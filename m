Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793064252;
	b=l4LLKc63kDP7Du77/kd6+/k1DJZf5oq4msC3dfPq2FkyaN1AcSBLcWfyw3Bmbmn+HjUT
	 JEymG0n3AapmNFzXR1ofRkZF70rFFTPKSGHaFwHkdmRz9XjsGOSeLBlLFfFWJMfD81Q+n
	 dUbEMdAWtT3uoOoZ6LnyNM7RVBhnyfkSJ5uj+FGgKbDlu7/g0rYhslbdYgLisONzFYnUR
	 CclpsZDvzSHgO2TCtdaiQ1FIlww5orqB9ZA1+f7mH1D2YABsxHXcKO+neY1pJ3xvzPEK6
	 /BFn4YgsJs/lj+ven50QpJU8p84LQvz544na7R0qpEJuqP4DOSl7z/XC0Nw2ZymHnqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793064252;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=tLusgW45F30GPKpEKnufRsNVGgxts3xq8eyJa2O8m8g=;
	b=QhUNZty+EPqpFvBHraoaPBsVays2sbF35EmIH8MCHX/Q8TRNgMB/WthjsGTiBV3DgIwe
	 npD+Ln8sndFR058ojW+VWD+5Tehg+9ZMML5rCXPNuRSrKm53UnBkWEe5hHogHuVILtjQF
	 EcPKViNHi/LfWub/Z37FCghMa9FMj3N3QjTOhrZ79tsoZVOFcRH/1vwSKQJPQBlXORonj
	 y5hsbndOjDacJlyW2VvxW1d2TuVAzcACqFrtT46VlxHUnqTBN4tlkuvinw/WY+6uQCT67
	 tYbyYdLhkWoETL05tu2KG0qCnBPKd+iweee0M2zN4nen2GKjKvOlKELnNIMXTkhI1cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="L/XmS78J";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74589606A31A;
	Tue, 27 Oct 2026 01:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74589606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=L/XmS78J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793064243;
	bh=GUNzZfSn47QjR6+3HlGnMBktD45Xq2bwEqIQm3r4QF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/XmS78JSeNbSM0WkCRl140w6lDTbPs3lfozlZFm8BwqrzVuH3NChgQ9yB+0U4JlC
	 43pfHnIRWaNVTQ9StdKqHcfPkdJwPHr/K/CKbsEuBZld4Kz6st7yUCsoTzreyGXKs8
	 pyOyhZarS+hMtfl5iymgpzJZ08anN1V38p8ZKUej2b1a0SqsnUy2ArD8liDPNACYeX
	 ipgejZcT6xPVYBy5eCAPb1M7amd+UFffavzrVoSicdyAjQpf3yw9kYomnCMpRQXyfy
	 2wuxGBnU3Y1yX/fS8wIpHGtmmLMuc72TaoV/JdEbr2Fx+ZVHWYsD5918IP1jJWQIig
	 hY/shSv8EmZfQ==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 65C8217E013E;
	Tue, 27 Oct 2026 02:24:03 +0100 (CET)
Date: Tue, 27 Oct 2026 03:23:45 +0200
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Lucas Tanure <lucas.tanure@neat.no>
Cc: Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Dom Cobley <popcornmix@gmail.com>,
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drm/vc4: hdmi: enable scrambling before the TMDS
 clock starts
Message-ID: <at_4EgWZFghkRHzH@collabws.localdomain>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026164028.78792-1-lucas.tanure@neat.no>

Hi Lucas,

On 2026/10/26, Lucas Tanure wrote:
> HDMI 2.0 asks the source to set TMDS_Bit_Clock_Ratio in the sink while
> the TMDS clock is stopped and to start the clock at least 1 ms later.
> vc4 writes the bit, and enables the scrambler, at the end of the enable
> sequence, long after the PHY has started, and clears it before the PHY
> stops. A sink that samples the bit when the clock appears never locks
> a 4K60 signal from a Raspberry Pi 5, while laptops that follow the
> order work on the same sink.
>
> Patch 3 is the fix. Patch 1 is needed on BCM2712, where phy_disable()
> was an empty stub upstream, so the PHY kept running after disable; the
> Raspberry Pi tree has carried this since 2024. Patch 2 fixes a
> pre-existing race in the scrambling work cancel that the fix would
> otherwise make easier to hit.
>
> v1 was tested on a Raspberry Pi 5 running the Raspberry Pi 6.18 kernel
> with the same change applied, against the sink that showed the
> problem: plain enable at 4K60, 1080p60 to 4K60, 4K30 to 4K60, a sink
> reset and a sink power cycle all lock with zero character errors. v2
> and v3 carry the same code; the hardware test of the final form is
> still pending and will be reported in this thread. Mainline was not
> booted on the Pi 5. The BCM2711 path is unchanged except for the
> enable order; I have no Pi 4 at hand.

While converting vc4 to the common HDMI 2.0 scrambling infrastructure, I
ran several tests on the Raspberry Pi 5 and didn't notice any (obvious)
issues.

Hence, could you please verify whether your problem reproduces with a
recent mainline kernel?  If it does, could you also give [1] a try and
report back the actual behavior?

[1] https://lore.kernel.org/lkml/20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com/

Regards,
Cristian
