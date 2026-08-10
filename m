Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8C23BB100
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405891; cv=none; b=r658vzykTdVws7aHgSMkRMP0Tz7oCpltzMQ34i9OAYLovkenC0fIkoGoF03RorVnqa3+/31BJ03LroXsU59TqE50PoHOSXKivPpb2Utr1eEUFnljiLt6qEjWt3RNGwogOo0Z8UL+/Wqq+ybqunkwhs7aaEHT6LbvH1/u9Nc6bPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405891; c=relaxed/simple;
	bh=Q3ONf1CsjndgOlVpJkzPRR6JIfqZC+C8gBU0y9Lqa20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aX0wj0/VZyKQuf5JvwshCJTOrrKaJw/wim3ACuAKN6fZsXy01aZXixCEa0tvkkN5yknrWosZSFGtm5Si60C9GYez7+4QZ1bCdU3RGy/ySBAUuc+3ywV+yBiP/Gw0ErwAXUIJKNZsHed889dXYzTRqhAUJ4G6IgQQ60cWxrUflwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr8hx9mY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr8hx9mY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D826B1F00A3E;
	Mon, 10 Aug 2026 23:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405890;
	bh=UhlpN2r2n+FxLYV/6nW5HDBVm3qr+ZysjPpC+iUv0NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kr8hx9mYXTbJdrXjc/p7hpfUGScLhuw+uyQdOfVWzQH6x9RN5QjRi8HCDGoQmfl75
	 idEkZwLk4C8mZfTtS6I2NxNd4P3Kl05jnGfYWTnJkuchzrwCsyJJsBISjVFt721C/W
	 20ke3sp+fNPkycqMLAPt9WZCjyEgmwx9uH727WgJWJBqanfq42Sbd74ade3pHvK9M6
	 T3OPHzkNvAVIHtHHe9hBeRQwui/zl/ToDfoiuPzeA0o39kwLkXSBuZOr86iVby0WY5
	 NPTMOfK93C0ZojwJhfsud8AJXZ8xniOekBz9htEJzcPoEI4CK+Jp5rkGX1dYug7bMJ
	 MSBhk4275WSJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/7] Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1
Date: Mon, 10 Aug 2026 19:51:22 -0400
Message-ID: <20260810235124.3217231-5-sashal@kernel.org>
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
 net/bluetooth/hci_sync.c         | 19 +++++++++----------
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bc18037e25ac1..e749977638e82 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -245,6 +245,7 @@ struct adv_info {
 	bool	periodic_enabled;
 	__u8	mesh;
 	__u8	instance;
+	__u8	handle;
 	__u32	flags;
 	__u16	timeout;
 	__u16	remaining_time;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d9bb05f81f50e..7193903943b15 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1706,6 +1706,15 @@ struct adv_info *hci_add_adv_instance(struct hci_dev *hdev, u8 instance,
 
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
index 36c1a1124a9c4..57756cd615acf 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1195,11 +1195,10 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1218,7 +1217,7 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	cp->num_of_sets = !!instance;
 	cp->enable = 0x00;
 
-	set->handle = instance;
+	set->handle = adv ? adv->handle : instance;
 
 	size = sizeof(*cp) + sizeof(*set) * cp->num_of_sets;
 
@@ -1312,7 +1311,7 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	len = eir_create_adv_data(hdev, instance, pdu->data);
 
 	pdu->length = len;
-	pdu->handle = instance;
+	pdu->handle = adv ? adv->handle : instance;
 	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
@@ -1465,7 +1464,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 
 	cp.own_addr_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
-	cp.handle = instance;
+	cp.handle = adv ? adv->handle : instance;
 
 	if (flags & MGMT_ADV_FLAG_SEC_2M) {
 		cp.primary_phy = HCI_ADV_PHY_1M;
@@ -1523,7 +1522,7 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 
 	len = eir_create_scan_rsp(hdev, instance, pdu->data);
 
-	pdu->handle = instance;
+	pdu->handle = adv ? adv->handle : instance;
 	pdu->length = len;
 	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
@@ -1605,7 +1604,7 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 
 	memset(set, 0, sizeof(*set));
 
-	set->handle = instance;
+	set->handle = adv ? adv->handle : instance;
 
 	/* Set duration per instance since controller is responsible for
 	 * scheduling it.
@@ -1684,10 +1683,10 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1695,7 +1694,7 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	len = eir_create_per_adv_data(hdev, instance, pdu->data);
 
 	pdu->length = len;
-	pdu->handle = instance;
+	pdu->handle = adv ? adv->handle : instance;
 	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PER_ADV_DATA,
-- 
2.53.0

