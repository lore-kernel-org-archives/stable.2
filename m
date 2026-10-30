Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793366127;
	b=CLrG+a3vfe0ZCAj+2sDzQMbC/42GBUBLzIJpgUmaomDxFSNT7T5UgDsQO7X00w57w6O+
	 FjUJnLU7Ym5q3zyHMqrRVQ0+xVHl3p5pU7HOwsd/cBgXZn1ekanPwB2ocV4adEmARiL7a
	 NATbtG5zsdBlLFYqJiSaQvr0mhYN5AGJH5X5xiuYjjJ0pmK+0FwJhLbyQ3TFJwHyzQGBa
	 lCdadoNPm6wJa5pEx80FUkyMFE/eviElUxs4i2yoIufhbWN1B2ucG8Qb5uMkLh3sNf+kZ
	 klwIgtpHntK35Xdi7k5LNkDKZEMEY7tkjCbh6nTMU989h8SNOchK8as/cxsEDZl/Asg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793366127;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+2nvKM88jwoLfLwwyKqMT179aru67saPys7pTH9M+hw=;
	b=ex5GpYctn41SE9oHArkg9v6PzDfHTWC3N3iItKMRYf3UkmSWphWJSJjBPgI9acXj138L
	 +skvZ5O0xJRr14ejP+mZmKbnG8CKBtMrXO9F1DZptX96//+FPBii9tUC1qunAhqgizZJ8
	 GjfgEQAuOcBTuHAhufb/KbDgCv9PvM/OutqyXWw31lnqOlW9wpvFI4uqgpz50jzL5YqLh
	 jquu75Q9DDEN7IeLxGaiLMmN0ELlrI3mudjgj89BcLijDlHa15YtIxvz3jpxLtLvKn+rI
	 NBi7koqED29QXM5CW3nhlyuxPbSdvZnb5YY61+aVt28Fdzz5HU/cNu69rZ5z1Jipikg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=qbXUnsaY;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB4606A32C;
	Fri, 30 Oct 2026 13:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19FB4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=qbXUnsaY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=+2nvKM88jwoLfLwwyKqMT179aru67saPys7pTH9M+hw=; b=qbXUnsaYgGJOKfhy4lCxY4koQE
	ApDfE9QjUvUWKCd6RJ0OLR/qfKLzgHi6TGSwEVRh/qXkKQnpRAguHcNN3ccGRVeKPVVHO3veK7zeY
	wakKwef63z3j13AauGS0WDZnDPNjv6ZgGVFjfcLydZ0+XfjvUJ80Oknu4ApmCqdi99xquCV5DJG7K
	xwhPKVHtg60jR+FberxrUCX3IUfIJzWFcjmJD14i9RbPXhl3Cig3Ub6bQuOZoIp18NyfvV77B6QWt
	g1XLhwgCwkySfAbihuxHfDMJd9TB0yFZN3QwzkjGgx57wTBl4XQsz5zEV2zGasisC9ExMeTp27bPB
	88PbPhzg==;
Received: from [179.105.94.163] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xMmRi-00Ezw7-59; Fri, 30 Oct 2026 14:15:02 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Lucas Tanure <lucas.tanure@neat.no>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dom Cobley <popcornmix@gmail.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drm/vc4: hdmi: enable scrambling before the TMDS clock starts
Date: Fri, 30 Oct 2026 10:13:48 -0300
Message-ID: <179336602325.1953359.580164990520983023.b4-ty@igalia.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 26 Oct 2026 16:40:25 +0000, Lucas Tanure wrote:
> HDMI 2.0 asks the source to set TMDS_Bit_Clock_Ratio in the sink while
> the TMDS clock is stopped and to start the clock at least 1 ms later.
> vc4 writes the bit, and enables the scrambler, at the end of the enable
> sequence, long after the PHY has started, and clears it before the PHY
> stops. A sink that samples the bit when the clock appears never locks
> a 4K60 signal from a Raspberry Pi 5, while laptops that follow the
> order work on the same sink.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/3] drm/vc4: hdmi: power down the BCM2712 PHY when the output is disabled
      commit: a59a60e6e9e3a1d5177b28577d935d5ee37ace66
[2/3] drm/vc4: hdmi: always cancel the scrambling work synchronously
      commit: 2e47848f0d076dec66df3bc403214073cd2214ac
[3/3] drm/vc4: hdmi: enable scrambling before the TMDS clock starts
      commit: 81383bd290a18f06ccf9b0bfb29e1a3ef73d9357

Best regards,
- Maíra
