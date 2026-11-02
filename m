Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625488;
	b=ONJgLNs9JdPBKeZ0OddjogUJyJ33i211Pj+zlsOt9svs/gRKvd6cd1hVB7dZbgP2Ud/F
	 xILxUDvYxEmiN+XfGNTJWJw/hy4Q2GtyfECBpurPMpS6W/VXM4ik2BSueBqVT7vShRIQH
	 mUKBhNrMsSwU0ZDe39fJmF4AVTVlOinVhl7JLmjm8SJSNGbTrUhNWW81ZSMPyaH97YEZu
	 isacFTz7YBew9uceBeypXRvsdROI/E8E2lf7ghMTwKQ5eVIOX+vX55G/jR8Yb+hJAjVjY
	 5OyLcq9xW0d4RMPQ2WpdntAxdizvAJf/9yD16g7zOi3AdgVQGJBr+mpkOL/JZlY36jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625488;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nCdlxFyOUKjMKgyfhhxeQD336etZ7vz26BUvkTR4bp4=;
	b=p083mZv9cgU5yKiDueSU08uk7zOpVda5Zyv6iSVatOGoBrbaoTx6Unh3ivulzwQ0rJwo
	 qZteSmpY6HRd8KsGmAX55JPl+gOU6R8OTjutqRg0XeE5fpW83E8gMN/TC5O4u5zsJIkP8
	 fivmwTPv8tBkvLOf+MsIU7kBinUBRcZNQP6zN1BxuGcfqMUGVQOqTcu3CT/nsUTBV+Eyn
	 rrqdXkJEA5GxP2dah0yTMb84KDW5smyuqPZ54s/pZBTuOnKKBFzfmNZHpIGVx9wGMt2XE
	 A/vRT64b+aICPhLDubS77Sh06Jv3/2573+iMboFucYE/YGWvXhf6x1tQf50lQJ3uD8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=cy9zUguR;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450D606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 13:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9450D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=cy9zUguR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=nCdlxFyOUKjMKgyfhhxeQD336etZ7vz26BUvkTR4bp4=; t=1793625487; x=2108985487; 
	b=cy9zUguRNS/KR2cZnWHwW0LX75atBBIJV74ondDh03S6iLa+msDsFkT2C0/dDHcqIzPPK7Z4tRC
	JzT1n/cSfTqs30FbHExNfw0L11icKT3QIwTeAjxfDY5WE15nW0rKnDfZmauCaZp6zM22l2xctBmUx
	EGKHBHsQ+FkOhWnWWCCsJUKFqNIiBcnXclcKdozk0xlCj0c1uDlHoU1zEQCZl3Z45hWW9qPotguJo
	D41034Zgg3o7y73DjzM0/kVOtl/bbZUKdPS+gNPUSvQI5+gulVrzKA2o3SJxJnt+/RlrvQj/yeigH
	R9tdsS1lTOwBi5FceOLlPqrPrhLGs2DWHAjw==;
Received: from [179.105.94.163] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xNrvH-0009Ul-UN; Mon, 02 Nov 2026 14:18:04 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>,
	Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
	Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/v3d: Initialize timedout_batches when running a CSD job
Date: Mon,  2 Nov 2026 10:16:56 -0300
Message-ID: <179362541395.53188.8652440988836179813.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101125619.2465064-1-mcanal@igalia.com>
References: <20261101125619.2465064-1-mcanal@igalia.com>
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


On Sun, 01 Nov 2026 09:53:57 -0300, Maíra Canal wrote:
> v3d_csd_job_timedout() decides whether a compute job made progress by
> comparing CSD_CURRENT_CFG4, the number of batches the dispatcher still
> has to start, against the value saved at the previous timeout. That
> saved value is never initialized, so it is zero on the first timeout.
> 
> On V3D 7.1.6 and later, CFG4 counts down to zero once the dispatcher has
> started the last batch, but the dispatch keeps running until the batches
> in flight complete. If the first timeout fires in that window, the
> handler sees no change and resets the GPU while the job is about to
> complete. For example, this happens with long dispatches that only keep a
> single supergroup in flight.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/2] drm/v3d: Initialize timedout_batches when running a CSD job
      commit: 0afdbdd5b1af729108de8f893d179c3b99eac29d

I'll apply the second patch to drm-misc-next after the back merge.

Best regards,
- Maíra
