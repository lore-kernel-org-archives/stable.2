Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005CF3ECBED
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889795; cv=pass; b=JXl4DEtJ9/BWQd5/i0ionvxyi/yelKXHCNeFEwBcoDrNX+1Hz4c/A5LLA2Bh3HaOXRvAfauns0Pp23bQGiXIW+SGAKXqGdJOYwZlmG5xxQHYTKiQWWw5HH3lDVsSj/z71t15YSyld8C3zxYIuX4IDR0+drBbiJoyUeLy/7UkSTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889795; c=relaxed/simple;
	bh=DLs/KIZ5/ycwSa0SN3niPNJWgFMiQFCmcvqsb0nclfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+VvyJy7Y7z2GMdDI0uiJRHtvZbqP6u+dTrguIzn3A87ytIrKosceDi6h+COrzEZw9LuJjw/0rSt/fFfKxXoW/4sthGgiY3r0E6XctCDNCmKj8xqoDSlyiye9ROAy32mRW2vmD7b3Sbr+hfCSydTf3vH4EfR0Cq60Nc9COZvR+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TLUBHtM4; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLUBHtM4"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e1b09e0c7so321838266b.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 14:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790889792; cv=none;
        d=google.com; s=arc-20260327;
        b=dV6e+7Iy7PpTlyHsA/qKcFonQBNCW+5EsXV+6zCF/cLb2Vp3nf9+6sAhE4Cv7UaZex
         xIK+E56josYuEKeIn00Vcx/iQTpaWuuwzXT+QrmJSTz/5g2SjSqe/qfY7Q/CODI8Sy94
         g/lqTRIrJ+X+Eo0oAdkV0EQbQPIy5OqgPEEd7xHd/ODLSxc1QiClhXQQ/3BuxsbKv7BG
         zwrrXP08JMn/tBXL4zx/lhOVAIhsrgCLSIru8YlX9uhtvaXCEiXNUeJHheuNdkPH2J5Z
         t637Lb/JiOx3rjTHyVKxE/yAykEzN2kQG1JBBFu+BuAY2KCXFlnNXtK5JNq8O13Tmzac
         oupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bGDIIilh263XLFQkrjj0HvyT95v71lu9sg14IVq4dQQ=;
        fh=ebUrguuqhO38fNd9XPCvgJHcJE+DU4VM602dKP06WMs=;
        b=CYHhiCWfP+T9ZOMyLR1o6nk3+oIsNKu1k1E8aMlcj3QBwXbTSWm3a+V6TJBNpq5Wa0
         BPzVcdGGM/rNFxAqrmnlFYhTo8Rsfh9DIMee/U/A7GdY4pU/LDQjucaF2GBz6Och7FMY
         sX920YHa0n9xGtMq14Cd8PIHH4L7LM2ZLkCzdnYAleYeVdZmw0F2M52Zo36VVY3NrN+t
         B8JcHCZUImyqW5mDFPUW4mVkL7vB+KnkpX7ygqrulJN165jhmgOERHIP1BKZZ/4Lou/H
         DULZDXexW6UlY8Ns6ZcIQC6U4acCoFN/2LXUmbmSHhXpUvigODCU2rvK7jl9ZAlfBKYS
         S8Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790889792; x=1791494592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bGDIIilh263XLFQkrjj0HvyT95v71lu9sg14IVq4dQQ=;
        b=TLUBHtM4X9DfCuZ+6UdOl6Pymyz9MySlWXhFPcefNzL8k2Gq8fs+jKPTLkk0Sv4vWe
         TUHEzMiqAqdbdFmatWRgOhwKRlrqN207xBYbZ/R19XlEKJoOmFCuj4A/cU3y1wXDGgMb
         Vq7LOg2k2JSXkwHKZuyngZqcsAn14vS5eZtj1w9M5Y6oWQowL7z5wpQJ0PRVR17N4IcW
         ky2ZGWnqpeKVQBri8a3SkK4xTareftW5LaJetdwtXbW37sDgTWqC130B7o+gD4s/FD88
         ak7U3SUgN251Ey66LpsgCLt0xPdEYfovtlK1wb/X2RtE5zpETwrLlpu/CTxnXdsz7clu
         zB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790889792; x=1791494592;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bGDIIilh263XLFQkrjj0HvyT95v71lu9sg14IVq4dQQ=;
        b=BSKiwndeHyFp9L17uO9HZjuS2VRpewy3DVXSQwhSyYtKbzmXnnuac8C6LVZTgWzfXp
         P85FW4LHPCzbx4UeSCKzVeCizN9bQvmmoZyFffvx2CVCrWuvs+JSf0a8tj0agvFyaTlf
         sqNG2DYF1u7aeYBt3ktlr/8e0dUZ4DvKM20abKVB6Db9HuuPlwh9Oouo+a4xEKL+tkKO
         a70baT1uKGqcITBJf3dLmC8LGTU260jWVlCG7kHuJHwsY1wmEcDJP/iAuCMFm9Tv3cZK
         nxjpZKUhCo+bgFzDxgC3Hh30izhcEKFGaI6cfZFUXu3zvdCNENhwgo5mFioJK7FHvqqT
         MqNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzm2307Pmv1GtYacUnpuCMGau2pupXHKIJHNmTyll9Q/40DRdq6pl80uoNzLzDe0j7tyncxk18=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdyGdWPnlOeEewfTy+DrZGdwjCeLpmcTpSWJsHlHW38/qWBZaw
	55GKazmsfkY7yUt4x84sY7dhIz0xX5s0tGcgbyhYpd9KE8NwEzLid5UEbBzBnaq6oohId7YMuFF
	Vi2GRZkNWTbwOsnWyTsbs+omfUUXtHtVItBVktkAK
X-Gm-Gg: AYBFou2jmhRd406jy2FUkvJBTdPMyZTE+ddp2kdg5YvtHSXowUL8MDnYkEX+Tu+QNQa
	f8+t3r+BSVDGgoQlCHcgPCzGbtGUzUCRaDQYNHyUwDI6chsGFqCkMSznSH+T5OZ2llf6TEHKWpt
	poS+P1c0YSymdxg3Mt+ZAb54m9FVwqY6Ej3qIkk4+g7Dzxrhh3CRcjG+RHowHWEcdF10V538A+E
	vLbUfqGDRD3Rn3QO7jMYeDWKJfxDXqan+LLtt7R3Ut3WLI2Xt8mqcPpVKfO8ruA8xdhliilpOZN
	30tcBiSIsh1jdBXtAzohmOsOwj40W46gYGmsWEv+MSvMsuVr5ZhbknlGs3zLfykfv9ONUq2W8N1
	c9K7A6FLaRU4U87O+U4wr
X-Received: by 2002:a17:907:7282:b0:c25:977e:5377 with SMTP id
 a640c23a62f3a-c2e4ad7cbf6mr69097466b.10.1790889791661; Thu, 01 Oct 2026
 14:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001171349.81454-1-ebiggers@kernel.org>
In-Reply-To: <20261001171349.81454-1-ebiggers@kernel.org>
From: Sandeep Dhavale <dhavale@google.com>
Date: Thu, 1 Oct 2026 14:23:00 -0700
X-Gm-Features: AclHuK8XgZOhRUaL3sAt7Iljpz3t_TC6CLjoxsnzy8OUuuVA4aEvXm2un4VWkDk
Message-ID: <CAB=BE-TsYHMdwKbVPmEQZXENL1gVcwUa7Sde=e1wgGuVLKWnEA@mail.gmail.com>
Subject: Re: [PATCH] fsverity: RCU-delay the freeing of struct fsverity_info
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 10:13=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> __fsverity_get_info() calls rhashtable_lookup_fast(), which just uses
> rcu_read_lock() and doesn't directly synchronize with
> fsverity_remove_info().
>
> For the same inode this isn't a problem: its fsverity_info is removed
> only at inode eviction time or upon failure to enable verity, when the
> inode no longer needs its fsverity_info and it will no longer be
> accessed via that inode.
>
> However, this is broken and can cause a use-after-free for concurrent
> __fsverity_get_info() for *different* inodes.  Those rely on following
> fsverity_info::rhash_head in the rhashtable under rcu_read_lock() only.
> They also use fsverity_info::inode to do the key comparison.
>
> Fix this by RCU-delaying the freeing of 'struct fsverity_info' after
> it's been removed from the rhashtable.
>
> Fixes: f77f281b6118 ("fsverity: use a hashtable to find the fsverity_info=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/verity/fsverity_private.h | 15 ++++++++++++++-
>  fs/verity/open.c             | 13 ++++++++++++-
>  2 files changed, 26 insertions(+), 2 deletions(-)

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
