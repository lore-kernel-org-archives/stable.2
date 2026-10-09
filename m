Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4A73BF676;
	Fri,  9 Oct 2026 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565832; cv=none; b=kk1y2Ds1HXBAr2JCY3br2aj2mO8eHW2KFFnNkmPfFb8z9DyXkgxyoJ1rvHaZoXIC7UAxMVinBlzGRrsP+/cE1FMA6OtLeyNoYTrY2uoWEM/GMkBrxnCw9I5as+K2xYEYe7TQSoFtu9W7T6tKY0Ol0bUBJ8E1bbY4pP1hQ7uC/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565832; c=relaxed/simple;
	bh=vY6L4NTvm/on6IWMnloYlwQJX0aRNJuGQuYsvtVGC40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aI0Ty7XT/uyLazTN1b+qZmCzPLJ+6etvUQ5+viIuW/7wO2NuAUT481gyvEDmKkcEp4zaap+/86tsAMcPAP7MOwEL8xUSHj3BUpsSis8x8dMUMO1MR1B0cPHJ5oG8KnLW/d4rkrivaaVdpOFh76J+Psr1yqcDv0uvdQiKaKbA4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wmxowf33; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wmxowf33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D4B1F00898;
	Fri,  9 Oct 2026 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565831;
	bh=dmxj2lj4Q4GvWHDzZDgnLPWqXygKdSJybIHJoEn8ViA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wmxowf334BkRZFU6Sq+uwK2c5v9j4EnLSle+yuIxbw0dZoW2zbp0fanJ3gjkSzjlg
	 ++J5V5kaKFWyO50Jl1QWmLE98n1bC9sGm9nyBGYh2S3xa2FjRSCHhuqsUO41nflxsE
	 HF2AgCutPzPCaKnIxuPIaY9WkS0OvpankhXXAzlwqBkuVCvMpnPGAmwupB4qR1BX4q
	 y7pVdBA7HD2YGln5FnmdyMGutGkG+xpvhjIoiak5Nrz8n5urXSS1zeK4oPcAT+KvjI
	 1SMKLjs3nGGyEl61xuJW/lbEGxNl3dMETwT3QENiyz1QiYF+b9OzkVDVLfQLr1X7dM
	 Ivjwqv6bRwygg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Helge Deller <deller@gmx.de>,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH 6.6.y 0/2] fbdev: backport CVE-2025-21976
Date: Fri,  9 Oct 2026 13:09:46 -0400
Message-ID: <2026-10-09-1-daily-reply-0009-hyperv-fb-removal-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008191309.98263-1-artem@trailofbits.com>
References: <20261008191309.98263-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you please consider this series for 6.6.y?

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
