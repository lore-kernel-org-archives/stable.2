Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049236;
	b=1G8xKzzmCjbm2iq7EDOLnyBFLjatwZhfolR+pJbjRhSpjOXwmqd2CpoHhNg3rl7dr2vn
	 JM+TB7qPPmG4Ys/SLfDckjuut/vr1TZBbhVjiqkL3V/vfdeeXzc65n6FbueOvypkd5BLD
	 sHvCmmgGa/sqhC0qJFq6D/QBqC7gjjzZCWoL2YhNc1krQ8nwfKZ3FDxw73z31IhfeSnuE
	 QGcC39Rw/z4WmeJyqGYYn3Ubcq5XcZQY2MtUQB24lxlqLJWR5OTF2EsI5GeptDnKvG1Ei
	 wx2WXWIpfLVAtJl0hxJgYhbXk+oV9L6de4nOLSgH7easyX2dU+E8nqGxJ1azp4WZoDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049236;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1yvSYyuBWomwtaX64mlF6JGZ6CTezbw4KZUCh3WzM2E=;
	b=CPC/35JXqFTbh7b3/ch5/TXLspKHtZsE1VbhWrxKv7tORe1g3XmY0R0lJcbKtVDq7fgB
	 M3qNgXIIIAlVW6v2/7VwB1TVBq4/tABfbovuH/4xIZup2KeGRPLFTP276py7e2GScYIV+
	 /tRPl1JQO6eGgbatRPwiqTx0FM8Vidi8vtrL2mr+OX9VYgCXkXeswvrfMPK2mA0N6wBj4
	 +PDewtYf2dSTXUtdFsvyrRUjr+OgEpVd3nSA/nxdGV4RRi9Hqwk2Lh3mHQ6WnMdC7IBpu
	 Y5HeweAC4KvqZpkvVCTkiIuNBJnHI27Go4J/dgOxSzIClMrPFX2FIbejekFBdkEdZew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOouh1RD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689BF606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOouh1RD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66D11F0089F;
	Sat,  7 Nov 2026 11:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049236;
	bh=1yvSYyuBWomwtaX64mlF6JGZ6CTezbw4KZUCh3WzM2E=;
	h=From:To:Cc:Subject:Date;
	b=WOouh1RDq0sFlxS0ja3+pGsKB1MVlPuIeyYNyc8ndTo30pxSKpv2/WhF/0EQdCEYd
	 wRVxm74SBuhllcIliJG85Zc/VssJ6IgADeghjkpzZ/mFDRqo/IEXPf3y5znCPEyxP8
	 p5TH/u5qwT2VjjL1AYMsfSGDsjszz/mKtQpc19qlCnSvQbIQatLlk9ct1MY4eG+dRm
	 EetSXKFdiGvxdAxZaoamdoqlaLoc7R3zpTy8+rPbz+zBNKHc57fs8P4CE5IutBnr/d
	 L8duiVXKotkIu5i5kyA2NbJJaoquxAPblTI3o5jDBAtzTyFwFUfL/L6Aq8ZqJUlRdE
	 p6Byd/6wITuKA==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: codecs: wcd9335: Fix SLIM interface device leak in wcd9335_slim_status()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:34 -0500
Message-ID: <20261107060034-failed-5.15-082723fee626@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 082723fee626532f176727b6438b666a96d5246c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060034-failed-5.15-082723fee626@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




