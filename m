Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9643030F958;
	Mon, 22 Jun 2026 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140275; cv=none; b=JjIyYKgBJl05OMSnNUrk5kIVkF2IKHtbyxYojZdJe7przvXyCNCYqUQtJd0GQDbpJjkggvlwcmalT6VVaswUYnqUT7aVvHeFegVgEerhvxMhCnENsdVfB34iNpU9Mrzwj0pmdDn3FO/AzwYsNUjTROB0MxIv2MWqz/5xjSKQO+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140275; c=relaxed/simple;
	bh=YYf68g1Rg/bNLATb9mULw2cV5WPeFjqfRq0ysdUgXGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i4w+pp2ckfawFBzRRs+wknuWqawmllhbWBVywLWJbO1iIgFEO/FdFR0eS4Dr2Z+DwpB3Xqp/S40ukfYb6oW6PSxdDoWvIAdywlqDT7fohlZavM5gEVTTTRc46fF+swfHdCMuFvuLD4C8XiEEVJYERfvDWivudZnuALAFnLwBE7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G1wDpdAS; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G1wDpdAS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ur
	UO7o7/Wt4Vl34crWwNFTWFoRKfVps2Hqy9BDR/fK0=; b=G1wDpdAS/M3aJVDp/r
	Oyyk5DH8nL7c1wk/jZqNs0HaSlUNrID5NfaRr4sabndiU4/SVTbq1ZDOujOaUfzW
	yQgF0sA7dT7gpgqL1OjblOMXeORXRC7q7fbiZTHTYuhcvgNYR5EcIyWzVoOalgSe
	68euzoXjijM9EhLsSz0kO+NoQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3P5UtTTlqJpM_DA--.33730S2;
	Mon, 22 Jun 2026 22:56:47 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	ckeepax@opensource.cirrus.com,
	kuninori.morimoto.gx@renesas.com,
	pierre-louis.bossart@linux.dev,
	rakesh.a.ughreja@intel.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: hdac_hda: Fix hlink refcount leak on component registration failure
Date: Mon, 22 Jun 2026 22:56:45 +0800
Message-Id: <20260622145645.1184986-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3P5UtTTlqJpM_DA--.33730S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF17WryfWF1fWF4fKryDKFg_yoWkuFXEk3
	4vg3yku3s8GFZrGr17CF4rZrs7ZFsakFWIvF1ktFy3Xry5GrWktFn8XFn8urW8Zws3WF98
	Xa98Zr13CF13AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMyCJDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hBItmo5TTAGKwAA3D

hdac_hda_dev_probe() gets the HDA link with snd_hdac_ext_bus_link_get()
before registering the ASoC component. If component registration fails,
the function returns without dropping the link reference.

Always call snd_hdac_ext_bus_link_put() after the registration attempt so
the reference taken during probe is balanced on both success and failure.

Fixes: 6bae5ea94989 ("ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 sound/soc/codecs/hdac_hda.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 680e341aa7f1..1ab5f8a26e03 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -642,10 +642,8 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 						&hdac_hda_codec, hdac_hda_dais,
 						ARRAY_SIZE(hdac_hda_dais));
 
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&hdev->dev, "%s: failed to register HDA codec %d\n", __func__, ret);
-		return ret;
-	}
 
 	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
 
-- 
2.25.1

