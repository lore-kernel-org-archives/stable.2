Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4ED3C0625
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262009; cv=none; b=DnH+iWzbYElfJIHY/SEitasg2VYrfc9ZRkOfzsG7tCgkWrH38eJGuxPPBDmqbhP8kNmYdswsggIQsZae0r2iFi9auPmjKTJlvGwD2abp+o66XYBx2q9RhzQRyudI/n+tDW7hmd9JRsxMC/48wu5VhocXPQVbfEWnWPkdW0/WFMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262009; c=relaxed/simple;
	bh=L5A2JIBiTEi6WqSAs7LH+pHWqhbBmtWC6VGT4itCWQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYnd264QzMAqdnAz2QZbjwrykscZXNRTkWPwW0ggzyBOaT3q3V2ibw76q6dn2V5CJrm9MZa/QhIzJbNvKZZaVia2a9Xq+vrQLp84h38StY4F7txeQH3fEwEX80a8osPBpssSCkIcHiMaXp5IgRM9nE1iIZiJ2/nm2Pehmlx5dII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yfenb2t1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yfenb2t1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A598A1F000E9;
	Tue, 28 Jul 2026 18:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785262005;
	bh=LHHOp4K4PVNT9mJvJsIb/tsHRry3OMaj6XvH/7g/GFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yfenb2t1RKbx4xg5PfclDSkQFotkIWSg1ifnST7MzAxc8qhjJmRlvgFQk7S7N2K5n
	 4soeVICBD6RPx9rWFVA7nt2CrqtGQWACotWTaYKDUJaFYM4U5QqHEhpN4/pCSlno9G
	 GoXs0nTMmFn/ISPXj18doFYFnZYFw5KSXpY1qaLb2M1QqBbENCjHbDTet/6pK6ghPw
	 h4R25oZOQ+T10IkklRrSp4ezk4tjzdM8dFYeKZpzbxpLGA/NoLx3cD3XqvPJfBbvsx
	 x1lywuXcw8nMH3+9owRDl8YK8PUFzcbcCkvgyZVAiW8upOtPnqVZG3cC5cYqOlcFqv
	 QmGH/q8FEpuGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] bootconfig: do not put quotes on cmdline items unless necessary
Date: Tue, 28 Jul 2026 14:06:41 -0400
Message-ID: <20260728180643.289803-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072112-copied-earthy-db88@gregkh>
References: <2026072112-copied-earthy-db88@gregkh>
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
index eac47a2beb7e4b..bf92053bb3b443 100644
--- a/init/main.c
+++ b/init/main.c
@@ -325,7 +325,7 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 {
 	struct xbc_node *knode, *vnode;
 	char *end = buf + size;
-	const char *val;
+	const char *val, *q;
 	int ret;
 
 	xbc_node_for_each_key_value(root, knode, val) {
@@ -343,8 +343,14 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
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

