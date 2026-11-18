Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961213;
	b=RZStZh9/8EewmBAbdekGQduKRV1Zv9vRTtYWnqR6AD0KwllSlq3q/sNjDO41pFos4Ts1
	 BIPawDrjOBO5YczEaFEYqQjMHVWl1u7ZnIn9UR6tlGGMlRQhREeu2bN4zvgTmx+eTfOr6
	 VDG+InH3z4DQHBIcj6uWMy3do24jomxT/umo/rcrYF2XE7cviJ/O6OfGBdOJEhkwsZl/f
	 6pcvhjeQK078UQJy+WfncLNTs08VQ5q2d3PG/JxQVYpikp3OI1xbhCErn2NpF9m9sOIaT
	 PdzdnFo0fOuftrtOIsO68FVBKKUKXGGKZQDW9uM8rmJ9SJ3XXgjyRU6zFAIsdErVMyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961213;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TvmVX8vSr+bVv958yLRdJe1gco7tiYKjCsERcZnNAd4=;
	b=L8+cyEKltuxBZqIckKiQ1H8baEtD8V89ZP2pMVbOW51vPe9pJ4EMqQJYqufrREOnYiap
	 RsHxhBofTznKup0DRtqgxTZFOwxUtGJTRSXbAQAC1nhZv6ccbFooqh3bWZtbsaTVRqakB
	 0m9MSK4BHOpXUMl1W4OHZMsB69FhcbOLPjW/qPd8e9Uiw6fsm/XsV4ik3r8mgcAhW/0XV
	 /53oyJK5M468YOD4OXTRuO5qX6nk9gmZZklnlqdlDjyzQlPXW4MHc5aI52zaehpZ9YBKr
	 H/zs8Lumr7Gv7tL7WOimEZlB6K1xKvNyj/9VmeYwBjK/0168sVOml9ezlKKq0d/qsbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U5xGvlbE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996D2606A33F;
	Wed, 18 Nov 2026 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U5xGvlbE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915DD1F0089E;
	Wed, 18 Nov 2026 00:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961213;
	bh=TvmVX8vSr+bVv958yLRdJe1gco7tiYKjCsERcZnNAd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U5xGvlbEtbMfAj6hBflVTOBrkUYpTdJleDkSRwmugTIz1/08AYcKuQE2lLkYRn8s4
	 T/AkpoGf1urTaF11oPwpFx2TqEp6ZYc9FwbdqwWLQwD1EOOODUddnrkuADbgeoChmp
	 TaSZjRClVBM/OapvGVcRWyANxSJoVTH5FZAWQOMoOFfK4I9keBSKXRKGYsvwY17kqX
	 v0UZG6+gvC+JAUOUDLpVmWkhmWqW5DBwYNYdV4k+xjYK4QRdr4Mp/QsXDyyxKkRJq1
	 VuoFFeYp3R1mLvQKmxlW1xqSf5fy+JturXAmtp3KvppLhJLz9L544jLoByHjOE++am
	 TSRn72AAzF8JA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>
Subject: Re: Patch "irqchip/sifive-plic: Cache the interrupt enable state" has been added to the 6.18-stable tree
Date: Tue, 17 Nov 2026 19:19:58 -0500
Message-ID: <2026-11-17-1-daily-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABe3_aGGSWW2LrPHNtAU8Lc2NqgeOQJrZNma2WzQ-JH+vFyWJg@mail.gmail.com>
References: <CABe3_aGGSWW2LrPHNtAU8Lc2NqgeOQJrZNma2WzQ-JH+vFyWJg@mail.gmail.com>
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

> This patch makes substantial changes to the driver and how it
> processes interrupts. I am not sure it is a great candidate for
> stable.

Agreed. I dropped it, and the BIT() fix that needed it, from the 6.18, 6.12,
6.6 and 6.1 queues. The same applies to your notices for the other three trees.

Could you send git-am-able BIT()-only backports of 0f214e5bbee5
("irqchip/sifive-plic: Avoid signed shift in interrupt enable mask"), one per
tree ([PATCH 6.18.y] through [PATCH 6.1.y])? I'll queue them. 7.3 already has
the cache patch in its base release, so it keeps the original fix.

-- 
Thanks,
Sasha
