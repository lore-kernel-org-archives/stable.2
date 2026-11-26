Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795716172;
	b=RqmAVTh2h7ISpIiczDXnTUYU7sBP38QtoZlSF4zCDy3Ho+7phnaaMrOnbhxrZcU05MD3
	 d6vSWt0Y7CgTNXeb1g/hS/5VJvLl60L0jcDZnioIz+jRKNp0dL8XynkBYm3BVRokbd6BH
	 JRx09ZDZneyC0eGK+lo0s9sbA/hdFnIopUtkNdJdTX6zeJPGag9Mst65p5U8MUZfeaNZ5
	 TJHD3bnvvV5gPJtuDv3k23H++PChvojEiKz4m2FyAqQ+gk6q7rdJKU7vZEvHZRBFXALYu
	 l4jrewge/r5hZX5cdoc8w4Ck6hZoa/tJ4nBO27+hPcOHSyYjmGguD1XnaZp6GpPYjFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795716172;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=OBmftwX5xkmh2yEUhqByt4ga8q9hssUc5Tn86F/AT9s=;
	b=AWeMzIP4mjElMptH2hvptfhTtO276fG8VtV78eewB5NgrpsJVb8tBECk2DLhxdz3tlKc
	 QwiHvQ7VPNVVAk5JgtALrOf6SWqvzLbkrUw+/FtwcN4KVDadOdf730XkgKq44aXN9WT19
	 2fAhEj4Zjt5ITpMgSfffvjWHuu5isHz32dNGBA8a3Yze/i0F5sF0YrSD4lguV2yBywj+U
	 Z3WE8kztmyTSH2+m5RixnLcB1XphL0ojK4SS2r+BNhydavE7h8P/mlScjvxoiXdCXP0zk
	 5ApqtzmcN7Smp/sr4/dYUSfUjYGaQ8KjWhgcocPSPaxVPLFayybJ4UJMYm4w9U+EqMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2YUCeZto;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE6606A31C;
	Thu, 26 Nov 2026 18:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40DE6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2YUCeZto
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7BCFA4E417AB;
	Thu, 26 Nov 2026 18:02:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4461E60558;
	Thu, 26 Nov 2026 18:02:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9464B11E69199;
	Thu, 26 Nov 2026 19:02:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795716168; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OBmftwX5xkmh2yEUhqByt4ga8q9hssUc5Tn86F/AT9s=;
	b=2YUCeZto/xB7S8Ytj+9Kwaw2TcEYtRWgowALzmEFPgsU/ZYf30P0y364TFWHsW+aeHnpK2
	5POwVJ11e1JKblQsa7TAsF9so7aczS71cgkXTYx+AO+gRpw+XCK3795VrAYsCp15guWqXx
	0QHvk93ETtX7KUR+U4SI21olURehwtZdcSCOt2YqaDMMfT9YVX3AogK/EI7/XUMK6QoPgd
	jEKDfPsptO0+0Oh8gY59z/BBt/XqGs5XxejLraCkmYrgpmpxIliI1ptKntc9fCJf8ltWb/
	6NZ9MGc4bvEBa+4blKQusF+tPX0qdSjPHBhq5u+ycRch10LGov/ZJR8vinegjw==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 19:02:38 +0100
Message-Id: <DN5C92OQ40J6.21PMG8R70TEDK@bootlin.com>
Subject: Re: [PATCH v7] drm/bridge: dw-hdmi-qp: serialize HDMI audio
 callbacks with PHY enable/disable
Cc: <dri-devel@lists.freedesktop.org>, <linux-rockchip@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Frank Zhang" <rmxpzlb@gmail.com>, <hjc@rock-chips.com>,
 <heiko@sntech.de>, <andyshrk@163.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <royalnet026@gmail.com>, <me@timsurber.de>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261112101155.47777-1-rmxpzlb@gmail.com>
In-Reply-To: <20261112101155.47777-1-rmxpzlb@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Nov 12, 2026 at 11:11 AM CET, Frank Zhang wrote:
> The following panic was observed during system reboot, it can also be
> triggered by the following sequences:
>
> - Disable the HDMI drm display, open and close the HDMI PCM device.
> - Enable the HDMI drm display and start audio stream on the HDMI PCM
>   device, then switch the HDMI drm display to disable, stop and close
>   audio stream.
>
> Kernel panic - not syncing: Asynchronous SError Interrupt
> CPU: 6 UID: 1000 PID: 2348 Comm: pipewire ... 7.0.5+ #4 PREEMPT(full)
> Call trace:
>  ...
>  regmap_update_bits_base+0x70/0xa8
>  dw_hdmi_qp_bridge_clear_audio_infoframe+0x3c/0x58 [dw_hdmi_qp]
>  drm_bridge_connector_clear_audio_infoframe+0x2c/0x48 [drm_display_helper=
]
>  ...
>  dw_hdmi_qp_audio_disable+0x28/0xa8 [dw_hdmi_qp]
>  drm_bridge_connector_audio_shutdown+0x38/0x68 [drm_display_helper]
>  drm_connector_hdmi_audio_shutdown+0x28/0x40 [drm_display_helper]
>  hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
>  ...
>  snd_pcm_release_substream+0xcc/0x120 [snd_pcm]
>  snd_pcm_release+0x4c/0xc0 [snd_pcm]
>  ...
>
> The crash occurs when HDMI audio callbacks access registers after DRM
> atomic framework disabled the PHY.
>
> The root cause is a race condition exists between ALSA and DRM atomic
> framework. During a modeset disable sequence, the DRM path disables the
> PHY, while ALSA may still execute HDMI audio callbacks such as
> audio_shutdown(), leading to accessing registers while the PHY is down
> and eventually a kernel panic.
>
> Fix this by introducing a mutex lock and PHY enabled state to serialize
> PHY state transitions and HDMI audio callbacks. This ensures that HDMI
> audio callbacks can only access registers while the PHY is enabled.
>
> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi=
-qp")
> Cc: stable@vger.kernel.org
>
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5 Plus (RK35=
88)
> Tested-by: Tim Surber <me@timsurber.de> # FriendlyElec CM3588 NAS (RK3588=
)
> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>

I'm not really an ALSA expert, but the patch looks sane to me:

Acked-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

I'd apply it to drm-misc-fixes in ~1 week if there are no objections.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
