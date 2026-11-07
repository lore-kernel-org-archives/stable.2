Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050245;
	b=2vASitkSBkQACSCMpMXP+krJjq3uzBUkZXQwqi6BLlv89DXAB6Tm3Z73blbj0Lfuplze
	 sYo5EmbL0LvW5I+NEFK+eJWEjpNw9hGQP1afAzlge43mFK7viFtpjp0Lflyrm92ASZH1e
	 C9b8d7BzuYlP8rhEz5aBL9OuIpaHYPX29/z22DJb+ipT8kCv6kyikI2fgcek9hinmc6go
	 7dpqYYIMQgRBX6ZGhuPyb/GGQ6Yos2iS+EzYUxE1QvuVdJDhK+dwnvDiWb5l4JFgvnRXv
	 ZzW0LBkXiExKrwyHmesvzXkpZVShaLdiP9JubG5usuaq1lQqWicA/WvfCD7LBNZuMtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050245;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=t9Yqr6XN9XK2B+hkTb8Qy0Y3arTmmmc6TfnUUkBIfEw=;
	b=CpMdB4pa5xw4gXqWrEJkzDjFS8tQSRrVCK011kcAP7RaRUuLaGwZ8mpYlo8uQa7lIuWn
	 vRiKVpD073E+ZnumwSaRmNPk6b9e8y/dAJ/5pndtzlY8/HIQWjuh4P/+5RjSFuoMrCvG1
	 Yd/gtmCGpMXdibD1I7++ibAeDslbhXeWWOJZX2Hdj5H1I7SY7iam9+uUlml9cjCCjow8m
	 fzrHtyLgDzrS1zcAZvURoVBWjaeoexEqm0wTHGnrp1i6+erKTijSvSBqqacOfdDNd09DA
	 XnOS3kNxlvjYdsTfbUqBAhv7+Sj6r9LbuCXgAAdf5PV7Td68owEAxkx559KThrL7z9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvNU37Cv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B5D606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvNU37Cv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6450B1F0089F;
	Sat,  7 Nov 2026 11:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050244;
	bh=t9Yqr6XN9XK2B+hkTb8Qy0Y3arTmmmc6TfnUUkBIfEw=;
	h=From:To:Cc:Subject:Date;
	b=lvNU37CvdKW5UY8t0ssC2rD71IYuMZWmbMa2ppkZCEo5vZpU/b7M6m4D6oRL7gShA
	 ubLMWWLFsTMVpQ0JAeUwI2UrF0M+W02FLfX9qEIOCK95jMQV5bZP4vbiizeDLILyfk
	 9cywbUiKoVAwXCCQzx0Vg2qRO4VBzTa0FY4sY2jV/A3Pyj0RFFCZStLoI0X4Sc9Ak3
	 9OWiSZkMCLRMRepiQoQQMvYUs+k1/tAl9zRJSq4L27I1PhjzgdL6r5QFL/Q/3Xp6mF
	 oo+rrR+7Drk0zFXcPvGliBaITNEuJtyfsTd+cd7gwLCe0x3lRpMrY9pjD5sWd77/Os
	 Xy72hyGOJBCOg==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: codecs: wcd9335: Fix SLIM interface device leak in wcd9335_slim_status()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:23 -0500
Message-ID: <20261107061722-failed-5.10-082723fee626@kernel.org>
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
git cherry-pick -x 082723fee626532f176727b6438b666a96d5246c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061722-failed-5.10-082723fee626@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 082723fee626532f176727b6438b666a96d5246c Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Thu, 17 Sep 2026 16:48:53 +0000
Subject: [PATCH] ASoC: codecs: wcd9335: Fix SLIM interface device leak in
 wcd9335_slim_status()

of_slim_get_device() returns a device with an elevated reference count,
and wcd->slim_ifc_dev is intentionally kept for the codec lifetime on
success. However, all the failure paths of wcd9335_slim_status() return
without dropping that reference, leaking the SLIM interface device
whenever the register maps cannot be created or the codec fails to come
up.

Put the device on each of those error paths.

Fixes: 20aedafdf492 ("ASoC: wcd9335: add support to wcd9335 codec")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260917164853.2163184-1-vulab@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 9332082092c79..a98d1fd789251 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -5135,25 +5135,32 @@ static int wcd9335_slim_status(struct slim_device *sdev,
 	slim_get_logical_addr(wcd->slim_ifc_dev);
 
 	wcd->regmap = regmap_init_slimbus(sdev, &wcd9335_regmap_config);
-	if (IS_ERR(wcd->regmap))
+	if (IS_ERR(wcd->regmap)) {
+		put_device(&wcd->slim_ifc_dev->dev);
 		return dev_err_probe(dev, PTR_ERR(wcd->regmap),
 				     "Failed to allocate slim register map\n");
+	}
 
 	wcd->if_regmap = regmap_init_slimbus(wcd->slim_ifc_dev,
 						  &wcd9335_ifc_regmap_config);
-	if (IS_ERR(wcd->if_regmap))
+	if (IS_ERR(wcd->if_regmap)) {
+		put_device(&wcd->slim_ifc_dev->dev);
 		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
 				     "Failed to allocate ifc register map\n");
+	}
 
 	ret = wcd9335_bring_up(wcd);
 	if (ret) {
 		dev_err(dev, "Failed to bringup WCD9335\n");
+		put_device(&wcd->slim_ifc_dev->dev);
 		return ret;
 	}
 
 	ret = wcd9335_irq_init(wcd);
-	if (ret)
+	if (ret) {
+		put_device(&wcd->slim_ifc_dev->dev);
 		return ret;
+	}
 
 	wcd9335_probe(wcd);
 
-- 
2.53.0




