Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049677;
	b=y8awZPZPDH0myH5PW6BwxG8wpymdov2cUcrN9z4XzRejJAoB8nRcqDXAFiuF6nD75m4/
	 L8xw+Y9VkIvSwSgKKlEHhTEsWdDcMHWzlIQb05y7TeIk9j88LvvemXS05gcg2Bk0J1sS8
	 E2AeoSzV+vf3W3E9wiiUsE7cAOPsIrQJSDcRam/9PMD8stk9qsmFurH+rl+9ecGWtmUXV
	 wpNeyl62OP03S/4aN40hmfznKHpuO7MrdFBFK0Ubo0Yd/MJ+kxPAAm4HWO285JdfEAFkk
	 /IwSWsgm7FjOKcqsKYn1pDeR/6R1hS/2dg1hXhkjf2nD5q32u25SWTmlfYwBx5cAICQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049677;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MVGagyXqrwdo7dH2O8hLICXoxaxNUg6CLkCz21qglC0=;
	b=JrsFR2HS22pxh0+Smai5Vye48lxi10S9zaLJsyber9WjN97JqNoYVd6JN4Hyb46b1suh
	 yzdi3RsFvP0Mh63qR3sEvpsXJxcOdNXj5tbWU89rijmlx2raJOvU8GqsXYE9ZQGFUV1fh
	 VKOPqqn6JNogDJIxdHhY8rytKqqfnE1quKbAhy2iZ9BK4VZL7jEJUI4HVa7r1qkatCfnl
	 l5rOtbQumgK31X+dOH0lERH9S2b21K8buATRArbsHxcAlvB4BgPx14NCvJxvb/l+fS972
	 +t75HZ54hT5MzvUtGKQf1csbSBFsDy8HDL499614mKOg1gLlKtbSVxnE8f6v7LfNt4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=yAsIEfaj;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9010606A320;
	Thu, 19 Nov 2026 00:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9010606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=yAsIEfaj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795049664; bh=MVGagyXqrwdo7dH2O8hLICXoxaxNUg6CLkCz21qglC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yAsIEfajW107SmrTKjNjPhJLH+X/+VSNGrrzfo2H7TPbThBRHjbF5aeQloG7dqN5+
	 5gq93499ydiV26drT5SfrsXYz1OM8V7fUi71tCpKyeYG4+qUntKpkjH/aMGNkTUltS
	 y5uraQTcCkQ129l2UoWSXWrGxqk44A6uPNlDz6Jo=
Received: from localhost.localdomain ([59.46.81.208])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id D9612A37; Thu, 19 Nov 2026 08:54:22 +0800
X-QQ-mid: xmsmtpt1795049662tfile5mo1
Message-ID: <tencent_F0BECCFBD52CC861F260A0F6169273C41209@qq.com>
X-QQ-XMAILINFO: OSjQccS6YHkHyle7B+8Ip3eSzrvH5Q03e6f89n8ZGPjwggK8/4mkkisve2dTR6
	 DByaM+B2SpJK5E0zgA/a7IDdyLsFMGFZP+TQ3b+9NgZJfxPaP4oBzdtwRjPu4lZvJ0qXERrS5pW4
	 aCQrpNMuKYux8gxYDASf4+GrGGD4UFyi5oZi7NCSuq1rTeWubSe6lf9gVJlSBm7bN6iHN8orUj3F
	 A2MgCsxVYNYyPijKjE2G7R8eVsFo6asqhgsrePDIYRsplCYi0prARe2pDFHeYEcqa4aiLzxCD+Xc
	 gCJ3XH02GnKCEv0W9ISJHdPALaR2Ejc/cY5tX5pPbqmF3GUClWm4O7Xr/XnQltu/fQonsbsTDKei
	 T4eugew9RyA6tj2+RKKG7NAVwVRA03iO5Hyfx6ESsYLsTeWkViRtnY5akaT4q7JJ/AJOd4PL1ONG
	 qOWgoDDMPeKheXjasPgIG58CHNfrSLhdb+gkPhIX2BAvD7p393HPWaCGlmGsHZnWmBiqdL1mirjO
	 jXOVXRtITQhtQ+vqhsxLl3CdOzU2TNuZ/l7NDUUKrvNVW5Mv0IMHmTXoq3KtM1lhAmvhDJxfB1H6
	 UCvtrMyIFz9LjSWju5c+APVJSIvqytKWPO4t/x3exij4PdSb7EGTEEwQk5OcaRHV71MzaOdVblPz
	 ZqygC87LBf7NgVCJXBQSr7wDuJx8hRLEi9l56BwnCJBKjb0TxNWWjCMFZvMn7HBCFtnnGoL0Lddd
	 oYBUzO8nJlugT7AfeTMnZdjSTnllQvyrCgN3BHEs4Ub3hcODgrWlQjb6KIwSkbU84WrSg738Qtk/
	 JdWTiz2PFZnk+5ytXR+mwWn02jO2odseFL1O6iqn8i8nusARhsw6Te1HgsoS0YGu/lrPmDxl9Q/b
	 7mOMtsXw5nEtJvdnmBjvJEr9Ls1XnhwB4skWMGHiSEnDp7F9/CBehRRIcD4zRuUQhPy0YdWwVJMT
	 CS15sNK5TuRnq5l7VaIoAjvu46Bmm0wHfIiesgJd5E844aeKDmrDFhFonpsctZtnRC/O31kaej3c
	 cZxiKxPpGui3u7Mu1CZ4gYfVifpYQ=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Lei Qiu <750592120@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] hfs/hfsplus: validate uid and gid mount options
Date: Thu, 19 Nov 2026 08:54:20 +0800
X-OQ-MSGID: <20261119005420.35222-1-750592120@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <85c26064db32f34da57b313a2e5d505f60ad1df4.camel@dubeyko.com>
References: <85c26064db32f34da57b313a2e5d505f60ad1df4.camel@dubeyko.com>
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

The conversions to the new mount API declare uid and gid as fsparam_u32
but consume result.uid and result.gid. This bypasses make_kuid() and
make_kgid() as well as the validity checks in the old parsers. As a
result, both filesystems accept the invalid ID 4294967295, and IDs
supplied through fsconfig() in a non-initial user namespace are treated
as raw kernel IDs instead of being translated through that namespace.

Use fsparam_uid and fsparam_gid so the shared parser translates the IDs
and rejects invalid or unmapped values before storing the typed result.

Verify both modules with W=1 builds and a before/after QEMU test covering
fsconfig(), legacy mounts, and a filesystem context configured from a
user namespace mapping ID 0 to ID 1000. The fix rejects invalid IDs with
EINVAL and preserves the mapped ownership and valid mount options.

OpenAI Codex assisted with identifying the issue, implementing the fix
and reproducer, and running the validation.

Fixes: ffcd06b6d13b ("hfs: convert hfs to use the new mount api")
Fixes: 432f7c78cb00 ("hfsplus: convert hfsplus to use the new mount api")
Cc: stable@vger.kernel.org
Signed-off-by: Lei Qiu <750592120@qq.com>
---
Changes since v2: drop the build.log artifact that was accidentally
included in the patch; no functional change.
Changes since v1: realigned the new fsparam_uid/gid entries with the
existing column style in both option tables (no functional change).
---
 fs/hfs/super.c       | 4 ++--
 fs/hfsplus/options.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 5e6d66ff4..5ff04a7c4 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -203,8 +203,8 @@ enum {
 };
 
 static const struct fs_parameter_spec hfs_param_spec[] = {
-	fsparam_u32	("uid",		opt_uid),
-	fsparam_u32	("gid",		opt_gid),
+	fsparam_uid	("uid",		opt_uid),
+	fsparam_gid	("gid",		opt_gid),
 	fsparam_u32oct	("umask",	opt_umask),
 	fsparam_u32oct	("file_umask",	opt_file_umask),
 	fsparam_u32oct	("dir_umask",	opt_dir_umask),
diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
index 9b377481f..28717b6c7 100644
--- a/fs/hfsplus/options.c
+++ b/fs/hfsplus/options.c
@@ -33,8 +33,8 @@ static const struct fs_parameter_spec hfs_param_spec[] = {
 	fsparam_string	("creator",	opt_creator),
 	fsparam_string	("type",	opt_type),
 	fsparam_u32oct	("umask",	opt_umask),
-	fsparam_u32	("uid",		opt_uid),
-	fsparam_u32	("gid",		opt_gid),
+	fsparam_uid	("uid",		opt_uid),
+	fsparam_gid	("gid",		opt_gid),
 	fsparam_u32	("part",	opt_part),
 	fsparam_u32	("session",	opt_session),
 	fsparam_string	("nls",		opt_nls),
-- 
2.43.0

