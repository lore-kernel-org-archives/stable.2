Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638432;
	b=vkl5uDg7nIh0i1oC4l6IiSOwi/fKDzB3NeG964x/OK9J84X5MlgxC6PeQFFYKz/rPUx6
	 +hC5Uq9QMIkdb2LgJm1MbIwQRTfrqgGhx2pGz6RK7vOWO7RPLw/q50Jcc4ucTCVoAs61U
	 mD2EkkQmyREQCyoCTO1IIS375W56rH4J0rTmb5F4XHLTw9GYrJv9p8d/5LniGEZUt2mnq
	 Fa9HbcGKiQcbn5xU20D1Q212chtqlpEVmQxT0/eopIOBiXQalq8zWVF2sVyoSf/pJ9wNc
	 DWFm2C3lPFKj4fTG2rKGbhxOQtb0x3YSLNoqc/u7mL0Mp8ACJHAXy8TMZ/c8KSvyC8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DK7v6wYvjpWGWACA8NpEPyZSTxrM2x1ZCEappFkN6jE=;
	b=BZ0ahC4jrrv29/Csa6tWShd2UdvOQm8NKyiNqP3hBFK4RE7c319smUIE9l8+aFh8RLQJ
	 L0oA1k4JXF6EBrFQ6FIWZjHyc7Cyd7NB3f3fprSxVx09ZO5luUGfGM4tr3XKr4E+H75zZ
	 Is5XlGRzB4jEe2e5SmjbuiCF/4k48ZBqVQgZ7HK0O1xixkHwwtolrXVQrdAonr+1wKCm/
	 lrSdMKOgNZ3aJdjROfyaNxkhKWcCNOet1rD+NcFfYfoqX4IvdS4JUUwyDMNE4Vcgxfl9F
	 JkBZzJMNYZWNw6RUvzAvR8T/b/ugqLem0fb7NBi/7SE1MO7Agl/cUG0obh7/vYOuJpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NWGSDNLL;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1898B6079921
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1898B6079921
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NWGSDNLL
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso2248977f8f.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638430; x=1794243230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DK7v6wYvjpWGWACA8NpEPyZSTxrM2x1ZCEappFkN6jE=;
        b=NWGSDNLLPH+2cxYHnjacGqyQ2u8p5nMXfGILetA9gvSqfFXJVOIuVfB0WLP7qg567z
         ZK6WfmQ6c4giLDzbEFKOsAX3ZfZfXQ0uG7JFqklr5F85wOi+G4YXUrwzA7ij2/US6TWM
         PQknLieXayUVHYyTtjIN5RwuO2iqB3dQF0wyAjtXqKvz94EA7Avg6pO1wG69RsZFnI1l
         Z+tFOgU0UEHZFep040jTC5Fo33ePSGa2kqi714wQYOzJM1924OENq0Ew3vGM8d5WtYB2
         bGzDOGBJ6aJYWEdUHhupISXNA8jlUV+JeEH7RIrud3dMFPry1OB0AVeDbiFDfVNMN8tY
         gIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638430; x=1794243230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DK7v6wYvjpWGWACA8NpEPyZSTxrM2x1ZCEappFkN6jE=;
        b=FfEybjV3DxED+5tSg4uji6B7+MJZj3YW0A3J6+s35DUDVHo3PVxKgdLv2wO3cvXuWN
         sRq6V96eKymInuGg++rXuD9TSLgjDkBtC8iI9pSBbhzSnS8/LCVnqfWMVdmIo36FdrVh
         PbBqKc9hynSYOEwEfshhBw21WmA/MQuLtNmlBPsynZMbh6n1ZfITYN3hvy08rqsb3WJa
         ClhFa7Vd6ci/7TDZ7LQ98Ic0obykG5xXvsgFoQwfN9nDMX7xvmBCZaSGK4lGfSdVss/3
         yYDMBJCLi9wQ0LC5rWZsouTv/Odb7kVJefg9GpkZJDkpJKawxkDo66RtmOqF4QoK5gF/
         IwIw==
X-Forwarded-Encrypted: i=1; AKwUvBzJEnWlAzNsrBTnIFZogPwcJ570Qg5sL2y5XmQoFV29RlofkRNbKi8ZSx6S2zW4sQKrJ1S9Dbw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JzU3b5lJg48/1EQ8mKDjrBPFUY8a7uAhc2HoTWzbMgruCqT0i
	qjpW1gea1MNmRwXLQaxqADDH3eURxPYril4xbmq03zNo7HpLBJCrgv8=
X-Gm-Gg: AYBFou1cbO7lW8z+ueTT+pUlku21N/4R4CPZ2re9C/RbowTUjV4wmQeQb9AOHTg6mQZ
	2X1a/wG+fn/2ImLSUgaIeYDyfWRX/q85ajdPHcaheO7QMPr/NDJucR9JUOGtp05sZB0kHaIOCxm
	bswNAc/64LBqADAnEnNmcMCk7LkTbySCmzeDz1bLstoj+44jI2gi0TgT3/sjHM7QC3o8ycidZsK
	ERHM/RVhwI3qMI8HfAGxMq2u80EE2zRbUB5hUoykKxAPlg9vz+k6nfoObEUXhAruNDiPGQ/hBPT
	R1oL10H/AgSZTVbB12IkINyncd/DlLg8NwMymFrpIE8/ZSLhPRK0wTIBKI9Qsjeuspsf9P7XnEL
	FYPb6fBcv2dXOaTICTWk5bVzjYbeFFKd+majnmefADXW+11FLeZUv8UcXCg7k8W12tqj6VlNdTk
	+7R+R3OWdf8zlmVX7WmGJFEqFIs8pDL8xCPXwE/oMpsjev/g4e5tC05DZfSstgvqkTp7aBlhOiM
	YoGP6GNITr9szqcG+vZ0pL/h8Dttac3/nwgjLJIT80QecaTu/mYreFlpyKCh5N9dEa7y6Wouw==
X-Received: by 2002:a05:6000:4202:b0:48e:6159:8274 with SMTP id ffacd0b85a97d-48e6e4f500cmr23446011f8f.27.1793638430339;
        Mon, 02 Nov 2026 08:53:50 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8e5f4sm21479385f8f.40.2026.11.02.08.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:53:49 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Bard Liao <bardliao@realtek.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jorge Eduardo Candelaria <jorge.candelaria@ti.com>,
	Margarita Olaya Cabrera <magi.olaya@ti.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH v6 3/4] ASoC: twl6040: cancel headset jack work on component removal
Date: Mon,  2 Nov 2026 16:53:39 +0000
Message-ID: <20261102165340.1558853-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102165340.1558853-1-tristmd@gmail.com>
References: <20261102165340.1558853-1-tristmd@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

The twl6040 codec driver initializes a delayed work for headset jack
detection (hs_jack.work) but the component remove callback only frees
the plug IRQ without cancelling the pending work.

Free the IRQ first so that the threaded handler cannot schedule new
work, then cancel any residual queued work synchronously.  This
ordering prevents the race where the handler fires between a cancel
and the free_irq, re-arming the work after it was drained.

Fixes: a2d2362edf9f ("ASoC: twl6040: Add jack support for headset and handset")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 sound/soc/codecs/twl6040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 650836f9615fb..826bde1a9ba46 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1136,6 +1136,7 @@ static void twl6040_remove(struct snd_soc_component *component)
 	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	free_irq(priv->plug_irq, component);
+	cancel_delayed_work_sync(&priv->hs_jack.work);
 }
 
 static const struct snd_soc_component_driver soc_component_dev_twl6040 = {
-- 
2.47.3

