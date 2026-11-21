Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795282168;
	b=dh6599DLxHsi2xwCcoZvTY//rRj5Avabwo1hDtWVJP3LkohoNmFxv/w+AOTMAOYIwKS1
	 kPhoieG/IgPZT66loBAoVmVQASFU4zpVzAiWv05FA9AF3n6f1jCZ8R/C6Y0FoeAqcBGU7
	 d0PExVncPi0km1IuTP+qOT6G6XmEoP0yQ+wRB+kVM61P/XHQTDQrWrLKfCYZLwio6XBBa
	 /8K/BJ9C9OR7tPNAlG8j1bkXEshw/XhlbpqRVviuz0+fFtgnRMFJrOF8G+AGFztuz7ZMf
	 do2CiJ2FiFUWi07xTMB8mRr6F+HAn3MyjkWBTegBnsVrr0HP199JRVlr2kNc9DPgIdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282168;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NJvtiQFrK+TKOzdlaogJMSqLyClicrfyTdVB70PUMlI=;
	b=xskejg1KofZ3raqfmLFTD7wCmrzYbvL2zUKXnfyFmeNH2Ty7byxa7/NMkjfrJpg55nLj
	 0Lc8O8pTE7ehNbOPuG42FvZjmZoJsMviiggvfXNuE9YdeppxcP4ZgvxjweFW+DT89BSrx
	 Qdjg9Z4iO1x6opq2yNqqSjOYQsfZAhhZZC1Oo5THbWG5NEsLW7gOpnYQ/dCBvexpD07xQ
	 EHg/dNK3+iIb3F2UE2LK7J2WQXxgHh66hOosCGFpFYog43C3Zi1WyoRf10tVrgRrEnUpd
	 GtrDRWyCF6DPZrecjLw1s3YPEiCtjPEFEddHKk7WFtChxdRFhgrWuWr53iezmLr1bGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RuZEFH12;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E0606A320;
	Sat, 21 Nov 2026 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RuZEFH12
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4521F000C0;
	Sat, 21 Nov 2026 17:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795282168;
	bh=NJvtiQFrK+TKOzdlaogJMSqLyClicrfyTdVB70PUMlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RuZEFH12nvc2PIbb9pavr1AbcZ5VX507aGY34xBjHeKBSPsbw8RiW3S6Vq+F/+RuB
	 zvl/t7XXqQ4bO57J+rIZge5gQHAyIpvucvFW2CkDhTjfgK6o3sChHdm6hX5603pTYw
	 jvN9pQLVAdwoOVp/TOOCGg2Ym+Fl3l+bN3NYKmYVYJIg51s4pudgnEW+kkbcjcg7f1
	 bPpEIwI2rRfCFtjCnYeCP0sXHoD/D98SG6wn2AOc8e0+24rDxPl4Z4c7Zqqjq8ua3e
	 c9NCrmW4EqGkUtlLMk3O3NR7JwJbmT98JdYhKlubfdYlaBC11LWPfxZYBODW5Kai8h
	 Cj/82WdZZ/TBA==
From: SJ Park <sj@kernel.org>
To: Yifan Feng <evanfengff@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: fix damos_walk() hang with zero watermarks interval
Date: Sat, 21 Nov 2026 09:29:20 -0800
Message-ID: <20261121172921.84465-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121025626.75981-1-evanfengff@gmail.com>
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

Hello Yifan,

On Fri, 20 Nov 2026 18:56:26 -0800 Yifan Feng <evanfengff@gmail.com> wrote:

> kdamond_wait_activation() cancels damos_walk() requests while all
> schemes are deactivated by their watermarks.  But it returns without
> waiting when the watermarks check interval of a deactivated scheme is
> zero, which is the default of the DAMON sysfs interface.  The kdamond
> main loop then runs with all schemes deactivated.
> 
> In that state, kdamond_apply_schemes() finds no scheme to apply and
> returns before it calls damos_walk_complete().  The walk request is
> neither completed nor cancelled, so damos_walk() waits until the
> watermarks activate a scheme again, possibly forever.
> 
> For example, with a scheme that has the free_mem_rate metric, zero
> interval_us and a high watermark below the current free memory rate,
> writing update_schemes_tried_regions to the kdamond state file never
> returns and cannot be killed.  The writer holds damon_sysfs_lock, so all
> other DAMON sysfs writes including "off" fail with -EBUSY meanwhile.
> 
> Cancel the walk request in kdamond_apply_schemes() when no scheme is
> activated, as kdamond_wait_activation() does for a non-zero interval.

Thank you for finding and fixing this issue.

> 
> Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
> Cc: <stable@vger.kernel.org> # 6.14.x
> Suggested-by: SJ Park <sj@kernel.org>
> Signed-off-by: Yifan Feng <evanfengff@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  I will repost it soon (~1 week)
as an mm.git merge request.  So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees



Thanks,
SJ

[...]
