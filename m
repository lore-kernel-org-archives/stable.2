Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E4F373C00
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509492; cv=none; b=Teqy7h2Bg9QJoPQQAbfwqJj9SXrzE022wHSTQZV41M8k4H9mniVW+4BIGTmttolnjo+3q/eME43nS0bnXw9znISMwBVySv3GaeyJEY2tAIpME36L89OgsMywNxW3A8OgBZpLT3hxZL5QG19Fvv5ZufXz9zkEBNBw0kCROwIYCug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509492; c=relaxed/simple;
	bh=8JgR3faeGlRVPEBTlS0J0PeFqUo9krPvX03s9XENbGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a4i8z6Vp16yi5WHeQkWd8xQF03wj9JjFvi2TlSZRH8mKJ1fYDF/dchoqM0Q9gYzr/TvrhxGS1HoTOKhmajUYajNBOBkb6lSPRdxykqMA5LZYJFx+VzFeSBHq0bW0DIKov03407cx9mTaiSBDlXCS+UuITlenhD2l1LyZ6X+My7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9WUHN0R; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9WUHN0R"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304c520fe9aso2945538eec.0
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780509488; x=1781114288; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KgSUwufu0DBM9d4er96QRPnvOskLS4/KoB1eLfgcG28=;
        b=S9WUHN0RFlucny6IQUnGH9LQAFL3ejs90uZsfiyWqFipXfxGfbGztuuujtwfVipifO
         fqn+Z4FGoNPEqLsxpOXb8RoGLChteD0j6H5/MOuDa1+iG5lf6zvtGvRR88cDhjo9m389
         f3JR/VHVuXZOkBMYNN5rsISvXUzQ/Hc7MvQ7eYT3Z2sGSL83iNY1icOHrAmkBgfX7eUl
         ID47n4AUQSDBgRJfJ9xQjoJzeotd1CzHvzqlmAg885Vkxrgoc4wE6r9hF53PZ3ioDGxh
         cfAxzVwHA1tN2HlJTmW3rJP8oYepsoAgYl96UROlTQI/ebfZhmXZqLSHIwLQU1dYQ1XL
         L63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780509488; x=1781114288;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgSUwufu0DBM9d4er96QRPnvOskLS4/KoB1eLfgcG28=;
        b=YSwn0ILybj3o4adaJ3EKMOdC1/1J97GQ+sdOos5NIxFlnT2KfKIsmiG8fxYZITR7nx
         uaT+3DLvKRV57SupKbifv1sVgAQF65zHhblGedFN6XWigqD4ntQbgGqakX5ekhQqiRJD
         OXjPru1SOT6EoYg36i7q2j4Z+AyBpEDfV7NO2T8PAud9zXlHCJxPpugS4yBmVMLN2Pl2
         /ofx0rh7B2fC9icqKJzSVSGgSg1tyt5o55ydYzggv7C0CpCDeCKZidRrdPBL0I5YEOH/
         Qpqw8XdtdOpGBzhY9KznUh6lz+BQ9tZfw6UwBz5+tm2/evlFSR7hO0yHt2WnppoRcl40
         T6Xg==
X-Forwarded-Encrypted: i=1; AFNElJ/F1X4phkjfVVz+UzJuAGgHf9pUJd0InJgDq0KTc4lrS6xW3+vexY8XquzQJ2GFQmbFKr7wuyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpYF2J5dWPTlAmJtVicK8Y477MCQUjdU1X/dDI8KMRZcMxG19n
	o8NiVO8OaR+QRfeaExVSU6yMMOmNM1085i1g7AtBuBSHa7+i4xz9G5s/djYfi9ci
X-Gm-Gg: Acq92OGE2TjnWl4dRxkTwoj0HzHcvui1AvwuVEA6ZLkt8RrOk4hFIbIdHYxC6DrAHAI
	1s1b1k9fJIVeaRZaQYTA38n1VjhPngNZJbJ7RyYYVtLSuuYWxF8R7qleZsTMxuM05Myg67kbMFm
	1fo15/bLpScLK9gFUDYcgzD/md69djS6j1+oFxtAquUpjmE8oITZdOI6lTpQwSevbaNgINeoSlO
	1D/Nw+AWxES6MZ8dzdbjlgo6nVUiDzcQqB4w+BuE4GRMNbDdPTWzkIFcfbiTzOHSqO5XFtoFutJ
	TvoHXbcxsp9jvlwHMX2eMzkgzyXE3wbNQhtLASOBGDbZYZ2EkYiIw+w1P2sJjZ51ApzLOf5TAlK
	qBXQNY0wJF/1dq1nFPTsekoOpeHG6rTZz8DlS5Tcqdi5ro9v3Qqg6TZ6NBEi+VaY+w+Z6FTJDm0
	p2AoOSItorw1x0pEtaCIeoyhahfeTaSOrenxaPB5igjTmxyzC3E2mSwJxiR0F0+7rOWLpp7h+XP
	59+Y0xBpHjA
X-Received: by 2002:a05:7300:dc8c:b0:2df:7fe3:96a with SMTP id 5a478bee46e88-3074f843547mr2258920eec.0.1780509488123;
        Wed, 03 Jun 2026 10:58:08 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-23.user3p.v-tal.net.br. [177.4.161.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db56697sm2956046eec.2.2026.06.03.10.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:58:07 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Wed, 03 Jun 2026 14:57:54 -0300
Subject: [PATCH] ASoC: SOF: topology: validate vendor array size before
 parsing
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260603-sof-topology-array-size-signed-v1-1-84f97879a4ef@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBCF4auQWTtJgcjCqxgX03aoY0xLZpCIh
 LtTdfOSb/O/DYxV2ODSbKC8iEnJFe2pgXCnnBglVkPnusGde4dWRpzLVJ4lrUiqtKLJh+ukzBH
 dQD5S8G2IAWpkUh7l/Tu43v62l39wmL9V2PcD3NazP4IAAAA=
X-Change-ID: 20260530-sof-topology-array-size-signed-06abdacb1cdc
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 Jaroslav Kysela <perex@perex.cz>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, notify@kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2158;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=8JgR3faeGlRVPEBTlS0J0PeFqUo9krPvX03s9XENbGg=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFkK2eqvr9u/OWZ8JK0wRPrenwvXg6cL833m9A+9dPrQ1
 DXnOVv+dZSyMIhxMciKKbKsTlpkuafrwdX6uBUeMHNYmUCGMHBxCsBEDLczMhyY/SXmeYvo/K3Z
 flenOqTr8HNN2f2iX3LJsSkLO4Wui6cz/JX96a2lbq2tcHO7393dR04EyOqaey6SNt627k77PjP
 7F5wA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83

sof_parse_token_sets() reads array->size while iterating over topology
private data. The loop condition only checks that some data remains, so a
malformed topology with a truncated trailing vendor array can make the
parser read the size field before a full vendor-array header is available.

Validate that the remaining private data contains a complete
snd_soc_tplg_vendor_array header before reading array->size.

The declared array size check also needs to remain signed. asize is an int,
but sizeof(*array) has type size_t, so comparing them directly promotes
negative asize values to unsigned and lets them pass the check,
as reported in the stable review thread reference below.

Cast sizeof(*array) to int when validating the declared array size. This
rejects negative, zero and otherwise too-small sizes before the parser
dispatches to the tuple-specific code.

Link: https://lore.kernel.org/stable/CANiDSCsjR5NHqu_Ui5cOqWdJgFqmYsQ9WR8O7m0WOhngaYXFpw@mail.gmail.com/t/#m9b3be379221e79327cc13fd71009287368ef4f23
Fixes: 215e5fe75881 ("ASoC: SOF: topology: reject invalid vendor array size in token parser")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/soc/sof/topology.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 8fc7726aec29..bb6b981e55d1 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -740,10 +740,13 @@ static int sof_parse_token_sets(struct snd_soc_component *scomp,
 	int ret;
 
 	while (array_size > 0 && total < count * token_instance_num) {
+		if (array_size < (int)sizeof(*array))
+			return -EINVAL;
+
 		asize = le32_to_cpu(array->size);
 
 		/* validate asize */
-		if (asize < sizeof(*array)) {
+		if (asize < (int)sizeof(*array)) {
 			dev_err(scomp->dev, "error: invalid array size 0x%x\n",
 				asize);
 			return -EINVAL;

---
base-commit: bb451bc01ea42c9e47557638400708e20df34178
change-id: 20260530-sof-topology-array-size-signed-06abdacb1cdc

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>

