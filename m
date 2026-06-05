Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730F390614
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681116; cv=none; b=cmdwN4lEOZG1KO68rKkOZFtj/SoMjPyPPF8g+kuimiYSCqTlzO1H6CLItFRPwcF28/bLorWYdBZqhbTQxhqsVuswlK1i47fDLdlJB8kBOFKvA8A2AhRMIepiz8dqwOoAKQmyJrZzC6Us04KuQXIUKVVE0/3lcUDAQhRPyfrLsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681116; c=relaxed/simple;
	bh=K7CQM4eliJj4wIiUfHWlYLWJDGHIdJ3cNCElgLyQKQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3v83d3H2O7gggHq5EyUeDvaWIaNcJyzxC+jM9BQYgKLsF1rbQWaztGaK7NIToPuKHx0kNcXZL4GKYon1HDh9kBEsQxtluihTLtcICRVJnQlV0SYlz8cPAZLDNZCKQrqTywbTWyCrUOxVD94rrYkbixjgF7+H9dpw1+xixeVMAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhwjXUXO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhwjXUXO"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa7a7c9711so2681213e87.0
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780681112; x=1781285912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01P7q67TBv+LoXRCSByZDo7vD+dZYPFTd1o6tohYeZs=;
        b=QhwjXUXObt3n4VRZgvPjX0m04fq0YZuCzO/bdP+iaDRKKzcY1+5RelfQJqdTEbBo18
         kxLBg26M7nZdhHjudbD2hRdIRDcM4TkCnv2C7HwfI0NTndgqEpmi9HjAt3siWAYdb9f6
         68Bei5Smb30hVitLrA0rbx+DIPNam5cFDai9dHCX4r00ruy9Tn6nigpORyGSqBZi+KKu
         7KLAh3a6fs9BKbadLZw4j/xt7kGY4uBzeAlhgQC7qN1fnWxouJDH9ZqR3/F+NVVAjz7A
         j+HbgwZihOn9bDK0QLEiyqfZ09cinNLLMznHeef4GBq4MTbdckavTdrHS1kFWqMr5ArJ
         cBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681112; x=1781285912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01P7q67TBv+LoXRCSByZDo7vD+dZYPFTd1o6tohYeZs=;
        b=p4TeczjrZ6A4on6Di7t04GVXiUAIjAuAqIW88nVXh3Kwe5NjOWDUTnaDm35IWyY7p0
         ZIvDZAhSPgjNhGFCaLwP3wL7hz1tswIWc6lad/EcnZsQhfBZHFe/CJi4BNUrjeE07ILc
         tGE5cuDQOdZlYCIQm0GzYfhd+qDnosfeU5ejPFR5dns6cTWXNZOTqSFvaqhPTpGicWfv
         mychnU1D8b4Hlc+Bf90lr19KBHoD/ACZ3lx7fYo5rbqQlKXTK7VdrbifwRGCBXOQdD2B
         Qgjo32FnzSWJ6LEbNpBMvjLOq0nYeO8waUHm+svu8lqpdVscJny+ksoyCUSNF+6xZKQS
         C9aw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZK5frLjgDHO8Fzg9CrPv1jtQTyzcLcXmJnE0Qf/2Kyns0GTlCUBZyA94OzEdsK2UtBN33lVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIocHwYxF75ifP9qRjmWBK2UIDQmO/KOLTFJ26wadLdTy6i0wX
	CvsoWgBEB6oo9B2K6zA1+tPfNMnihYvYnuNHYtGSeQkAwBR+DWmtdTxc
X-Gm-Gg: Acq92OEYsILokTSocWWjMEPmGfXKJdm9FYRX2eiORYnVdFWY9hx4mwZ1LVhyMSn+B7a
	/fOy3wCTii6AIKrqGn8xa9M1D6HFSYB3L24Cawh1Cl4iWxrllhQLMF7iWi8k/0G/34GofcdesNx
	r57P3oyF0ghRx2QBkanuUf7qWiKc6uaEFXEBZL0zVp2eqXWYl7YbPWGJkLGgZr1YGFgZ6IB0r9l
	znY7vEmANZDJJBRKQ/D48gi+1d8EypXVeWdm/IiD33q9fumUnwTRq2Fk1ZfcSP8TNIfPI1zKhkT
	Y8nxvC4c4e5JbH0Xwc3x54aYfAh9KSAznkyQehKfgeo0qU8XLBhjTsIp4OZ1mHi1JqNpSH6wKv5
	LdPP6A9FZKvE9Mv9t82trJyXYiyaDP0AuSiEQ4K1Brr/Ntarv/zCXfGXLw2dqkJPeYDq4o7N9UQ
	Va3GFEhoeEMaeIxu1yHh+s+JCKAbyofJsAGC1ZLH7OuyDFNW1yxh5kTkJdR1cFLHOFpBJI
X-Received: by 2002:a05:6512:230f:b0:5aa:5edf:3311 with SMTP id 2adb3069b0e04-5aa886aa0bdmr966294e87.12.1780681112036;
        Fri, 05 Jun 2026 10:38:32 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97ac34sm1973861e87.39.2026.06.05.10.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:38:31 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Haggai Eran <haggaie@mellanox.com>,
	lvc-project@linuxtesting.org,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Doug Ledford <dledford@redhat.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
Subject: Re: [lvc-project] [PATCH v2 5.10/5.15] RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"
Date: Fri,  5 Jun 2026 20:37:21 +0300
Message-ID: <20260605175333.5.10-5.15-v3-reply-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603174551-bf141bed5d94d0d92337aae2-pchelkin@ispras>
References: <20260603121902.274-1-vlad102nikolaev@gmail.com> <20260603174551-bf141bed5d94d0d92337aae2-pchelkin@ispras>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, 3 Jun 2026 at 18:03:00 +0300, Fedor Pchelkin wrote:
> Moving it a couple of lines around requires some explanation why it's
> okay in 5.10/5.15 kernels.  Note that in upstream it was done by another
> commit 960ebe97e523 ("RDMA/rxe: Remove __rxe_do_task()").
>
> [ yeah, it should be safe to move the call but it'd better be stated
>   explicitly in the backporter's comment ]
>
> Worth saying that checkpatch.pl for the current patch gives:
>
> ERROR: trailing whitespace
> #52: FILE: drivers/infiniband/sw/rxe/rxe_qp.c:771:
> +^I$
>
> You might also want to consider porting 1c7eec4d5f3b ("RDMA/rxe: Fix
> "trying to register non-static key in rxe_qp_do_cleanup" bug") which fixes
> the similar problem for del_timer_sync / timer_delete_sync calls in this
> code.  This all could go as a series now probably.

Thanks for the review.

I have prepared v3 as a 5.10/5.15 series and addressed all three points:

1. extended the backporter's comment to explain why moving
   rxe_cleanup_task(&qp->resp.task) after the RC timer cleanup is safe
   for 5.10/5.15 even though upstream got that order via 960ebe97e523;
2. fixed the trailing whitespace;
3. added the backport of 1c7eec4d5f3b as the second patch in the series.

The updated series is available here:

https://lore.kernel.org/all/20260605171449.1760-1-vlad102nikolaev@gmail.com/
