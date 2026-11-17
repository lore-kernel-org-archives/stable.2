Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950523;
	b=x3Gn7V/cWA3uSGZl7Tt3dYVgmOk89QKCxffbvVILZ5Reemid2jkzlXEAOlkKQZ6uVgBY
	 ZdvI9qQh6gN7iEYeVy9lasA8U5K4O0rWGcU41Gp3Ke21sd/MVs4o7WlDNNIELoNofm1bg
	 sPGu7lU9IqS6R5X1CG0MHXakpLvAn4QkJPDDWrE6olvomjnV3knk6vE/J6dl1DFIsQWZL
	 s/eRzdoRKZu3rFvsMoTqi/pwPattbZDNC65vwUcjKuanJofZnFQhdeNqZ3mB3cr0UVMvf
	 xHj5lDqwOTCPl/yW7ubAMyYyZb5G+Z7K+T03YtehKmRiHNvDE+VgDzi7T1+/1SSE41A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950523;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AS+LdjAZ9uLUysJ7yrvtODB4cFmFqghPvSXSI4kogDk=;
	b=dmjGUaqo1/kuHiEahY9Ae7mjAyl+LQ3PQrA/yzjKM8DKsjiRbyNU6u6K0o4+KFffOOoR
	 g5sJf4phh1VmecU2pvFTRqYzr3ssftG3MBjAwz/w2dlDH3lgW6CSG61hW2arxYTiGdjpO
	 T7aaW9rR1PW3l1oHgYjwROYXXfFWLImMDwjyZNDNy+6jNziKhWIxEd+2uLTlBn7VBxOzz
	 MI1n1Y0mV0aFbi1jzfDx41Yn+qVTyTfb4LM2AQ5rplejM9SxlWhLhZOiELmzzJA9JjTE0
	 pldbnUMi0Ad+n8XsUSgzi+vk5DIlneOjrzsOlLo4WZyRGd5TdEtyNOIXcK1G4ubDs0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=e6me1UNL;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E2606A32F
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 21:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD8E2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=e6me1UNL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=AS+LdjAZ9uLUysJ7yrvtODB4cFmFqghPvSXSI4kogDk=; t=1794950522; x=2110310522; 
	b=e6me1UNLvbZJFjO6MuL7Xsx/iAswrigcDyr8uQHe5Z8n/Wg6Jq6V0y846qzK4YQupu23kP5T32q
	va2Ps2jUYfbOs9oqxPNRpgWD0a6tnTLhANEEoRWpwwren0bIhSQkkeTOWvhhR6wLvNPqcajrMP7/I
	dQ5E4ksQiySbeBrzwOgBp/kUHm/tqhDMMVS/yEbT4m6uc2i7X3YSDBjpUfxivelKrJe+3A8aRgtY5
	wGtnrQB/vt1BXlxlqh+kRcvBvEyvxCcaeEbsYhQJo5THicsaW4XWteWMP7ait0KWO3ARMwFWv96Bb
	ZNz7JaRFYiu06N5aHqGZ80ChqzS8W/7RIOzw==;
Received: from [179.105.94.163] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xTQck-00000000kvm-278V;
	Tue, 17 Nov 2026 22:21:55 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>,
	Melissa Wen <mwen@igalia.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm/vc4: Fix async page flip completion
Date: Tue, 17 Nov 2026 18:21:17 -0300
Message-ID: <179495047310.1852768.467440424263871082.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114-vc4-async-flip-fixes-v2-0-d33cbe99ed5d@igalia.com>
References: <20261114-vc4-async-flip-fixes-v2-0-d33cbe99ed5d@igalia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 14 Nov 2026 16:16:49 -0300, Maíra Canal wrote:
> VC4 implements async page flips with a custom code path that waits for
> the BO fence before completing the flip. On VC4_GEN_4 (RPi 0-3), the
> completion also decrements the usecnt of the old FB's BO. This series
> fixes three bugs in that path.
> 
> Since commit e8941ac97f28 ("drm/vc4: Remove BOs seqnos"), the completion
> runs from a dma_fence callback. VC4 signals that fence from the render
> job IRQ handler. As vc4_bo_dec_usecnt() takes a mutex, running an SDL
> application with SDL_VIDEODRIVER=kmsdrm on the RPi 3 triggers:
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/3] drm/vc4: Drop BO usecnt before releasing the old FB
      commit: 43b85636ea0d33152bf16816b7601e785723596d
[2/3] drm/vc4: Complete async page flips from an ordered workqueue
      commit: 12a321af56c436e299414d8c276457dcf387e0cf
[3/3] drm/vc4: Look up the async page flip fence before committing the flip
      commit: f9fc6da01a290609428d308033143f1d96ab658f

Best regards,
- Maíra
