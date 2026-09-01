Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E2D38D401
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225726; cv=none; b=RpiMn4OGwVjkuHrS7ukM9fvCMlYL0N0kBt3eR94bAyHmVBesRsSN+uW0Tk0iKvcjZ0LvAfyEFflTAchNbXBDK7WmJjTWgSwxpAumpmvVnu6mRbJVFNf/AGZ7wtD8kTjJ7S3duQkreM+m944a4OV3/KUTEzEgXfdYeQfJEoYX82o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225726; c=relaxed/simple;
	bh=6rqNGRI05MTg3X7tYJ1D9gyjd6S7VqI3csAYUBWnpmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUgubh6kZkOS4cOa95+e58NTCiTNnAJrtJhWQDpJbzqXr9paOgKG+S6WPmaaGRGjTb7xAI6iEghj1Rt9skcv9GzAFUxR3y+5Xg3d28xodfbb/RccY8pbZHwxVMDaXAlHE5gRyVBFO5S1/mCS+rYrXN+aF2Sc+V5PeaSNeLMsPnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTW2m3qP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTW2m3qP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CE81F00ACF;
	Tue,  1 Sep 2026 01:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225722;
	bh=ASU7g3anovkHpYoZgeQ+SB161c4YLAodmgKH0HQaK/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QTW2m3qPAxOgbY9HIx8AvqcQA1VBvmLz0NfUem43EcGh2Q6b3Ysux6EAQrzsXv4F/
	 eKhHtW4cfZpmzxsVbiNjgG3wkHVzpwzv4REDmSTa2k+LC3iv9C4D+13y/60dLLLjNP
	 Oxl/Bzvjk+rvUWeerelUt1hWyjn1vy0WAcX1qE0hCfXbBgkJsjO4rOf1HtTUI97zlB
	 IuqTvqrqATXQuMtdoxoLOWP+e+qSWDrdxozfbscn/h4Z5iBmrWykzLHCbc9qsejFyS
	 YVk0NcBpbOqFF605Xt9lJC8EpSSs4Yb8zVV03I4YP9me07On8ljnX8ARBkLPv4dwK4
	 IhFv4HblfSRPA==
From: Sasha Levin <sashal@kernel.org>
To: Artem Dinaburg <artem@trailofbits.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Please consider these upstream CVE fixes for 6.1.y
Date: Mon, 31 Aug 2026 21:21:51 -0400
Message-ID: <20260831-daily-reply-0007-cve-fixes-6-1-followup@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAP3zxaDkc3nz2tGDfScvAXKj_O_0PsVksJJ6u366aJ-VJ7SxYg@mail.gmail.com>
References: <20260828232904.91398-1-artem@trailofbits.com> <20260829-stable-daily-0003-cve-fixes-6-1@kernel.org> <CAP3zxaDkc3nz2tGDfScvAXKj_O_0PsVksJJ6u366aJ-VJ7SxYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Thank you so much for the quick queue. I have drafted emails for
> effectively-free CVE pickups in other stable kernels and will send
> once I validate they build post-patch.

Sounds good, thanks for following up - I'll take a look once they're
in.

-- 
Thanks,
Sasha
