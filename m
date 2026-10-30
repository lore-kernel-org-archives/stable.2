Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374929;
	b=LRHPO0j5PltEN2ubwDyFc3itGsT85EpYBAuPJkskSoT77XIX5Hx5REK9vTRSszQY+Nym
	 MMVjSZq03B5mCtzgd2YDPkMBd8ZrMMBiZkamMM/5fXD+RJfWf3to7vMvGl5rxru0YThTU
	 4sEBPW8OSxdl9xTYVy3wSCRPF5qzewtFtYge4hPBdHfey3c0GIKHrqQHNCw6LH1iPymwQ
	 RkQCCKtfCARF5Aqk/GfHJ6I5FkuKnMlCru3cZBcKqhcEkk+65lnrMMSh5ug63N2EjrHug
	 huqrkitQCBUxeUi+l/r0ofDU5N6ewBuocK1QiiFi0Sp+WmBnxnVDGnW7wLo16gAAIcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CaT2SSAJFNm/sn1nl6FBs7/CABv+df9p8PrN4R09z7A=;
	b=McxXWknqMTNjX8Sur4gpZLsGS7ZRE6qTTUX1sceIKslubK4L7AV6CJjJWv2983s06g38
	 5e6tZOP9loUKBh1aNTSFjjt6dMDDAxX2r2wp2dTVRy5MRA3L2oZrpdPXfgk86PIUFc+nB
	 y7MDuT1uu2PlBnDnotQh829v+VezasmrDip+I7leECB8nnwTlcvVy/wfhF5fa3JVQ9sIt
	 wmVeWs5Uuez3LspBZGvtHqIX0x1AQFjHBcPdk/vDWMNLQc2VfVVoej/z7ea/7xhyr2Piu
	 SDCz2OvR49ZGy4UihklnxJtsEJzLwwSbgT3A47WcuXLd82BcshCMEAGJN5tP3Vwjqow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CjxFBs1f;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42286606A322
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42286606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CjxFBs1f
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so7844475e9.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793374928; x=1793979728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CaT2SSAJFNm/sn1nl6FBs7/CABv+df9p8PrN4R09z7A=;
        b=CjxFBs1fG3X4uRzTT8eoecv8f/WX8SMgh85KDlSg7FGUwToLmqADTyWEyVCdBUVXWc
         Gk38Vvphua4C2Gc5kOnWBJuJdfaIL4RO8y11hMUQs/n+vLduoOVqgv/sBugTk5ZtC0gg
         cWGhJyFzT3wSE1Kf5Nz0qGd+s5EPRdUfZvx+QPXcDxmGwNEj8Qd4IICN8rCdXdIcsQEh
         efCV9lOb/ti/q5G7Xbf7DT15MMmsqkp05KZiqo2KOMTLq9i6v4JdiB1YTDWjdSWgqOiF
         vjgQCIjX71cOuVKHmPe7RD/NFCJl0efYkQU/wsQ7JCon/JKBMBfxycdgpXfx8W40oeuw
         cOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374928; x=1793979728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CaT2SSAJFNm/sn1nl6FBs7/CABv+df9p8PrN4R09z7A=;
        b=paXi2LnkJiOiQwx9zPn2i/+zCkKcloosoJhpWjy3sf7jJtQR3fkezI6tN427a7zKwl
         oHoOLcsFo9gWpMddoChiSs9yzHB/OFIyYimO4C0+NAZBQRmNEPKp6GLgjD7m//zpqzy5
         6s70oGx4+hDdLTmCehQRZ9jKj3VkcQ5rHS7SWLJ4jicB8YTzVIhJc9aB5ZDGQVz88kMX
         690nRsLKLCHOviWw2ST+JPi66j52HjzKhhc4GRQhZb6YoFtciaAWAsj4/xXU34Xk6Xdq
         QLY+WUPqt8Do6QoJSZekLWZ41j8Nt0BVtsXq2mxTm3uCryagIUc/s/KEh8MBhhXV1spy
         L5VQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpHakPSPEfBMgoC3R6+fzTCO5R9gBD92HEimauCx1LVNMFIAIT/Bo/SPl/y5kp+0DWaAa3MP0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1pIai1xIsXlHhJMZxDjKJhnGUt++u9UPtHccFg1cx6Wq5PMvC
	6/n9Ydygw+pfW9toxeK7trAP2/JT1ryMwy4AoE6vfIzhrhNzrj1MWmA=
X-Gm-Gg: AYBFou3fp20iBh5CBrsCC8E0tbgQ4lfGsaX/1K4PFQsIV4RMfwVLCmVfIiY7Wnmd2vC
	mN3pI0O2q5NIAF27WvSUWcrDxAKu+jxlztdYOI3ejRBm7frjKuOtEI6tiQd8WAJtTd563pbN2nF
	ZGDUt15eKJz+s2mzeebErBBYBph7ThADNbMzND4claKckW9+wIoDOdfc9L0YdxxvHl09w6bj2zp
	ZnGH58PvUgPdnDAxqeQ+FzaumO3zYMmdGjccF9NXNSMZDalGeERhGq7neTCcLBwZzmo5EtNXA0N
	/axcX+sfS4yvWfhbaM0sy3k6qqPCQ+ft1Zs8VbqPqBzuQHoxqYbF9zr7Uus5spxeR6yn20pjUsR
	vQdKLBE8GhaLqvxXiFsn0Zu4Pp24r8nJVeNYcNUx1qqpPn6BuG/vNjMMtzYZtu1G1ErvOT6EMpr
	VAmwiSwZaI6vqZgbvMAcn18zpn56mRJU5ghqUzFWSKcYW0Ltnd1ygn1+wZVFFyI7B3zD11zCYmR
	//2TJvHQBjaaK+40vby58qSdNDUnJURMqp/fs8UlrlhlkMOuibsMc5In8GrSIxKzF218YAbEZoB
	OSW8QI8PQDs=
X-Received: by 2002:a05:600c:19d3:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4ac1209eafcmr61882325e9.0.1793374927621;
        Fri, 30 Oct 2026 08:42:07 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f047bfsm144419935e9.3.2026.10.30.08.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:42:07 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <bardliao@realtek.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 3/4] ASoC: twl6040: cancel headset jack work on component removal
Date: Fri, 30 Oct 2026 15:42:01 +0000
Message-ID: <20261030154202.2989936-4-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030154202.2989936-1-tristan@talencesecurity.com>
References: <20261030154202.2989936-1-tristan@talencesecurity.com>
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
the plug IRQ without cancelling the pending work.

Free the IRQ first so that the threaded handler cannot schedule new
work, then cancel any residual queued work synchronously.  This
ordering prevents the race where the handler fires between a cancel
and the free_irq, re-arming the work after it was drained.

Fixes: a2d2362edf9f ("ASoC: twl6040: Add jack support for headset and handset")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---

Changes in v3:
  - Swap ordering: free_irq() first, then cancel residual work.
    Prevents handler from re-arming work between cancel and free_irq.

Changes in v2:
  - Resend as part of unified series (no code changes from v1)
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

