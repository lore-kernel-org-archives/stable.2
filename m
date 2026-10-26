Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013740;
	b=pAdW7VtHhcnNB1Qd2AAoUtq4tBB9L3jQFQ8O24q8Lt7YeYBndvovOQDGNKQlYXmKhsFE
	 tVqKf6/KyMXXNnxzBEtFdP8FXtAaFbVnGss7MqAc0oCJE+6WK5fOYmi6HbYttrgHtg5kW
	 dhIkS3gKVBSQfXIWSvnYpDce4Ua4A6/8wDX76Jk/rUInyu6rnwJPRWZTqxz6zKMuXwM1x
	 caCXTtdbao5QmhqRwGz2N996lOScBi7YsvVlYjaMHWcrLOcdi1WzpdeZkaCwgt1C0/dm5
	 TggM1b6SnfveSxK0Mdmltx9OxtLEmNFb5HIJohzvn5iKU5xJNbCh0XVpPbuylDpAffA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CshcBQHuBaiwBblArFZhJHX0pEvJjKnI4lGTEeUq7uE=;
	b=wQUCbfXOVAMNwPKGDXFMz47kT4zNrkhAovCX6F8D8Y9WCSCtfcTVaLQYyCpLCYO7xxVX
	 4esGLBNK9Z2pHzSDVYmI8wrP6WVbuw2ljxgp5jAAIq/A8zMXPXPnYNbsZf+J6I0Dz5OCx
	 0JPVkGNCouffyW5h9+kE/9jbIPOx7wOmX/oYlaKZj+fM4Oa854dquNo8cZOlouMNi7ITH
	 d0wZfGNY9ykwDiOgqjfl9xhUIsnj5jrII6a9xKl3eDO6igwcpDc8IrhakBS31KZ/AxS3c
	 m0LZBATaGJCpIg7RhLQ4f8PtwSAAaNuVlK8ucMCspR5KGgoCnvHA4RhCYKsaZSgAUNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TFdenwJg;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66E60A3824
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B66E60A3824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TFdenwJg
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so18452515e9.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013739; x=1793618539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CshcBQHuBaiwBblArFZhJHX0pEvJjKnI4lGTEeUq7uE=;
        b=TFdenwJglwNv78LJK9io46mIH7dcJiPtAvl2c5mS+6t5BMhQWD+/S3rvX+JHd65u9U
         vvJjqUasRgLO1SpwM6/z6hp+r1JEwribYZ3Qp0tubHcS90ocoANwbjuynh0W+H5ph9uF
         cXVX7DPYaA0VmMkZHwiDqudBVhDOSRxbb5QH2VYsGD4WHCXuYkL3gPxO4VGpJtK0YMsZ
         XQmlXzoQBwTCGi47a0VdF4bFHmUFmyeri82JyCdSx8ts7TeDK85BEBSyjPlLXa25AG8Z
         G59qbHMMWgPMG9n0bzJSkC1kUgQDuMnPbnPRAADAlAPUOi4YzhCIiYZKBmzuLtrnqBIm
         ftkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013739; x=1793618539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CshcBQHuBaiwBblArFZhJHX0pEvJjKnI4lGTEeUq7uE=;
        b=lwTkjLNCaL5ftGoXOzcUKnXILq8rlY+EIT/ej8CJsHuBaPl3C+AYslLthXXLZoKFCP
         pUnykaXYxNhH7ZjDsngEwtVWEqIuT3EDrJtH3/x0EhSfAAd4tIVE924HuPVMFo+zWkBH
         2IlzRdFNmJ5SiU+FxThckhN4UpTC3VS5t1MZzsTxLeiAkDK86A8qg5KnGMmCyTFRo/w2
         D08rUwCKqJgiOcAXUOFlPkKc+HWT8sgjX2M/3LEZ8jbcAPrVsSHKyOwr02jX14OIYAKb
         f8LOLc3foMHY28OrRP1A2XchULW+z6sqNM/mXhG+vp6B+DhMwn3uo6RIuHXYTU8VGkNv
         5K/A==
X-Forwarded-Encrypted: i=1; AKwUvBw8xVgdf4PLKq7QsEcHpZD9St/sFyckCGtqnyzIsMNZhjrXPViWs0WP+EqRe6vQM2FZrG2s07s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIikDM7pkkWUkxp/DTUxksK+rzWkJf3RDkxLiNv62R3Gn682Xr4
	YXf9K4KRtIRdkOGfks/zKL4tfnJ0ohRlradEVFXYbwMMQB9KDd3X+8E=
X-Gm-Gg: AYBFou2RBiCK0PLYC9BhV9dbNmf/okh2QEB37CiSutzx7evk7XlhL7X/Xz1RT1M0YjL
	6ydOcm9JLfEJoqSjuOQIjaLNZMHVdKuSAcXBtVa7cykls5HPeUpZ0gllOYIWPjUbNhz+XNa1kQy
	opvFui7Izmy/cd4RrMJsk//Sp/n8eCb00viROgGaPcHDqT70J1RQXYei/d0TG7cSGiHqFFyEbia
	hj36rKFRBhERI1gbeMLMjJKg4WWnHCTwq/FnRt9LGKqDRgPPqAKkMl+1aRR9QD+Ky+IBNDeOhzY
	Vr4cBzkDEWdpdxY6ccF1QS7r6MV0VmdetcnHpiLOlcMYbk8HxVipBn9aPz4ja+LYtWhI3XEJKEU
	Cqq/A/6nzS9IKscrvFAbP0Q/UJg7ARs2AK/BXCiSHSQhbyEZeBm+cOZvmhfjTrXFJWbJyKY8nOb
	25ia0la919is7xIVd5CtUbIYdBfYJe/sauqPOlDMD53kpz3Tjav6Vch+25EE5bRy/H29QoDRNvr
	MNOHurhiJ0NhFK596hGXA4P
X-Received: by 2002:a05:600c:1c06:b0:4a1:e7ce:107b with SMTP id 5b1f17b1804b1-4a35ac407fdmr160741305e9.2.1793013738712;
        Mon, 26 Oct 2026 04:22:18 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f59750sm129141265e9.0.2026.10.26.04.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:22:18 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Bard Liao <bardliao@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Jorge Eduardo Candelaria <jorge.candelaria@ti.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 4/4] ASoC: wm8994: drain all delayed works on component remove
Date: Mon, 26 Oct 2026 11:22:12 +0000
Message-ID: <20261026112212.2519775-5-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026112212.2519775-1-tristmd@gmail.com>
References: <20261026112212.2519775-1-tristmd@gmail.com>
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

wm8994_component_remove() frees IRQs and firmware but does not cancel
any of the delayed works that IRQ handlers and DAPM events schedule.
jackdet_bootstrap can spawn mic_work (via wm1811_jackdet_irq), and
wm8958_mic_irq can queue mic_complete_work, whose callback may in turn
queue open_circuit_work.  If any of these works are pending when the
component is unbound, they fire after DAPM widgets are freed.

After freeing all IRQ producers and before releasing firmware, drain
the full work graph in producer-to-child order: jackdet_bootstrap,
mic_complete_work, mic_work, then open_circuit_work.

Fixes: 99af79dff5a6 ("ASoC: wm8994: Ensure we get a notification on startup for jackdet")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 sound/soc/codecs/wm8994.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 8bf58a6a8af7c..32c1786bd48ef 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4592,6 +4592,10 @@ static void wm8994_component_remove(struct snd_soc_component *component)
 			free_irq(wm8994->micdet_irq, wm8994);
 		break;
 	}
+	cancel_delayed_work_sync(&wm8994->jackdet_bootstrap);
+	cancel_delayed_work_sync(&wm8994->mic_complete_work);
+	cancel_delayed_work_sync(&wm8994->mic_work);
+	cancel_delayed_work_sync(&wm8994->open_circuit_work);
 	release_firmware(wm8994->mbc);
 	release_firmware(wm8994->mbc_vss);
 	release_firmware(wm8994->enh_eq);
-- 
2.47.3

