Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651254734C7
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267018; cv=none; b=ResZUJzKMh+5dDyqojawEh5M9ZdEuvbnbodmUwwHN7tTdb6lTP9gSjixzxrIZ3XEnX1equytz2KzDkTIxXKT14STOP6j2FJq3mWWwVHqW8bJR0a43JIQX7b7WDRd96y6kKn6lzE6veBKAwiFq1erCDcSsG/SdYx8BrWlv2Fwtxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267018; c=relaxed/simple;
	bh=HEAlgZagS1W4g5dBSlODin7XJ5qU5iX4+fyGFovuzF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzQFa9LAbjFM/HgiYS29yjj/FtCV9wObHy7zlFjrglKOs7/l5EHbiQumUQRJRhxlemG97qVWhkGekNpowhge1PQ1eM+HOplJPe38OB4fmTnNS2LQYlFF1ErScjDPNeX+ZFbi5tG+cxbfv1ndtZsnpARPLqEmv6QAwUrqAfanr94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFNd8HaW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFNd8HaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9251F00A3A;
	Tue, 28 Jul 2026 19:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785267017;
	bh=g0BmUoroGZ53EirTOMGZlOqd83G8bMQNlOICz6v/Ssk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RFNd8HaWEOYz+LAF14UniWyoFjxochJLboMWDW31DztuCR2rhpDiGz2pIV7KbkMo/
	 x5txlwRHSIffIden4zWE2haIDexIPyvSwwnRKK1vITl6QeMpeom7+gNP6Y8wthJ5vB
	 G/69dppyLYw35iOWmS4ArSNUIVV08W/Gf8QJQS2sBjsAJPVGR2DC75gPj7/1jYN3VS
	 G3mmTqSS82Ss0cgsCCvo5aFwr+8ZuQT3SFzvc+WByqfMfem7DPTh1mvYPvpB2bNXee
	 S8BOe8p1vdMQw823/0pie39L9kT8GvemJZaJyBtGLedbrxUsxAXVG3JcVzSOOb3i5q
	 XyVVTbFhyL7uQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] bootconfig: do not put quotes on cmdline items unless necessary
Date: Tue, 28 Jul 2026 15:30:13 -0400
Message-ID: <20260728193015.455727-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072113-streak-grandma-0f8a@gregkh>
References: <2026072113-streak-grandma-0f8a@gregkh>
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
index a677b6a2cef5b5..2ae33ded6596d1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -332,7 +332,7 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 {
 	struct xbc_node *knode, *vnode;
 	char *end = buf + size;
-	const char *val;
+	const char *val, *q;
 	int ret;
 
 	xbc_node_for_each_key_value(root, knode, val) {
@@ -350,8 +350,14 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
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

