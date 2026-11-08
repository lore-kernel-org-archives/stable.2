Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135396;
	b=U8fHO7Uh3hQ9F9SpgAgXlB0BqMCN/i+tKC3I3U8qFAzEwrklw5wVQteIZ81MJXTfLkxJ
	 r3ju3eB86UvYcyhL2ionnBsUyHc0VxtvegO/EjjmR8qiSX5lSpp09WHAZYtyHZ+2YaXlO
	 XJgS2fOEOWOMLz5v37KxdU6kx6XR414WE46dAUWj66bK4xtVLcf/pQw83D/wYpmkbtUQk
	 GSnE9B6Tlvs+wFVpDg3t7jgKCj8q6FsxbTlpWZAt+54l3rdm3JPg54idPad+vjhKs7vLx
	 nyxAIRwLCpdjm/roDOulkDMJwKvXl/lhP399CccUo0bK+eEoryvmngbFd8lkbR6UDdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135396;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=HxXu2GTQG4yhEJLc5iwQnlJAqV2TSZDwVlIJ4aCRQ3g=;
	b=OeBL8ty0rn3kEyYRGB7rchE1s0NfWmp+Ng+LiMeMu1n/0cvj1g0wFXJrfXr/ooLhdCwb
	 FvrZQTECOl6cW0ribPQh9Ht/CJLFiqlgYkaHIrNcqRXUMhdzJDr0+nJasf4nxMSB5BCkE
	 rVY9TMQruf3J90rkGNqG/0xsfw3vTtYXCz6n7hpA0q4b8TYpM8S5NKrLPiPeT2n3NL4CZ
	 mrCjU0+v2qqQlwxonN0ig1nP/KMPKMjtmtTGnNGKiKggkEph7HKxg+/69CCXSKeoBYcub
	 taCpjQZVpiFFhkka2XP+E3oxtepDrksmSnVjmqeqkq1KAN6tI+u0bFIiipleAQOfUjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=RMr8Hx9I;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC678606A323;
	Sun,  8 Nov 2026 10:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC678606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=RMr8Hx9I
Received: from LAPTOP-99KJFSET (unknown [223.75.64.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53e3dfdd6;
	Sun, 8 Nov 2026 18:56:30 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] PNP: fix unlocked access to the resource list
Date: Sun,  8 Nov 2026 18:56:29 +0800
Message-ID: <20261108105629.1200-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1bacd774203a1kunm370148b4ce665
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0pDVkpMGB5KGktNTkxDQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTE5VTU9VQ0lZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=RMr8Hx9I1p+19Xd9tExMu0+ekRh+ujJXpFpQc2XQVz1abraRAHWybj+IlBiDnRpqsRX/SRJxPNB1PZrBpWFKyI5jN1NLNOqAahl2eK7DA8wouPlSBIAW+eEopVZLvgY2kM24FR5mhTMxmui7LvUmwXR0SPvrGjy72Fraup0Baus=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=HxXu2GTQG4yhEJLc5iwQnlJAqV2TSZDwVlIJ4aCRQ3g=;
	h=date:mime-version:subject:message-id:from;

pnp_range_reserved() walks dev->resources without pnp_res_mutex and
dereferences each pnp_resource, while the "clear", "auto" and "set"
branches of resources_store() free those entries without holding it.

pnp_free_resource() is list_del() + kfree(): list_del() hides the entry
only from later walks, not from one in flight; no refcount, no RCU.

pnp_res_mutex already guards dev->resources (pnp_assign_resources() and
the .get() callbacks hold it), so the unlocked readers and the remaining
writers share it; resources_store() also takes a file-static leaf lock
around its whole body, closing the two-descriptor interleave and
serializing writes per PnP device.  The pnp_assign_resources() failure
path frees via pnp_clean_resource_table() under that lock again, which
also fixes the unlocked manager.c:295-298 free after mutex_unlock().

pnp_get_resource() and the protocol .set() callbacks still walk the list
unlocked; they cannot take this mutex, because their callers in
pnp_assign_resources() already hold it and it does not recurse.

Fixes: 1b8e69662e1a ("pnp: add PNP resource range checking function")
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/pnp/interface.c | 52 ++++++++++++++++++++++++++++++++++-
 drivers/pnp/manager.c   | 60 ++++++++++++++++++++++++++++++++++++++---
 drivers/pnp/resource.c  | 19 ++++++++++++-
 drivers/pnp/support.c   | 11 ++++++++
 4 files changed, 137 insertions(+), 5 deletions(-)

diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index 9303fef72df0..80a39cebf8e5 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -265,6 +265,30 @@ static ssize_t resources_show(struct device *dmdev,
 	buffer->buffer = buf;
 	buffer->curr = buffer->buffer;
 
+	/*
+	 * This is a sysfs attribute read, so the caller holds no PnP lock and
+	 * nothing serializes us against a concurrent write to the same
+	 * attribute from another file descriptor: kernfs only serializes
+	 * operations on the same open file.  Walk the list under the lock that
+	 * the writers of dev->resources take.
+	 *
+	 * That lock serializes the list itself, the dev->resources list head
+	 * and the struct pnp_resource entries linked into it, which is what
+	 * this walk needs.  It does not cover the scalar fields read below:
+	 * dev->active is written by pnp_activate_dev() and pnp_disable_dev()
+	 * (manager.c:438, :460) and by the protocol callbacks without a lock,
+	 * so the "state =" line can disagree with the entries below while a
+	 * store is in flight.  The worst case is a diagnostic line that is
+	 * briefly stale; dev->active is a plain int, so this is not a
+	 * use-after-free.
+	 *
+	 * resources_store_mutex is deliberately not taken here: that would
+	 * add this read to the store serialization described below, and a
+	 * diagnostic read should not queue up behind an in-progress
+	 * activation or deactivation of the device.
+	 */
+	mutex_lock(&pnp_res_mutex);
+
 	pnp_printf(buffer, "state = %s\n", dev->active ? "active" : "disabled");
 
 	list_for_each_entry(pnp_res, &dev->resources, list) {
@@ -295,6 +319,8 @@ static ssize_t resources_show(struct device *dmdev,
 		}
 	}
 
+	mutex_unlock(&pnp_res_mutex);
+
 	ret = (buffer->curr - buf);
 	kfree(buffer);
 	return ret;
@@ -333,6 +359,22 @@ static char *pnp_get_resource_value(char *buf,
 	return buf;
 }
 
+/*
+ * Serializes the writers of the "resources" attribute among each other.
+ *
+ * Taking pnp_res_mutex in each writer is not sufficient.  The "activate"
+ * branch runs the protocol .set() callback, which reads dev->resources
+ * through pnp_get_resource() without holding pnp_res_mutex, and dev->active,
+ * which gates the "clear", "auto", "set" and "fill" branches, is only set
+ * after that callback returned.  A second writer on another file descriptor
+ * therefore passes the gate and frees entries that the first one is still
+ * traversing.  The "get" branch has no dev->active gate at all, and the
+ * protocol .get() callback it calls frees the table too.
+ *
+ * Lock order: resources_store_mutex before pnp_res_mutex.
+ */
+static DEFINE_MUTEX(resources_store_mutex);
+
 static ssize_t resources_store(struct device *dmdev,
 			       struct device_attribute *attr, const char *ubuf,
 			       size_t count)
@@ -341,6 +383,8 @@ static ssize_t resources_store(struct device *dmdev,
 	char *buf = (void *)ubuf;
 	int retval = 0;
 
+	mutex_lock(&resources_store_mutex);
+
 	if (dev->status & PNP_ATTACHED) {
 		retval = -EBUSY;
 		dev_info(&dev->dev, "in use; can't configure\n");
@@ -365,14 +409,18 @@ static ssize_t resources_store(struct device *dmdev,
 	if (!strncasecmp(buf, "auto", 4)) {
 		if (dev->active)
 			goto done;
+		mutex_lock(&pnp_res_mutex);
 		pnp_init_resources(dev);
+		mutex_unlock(&pnp_res_mutex);
 		retval = pnp_auto_config_dev(dev);
 		goto done;
 	}
 	if (!strncasecmp(buf, "clear", 5)) {
 		if (dev->active)
 			goto done;
+		mutex_lock(&pnp_res_mutex);
 		pnp_init_resources(dev);
+		mutex_unlock(&pnp_res_mutex);
 		goto done;
 	}
 	if (!strncasecmp(buf, "get", 3)) {
@@ -390,8 +438,8 @@ static ssize_t resources_store(struct device *dmdev,
 		if (dev->active)
 			goto done;
 		buf += 3;
-		pnp_init_resources(dev);
 		mutex_lock(&pnp_res_mutex);
+		pnp_init_resources(dev);
 		while (1) {
 			buf = skip_spaces(buf);
 			if (!strncasecmp(buf, "io", 2)) {
@@ -432,6 +480,8 @@ static ssize_t resources_store(struct device *dmdev,
 	}
 
 done:
+	mutex_unlock(&resources_store_mutex);
+
 	if (retval < 0)
 		return retval;
 	return count;
diff --git a/drivers/pnp/manager.c b/drivers/pnp/manager.c
index 1765d6e60a8a..6360863d3dea 100644
--- a/drivers/pnp/manager.c
+++ b/drivers/pnp/manager.c
@@ -17,6 +17,51 @@
 #include <linux/mutex.h>
 #include "base.h"
 
+/*
+ * Serializes access to the resource list of every PnP device, i.e. to the
+ * dev->resources list head and to the struct pnp_resource entries linked
+ * into it: the additions in pnp_new_resource(), the removals in
+ * pnp_free_resource() and, at runtime, every direct walk of
+ * dev->resources in this directory, except the one in pnp_get_resource().
+ *
+ * "At runtime" is literal.  Three walks of dev->resources in this
+ * directory run without the lock on purpose, because they can only run
+ * while the device is being created, i.e. before it is linked into
+ * pnp_global and registered with the driver model, so no other CPU can
+ * reach it yet:
+ *
+ *   - quirks.c:305 (quirk_amd_mmconfig_area()) and quirks.c:388
+ *     (quirk_amd_ioapic()), called from pnp_fixup_device() at the top of
+ *     __pnp_add_device(), before the list_add_tail() into pnp_global and
+ *     before device_register() (core.c:164, :169, :174);
+ *   - core.c:104 (pnp_free_resources()), reached through
+ *     pnp_init_resources() from pnpacpi/core.c:273, isapnp/core.c:403 and
+ *     pnpbios/core.c:331, all three before their pnp_add_device() call.
+ *
+ * The runtime exception is a real gap.  pnp_get_resource() cannot take this
+ * mutex, because its callers in pnp_assign_resources() hold it already, so
+ * it walks the list lockless, and so does everything that reaches the list
+ * through it instead of walking dev->resources directly: the protocol
+ * .set() callbacks that program a device from pnp_start_dev(), and
+ * pnp_is_active() as used by the sound/isa drivers.  Those readers are not
+ * serialized against the writers above.
+ *
+ * The pnp_global device list is not covered either.  The naked
+ * pnp_for_each_dev() macro (include/linux/pnp.h) lets pnp_range_reserved()
+ * walk that list without pnp_lock, while pnp_delist_device() unlinks a
+ * device under pnp_lock and pnp_release_device() frees the device from the
+ * driver model release callback, so the walk can read a device that is
+ * already gone.  That is a defect of the device list, not of dev->resources,
+ * and it needs its own synchronization primitive.
+ *
+ * pnp_release_device() also calls pnp_free_resources() without the mutex,
+ * but by then the sysfs attributes are gone and the device is no longer
+ * reachable from resources_store(), so that path is out of scope here.
+ *
+ * This is an ordinary mutex, so it must not be taken from atomic context.
+ * It is not exported, so out-of-tree callers cannot acquire it; in-tree
+ * code still can, through the extern declaration in include/linux/pnp.h:330.
+ */
 DEFINE_MUTEX(pnp_res_mutex);
 
 static struct resource *pnp_find_resource(struct pnp_dev *dev,
@@ -292,12 +337,21 @@ static int pnp_assign_resources(struct pnp_dev *dev, int set)
 			break;
 	}
 
+	/*
+	 * Drop the partially assigned entries before dropping the lock, so
+	 * that no other reader of dev->resources can observe a table that is
+	 * about to be cleaned up, or briefly report it as reserved.
+	 */
+	if (ret < 0)
+		pnp_clean_resource_table(dev);
+
 	mutex_unlock(&pnp_res_mutex);
-	if (ret < 0) {
+
+	if (ret < 0)
 		pnp_dbg(&dev->dev, "pnp_assign_resources failed (%d)\n", ret);
-		pnp_clean_resource_table(dev);
-	} else
+	else
 		dbg_pnp_show_resources(dev, "pnp_assign_resources succeeded");
+
 	return ret;
 }
 
diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 6792bd023123..834aed24633f 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -20,6 +20,7 @@
 #include <linux/libata.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/mutex.h>
 
 #include <linux/pnp.h>
 #include "base.h"
@@ -690,14 +691,30 @@ int pnp_range_reserved(resource_size_t start, resource_size_t end)
 	struct pnp_resource *pnp_res;
 	resource_size_t *dev_start, *dev_end;
 
+	/*
+	 * pnp_res_mutex only serializes the walk over each device's resource
+	 * list.  The traversal of the pnp_global device list itself is not
+	 * covered by it and this function holds no other lock, so it can run
+	 * concurrently with the removal of a device; see the comment on
+	 * pnp_res_mutex for why that is a separate defect that needs its own
+	 * primitive.
+	 *
+	 * Taking the mutex makes this function sleepable, which is a change
+	 * for an exported symbol: atomic callers are no longer allowed.
+	 */
+	mutex_lock(&pnp_res_mutex);
 	pnp_for_each_dev(dev) {
 		list_for_each_entry(pnp_res, &dev->resources, list) {
 			dev_start = &pnp_res->res.start;
 			dev_end   = &pnp_res->res.end;
-			if (ranged_conflict(&start, &end, dev_start, dev_end))
+			if (ranged_conflict(&start, &end, dev_start, dev_end)) {
+				mutex_unlock(&pnp_res_mutex);
 				return 1;
+			}
 		}
 	}
+	mutex_unlock(&pnp_res_mutex);
+
 	return 0;
 }
 EXPORT_SYMBOL(pnp_range_reserved);
diff --git a/drivers/pnp/support.c b/drivers/pnp/support.c
index f6c866851769..559d66698742 100644
--- a/drivers/pnp/support.c
+++ b/drivers/pnp/support.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/ctype.h>
 #include <linux/hex.h>
+#include <linux/mutex.h>
 #include <linux/pnp.h>
 #include "base.h"
 
@@ -80,6 +81,14 @@ void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc)
 {
 	struct pnp_resource *pnp_res;
 
+	/*
+	 * Both callers, the tail of pnp_assign_resources() and
+	 * pnp_start_dev(), run without pnp_res_mutex and can execute
+	 * concurrently with a user space write to the sysfs "resources"
+	 * attribute, so the walk needs the lock.
+	 */
+	mutex_lock(&pnp_res_mutex);
+
 	if (list_empty(&dev->resources))
 		pnp_dbg(&dev->dev, "%s: no current resources\n", desc);
 	else {
@@ -87,6 +96,8 @@ void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc)
 		list_for_each_entry(pnp_res, &dev->resources, list)
 			pnp_dbg(&dev->dev, "%pr\n", &pnp_res->res);
 	}
+
+	mutex_unlock(&pnp_res_mutex);
 }
 
 char *pnp_option_priority_name(struct pnp_option *option)
-- 
2.50.1.windows.1

