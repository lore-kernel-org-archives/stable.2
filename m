Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032834;
	b=d4M2RRDR4gzZvolJTc8CLxyyqtNpbQFXyIPOddzWnWbF3cIsQ4sLI9+eYMlly0LlffWS
	 1KZLEhNre67sU2BRuCrgxgw7Myn38aZcOypAZ+xKTRaUg95vGA9/c5QTNSUhXYXniFcb3
	 skbQ0Vp/VhTvWp1eRfYAF3nI6qh6TRXFphiRovB9YtLoRHQgLd2UmojlSvp8dhTuQWdf0
	 Uq0KT5OvLumjbxqW6wO93c238s+tI87IAUSTbXhJxB41RKUWdnB5POqbcsiI4+V/fmqng
	 7GTE6wz0lIg5SOuSu98uFyGbPORJ5OPdxHH4V0E0F1ye/ewNgCjd2GGU7J1qavNJ/6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oG0OCrqpe0XEV+bay86LwUo+wIO5sgYnrEJ8HAsyUYo=;
	b=f/N59V12+ebaHrL4QCKn+1LL/oKox8yYtMw07D5BldYvBM6BQAgB83VNH0az2cEiTihu
	 YFiGd6K3QI+jGi2msegJdtmknizSxfEmL6fboKahdfWutyNVSvg9zH+LMaIDSyHqNpCUj
	 DgV1Yo+UfOhfogHraHlDnO9K096Oe1QAHddV/RO9OX1SShUz5iOLb81eFNEw0t8M5S5MK
	 ba22c/QhXphvo4VLGghbarkTTXVxTljupNwtVAfXJ7xMR4Qn6C+bkpwm31UxlfQ38xY+W
	 HGb0p0R0V7kqFWNacwa74sjzdLwX9KxRalapRXHnvovbi+jowB6hs6aDGTwFjmPgypQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=neat.no;
	spf=pass smtp.mailfrom=neat.no;
	dkim=pass header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=gWDcGF5y;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89AB606A329
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B89AB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neat.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neat.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=gWDcGF5y
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c5358fc28so2996286f8f.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neat.no; s=google; t=1793032832; x=1793637632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oG0OCrqpe0XEV+bay86LwUo+wIO5sgYnrEJ8HAsyUYo=;
        b=gWDcGF5yTCl+ltUDUmx/EnIgMcv9cYZ45OAt4KEzCH/FGL+HfkLw8Jzw+f2sewUcB2
         y17Je6QGxvKQmyjWvFqT8ILCHIpgVBOezjYEN3CeDh4Zx27yJwhvZZXlG2N/+iHKM+b3
         Rja7q+PXBGGrt0tQBtM4CCeDn3z9fwALWTHLNXLOCU0TpzuhCxd4leFmfUzf0pQnYyDm
         fY/tltoI0TpdBu7oKcsU2yD9zaYFLPHINo0GyfW7TDMBBLTKFSrbcmX25mNU+giaPqyi
         C5H/kl+d0wv4mguweDiPc0Z41rGa5aaIbs3mqUEopLkaUy8Idw+Tn2/DTVANbu5qrPNV
         onOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032832; x=1793637632;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oG0OCrqpe0XEV+bay86LwUo+wIO5sgYnrEJ8HAsyUYo=;
        b=yw0ojJZ5xqsTl7HoxwP6SFaVe8njRVIF4jdArBbiPY/0L/d1hTB9HQxNJnPR7YlNNz
         7vdXWa8DQ/UttL4pvdAn+kr4UKvgMIr8CscEoKi81h9dpY00tNej0wwXSZyN04XwYCFf
         0C1Tn238fepwjgBZnYFkYbuXFHuT1fv++1nee/0zdXaCp0vTwNvjCix6PXTydTHfnkEi
         YdX/73ln2NezYyH2B1MI2iX+/2gQLxrxncVgZszx8mJJ0fRvLwW4pcnAC1x/xM7Lwsl6
         KhjB44kPHtUGxXWyiKKVbMHG7i8DHkytVhprNUlQoBElLbm7Ee8eNGiKqHMcD/gRR8yq
         ghQA==
X-Forwarded-Encrypted: i=1; AKwUvBwd9n2nz7Ud7KfnKS7OPwLaWhPFKusQkJ63558z5F5X/S/E/Y5+XBlre8zemKf3qNahZfdeBfw=@vger.kernel.org
X-Gm-Message-State: AFq9FYItqnncsK01X29g/erheFwVZxNxTNjUndu1wbz493CmxmJljdm/
	gdxqDEuWbxtGYkDLo0hJ6icnCYA8uXPNvDB8a/D+Hy4XZIDVIPPtkQFymif7gofXvQ6TSko5DR7
	q8RQwtm1RHqFvX+9aT0Kxsuao15+55iUBADDaBUPTBFZ0gLoZ+Qvj726GMWzf5DfOEFULqEto3j
	UymiXkA/e+Ul52KKOUh1xWPcrorMelNwhTzoHPZOu76s+jy0cEuI6IBN1sz59ZLYz1XB50ZWYRy
	i8=
X-Gm-Gg: AYBFou1SJm+7jtPyFQwEQI2kuBOVOLeNnyieEub64kZGRBUtnGEGMlJz9QjyS4sbwRr
	9MEqQF7nCjIWxian/Y2uWw9KMAeUeUZd7qD9a/MAnm1P/77IHfopsaOpUSDwGTdhmecqldYRIIo
	ESS1Q+PCCeGAiJjBPiYGedi3jNNkGZVmitKXCY4xMZBVUuR1+oIvxBVQZU1eiQE4Ud/NN+ab89m
	pCPn01CtRAd4KcJR5rQ/vod07hlp/yy9mGZyElkoa5nSI5/p6bqeD71sTB4zgmjMuyWGkPRKpVF
	hjutUwZi0AlRwiYle1KNg1G/YqH1O8vL8FZ510Li5ple3q34hkKqNwcL0g8MEcM1jvWxGrFRI5s
	SpGgo7zxqM9ZyvDPJjv1rWwz5pt+ma74H7LcamDqGrLACEDoqf2d0CkaiMp+qCQXn+beKaRclMC
	g48vHCBobhPO9yWUQxoZqzhWm9TIgeanIKVVErcaJQSM4B7fOon9/N8UCIJyol1VIWxZad99v3U
	bTdFsxz83KG5MWNCU0SYL7/MQcp985lhAOmsO9XHkficEa59aBmDMJNwNzz+HVR
X-Received: by 2002:a05:600c:19d4:b0:4a1:fa33:441a with SMTP id 5b1f17b1804b1-4a35ac3f123mr144774155e9.2.1793032832124;
        Mon, 26 Oct 2026 09:40:32 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a30e22csm205961655e9.2.2026.10.26.09.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:40:31 -0700 (PDT)
From: Lucas Tanure <lucas.tanure@neat.no>
To: Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dom Cobley <popcornmix@gmail.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] drm/vc4: hdmi: enable scrambling before the TMDS clock starts
Date: Mon, 26 Oct 2026 16:40:28 +0000
Message-ID: <20261026164028.78792-4-lucas.tanure@neat.no>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026164028.78792-1-lucas.tanure@neat.no>
References: <20261026164028.78792-1-lucas.tanure@neat.no>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

HDMI 2.0 requires a source to suspend the TMDS clock, write the
TMDS_Bit_Clock_Ratio bit in the sink's SCDC registers, wait at least
1 ms and only then resume the clock. vc4 does the opposite: the PHY
starts at the new rate first, and the SCDC bits are written tens of
milliseconds later, at the very end of the enable sequence, together
with the source side scrambler. On disable the bits are cleared while
the clock is still running.

Some sinks sample the bit only when the clock appears. One HDMI 2.0
sink we tested then sets up its receiver for a 1/10 clock and never
recovers: a Raspberry Pi 5 at 3840x2160@60 shows no picture, while
1080p60 and 4K30 work and other sources work at 4K60 on the same sink.
Writing the bit by hand before enabling the output makes the same mode
lock every time.

Enable scrambling, on the sink and in the controller, before the PHY is
started, and disable it only after the PHY has been stopped. The SCDC
helper already waits the required time after writing the ratio bit.

Fixes: c85695a2016e ("drm/vc4: hdmi: Enable the scrambler")
Link: https://github.com/raspberrypi/linux/issues/7693
Assisted-by: LLM
Signed-off-by: Lucas Tanure <lucas.tanure@neat.no>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 4a386e053d3f..e57fc33af6b3 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -918,8 +918,6 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
 		spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 	}
 
-	vc4_hdmi_disable_scrambling(encoder);
-
 	drm_dev_exit(idx);
 
 out:
@@ -947,6 +945,8 @@ static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder,
 	if (vc4_hdmi->variant->phy_disable)
 		vc4_hdmi->variant->phy_disable(vc4_hdmi);
 
+	vc4_hdmi_disable_scrambling(encoder);
+
 	clk_disable_unprepare(vc4_hdmi->pixel_bvb_clock);
 	clk_disable_unprepare(vc4_hdmi->pixel_clock);
 
@@ -1554,6 +1554,8 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
 		goto err_disable_pixel_clock;
 	}
 
+	vc4_hdmi_enable_scrambling(encoder);
+
 	if (vc4_hdmi->variant->phy_init)
 		vc4_hdmi->variant->phy_init(vc4_hdmi, conn_state);
 
@@ -1688,7 +1690,6 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 	}
 
 	vc4_hdmi_recenter_fifo(vc4_hdmi);
-	vc4_hdmi_enable_scrambling(encoder);
 
 	drm_dev_exit(idx);
 
-- 
2.56.0

