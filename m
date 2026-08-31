Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A43E168C
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177264; cv=none; b=O3VUwht+EAeaGhZjPAP0+lMBDJLZfviXhmaQ0QqcZtSxxnOO8NaDxBncIMb6wle0HTSsZYH7cadEqPPCszDRnyOK7/9xuRtUdqc9W2yBJmyiXHZdvD6Iw9/H+VH+a9DbwK1udivFW3XxHAun35pDPMmnq1ApFoEK4xzogQLxuQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177264; c=relaxed/simple;
	bh=EOh34/bY+vLKME1hcEKp7nWL2DLHCDFgGMaDb2zsXnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3PfGgP/gprSD8WkGBly+jk9Xd/r+mAfVMYumNk/36OgGnBi+ZHsp21ltDsXlzXaol+7aLAPWR1VQuh42YXTDiicBF/iR38W2rAuLLk/uqImJMRC3dTS5Z9SIhDDPxUXcpYsbHdAVx1NLkoK1M9fZXWNn6jVkxjP5XY0aJOWfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qC/GcIf/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qC/GcIf/"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso3345769b3a.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 04:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788177261; x=1788782061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5cVb+Ke40wrGC2mPvk1Jaam2esmixnNeXINlgzV2XCM=;
        b=qC/GcIf/SHe4cpPsiBqGxujL3uZhsdzfWtGdsfm8dESw3ujK5lGBjnx7JQIN7tSOV+
         jqWHdCbX8jis0k1dOC9KtghFMLxJlYiwaXCUOSC1sWlk3Uet9ME3jaQOW59r538y4Byf
         XXCQaV90KYl9YvmlMisXmmi/DgeecoD0kPXBOiDHQ+ZwvA7wMmYEguPDIPGm8rpfpScP
         iUAnWAa7qIN2YEh76U+Q3KwnBAZ9klSg1PlcJNcEqFOf6UDvvprykBwOk6jd2onK/FOt
         ObX3hIWxzKxUGzG3JAylBcSwcxuMnh/l8bxoLJ6PuX6713OWC56c9+wLU5cHBN+IYVZP
         pZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788177261; x=1788782061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5cVb+Ke40wrGC2mPvk1Jaam2esmixnNeXINlgzV2XCM=;
        b=n7Vn2d2jhMCatqqRo1W782FGK4qZ1GK+GLDna6TTN0K1iZARPaxIMlpf4nNGwSwTl/
         quFdgE1WSQ+izfqb+U9Bo2oBqqqZJUlog4mE97MmMaLtyzW5Ly8MCHO7GmhVBgJe8/Fn
         tKmr2DsMxr3x4dW6LNePze+PoxyA8PuqAWxJKLgQ778fSFLS7O6h/r1VAUQeqB8Gis3S
         MTv9RMfoxZV9sOKj7czEYUGr/uJ7uc4jrtFGkOgINeUZTXa8G/dX1sBQbfZPXM8giG9F
         B5zd92sIzZGZ4LaJecbEfgaieWiivda+aepfWnqXdczp/fd8gPRPw855tTguSQseJ7RH
         6e+A==
X-Forwarded-Encrypted: i=1; AHgh+RohBekKB9cF8bZBP9FriqWU/Mla4lIU2TIm0nPYgHlQ3o/TA63LK08WVxAZ9CcSKtYGE4iVVyM=@vger.kernel.org
X-Gm-Message-State: AFuF++ktLv/L4mplpMaYA/2TAJp7cjDb5UUehNJ+pC2W5iP3Luf9YLpn
	n1uQ/o1xzrnFRTWncnty5jBNV6g95RPiHWr8Sm4nVZ3vSaYY9YPHBk+9
X-Gm-Gg: AR+sD12J1mISe7/HTKTVRFbeIhLEf2c8O3CJfecm7HrAJLdtdhBBX5OZFNeY6Qg3fgx
	yKswMS3w5lDrRvkE1a7KunAyl9h5te6MMyZggu2wN43LTeLISQRrVm42c4p59bnEW3KAQrYppBE
	pcqfmYR0xU9HcQI2EC+MaW4ucoTIsVHXOKQi1LlvkH9MMBcVlXBnPrxYB+dwT9sXTKlS1p4CYpS
	DoFlnC2nWxJi+zKtqlqwBXJDUPV9PNDeMHDFxB5tm+Qs5FbaqZxsg+cWSJMgjZ6rdWPOatUJBjd
	LmdSTPWF2bXtDi+4EQGI4VKKfpfMt8TBjWjMa+24ixiBYUk9nJ2vdRkUJ/vwEweWiAdfBrMPibc
	7RT44V2SXKtUlUr/xdQo3k4Tc7UlhB1KIrFWyzq1gIeezCroj/6fPSG1oFIOfF8Faw122OSV8EG
	XeSCswnFaqe9hPi2E93DRMbIdhlTlieJyITFWA3W+5oEt56HC/bgncFAxYNjJhpqv+PVFKme5k/
	15Bn8grUsAqdCoB4DV6lX9SCkoFGWEJd+FYWt1O85k=
X-Received: by 2002:a05:6a00:21ce:b0:84f:a7bf:8fb9 with SMTP id d2e1a72fcca58-85626e0fdc8mr37556315b3a.3.1788177260682;
        Mon, 31 Aug 2026 04:54:20 -0700 (PDT)
Received: from hnkz-ubuntu-vm1.mshome.net (flh4-125-195-69-140.tky.mesh.ad.jp. [125.195.69.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8569f49f516sm3509894b3a.4.2026.08.31.04.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 04:54:20 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: Kazuki Hanai <hnkz.64@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_core: Fix IRK lookup lifetime races
Date: Mon, 31 Aug 2026 20:53:42 +0900
Message-ID: <20260831115344.2393116-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828022549.1721170-1-hnkz.64@gmail.com>
References: <20260828022549.1721170-1-hnkz.64@gmail.com>
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

Make RPA lookup and caching linearizable with duplicate-key updates.
After a cryptographic match outside the lock, revalidate the matched IRK
value while acquiring the reference, updating the cache, and taking the
payload snapshot under the lock. Perform cached-RPA matching and
reference acquisition under that lock as well. This prevents an old-key
match from caching its RPA in a replacement-key object and makes blocked
key filtering use the payload that was actually matched.

Add a CONFIG_BT_SELFTEST regression that models the exact stale-match
state and verifies that it neither acquires a reference nor changes the
replacement key's cached RPA. It also covers successful current-key cache
updates and cached lookup reference balancing.

Fixes: a7ec73386ce2 ("Bluetooth: Fix removing any IRKs when unpairing devices")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
---
Changes in v2:
- Use the required AGENT_NAME:MODEL_VERSION format for the Assisted-by
  trailer reported by CI.
- Revalidate the cryptographically matched IRK under irk_lock before
  caching the RPA and acquiring the caller reference.  Also make cached
  lookup, reference acquisition, and payload snapshot one locked step.
- Add a CONFIG_BT_SELFTEST regression for an old-key lookup racing a
  replacement key update, including rejected-path reference accounting.
- Rebuild the Bluetooth subtrees with W=1 and boot the new selftest.
  Fresh matched baseline/patched runs passed mgmt-tester IRK (6/6),
  mgmt-tester Privacy (30/30), and smp-tester (8/8) on both kernels.
- The v1 CI failures in unrelated experimental-feature and mesh-cancel
  tests were previously reproduced on the v1 base and patched kernels;
  the handlers involved are unchanged here.

v1: https://lore.kernel.org/linux-bluetooth/20260828022549.1721170-1-hnkz.64@gmail.com/

 include/net/bluetooth/hci_core.h |  19 +-
 net/bluetooth/hci_conn.c         |  34 +++-
 net/bluetooth/hci_core.c         | 311 +++++++++++++++++++++++++++----
 net/bluetooth/hci_debugfs.c      |   6 +-
 net/bluetooth/hci_event.c        |  16 +-
 net/bluetooth/hci_sync.c         |  16 +-
 net/bluetooth/iso.c              |  18 +-
 net/bluetooth/mgmt.c             |  12 +-
 net/bluetooth/selftest.c         |   4 +
 net/bluetooth/selftest.h         |   2 +
 net/bluetooth/smp.c              |  20 +-
 11 files changed, 389 insertions(+), 69 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4105c446ca983..75f3f26d9e312 100644
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
index 8de98af2fb581..5e19fc6ef9300 100644
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
index 35a1be57e3862..e07d3673295b7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -38,6 +38,7 @@
 #include <net/bluetooth/mgmt.h>
 
 #include "hci_debugfs.h"
+#include "selftest.h"
 #include "smp.h"
 #include "leds.h"
 #include "msft.h"
@@ -1031,13 +1032,36 @@ void hci_smp_ltks_clear(struct hci_dev *hdev)
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
 
@@ -1171,37 +1195,99 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return NULL;
 }
 
+static void __hci_irk_read(struct smp_irk *irk, struct smp_irk_data *data)
+{
+	bacpy(&data->rpa, &irk->rpa);
+	bacpy(&data->bdaddr, &irk->bdaddr);
+	data->addr_type = irk->addr_type;
+	memcpy(data->val, irk->val, sizeof(data->val));
+}
+
+void hci_irk_read(struct hci_dev *hdev, struct smp_irk *irk,
+		  struct smp_irk_data *data)
+{
+	spin_lock_bh(&hdev->irk_lock);
+	__hci_irk_read(irk, data);
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
+static bool hci_irk_get_by_rpa(struct hci_dev *hdev, struct smp_irk *irk,
+			       const bdaddr_t *rpa, const u8 val[16],
+			       struct smp_irk_data *data)
+{
+	bool match = false;
+
+	spin_lock_bh(&hdev->irk_lock);
+	if (!test_bit(SMP_IRK_LINKED, &irk->flags))
+		goto done;
+
+	if (val) {
+		if (memcmp(irk->val, val, sizeof(irk->val)))
+			goto done;
+
+		bacpy(&irk->rpa, rpa);
+	} else if (bacmp(&irk->rpa, rpa)) {
+		goto done;
+	}
+
+	kref_get(&irk->ref);
+	__hci_irk_read(irk, data);
+	match = true;
+
+done:
+	spin_unlock_bh(&hdev->irk_lock);
+	return match;
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
+		if (hci_irk_get_by_rpa(hdev, irk, rpa, NULL, &data)) {
 			irk_to_return = irk;
 			goto done;
 		}
 	}
 
 	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
-		if (smp_irk_matches(hdev, irk->val, rpa)) {
-			bacpy(&irk->rpa, rpa);
+		hci_irk_read(hdev, irk, &data);
+		if (smp_irk_matches(hdev, data.val, rpa) &&
+		    hci_irk_get_by_rpa(hdev, irk, rpa, data.val, &data)) {
 			irk_to_return = irk;
 			goto done;
 		}
 	}
 
 done:
+	rcu_read_unlock();
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
 
@@ -1209,6 +1295,7 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 addr_type)
 {
 	struct smp_irk *irk_to_return = NULL;
+	struct smp_irk_data data;
 	struct smp_irk *irk;
 
 	/* Identity Address must be public or static random */
@@ -1217,25 +1304,135 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
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
+#if IS_ENABLED(CONFIG_BT_SELFTEST)
+int __init bt_selftest_irk(void)
+{
+	static const u8 old_val[16] = { 0x11 };
+	static const u8 new_val[16] = { 0x22 };
+	static const bdaddr_t old_rpa = { { 1, 2, 3, 4, 5, 0x40 } };
+	static const bdaddr_t new_rpa = { { 6, 7, 8, 9, 10, 0x40 } };
+	struct smp_irk_data data;
+	struct hci_dev *hdev;
+	struct smp_irk *irk;
+	bool match;
+	int err = -EINVAL;
+
+	hdev = kzalloc_obj(*hdev);
+	if (!hdev)
+		return -ENOMEM;
+
+	irk = kzalloc_obj(*irk);
+	if (!irk) {
+		kfree(hdev);
+		return -ENOMEM;
+	}
+
+	spin_lock_init(&hdev->irk_lock);
+	kref_init(&irk->ref);
+	set_bit(SMP_IRK_LINKED, &irk->flags);
+	memcpy(irk->val, new_val, sizeof(irk->val));
+	bacpy(&irk->rpa, &new_rpa);
+
+	/* A lookup that matched old_val before a rekey must not replace the
+	 * new key's cached RPA or acquire a caller reference.
+	 */
+	match = hci_irk_get_by_rpa(hdev, irk, &old_rpa, old_val,
+				   &data);
+	if (match) {
+		hci_irk_put(irk);
+		goto done;
+	}
+
+	if (refcount_read(&irk->ref.refcount) != 1 ||
+	    bacmp(&irk->rpa, &new_rpa))
+		goto done;
+
+	match = hci_irk_get_by_rpa(hdev, irk, &old_rpa, NULL,
+				   &data);
+	if (match) {
+		hci_irk_put(irk);
+		goto done;
+	}
+	if (refcount_read(&irk->ref.refcount) != 1)
+		goto done;
+
+	/* The same cache update remains valid when the matched key is current. */
+	match = hci_irk_get_by_rpa(hdev, irk, &old_rpa, new_val,
+				   &data);
+	if (!match)
+		goto done;
+
+	if (bacmp(&data.rpa, &old_rpa) ||
+	    memcmp(data.val, new_val, sizeof(data.val))) {
+		hci_irk_put(irk);
+		goto done;
+	}
+	hci_irk_put(irk);
+
+	match = hci_irk_get_by_rpa(hdev, irk, &old_rpa, NULL,
+				   &data);
+	if (!match)
+		goto done;
+	hci_irk_put(irk);
+
+	err = 0;
+	BT_INFO("IRK lookup test passed");
+
+done:
+	clear_bit(SMP_IRK_LINKED, &irk->flags);
+	hci_irk_put(irk);
+	kfree(hdev);
+	return err;
+}
+#endif
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
@@ -1315,24 +1512,47 @@ struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
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
 
-		bacpy(&irk->bdaddr, bdaddr);
-		irk->addr_type = addr_type;
+	new_irk = kzalloc_obj(*new_irk);
+	if (!new_irk)
+		return NULL;
+
+	bacpy(&new_irk->bdaddr, bdaddr);
+	new_irk->addr_type = addr_type;
+	memcpy(new_irk->val, val, sizeof(new_irk->val));
+	bacpy(&new_irk->rpa, rpa);
+
+	spin_lock_bh(&hdev->irk_lock);
+	list_for_each_entry(irk, &hdev->identity_resolving_keys, list) {
+		if (addr_type != irk->addr_type ||
+		    bacmp(bdaddr, &irk->bdaddr))
+			continue;
 
-		list_add_rcu(&irk->list, &hdev->identity_resolving_keys);
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
@@ -1372,16 +1592,27 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 
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
 
@@ -1389,6 +1620,8 @@ bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 {
 	struct smp_ltk *k;
 	struct smp_irk *irk;
+	struct smp_irk_data irk_data;
+	bdaddr_t identity_addr;
 	u8 addr_type;
 
 	if (type == BDADDR_BREDR) {
@@ -1405,8 +1638,11 @@ bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 
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
@@ -2495,6 +2731,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_LIST_HEAD(&hdev->uuids);
 	INIT_LIST_HEAD(&hdev->link_keys);
 	INIT_LIST_HEAD(&hdev->long_term_keys);
+	spin_lock_init(&hdev->irk_lock);
 	INIT_LIST_HEAD(&hdev->identity_resolving_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 	INIT_LIST_HEAD(&hdev->le_accept_list);
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index aadffaaff20e1..3b3f7a4819903 100644
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
index 2f5e21ff97529..f2971319410d2 100644
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
index ffd7b37e74018..fcb96c4b07937 100644
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
index 75bfd5938b2ea..928b761453d6f 100644
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
index ac4864e56ec72..841702cdf14e6 100644
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
 
diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
index ae5b44bb9d3d3..5d30828e06688 100644
--- a/net/bluetooth/selftest.c
+++ b/net/bluetooth/selftest.c
@@ -270,6 +270,10 @@ static int __init run_selftest(void)
 	if (err)
 		goto done;
 
+	err = bt_selftest_irk();
+	if (err)
+		goto done;
+
 	err = bt_selftest_smp();
 
 done:
diff --git a/net/bluetooth/selftest.h b/net/bluetooth/selftest.h
index 34d684ee84fda..b18648fa490f2 100644
--- a/net/bluetooth/selftest.h
+++ b/net/bluetooth/selftest.h
@@ -40,3 +40,5 @@ static inline int bt_selftest(void)
 }
 
 #endif
+
+int bt_selftest_irk(void);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6091c47cb0028..37000495b9872 100644
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
