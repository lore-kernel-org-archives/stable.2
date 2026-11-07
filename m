Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048192;
	b=V4uEi7NkQP/wij9Ucdh8n6lTcIko8Ic8Gzgs45v4/luf4qNHKwwRY/zOVcRMmB7gGOBf
	 As393sa0dzmSXMmBghXqzBaMjLM56uhmTIRg1we6OR0NVM8O1MbqHDChTtCnMcvAkDZAo
	 N43NXAM1vTtPEIg1sNQwfmTeGNvhTuCj9+DE+bcdaGJ+Xgl6JujBsNLEWJKnjNiAGVjGk
	 7ANR4TvpEMpto0XWNs1U270/FzD7XQi0W2rKJG6yVPYnn1r60vfRu8P/slMNHbCgZuLfh
	 E5MKo/zWWSM50qlFASQv0FN8dmmfn2199No7Ns6OKsCP8waFRh5c0PQq1wQo0DWDWwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048192;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ncKz3oa33CGzb5JCMiIvvOwbQrI61uWf3II44B4kk7M=;
	b=wNB6nj6l4hjHosHJJNNfOfTfR9LrSsiBQE+LRCKT/6HfW8FesU9VWDK1VVo8GAJiEsqC
	 Gyth/De4v6ged9dewxmlwDA/IH64tgzaGTfHV1HLmYswloa6FBTaPXtZXNakoRUtvZ8Gp
	 FqRS4M6SfuXnYhRVMzMxCYx+mpgtB2QDFdwpQvk6zQtB24dC/g5OFDXesXiPG4+3DRvRK
	 xsX6LuKdeT1k4sfG0fN9aDjCAJeHEsO1EFWgt+9s9wxkN9HcAdUbw8ybuYjgExW9roCzv
	 6Zy0yTujibA6/Wr6MAvoemrwH9XTsltDIUpbK9rnNtsulHci7Jild1spB/V2TZt47sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfebcsqD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D28606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfebcsqD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3004E1F0089F;
	Sat,  7 Nov 2026 10:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048191;
	bh=ncKz3oa33CGzb5JCMiIvvOwbQrI61uWf3II44B4kk7M=;
	h=From:To:Cc:Subject:Date;
	b=MfebcsqDhsmS5MZEThBiOCzPWzzwS1rpN1g+t5+I78H4L1Hoh+sp1gzpe/qKmuNd2
	 lrTArV790N2U2uIcLFmkneuCL7Vk9La3ctBk3KNuQ3z8zPiq+eMVTimPXGKjLybYg+
	 b+y5Uz3zGnLIy1LcL7A5RDllZrlOLsnSiSFBP46PNcuSHpWBztXYqA+E9F8PjWzzg/
	 GizB3YdpXDbywB6VBGZEz4Hq30QQuOm1IONDT1KgfCSkLcauhRI3yrOgpl+uwtMwyS
	 rS/d/mwwuUVpm9A54itBXZYivu1cq48aUEGbUEKjMGWpcpa6EUt878DBjnjqqapiad
	 rAKuTjEUstUdw==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: codecs: wcd9335: Fix SLIM interface device leak in wcd9335_slim_status()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:10 -0500
Message-ID: <20261107054310-failed-6.1-082723fee626@kernel.org>
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
git cherry-pick -x 082723fee626532f176727b6438b666a96d5246c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054310-failed-6.1-082723fee626@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




