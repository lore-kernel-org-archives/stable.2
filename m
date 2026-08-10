Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A03B9DAC
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405891; cv=none; b=jfWj20HbD1MQm+GWVwIr0mcZBVDcCZGSNfHc00VJ03hV7tyblWxeKPzqHAlkCSjBCwGlpvwHwbVqBXrUGzsmzp6nK/wlC0d6djTHg7lymWBPIwoaq9aGg/74+App7bWxqL63/Y7E+SJQFGAXKQl+t2ZTkTlK0O/Kyb+3ZrdMaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405891; c=relaxed/simple;
	bh=l7JcXWX1GADUkVw5mFjDLufA8RiWBrqgJznN460u0+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkNg7cJ2dH6Es/KiMNa4eUsi5TjMjmXIA8RLJFdSnxbkuW+5yHu/TtCC3TI5ueH4Q9dlKDEQMSUZXThDadxUXz7U+OhFN23CSUww9msk67CcJpdvZDIaCPLZe3ERiM4B0Tiz6kwF5X7JUTSviiDp7gbPQkTBk8Jvj8ULzKqoaJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G45cDsqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G45cDsqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160C01F00A3A;
	Mon, 10 Aug 2026 23:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405889;
	bh=raQTd9NDXH6JW+4iyLc6ockqT31jN6wHIAdG1rPA004=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G45cDsqsueQOtAAYSK4DUK/H7FRyQIw+i1uOc+00WQxQC6Y68vajI3rwIDW01kYrr
	 6qUCd/ICjy3Uvy6x6V1Gp6S9XXHBhd438Scg3neJg35OVobDCJV/T16a9WbUAh8H/N
	 uynx1wNrUlmqoavDosN5bfN/6C6TKz0fVRELouBKDIbeRjNM4B+ChnVxsdWrSQFxxN
	 a4P+hawl6/sXcfoOTdclr15+sKRCcL28/Z4YuG2eI8i4i3C7K7sOgcNoPGPQalHGq1
	 KZcBXOrwa5jvtGeTHoTZ4Me/4dstMCKkfxan8GR0qMf9iys0B83f5YteKK3vYswciT
	 3xOQ1fcP9S8yA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/7] Bluetooth: hci_conn, hci_sync: Use __counted_by() to avoid -Wfamnae warnings
Date: Mon, 10 Aug 2026 19:51:21 -0400
Message-ID: <20260810235124.3217231-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810235124.3217231-1-sashal@kernel.org>
References: <2026080500-repeater-crust-fca2@gregkh>
 <20260810235124.3217231-1-sashal@kernel.org>
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
 include/net/bluetooth/hci.h |  8 ++--
 net/bluetooth/hci_event.c   |  3 +-
 net/bluetooth/hci_sync.c    | 84 +++++++++++++++----------------------
 3 files changed, 40 insertions(+), 55 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0011d122458b9..ca30e76ee56e4 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1949,7 +1949,7 @@ struct hci_cp_le_set_ext_adv_data {
 	__u8  operation;
 	__u8  frag_pref;
 	__u8  length;
-	__u8  data[];
+	__u8  data[] __counted_by(length);
 } __packed;
 
 #define HCI_OP_LE_SET_EXT_SCAN_RSP_DATA		0x2038
@@ -1958,7 +1958,7 @@ struct hci_cp_le_set_ext_scan_rsp_data {
 	__u8  operation;
 	__u8  frag_pref;
 	__u8  length;
-	__u8  data[];
+	__u8  data[] __counted_by(length);
 } __packed;
 
 #define HCI_OP_LE_SET_EXT_ADV_ENABLE		0x2039
@@ -1983,7 +1983,7 @@ struct hci_cp_le_set_per_adv_data {
 	__u8  handle;
 	__u8  operation;
 	__u8  length;
-	__u8  data[];
+	__u8  data[] __counted_by(length);
 } __packed;
 
 #define HCI_OP_LE_SET_PER_ADV_ENABLE		0x2040
@@ -2084,7 +2084,7 @@ struct hci_cis {
 
 struct hci_cp_le_create_cis {
 	__u8    num_cis;
-	struct hci_cis cis[];
+	struct hci_cis cis[] __counted_by(num_cis);
 } __packed;
 
 #define HCI_OP_LE_REMOVE_CIG			0x2065
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 14caf945aadde..0140dde67c309 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4253,7 +4253,7 @@ static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
 	hci_dev_lock(hdev);
 
 	/* Remove connection if command failed */
-	for (i = 0; cp->num_cis; cp->num_cis--, i++) {
+	for (i = 0; i < cp->num_cis; i++) {
 		struct hci_conn *conn;
 		u16 handle;
 
@@ -4269,6 +4269,7 @@ static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
 			hci_conn_del(conn);
 		}
 	}
+	cp->num_cis = 0;
 
 	if (pending)
 		hci_le_create_cis_pending(hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6a5ec74eaf25a..36c1a1124a9c4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1297,31 +1297,27 @@ hci_set_ext_adv_params_sync(struct hci_dev *hdev, struct adv_info *adv,
 
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
 
-	len = eir_create_adv_data(hdev, instance, pdu.data);
+	len = eir_create_adv_data(hdev, instance, pdu->data);
 
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
@@ -1330,7 +1326,7 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	if (adv) {
 		adv->adv_data_changed = false;
 	} else {
-		memcpy(hdev->adv_data, pdu.data, len);
+		memcpy(hdev->adv_data, pdu->data, len);
 		hdev->adv_data_len = len;
 	}
 
@@ -1513,31 +1509,27 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 
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
@@ -1545,7 +1537,7 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 	if (adv) {
 		adv->scan_rsp_changed = false;
 	} else {
-		memcpy(hdev->scan_rsp_data, pdu.data, len);
+		memcpy(hdev->scan_rsp_data, pdu->data, len);
 		hdev->scan_rsp_data_len = len;
 	}
 
@@ -1689,14 +1681,10 @@ static int hci_set_per_adv_params_sync(struct hci_dev *hdev, u8 instance,
 
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
 
@@ -1704,14 +1692,14 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
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
 
@@ -6685,10 +6673,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 
 int hci_le_create_cis_sync(struct hci_dev *hdev)
 {
-	struct {
-		struct hci_cp_le_create_cis cp;
-		struct hci_cis cis[0x1f];
-	} cmd;
+	DEFINE_FLEX(struct hci_cp_le_create_cis, cmd, cis, num_cis, 0x1f);
+	size_t aux_num_cis = 0;
 	struct hci_conn *conn;
 	u16 timeout = 0;
 	u8 cig = BT_ISO_QOS_CIG_UNSET;
@@ -6716,8 +6702,6 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 	 * remains pending.
 	 */
 
-	memset(&cmd, 0, sizeof(cmd));
-
 	hci_dev_lock(hdev);
 
 	rcu_read_lock();
@@ -6754,7 +6738,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 		goto done;
 
 	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		struct hci_cis *cis = &cmd.cis[cmd.cp.num_cis];
+		struct hci_cis *cis = &cmd->cis[aux_num_cis];
 
 		if (hci_conn_check_create_cis(conn) ||
 		    conn->iso_qos.ucast.cig != cig)
@@ -6764,25 +6748,25 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 		cis->acl_handle = cpu_to_le16(conn->parent->handle);
 		cis->cis_handle = cpu_to_le16(conn->handle);
 		timeout = conn->conn_timeout;
-		cmd.cp.num_cis++;
+		aux_num_cis++;
 
-		if (cmd.cp.num_cis >= ARRAY_SIZE(cmd.cis))
+		if (aux_num_cis >= 0x1f)
 			break;
 	}
+	cmd->num_cis = aux_num_cis;
 
 done:
 	rcu_read_unlock();
 
 	hci_dev_unlock(hdev);
 
-	if (!cmd.cp.num_cis)
+	if (!aux_num_cis)
 		return 0;
 
 	/* Wait for HCI_LE_CIS_Established */
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CIS,
-					sizeof(cmd.cp) + sizeof(cmd.cis[0]) *
-					cmd.cp.num_cis, &cmd,
-					HCI_EVT_LE_CIS_ESTABLISHED,
+					struct_size(cmd, cis, cmd->num_cis),
+					cmd, HCI_EVT_LE_CIS_ESTABLISHED,
 					timeout, NULL);
 }
 
-- 
2.53.0

