Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C5931352B
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692773; cv=none; b=Tt2nl43ezosFQuWeQ5b8YhQC3rptuw16rdjP3JYbuT1biqDSS+Lfln09J++WHiWliuEc1YO+9EYRCsLChf/p4QY+/2Kk4diAqyCait/OcGzUp+e5Am8t0cdhcUTX7zRLIiuTslBEam3UefZy1sBs++wRyqW/aLiZElh5Gy4Mt+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692773; c=relaxed/simple;
	bh=8Brw7dt5RP+YdWPIVEEAPNd7Pb/EfTLikqUxGtKL5qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEEM96ZNbyavMRvonw2DnpISSTgJW6CAKIR61scCBjbp/vO4L/yL1bvpPYEA5AqzehvxwkcbDPLEgM7h+kX4GYzDRj+k+XvcFHSpU1nOhS4clSsKCD9CdAjiG0sQUdN6ScC6RKYEvu67ZfJxzu2ps6KJ+aMXIxCrJ7u8/3t1UDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfeLe6go; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfeLe6go"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712D61F0089A;
	Fri, 18 Sep 2026 00:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789692772;
	bh=zUZZi606eJC1TrPQgWADLzGEdbl/IxqE78pG2bo6NF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YfeLe6gomgT/wu17dq3fuvYzk60IICG85kIeis8g6WhpFUmYMpIQzLAAhJ7tbO+br
	 RO/s008zW2jMwuR7WayIbXkZQzODr7PTktg8EJUcCd31TbNnFH3q37Zp6e8opWT2Eb
	 ZpjxOT11mcNeUx7t9mc/JuIzcuj08r/dNcUbuq3nfZ1quYf+X9JmfUhSt1EiHqCnqh
	 f+ejF6Y/vi+8aq1HAbc6UI/E9whWD/j94mBKFar/PtyNgobV9nv6d35Te1DRi6vglF
	 AIOxCSPyD+HMZoSNzN/2bPK60ZHwrROVZSgzuePBkB3KKJg/BLC1vomoUSBP7L49sp
	 iSMyVGqaUp1iA==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] stable-rc/linux-6.1.y: (build)implicit declaration of function 'is_core_idle' [-Werror=implicit-f...
Date: Thu, 17 Sep 2026 20:52:30 -0400
Message-ID: <2026-09-17-daily-reply-0003-kernelci-6-1-is-core-idle@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178964994370.141985.11043353739859044931@kernelci.org>
References: <178964994370.141985.11043353739859044931@kernelci.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> kernel/sched/fair.c:9912:53: error: implicit declaration of function 'is_core_idle' [-Werror=implicit-function-declaration]
>  9912 |         env->dst_core_idle = !sched_smt_active() || is_core_idle(env->dst_cpu);

This comes from the 6.1 backport of bf6aa722198d ("sched/fair: Reject
misfit pulls onto busy SMT siblings on asym-capacity"). On 6.1
is_core_idle() is defined inside the CONFIG_NUMA_BALANCING block, while
update_sd_lb_stats() sits outside it, so the new call does not compile
with NUMA balancing off.

The backport is dropped from 6.1. 6.6 and newer keep the fix, where
is_core_idle() is not inside that block.

-- 
Thanks,
Sasha
