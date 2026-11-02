Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793589944;
	b=x6x7UyBRXkpveEsA71sb+AG9rHsoProwGAhT6BNCAx7zE0QHOemC7JOu0rPNAn/W4pYY
	 coLh0JnQvvR/5KQEv4+uAOfs9evFoD6k7S2PoHhIyLKR+kd0aD4wwAZI3wn6itqV8q+Md
	 ujyXshIoY4n5bD6EbZ+oi++QqfiWlnKKhJayE28TfczXBMYPooOAM7htvDLapU66nFeby
	 1UxpaBGMCDpzUS5HyZKMLvMjTqYdRTvAOvwVIDla+ku/qUGGEX8EV2Yb5g+Q3rQAhvqc8
	 BdT8a2W1FkeSS8RBh230ejhaaZoC36EyXJiyzfibEJ5d7KNb8cbtFFfIHnr/2zjto/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793589944;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:Sender:X-CM-SenderInfo;
	bh=veZDpRBvsFIvF/XJwen4k9bmxlWJry4e0api1yU19lY=;
	b=kGEkcfQwlS5mDhdStaWZ8vKJE4ZH8ont7aUaca2ubC339tb4pqmyh67LaeLTR3EvwSsn
	 0F9iXRhzlMfGCdFd1W7ktmZzSCHqnPdo3enawWftD999Teso6FaNcv6jRiyo7tsrkj9u3
	 Cqm3s0+I6ply/aH8lgFjxPl4T0l75Bh6+0x9QSG1Ws+MfvF7Rfmsn6GWPkXPO/3BtxmCM
	 jEzxq6LiamLMAytu2dpR4qI5cKSX5Ui/4Myq/r66dZvVEOTKYq0xVt5eRNGUvn7elZkhH
	 a4FIitOVuGKhBK0mbkJRt8ZMfjNiEe6QogKbIM0MuB+xEOfagbPxFuuQUg8YNQBIZCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hurb2bK1;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83697606A324;
	Mon,  2 Nov 2026 03:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83697606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hurb2bK1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ve
	ZDpRBvsFIvF/XJwen4k9bmxlWJry4e0api1yU19lY=; b=hurb2bK1wnF/7c1yiM
	Qd+ryg1SzmOwRJdYq8Z4ImzlMSv18EA8wEmL6GktXhkA2yzv5qZuTEhxmHiVflFj
	7ZxiH4l2vZdt5jTMzYnOMmcJ/jYQ9vDNyxUPMzF/qdSMrFv68U4IhsgrCDnUC+zu
	7lhpyHbWNmAUDHLA8u+j+8pB0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDX30V0AuhqjnIJDg--.46362S2;
	Mon, 02 Nov 2026 11:24:45 +0800 (CST)
From: Yongxin Yang <yangyongxin@kylinos.cn>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yongxin Yang <yangyongxin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v5] cxl/core: Create einj_types regardless of EINJ init order
Date: Mon,  2 Nov 2026 11:24:36 +0800
Message-Id: <20261102032436.230945-1-yangyongxin@kylinos.cn>
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
X-CM-TRANSID:PigvCgDX30V0AuhqjnIJDg--.46362S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFykZrWxXrW8WrykWw4fuFg_yoWrJw1fpa
	yDurnYyrykAF4IyrsxA34UZa4Fgws5WayDCryDW343Zan8urnYyF10yFWY9a1kGFWkJa40
	qwn8Ar12kayjkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5KsUUUUUU=
Sender: yang_yongxin123@163.com
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbDAB50EmroAn4PiQAA3A

The einj_types file under the CXL debugfs directory is never created when
cxl_core is built in.  cxl_core_init() runs at subsys_initcall level, while
einj_init() registers EINJ at device_initcall level, so the
einj_cxl_is_initialized() check in cxl_core_init() always sees EINJ as not
up yet and the debugfs_create_file() below it is never reached.  With
cxl_core as a module, module dependencies make sure it is loaded after EINJ
is up and the file is created.

Create the file unconditionally instead, gated only on the CXL error
injection support being compiled in, and have
einj_cxl_available_error_type_show() return -ENODEV until EINJ is up.  This
single check in cxl_core_init() covers every combination of built-in and
modular cxl_core, cxl_acpi and EINJ, with no extra hooks.

The check in the show callback is required, not cosmetic: einj_tab is
NULL until einj_init() runs, so einj_get_available_error_type() would
dereference a NULL pointer.

This restores the discovery of the supported error types only.  On a fully
built-in RCH/RCD hierarchy the inject files below the dport directory are
still not created: cxl_debugfs_create_dport_dir() has the same early return
and the only dport there comes from cxl_acpi_probe() at
subsys_initcall_sync level, before EINJ is up.

Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
Cc: <stable@vger.kernel.org>
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Suggested-by: Ben Cheatham <benjamin.cheatham@amd.com>
Link: https://lore.kernel.org/all/de14c4ef-e3d8-432f-9ce8-87c468d6d2ad@amd.com/
Link: https://lore.kernel.org/all/7a22cc6a-deba-40e6-8033-97d1234420ba@amd.com/
Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>
---
Changes in v5:
- Rework per Dave's suggestion, agreed by Ben: create einj_types from
  cxl_core_init() without looking at the runtime EINJ state, and return
  -ENODEV from einj_cxl_available_error_type_show() while EINJ is not
  initialized, instead of creating the file from three separate hooks.
  This drops the mutex, the exported helper and the cached dentry.
- Drop the cxl_acpi_probe() hook: host bridge dports, RCH included, already
  go through __devm_cxl_add_dport() -> cxl_debugfs_create_dport_dir() in the
  same probe, so the hook added nothing.
- Gate the creation on CONFIG_ACPI_APEI_EINJ_CXL rather than on the runtime
  EINJ state.
- Dropped the Reviewed-by tag as the approach changed significantly.

 drivers/acpi/apei/einj-cxl.c | 4 ++++
 drivers/cxl/core/port.c      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index e70a416ec925..3090c7649ed2 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -30,6 +30,10 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
 	int cxl_err, rc;
 	u32 available_error_type = 0;
 
+	/* einj_tab stays NULL until EINJ is initialized, don't read it. */
+	if (!einj_cxl_is_initialized())
+		return -ENODEV;
+
 	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..d4ed1cc7c480 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2515,7 +2515,7 @@ static __init int cxl_core_init(void)
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
 
-	if (einj_cxl_is_initialized())
+	if (IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL))
 		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
 				    &einj_cxl_available_error_type_fops);
 
-- 
2.25.1

