Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD519406261
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123809; cv=none; b=BBOpCvHAl89H20v0xdUjVbbS/lIYc4s1qJdNsNpqddSJPbJP+NtumeKHwiUy95xBbqLeOQpOYSX+XY2tT9zK8M1vjYej9eU92azugY/D6VxG7fzDBJr4PmqHDU6WCRhLx9107vP0pIYq4HxUeJsAQPDXHAEAgQfu4Zgmq7Ul+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123809; c=relaxed/simple;
	bh=9rh/VQpHg7Jbc/pPX3DrsBrjkRUxgqelNcNGbLkYpqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nC/dJjv00vyUMh1qoKmD0kFTh0Mleqwe84H/vO08Tf5/PsesbT+LOjqh5E9y4DIeAXa5xVYJgmZNw8PKBrVjxoxmEIXgtDtc91976CmiCNxNtodssH6WsE2ZLY10R2nC3wyb9jK6U4xY3U2n4r3yuUV8TJnzgPzmcjuTA4R3guI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqXzvLy7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqXzvLy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328531F00893;
	Fri, 11 Sep 2026 10:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123808;
	bh=kh8nf5WOngCRV7CaHmtub/ba2MYIfuiAsAgkpVejZyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GqXzvLy7c344ZOs21qCDAYb8y2p4gcsHAKtOF7Z1HA4ex1VF8AQ6DGZsZs+e3KSlv
	 FXEBCQ4G5mFuAr4h1OdIF4ZqWCWqOjYS6gRp3UCmzcc3UMqzA9kfJ/Zyu+dYvvCfB1
	 lbu3zBgPoywodEHGqUVfv1P8+UPIuhb3Fb1kZ3EiuJqH6rf4Gds1Pwf+cBnLOaXebb
	 5eRv8l5QIDWVTKhiBguc0HykcJJbzHEkJTVgIFLoQWuumgKKOtILVY/TCYPHEHJMrL
	 Or2E33rhujlZ09g8dBmvBp7+RMrao3JkinybKDCynCr+eAN0Q/t0nMaiJ+sn5tZBXJ
	 KsEIbocywJ9CA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] ASoC: hdac_hda: Fix hlink refcount leak on component registration failure
Date: Fri, 11 Sep 2026 06:50:02 -0400
Message-ID: <20260911105003.268248-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911105003.268248-1-sashal@kernel.org>
References: <2026090904-payphone-halved-2f01@gregkh>
 <20260911105003.268248-1-sashal@kernel.org>
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

