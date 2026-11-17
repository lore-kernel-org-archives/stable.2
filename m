Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794883495;
	b=fKAbhNDsXYKOAIgXhH5y3+VEC1OvB+mz5UHzopfO1z+e8w9X1CudSkRxrrBxZKoPisIl
	 TtQYN9Ukqoo5HenAGpm/BafLVmRNLpcYSmgCwJL+Y84/13pqC10d4jivztLllGZQ3RLSL
	 119Xa6YJQIUU9g5jlXsW343Els6KF+wMz8SN5PepaQTvvBaMUABRhSuq4HGuJSTleXOkv
	 +QF8/9dJKdv+jyBTFRmD6VlgMTrwRVwx14wDApnh4DD8GM7513M45+XAnWm6EmjPmuBAy
	 YeKUub8wRNMzKB4HTTDGQfpz1nd6NUa6wP8w7+jLgIyIf7/zGtIpT88ny9V5zqlSYYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883495;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OsgGTvr772vYOa31xQAPV2HCrq/fmpKBdM5EQit4rQw=;
	b=bZ5Uhxi69/U9rTuyGQJslIzZ1wO5KGg1UzzEBNVoi+eaOAlpo6/XbtjtNyqtMdp5YMly
	 AMKOB4Y7F3IKWQY+wLwwaiyo/Qu2BPqYauRd8C9KGNRVmknsIPFU6+Avnnt+PVcBUNOkO
	 c0u3k6KVbyjndxCzH/5OwwqYjK5iLsqGB90NEsGjyRA2HNIhcXbxjqhQ/we0i6EVdxw3x
	 ShIYOhbQtXW9WyLQxc7HogBf9DmXgwFPcrDrLvUohlmvzfCPyYS90Z5ilbiWkI7tMjvK3
	 ZB2LXLRIupwe0i31v+koKgwZ9KsPpo6O2cb0vRKDgKogs+avDUUE5yiKCQvDEkGFsdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=HLvlGzx8;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08824606A329;
	Tue, 17 Nov 2026 02:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08824606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=HLvlGzx8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794883490; bh=OsgGTvr772vYOa31xQAPV2HCrq/fmpKBdM5EQit4rQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HLvlGzx8EV49hPulzVLWNDBrWUKtqkp569jlI/JQE1mcJxKbom6lLA5zZbnfrBExe
	 sch/QuD3+h7uex2NWiJLM1B6YBQHwmya0zGQ8XumdXGJmFekg7UsE9+yov39i89ICf
	 Ho9IvNlZIUUKtSfvfkty/mvJVbEIr1+Iqa7Xhkgg=
Received: from localhost.localdomain ([59.46.81.208])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id B3006632; Tue, 17 Nov 2026 10:44:48 +0800
X-QQ-mid: xmsmtpt1794883488tblmikmdg
Message-ID: <tencent_4FE79C24049B83A9919143E7B141952DFC0A@qq.com>
X-QQ-XMAILINFO: M9x8kX0uaJjaodnrOs9iBTg8onBnzwmDeCmyoCBGqJ9WEAwGwlhKJXXL4ycKy2
	 vVSnexO+ycq4+G3+Cs4Ho8fhajY31RsyiShxVPaY/UxPllccYyMYRie8D0LRmDwoyrhcVaxOvfSa
	 ikKuYK9+GYWpAlLRTEAp8S/9PHFfHnefe3p9ibfojlib//2iEKowEhaX41R5V6S8u4Tslv0T6aH7
	 lPJbLrFgc072FZ5zStPNn/l9hwreHaOZ1vVR5HJ/7RMudP2oZS8Ky+G8h5q4mcU+lrKQ9c6eicjn
	 yO7+9PdMG+KiqEQCVwNO2IB/1+ppKR4t3ZkqTWCTV+oFh/4Xbmg966CVzdK1wEtbGDj8m4Ffevk4
	 vIJyNLLUtlq7OgIP2MOPMmtxtcScUFZFcmobo/4J/IcebPYS6Ss4FkAN1L7XCBRfu0epHhmAkIVm
	 wMfTHyWc/ownSoLHo8htkxy0uYWMyfL+mSwHOd7f0KgqvZpWVBWAHksfP01+T6r9GvyQWCK61loB
	 H6mY7h0yYKsxgxrAJ6ZCbUhRRBiEeGIxGS+8RJ3XCCwylXCBc/gXjzvBDDRgw8AfXIU/TR6qY2V4
	 +8qNRHtvbR3cX5//s6RBsJfY+L8zgJRRhF1EOSVSAlr4LJxeAudch92iM1q/0lYBkJX9RmDDQ5hW
	 V61sgrS+t3j6KujCaJGaoYj0O70aa6Iv7VFa1QbBIfuyP9+aGGHsUC5feNuy0UEM4H96a+8TacXg
	 V1Vtskd4KjAGfw/LXXF2PzV/HCsLaUVcDpI/63zu7TnsT5b03xmin14SRj3QUrB0KX3x3ntF1Rg8
	 1YR7WDYUa03Ekfxmak2RLcbSNb3jI/YL9A40w8SqXo1KhY0B1q6/IBcxuodTGH5KrXyDLGiGM9In
	 WQ2lXh5pqIO0HiIGeO17Ce01K6hi6hKMO2UQ8hzCBtrYBcL42Xg2FrC7xh2LGKZ+7psTE4gbSfZO
	 qNtMFxnX5hLmvFbIpxxsrPc+N/kfc6dWNXT8hzJ0atEoQzp+0EQtAPUhoLH9V8TPeQA8HJLCAsZj
	 1B+migAmmn/AUfJJqgzXhFEJwbDWQ2chI0LRQADNSOxJZ6t3v35Ks+20+kwfg=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Lei Qiu <750592120@qq.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] hfs/hfsplus: validate uid and gid mount options
Date: Tue, 17 Nov 2026 10:44:47 +0800
X-OQ-MSGID: <20261117024447.21982-1-750592120@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117024431.21914-1-750592120@qq.com>
References: <20261117024431.21914-1-750592120@qq.com>
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
 fs/hfs/super.c       | 4 ++--
 fs/hfsplus/options.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 5e6d66ff4..4309cc23d 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -203,8 +203,8 @@ enum {
 };
 
 static const struct fs_parameter_spec hfs_param_spec[] = {
-	fsparam_u32	("uid",		opt_uid),
-	fsparam_u32	("gid",		opt_gid),
+	fsparam_uid("uid", opt_uid),
+	fsparam_gid("gid", opt_gid),
 	fsparam_u32oct	("umask",	opt_umask),
 	fsparam_u32oct	("file_umask",	opt_file_umask),
 	fsparam_u32oct	("dir_umask",	opt_dir_umask),
diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
index 9b377481f..3ec428142 100644
--- a/fs/hfsplus/options.c
+++ b/fs/hfsplus/options.c
@@ -33,8 +33,8 @@ static const struct fs_parameter_spec hfs_param_spec[] = {
 	fsparam_string	("creator",	opt_creator),
 	fsparam_string	("type",	opt_type),
 	fsparam_u32oct	("umask",	opt_umask),
-	fsparam_u32	("uid",		opt_uid),
-	fsparam_u32	("gid",		opt_gid),
+	fsparam_uid("uid", opt_uid),
+	fsparam_gid("gid", opt_gid),
 	fsparam_u32	("part",	opt_part),
 	fsparam_u32	("session",	opt_session),
 	fsparam_string	("nls",		opt_nls),

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b

