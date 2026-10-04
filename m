Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7396F3BBA1A
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131406; cv=none; b=RGsoJbLre/ucA3AnG4aNXYy/j5PZloFoBVrvGb1j4FTI7/T0Odou8G9s2Q7KbKLHax6eA7nYY9JGZGSYnn+ld6L1kizwoeldj+38XkkEujoCXimHWuDg+MxdTChnCvgxEfBgLx+Xg4GSUUvpzMEySf2uFKcQShhKnPgxMQpyTkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131406; c=relaxed/simple;
	bh=AdjoQHxYo9iOfTqkCx46drVsEvTh8MG5svWsddOsgFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNFTvgkM6sEkMSU9ZaGVQajC4UgF20rY+RzedhccmNMYT1A9bckrdY+52gPb2rubACECz9RrfHaprpfFvjwNMtS1xXwXlSVH/c0zHUXVrD104RHZNEDrhGH5lTNRRHuqN9q6PaM0c9VkIK9DvmMKFZTyz9ixvHV+gRUTe/eRrng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWPrl5DW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWPrl5DW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A321F000FF;
	Sun,  4 Oct 2026 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131405;
	bh=QyqacucZ55bSWJnFMejwXbk3OOrhwD72932DcyeUP+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hWPrl5DWFaKGjP8tZ5gkO3vvOKAObvW29XndE6GGCB6o82GqShG6tNn4eyFAXZlhe
	 dEaLMjhNHNSUWptjkrb0GV5+zRiGJjN9fCwRknObI4U5g77TpSR3mAKVXUxiVvpGdn
	 t5dKcVQ5Mv2RTSBlwaka5P+5x0MFtfJAhbUon/GLVMnYzzGW9EjIzFaHO4FxX2chrp
	 EBprh+zB2+yFAO4SGL1QW7T8SJha8NijoEGZBPUzPfIqDXHHu/xgv1BDneBdrpotqd
	 fn+Ft++H4hAO3YhhJEDFKoHyXbNCuCiCAn8BkgNufsv9sbNY2Ijzqjticmui5hO2LA
	 J7w3wyAm0S6zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Please consider these upstream CVE fixes for 6.1.y
Date: Sun,  4 Oct 2026 12:29:41 -0400
Message-ID: <2026-10-04-1-daily-reply-0003-cve-fixes-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004034937.70523-1-artem@trailofbits.com>
References: <20261004034937.70523-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you please queue these commits for 6.1.y?

Queued all seven for 6.1. Also queued the cpu5wdt, hsr and qla2xxx fixes
for 5.15, and the hsr and qla2xxx fixes for 5.10. The ath11k and tegra
fixes conflict on 5.15 and 5.10, and cpu5wdt needs timer_shutdown_sync(),
which 5.10 lacks, so those were not queued there.

-- 
Thanks,
Sasha
