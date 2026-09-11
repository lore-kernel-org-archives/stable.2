Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352B305670
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091032; cv=none; b=IJlpxoARZRTpc4jJ6eTsguBa2PUzrvva6F3TfY0mk7hS5kqpx6fNyS3RobkD+uSvTSFkY+zFeHGzpbwAfDfrCDYmwF9lD8nvN07Eblb4K1GBNFwwSe7/ORdJpaVOTF2vMJ4OYWCn9uEFYeKlR3Me4I3meQTTzHhhk8Zmd+4S5dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091032; c=relaxed/simple;
	bh=TVVug2pvQvLK/gVwTbw+nSb9KVsYZhgfLbeAdPiIRTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEsjBnjy/Ih38j6J71uidpAr5gUIkQmS0kyYIbB99QAZaS29fUSXusZXSwSGdi+naNAgkgt3lNvKpEivS8AUgA8nrWqwj9QVXcsxg3s2ALAWgx51qrSVyRQsKLQYX99nU9W9NywLGix08jkEaJ5wK1Z4WGYlpG0rmaKLfIC7eeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzjdrEGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzjdrEGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42FF1F00893;
	Fri, 11 Sep 2026 01:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789091031;
	bh=ZPfQWFkf/YfU43Pj8H536Km5E6S3jO0l0kUU+YkE21k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TzjdrEGk5n/PR7LOFpDGcRcfeqCFXEvlvsNUUhuA0v7coRvSJ+N44fWUhap4EFxET
	 +WTZxt4sPqNWGKjprZLdmrWsTUJieX/UBPvBlZrfKST9UGuYz82YGnTHxdxnSictKA
	 VU93N7tFwBxLB/ncvbokGh8rOXjwdkfi/0oTcsTPB9Gq3EcxJ9hmy1BIB0Vb/D/4Gp
	 cMLkOU/78WLKC+wvEO0wZeKxe+q9nTDNc6KaIV1Py5qD3o4oUt5Azlqi089qaOxdsl
	 VTZWPTQvNnqRwHgBRq+1CFBp0dQKgbpJuXg1jQtqZAj1qjK7vfblmgK5g/WvyKqyn4
	 FF5bpvRfaOdOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ASoC: hdac_hda: Fix hlink refcount leak on component registration failure
Date: Thu, 10 Sep 2026 21:43:48 -0400
Message-ID: <20260911014348.4149148-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911014348.4149148-1-sashal@kernel.org>
References: <2026090904-opposite-unpadded-c0c6@gregkh>
 <20260911014348.4149148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <haoxiang_li2024@163.com>

[ Upstream commit 6ad4892c4f5cb437a928a02f5b7d37d496aa9268 ]

hdac_hda_dev_probe() gets the HDA link with snd_hdac_ext_bus_link_get()
before registering the ASoC component. If component registration fails,
the function returns without dropping the link reference.

Always call snd_hdac_ext_bus_link_put() after the registration attempt so
the reference taken during probe is balanced on both success and failure.

Fixes: 6bae5ea94989 ("ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Link: https://patch.msgid.link/20260622145645.1184986-1-haoxiang_li2024@163.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hda.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 8ed645a3f2a9b..9c7391f7b9198 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -616,10 +616,8 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 						&hdac_hda_codec, hdac_hda_dais,
 						ARRAY_SIZE(hdac_hda_dais));
 
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&hdev->dev, "%s: failed to register HDA codec %d\n", __func__, ret);
-		return ret;
-	}
 
 	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
 
-- 
2.53.0

