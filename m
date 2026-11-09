Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228969;
	b=IOGef/rCxOMJb0Fr45NFgMaOrLYIMuVToieq+QbRZ1K0nmsVaVRuQJH2dD0WiJ2IJ6O3
	 Zuy/yIaTptX7B0jbguwQqYwMYQEyXWNACQk6ULaOqZ+F0UhBwINUU9DThAkx1FUrs4icd
	 8XdO98EW0m40Xiagb76ZrMaz9Am+1wKbydhT6KGUCnaGKvG8s8UWQQ48g8cZ+hEG0HYz/
	 ZwoD3aPchkqq0ZoeBRhQsyPnn4D+KAZunw4ZBxQNoTZmm3x/HEm/Y85qUpDAEvJ0epPOf
	 CH62KmYvzVLi4tuYRlCGqk9Lh2ptRXOZYW46IfyfhQ/++gz04YAXt+XTg8LYU0diblw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228969;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=RlHXEngYq18Jj8tFRRJ8jj4MrDZLmQ3Qo9NJGm/ux7k=;
	b=C3ttJHk6w1DzKDFQDO/azbExBYUhoGGF9CMKeEcUev1QnJWPjAre76hOLDbWLbzWYRIK
	 sEK+9TY2ZUyJXsULFgKIM1QJ1Uj05aRXkoiExApFvFjeSLaAP6w8s8Adeam8GISYc8C0d
	 V9P/jGlDrq//qqAHQItCO7g9hvDsBUNeJb31Edg+x15IHplYmqAI8iY1QGtpDYWbaaxAd
	 hVomkrVn1DqauxZMQu1bfzuQ6OpNnZ1Q4znOy9SmaTOdl8OAwOmCmwukpoDlkdeG/q5NO
	 9D0hXXfY8VIcTnGVcEGuGoAe1iLbUuxyTsC3rnnfUeHtD/QGrNqabOapyk0R6w1o+nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwEcwZeS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6778606A322;
	Mon,  9 Nov 2026 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwEcwZeS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1481F0089F;
	Mon,  9 Nov 2026 12:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228968;
	bh=RlHXEngYq18Jj8tFRRJ8jj4MrDZLmQ3Qo9NJGm/ux7k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZwEcwZeSanDenPa0eeRoFDyCiLtGCr2CMJ5FgJf5XZdSbIB0N8JBOb9RV7uCoDe1g
	 eqjAIdB2AoI1r84cuzlN+g0R+zafTQJzGQVMEiJyeMDWSGMw0cPlXQKn1bSmLEV/2y
	 QSEJ92Drya8zv0iK7yfGnYk9PFYUvsvv+A30rzX5Ffmcibck0nlEnj91yoBQR4C4+h
	 8pILX51p0G0GbivHQT0O/bd3QrH8Md1XutNjypqw0DiWLS8NODfHcgjjy78bdADmVC
	 UC+3gEv6E0ZJL5ZRsVG7mYCPdCFb6cCvOLfpa+byHIjPklVa7FXilFtfbTHD3zZ7Xb
	 9GQ9mc5d8rcdA==
From: David Hildenbrand <david@kernel.org>
To: akpm@linux-foundation.org, david@kernel.org, shao.mingyin@zte.com.cn
Cc: linux-mm@kvack.org, ziy@nvidia.com, matthew.brost@intel.com, 
 joshua.hahnjy@gmail.com, byungchul@sk.com, gourry@gourry.net, 
 ying.huang@linux.alibaba.com, apopple@nvidia.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261108142831046W_fbNCAFfuY0BjHPCCHgi@zte.com.cn>
References: <20261108142831046W_fbNCAFfuY0BjHPCCHgi@zte.com.cn>
Subject: Re: [PATCH v2] mm/migrate: fix softlockup in do_pages_move() with
 huge page arrays
Message-Id: <179422896536.6396.2331659018342056694.b4-ty@b4>
Date: Mon, 09 Nov 2026 13:56:05 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Sun, 08 Nov 2026 14:28:31 +0800, shao.mingyin@zte.com.cn wrote:
> mm/migrate: fix softlockup in do_pages_move() with huge page arrays
> 
> do_pages_move() walks the array one page at a time.  An entry naming the
> node its page is already on is never queued, so the loop runs without a
> voluntary preemption point on a non-preemptible kernel; the existing
> cond_resched() calls in the migration code are only reached after a
> folio has been queued.  nr_pages comes straight from the syscall.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: migrate-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/migrate: fix softlockup in do_pages_move() with huge page arrays
      https://git.kernel.org/mm/core/c/e200153a

-- 
Cheers,

David

