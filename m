Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531858;
	b=AezB6rG1XpnLwX3U4GDOIffKj57Nno1THlDXhIhjyJtmvNEB3o/IKSPDnzFaKYdvRPPf
	 YpClZd5OXVyJDRn7tEycEmzKegNInPwRlw40QvXLAPtPTEsVlMJPuG+XwPQk3qJvuYKlI
	 1wxXi70bLBjSdu0HXFhHXBFnvN5eGj7SLVMpSVUeMNFvIYoYiJ+H322d52+VvMHmbEouH
	 OoRGMmOYh8kEDHqlOS91cjLE5ZRMxPo7GwWltF1lWDkiJD2d71/hiAwzx754q7+RUze4o
	 sObtGP4s9HQJl1fUHTZHT2bhdO7KTXKLGJVcHtn1X9YpvvmuNt1ab/V6eExtHwZyngQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531858;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ocnvVpUM2k4BZ1JlH5J3u/MwbHTCf+vA7/pfRS7pts8=;
	b=eaI2VQfcejjszYfzXL5pNlVEOX+XNhZ6IOr7ZeNwYGTuQhca0tMxl1QzXoU3EW+2zgxC
	 8JuBCcNnfFfSrLPJUQjYQxBiPk/iNvZdtviQ5CsDuPR8H2IGed0Is5xxMghHHt8IWcEwy
	 0WjBN3fnDT80/KILhP0QvzLj4zDcH2eEWy7/Rb5I0y84Ec8pd/Vnx2BtcR4OARWsE7FJC
	 3U57s3TykQOVRG8DDFixwUjyodFIxlB2Lkc04G53Rpl+8t4Rbkqm5yfG7Tb7u18FEwOpz
	 Oqx3bgzlMSKDEBpEyf+kk2Vfvb1JDTDoVwdBbH8Hjqe/SEuMzHGGw5FzlDcIX4MCwIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lftpzHzM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42B0606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lftpzHzM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2741F00A19;
	Tue, 24 Nov 2026 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795531858;
	bh=ocnvVpUM2k4BZ1JlH5J3u/MwbHTCf+vA7/pfRS7pts8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lftpzHzMHEfOCb549EXK1dt0qPVNSK6N3xfQwkLg2+aF3TcXx0kSryUz/f5Ln5Sro
	 5/oUivrgVVLsPPNe7zJY0g5IlRI3Dwtw3AHGbjWoPtlwOu2BD6M+BL6IA+dI4DS9el
	 j2lZA3c4dzq8OIMwHRJp8JjbwZZZQsQlrkoDgjwoR5M5lelLFO8TvBiyhSSimfGZBR
	 V0Gff7uV7BuOl8pTB9TrhZt1CBw2vPEI7wlOAVJot64JuHr9NIZ84ggb2y3cQVEWMa
	 ZPd4Ng+Rw49nHG7r3x6HwkCz55Cq+i++4rMGT0z94hpJle7VRUIUWDfj6nDdFKLjFR
	 IBdiMr0/Eouuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Daniel Lundberg Pedersen <dlp@qtec.com>
Subject: Re: 5.15.y: Missing "nvmem: core: Check input parameter for NULL in nvmem_unregister()"
Date: Tue, 24 Nov 2026 09:50:52 -0500
Message-ID: <2026-11-24-1-daily-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <768938ea-ff6d-4fa8-bad8-fcb8713a008a@qtec.com>
References: <768938ea-ff6d-4fa8-bad8-fcb8713a008a@qtec.com>
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

> 5.15.y is missing the commit: 8c751e0d9a52 ("nvmem: core: Check input parameter
> for NULL in nvmem_unregister()") which is necessary for the commit: bcf4ef28b083
> ("mtd: core: Drop duplicate NULL checks around nvmem_unregister()") which has
> been backported to 5.15.y.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
