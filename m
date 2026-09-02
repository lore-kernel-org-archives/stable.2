Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC524A3D53;
	Wed,  2 Sep 2026 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360492; cv=none; b=oHh2LFoT76FFdgRwV0sQm9b53/Equ9IyJ9Q8O9iZ+ymd3PAJl0G3r708bTaswl1lXQqniew5iqu8cqNJdaaDSYMAAgpvlAaD2kHCBuJmZ1U5+uSdWw96e13qjsBUVrtWeW64dinIQRcSqNwFmAbsu9mv95k9o/5nYtA9Pt8fBAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360492; c=relaxed/simple;
	bh=7ThaHv7JV1srdybjwPxZ51zO83IVbd77PsE9/jExvWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7f/JOtLvJGaGyccsY+Aoke3U9cRPmtY7o/XF0Yyvyqpb8sxM41grI90sG/sd+5OfHDciT5iKbKY9xWYN+YiEiXJXw8PwUBFANDyL7L0JjQkj4yuzN9+fjT+FFEZJ6jhKfoe6tSBs1+aR8H6QEHqnMW+UMGXJCPs727NU4/gRzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyikNhCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyikNhCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A321F000E9;
	Wed,  2 Sep 2026 14:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788360491;
	bh=kUXYVCmWjiQeTz/NFKBu4Y1w5fCojC14Ox7jlQ0n8OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AyikNhCwZna5smqbj0GVWcCnGjutXLJmM9MvlPkDkDB9JJo/kn3io4tTvDe5tXMxW
	 ZUJjlFamPUPfGq2Lmn76ybrIYQPDL4mzZUKVZjfcXGiJEJbIuTGjxD4BsugydnjM82
	 SYjbRfQXN+jByOKT3dN4kPhNrpx16KMLuEcCraBX3USkGOdvW9ZjV4wMzsktiY4DnE
	 AzKko6VpADJ/YxX9/Lt+miy8YUFTjr9S/9QiCfYgStVLF53EtKXZC5nqHQKwklqp4g
	 bDrDAPVc3LDJhQFcLdo/P3TnXopCbzVm1mlLKaifWc/rSGrOrBVgIjA9vyUz324zx3
	 XvksGDML0s4Wg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Wed,  2 Sep 2026 07:48:03 -0700
Message-ID: <20260902144804.88298-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902142254.5328-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Sep 2026 22:22:31 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Wed, 02 Sep 2026 07:10:00 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Wed,  2 Sep 2026 16:44:45 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > When setting goal_tuner to 'temporal', if the goal is achieved,
> > > quota->esz_bp will be set to zero.  In this case, damos_quota_is_full()
> > > will always return true, even if no regions have been tried to apply at
> > > all.  This causes qt_exceeds to increase unexpectedly.
> > 
> > To me, this looks logically correct.  Could this cause any user issue?
> 
> Yes, I think this might cause unnecessary confusion for users,

If it is _might_ kind thing, please ask questions first, or add RFC tag at
least.

> at least
> it did for me.

If it confused you, definitely we need to fix it.  But if it is just confusing,
let's try to clarify by adding documentation, rather than changing existing
behaviors.

I feel like we also found similar case that people send patches to change some
behaviors that confusing them, but not really problematic.  That sometimes
waste unnecessary time for understanding the intention of the patch.  Please
feel free to ask question first, if you found some confusing behaviors and
don't know why it behaves in the way or if it is a real problem.


Thanks,
SJ

[...]
