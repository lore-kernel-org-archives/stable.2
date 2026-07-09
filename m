Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE05D3E6DF4
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584164; cv=none; b=aFYErn5HqHbV8S/P1GXp6xJMaXqCAkdQfWYsLj5Uf8M6c29Hsy06ZRdiNfT13BHwAg9S5Q0hywCLzSyXHWI1XMOeAnmioz2GhA5N3Y7m6UkglNKwzJ0mY3vx2X1BYb6D+40LmuCC1JDy9A065MAO6eqSqj27uLNnyP403AL0sNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584164; c=relaxed/simple;
	bh=40uSKZxzTsP/abeQJAQ2ZfI2elUt9yomdEcYr6QRnGw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW3ZOlB5wNlRfxndEIUcWkqN4zAr1VgcdWT9TxbcOd7uK+nrGpwjMqcvWf7/81LlU2MoSe9S575pDhvKj7XxgRWBFm3M8wQgybx09Lgq+nC1aEGl71px8zKFT9CiUA667WNR/mArLFayfOl7LF3TSNYeyQ6ny8K8qy5xFgCTP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zdg8l+IB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zdg8l+IB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DB91F000E9
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 08:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783584163;
	bh=40uSKZxzTsP/abeQJAQ2ZfI2elUt9yomdEcYr6QRnGw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Zdg8l+IBbL6jySI1wdH2gjYLk/ruZhiixoPZf8KkB0Q9C9uyVifVjNthO/EhvbbDF
	 V/6nb9Kqljb1CoGmKV8Zm851+wPUewwvtHO6yCus4l88vBeFw3Lpm7cpd/pksT/dEv
	 sgWVC+DdsWFPeRbakct/1WIiBf1Fa1QSRr7sb9O/k7pyXLMX/jsJHYIGWlO7hDuOGN
	 etLfWJUx7UcEL9CraxIVJtJqUhRzDaFEwV9t3VvFD0BvGan4tVh3LT6m9uP2uYgRwH
	 MD8EafYsvIIzpv6MPU0V4IKjqugqk3gNRL/d2y1evfzUuusLOYbNe2dvSz9cxXCC34
	 TYsTJWzUGRk+g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c7050a48fso5327781fa.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 01:02:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro/L4dnc8eW2A1n5rGZ/mpsTEKRpoDwWNx29F/wFhOInagzoJjLXVbMyObPRMQ/lxXFBQGhE3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpoy81OyUE52K8L20tMmDdi+nmLd8nDx1B0+bAI/MMILpGe6cc
	hQFIyOTTdVdoh7kFjYYy3uI8434ZmGaOW16sXtOExwRHZ5ZngZvOjMmuQfhcUFJHCIqV7rb0fP9
	GPL3HfyMTCJK3fukWUY5vL94TTFshrkhdDeCuLiPtQQ==
X-Received: by 2002:a05:6512:1417:b0:5ae:b861:ac27 with SMTP id
 2adb3069b0e04-5b01147ae74mr1441708e87.18.1783584160896; Thu, 09 Jul 2026
 01:02:40 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 04:02:39 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 04:02:39 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260709045116.2304246-1-mark.tomlinson@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709045116.2304246-1-mark.tomlinson@alliedtelesis.co.nz>
Date: Thu, 9 Jul 2026 04:02:39 -0400
X-Gmail-Original-Message-ID: <CAMRc=MewrdyKNGrFSjJksphdA9_2sNb8cZk39Doionfoj_nS+w@mail.gmail.com>
X-Gm-Features: AVVi8CeNk0PxdnG2tC1ocjzjgysi2rL_eYaPnfyOmR1fxSCOy93U7-hk8Cm0LQE
Message-ID: <CAMRc=MewrdyKNGrFSjJksphdA9_2sNb8cZk39Doionfoj_nS+w@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock
To: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, brgl@kernel.org, ian.ray@gehealthcare.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jul 2026 06:51:16 +0200, Mark Tomlinson
<mark.tomlinson@alliedtelesis.co.nz> said:
> Locking is disabled in the regmap config as this driver uses its own
> lock. This means that all calls to regmap functions (read or write) must
> hold the i2c_lock. The function pca953x_irq_bus_sync_unlock() did not do
> this, and it was therefore possible that multiple threads could cause an
> incorrect register to be read/written.
>
> A previous patch partly fixed this, but only protected the write to the
> interrupt mask register, and not the read from the direction register.
>
> Fixes: bfc6444b57dc ("gpio: pca953x: fix pca953x_irq_bus_sync_unlock race")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---

Please always include the entire changelog for the series, I don't know what
changed since v1 (no need to resend, just explain here).

Preferably use b4 for managing patch series.

Bart
