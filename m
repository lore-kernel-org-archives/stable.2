Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F06D2701DC;
	Sat, 27 Jun 2026 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578137; cv=none; b=ExbgBXC0Eq6lltmBL+i3E9bdXkVtBFQ9mtYo8SFRz8sE4XVwP2r/oTcm/WUMCL3eaAlHRo9A2kz91ItvXiJp8G1xRtkFHxoRDUCAmUB2nJc/MDdVV27gwTqaW6jgBiAfm0/SndCHc1XJK012c9pOhWLtdlIRJb9Cvz3eYSQ4yaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578137; c=relaxed/simple;
	bh=JDqATDG7YNAzCMf+80Z1zGlzNEfShKBx7VoZq8JM1wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i42g5xZFCvNyGja5/3z9FKqusRTXxjBVXLZFzboWTdALvmftAVuIIuDNG4J38PSvDELQxt7HgYeQWMBaB+VDxvz1bFw3tXTp6Wz80Z4dQUu5DvrVjznLO3z12Wd/ye+nuVQELXDMblAd8ZLHton3ykZ9PtMeILZxQghTR9Gepdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CReMyhSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CReMyhSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6018E1F000E9;
	Sat, 27 Jun 2026 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578136;
	bh=6dAN2gFUrWYuJCTysU1oLdEdPytBC2n2+gDMLWQW3sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CReMyhSDSoH6iThdRcSXpCGszEQsISpAQQWNTbEYBJtgf0imxEx8aiAyFdRJM6XpQ
	 Frb8x9R/w2ZUDSAIk/88/xbb0BdnhwsMjptxVCKb6WYqwkkXrSkKkZY312aNvNGK1V
	 hWGChOIE6nKv1hju910+nLppJevizNKiBhu5L8SfFMDa5L/kcxJM4CuFd0H6EoRWQJ
	 cRvw2GH3CE+155BmNZtQ110U5aHczuEr+oz2SAm0c6/ByY+CfeVGPfPYdS4QoA4jS0
	 9Nx7vJ36J8VWWjv2JdBBctjyF24/HKFrz0N9My24kViONgN5JY4ZTCzYEvoT2eOvUp
	 UcqkV18HrQicA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	tristan@talencesecurity.com,
	pav@iki.fi,
	luiz.von.dentz@intel.com,
	linux-bluetooth@vger.kernel.org,
	Siva Balasubramanian <sivakumar.bs@gmail.com>
Subject: Re: [PATCH 0/2] Bluetooth: btmtk: WMT event length validation (CVE-2026-46140) - 6.6.y backport
Date: Sat, 27 Jun 2026 12:35:24 -0400
Message-ID: <stable-reply-item008-btmtk-66-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626104604.3465124-1-sivakumar.bs@gmail.com>
References: <20260626104604.3465124-1-sivakumar.bs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Jun 2026 16:16 +0530, Siva Balasubramanian <sivakumar.bs@gmail.com> wrote:
> [PATCH 0/2] Bluetooth: btmtk: WMT event length validation (CVE-2026-46140) - 6.6.y backport
> Please consider the following two upstream commits for 6.6.y.

Both patches queued for 6.6.

-- 
Thanks,
Sasha
