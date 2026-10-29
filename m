Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309116;
	b=CPYx2MbD9Rc6GV5vu/fjCeagKXo5pyKCugw2dgyo0btVu+phWIdSmI1M/0zzSg/AMlac
	 yCB1Bl9RLRgxBVZjuZ2UG0SVGkQohhsuAnVL0RKnXniho/ubW/JoDT4qxaECO5l1X6U9W
	 8Krp86kBFAtpSB4qy97IqZE879il2QKlB5/VYVdEpX9YS2hWL0e+KFNZbaQXwnEPVO8+6
	 21UuqRsttXCwvu2m0C381Vd/Zbvo5CjT16WtNcRSSrhuLzW8zexmmY4cNZbFdwVRxBjj7
	 mlCOP2ZrJJMmgrfCaTi1BL8aGWkxrlmqrNhFcmKZmofbeAB+GoxyRVaqsfNWCjo3w4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CrBgGQGqJWx1uEEiW4SUMnU3kVwTxs6ZeaQFQV+W7qU=;
	b=mcI3mMdWbBqykzg0Lmh+Tk5FdRCEVghYWCKYi1wjl5pE3j0RuxwODmBK2DOAfNHEyA/i
	 3scQ/dri5VDZvHlXe5wgWIyX0nRvYJn9xz5HtkttcXTudrh+E2amCFfc3mpkQAa/l8cQd
	 n0CK4lClgLPSPIk/JfYXjqjlQoGfuGz8ZsqHrpRfc5Tegg59mOm4wU0QtgsSea1TuHFOT
	 JIkwKh897JOaI6GHxnzOsGgTppEIdH7Gpck5WdAtbbgfIxeDPC8L5R0Vfgc1EePQH6j9K
	 A5q5f4dXNoTD/VFqLC0sTsMfNluFrKwCKy76aEhaSQYtCn44hSxARQ8tfZKaVm5Y2HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NvBz9EMb;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FCF606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91FCF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NvBz9EMb
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e20edd106so54403f8f.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793309114; x=1793913914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CrBgGQGqJWx1uEEiW4SUMnU3kVwTxs6ZeaQFQV+W7qU=;
        b=NvBz9EMbBNWMWUtdMwyCKGDsrgIhnBkizGABdNpwiy7me54e1kGo6lnvZhmOZAoSe5
         QnnmQVCKoS/n33QU34KyZjVYMJ9D0hwFQMsbSVeXOFXyPjQinn5oAXHxd8wpzuMh1oyr
         jGMEmweXumAnzR9wuxPmCpfycogCixBtEoF4zN6yqmhJwZYClX4EjAm8lUUmx8Flg6G0
         LHaFklDzpmPbheMMRXZV/2tIacv52V0CmSQYevr37KUYX9Zd/epIVaIAZF/xkdo3lKrs
         j67487t24sXSxn8L112RH9S3a1UU3CTuKp30/t0zJaW7P+qeWxhvpLyNUsFmEIux0nFX
         XtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309114; x=1793913914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CrBgGQGqJWx1uEEiW4SUMnU3kVwTxs6ZeaQFQV+W7qU=;
        b=IQ7ro+N+U4FGNKJHCa7YeBtQvRe1kTfMtpo1geLEFIxy8AKiOUiGS6IGKHmtUN8NWo
         iGsM9JlxVtkTt5a6zKOCbIuG9P0xpvevpZQv0GSwRK9QVUYZwx1oaLwSBd+WjHt2eYig
         /vJ8obRQW7OmFXBRwSqqd3uJZrkWSHoMnLl2jjlWbxLL19fE2YKo9/y6VHLEwRcLh6j7
         gKhNIIwdz6qtwpwSHRjG47HPx06AtmoZviymD2SpzofrbC+DUomWCpzi5jJfurRNSWAi
         AxAhNvFjseChSS3RxENRULslsW/bjsPXudvlbEUtBrSVVh5j+qp5mYnwww0gkl/QJj84
         2DTw==
X-Forwarded-Encrypted: i=1; AKwUvBy8H+unSoypGvLPYSrVvgfEKHDkOhubzkLwZXR/vjRVFDgre0rm86uhprGE406Ive6RfFtkNLY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtp1dLTIf1aOP1igmQkUuEEjb00XryK0T5EfzA4ve0qvfF4Uko
	WBUHNPlxnBxnI+/qKfW04oiRG7L/Egezut1Cnceb5ldeGEpnqpGhYj0=
X-Gm-Gg: AYBFou2XWs1nlsW8LftAvfIKszp1GGtBI/1fMc/gK2zvlEyz7sLl8D2YuA/iDU+dumA
	sIZ0RBJ8Z0zy9JPTOjj+FyKZ5ThcQmRSLPe0avwv2NpJM2OK6yoKg7YThL7NTLjK9t5c0xzsPky
	kzy12OLW3Q+pXqIghzIyTmQunglie5h5zK387SlWUm4fidqSePJqepYauUnlqeXUYxzj3XzAfQL
	oJFjcrQTHMAh2Fzcy0CDPzdpSVqEnifm6b0WMJcXkZSaxlFiMV0zKYxaLFB0Lo320k6w0q6j3EP
	tnZcNDPMdOtrpIOJ3RX/8KZ6A/RBWTHJTm37kZcyrfX0UPTJfk/ZY8kzkvlLTbpLm1k0Jy0WqNm
	RNsiv3eFPOHnqhW0/tdFi7qDZqAHDgXyx4djWlkD74kZXLaaesaXR/8edn0TZhmkzq93uG58f4r
	Mlx+ArlOlfjpyKs12L1VwFKWQTXhDPDRmLQPAmiAOAaUN1uFNzwZJAHGQnv+Ix6hva5AEdNYBMh
	nTrKfJPsxCz0H8/9gaIVnc0e36mhkuGliVieCC1cMTOQnTpfs+VAo9Xn0TlMVfti0h+Sza5BQ==
X-Received: by 2002:a05:6000:719:b0:48d:fbf4:895d with SMTP id ffacd0b85a97d-48e6e2e7552mr1275586f8f.19.1793309113574;
        Thu, 29 Oct 2026 14:25:13 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb82584sm714873f8f.27.2026.10.29.14.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:25:13 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <bardliao@realtek.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] ASoC: twl6040: cancel headset jack work on component removal
Date: Thu, 29 Oct 2026 21:25:03 +0000
Message-ID: <20261029212504.2997364-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029212504.2997364-1-tristmd@gmail.com>
References: <20261029212504.2997364-1-tristmd@gmail.com>
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

The twl6040 codec driver initializes a delayed work for headset jack
detection (hs_jack.work) but the component remove callback only frees
the plug IRQ without cancelling the pending work. If the IRQ fires and
schedules the work shortly before removal, it can execute on freed
memory.

Add cancel_delayed_work_sync() in twl6040_remove() before freeing the
IRQ to ensure no stale work remains queued.

Fixes: a2d2362edf9f ("ASoC: twl6040: Add jack support for headset and handset")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristmd@gmail.com>
---
Changes in v2:
- Resend as part of unified series (no code changes from v1)

 sound/soc/codecs/twl6040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 650836f9615fb..43feb660b635b 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1135,6 +1135,7 @@ static void twl6040_remove(struct snd_soc_component *component)
 {
 	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
+	cancel_delayed_work_sync(&priv->hs_jack.work);
 	free_irq(priv->plug_irq, component);
 }
 
-- 
2.47.3

