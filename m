Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD803D3309
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125686; cv=none; b=S/RF0sDHdwVVoglYowLQUe46lPMe1o8b2r+DDFVu+4hQyokWsEkC8N87Rb+bEGrhYilAr1f2RhZ2VQ+YbROzd7YTswI39tjubvlrdJ8B9h6EHQGaQ6F2dt/UdizKSOFwWa+4KLKyjfQXjvIXFsWWSp9GBl5tqmsqmeo8X2qvEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125686; c=relaxed/simple;
	bh=cdmIdujGk2Ydmvn7IwKxFmHElOMBnWaGTsddH35XPeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWcL7mkPEpTg9IIAuei5NkQs2aTTNowMxx+RkC7nHOA0LXvljGPj9HkahiEGCMihdqYQnlu/rhgf54VYI0JfeCdnHPbR2cef6VuL4B1WCDz4ppb6SJbvlWKJu+PNoq3M6PL3kqef7TGT5ULqQ88O2v90VrVydC/+4Vf7U2BSazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okN+8mG1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okN+8mG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D971F0089A;
	Fri, 11 Sep 2026 11:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125683;
	bh=XKf2IaWPsF1/+yCKHP679TI6GT7HhtNGvvo1PUvX9W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=okN+8mG13RjSgX0YPuez08I38WOqHV8rQqCFUE70QKRtKJfxA+Tvbs//xyHTBE2DM
	 +W/UlEN9Wpaw50Dnw3QlaQMMWOCa5t0TT9MomgNnIWaQvpzCvmJM7y/K0XkgJ7SN59
	 mlkliLFmm719KUHoQj9pWKhSAW0DJ/s+s0nem8PwmG36y74I9xIWsMiXsxWSmHXxL2
	 getXOpB+noHnuat9B+spnOLawdw8X0x2Sdp/gmqMOgFzUY4Np/J7eyP9gg5ys5IaGZ
	 7qBDywsJHE6gncYIRiJniYMgAy5i+Tiz5LgCeYpu9fLCXXtQJ/He0JoptzqevX0aug
	 oqSzzEj2yo7Iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	doebel@amazon.de
Subject: Re: [PATCH 6.1.y] perf sched: Fix register_pid() overflow, strcpy, and BUG_ON
Date: Fri, 11 Sep 2026 07:20:43 -0400
Message-ID: <daily-reply-0024-re-perf-sched-register-pid-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909210503.199459-3-doebel@amazon.de>
References: <20260909210503.199459-3-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 5949d339f5ec98752d56dcd4e36f619a59d513a5 upstream.
>
> register_pid() has several issues when processing untrusted perf.data:
>
> 1. Integer overflow: (pid + 1) * sizeof(struct task_desc *) can wrap
>    to a small value on 32-bit systems when pid is large.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
