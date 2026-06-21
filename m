Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B025B2F4;
	Sun, 21 Jun 2026 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049680; cv=none; b=uutv8V3XSEUQwTmw++zgs68v96qWC/a7454+5sV7WNEA+idL1qtND8fyHxFSV+49UNQc33GmnlG/gsl5veMO3EtpuT3kncNo14Id3wg8VLU8oJuxKTK6jPs0rxz7Wii7J4RKe/ewN2n1MYO5yHWg0KPwm0mrqSJmT7QnocxYTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049680; c=relaxed/simple;
	bh=M458LoN8QZhqyhBARrCTEOqQee58V5gjjh6Md3VyKJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7KtXUi0oWtzbE3dKORGnAahRpViTUCeTKxEqdEfK/TzoHfMKnHA2uMClWMcDzS6NCUYUPfyYQhAyipizdtw1aJZ3ruez36zMYeL2r0orh2Y8ebet9N2kgr07KFAfAV5bfe72Ejl4BNiOpuis+cDxhvikXX0oJIZJKw2T0iJjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4CN4vgE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4CN4vgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFB31F00A3F;
	Sun, 21 Jun 2026 13:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782049677;
	bh=2jxR1WwgEoatBQ7xflfDZUIze5ZiTfoay/yY1hYZq7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C4CN4vgE8QRkiqJXnDPEvFZuVJrHkYap3/0pMyTXHIk6bo7CDZ1E+M/nWb1Tfex0a
	 9u7RyABJ0nd5cNCh0LLQvSZQG2I/kCKmiraJiws7xdO2IKNsYA6CkGOvTwmJw8dA7w
	 CoUdG/7LdLQEDuljvB3gI04jgAu+NU2Al1X5Iy3e3vQvIpvh8MZ/zGSDbEdSHGEWZi
	 b5j37u1F9bYv/NOe1ww/J7jc8qE6MTuacUsam8bhjd1VmYEQH0GmzQeXAtZ1XAHcCZ
	 L0aKZQfBa4DTafjiEOgwdffQmnI8nfH4nzncNZXCqHxfTJHaTnWapAlS5z2y5OM8De
	 NAxOSf6zPO0dA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Kirti Wankhede <kwankhede@nvidia.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>,
	Jiacheng Shi <billsjc@sjtu.edu.cn>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 5.10 5.15] vfio/iommu_type1: replace kfree with kvfree
Date: Sun, 21 Jun 2026 09:47:43 -0400
Message-ID: <20260621133722.0005.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619150206.1719815-1-kniv@yandex-team.ru>
References: <20260619150206.1719815-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 2bed2ced40c97b8540ff38df0149e8ecb2bf4c65 upstream.
>
> Variables allocated by kvzalloc should not be freed by kfree.
> Because they may be allocated by vmalloc.
> So we replace kfree with kvfree here.

Queued for 5.10 and 5.15, thanks.

-- 
Thanks,
Sasha
