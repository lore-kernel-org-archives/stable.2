Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5EB672
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783172430; cv=none; b=clVt6fmgbPqY5IGLapbnUQ0qTKGK3bBEl/Jd6Q5OgCz1qdpVpBUKE5GeIuOSiYpWCQloXcq73r9BBemebV3ymDVdc+IpbqQ+qsTzIb0QUskOOp/IgBszzYeUS7xrC7sq8m4dfo6ql7ZmZLJAM7w9RxPP7wibaJ0CiIuIMwZmslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783172430; c=relaxed/simple;
	bh=P02l9AAAEEiCXKWVi5Lu/l2RJdL0EBprJN0MRhDwhts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7niY1wiBX97JRWkkDYgVR3MFo05W1POTUVb9yxW5mx5Uazp/I/EJBkUJoU/p54FsFxNsltNAc1JdXWopBB7XcTzwUi49n44UsYZ5aoblkB7v+N3xdKHtzZdIkChfw9SFDHnLw/IUsmUke07lS+3Cb4XbwcIlWaZY/3FLheRlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma5uFNhb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma5uFNhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F151F000E9;
	Sat,  4 Jul 2026 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783172428;
	bh=cUmZd+n4y5pa15wGBG4MHjUP0l56vLGTkj4GCqvPyKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ma5uFNhb4FXejNBUp+VYQDjSNx9JvtUNodjXTGZXE+Vwr7D/Y0BPVICfTFEhWbBXn
	 Onwz3FYHY2+7gWRihbXKv2eujNhw+3sgVXmUM64bqtPceGOzvpI33c/GhS01781glQ
	 v+YAt1+rjRN6CsUk7SMt18VnOVvuZFVzP+vHg7WlUQYILSknzXzlab36pSzxPPdsQC
	 uU1wbUu7q+8T1qMQf8wPVvlgKb8nPmmUCgjCksK9iNJOETgpI6RNRdDkx0NYBp9SYq
	 YM7C0xTl2/wYa/BERUOyxsqLAPg5nzDSauPnn5rZTE5snKUy8nkHlWKHpvdonwXMOM
	 8KqIwjaG3+7PQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuho Choi <dbgh9129@gmail.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] rpmsg: char: Fix use-after-free on probe error path
Date: Sat,  4 Jul 2026 09:40:26 -0400
Message-ID: <20260704134026.903689-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070228-dwelled-nurture-5733@gregkh>
References: <2026070228-dwelled-nurture-5733@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuho Choi <dbgh9129@gmail.com>

[ Upstream commit 1ff3f528e67d20e2b1483dcaba899dc7832b2e6b ]

rpmsg_chrdev_probe() stores the newly allocated eptdev in the default
endpoint's priv pointer before calling rpmsg_chrdev_eptdev_add(). If
rpmsg_chrdev_eptdev_add() then fails, its error path frees eptdev while
the default endpoint may still dispatch callbacks with the stale priv
pointer.

Avoid publishing eptdev through the default endpoint until
rpmsg_chrdev_eptdev_add() succeeds. Messages received before the priv
pointer is published should be ignored by rpmsg_ept_cb(). Flow-control
updates can hit rpmsg_ept_flow_cb() in the same window, so make both
callbacks return success when priv is NULL.

Fixes: bc69d1066569 ("rpmsg: char: Introduce the "rpmsg-raw" channel")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260601183247.1962010-1-dbgh9129@gmail.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rpmsg/rpmsg_char.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index a271fceb16f421..c02949adf563d5 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -100,6 +100,9 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
 	struct rpmsg_eptdev *eptdev = priv;
 	struct sk_buff *skb;
 
+	if (!eptdev)
+		return 0;
+
 	skb = alloc_skb(len, GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
@@ -448,6 +451,7 @@ static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
 	struct rpmsg_channel_info chinfo;
 	struct rpmsg_eptdev *eptdev;
 	struct device *dev = &rpdev->dev;
+	int ret;
 
 	memcpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
 	chinfo.src = rpdev->src;
@@ -460,13 +464,17 @@ static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
 	/* Set the default_ept to the rpmsg device endpoint */
 	eptdev->default_ept = rpdev->ept;
 
+	ret = rpmsg_chrdev_eptdev_add(eptdev, chinfo);
+
+	if (ret)
+		return ret;
 	/*
 	 * The rpmsg_ept_cb uses *priv parameter to get its rpmsg_eptdev context.
-	 * Storedit in default_ept *priv field.
+	 * Stored it in default_ept *priv field.
 	 */
 	eptdev->default_ept->priv = eptdev;
 
-	return rpmsg_chrdev_eptdev_add(eptdev, chinfo);
+	return 0;
 }
 
 static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
-- 
2.53.0

