Received: from mail-wr2-f29.google.com (mail-wr2-f29.google.com [74.125.225.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5741A4C2255
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575045; cv=none; b=YE/jQHNuNv9ssxWqvVM4WJGHcxh4N0lzzdfWK4/3WY73ucpbzvv2ewSggR3bbpSzKtSSowN3vpc1gMto5lXlbGTMhCdeZcLrNmXUg9H8t8Qi9l77gCp8wWGu2V4RxbT8A11hEtFXEDSg96OsCffi5tvG8forpQhgK91x2D4L9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575045; c=relaxed/simple;
	bh=jRGuyNoeAYzVvO6Ipu5riZv9jM8Q8fQw/YB1R2vQM+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YprkTVYSskMocpiVWBz+6qqTjDurqIwb3tp7x/x7GhQB/ep+vI630DErIqRFqN0lFhPkjhXtb0+QT8FYCklK+KeFLRujrwozSaSY6eevvSj79YwFClH0+CD6+o+NluwcJXtd+LGjTKa9K5CtfCEd0N0pWIiEr5xfwfUSngndS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ruhZYiyO; arc=none smtp.client-ip=74.125.225.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruhZYiyO"
Received: by mail-wr2-f29.google.com with SMTP id ffacd0b85a97d-482e1b30c94so93937f8f.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789575042; x=1790179842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jRGuyNoeAYzVvO6Ipu5riZv9jM8Q8fQw/YB1R2vQM+w=;
        b=ruhZYiyOUIS27Sf9uIAVIUidzqLOoPHOJzGgH8bPUpet9DJhKwToErisqzMDuLm3Bh
         SjoZTMQqmlxiUjzElcTTroc8ommXWYglCt/LYt97JSXsqHH58yCUkBfAYyRqlJkGCBus
         1NKTpixb9xf3xNG0CBsHNiVs/umDqsyiROXQjFD1xGPdzAjWeyeboRc4aNlC2coBWPhG
         CUVd8rwBphUJ3IgfzQSCJQ0XpvRU8Z8p6dYze3MwFdikKb60yWzowBBHPgF3vIgvXQmL
         UU6uZNodwKOUZi8O7/W94RECVVeWyxcLSF+gCZWf5jzIQYQ+lC+w2jA5CNDtxRF06c36
         8sAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575042; x=1790179842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jRGuyNoeAYzVvO6Ipu5riZv9jM8Q8fQw/YB1R2vQM+w=;
        b=N0kDImBJJvWxTNCELN8MkEX7LIuEBL+B1pZTCrozfwrLtSFf5fwOqRCdabbScFhWZr
         4L00qlcN21LXqDcVVVGmwe1yAFMhk0OIW6NZA0fBvKxL1ReRa2zP+B9HGcBZs0s+I5Z/
         RiwNghgdbAlFvBZH9WWal5LFmcz8htejkWyPXblCmzQOhtANP7NJDRzSzw9F7li/sQJN
         QluZcYFtfey3pPT4K6K2ZqR3qPziQx56/yorMMzLWjPtki/bjLe5quO8pDBk+0pxCcAO
         QrI9X0NagZn0q+gC5l69qel0rcwA+1BjOVh0ScEdBFLR19bWI33KpbJ5wPYFnJVI0Bkc
         GrZQ==
X-Forwarded-Encrypted: i=1; AKwUvByl0fV7oRb4RNjDAERsaXQ9BEHXTenHsEdsNGPd9Qy6l1cxOJ7O6TS6zMhn2aLL9C4AAp9Vl8Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lRuwPYSHr95FZQel1Hk/V1S4FrHu2VDYHrANyj/v5//2gN3e9z
	6hQXOFmON4CO+uB/eRcLGhsVYSxzgfsY97zsjEe65qH30CQ2w25DNzwV
X-Gm-Gg: AYBFou12H7Q5pHIs5+iKgLdIbwyxg3SEd5jeaDauzEhJuvgz3jwZKqSa+AX2Q3DPesY
	Kkiveup9Z1E+99mp8Kit2EbVa0VcLy+GYB2zyW4p7DOvWiKQehFzOrqucfdksCp4Pc0mjzuK4iS
	PY6royQjrredP0LUr0JyiRlg2O91pdSxX88Jip6BP1WE9/M8sYLipUUENMVbgKSZl++RoTn/L19
	TxkHvToAj74y9S7utRN1Az6kO6WtfWjpd4AnB7LveNhbvf/Ls/747nceevv04fnBRUHuq8QtP4B
	EUqsan2xp7iRu2wV1aHAbFpPnvlWgCEGNsvVPqV8hykFXfE7WyqM6Zt3V7Vp73aUOiUaVHvHeFF
	tCK5e8smLxBZSgKIjQT97RG0rhwsIACFsyb/LpdL60xX80ujDIvKAvLe4gv2IlkE+DIeLg5hvvJ
	TdPlbB9Hqs2B0D+axjYNfh7zcPUlM4yiE/lkAWnrI6o+vEkSMjdw87oLV7gfYmXqHITomebcykg
	5pzG/XlOoopnYaUlPqMsfeinUvq6+qrE//Vk0jcnfY9PYSMll4aJrWKIzy0djcJLtyCKn+FKjn2
	xw==
X-Received: by 2002:a05:6000:4a04:b0:487:10cb:ac16 with SMTP id ffacd0b85a97d-48710cbad2dmr2186039f8f.4.1789575042076;
        Wed, 16 Sep 2026 09:10:42 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B8E02002D5AB124699B1F76.dsl.pool.telekom.hu. [2001:4c4e:1b8e:200:2d5a:b124:699b:1f76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf43511sm7720177f8f.33.2026.09.16.09.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:10:41 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Laurent.pinchart@ideasonboard.com,
	airlied@gmail.com,
	andrzej.hajda@intel.com,
	luca.ceresoli@bootlin.com,
	daniels@collabora.com,
	dmitry.baryshkov@oss.qualcomm.com,
	heiko@sntech.de,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	macromorgan@hotmail.com,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] drm/bridge: dw-hdmi-qp: serialize HDMI audio callbacks with PHY enable/disable
Date: Wed, 16 Sep 2026 18:09:59 +0200
Message-ID: <20260916161000.11756-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915103433.13163-1-rmxpzlb@gmail.com>
References: <20260915103433.13163-1-rmxpzlb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Frank,

I tested v6 on an Orange Pi 5 Plus (RK3588): git am onto a
drm-misc-next based 7.3.0-rc2 tree with PROVE_LOCKING and
DEBUG_ATOMIC_SLEEP, HDMI output to a TV.

The reproducer I used on v5 (output off, then open and close the PCM)
now stops at the open: dw_hdmi_qp_audio_enable() returned -EOPNOTSUPP
three times out of three, nothing from ASoC or the bridge was logged,
and since the startup failed, the shutdown path never reached
clear_audio_infoframe().

So I also ran the sequence from your commit message: PCM opened with
the output on, output turned off by the compositor while the stream
runs, PCM closed after that. With function_graph on
dw_hdmi_qp_bridge_clear_audio_infoframe() and
dw_hdmi_qp_audio_enable(), the clear call after the disable takes and
drops phy.lock and returns 0 with no regmap access inside it; with the
output on, as a control, one regmap_update_bits_base() call shows up
inside it, under the lock.

There was no external abort, SError, lockdep report or might_sleep
splat in the whole run, including two output off/on cycles, and once
the output was back on a new stream played on the TV.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5 Plus (RK3588)

Not covered: I did not try to hit the window the lock is meant to
close (an atomic disable landing between the state check and a
register write), so that part rests on the code; and I did not check
Dmitry's condition from v2 [1] that a PHY off/on cycle clears the
audio registers.

v6 overlaps with Detlev's patch [2] (both return -EOPNOTSUPP from the
audio callbacks while the output is off), and [2] no longer applies on
top of v6. For the crash, v6 alone now covers both sequences from my
v5 note (open with the output already off, and the output going away
under an open PCM), so my remark there that both patches are needed
does not apply to v6.

An LLM assistant applied and built the patch, wrote the test scripts,
counted the traces and helped draft this mail; I ran the tests on the
board and did the listening myself.

[1] https://lore.kernel.org/all/urguajogb4zsz4jg3ef32hpyf2awxkywdtlk5ackdi2gjai4l7@vpjaf3sznkto/
[2] https://lore.kernel.org/all/20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com/

Igor
