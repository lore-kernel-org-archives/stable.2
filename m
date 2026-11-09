Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185946;
	b=hDLWB1jNgayVf4MZS9qyUwd0S+ZGnQx58Glruk5cZPI1m58sTDZtSxex8Gi5O4HKpR2c
	 LKuJCmBeOoPK4EDjQ7uHr/wGlWloqAV7GDRgxXwXSXKzGyEyT6jlV2D20RUL7blEyMYTL
	 qbJKmYtvHFgaFKEG4/gUJC+iWNkMDxN7wT6rD6z2g9w++bmO79WKXy/bxJo1x2OQ37IVx
	 yv2ITFUzXvfYZkjHQxcs5P7IZjAFcwOwSEKl88wma+UXF8jO5fYCuqZ5ai2JP4y1If3yV
	 K309WbQrDlGfjUfnbRuQ77ieXT9+oN4eqzr5nQ+ZeHKLJs7hHG6IbiAPGGjwcZsZ8lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185946;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wRZ+9weq0Le6c9wBo/j3BdKIziIm6KkYIs1dhkLyUZo=;
	b=pm03hfWxVenBNHm6tXpPnv2axSHa4LHwFBXP92JmsuO7fJ+2n5QljrCXPy24co88Niti
	 YiYcmkWCGHKelrNuiHwB41qo1yejfAWZSw3GBS1tLTJIgClL+Qin+qOTIXzk6nkauDU/5
	 jaAj0skmwOjqMXuCzdHYh+utha/6s+pJM9902Lx+Q4Eg7a0Vj5u8s/lRYxLo8zflrl13G
	 Di4o5nPmDC+U4cOdElCyFtmwPf3ALelZ19SX7o+IC8MwIlyGcyVrjMno7iOUSy70Sr96k
	 EK2QGSdOcNvrxgM3s9tion0xpxORGTAGbdvU8lqsGH+/EcxwTbps03OdOLHryKvargQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fon+GDf3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F71606A31C;
	Mon,  9 Nov 2026 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fon+GDf3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE461F0089F;
	Mon,  9 Nov 2026 00:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794185945;
	bh=wRZ+9weq0Le6c9wBo/j3BdKIziIm6KkYIs1dhkLyUZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fon+GDf3Ax2qr81devlq5g96iZoFlEWWROb1X6024cru6iLVLU9ExtJ0oE+/x4k1o
	 wRQ70J2DCoK2qDRKKW+2ZgCOf/Qw8IMO7V6XVNV16QvWMfVpsKHy/YPIUPO7ceh+hq
	 n11rSR4ThvGFL0b33BOanFcw2vpJ/TLxxcHVmi+mCGRGtjJYxMV/NM1jIia2YvVBz2
	 qbql4+xcbT9FeFeM5GqWLhI0kxSNtGnWDU+ggU9mQI9dfBlSpMBctTDctBHUOUoHuT
	 TNok8DbfWDASNeECp/4pf+eJWW8/7agvKP3OYINQPHeVbsJXPtTiwEUaApF7RpeJBX
	 wdr+fLrRkwwKw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 6.18.y 3/5] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
Date: Sun,  8 Nov 2026 16:58:57 -0800
Message-ID: <20261109005858.87582-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109005106.77748-1-sj@kernel.org>
References: 
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

On Sun, 08 Nov 2026 16:51:14 -0800 SJ Park <sj@kernel.org> wrote:

> On Sun,  8 Nov 2026 19:34:34 -0500 Sasha Levin <sashal@kernel.org> wrote:
> 
> > > DAMON sysfs interface reads the user-provided size range arguments for
> > > hugepage_size type DAMOS filter twice.
> > 
> > Patches 1, 2, 4 and 5 are queued for 6.18.
> > 
> > For this one, af19aff38d6f ("mm/damon/sysfs-schemes: read
> > sysfs_filter->sz_range only once") is also missing from 7.3 and doesn't
> > cherry-pick there. Could you send the 7.3.y port first? I'll take it for 6.18
> > once 7.3 has it.
> 
> Thank you, I will do.

I just posted it: https://lore.kernel.org/20261109005724.87550-1-sj@kernel.org


Thanks,
SJ

[...]
