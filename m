Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096492;
	b=w25SRdw7cFqwumq0n7YYHE9afyEWZ1KCmmgwm19l4zLN3uYnL0xPGNxqxJGHU+iDaLRj
	 C4w9313NFf9okNaKCRPXfXbXm5GXCP8IDWrhN5ba6fQbc1/shhBAwVwU84AXO178aZae6
	 v89TeiV1CXUvpfm79dAZD7hkvmxEnzXuXAGj7MskezKZjrf5iqDW08I4Cbd6raJMKXOF5
	 zEuv8V8aJeuIG3TmgIyYH6JHlkihzHVXpTSqErjG5pm6z/RoApHPjlu/V0Dtae2QxLzK6
	 jgI/ExheqNDhxJhZ247FEXzVPFccpN3x4LsZA8XVQZhNmt3BU9DVykYQgGW+FxDBayA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096492;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bs3e533bt5D0o+EpSdAjhPVi/JGC5ZQYFdjvbtCNaXk=;
	b=WLsvWbilaScqde2jTrZ80cQCwrsRXpTa3KnJQANMPaPE/grn+20rtTwRAyYgu4yZkzfX
	 tsQGrDNW1Pbn6UMuihXmEsTrelH0mPp/UiXlxhhVpn66vdDNJ9hdAvllgulMGEjvfu9KU
	 QXTRUbl/JjurBtOAOovL63YiBIwcMoXVKyVH/lidTQOLr+jSTHgJJuPeL0SkBgDkWggkh
	 oLmO7zS+Rb1vgcYpv10EVZaLYBNlcHGwa5eZ8ROwNOQIlGn/R7FuQcq/zf+4cp0phQxAh
	 S7jkrCPKkAU3/fZ9w2FTp0tSEqwb4KQABRFmBwV6083t3XS4qk3rDJ099UijueyvuQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=nTkeLZtp;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252BE606A333
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 252BE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=nTkeLZtp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=bs3e533bt5D0o+EpSdAjhPVi/JGC5ZQYFdjvbtCNaXk=; t=1795096490; x=2110456490; 
	b=nTkeLZtpFfwqXlsy/IzqCfKpoW3l+GZ2EOZzoVwrCfXX09WPAsCq4SMVbomo50gnxHuKE69zLXk
	mBT0HRohMgE9Ly5fH1DbASeUXk+PKPh9m9In2DGeAG3aBAn47qNMCrBW9CMcgZrQdoSrimye3z04R
	Az3Bd72DXi7NUk9P7HYSWDNpbsMh1tTG792WPJkYz0uS0tYpVBQ+tn/5p/ssGnToJ44diG98v7eQU
	Z4KhYKL59vzG3aDdgDckpNenT32ihTan3QB4rDT+p/pxA+WIWHdBWuNXKSNSzPEiLu0PSPUyEICNm
	miXF5YHYYPVSsdhyttwQTX8jxlzPiARj5niA==;
Received: from [179.105.94.163] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xU2b3-00000001TSi-3SwJ;
	Thu, 19 Nov 2026 14:54:42 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>,
	"Juan A. Suarez Romero" <jasuarez@igalia.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/4] drm/vc4: Work around GFXH-16 instruction cache livelock
Date: Thu, 19 Nov 2026 10:54:10 -0300
Message-ID: <179509644527.2610316.12481910514496776613.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
References: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
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


On Wed, 18 Nov 2026 18:47:27 -0300, Maíra Canal wrote:
> Mesa issue #16652 [1] reports GPU resets every few minutes on the
> Raspberry Pi 3. They happen when text labels are drawn over their shadows:
> two different threaded fragment shaders, plus untextured single-threaded
> ones, in the same tiles.
> 
> During a hang, the performance counters show four QPUs fetching
> instructions with 0 cache hits, ~6.5M misses per 100 ms, and 0 valid
> instructions executed. This matches HW erratum GFXH-16: the QPUs of a
> slice share one instruction cache and can livelock, evicting each other's
> fills. Since shader code always starts at offset 0 of a page-aligned BO,
> every shader competes for the same cache sets.
> 
> [...]

Applied, thanks!

[1/4] drm/vc4: Fix off-by-one in the shader record BO handle check
      commit: 1fbbd14add401c70c178f0fa13016a3a53ef0de5
[2/4] drm/vc4: Check for a validated shader before reading its thread mode
      commit: 15da41dff1f66a389d238db60a1c19fa83582d07
[3/4] drm/vc4: Start shader code at varying offsets in its BO
      commit: c0e1ed41ad86cf5230d64dc5f2c6d2e3aeb59937
[4/4] drm/vc4: Clear the slice caches before resetting a stalled GPU
      commit: af1cf92e8617a7f7aa24b415596cbf64b76a12e7

Best regards,
- Maíra
