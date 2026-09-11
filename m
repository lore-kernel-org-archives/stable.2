Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A532443CEF5
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123298; cv=none; b=sQ51i52GZiVI5J4+OfbvyLBMgQWTq4nj7YkGybM6v4YKwm5kBEpfb3HavNF6aKCVYF3fhnevaEI2fd8YqWpIEj/7H1yxb3pK43BNVOSthsFpAMfjHDfab3lPZ/IzTH4FZmbCFNYMdtA2S336f9v7jU3ZBfHPiTfAVJKlnp+0piY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123298; c=relaxed/simple;
	bh=9rh/VQpHg7Jbc/pPX3DrsBrjkRUxgqelNcNGbLkYpqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuJsqXkpZSn/YmSAgUhpf7awdk8EOYkrOEUaqsr/UZdZmCzQCBKgTCAuMwXr/u3qn3lZM8zEzf18GpQ/zytyOPQkFeK2Cf/ywP/ujNwNEsBpolbhN2RsQ5wFEhsC8rRonG0k6+PLC39feFfwuPLuU0/sCa/qBzLi0ekvYIwqUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8/tknsY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8/tknsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B091F0089D;
	Fri, 11 Sep 2026 10:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123296;
	bh=kh8nf5WOngCRV7CaHmtub/ba2MYIfuiAsAgkpVejZyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d8/tknsYaMrOhan4jPNAqrj1OFsr+O7wvmLhglcBXutE1Ged4iCNK7yrdoUYF+eYV
	 4kyR2pBz5SDoY6BikjMwu+NSn7VwLv92ZbGSUGPlMJoR+JZJPBGK1m12jgXlViJ4x6
	 7uZ4fkoecqR/YGdbCxZyUa54Qtm0+fuQw5cnviN97LvRC1zHBUgwlBSpzejQCRvao6
	 zSgLWwlq/Hjz4536ncSwbFM5JSr4/dava/3Q5m7Z++kciGyLPcPtvCYsIPQOCpajfX
	 anA885QT8TEa3+2ygFvG6kkFvWqw6f2rskYI2V/SfczC3o8AFl8bbL2O3Fmd+izLAx
	 603kG2JHlUiIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/5] ASoC: hdac_hda: Fix hlink refcount leak on component registration failure
Date: Fri, 11 Sep 2026 06:41:30 -0400
Message-ID: <20260911104130.193213-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911104130.193213-1-sashal@kernel.org>
References: <2026090904-antiques-gallantly-338c@gregkh>
 <20260911104130.193213-1-sashal@kernel.org>
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
index 3cb5ae7fb5269..3734cc0d7f059 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -600,10 +600,8 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
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

