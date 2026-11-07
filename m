Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048307;
	b=dVfKgntwE1qj8YQr48i7gwsM06Kv4ioK024dMKj/R6qxV4L8MXyYfkOmTZcp6aLWy/ma
	 Ze91wXCw1yT75X83PEwah/kq/AnHu1eaGi6HA7ZLhwwTvsNBKagemKnlsY4AZaPHomF47
	 due+iP9oBvCBi54uGyQsOqeWJDQ2Q198qm0pvzvy/auRgFnxbTomQQUoaMtdKC6JKXFvR
	 6jP7UOMgy+7EeDyv4TgFcJy1Ocr753dKyUM0Su1NOFM0kLLK1HpAtnGw2MqOxyE8F/kyg
	 RLWe9JvCfvABbXl71+aifzZfFUtDl5hxgYuVlCe6iH8k7pDwiJPXRbILXB6nvSj/Ung==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048307;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q1AF6bmza6SQuDYvPNn33zILT6XzPchaVTClqG1x3Jk=;
	b=bCcy7kVaHzkgkIpVG84a65qZV4Yp6x+0IGqkvoqPYqAYPxyDnDwnwh0JwZBFsDJZQQTp
	 FhfD4LGUBdh6O0P2Q1714R2xfizqK5gWXIXpVBmcP7+q5zLw+tv4Lzu8jnDBNMQzQM5uH
	 CAzLZSoTY97S7YOTijv240kgtQHSw7HyZNy3v7m608qS6JCODZc833k9GsQ99p5TOC0Q0
	 Wsk7jVa7Q+8hRcd+wcUpC/JdCDQnjgrpLgtsNvK09JxidKhPp57Q/r7koY6wDKnV9AeeD
	 dzc7pJV1npGHjFGWdijN/Jziv3233/j0zDVOAHsPyBwBZqz+6yKKRBbRLh4PsoFqJSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtBjCUVi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37715606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtBjCUVi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913E31F0089F;
	Sat,  7 Nov 2026 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048307;
	bh=Q1AF6bmza6SQuDYvPNn33zILT6XzPchaVTClqG1x3Jk=;
	h=From:To:Cc:Subject:Date;
	b=VtBjCUVihNEVjU6vN7VLPxt92/7oDZD2TZt6JAVNp/Lz++tYprDYxjykxUkHHMw8K
	 3THrJvMInn2erHePxLQkcigQ4/UNPOCJ7Hv0ci/5rtIp6oWMlYmfzUNBfmDPeuh1oY
	 qTRNFf2tD+f1J/0O9us1f71G4yPvsKVgElBucER9uie/1GpH8a83pcCHmdYgL++yrr
	 0b7kUs7k3wQ8xcM5X0jC7b622+2tva0QzLsQN+ydtxVL1jimBV6IHVF2Ib46RlwH6H
	 f1OMKnfGiprnon0tyZv1dFkijfmM7oTaQ2y1NNPGrT2+nTiP/xesm9KNHMX10aNl2s
	 KNj9aG9FFbQGg==
From: Sasha Levin <sashal@kernel.org>
To: blum@kernel.org,
	akpm@linux-foundation.org,
	dmoulding@me.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] init: fix early boot crash with bare hostname parameter" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:45:05 -0500
Message-ID: <20261107054505-failed-6.1-b6bec5b63a5b@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b6bec5b63a5b812145e53aaad1e63661c7214f93
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054505-failed-6.1-b6bec5b63a5b@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b6bec5b63a5b812145e53aaad1e63661c7214f93 Mon Sep 17 00:00:00 2001
From: Thorsten Blum <blum@kernel.org>
Date: Wed, 26 Aug 2026 12:09:03 +0200
Subject: [PATCH] init: fix early boot crash with bare hostname parameter

When a bare hostname parameter is specified on the kernel command line
without the '=' separator, early parameter parsing passes NULL to
early_hostname(), which dereferences it in strscpy() and can crash the
system during early boot.

Reject NULL values in early_hostname() and return -EINVAL instead.

Link: https://lore.kernel.org/20260826100904.296151-2-blum@kernel.org
Fixes: 5a704629f2c1 ("init: add "hostname" kernel parameter")
Signed-off-by: Thorsten Blum <blum@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Moulding <dmoulding@me.com>
Cc: <stable@vger.kernel.org>
---
 init/version.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/init/version.c b/init/version.c
index 94c96f6fbfe6a..0bd5c45aabc46 100644
--- a/init/version.c
+++ b/init/version.c
@@ -23,6 +23,9 @@ static int __init early_hostname(char *arg)
 	size_t maxlen  = bufsize - 1;
 	ssize_t arglen;
 
+	if (!arg)
+		return -EINVAL;
+
 	arglen = strscpy(init_uts_ns.name.nodename, arg, bufsize);
 	if (arglen < 0) {
 		pr_warn("hostname parameter exceeds %zd characters and will be truncated",
-- 
2.53.0




