Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177457;
	b=QuktvT0vykQjIw07PwcOIbC+v3geO0h3Q84qD+0ipUzTsXtWj7FrdqCT4wpP0oBC1COD
	 gzHDzaYrEstLIzDAFhG2nBkST4ClglQEeyi8jFDoWntxHh/XmngPsOqJitEFFsdEeHgGf
	 4mms0ZYUvvkLkSByWU665OM78goQ2fnkWHBX6bzUhnThm4lQaldWVPh7WP02wd8g1bGY4
	 qfAveHOF2MUPovj6PZE2TmJ+LrUqreBvBc9KD+NPaEoC+YQLk9skLUXU8eZA+YrOvSXPo
	 jeXEL/oLA4VXDXWkmwNKlpH+HxKifCkVgms/O+p2o1B1m1Na/LReGIAI76sdUovCsLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177457;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=5iohBM+GgU9IICAeS2iaT4fIHKg4GUrBEZRaogQUUjQ=;
	b=CIQVvtOmsEeBeN24vOAcG3rbj4+L+gJZFxJsoq3OcMJNpvyT9xUOtdv7xBGgyddgRvdl
	 0aItmK07nmi186idnb+x1LBlhUPqYQjEXfLqlZzLV0d8IKwzeW2XdOuc35PYL2uomZd2Q
	 M+jDw9NzSbIqO2TljqIDLjXdGNom/A1tBqObhp5UUQpRXj69j/pSxXJDnXyX1uzCFlovW
	 x2jInRAjbk7egwN5Q9gVhHTxLwPsza5OSSRMvl7X5limY1yi9TSV53J8fusT69ob5j7wE
	 OrPG0yLVIlYvB4WvP2BqQXJa9npqKN4PkTHGK31wUeGxLFADOzMIttoySVLiU+Gnq5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FLQhd4FH;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C774B606A31A;
	Wed, 28 Oct 2026 08:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C774B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FLQhd4FH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5i
	ohBM+GgU9IICAeS2iaT4fIHKg4GUrBEZRaogQUUjQ=; b=FLQhd4FHy1z5zA9bUG
	OjI+qnr1CzNxzeQ5XvHvA7bZRwG+B5ang75+gClvSbJ6Deip+rxtTvWmKMX+PcrK
	aQCqbgFzwlBS7Bv+Kl58iMnwMdXLMoZOfWurdp4+HGCyfEVjve0MSB5Ipy3dID3u
	j+MwbuIWKShJ9y19QnVanBQm0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnPxIgt+FqDMOJDQ--.49242S2;
	Wed, 28 Oct 2026 16:49:38 +0800 (CST)
From: Yongxin Yang <yangyongxin@kylinos.cn>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <djbw@kernel.org>,
	Ira Weiny <ira.weiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yang Yongxin <yangyongxin@kylinos.cn>
Subject: [PATCH v2] cxl/core: Create einj_types when EINJ becomes available
Date: Wed, 28 Oct 2026 16:49:34 +0800
Message-Id: <20261028084934.1735010-1-yangyongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261028055401.1626640-1-yangyongxin@kylinos.cn>
References: <20261028055401.1626640-1-yangyongxin@kylinos.cn>
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
X-CM-TRANSID:_____wDnPxIgt+FqDMOJDQ--.49242S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFW8tr1fGryfurW7ZF4rAFb_yoWruFy8pa
	y5Grn8Gr4kCa4xCF9xAryUXw1F93ykW3yDAr95W34aya1Durn8tF1DCFWY9a4DGFWUJryF
	q3WYyryUGw1jyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgNV9UUUUU=
Sender: yang_yongxin123@163.com
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbDAAIJpmrhtyJOTQAA3w

From: Yang Yongxin <yangyongxin@kylinos.cn>

The einj_types file under the CXL debugfs directory is never created.

cxl_core_init() runs at subsys_initcall level, while EINJ registers itself
from einj_init() at module_init level. When cxl_core_init() evaluates
einj_cxl_is_initialized() the built-in EINJ driver has not been initialized
yet, so the value is always false and the debugfs_create_file("einj_types")
call below it is never reached. Users have no way to discover which CXL
error types the platform supports from debugfs.

Create the file from both places that can know EINJ is up: cxl_core_init(),
which covers the case where cxl_core is a module and einj has already been
initialized by the time the module is loaded, and the dport probe path,
which covers the built-in case. The dport probe path can run concurrently
for different parent ports, each holding only its own device lock, so
serialize the check and the create to avoid a duplicate
debugfs_create_file() attempt that would only fail with -EEXIST.

Note that this is still a partial fix: an RCH platform returns early from
devm_cxl_enumerate_ports() before any dport is added, so einj_types does
not appear there. Fixing that requires moving cxl_core_init() after EINJ
is probed, or creating the file from cxl_acpi_probe(), both of which are
out of scope here.

Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
Cc: <stable@vger.kernel.org>
Signed-off-by: Yang Yongxin <yangyongxin@kylinos.cn>
---
Changes in v2:
- Create einj_types from cxl_core_init() as well, so that the module case,
  where einj is already initialized when cxl_core is loaded, keeps working
  and is not regressed by the lazy path alone.
- Serialize the check and the create with a mutex, as the dport probe path
  can run concurrently for different parent ports.
- Spell out that RCH platforms are still not covered, and why.
- Rebase onto mainline, so the diff no longer carries the CXL fixes that
  are queued in linux-next.

 drivers/cxl/core/port.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..c1736a00f22f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -802,6 +802,30 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 
 DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
 
+static struct dentry *cxl_debugfs;
+static struct dentry *einj_types_dentry;
+
+/*
+ * einj_types is created from two places: cxl_core_init() catches the case
+ * where cxl_core is a module and einj is already up, while the dport probe
+ * path catches the built-in case, where cxl_core_init() runs at
+ * subsys_initcall level before einj_init() has set einj_initialized.
+ *
+ * The dport probe path can run concurrently for different parent ports, each
+ * holding only its own device lock, so the check and the create need to be
+ * serialized to avoid a duplicate debugfs_create_file() attempt.
+ */
+static DEFINE_MUTEX(einj_types_lock);
+static void cxl_einj_debugfs_add_types(void)
+{
+	mutex_lock(&einj_types_lock);
+	if (!einj_types_dentry && einj_cxl_is_initialized())
+		einj_types_dentry = debugfs_create_file("einj_types", 0400,
+							cxl_debugfs, NULL,
+							&einj_cxl_available_error_type_fops);
+	mutex_unlock(&einj_types_lock);
+}
+
 static int cxl_einj_inject(void *data, u64 type)
 {
 	struct cxl_dport *dport = data;
@@ -819,6 +843,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 	struct cxl_port *parent = parent_port_of(dport->port);
 	struct dentry *dir;
 
+	cxl_einj_debugfs_add_types();
+
 	if (!einj_cxl_is_initialized())
 		return;
 
@@ -2501,8 +2527,6 @@ const struct bus_type cxl_bus_type = {
 };
 EXPORT_SYMBOL_NS_GPL(cxl_bus_type, "CXL");
 
-static struct dentry *cxl_debugfs;
-
 struct dentry *cxl_debugfs_create_dir(const char *dir)
 {
 	return debugfs_create_dir(dir, cxl_debugfs);
@@ -2515,10 +2539,6 @@ static __init int cxl_core_init(void)
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
 
-	if (einj_cxl_is_initialized())
-		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
-				    &einj_cxl_available_error_type_fops);
-
 	cxl_mbox_init();
 
 	rc = cxl_memdev_init();
@@ -2541,6 +2561,8 @@ static __init int cxl_core_init(void)
 
 	cxl_ras_init();
 
+	cxl_einj_debugfs_add_types();
+
 	return 0;
 
 err_region:
-- 
2.25.1

