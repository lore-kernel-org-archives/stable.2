Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC0380FC7
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447054; cv=none; b=TYbpHwvgULxJgj3yuEBXAeMHJvgqZH7TqCCjIFqZ8xdQEG5InRXXg7ANftx9GpghSRDhyOZlMTuxrrTjxSl2tzTh2DRaxVsw3bmaRKS9q03mGwEGx2YWWaJsyoIAw2k3q7+EQQLHRTvtdSdyh1Y6TFZROtUvllpjSZzXphtP3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447054; c=relaxed/simple;
	bh=HBBh6UpOBwMO8kPJ3yP2O67r6ln3ePpGtAx9NQL/4a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORY8Y43VPme2SRn/x8FuXzhyQs+/Rg5yySCZ6guEGLsM/HXLF8iuT3EPu/du6rR/oD/dmHQ3MCj4kNaBFq3ArtVU5FcCuk3yBrO3mAYyQMCs5VUU++nv0UqVbHocLd4F7e7pmtz7s0iHms1FHzsnz7XP1TmrgRsxMwKpKEFpFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZdSfRzL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZdSfRzL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950AC1F00A3D;
	Tue, 11 Aug 2026 11:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786447053;
	bh=iN9HWzSV3xaSKqtDw9sk9hjtucp90RZt8YyEFPPx7aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BZdSfRzL8tbPvdH9WTB9W88ekjgWiEawSy+oX5iBeOw1JN0AfhtLqZoTrJa+KcNUV
	 ydF/ojQapQ5hWPWbOTZlvIfXM6Fx+crFUEQoUr5HnjInjbCFvI2HzqcLxuTWIlvl2e
	 KsdkYHIaoGK30zS7HzYvlh4CaEFv6PU7F4NnJUfW+0itWUbJn4EjcyhdCGsUoxJl+/
	 84yL4e1xIb1OaaVRn7s4yUugzTXTlgjTEfz5Ubfv3uIt8+8EOrx4R4VMmG+XFTyTGv
	 5nrbsv9JfmQcS7lXOjh8WqDT1bNB4j0OEebPMmWfbDGaa0RF5a/fmwFxHyDKbZbMq5
	 KFygU+MhKGHBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1
Date: Tue, 11 Aug 2026 07:17:27 -0400
Message-ID: <20260811111728.2259626-3-sashal@kernel.org>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit e77f43d531af41e9ce299eab10dcae8fa5dbc293 ]

If hdev->le_num_of_adv_sets is set to 1 it means that only handle 0x00
can be used, but since the MGMT interface instances start from 1
(instance 0 means all instances in case of MGMT_OP_REMOVE_ADVERTISING)
the code needs to map the instance to handle otherwise users will not be
able to advertise as instance 1 would attempt to use handle 0x01.

Fixes: 1d0fac2c38ed ("Bluetooth: Use controller sets when available")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: cdc36db204ff ("Bluetooth: hci_sync: Fix advertising data UAFs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  9 +++++++++
 net/bluetooth/hci_sync.c         | 17 ++++++++---------
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e67b1e5e0d2c8..86a94cc6081fc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -243,6 +243,7 @@ struct adv_info {
 	bool	periodic;
 	__u8	mesh;
 	__u8	instance;
+	__u8	handle;
 	__u32	flags;
 	__u16	timeout;
 	__u16	remaining_time;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6a69b85c1c7fc..7df7e75a83038 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1717,6 +1717,15 @@ struct adv_info *hci_add_adv_instance(struct hci_dev *hdev, u8 instance,
 
 		adv->pending = true;
 		adv->instance = instance;
+
+		/* If controller support only one set and the instance is set to
+		 * 1 then there is no option other than using handle 0x00.
+		 */
+		if (hdev->le_num_of_adv_sets == 1 && instance == 1)
+			adv->handle = 0x00;
+		else
+			adv->handle = instance;
+
 		list_add(&adv->list, &hdev->adv_instances);
 		hdev->adv_instance_cnt++;
 	}
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b8ac425e0f7c0..16fe8b6eff2f3 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1136,11 +1136,10 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	struct hci_cp_ext_adv_set *set;
 	u8 data[sizeof(*cp) + sizeof(*set) * 1];
 	u8 size;
+	struct adv_info *adv = NULL;
 
 	/* If request specifies an instance that doesn't exist, fail */
 	if (instance > 0) {
-		struct adv_info *adv;
-
 		adv = hci_find_adv_instance(hdev, instance);
 		if (!adv)
 			return -EINVAL;
@@ -1159,7 +1158,7 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	cp->num_of_sets = !!instance;
 	cp->enable = 0x00;
 
-	set->handle = instance;
+	set->handle = adv ? adv->handle : instance;
 
 	size = sizeof(*cp) + sizeof(*set) * cp->num_of_sets;
 
@@ -1254,7 +1253,7 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 				  HCI_MAX_EXT_AD_LENGTH);
 
 	pdu->length = len;
-	pdu->handle = instance;
+	pdu->handle = adv ? adv->handle : instance;
 	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
@@ -1465,7 +1464,7 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 
 	len = eir_create_scan_rsp(hdev, instance, pdu->data);
 
-	pdu->handle = instance;
+	pdu->handle = adv ? adv->handle : instance;
 	pdu->length = len;
 	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
@@ -1547,7 +1546,7 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 
 	memset(set, 0, sizeof(*set));
 
-	set->handle = instance;
+	set->handle = adv ? adv->handle : instance;
 
 	/* Set duration per instance since controller is responsible for
 	 * scheduling it.
@@ -1624,10 +1623,10 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	DEFINE_FLEX(struct hci_cp_le_set_per_adv_data, pdu, data, length,
 		    HCI_MAX_PER_AD_LENGTH);
 	u8 len;
+	struct adv_info *adv = NULL;
 
 	if (instance) {
-		struct adv_info *adv = hci_find_adv_instance(hdev, instance);
-
+		adv = hci_find_adv_instance(hdev, instance);
 		if (!adv || !adv->periodic)
 			return 0;
 	}
@@ -1635,7 +1634,7 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	len = eir_create_per_adv_data(hdev, instance, pdu->data);
 
 	pdu->length = len;
-	pdu->handle = instance;
+	pdu->handle = adv ? adv->handle : instance;
 	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PER_ADV_DATA,
-- 
2.53.0

