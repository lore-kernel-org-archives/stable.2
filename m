Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330490;
	b=AFGYD8bUBPnw+0Bcc+nMOgnW0mQgg8BHEyfVOqTXbe6wNKaafG9SM/E+iMkq/cG/ruNR
	 9ohve4fECcC/Pd3Tjpd1U/wNwELlilMG89lV0Dn6hLKRZz+iccOEGA6f8rpL2wc4BT0qT
	 ++4lgprzfu7YZs1EUW4VO8pl1n0NESo6iEIL/OPZsHTj1GfjQVwxgFyHjfGU7XqPg2RSi
	 J32dojhcOGKWadzxHDP7fLILnSly9AF6bvOo0/Ged4aZhGzJ7mbvtHAX6jPnCp++8u/9O
	 S3lgscq5IC0Kq0dXv78rC/JGPJ2jLAHODI8BoZ5YvWkU1YgeMPuYXZc8m08e+dzRIlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330490;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=JmkOB8tNSigulUXFtOqEYD/RkVQB6sEM6Wu02clX6Gw=;
	b=QDUgNyMMvLrSNH/nyFwTIu/+Z0PxVoRA+xZxdcJXqRS99GblVdM/5rqZ/uTfoXBd0qtN
	 mrM72ctt0BXCYeomwccJYEP7kNPvzofazVuaihqBY4LkUIlzKsEUwlcJx98OUvzxaVe7K
	 4NeDtxc76L1KrVufnAGwNNxI1yDtYZBzkzxXUgSWjFunUJsXp63DB5Wlem8sMCac7xQvw
	 KB+7a/oP6obAA9AGafY2X4JwEs8+VvkuS+HaWW6xaMTInAjE+e66KKqG4k0MG1gQR3TVm
	 hygJaDYmY1X+bY9hlBU1zXKxYRZ7gXxekaREfZ1Dyp25VI+MVXMhyaoE1GbtIcYjOQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cQm9hK4T;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C81606A31C;
	Fri, 30 Oct 2026 03:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4C81606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cQm9hK4T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Jm
	kOB8tNSigulUXFtOqEYD/RkVQB6sEM6Wu02clX6Gw=; b=cQm9hK4TVVVjYBC+9H
	t66K9i1+bzOKFu/XqT0V5GvG/MoXCoGvSvRIn5rX+8DiNQjPsGODojORNAX1c7hE
	enLH4xgGzVCx4ueEm7BRjU5tQIwOd6pSu/jy9bTPoanZ92qIawTmmgBOrcFOunoI
	9IgVE0cuKtDHrnrospMO4EotU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD314ASDeRqZppBDw--.51113S2;
	Fri, 30 Oct 2026 11:20:52 +0800 (CST)
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
Subject: [PATCH v4] cxl/core: Create einj_types when EINJ becomes available
Date: Fri, 30 Oct 2026 11:20:50 +0800
Message-Id: <20261030032050.787682-1-yangyongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261029065629.333949-1-yangyongxin@kylinos.cn>
References: <20261029065629.333949-1-yangyongxin@kylinos.cn>
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
X-CM-TRANSID:_____wD314ASDeRqZppBDw--.51113S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr43tw4DGFyfGw1xJw4xZwb_yoWxCr1xpa
	98Gr1rCr4kCayfAr43A34UJ34rW3ykW3srCFyku343Za1DCr15tFyDAFWY9FWDGFW8JF10
	q3WYyFyUG34jyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UkWrZUUUUU=
Sender: yang_yongxin123@163.com
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbC5BYcuWrkDRZtdQAA3a

From: Yang Yongxin <yangyongxin@kylinos.cn>

The einj_types file under the CXL debugfs directory is never created when
cxl_core is built in.

cxl_core_init() runs at subsys_initcall level, while EINJ registers itself
from einj_init() at device_initcall level. With cxl_core built in, the
einj_cxl_is_initialized() check in cxl_core_init() therefore always sees
false and the debugfs_create_file("einj_types") call below it is never
reached, so users have no way to discover which CXL error types the
platform supports from debugfs. When cxl_core is a module, module
dependencies make sure it is loaded after EINJ is up, and the file is
created.

Create the file from every point that can tell EINJ is up. cxl_core_init()
covers cxl_core being a module loaded after EINJ has been initialized. The
cxl_acpi_probe() hook covers cxl_core being built in while cxl_acpi is a
module, and is the only hook that can work on RCH/RCD hierarchies, where
the single dport is added by the ACPI probe itself, too early to help. The
dport probe path covers the built-in virtual host case, where the dport
added from the memdev probe is the only hook reached after einj_init().

The dport probe path can run concurrently for different parent ports, each
holding only its own device lock, so serialize the check and the create to
avoid a duplicate debugfs_create_file() attempt that would only fail with
-EEXIST. Reset the cached dentry in cxl_core_exit() so that reloading
cxl_core starts from a clean state.

Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/all/de14c4ef-e3d8-432f-9ce8-87c468d6d2ad@amd.com/
Link: https://lore.kernel.org/all/7a22cc6a-deba-40e6-8033-97d1234420ba@amd.com/
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Signed-off-by: Yang Yongxin <yangyongxin@kylinos.cn>
---
Changes in v4:
- Scope the problem statement to the built-in case: the file is only never
  created when cxl_core is built in, the module dependencies take care of the
  ordering otherwise.
- Replace the "no dport is ever added" rationale with the RCH/RCD case, in
  the changelog and in the cxl_acpi_probe() comment: a system without any
  dport cannot do error injection at all, so the file is useless there. On
  RCH/RCD hierarchies the only dport comes from the ACPI probe, so this hook
  is the one that matters.

 drivers/cxl/acpi.c      |  9 +++++++++
 drivers/cxl/core/port.c | 41 +++++++++++++++++++++++++++++++++++------
 drivers/cxl/cxl.h       |  2 ++
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3b818adbd38b..ca7741203740 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -958,6 +958,15 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return rc;
 
+	/*
+	 * Create einj_types from here as well: with cxl_core built in,
+	 * cxl_core_init() runs before EINJ is up, so when cxl_acpi is a module
+	 * loaded afterwards this is the only hook that can create the file,
+	 * including on RCH/RCD hierarchies, where the single dport is added by
+	 * this probe itself and cannot help.
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

