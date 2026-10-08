Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6BC369D71;
	Thu,  8 Oct 2026 03:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431784; cv=none; b=Nrxwtf0ICscyR0tjnKrLBHQveakHBQZ4KV21dTasv5EtlSxhqfHiz1cPgoI4GJzO3N4S2x55iDK1Cwhp58F7EAv+55yYNaBawLRhVzaYYK+NekB35mfEazutDX/pxOh7MmW0JCXDSTZ7BWiwT23mCERC5HeNdqwnpb+avVcEuNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431784; c=relaxed/simple;
	bh=3uY3LF59sQ0FPvnkPdI0ps87lsfnomv1fTVpGw8r628=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References; b=a2+Xi37DHN1DhKqFIPsK0dTnCTAuKdvXlQ2B1cV4hS7QKXFLzu7vdd5XPXjcmENqt9s0wER2rJl76ZpB4NolndGcumey0jkc5xjBYNYT+Pt6B+TZcJiCyKVjIIOyJypbbwus2ByozzjPqmkxP8Nk25FWQtBfRDSmWPgRkLJynGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TbG+kg4o; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TbG+kg4o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:From:To:Subject:Date; bh=3uY3LF59sQ0FPvn
	kPdI0ps87lsfnomv1fTVpGw8r628=; b=TbG+kg4oAr4l4Po11aV/BQp88w+kmRt
	XiZrRLHoJOx0e1rbkUG8j+R+kUSXfSuCSkzeppHdTFrKLTY3EDTVMlZAwq5HOeMW
	jACdDUcGfXMPVgqlGyocnYKLqMrilhzqPR1iL4EcZwjjush0EPjCsRAkr65FwMGj
	znxQzjS5haVw=
Received: from localhost (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDntRbzE8dq_0uECw--.42544S2;
	Thu, 08 Oct 2026 11:54:28 +0800 (CST)
Message-ID: <c672e085a5334a02709a891d447ab857.sh_def@163.com>
From: Hui Su <sh_def@163.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Hold DSQ refs for deferred reenqueues
Date: Thu, 08 Oct 2026 12:41:18 +0900
In-Reply-To: <ar1DqN6Ek2VwYLwO@slm.duckdns.org>
References: <20260930143443.2862150-1-sh_def@163.com>
	<68e1d1e0cdfc633520a6593fdcdb3b72.sh_def@163.com>
	<ar1DqN6Ek2VwYLwO@slm.duckdns.org>
X-CM-TRANSID:PCgvCgDntRbzE8dq_0uECw--.42544S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWDCFWDZrWkXF45CFWfXwb_yoWfZrc_Wr
	WDtr97K3s5Kr4ktr15KF4I9asxKay3WFyUJFWrGry3tr95J3909an3Crn3urykJ3y0qrnI
	krn0yryIgw4a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1qg4PUUUUU==
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6RSO7WrHE-RPxgAA3d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Hi Tejun,

On Wed, Sep 30, 2026 at 07:15:20AM -1000, Tejun Heo wrote:
> Can you try to do it without refcnts? DSQ destructions are rare events and
> we can reliably detect whether the DSQ is full or not. I'd much rather make
> the destruction path expensive than adding refcnt to hot paths.

Thanks. v3 follows this direction and adds no refcounting to the deferred
reenqueue path. After the initial grace period, the destruction callback
sweeps the per-CPU deferred lists under the rq lock followed by
deferred_reenq_lock, then checks the DSQ list under its lock. If the list is
still non-empty, it retries the callback, which also covers the case where
an active reenq_user() cursor remains; otherwise it proceeds with final
reclamation.

This keeps the additional synchronization on the rare DSQ destruction path.

v3:
https://lore.kernel.org/lkml/20261008024753.4096008-1-sh_def@163.com/

Thanks,
Hui

