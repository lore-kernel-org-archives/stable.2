Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC421257F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285030; cv=none; b=Pc/HceZPyn7gIsO33/mvXmUsqJS84LrNIAkO7/y/aMoGFIySqCu3D/iiCM77T6kLUdFuz4pyh5IKUA1R9usd/LXdlZC5LNjHvYtrDb279puH5LWHaCKIKkVGzAK0CvpmUgNkzYLSSEjksfUD820BhcsrPp2cSsJIGv4HCw+WQhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285030; c=relaxed/simple;
	bh=DLn56+mTGeyrNtF5f8CF8eKtdBuUy4UnJ4d4ZKP7+ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7ks42Wp6cImp04K2YIrPzx7/D92/u6HCY7kbUgVznt6x5udAknKK5DPUpH4Qx6zuJ9FZuWp6lzBpZMV5fTE1rLMAcQSmiEXFlHwVj+BWTSDfxV49Prpx2pze2M+OhNNzxOPGeiakyRBypoGW1rWRxqj/pdTt12KvndICyYIzDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKjVveJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKjVveJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5921F000E9;
	Wed, 29 Jul 2026 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785285029;
	bh=POvNfjuRGNsw/C0fubvS82O/8US10+L2R3ogyishZMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bKjVveJ7fCcwWB0sKWEXCieunSy5nbNOGFYgSovoXEFB0ZWvhq1TRV32Q42fTGq5d
	 EiHdeiLWho1VzTutdR/yRi97gWUQ9z1DRVleiA0q8nH2SunFvTZJJAkS8nG0rgmhkp
	 g8RkQtKP2fntBf2xy/5c6cm7CbVa2SL93igzWwhYe8RquhPx87CvDpYr90zHGsczme
	 HldCBPdMAdGEITmehXYIL/xn6ADI3qiFlf5JCdN8YwXSPYCm3G/9CCcZpjEitvsKpm
	 0iY0PVSpMLhuq6Svt7nWlzspPX8GtooNIpuYdFLxfwo3F1X7o3oqZu0+0reVUg9HBO
	 wao9ZWSRiPpeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] bootconfig: do not put quotes on cmdline items unless necessary
Date: Tue, 28 Jul 2026 20:30:25 -0400
Message-ID: <20260729003027.887848-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072113-duvet-tattling-a13a@gregkh>
References: <2026072113-duvet-tattling-a13a@gregkh>
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
index cbb7ad93d7fa3c..8aab715535dcad 100644
--- a/init/main.c
+++ b/init/main.c
@@ -323,7 +323,7 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 {
 	struct xbc_node *knode, *vnode;
 	char *end = buf + size;
-	const char *val;
+	const char *val, *q;
 	int ret;
 
 	xbc_node_for_each_key_value(root, knode, val) {
@@ -341,8 +341,14 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
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

