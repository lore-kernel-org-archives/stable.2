Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257042;
	b=GFJCwkt1pYSyFzElIo433s7yOZdcy/r7KARmPqyB4KjZDraBVPfCiU1d3cg6gWvQ3BBx
	 3be9GtLrjjxgbm5+rr5dDgflAE+EDW4XxHjb6ZQ3zN2lXJ9r+R3qvRAG0ymAORo7xcb/F
	 Nx7DI4vpRTSZtBND5rYe8g/JyOPNVhmhXfmLvBdk5gNuv1oSwC8zFwJM8lKOR7SZqPwwe
	 /qBKqEQ8kMEU6aRPmvxn40r7Z9tW0rpNBQWFd+H+gncnsxyRYzmwmi94muq26rN98LxBB
	 DA6lFyLRkBv6Y22qtV8h96oHqeL0FVlCXHAaqPEzSKQzAb9+Cd6NM1unEm0uuGzE5hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257042;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=2BR2wSy5joZ/Mpe7EJC50aJ2E6Aa1XiDqjOTNWWpSlc=;
	b=WBNe6LIwy9/Bkz3Hq0papZq45R0Na/nsWe8PVPW6LmERXDe8ceo8Zkq51vOeLZ4goZCS
	 89m2MMzj7iNQVFS6mdFmOPi09Xz3OCfd9NhrhbMf5PYKICrm+H3P4RnHDWnAx5eboOIlP
	 eijATZ8D4C8YjsGFoaLhM7E1nXvr0H8RbWzuJ/lcH40tt5HHyUERO4T8BOsNZrA0vegzM
	 +bofuy5O1XGFLjn1Px/8hmJjmfKxfO00sTWpgaljraiPvA2AAGrGCOdsunsUL7mJ/fb7d
	 7Z6wA2i9qiWVHeIp5w4czDFEBMlAtcledS5p+lO/5kf0P20V6fFRFcqJ+Pyb7oDdaXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Kr19EuUW;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619DB606A31A;
	Thu, 29 Oct 2026 06:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 619DB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Kr19EuUW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2B
	R2wSy5joZ/Mpe7EJC50aJ2E6Aa1XiDqjOTNWWpSlc=; b=Kr19EuUWqtR3JHj0jo
	tsp2PXpBHPcDFB94Mb+07tkLCXukrZHcUlEYi9NaFkGIrD/pZiEORmXyM0r9ZdiQ
	J1Gk/9Mkh4IbYv6ivEFgJ14EYypT8mZVTRXVHRn5yEJUIYP5PbULzmNmr7uusLeB
	qe65BpCmJMHigKZFIPu2kNgMM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3318h7uJqLmdrDQ--.46914S2;
	Thu, 29 Oct 2026 14:56:35 +0800 (CST)
From: Yongxin Yang <yangyongxin@kylinos.cn>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Yang Yongxin <yangyongxin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] cxl/core: Create einj_types when EINJ becomes available
Date: Thu, 29 Oct 2026 14:56:29 +0800
Message-Id: <20261029065629.333949-1-yangyongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261028084934.1735010-1-yangyongxin@kylinos.cn>
References: <20261028084934.1735010-1-yangyongxin@kylinos.cn>
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
X-CM-TRANSID:_____wD3318h7uJqLmdrDQ--.46914S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wr4rArWxurWrAF1fWFW5trb_yoWxCF1rpa
	98Gr4rCrWkAayxAr43A34UZ34rWw4kW3srCrykW34aya1Dur15JFyDAayY9ayDWFW8Jr10
	q3WYyFyUG340yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgNV9UUUUU=
Sender: yang_yongxin123@163.com
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbC-wMXtGri7iNUqgAA3k

From: Yang Yongxin <yangyongxin@kylinos.cn>

The einj_types file under the CXL debugfs directory is never created.

cxl_core_init() runs at subsys_initcall level, while EINJ registers itself
from einj_init() at device_initcall level. When cxl_core_init() evaluates
einj_cxl_is_initialized() the built-in EINJ driver has not been initialized
yet, so the value is always false and the debugfs_create_file("einj_types")
call below it is never reached. Users have no way to discover which CXL
error types the platform supports from debugfs.

Create the file from every point that can tell EINJ is up: cxl_core_init()
covers cxl_core being a module loaded after EINJ has been initialized;
cxl_acpi_probe() covers the same case for cxl_acpi and also systems where
the CEDT is parsed but no dport is ever added; and the dport probe path
covers the built-in case, where the dport added from the memdev probe is
the only hook reached after einj_init().

The dport probe path can run concurrently for different parent ports, each
holding only its own device lock, so serialize the check and the create to
avoid a duplicate debugfs_create_file() attempt that would only fail with
-EEXIST. Reset the cached dentry in cxl_core_exit() so that reloading
cxl_core starts from a clean state.

Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/all/de14c4ef-e3d8-432f-9ce8-87c468d6d2ad@amd.com/
Signed-off-by: Yang Yongxin <yangyongxin@kylinos.cn>
---
Changes in v3:
- Take the review from Ben: the helper is now cxl_debugfs_einj_add_types(),
  non-static, declared in cxl.h and exported to cxl_acpi only, so that the
  cxl_acpi hook can call it.
- Add the cxl_acpi_probe() hook, before cxl_bus_rescan(), so the file is
  created once the CXL topology exists instead of waiting for a dport.
- Keep the dport path as a retry point. With EINJ built in, cxl_core_init()
  and cxl_acpi_probe() both run before einj_init(), so dropping it would
  still leave the file uncreated there.
- Drop the "RCH is out of scope" paragraph. RCH does add a dport, from
  add_host_bridge_dport(); the file is still not created there when EINJ is
  built in, so do not claim the acpi hook fixes RCH.
- Reset einj_types_dentry and cxl_debugfs in cxl_core_exit(), so that a
  reloaded cxl_core does not keep a stale pointer and lose the file.
- Use guard(mutex) instead of mutex_lock()/mutex_unlock().

 drivers/cxl/acpi.c      |  9 +++++++++
 drivers/cxl/core/port.c | 41 +++++++++++++++++++++++++++++++++++------
 drivers/cxl/cxl.h       |  2 ++
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3b818adbd38b..0584245b30f2 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -958,6 +958,15 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return rc;
 
+	/*
+	 * Create einj_types from here as well, so the file also shows up when
+	 * cxl_acpi is a module loaded after EINJ, and on systems where the
+	 * CEDT is parsed but no dport is ever added (no CHBS for the host
+	 * bridge, or a CHBS without a valid component register base), which
+	 * leaves the dport probe path untouched.
+	 */
+	cxl_debugfs_einj_add_types();
+
 	/* In case PCI is scanned before ACPI re-trigger memdev attach */
 	cxl_bus_rescan();
 	return 0;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..76ac612b514c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -802,6 +802,35 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 
 DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
 
+static struct dentry *cxl_debugfs;
+static struct dentry *einj_types_dentry;
+
+/*
+ * einj_types can only be created once EINJ is up, and no single hook is
+ * reached after that point in every configuration:
+ *
+ *  - cxl_core_init() runs at subsys_initcall level and cxl_acpi_probe() at
+ *    subsys_initcall_sync level, so both create the file when cxl_core and
+ *    cxl_acpi are modules loaded after EINJ has been initialized;
+ *  - when EINJ is built in, einj_init() runs at device_initcall level, so
+ *    both of them are too early and the only hook left is the dport added
+ *    from the memdev probe.
+ *
+ * The dport probe path can run concurrently for different parent ports, each
+ * holding only its own device lock, so the check and the create need to be
+ * serialized to avoid a duplicate debugfs_create_file() attempt.
+ */
+static DEFINE_MUTEX(einj_types_lock);
+void cxl_debugfs_einj_add_types(void)
+{
+	guard(mutex)(&einj_types_lock);
+	if (cxl_debugfs && !einj_types_dentry && einj_cxl_is_initialized())
+		einj_types_dentry = debugfs_create_file("einj_types", 0400,
+							cxl_debugfs, NULL,
+							&einj_cxl_available_error_type_fops);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_debugfs_einj_add_types, "cxl_acpi");
+
 static int cxl_einj_inject(void *data, u64 type)
 {
 	struct cxl_dport *dport = data;
@@ -822,6 +851,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 	if (!einj_cxl_is_initialized())
 		return;
 
+	cxl_debugfs_einj_add_types();
+
 	/*
 	 * Protocol error injection is only available for CXL 2.0+ root ports
 	 * and CXL 1.1 downstream ports
@@ -2501,8 +2532,6 @@ const struct bus_type cxl_bus_type = {
 };
 EXPORT_SYMBOL_NS_GPL(cxl_bus_type, "CXL");
 
-static struct dentry *cxl_debugfs;
-
 struct dentry *cxl_debugfs_create_dir(const char *dir)
 {
 	return debugfs_create_dir(dir, cxl_debugfs);
@@ -2515,10 +2544,6 @@ static __init int cxl_core_init(void)
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
 
-	if (einj_cxl_is_initialized())
-		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
-				    &einj_cxl_available_error_type_fops);
-
 	cxl_mbox_init();
 
 	rc = cxl_memdev_init();
@@ -2541,6 +2566,8 @@ static __init int cxl_core_init(void)
 
 	cxl_ras_init();
 
+	cxl_debugfs_einj_add_types();
+
 	return 0;
 
 err_region:
@@ -2560,6 +2587,8 @@ static void cxl_core_exit(void)
 	destroy_workqueue(cxl_bus_wq);
 	cxl_memdev_exit();
 	debugfs_remove_recursive(cxl_debugfs);
+	cxl_debugfs = NULL;
+	einj_types_dentry = NULL;
 }
 
 subsys_initcall(cxl_core_init);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cab8ce39f465..b9245261ee39 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -926,4 +926,6 @@ struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
 
 u16 cxl_gpf_get_dvsec(struct device *dev);
 
+void cxl_debugfs_einj_add_types(void);
+
 #endif /* __CXL_H__ */
-- 
2.25.1

