Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050593;
	b=HebDdahydtCnGl3IR5bMjO0c2ZNhiO0StZQYT+MvMAo9W4pOeS7KfT/uk+uyYajAKU+z
	 yolnp752OkiGFbGE0J2odUZm+epMH0koTsOhqOiyOP3bIdEOtI6mNLIJBsd+EC/xmzbfY
	 7su6X4ubxoUhQJKOogN2cx2qHxZNsZRIHIMzkQTe9cLe0CL+6SwX6kDakpMP/89K/6oHx
	 vPUprjILjU0nK5uk5o439Yin5vF4nlseGWvnBIm3vW68TnWvpBToiWIyTu/6ZtM3VlxJH
	 rQafrVagQGKErKTPfrN7Rh7W24XEEw8QZhiGwTEQ+G9A8KgI+jx842OWsoSOIbmilDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050593;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tMCNNTgnjKUYoIg5bBFfJW03C/2j2yNc7/DKo8H41j4=;
	b=m+4xX9FXKXR63NdTzcWWdpO0COZ8hw5uTFJxEeY9aiiB+/zfwtNVE6Krr/7XWTKzI4hU
	 yNz1XQyiXboWPewUtnJ8crGChiKLRmWl/PjaC1M3z28rYzpua7sCxgQvWbJKxuRHx3rAR
	 O4Z81lCU8wivnvbfyAwSKpztlD/Y2vh3y1rjtFB3pYJLnNZGzON8J6+iX07pqIdOrKEeP
	 ZIgf//0vfOhNPyX7A5KROlFaa9uGChTAH3Ra1JHu8STq88hvnXkn2E7lrSI20V4H1OpOv
	 bvcR1d81I6h/ztTO+FuQ5ezBS1aln57qFHWeju9zNyas2Um4nztiCle6haE6DGUE4ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1urJ83p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3826606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1urJ83p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A171F0089F;
	Sat,  7 Nov 2026 11:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050592;
	bh=tMCNNTgnjKUYoIg5bBFfJW03C/2j2yNc7/DKo8H41j4=;
	h=From:To:Cc:Subject:Date;
	b=g1urJ83pQOh1oDmskqVYTRUUPWYBppZilJYgT69LPl1wQJhXyZrgLRGhnuRPxdkMy
	 xmfNDV4NCpCprPEQ43L/CN8xl56XjDl5PCIT44pZsBspqr/o6RDQ9Xmlehf5KqZ/Jh
	 eFWdcNuXvyyAVXeNAX6cO43OH7UwbRdqNsJzhnejf/5sCbZZ/Df3pFhNPJ6CRw00hW
	 zJkkSjILAyA4CoV0rfzAh5qqAYQ/2fzI/12dLbPVKWAS715uvak4Bhqt+we26pHRKg
	 vTHwYLLg8zcAHlZFVJBLh77wTgUtEOx60wh/iNCn0v0nUz14+magZdY6tUjhF4vU5v
	 KwtogWHt+x7hg==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	lee@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mfd: ab8500: Fix child device leaks on probe failure" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:23:11 -0500
Message-ID: <20261107062311-failed-5.10-5bf2ae8b131d@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5bf2ae8b131d4ae9c0ed5f7aa02532645f512022
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062311-failed-5.10-5bf2ae8b131d@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5bf2ae8b131d4ae9c0ed5f7aa02532645f512022 Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 24 Sep 2026 22:43:55 +0800
Subject: [PATCH] mfd: ab8500: Fix child device leaks on probe failure

ab8500_probe() registers MFD child devices before completing the
remaining device initialization. If a later MFD registration or sysfs
group creation fails, previously registered child devices are not
removed.

Use devm_mfd_add_devices() so registered MFD child devices are removed
when probe fails.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: cca69b67b3ba ("mfd: Export ab8500 chip id to sysfs")
Fixes: 9c717cf3fa16 ("mfd: ab8500-core: Add device for new RTC version for AB8540 cut2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260924144355.1604369-1-lgs201920130244@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/ab8500-core.c | 44 ++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index ceea1ae34dd89..d5602b2f4a0e8 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1194,39 +1194,41 @@ static int ab8500_probe(struct platform_device *pdev)
 		return ret;
 
 	if (is_ab9540(ab8500))
-		ret = mfd_add_devices(ab8500->dev, 0, ab9540_devs,
-				ARRAY_SIZE(ab9540_devs), NULL,
-				0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab9540_devs,
+					   ARRAY_SIZE(ab9540_devs), NULL,
+					   0, ab8500->domain);
 	else if (is_ab8540(ab8500)) {
-		ret = mfd_add_devices(ab8500->dev, 0, ab8540_devs,
-			      ARRAY_SIZE(ab8540_devs), NULL,
-			      0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab8540_devs,
+					   ARRAY_SIZE(ab8540_devs), NULL,
+					   0, ab8500->domain);
 		if (ret)
 			return ret;
 
 		if (is_ab8540_1p2_or_earlier(ab8500))
-			ret = mfd_add_devices(ab8500->dev, 0, ab8540_cut1_devs,
-			      ARRAY_SIZE(ab8540_cut1_devs), NULL,
-			      0, ab8500->domain);
+			ret = devm_mfd_add_devices(ab8500->dev, 0,
+						   ab8540_cut1_devs,
+						   ARRAY_SIZE(ab8540_cut1_devs),
+						   NULL, 0, ab8500->domain);
 		else /* ab8540 >= cut2 */
-			ret = mfd_add_devices(ab8500->dev, 0, ab8540_cut2_devs,
-			      ARRAY_SIZE(ab8540_cut2_devs), NULL,
-			      0, ab8500->domain);
+			ret = devm_mfd_add_devices(ab8500->dev, 0,
+						   ab8540_cut2_devs,
+						   ARRAY_SIZE(ab8540_cut2_devs),
+						   NULL, 0, ab8500->domain);
 	} else if (is_ab8505(ab8500))
-		ret = mfd_add_devices(ab8500->dev, 0, ab8505_devs,
-			      ARRAY_SIZE(ab8505_devs), NULL,
-			      0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab8505_devs,
+					   ARRAY_SIZE(ab8505_devs), NULL,
+					   0, ab8500->domain);
 	else
-		ret = mfd_add_devices(ab8500->dev, 0, ab8500_devs,
-				ARRAY_SIZE(ab8500_devs), NULL,
-				0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab8500_devs,
+					   ARRAY_SIZE(ab8500_devs), NULL,
+					   0, ab8500->domain);
 	if (ret)
 		return ret;
 
 	/* Add battery management devices */
-	ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
-			      ARRAY_SIZE(ab8500_bm_devs), NULL,
-			      0, ab8500->domain);
+	ret = devm_mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
+				   ARRAY_SIZE(ab8500_bm_devs), NULL,
+				   0, ab8500->domain);
 	if (ret)
 		dev_err(ab8500->dev, "error adding bm devices\n");
 
-- 
2.53.0




