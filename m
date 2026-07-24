Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D94334B5
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892178; cv=none; b=rNx+xpOi5l1ou2tSAp02A5SIqnhiE/yrtkxa9sVzwG/KAtyPAfE9+l6vp18J8d0yS4NOHVvfLvrAUziMPs6/GDkJp9KZ16EtFD4/HnUyuOUipV4L+HA9Cm92pNmMsfamjy0/2GKMkmg8fq9VV5VRVaTQAd+R643ShhEtQ4k2YmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892178; c=relaxed/simple;
	bh=QItzr9nhObaca7tZRqvZc/b75SOj/7z7kwVz14EOtnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXGGydQ4VcB/eDkcJHkOp9ZnEzFlgkuonT+LXkxTi1KG+og7Rarms9m59XCaz2LNhvTNLTPk51B9LqWAwHWj6/oJJQAyLHBW6VPa7v4TD3wqA5DxIlZz9wXRx84eGzvyLHouXPF3eoSjn2SITX820q+A+Zi8c7SoAYwh2eQmDzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqRONGvz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqRONGvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1F81F00AC4;
	Fri, 24 Jul 2026 11:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784892176;
	bh=g60IlUTK6aCjsp3P++kp0mmvAcUPRAflFk3HvQkULT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CqRONGvzEOHoYeKEoUwramnA3jN/1zYF8nn/9xAM8zM1djckiZkbbnPcb692R4Jxc
	 fRfvCDx+AofAHGwYJZFg8Jg8DmhqZGFdJSyT9TAr+/bCZ1LbHDPcJhEIvj67qnlNH3
	 C6d1Q2kVzg6enMC25Wd6MPwCD3JzgFlryX6hKOKpdkk2Is7qvj4ydJQgh3p9aBIfsF
	 6WUhbS1SGfbVLO3wlhHVcJPuJdVjE3mzSUG7YZ77kZ4dS+xUj3II9Fs8ZFUwNiVB3u
	 9Ch8XIWQfxa+YoOO41XIAQsGf7mCOFAp6lbCVX7smlyt3FP4QgtEWk+c6ih19qxvhd
	 DUP837t1mH5yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Daniel Gibson <daniel@gibson.sh>
Subject: Re: [PATCH 0/2] amd_pmc: Backport additional delay_suspend patches for linux-6.6.y
Date: Fri, 24 Jul 2026 07:22:41 -0400
Message-ID: <20260724105500.stable-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722165402.3199573-1-daniel@gibson.sh>
References: <20260722165402.3199573-1-daniel@gibson.sh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Daniel Gibson (2):
>   platform/x86/amd/pmc: Don't log during intermediate wakeups
>   platform/x86/amd/pmc: Avoid logging "(null)" for DMI values

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
