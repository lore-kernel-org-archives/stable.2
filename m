Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D391684B0
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006615; cv=none; b=V/ha8DirWRPOG981IrnqGqMXe0JQ8qNGzhHfQqeFkiWmenYFf1nFCGWn46DbPY+J3wokyWjrvdy/FLe0yItCtHq3QuBBshsuD91cJmH1KtOh82IJgmn8lUaNenXHdcUz7mvvEszT3lT5u4rXnmXFf70jl2zOMx13q6dW7KMe8Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006615; c=relaxed/simple;
	bh=USkmMPn2m09Xmxz+sO494+k/+nUWOFpUeajtnBtALvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YHCgAIhKxkdPp3Ea60FME/5KpP6daIDSDyXPEvDxEYTC2zGJ7tJmQVnBnZ5a4uHKB31kYelSXZbGur8wNkiGVwT/zmIGKI3/qT4FjZqmHC3/NEhpvhD3qIU69vTMUjtCC95vMSZj+M1ahKzT92PqKHGP8vHPQQI80KiafFu7/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=BWywT8FZ; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="BWywT8FZ"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35943f55c06so1249602eec.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792006611; x=1792611411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mXryqq8En0eicKl9AiPDfP6M0h2TRJ9mlYrQGAexp7U=;
        b=BWywT8FZesJEgXYXsd6YTzsS5DeysiKSlyRtxbT8vkjrhhYGZvH6rqUynx2nJO+J7c
         8X30uTdvUS2Vaj+i7JW78f+KUkYfG2Xpb9IsqBdhyb+8SIrmgSAfcCSCMc6JJuhon1z/
         sqAnFl61jhQpNf8g3odlMb4JsGjRkfzzl5mKaC8+SPskOVt9BGjJcquHmUAoL2PrjrkD
         QS7XmQKD7WEgPNNOcvvyaPzMd7OhA8BT5vJTF0qd+4dWuHNP1+kFSI55Y8M9lgZyssZE
         iRLe8eP8wM2ERFQjYMROc7FvOZNj8yZ7DnlisN6ysiaKBMjRpOUH0QQHZuS2QU7LW2yt
         HX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792006611; x=1792611411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mXryqq8En0eicKl9AiPDfP6M0h2TRJ9mlYrQGAexp7U=;
        b=0ADvF2GkmuyYZ4LDr7FgdbX+S8AuntRyW5NuDdozmKVmIQhdVBFTbeTyO62Whdn4xb
         BpxsceZudpjFxrYr70xMZqk9h6hN9lo731jjBT9hP6UNmJkivayEdcoequpWDt2d03r4
         XEhY7S/lrzu4xY1KnWubshWYAp67h1xAXpZuJZ9UGUh/Z+q2qkL6zQJIy/X1xRHtLHN3
         VPRsBNJcEHDXxXvcsYaTbP4XHJ9Vx/tSoojzuhf3TF91fAXIvkGt+UZQBCtVqBZKEoXJ
         YGpPq7n3k4H/eaJSUX21/AdMNVbcFvjqmtDG7DIhRfyS5HRpS8gO5eKPml1xXE/L43Q4
         2B6Q==
X-Gm-Message-State: AFq9FYI0DDtV0xvzt7DNDPzE4m0t0iS4gYMeOJcYphRzvgdkmPFeZiXs
	h/fuaVEqjE+3O4kTqVJIadkvyctPfJycIHwkd0PpVBEZ5iy91XrBO0TtwiOUZIG6SdRefmrP5As
	9ICNZv9OpWQ==
X-Gm-Gg: AYBFou0/Cb8j+bqR4DtM+vQInUH95YUibjDXl8/pPbzPAK/ippesISbz3dWzRpg+wbe
	a6n8ClwYIcVhH/QeMQCnLrtgsYDaLkfzxleVinhRsj29DoQYCB1/+uwwaoYDeLDHEaxN0glg+we
	Z51+ZhSkyVqFMb3Ng4rwfzSGwvUk6a2J+8rafeub0zrQSSo0OYFjaX7m2Og1ac/xXZzcNY8dMtC
	w49RUNS5srd3E9kAaBGO0xNQYprIoF4pIQDyHcPXBxb3hHPHTC7veMkC6SKe8kiaZkxpHP639zS
	cf081SbdUYW+v3qaZN4NhXBMH5tT93TzmOPcTN9sEMK0bZqstWIGMDqzHxpHZKsBjnjVeBTOGww
	RYeA4cKJo0Fm8HAVQYRK1JAizIgVC9SIc8oUc3OwAuFEN/FpuGNYvpqDVYjglu6fYA/xFpr46hx
	+4ICFryBwJtzVDCFdVMTA/1ULtiPRQ1AnKW1Trzx8p0mBT22PSOVLaECVUTKKiK5I2KQTdnXumB
	6/sUELBhIEX6T/U3HaoVJObVFnK22FWy8zAB07JVqdO3RtFsBp2X7ehLAj0z5bkDaSDDr8=
X-Received: by 2002:a05:7300:c87:b0:33e:61ab:8309 with SMTP id 5a478bee46e88-3537b291a93mr31801619eec.23.1792006610878;
        Wed, 14 Oct 2026 12:36:50 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b53dsm50852306eec.6.2026.10.14.12.36.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:36:49 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: broonie@kernel.org,
	haoxiang_li2024@163.com,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH 6.6.y] ASoC: hdac_hda: Fix hlink refcount leak on component registration failure
Date: Wed, 14 Oct 2026 15:36:47 -0400
Message-ID: <20261014193647.25131-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
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
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-89944 to 6.6.y.

The code changes are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series: x86_64 objects
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 sound/soc/codecs/hdac_hda.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index d59d38ce5657be698625fb20235decf6f848e712..c497354251cb2bb4e908d36675166a0b5f8a2032 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -612,10 +612,8 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 						&hdac_hda_codec, hdac_hda_dais,
 						ARRAY_SIZE(hdac_hda_dais));
 
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&hdev->dev, "failed to register HDA codec %d\n", ret);
-		return ret;
-	}
 
 	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
 
