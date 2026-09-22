Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259438DC59
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043833; cv=none; b=CJpjG+qNkUyRyQGy7xDYnmsFJVg8TmQ9AyJnmn7YgknOR1K7bBWN5KAvyopsjsRL0Lp5StEaF75ihJDW3qkqQiaKkgIM7UbPHhSkMehxGnagAbVXHDewgS2BwOr/AafcmjfkIx/VNlyV7stNPMFdBV/xlx+QH5faLF7bz+J4ey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043833; c=relaxed/simple;
	bh=7a/Y2u3p2Db7poPTc/p3tjfnA/ugo7700wm9AqcpBYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tL/yijtHZ/ZqSVyRDjnD6joOAL3wNfTpwAkbAsyOkqYA8mLPEMsxei+/T1KUJzaGEsLl/o57T723GmiqGZ3DjGDowRLeHTABr1JYLYEuA63qFWb3E4GgHzmPqxd87GDjHCXpc+ctM9Z011+JVVM0ZwxMjzD/jqYGUhC1LXoLLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1XJcSZe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1XJcSZe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F601F0089B;
	Tue, 22 Sep 2026 02:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790043831;
	bh=NFRDGYqlC7QTdKbYevOBIU3p0MZ8CN8UgKkbQNDYDYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E1XJcSZeUwhkadWTWXLzyQ/9W4bdf2Ftom9Ojj7lPxRtSJks6RPygqvNtmaXaMKGf
	 Jjo93a6ZorfhmdhAhPUSdLNr5HRNfRrJqBwcyWkwv1oVOV/qMbsdydVMQ6yL5QmKh0
	 8KkHBAbIwnYFvt25NpcYp020F9LwTOxOJ2ShGzGDqOazOFoMNiljs+vgnUpor9gkg+
	 j54CKItGiwqnFcH0JWvGkypdlTQNkm06vSDVkKiDuA4kWENmenU7tEmVCLj0FSsLJQ
	 LdUwUJqd59cTMwTOzJ8Q2DEHHn5yTkULJANQ17Ei0D7DcDJE6I4t1ioZKRktF9TE9n
	 CKseYaWRXJXoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [linux-6.1.y] 6.1.189-rc1 build failure: implicit declaration of 'is_core_idle' when CONFIG_NUMA_BALANCING=n
Date: Mon, 21 Sep 2026 22:23:40 -0400
Message-ID: <2026-09-21-daily-reply-0003-re-sched-fair-is-core-idle-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921060758.GA13965@francesco-nb>
References: <20260921060758.GA13965@francesco-nb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>   kernel/sched/fair.c: In function 'update_sd_lb_stats':
>   kernel/sched/fair.c:9912:53: error: implicit declaration of function 'is_core_idle'
>   [-Werror=implicit-function-declaration]
>           env->dst_core_idle = !sched_smt_active() || is_core_idle(env->dst_cpu);

Confirmed, and 6.1 is the only tree that needs a prerequisite here.
is_core_idle() still lives inside the #ifdef CONFIG_NUMA_BALANCING block there,
while update_sd_lb_stats() calls it unconditionally. 6.6 and newer already
carry 8b36d07f1d63 ("sched/fair: Move is_core_idle() out of CONFIG_NUMA") in
their base release, which is why only 6.1 breaks.

I have queued that move ahead of bf6aa722198d ("sched/fair: Reject misfit pulls
onto busy SMT siblings on asym-capacity") for 6.1, in that order.

-- 
Thanks,
Sasha
