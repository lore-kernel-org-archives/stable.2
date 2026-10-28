Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166792;
	b=JEvmDHb01+RPkCQOaWmqheqmsbV3+gDxzMZeXnt0VvCDlFYi7+P3GYiD03/ImklUq2Nl
	 w5C6ycgyH+hnnLuQPkoUSLaGZHHi22GMgMWnUX7h5EF6iKvQ0oUQ2dtwREG86Puk+BaPs
	 JoLn+/UURmzDti/sVfP8s6eYWXLNf+TGnZXzWdLd8cBo5PGqLkhktyRvClK7SFQNOhiYV
	 BgKb9eJlme/L450uTwhqdfs8zEjdEMcPemL5N+/VBKv0XMSZzV6ZNeaU5nRCRStU3CHg7
	 MQ1T+v1CIvc9jmgEjLlbXA3TXxXmbm2Fo372CCSuh83krbevSxNtbPr4ongaUX/IjEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166792;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:Sender:X-CM-SenderInfo;
	bh=gS2AMFJs3oFtyBSm2RKJOJAdZEycyNVD9u0HcQSd0n4=;
	b=B9qpSDdKbmrjqqz7te8IpHo4z4Jcimd972Fsb1n+rhEdZtS84lgFQlTnUswVH8aupxFK
	 iESHrXtFhygoZGZj1cwUJno4j1TyRLQqUasNpyEgCf650bzam6Xf4Cd4QqddNiloHMJBY
	 EewIArxKNoIVEiL4JRvCiZBCiDYuV6lvvSOw5iYEA7vowkc1OVEBhxO0iRpKKxk+ZMY2Y
	 Um+/MzRVk1Cgnnwf/ihn7/EpGBMAZ6G42d5BcViCQZ1px16C2/Pc390L2QpXYVbrnzR7d
	 uCeznd1naC+NmX4exK8svS5op6W0zQCQHwBQKFGeb5OX/TkYfumE5byX1/V/0D4h+Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BmsbE5kc;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AAD606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 05:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0AAD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BmsbE5kc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gS
	2AMFJs3oFtyBSm2RKJOJAdZEycyNVD9u0HcQSd0n4=; b=BmsbE5kcGELYv3Bkyy
	vUDYgsNW5SkTJNtQaeHmzfFXvzFFLaiSHo9v2wvLOc44SvbnFTKiVv4LY6uK6Thz
	Rhg4TMZa4EZ6C3Iol0WfNfTFh9kH37Aa1mF/JU+Vxsf7p/W8pS3m9YW0M4Fsjlki
	yYttu9212uMcR7s7jbqJOp2AU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3f_W9jeFqH9PUDA--.19060S2;
	Wed, 28 Oct 2026 13:53:02 +0800 (CST)
From: Yongxin Yang <yangyongxin@kylinos.cn>
To: yangyongxin@kylinos.cn
Cc: stable@vger.kernel.org
Subject: [PATCH] cxl/core: Create einj_types when EINJ becomes available
Date: Wed, 28 Oct 2026 13:52:57 +0800
Message-Id: <20261028055257.1625148-1-yangyongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wD3f_W9jeFqH9PUDA--.19060S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAry7Cry8KrW5GF1UGry7GFg_yoW5Cr47pa
	1UGrn5Cr48Aay3Cr9xArWUX34S9rWkW3yDAryrW34ayanrCrn8tF1kJayY9a4DWFWUJryF
	v3WYyr1DGw1xAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRiZ2hUUUUU=
Sender: yang_yongxin123@163.com
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbC-x6lQ2rhjb5pZgAA3w

From: Yang Yongxin <yangyongxin@kylinos.cn>

The einj_types file under the CXL debugfs directory is never created.

cxl_core_init() runs at subsys_initcall level, while EINJ registers itself
from einj_init() at module_init level. When cxl_core_init() evaluates
einj_cxl_is_initialized() the EINJ driver has not been initialized yet, so
the value is always false and the debugfs_create_file("einj_types") call
below it is never reached. Users have no way to discover which CXL error
types the platform supports from debugfs.

Create the file lazily, from the first place where EINJ is known to be up.
Note that this is a partial fix: if no injectable dport is ever added, the
file still does not appear. Fixing the initcall ordering itself would
require moving cxl_core_init() after EINJ is probed, which risks the CXL
bus registration order, so it is left out of scope here.

Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
Cc: <stable@vger.kernel.org>
Signed-off-by: Yang Yongxin <yangyongxin@kylinos.cn>
---
 drivers/cxl/core/port.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..7de08063469f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -802,6 +802,27 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 
 DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
 
+static struct dentry *cxl_debugfs;
+static struct dentry *einj_types_dentry;
+
+/*
+ * einj_types cannot be created from cxl_core_init(): that runs at
+ * subsys_initcall level, before einj_init() has set einj_initialized.
+ * Create it lazily, from the first place where EINJ is known to be up.
+ */
+static void cxl_einj_debugfs_add_types(void)
+{
+	if (einj_types_dentry)
+		return;
+
+	if (!einj_cxl_is_initialized())
+		return;
+
+	einj_types_dentry = debugfs_create_file("einj_types", 0400, cxl_debugfs,
+						NULL,
+						&einj_cxl_available_error_type_fops);
+}
+
 static int cxl_einj_inject(void *data, u64 type)
 {
 	struct cxl_dport *dport = data;
@@ -819,6 +840,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 	struct cxl_port *parent = parent_port_of(dport->port);
 	struct dentry *dir;
 
+	cxl_einj_debugfs_add_types();
+
 	if (!einj_cxl_is_initialized())
 		return;
 
@@ -2501,8 +2524,6 @@ const struct bus_type cxl_bus_type = {
 };
 EXPORT_SYMBOL_NS_GPL(cxl_bus_type, "CXL");
 
-static struct dentry *cxl_debugfs;
-
 struct dentry *cxl_debugfs_create_dir(const char *dir)
 {
 	return debugfs_create_dir(dir, cxl_debugfs);
@@ -2515,10 +2536,6 @@ static __init int cxl_core_init(void)
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
 
-	if (einj_cxl_is_initialized())
-		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
-				    &einj_cxl_available_error_type_fops);
-
 	cxl_mbox_init();
 
 	rc = cxl_memdev_init();
-- 
2.25.1

