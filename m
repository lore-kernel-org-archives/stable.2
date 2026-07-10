Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BE53B14C2;
	Fri, 10 Jul 2026 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717432; cv=none; b=e/o0boq1lZTOmaQlSpVoC0msT8rXNOf8CO4S6DJd1ZLRiN5850jM2C6xfWZbyKs7pN9p/hfNG6DGqqVK9Mv2H/+GUgBfuFlrBUbiQ4RS8jc8IUOs9VqDySlXxeDq14dR3LdcbwfJYUPSBHHo9cUGa0ifuaxG6gB8WqDQElNc1RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717432; c=relaxed/simple;
	bh=EXRbjcDZax7xqUBeZpdRd8kc8uGhUKu3fIVFfdAgEw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2fvut8FAiFDnvOLi2NGYzzYuX+UsyilKswbH/70kBh13TrXyGUfV18480hFYmgULU7eMjdpx59tTmvkcAhZ1Ed6ZeMLARxZLFQZcmuXTH+uyZUTmC98DKIagWQRZDBHzo2UFPeyHS1+YjI6fs3GjWTxG6wYHvg6Bk35Bi0nXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLwxde7F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLwxde7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05021F00A3D;
	Fri, 10 Jul 2026 21:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717421;
	bh=CX9f3IHRDl+LxOwV18ICMEVvKvPD3+hMHqlziECFXiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lLwxde7F4wta5rgC/vYag7jPrY4FlwnAbqgGdUxq92momezdQ06sa3amu6AicV0i0
	 AFirnQywKUjzHPODS0GoTxCxj/6T1meDRWNysOKDjr2HUO4I9cem974kC/PhVZrvvn
	 PgSqmf8QKuW1DlUyQ3ry7Vx0G26rcXKV0UVQv5sz4qTnAit+/gdxT2rmX1VbUvpkEQ
	 onWYVr4bFtrZ01W+CGUqq+h10iPcKdhJYCzUgdTYg38e5zqneGbc8fsenhCKi9lMDr
	 3GJuFi84pugEQETJAsWFBhsMNXIWsHDycLI2Z9MIg83rsZHV3sdRTPDdzIxH0+oQss
	 73XImnPZWxLTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: Re: Please consider fb3bbcfe344e ("exit: change the release_task() paths to call flush_sigqueue() lockless") for 5.10.y, 5.15.y, 6.1.y, 6.6.y, and 6.12.y
Date: Fri, 10 Jul 2026 17:03:11 -0400
Message-ID: <20260710163023.agent5-0015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710023120.3747693-1-michael.bommarito@gmail.com>
References: <20260710023120.3747693-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 09, 2026 at 10:31:20PM -0400, Michael Bommarito wrote:
> Upstream commit: fb3bbcfe344e64a46574a638b051ffd78762c12d
> Subject: exit: change the release_task() paths to call flush_sigqueue() lockless
>
> Backport note:
> The mechanical check above reports whether the upstream diff applies to
> each listed branch as-is. In this refresh, the upstream diff applies
> cleanly to the file snapshots for all requested series.

The diff applies cleanly, but it isn't safe on any of the requested
branches. The commit's correctness depends on the v6.13+ posix-timer
rework (6017a158beb1 "posix-timers: Embed sigqueue in struct k_itimer"
and friends), after which timer deletion no longer clears
SIGQUEUE_PREALLOC or frees tmr->sigq behind the exiting task's back.

-- 
Thanks,
Sasha
