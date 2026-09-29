Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607D4F7CD8;
	Tue, 29 Sep 2026 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707866; cv=none; b=dax5D/ZTNlfBU8qOzbZuCBZQox4swPyeqyapM/bxwodNs3yx5G35c+33Ab9Ob4VAP8W2sm7MqkJGfTwCveckB6smfbL+U+KxFumy6IMyClILNS9La+Z8zMjlU+RLNlFqC86Fg+iX3UxvFnyscHRxwh3RyWdBmIdsO1bIFOq+3ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707866; c=relaxed/simple;
	bh=jZARZh/kJWZLMRXMwDt0kf04BNmdlKi28dWs7crjX3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blO7NWMmVGLkNAOZ1lQrnDMpLYQxVLkgy1qV5kcVOXEAak9Jko4VLRe9aC0s7OeSuKL+z6ipxyNyFuuSx8L+743mpXEaduvLDIGNeA5gpMF10WGbxDvZ9NZm00cE7WEs6Ttf1NC6XGKLODjX3GOojEcTOsLcd+xikKUC/jNQ4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIC7Hwy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIC7Hwy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3DD1F00898;
	Tue, 29 Sep 2026 18:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707864;
	bh=Fxj2t9HrjooGG/e+u1xUODbbTsALcUEZoywvJj6KxeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nIC7Hwy4vhv54nXHvMyK1Aob5XAJStNNztMMPfgv20gqCVEx6YgYH0ru0+f4DDlWC
	 8zkGVOVp21UMk0sUn3zdUzdpvsZ/T/bPRSMHgHXoaYIPz8AjiTlSkOeUGjAy2P4b0q
	 P595PACawK5QNJSdspqqwBQXhPqw6jumc6ZV+EyUlgQqMAkri3GHxO+7JD6i1YBzfR
	 6nMWoJjofRb7Dr/l2YM4Rvyj0AnRwHVPpCcW/KYdjQEhg1Aud+q5y4JYZtn471j/UX
	 Mvx3GJd63awlfhJv/2inuM0FlLHG/3fZ/nwHAT0Qr/KQVow1Yg5ROyo/t1giW+YiSp
	 bIg2LCjFBUFkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	sdf@google.com,
	toke@redhat.com
Subject: Re: [PATCH 6.6.y] bpf: Defer work in bpf_timer_cancel_and_free
Date: Tue, 29 Sep 2026 14:50:46 -0400
Message-ID: <2026-09-29-daily-reply-0003-re-bpf-timer-defer-work-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929030524.86560-1-artem@trailofbits.com>
References: <20260929030524.86560-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This one addresses CVE-2024-41045. It defers timer destruction so callbacks
> cannot deadlock or leave an enqueued timer freed.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
