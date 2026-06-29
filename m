Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94B16DEB1;
	Mon, 29 Jun 2026 04:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782708541; cv=none; b=nN8VYEyBz8WIt00qb0V7PLfHgJUa6a45gmpHzq5NkDUWDDvTnfqxRXEEQ79wbB/fUhq470AYFx5tiiXRBVRbOpmRDNvewb0t99OjlVZ9GRd0EMzVRqM94F34CpNkJ/rtF7bivE593WHwKPTkgq42hKtU4F3yXqGw4ZLZBLsAl3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782708541; c=relaxed/simple;
	bh=1VnaWo7c623APspOxGxjo0o52OWaMYMblPtYIZUhQDc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k83ptMoWZGYOWB1Rin6fg1MRChgloxZ03wSiW4ksSOas4hHI+y38Jd0K8QcGDSMUWTMlVFN6gEy9qv1LpSCP4uEbncpQBtUcEa1uwcL6rK13iH2d0UYC10QhXS6mq9sZWjyFsxHBaIvcPLy/iVZggwth/WxKlKrhm/8Y6vafHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MgT/g++5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MgT/g++5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACB71F000E9;
	Mon, 29 Jun 2026 04:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782708540;
	bh=gmnizGxCysKK6WdG3KVzor5R+I/41HYhqEFAWV6pHpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MgT/g++5uXB/waAH9DJz9YFhFjYPNtNqoc9mrl9DN5t1cVJ5QcEEaaZq/FF8l7Ypw
	 HwbpH/D7APWdckzktYPNZJ9DdQAV/J5PDSezNXN92gOH2K8LZDY5QCRtd2h/2X7PgR
	 tBob0BV6dKSLzRBlSeWpL+ANRql93PsEZoi/wrgY=
Date: Sun, 28 Jun 2026 21:49:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/6] samples/damon: handle damon_{start,stop}() failures
Message-Id: <20260628214900.243ae17b910c18a4434036d7@linux-foundation.org>
In-Reply-To: <20260628215447.96166-1-sj@kernel.org>
References: <20260628215447.96166-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 14:54:39 -0700 SJ Park <sj@kernel.org> wrote:

> All DAMON sample modules are not correctly handling failures from
> damon_start().  Among those, mtier also has an additional problem for
> handling of damon_stop() failures.  wsse and prcl also have a problem in
> their damon_call() failure handling.  As a result, memory leaks, next
> DAMON operation disruptions, and use-after-free can happen.  Fix those.
> 
> Note that only the damon_start() failure caused issues can reliably be
> reproduced.  Reproducing those issues require the admin permission,
> though.

So it doesn't seem that we need to fast-track all this into 7.2-rcX?
