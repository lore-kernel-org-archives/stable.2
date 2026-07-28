Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523A471D14
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277074; cv=none; b=VxLmCMcUwIHa8V+ESC/NmE9hk+IORkyZzOPe17XrnyxQnDrqJWuCMUQDqd/cWkrj5WotWaCQz0+hkNw6uFPIhGRH1NaMOw0nHhUIHPXZuxP2NFjitQfZZJnaqMgvgM6DfRWwMVJqsuu20HIfei9SMlVJ/noD8VblWCM53bThfY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277074; c=relaxed/simple;
	bh=9hkXYyNFTbrQ9CubZVtZdcCHxQ6W8FT6fRAW0N2W9ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9f7cOxzDfTVgIGz6kBc3molx3PPClru0r8kFhkNOaJAvVCBJo+/bC6VVfDBdBOJcNyvXQZj68Ifj/zSfZFl3L/snNjYyfhoFvROxs7IuldxKWBNgRwY03IK14R5h8P5n2sLwlWP26/4X8ehQflqYfrxQQDbFlx3O9z7DsbdV2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8hJGVnz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8hJGVnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154961F000E9;
	Tue, 28 Jul 2026 22:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277072;
	bh=TmTJ3CTOM7Epau39f2MUMaPoGgRrZa0u3ybDGew9Szc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e8hJGVnz201NOevw3/LGda4S4p1cNUYTkOt0ZsL/Wowy2386cPx8rM770Q4UsP+sX
	 DIrwrSflEsYrjsYlPVlXGnI//79Xf2JBIhRrG0GgT/JCW0JF4/aUxSfVAj9V0qEEjU
	 7GhBiO9lE6/K+UUHSqiYsJd2xig7+CQ0C3pzMHCR8Fyu+ujswqxPbvnax7AxnbZp45
	 NsRoh6VST32mJ3bMrMYXx1Ul7r0ZHGysHKLiQE3Q+2wBmSVCKt8XHWUo+uvw6Apj78
	 l1tX7cxGp5eozybH1Mm/h0sARb6bQO9gmqvFktq0FpWzv7TR5iTwvWvhlaaG7u4iaI
	 YVBZC7K4sWZ0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] bootconfig: do not put quotes on cmdline items unless necessary
Date: Tue, 28 Jul 2026 18:17:48 -0400
Message-ID: <20260728221750.745951-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072113-skintight-barometer-812e@gregkh>
References: <2026072113-skintight-barometer-812e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

[ Upstream commit 212f863fa8811c780abacc1d0404c573fdc0a2de ]

When trying to migrate to using bootconfig to embed the kernel's and
PID1's command line with the kernel image itself, and so allowing changing
that without modifying the bootloader, I noticed that /proc/cmdline
changed from e.g.

  console=ttymxc0,115200n8 cma=128M quiet -- --log-level=notice

to

  console="ttymxc0,115200n8" cma="128M" quiet -- --log-level="notice"

The kernel parameters are parsed just fine, and the quotes are indeed
stripped from the actual argv[] given to PID1.  However, the quoting
doesn't really serve any purpose and looks excessive, and might confuse
some (naive) userspace tool trying to parse /proc/cmdline.  So do not
quote the value unless it contains whitespace.

Link: https://lkml.kernel.org/r/20240320101952.62135-1-linux@rasmusvillemoes.dk
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: dec4d8118c17 ("bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index 4e9c76a0e5a478..f9e98fb3a3e098 100644
--- a/init/main.c
+++ b/init/main.c
@@ -328,7 +328,7 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 {
 	struct xbc_node *knode, *vnode;
 	char *end = buf + size;
-	const char *val;
+	const char *val, *q;
 	int ret;
 
 	xbc_node_for_each_key_value(root, knode, val) {
@@ -346,8 +346,14 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 			continue;
 		}
 		xbc_array_for_each_value(vnode, val) {
-			ret = snprintf(buf, rest(buf, end), "%s=\"%s\" ",
-				       xbc_namebuf, val);
+			/*
+			 * For prettier and more readable /proc/cmdline, only
+			 * quote the value when necessary, i.e. when it contains
+			 * whitespace.
+			 */
+			q = strpbrk(val, " \t\r\n") ? "\"" : "";
+			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
+				       xbc_namebuf, q, val, q);
 			if (ret < 0)
 				return ret;
 			buf += ret;
-- 
2.53.0

