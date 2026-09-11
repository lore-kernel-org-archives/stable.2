Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5962F616B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090513; cv=none; b=jQEmuHnlG8nKha+pc8khHt2vagTgvRgYZ7YpXkg/SkSi25KtDiHb1RS4j+nr2L5uNSVIFD98aSJpxeOH+AufylQKBmaB6RrXoOZiZdiMW29WCGuhArcFby0i0lPn1br/1LX4YipgcsFtJ6hUB/5MQymSKUGA+wOW1Mr6ictAX/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090513; c=relaxed/simple;
	bh=NW0e7OBNvr2u9e0tnudSpfACagteMKWcB9n8nazs+Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8wqsDwoQzT6LVmlinlyJBbvrbY0tw1ZSiVjnHY2efh+YOqDq1Q04SYIwUE3p260ucyn6UDJkkB2wTXZPtSSH6zvSPD4WiJkRC8coeAUpE4OsA3Do4wVD4MEmYz+GCToh56jIbmr2xB5O2M+Ktq8xKtjPLWVHP1j1/PxVjV/mFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrOnPwVA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrOnPwVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137D81F00898;
	Fri, 11 Sep 2026 01:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789090512;
	bh=lpjNVFsTk1eTRqdg7IPkDsxqoBfz1qsxXu2UPHt+krM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NrOnPwVAiqr3795tKs+1JewrhMRnNQQRhEaKH71J320S40oZmLtdQ/PN5u9I/7vpT
	 YzPJ8YOQzQiXQs4NzcMKcalWeDjvRV4qrCdmvv7SjaKVscPyBAcQhpOiqNC4kXc76W
	 zjFDvsHriUhCNta+ftlsVSr1erexp2IAAqUq+AF0KyXgJZKIEphOOLkAi/3wWqMXyK
	 fidaZXzkzgT28+7YdorLTTgkqnoMvXhAQrgiJ1mlpgBr1zWWByCG26L8YWJvC4L5Tk
	 8vHAtsLoowNG7mQwN+2MTmiSVwJjkMR7c0fKYCLMNfELcRCX77OoaeUvH3pztj1Rm4
	 cKHj0uByTyiQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ASoC: hdac_hda: Fix hlink refcount leak on component registration failure
Date: Thu, 10 Sep 2026 21:35:09 -0400
Message-ID: <20260911013509.4124555-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911013509.4124555-1-sashal@kernel.org>
References: <2026090903-snap-maker-9654@gregkh>
 <20260911013509.4124555-1-sashal@kernel.org>
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
index 3285ebe3c7f6b..943cb197293f9 100644
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

