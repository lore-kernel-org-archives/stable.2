Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318758;
	b=oFAYTOamLRf++Jfwb3xd/R27waNhPc1GzX318Rpi44SlS+v33fbWTF/N0kpeu5g1b2t/
	 zdAt4QhEBV2xsT1khj0cL/0iLVLz3dDeAJOFI2I5weYkL+qtZn5n/r5KSWdvmAjUdN6yW
	 A7Y+vK+rWA9zeLFYa7DrUbwTGRvo54SujkjITdpdz0y5N/dXmdWXQfjINJTVY6nEn1zrZ
	 mNazc1xORCge98oRaHyno4X/7WQiTLNeaInIdkyksIJa+aPLkw/BW1eLL9ZJwLHn8JlDi
	 EWailrPAsFLtGTurAAZzSdw2oLz1kiBgKNASsExrqwN8ctKC3lHG2ZqL1d4w8m/ft4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318758;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xlAJSufIrvZMDmdcW1mgZFjpdvM8gZZPEKiNTVsVOW4=;
	b=bz10kKsi2v49lQlIUkkEVlyKqAfaJGBEBvo/PUoGUa4/zSgPA2XFePBfiHlTk/uqcffg
	 OJNZL3mB2+/IJFJAMNnkm7WREmfGu0UKWMXYLvXj7g70NJNcPxLyhS1swH0HCsgzygWrX
	 9jpodwDX32HbwlW1mAbiiXtfhk49iYPj87wm8F3QHAnx9N+tkabcSIs+lNXdsvXB1pwTS
	 vRePG23uPeCe8Jg7gWBavKu9Af8GKJlA5IsBm7KoLw4jn9Mf49NtCpjUiCNrpCfykheKN
	 nkWo/9YsCA5Rqfg785XHJa7UMKBRex5dtsKK8vwgwqiPCdY2yBfvJaY6shVLvwEajBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOY466Jp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEE4606A681;
	Sun, 22 Nov 2026 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOY466Jp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97121F000C4;
	Sun, 22 Nov 2026 03:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318757;
	bh=xlAJSufIrvZMDmdcW1mgZFjpdvM8gZZPEKiNTVsVOW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SOY466JpByqSZ89hsW8FmPLFpjmHLkPxuVAUy5POd6JQsrO8xFs6fQ/ch5lUR62d2
	 UwtOJfNtaxqGWlijs353MytdXjXF4rJrXCZnW79pCSjHCaWQUOPj3YaAUv4ys6qR65
	 ysPHWXvI/jcrT9diQsgyehZvf4OrRYPXt36jeSq4dnn7Meie+1UWBFPY+cMTvDLTaU
	 JpfnR6rsuSAwsPH4Uthto0c3ewtx4tKcC8J79dFDC0qi+XPGCRniBR0NeZ9D7gUdxd
	 eobjj6yxNkl5dBApqCH+6zHeHabqGMCgNMKhk7aZWKuMWyJIXIwgJDUgUwP5yV/KVn
	 eAdyDGSVLnXyw==
From: Sasha Levin <sashal@kernel.org>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	regressions@lists.linux.dev
Cc: Sasha Levin <sashal@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@redhat.com>,
	Ilia Mirkin <imirkin@alum.mit.edu>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"R. V. Lobato" <vieira.lobato@gmail.com>
Subject: Re: [REGRESSION] nouveau: GM108 hangs at boot since "drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts" (6.18.64)
Date: Sat, 21 Nov 2026 22:38:45 -0500
Message-ID: <2026-11-21-2-daily-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121101350.bab69dff11a2@gmail.com>
References: <20261121101350.bab69dff11a2@gmail.com>
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

> The 6.18.64 backport 15465d681517 ("drm/nouveau/devinit/gf100-: try
> to avoid double-running vbios scripts", upstream 2139cb633d48, review
> patch 426/686 <20261113153835.372076643@linuxfoundation.org>) breaks
> nouveau on my GM108 laptop GPU. The machine hangs during boot.

[...]

> The guard expects nvkm_devinit_disable() to return a mask of disabled
> engines. In 6.18.64 it calls the void ->disable() hook, which disables
> subdevs with nvkm_subdev_disable(), and then always returns 0. So the
> guard is always true, also on boards without a display engine.

Thanks for the analysis, that matches what I see: nvkm_devinit_disable()
has returned 0 since da2b1a0a40d8 ("drm/nouveau/devinit: Convert function
disable() to be void").

I've reverted it for the next 7.3, 6.18 and 6.12 releases and dropped it
from the 6.6, 6.1, 5.15 and 5.10 queues. Mainline has the same bug and
still needs a fix.

-- 
Thanks,
Sasha
