Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D0F3587A2
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447054; cv=none; b=cDa74rJwrQfU+zuVsIdF3hse1SEaXGfOeRh7L8zmkfwrM8emz01lJzEMCKLPYcvlojkARlderMbBgbUGuOmTe1ev6Ym4+HTKAFpG7R7G7A2g2XRdzNhA3Dcvi/EZbfK0r0PjAvhhlT18ArIIvFN2w+zNBuam3zKe64uDjkdVsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447054; c=relaxed/simple;
	bh=B3wyMTzhBkzcvJYrQUOu+CObA6DY+tJu4llThj1mN6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSO1q+aTZOYrNKkHRmSPCEt2zeUBNx4geYUsWOkW+Zag8/YGJd7fPB04OrMdsHYutH/5GT5XSpTafXo2GuzlJt68QMqKnkrlxLzIhUSCVobRhn9Zn6F7b0hYfyW0bE7Daai0j39TpZO49zqS4UMfidqyw+gH6h0tb018Xb1gg8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqS3I5Yl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqS3I5Yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC1B1F00A3E;
	Tue, 11 Aug 2026 11:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786447052;
	bh=MflX/8B82QE6f9NkCfTlKFe5Hjqv48QNj68I922vMu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dqS3I5YlaeHBo75e9651hOD5Kivm9gPcKSvrFGRhpeoNgcmU7bC00eArt45xvPaYa
	 /oa9wfdqBx/lBsARJb8h5+lDTKhENLoj6svg/cY6UwTGH5N9K5DtbqAc2DoQ5ru4kz
	 Tg0RQvyhlVcnZr4Pfam+f/le0o5IETRIf8dj+SMYEiPg4IqZwqB2t4x6q7XCyA3LaA
	 wc5LIXZQSnkc8o9m7LwBDBMBUn+b3fli2yrcUTysBKnFyLXZM0N8Tdp8dv8r5Q1zSa
	 cX718Zr0ILpRe8lRWo2dm7UBa6GsQO3ur2BGJ2LdHP1QxwbllC3qLsYEgNsvs+R0Ma
	 bs9gXn1XpfcbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] Bluetooth: hci_conn, hci_sync: Use __counted_by() to avoid -Wfamnae warnings
Date: Tue, 11 Aug 2026 07:17:26 -0400
Message-ID: <20260811111728.2259626-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811111728.2259626-1-sashal@kernel.org>
References: <2026080501-hassle-thinning-e82d@gregkh>
 <20260811111728.2259626-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit c4585edf708edb5277a3cc4b8581ccb833f3307d ]

Prepare for the coming implementation by GCC and Clang of the
__counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time
via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
(for strcpy/memcpy-family functions).

Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
getting ready to enable it globally.

So, use the `DEFINE_FLEX()` helper for multiple on-stack definitions
of a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

Notice that, due to the use of `__counted_by()` in `struct
hci_cp_le_create_cis`, the for loop in function `hci_cs_le_create_cis()`
had to be modified. Once the index `i`, through which `cp->cis[i]` is
accessed, falls in the interval [0, cp->num_cis), `cp->num_cis` cannot
be decremented all the way down to zero while accessing `cp->cis[]`:

net/bluetooth/hci_event.c:4310:
4310    for (i = 0; cp->num_cis; cp->num_cis--, i++) {
                ...
4314            handle = __le16_to_cpu(cp->cis[i].cis_handle);

otherwise, only half (one iteration before `cp->num_cis == i`) or half
plus one (one iteration before `cp->num_cis < i`) of the items in the
array will be accessed before running into an out-of-bounds issue. So,
in order to avoid this, set `cp->num_cis` to zero just after the for
loop.

Also, make use of `aux_num_cis` variable to update `cmd->num_cis` after
a `list_for_each_entry_rcu()` loop.

With these changes, fix the following warnings:
net/bluetooth/hci_sync.c:1239:56: warning: structure containing a flexible
array member is not at the end of another structure
[-Wflex-array-member-not-at-end]
net/bluetooth/hci_sync.c:1415:51: warning: structure containing a flexible
array member is not at the end of another structure
[-Wflex-array-member-not-at-end]
net/bluetooth/hci_sync.c:1731:51: warning: structure containing a flexible
array member is not at the end of another structure
[-Wflex-array-member-not-at-end]
net/bluetooth/hci_sync.c:6497:45: warning: structure containing a flexible
array member is not at the end of another structure
[-Wflex-array-member-not-at-end]

Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: cdc36db204ff ("Bluetooth: hci_sync: Fix advertising data UAFs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c |  3 +-
 net/bluetooth/hci_sync.c  | 62 ++++++++++++++++-----------------------
 2 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f5e3709816c9f..833b00921d149 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4272,7 +4272,7 @@ static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
 	hci_dev_lock(hdev);
 
 	/* Remove connection if command failed */
-	for (i = 0; cp->num_cis; cp->num_cis--, i++) {
+	for (i = 0; i < cp->num_cis; i++) {
 		struct hci_conn *conn;
 		u16 handle;
 
@@ -4285,6 +4285,7 @@ static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
 			hci_conn_del(conn);
 		}
 	}
+	cp->num_cis = 0;
 
 	hci_dev_unlock(hdev);
 }
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 81c0589554a82..b8ac425e0f7c0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1238,32 +1238,28 @@ hci_set_ext_adv_params_sync(struct hci_dev *hdev, struct adv_info *adv,
 
 static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 {
-	struct {
-		struct hci_cp_le_set_ext_adv_data cp;
-		u8 data[HCI_MAX_EXT_AD_LENGTH];
-	} pdu;
+	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
+		    HCI_MAX_EXT_AD_LENGTH);
 	u8 len;
 	struct adv_info *adv = NULL;
 	int err;
 
-	memset(&pdu, 0, sizeof(pdu));
-
 	if (instance) {
 		adv = hci_find_adv_instance(hdev, instance);
 		if (!adv || !adv->adv_data_changed)
 			return 0;
 	}
 
-	len = eir_create_adv_data(hdev, instance, pdu.data,
+	len = eir_create_adv_data(hdev, instance, pdu->data,
 				  HCI_MAX_EXT_AD_LENGTH);
 
-	pdu.cp.length = len;
-	pdu.cp.handle = instance;
-	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
-	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+	pdu->length = len;
+	pdu->handle = instance;
+	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
 	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
-				    sizeof(pdu.cp) + len, &pdu.cp,
+				    struct_size(pdu, data, len), pdu,
 				    HCI_CMD_TIMEOUT);
 	if (err)
 		return err;
@@ -1272,7 +1268,7 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	if (adv) {
 		adv->adv_data_changed = false;
 	} else {
-		memcpy(hdev->adv_data, pdu.data, len);
+		memcpy(hdev->adv_data, pdu->data, len);
 		hdev->adv_data_len = len;
 	}
 
@@ -1455,31 +1451,27 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 
 static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 {
-	struct {
-		struct hci_cp_le_set_ext_scan_rsp_data cp;
-		u8 data[HCI_MAX_EXT_AD_LENGTH];
-	} pdu;
+	DEFINE_FLEX(struct hci_cp_le_set_ext_scan_rsp_data, pdu, data, length,
+		    HCI_MAX_EXT_AD_LENGTH);
 	u8 len;
 	struct adv_info *adv = NULL;
 	int err;
 
-	memset(&pdu, 0, sizeof(pdu));
-
 	if (instance) {
 		adv = hci_find_adv_instance(hdev, instance);
 		if (!adv || !adv->scan_rsp_changed)
 			return 0;
 	}
 
-	len = eir_create_scan_rsp(hdev, instance, pdu.data);
+	len = eir_create_scan_rsp(hdev, instance, pdu->data);
 
-	pdu.cp.handle = instance;
-	pdu.cp.length = len;
-	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
-	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+	pdu->handle = instance;
+	pdu->length = len;
+	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
 	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_RSP_DATA,
-				    sizeof(pdu.cp) + len, &pdu.cp,
+				    struct_size(pdu, data, len), pdu,
 				    HCI_CMD_TIMEOUT);
 	if (err)
 		return err;
@@ -1487,7 +1479,7 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 	if (adv) {
 		adv->scan_rsp_changed = false;
 	} else {
-		memcpy(hdev->scan_rsp_data, pdu.data, len);
+		memcpy(hdev->scan_rsp_data, pdu->data, len);
 		hdev->scan_rsp_data_len = len;
 	}
 
@@ -1629,14 +1621,10 @@ static int hci_set_per_adv_params_sync(struct hci_dev *hdev, u8 instance,
 
 static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 {
-	struct {
-		struct hci_cp_le_set_per_adv_data cp;
-		u8 data[HCI_MAX_PER_AD_LENGTH];
-	} pdu;
+	DEFINE_FLEX(struct hci_cp_le_set_per_adv_data, pdu, data, length,
+		    HCI_MAX_PER_AD_LENGTH);
 	u8 len;
 
-	memset(&pdu, 0, sizeof(pdu));
-
 	if (instance) {
 		struct adv_info *adv = hci_find_adv_instance(hdev, instance);
 
@@ -1644,14 +1632,14 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 			return 0;
 	}
 
-	len = eir_create_per_adv_data(hdev, instance, pdu.data);
+	len = eir_create_per_adv_data(hdev, instance, pdu->data);
 
-	pdu.cp.length = len;
-	pdu.cp.handle = instance;
-	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu->length = len;
+	pdu->handle = instance;
+	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PER_ADV_DATA,
-				     sizeof(pdu.cp) + len, &pdu,
+				     struct_size(pdu, data, len), pdu,
 				     HCI_CMD_TIMEOUT);
 }
 
-- 
2.53.0

