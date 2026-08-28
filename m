Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C92E11C7
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787884064; cv=none; b=O5v+8w4lTYEUQ5/eGALSQuspUJ6y61H1VvoNEmuRdkVBF2MSW9CMrZyMUlhllDCiSX+lSjzmPW/1J1eaxbYuhBBpstRkZKsUchJfgeEDjMHj3IPJqy95fLvR4Eq3J0CYFeZdCabz9+4xsJ+BvLGw+YX+5q/hCdid6ffwXkiBR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787884064; c=relaxed/simple;
	bh=UVXtb7W4gdgH5L34xzQ46vF6m0RsPFCO+haqaMmFy64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wie/RWaYnDM//2E1JKemxgoDmRD4JnkQ5xmASpO6JqcmMOEfItEcQNfgz/Z403jw3XuXIbtz4WJDN/fHNEsQGNx8Jywhze7HGg504dqsfjLaf9bsz+qpbAehAbInPDMF74qGysthwjdoPnWvp8+XJqA+L7byQBV9FU7PT7HQtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJYIPgeL; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJYIPgeL"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92f0b5ed131so34845985a.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787884061; x=1788488861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IhhKvSdgsdH/5dINDgUoRDGzrDZV62MoEBnDb5HyM5o=;
        b=sJYIPgeLTC0FRHmZRoJ04YgLkS47OFl7DA7i8Mbl/9FJAJpbqUmS6K9mn3mk6y6KCm
         hxdicpk1H7LvwT7XlvaGh/I7Vj1Zv/3jSNGiSEGe30ISrTeMtahumpsW00MDXsypo2bV
         LCvz6wjYRyDw85ypgIfe+u9znRswu0q0NVISQNhsKrvikIG7W8MmFwTo4eZSBjIQ5RxW
         iSv4ex4ib2FIDBdg9/pm19pdHG9BhNka7xK5rO2pvWll/M0erY8TSogwFt7IQrTyXAVG
         qD4+iL03aUDwG68GAQ8mUxpzDi9dqotWqvW16Saqz0FR8oPbsNUOG5fvorMycQGcSWY8
         D88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787884061; x=1788488861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IhhKvSdgsdH/5dINDgUoRDGzrDZV62MoEBnDb5HyM5o=;
        b=BkDo7l1ZswA4VKuy4rqKxlpOStQFeAotJW1tm29INUtOaCnAspCQWBaV6gJhLpFyDg
         +2bJS/2/4osKoDW0s87SizmyVm0R80QOXt8eOK/d4HtHOxDt8ciZRTeSYbLeNrxeM9PC
         ZaKv6T96eTpxaJh9t/FwrPPCMQTUqN7HoEyXEnwJhsG/SBfRoXdB8wfnLkRvNq19TlTD
         sIn8wtKPoO6sLxdoMHPfVE3Sv0hMiP1rDUqpwe+rySJy8/Jmzzgjq/o7jx4EsIefjqnZ
         iafB8WO2/z1Pa1s7QUqQW131UQk0mPhHNw8EP8w6Q05rZXnduCZJ7xPfdWJqGx35wJvb
         LpIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpdyrb8sY2eoBcrWzsfpwA6jBWMaKLJsCqEIZKNldtv6ojJjSrG4o9CKuGneBsX7Okl8oJlnEA=@vger.kernel.org
X-Gm-Message-State: AFuF++nJlj6NK5nFPo3kBlwSUXvm8ZXnXcvTdrUYIX5Lv1yg8Qpiu1X0
	vN3UkKZ8ESIb67TWhortKkNvrpYU4tiiaqB4dPwjmCoKn7QTarFy3Prs/kpjbUjV
X-Gm-Gg: AR+sD12uJ+h31A7AC1XWCi2NDjA3XDkq1sMiSqSWT5UFm0ISOYSQS7KoZetjDCCDusE
	8qpqMNi2LyzN+od3THMJ2GMKcqvACDDKUWckqD+iEx33az43fhZm4gcbT1NS4GpeM+k3JGmHA+e
	E7zjzga60Ja7wmARhbM9lV2gdhIAIm9+wOW+Crw1NQmYSuQRrCgv65nX62ECvDwkZTnFEuhYKAb
	XWIsuQhpCSBSCjhEJ6UHK4gfEHyV04DxPxjEauI7dXeGzRmF84MOcyYdoNmAYAou2gRtGtTAHdn
	NYukv218Ypdy6jYxtiirkGyfPCsw1nneihBlbqH1x88YT+0Uk9s574yIygQwBF7t6MUgW5tvWTU
	6L7EdAXsqLDt/8U+AJh7w0UtAKyAU0+HFnwDBxkRHiItiZsO4rsvFotlYe1pmR9QpBLEa/K8h+9
	uG3bQZfsK2rwZ8ZdQOq0QLCgHVvotoezE9nup9F24eQ4XKXDKTSoYWsgUhf0Fm7gFJriecJudTh
	X7nY/DKSaH/Zg9ygrX0Yws11QRhKsUxIFhchBqnv5A=
X-Received: by 2002:a17:903:1ac7:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2d74dc7a37bmr67515835ad.8.1787884031023;
        Thu, 27 Aug 2026 19:27:11 -0700 (PDT)
Received: from hnkz-ubuntu-vm1.mshome.net (flh4-125-195-69-140.tky.mesh.ad.jp. [125.195.69.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759869cf0sm961525ad.54.2026.08.27.19.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 19:27:09 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: johan.hedberg@intel.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_core: Fix IRK lookup lifetime races
Date: Fri, 28 Aug 2026 11:25:49 +0900
Message-ID: <20260828022549.1721170-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IRK lookup helpers traverse the identity resolving key list under
RCU, but return a raw pointer after leaving the read-side critical
section. A concurrent management unpair or key reload can unlink and
free that entry while SMP key distribution still updates its value and
RPA through hci_add_irk().

RCU also does not serialize list mutations. SMP cleanup and key
distribution can update the IRK list without the hdev mutex while
management paths update it with that mutex held, allowing concurrent
list_add_rcu() and list_del_rcu() operations on the same list.

Give each IRK a list-owned reference and return caller-owned references
from lookup and add helpers. Keep the SMP context reference until pairing
teardown, and drop the list reference only once when an entry is
unlinked. Add a dedicated spinlock for IRK list and payload updates, and
copy payload snapshots under that lock so readers do not race updates.
Initialize new entries completely before publishing them. Unlink an IRK
added during unpair before dropping the SMP context reference.

An exact KASAN interleaving that removes and drains the RCU entry after
lookup but before hci_add_irk() resumes now completes without a
use-after-free. A forced late-add/unpair interleaving leaves no linked IRK
behind. A KASAN and lockdep enabled VHCI pairing/unpair test also
completes successfully.

Fixes: a7ec73386ce2 ("Bluetooth: Fix removing any IRKs when unpairing devices")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
---
 include/net/bluetooth/hci_core.h |  19 ++-
 net/bluetooth/hci_conn.c         |  34 ++++--
 net/bluetooth/hci_core.c         | 202 +++++++++++++++++++++++++------
 net/bluetooth/hci_debugfs.c      |   6 +-
 net/bluetooth/hci_event.c        |  16 ++-
 net/bluetooth/hci_sync.c         |  16 ++-
 net/bluetooth/iso.c              |  18 ++-
 net/bluetooth/mgmt.c             |  12 +-
 net/bluetooth/smp.c              |  20 ++-
 9 files changed, 274 insertions(+), 69 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4105c446ca98..75f3f26d9e31 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -24,6 +24,7 @@
 #define __HCI_CORE_H
 
 #include <linux/idr.h>
+#include <linux/kref.h>
 #include <linux/leds.h>
 #include <linux/rculist.h>
 #include <linux/spinlock.h>
@@ -211,6 +212,15 @@ struct smp_ltk {
 struct smp_irk {
 	struct list_head list;
 	struct rcu_head rcu;
+	struct kref ref;
+	unsigned long flags;
+	bdaddr_t rpa;
+	bdaddr_t bdaddr;
+	u8 addr_type;
+	u8 val[16];
+};
+
+struct smp_irk_data {
 	bdaddr_t rpa;
 	bdaddr_t bdaddr;
 	u8 addr_type;
@@ -561,6 +571,7 @@ struct hci_dev {
 	struct list_head	uuids;
 	struct list_head	link_keys;
 	struct list_head	long_term_keys;
+	spinlock_t		irk_lock; /* protects IRK list and data */
 	struct list_head	identity_resolving_keys;
 	struct list_head	remote_oob_data;
 	struct list_head	le_accept_list;
@@ -1885,11 +1896,16 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type);
 void hci_smp_ltks_clear(struct hci_dev *hdev);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
+/* Returned IRKs hold a reference that must be released with hci_irk_put(). */
 struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa);
 struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 addr_type);
 struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 addr_type, u8 val[16], bdaddr_t *rpa);
+void hci_irk_read(struct hci_dev *hdev, struct smp_irk *irk,
+		  struct smp_irk_data *data);
+void hci_irk_put(struct smp_irk *irk);
+void hci_irk_unlink(struct hci_dev *hdev, struct smp_irk *irk);
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type);
 bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16]);
 void hci_blocked_keys_clear(struct hci_dev *hdev);
@@ -2505,7 +2521,8 @@ void mgmt_resuming(struct hci_dev *hdev, u8 reason, bdaddr_t *bdaddr,
 		   u8 addr_type);
 bool mgmt_powering_down(struct hci_dev *hdev);
 void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent);
-void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent);
+void mgmt_new_irk(struct hci_dev *hdev, const struct smp_irk_data *irk,
+		  bool persistent);
 void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 		   bool persistent);
 void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8de98af2fb58..5e19fc6ef930 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -70,6 +70,8 @@ void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
 	struct hci_conn_params *params;
 	struct hci_dev *hdev = conn->hdev;
 	struct smp_irk *irk;
+	struct smp_irk_data irk_data;
+	bdaddr_t identity_addr;
 	bdaddr_t *bdaddr;
 	u8 bdaddr_type;
 
@@ -79,8 +81,11 @@ void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
 	/* Check if we need to convert to identity address */
 	irk = hci_get_irk(hdev, bdaddr, bdaddr_type);
 	if (irk) {
-		bdaddr = &irk->bdaddr;
-		bdaddr_type = irk->addr_type;
+		hci_irk_read(hdev, irk, &irk_data);
+		bacpy(&identity_addr, &irk_data.bdaddr);
+		bdaddr_type = irk_data.addr_type;
+		hci_irk_put(irk);
+		bdaddr = &identity_addr;
 	}
 
 	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, bdaddr,
@@ -1004,6 +1009,7 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 {
 	struct hci_conn *conn;
 	struct smp_irk *irk = NULL;
+	struct smp_irk_data irk_data;
 
 	switch (type) {
 	case ACL_LINK:
@@ -1037,16 +1043,21 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 	bt_dev_dbg(hdev, "dst %pMR handle 0x%4.4x", dst, handle);
 
 	conn = kzalloc_obj(*conn);
-	if (!conn)
+	if (!conn) {
+		if (irk)
+			hci_irk_put(irk);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	/* If and IRK exists use its identity address */
 	if (!irk) {
 		bacpy(&conn->dst, dst);
 		conn->dst_type = dst_type;
 	} else {
-		bacpy(&conn->dst, &irk->bdaddr);
-		conn->dst_type = irk->addr_type;
+		hci_irk_read(hdev, irk, &irk_data);
+		bacpy(&conn->dst, &irk_data.bdaddr);
+		conn->dst_type = irk_data.addr_type;
+		hci_irk_put(irk);
 	}
 
 	bacpy(&conn->src, &hdev->bdaddr);
@@ -1458,6 +1469,8 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *conn;
 	struct smp_irk *irk;
+	struct smp_irk_data irk_data;
+	bdaddr_t rpa;
 	int err;
 
 	/* Let's make sure that le is enabled.*/
@@ -1498,9 +1511,14 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		 * from the connect request.
 		 */
 		irk = hci_find_irk_by_addr(hdev, dst, dst_type);
-		if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
-			dst = &irk->rpa;
-			dst_type = ADDR_LE_DEV_RANDOM;
+		if (irk) {
+			hci_irk_read(hdev, irk, &irk_data);
+			if (bacmp(&irk_data.rpa, BDADDR_ANY)) {
+				bacpy(&rpa, &irk_data.rpa);
+				dst = &rpa;
+				dst_type = ADDR_LE_DEV_RANDOM;
+			}
+			hci_irk_put(irk);
 		}
 	}
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 35a1be57e386..4503e2afbb77 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1031,13 +1031,36 @@ void hci_smp_ltks_clear(struct hci_dev *hdev)
 	}
 }
 
+enum {
+	SMP_IRK_LINKED,
+};
+
+static bool __hci_irk_unlink(struct smp_irk *irk)
+{
+	if (!test_and_clear_bit(SMP_IRK_LINKED, &irk->flags))
+		return false;
+
+	list_del_rcu(&irk->list);
+	return true;
+}
+
 void hci_smp_irks_clear(struct hci_dev *hdev)
 {
-	struct smp_irk *k, *tmp;
+	struct smp_irk *k;
 
-	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
-		list_del_rcu(&k->list);
-		kfree_rcu(k, rcu);
+	for (;;) {
+		spin_lock_bh(&hdev->irk_lock);
+		if (list_empty(&hdev->identity_resolving_keys)) {
+			spin_unlock_bh(&hdev->irk_lock);
+			break;
+		}
+
+		k = list_first_entry(&hdev->identity_resolving_keys,
+				     struct smp_irk, list);
+		__hci_irk_unlink(k);
+		spin_unlock_bh(&hdev->irk_lock);
+
+		hci_irk_put(k);
 	}
 }
 
@@ -1171,37 +1194,73 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return NULL;
 }
 
+void hci_irk_read(struct hci_dev *hdev, struct smp_irk *irk,
+		  struct smp_irk_data *data)
+{
+	spin_lock_bh(&hdev->irk_lock);
+	bacpy(&data->rpa, &irk->rpa);
+	bacpy(&data->bdaddr, &irk->bdaddr);
+	data->addr_type = irk->addr_type;
+	memcpy(data->val, irk->val, sizeof(data->val));
+	spin_unlock_bh(&hdev->irk_lock);
+}
+
+static bool hci_irk_get(struct smp_irk *irk)
+{
+	if (!test_bit(SMP_IRK_LINKED, &irk->flags))
+		return false;
+
+	if (!kref_get_unless_zero(&irk->ref))
+		return false;
+
+	if (test_bit(SMP_IRK_LINKED, &irk->flags))
+		return true;
+
+	hci_irk_put(irk);
+	return false;
+}
+
 struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa)
 {
 	struct smp_irk *irk_to_return = NULL;
+	struct smp_irk_data data;
 	struct smp_irk *irk;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
-		if (!bacmp(&irk->rpa, rpa)) {
+		hci_irk_read(hdev, irk, &data);
+		if (!bacmp(&data.rpa, rpa) && hci_irk_get(irk)) {
 			irk_to_return = irk;
 			goto done;
 		}
 	}
 
 	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
-		if (smp_irk_matches(hdev, irk->val, rpa)) {
-			bacpy(&irk->rpa, rpa);
+		hci_irk_read(hdev, irk, &data);
+		if (smp_irk_matches(hdev, data.val, rpa) && hci_irk_get(irk)) {
+			spin_lock_bh(&hdev->irk_lock);
+			if (test_bit(SMP_IRK_LINKED, &irk->flags))
+				bacpy(&irk->rpa, rpa);
+			spin_unlock_bh(&hdev->irk_lock);
 			irk_to_return = irk;
 			goto done;
 		}
 	}
 
 done:
+	rcu_read_unlock();
+
+	if (irk_to_return)
+		hci_irk_read(hdev, irk_to_return, &data);
+
 	if (irk_to_return && hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_IRK,
-						irk_to_return->val)) {
+						data.val)) {
 		bt_dev_warn_ratelimited(hdev, "Identity key blocked for %pMR",
-					&irk_to_return->bdaddr);
+					&data.bdaddr);
+		hci_irk_put(irk_to_return);
 		irk_to_return = NULL;
 	}
 
-	rcu_read_unlock();
-
 	return irk_to_return;
 }
 
@@ -1209,6 +1268,7 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 addr_type)
 {
 	struct smp_irk *irk_to_return = NULL;
+	struct smp_irk_data data;
 	struct smp_irk *irk;
 
 	/* Identity Address must be public or static random */
@@ -1217,25 +1277,53 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
-		if (addr_type == irk->addr_type &&
-		    bacmp(bdaddr, &irk->bdaddr) == 0) {
+		hci_irk_read(hdev, irk, &data);
+		if (addr_type == data.addr_type &&
+		    bacmp(bdaddr, &data.bdaddr) == 0 && hci_irk_get(irk)) {
 			irk_to_return = irk;
 			break;
 		}
 	}
+	rcu_read_unlock();
+
+	if (irk_to_return)
+		hci_irk_read(hdev, irk_to_return, &data);
 
 	if (irk_to_return && hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_IRK,
-						irk_to_return->val)) {
+						data.val)) {
 		bt_dev_warn_ratelimited(hdev, "Identity key blocked for %pMR",
-					&irk_to_return->bdaddr);
+					&data.bdaddr);
+		hci_irk_put(irk_to_return);
 		irk_to_return = NULL;
 	}
 
-	rcu_read_unlock();
-
 	return irk_to_return;
 }
 
+static void hci_irk_release(struct kref *ref)
+{
+	struct smp_irk *irk = container_of(ref, struct smp_irk, ref);
+
+	kfree_rcu(irk, rcu);
+}
+
+void hci_irk_put(struct smp_irk *irk)
+{
+	kref_put(&irk->ref, hci_irk_release);
+}
+
+void hci_irk_unlink(struct hci_dev *hdev, struct smp_irk *irk)
+{
+	bool unlinked;
+
+	spin_lock_bh(&hdev->irk_lock);
+	unlinked = __hci_irk_unlink(irk);
+	spin_unlock_bh(&hdev->irk_lock);
+
+	if (unlinked)
+		hci_irk_put(irk);
+}
+
 struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 				  bdaddr_t *bdaddr, u8 *val, u8 type,
 				  u8 pin_len, bool *persistent)
@@ -1315,24 +1403,47 @@ struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 addr_type, u8 val[16], bdaddr_t *rpa)
 {
-	struct smp_irk *irk;
+	struct smp_irk *irk, *new_irk;
 
 	irk = hci_find_irk_by_addr(hdev, bdaddr, addr_type);
-	if (!irk) {
-		irk = kzalloc_obj(*irk);
-		if (!irk)
-			return NULL;
+	if (irk) {
+		spin_lock_bh(&hdev->irk_lock);
+		memcpy(irk->val, val, sizeof(irk->val));
+		bacpy(&irk->rpa, rpa);
+		spin_unlock_bh(&hdev->irk_lock);
+		return irk;
+	}
+
+	new_irk = kzalloc_obj(*new_irk);
+	if (!new_irk)
+		return NULL;
 
-		bacpy(&irk->bdaddr, bdaddr);
-		irk->addr_type = addr_type;
+	bacpy(&new_irk->bdaddr, bdaddr);
+	new_irk->addr_type = addr_type;
+	memcpy(new_irk->val, val, sizeof(new_irk->val));
+	bacpy(&new_irk->rpa, rpa);
 
-		list_add_rcu(&irk->list, &hdev->identity_resolving_keys);
+	spin_lock_bh(&hdev->irk_lock);
+	list_for_each_entry(irk, &hdev->identity_resolving_keys, list) {
+		if (addr_type != irk->addr_type ||
+		    bacmp(bdaddr, &irk->bdaddr))
+			continue;
+
+		kref_get(&irk->ref);
+		memcpy(irk->val, val, sizeof(irk->val));
+		bacpy(&irk->rpa, rpa);
+		spin_unlock_bh(&hdev->irk_lock);
+		kfree(new_irk);
+		return irk;
 	}
 
-	memcpy(irk->val, val, 16);
-	bacpy(&irk->rpa, rpa);
+	kref_init(&new_irk->ref);
+	kref_get(&new_irk->ref);
+	set_bit(SMP_IRK_LINKED, &new_irk->flags);
+	list_add_rcu(&new_irk->list, &hdev->identity_resolving_keys);
+	spin_unlock_bh(&hdev->irk_lock);
 
-	return irk;
+	return new_irk;
 }
 
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
@@ -1372,16 +1483,27 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
 {
-	struct smp_irk *k, *tmp;
+	struct smp_irk *k, *removed;
 
-	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
-		if (bacmp(bdaddr, &k->bdaddr) || k->addr_type != addr_type)
-			continue;
+	for (;;) {
+		removed = NULL;
+		spin_lock_bh(&hdev->irk_lock);
+		list_for_each_entry(k, &hdev->identity_resolving_keys, list) {
+			if (bacmp(bdaddr, &k->bdaddr) ||
+			    k->addr_type != addr_type)
+				continue;
 
-		BT_DBG("%s removing %pMR", hdev->name, bdaddr);
+			__hci_irk_unlink(k);
+			removed = k;
+			break;
+		}
+		spin_unlock_bh(&hdev->irk_lock);
 
-		list_del_rcu(&k->list);
-		kfree_rcu(k, rcu);
+		if (!removed)
+			break;
+
+		BT_DBG("%s removing %pMR", hdev->name, bdaddr);
+		hci_irk_put(removed);
 	}
 }
 
@@ -1389,6 +1511,8 @@ bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 {
 	struct smp_ltk *k;
 	struct smp_irk *irk;
+	struct smp_irk_data irk_data;
+	bdaddr_t identity_addr;
 	u8 addr_type;
 
 	if (type == BDADDR_BREDR) {
@@ -1405,8 +1529,11 @@ bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 
 	irk = hci_get_irk(hdev, bdaddr, addr_type);
 	if (irk) {
-		bdaddr = &irk->bdaddr;
-		addr_type = irk->addr_type;
+		hci_irk_read(hdev, irk, &irk_data);
+		bacpy(&identity_addr, &irk_data.bdaddr);
+		addr_type = irk_data.addr_type;
+		hci_irk_put(irk);
+		bdaddr = &identity_addr;
 	}
 
 	rcu_read_lock();
@@ -2495,6 +2622,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_LIST_HEAD(&hdev->uuids);
 	INIT_LIST_HEAD(&hdev->link_keys);
 	INIT_LIST_HEAD(&hdev->long_term_keys);
+	spin_lock_init(&hdev->irk_lock);
 	INIT_LIST_HEAD(&hdev->identity_resolving_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 	INIT_LIST_HEAD(&hdev->le_accept_list);
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index aadffaaff20e..3b3f7a481990 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -817,13 +817,15 @@ DEFINE_SHOW_ATTRIBUTE(resolv_list);
 static int identity_resolving_keys_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
+	struct smp_irk_data irk_data;
 	struct smp_irk *irk;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
+		hci_irk_read(hdev, irk, &irk_data);
 		seq_printf(f, "%pMR (type %u) %*phN %pMR\n",
-			   &irk->bdaddr, irk->addr_type,
-			   16, irk->val, &irk->rpa);
+			   &irk_data.bdaddr, irk_data.addr_type,
+			   16, irk_data.val, &irk_data.rpa);
 	}
 	rcu_read_unlock();
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2f5e21ff9752..f2971319410d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5757,6 +5757,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
 	struct smp_irk *irk;
+	struct smp_irk_data irk_data;
 	u8 addr_type;
 	int err;
 
@@ -5842,8 +5843,10 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	 */
 	irk = hci_get_irk(hdev, &conn->dst, conn->dst_type);
 	if (irk) {
-		bacpy(&conn->dst, &irk->bdaddr);
-		conn->dst_type = irk->addr_type;
+		hci_irk_read(hdev, irk, &irk_data);
+		bacpy(&conn->dst, &irk_data.bdaddr);
+		conn->dst_type = irk_data.addr_type;
+		hci_irk_put(irk);
 	}
 
 	conn->dst_type = ev_bdaddr_type(hdev, conn->dst_type, NULL);
@@ -6234,7 +6237,9 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 {
 	struct discovery_state *d = &hdev->discovery;
 	struct smp_irk *irk;
+	struct smp_irk_data irk_data;
 	struct hci_conn *conn;
+	bdaddr_t identity_addr;
 	bool match, bdaddr_resolved;
 	u32 flags;
 	u8 *ptr;
@@ -6309,8 +6314,11 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	/* Check if we need to convert to identity address */
 	irk = hci_get_irk(hdev, bdaddr, bdaddr_type);
 	if (irk) {
-		bdaddr = &irk->bdaddr;
-		bdaddr_type = irk->addr_type;
+		hci_irk_read(hdev, irk, &irk_data);
+		bacpy(&identity_addr, &irk_data.bdaddr);
+		bdaddr_type = irk_data.addr_type;
+		hci_irk_put(irk);
+		bdaddr = &identity_addr;
 	}
 
 	bdaddr_type = ev_bdaddr_type(hdev, bdaddr_type, &bdaddr_resolved);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ffd7b37e7401..fcb96c4b0793 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2469,6 +2469,7 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
 {
 	struct hci_cp_le_add_to_resolv_list cp;
 	struct smp_irk *irk;
+	struct smp_irk_data irk_data;
 	struct bdaddr_list_with_irk *entry;
 	struct hci_conn_params *p;
 
@@ -2496,12 +2497,16 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
 	entry = hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_list,
 						&params->addr,
 						params->addr_type);
-	if (entry)
+	if (entry) {
+		hci_irk_put(irk);
 		return 0;
+	}
 
 	cp.bdaddr_type = params->addr_type;
 	bacpy(&cp.bdaddr, &params->addr);
-	memcpy(cp.peer_irk, irk->val, 16);
+	hci_irk_read(hdev, irk, &irk_data);
+	memcpy(cp.peer_irk, irk_data.val, sizeof(cp.peer_irk));
+	hci_irk_put(irk);
 
 	/* Default privacy mode is always Network */
 	params->privacy_mode = HCI_NETWORK_PRIVACY;
@@ -2532,6 +2537,7 @@ static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
 {
 	struct hci_cp_le_set_privacy_mode cp;
 	struct smp_irk *irk;
+	struct smp_irk_data irk_data;
 
 	if (!ll_privacy_capable(hdev) ||
 	    !(params->flags & HCI_CONN_FLAG_ADDRESS_RESOLUTION))
@@ -2552,10 +2558,12 @@ static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
 	if (!irk)
 		return 0;
 
+	hci_irk_read(hdev, irk, &irk_data);
 	memset(&cp, 0, sizeof(cp));
-	cp.bdaddr_type = irk->addr_type;
-	bacpy(&cp.bdaddr, &irk->bdaddr);
+	cp.bdaddr_type = irk_data.addr_type;
+	bacpy(&cp.bdaddr, &irk_data.bdaddr);
 	cp.mode = HCI_DEVICE_PRIVACY;
+	hci_irk_put(irk);
 
 	/* Note: params->privacy_mode is not updated since it is a copy */
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 75bfd5938b2e..928b761453d6 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -723,22 +723,34 @@ static struct sock *iso_get_sock(struct hci_dev *hdev, bdaddr_t *src,
 		/* Match Broadcast destination */
 		if (bacmp(dst, BDADDR_ANY) && bacmp(&iso_pi(sk)->dst, dst)) {
 			struct smp_irk *irk1, *irk2;
+			struct smp_irk_data irk_data;
+			bool resolved = false;
 
 			/* Check if destination is an RPA that we can resolve */
 			irk1 = hci_find_irk_by_rpa(hdev, dst);
 			if (!irk1)
 				continue;
 
+			hci_irk_read(hdev, irk1, &irk_data);
+
 			/* Match with identity address */
-			if (bacmp(&iso_pi(sk)->dst, &irk1->bdaddr)) {
+			if (!bacmp(&iso_pi(sk)->dst, &irk_data.bdaddr)) {
+				resolved = true;
+			} else {
 				/* Check if socket destination address is also
 				 * an RPA and if the IRK matches.
 				 */
 				irk2 = hci_find_irk_by_rpa(hdev,
 							   &iso_pi(sk)->dst);
-				if (!irk2 || irk1 != irk2)
-					continue;
+				if (irk2) {
+					resolved = irk1 == irk2;
+					hci_irk_put(irk2);
+				}
 			}
+
+			hci_irk_put(irk1);
+			if (!resolved)
+				continue;
 		}
 
 		/* Use Match function if provided */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ac4864e56ec7..841702cdf14e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7315,6 +7315,7 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 
 	for (i = 0; i < irk_count; i++) {
 		struct mgmt_irk_info *irk = &cp->irks[i];
+		struct smp_irk *smp_irk;
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_IRK,
@@ -7324,9 +7325,11 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 			continue;
 		}
 
-		hci_add_irk(hdev, &irk->addr.bdaddr,
-			    le_addr_type(irk->addr.type), irk->val,
-			    BDADDR_ANY);
+		smp_irk = hci_add_irk(hdev, &irk->addr.bdaddr,
+				      le_addr_type(irk->addr.type), irk->val,
+				      BDADDR_ANY);
+		if (smp_irk)
+			hci_irk_put(smp_irk);
 	}
 
 	hci_dev_set_flag(hdev, HCI_RPA_RESOLVING);
@@ -9945,7 +9948,8 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 	mgmt_event(MGMT_EV_NEW_LONG_TERM_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
-void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent)
+void mgmt_new_irk(struct hci_dev *hdev, const struct smp_irk_data *irk,
+		  bool persistent)
 {
 	struct mgmt_ev_new_irk ev;
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6091c47cb002..37000495b987 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -761,11 +761,13 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 		}
 
 		if (smp->remote_irk) {
-			list_del_rcu(&smp->remote_irk->list);
-			kfree_rcu(smp->remote_irk, rcu);
+			hci_irk_unlink(hcon->hdev, smp->remote_irk);
 		}
 	}
 
+	if (smp->remote_irk)
+		hci_irk_put(smp->remote_irk);
+
 	chan->data = NULL;
 	kfree_sensitive(smp);
 	hci_conn_drop(hcon);
@@ -1017,6 +1019,7 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	struct hci_dev *hdev = hcon->hdev;
 	struct smp_cmd_pairing *req = (void *) &smp->preq[1];
 	struct smp_cmd_pairing *rsp = (void *) &smp->prsp[1];
+	struct smp_irk_data irk_data;
 	bool persistent;
 
 	if (hcon->type == ACL_LINK) {
@@ -1035,15 +1038,16 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->remote_irk) {
-		mgmt_new_irk(hdev, smp->remote_irk, persistent);
+		hci_irk_read(hdev, smp->remote_irk, &irk_data);
+		mgmt_new_irk(hdev, &irk_data, persistent);
 
 		/* Now that user space can be considered to know the
 		 * identity address track the connection based on it
 		 * from now on (assuming this is an LE link).
 		 */
 		if (hcon->type == LE_LINK) {
-			bacpy(&hcon->dst, &smp->remote_irk->bdaddr);
-			hcon->dst_type = smp->remote_irk->addr_type;
+			bacpy(&hcon->dst, &irk_data.bdaddr);
+			hcon->dst_type = irk_data.addr_type;
 			/* Use a short delay to make sure the new address is
 			 * propagated _before_ the channels.
 			 */
@@ -2443,7 +2447,11 @@ int smp_cancel_and_remove_pairing(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		 * remove and free already invalidated rcu list entries. */
 		smp->ltk = NULL;
 		smp->responder_ltk = NULL;
-		smp->remote_irk = NULL;
+		if (smp->remote_irk) {
+			hci_irk_unlink(hdev, smp->remote_irk);
+			hci_irk_put(smp->remote_irk);
+			smp->remote_irk = NULL;
+		}
 
 		if (test_bit(SMP_FLAG_COMPLETE, &smp->flags))
 			smp_failure(conn, 0);
-- 
2.53.0

