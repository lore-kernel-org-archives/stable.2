Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046963;
	b=H45oDy1+hq5Jebb2XMrz2mseuTxHmRT/yONJI5RGHo41uurm3zoHv5Dh02EONIMCLjoX
	 kTXrzN0jVP1a5qzzFx2S/qcXXnPwMWpDcoXWHpZ1yXMG18Q5MWwN/igwWO7sBjxRAFKnG
	 zRIELznCPfK1wtsOHClRsQOOuT/kS8sAvwQWEo1oSXwDCPA5HN7VQUXJrjjca33LEhQo5
	 NqJ+Jiumyt3BrKo5TpF+pTo91jARtLNrgLekB/AWtwLaEdt0FBupDjJJvENI91Gqr7+CD
	 ZIW54uIdfEtKzfU/A9Y9XeNoF2xEs2ybdGGN8sTnBoBP7rrRK3aurzvhBqj6eaIDQtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046963;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mo1CV36O9B+hV1L8Z2j1/hAcP3RAE7ofvyw/LlNGK7U=;
	b=AW7bMZGvOmjZXyJLULbZ35Xh1zaievNByP5BDKnQoMT0as2OH8R2ZhCfeT++kESvXb4h
	 i2IgtkjMImwFfRl/u7L6KDDHkcdFf5BEn2FL3kZlJyr7BvGGVo8DjjZaRW7Y8wB4wQd5f
	 z06eajWUoDNTwQX0a17eaix4qGdpND4+AlkDCQS/lKFdwgSkgrHKXxyKo4MtbLIEf5Iex
	 ubPudqs2DlFc9SdaQoetOTxVK8BCpn9iO79CUIBHKKXLzQbdSMzeeRsV+nvrO/nPqFrFa
	 URheaWBAIccbZ5hq0Gux22WlWfRIpDV6pM5TzgHKRG0xBlWlV0CFX/QRyojApbV0wtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfdsF6cE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CC3606A8D9
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfdsF6cE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CBF1F0089F;
	Sat,  7 Nov 2026 10:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046963;
	bh=mo1CV36O9B+hV1L8Z2j1/hAcP3RAE7ofvyw/LlNGK7U=;
	h=From:To:Cc:Subject:Date;
	b=KfdsF6cEWnRj+d4furWRYBSADXVwTQwXwbJhlAIIAcBW1ROHme5QbkRls0MpmhBfb
	 cPRM6ufOruCohORo03fGZjn6OiwGYowktLXV7zcYjFCvxW6jON1xpsi8X1ddTXqm9f
	 K9ICNVKknvr/jiSNYazo1M9N9zcZOErKGDXyUEjggab3xW7MN/r+BhDPfR9p3SNYec
	 ckIjbHljONEuDvkpBNEXtdCTCrr/Pb2R8gwhbDgQqhQ6hOElVNoK1ndxjnt7p6z29A
	 fhiHci0irnP3DOAUvPmIIVqoDO9EtVO82pgOhceUu5lqsdTq0Enljt3zScT+LW52En
	 4w1sGy37zWCuQ==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	lee@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mfd: ab8500: Fix child device leaks on probe failure" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:22:41 -0500
Message-ID: <20261107052241-failed-6.12-5bf2ae8b131d@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5bf2ae8b131d4ae9c0ed5f7aa02532645f512022
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052241-failed-6.12-5bf2ae8b131d@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




