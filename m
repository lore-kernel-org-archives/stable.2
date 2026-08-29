Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB5282F15
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 03:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974495; cv=none; b=CbMwAz9TJaSV6S4C+kTZbkUucUCtZ/H8wF+eMDqjyHNpGxKsyhFCE3FtIoGm0bNs/BT9XPJNIyy51exOKlMEBrP+Q+OuMW94JMFE4H0b4xDZHPOQObDd/5ExDqgwiuAwTkLYadwupEsGjJTgvFrYjXlgJIwXijwSUBvespGUayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974495; c=relaxed/simple;
	bh=kKJwPMCR8mmEteQ0G4Erm7TSg8nGxLMjyiVnN95ILqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOob9PawvtusL4r5r/s7iEE4cBr6eSRv7Kl1npBWlVOkvifxJHFZsXgBTo5NnzzrBDPqpJhxdWoP4AxVUeoDPGGRmgzM5b/dR8j1o4WC6eYdr3xjPowB/bAYtx/V5ScYYB3A4J8yvzPEi4ejtJ7Mslb0CLwwLFSO/ow+WMhyydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKDZ55PY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKDZ55PY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E151F000E9;
	Sat, 29 Aug 2026 03:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787974494;
	bh=kdNQ7yEbSHVOWBk4FFTvNTPTXQRm/iiNGDBRMBWgZ6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CKDZ55PYC1qgFiGjXUIjDpzOQEnIKdEn9xHJF2aK/XOPaZmuc/WAYyVPTtL8/9c7B
	 1RYfZtSJfU82TC9YbsiLqK1Z0I4M1jSLWBrQxV0OTRNqV9/9IvFo4lg3x2WTfuaSVp
	 TtRm22gOnxuuup3GxVY1VTYsb4LpjlvbRYBqvjV8/MHTmYlaQs2c/C9r1PwaSWC3J2
	 6hugZJ8Hkaxe9O26XF8PGHXtWBd0jonDoL1HUpQ0fFAmOnS4eXqwKxM9sw3SM60jTs
	 EBkXFDGKGXjTDWquviTZIVI+yMw9HKapgU536IsiLGqizW7+UhSlFr32lUPup2GwL2
	 LQ4tnEDKUQ8lA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y 0/7] Backport bugfixes for selinux
Date: Fri, 28 Aug 2026 23:34:39 -0400
Message-ID: <20260828-stable-daily-0008-selinux-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827191317.18119-1-guanwentao@uniontech.com>
References: <20260827191317.18119-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Backport "selinux: require a class's permission values to cover its"
> more cleanly, base on Sasha`s backport for 6.6 before to point out for 6.12.

Queued the series for 6.12.

-- 
Thanks,
Sasha
