Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E456FC0A;
	Sat, 19 Sep 2026 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789825635; cv=none; b=TWv/xIscVbIrs6Ho406ImFznm4XEU6aDIlJxjNj2FgfNjFao8zytuOGlebhNclvbkpQ30p5PtHAfmtutp61oLywtUcFtyz1qlngrNX+YyKO8Jihd3cwfCrP3HCkeoLH5ny3R/VkLUcpSEuy4qoVu2D3hfM+ofHuHKKZ418GHv7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789825635; c=relaxed/simple;
	bh=xAWI9fDuDWHwsPmh6iozYGQIrl2tv6kVhm8MDSlSMJU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type; b=gOFht5fyZWr7lfh1I8tG6Dc8mG01c5lZg/IRu68NyP14NCat+iEH2oW6YMUILW02FansCCiDeUFxLaK1cs8hu6AeIEYhWvuGWrd4os+uKvYjf3yR/LBiAdonBRjPJr6/xzwpGCAVXYdxq1+2lfOS40uN7FvDmdlajRPCqS5oLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Cqs8Pgom; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Cqs8Pgom"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:Message-ID:From:To:Subject:Content-Type; bh=TE
	05brO3+mRvg1UpYtE6pGvbi0SO6bTrSByqbleHAes=; b=Cqs8PgomEtVf7g989J
	bsmJxYYRadJGaORdnK86uR3t5QNfr3RhaMqRjXYOHce9IteF4WqYXSpqWl7PfPVr
	0l+O49/coAQQLiWzJZOZEvvoxWxtZje5sOeWuFIVYfyLD9ODZQSZtjs7i9S5vdjh
	rCXqt6oSfSSqXyyEevFXjlL7U=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAXqIjlka5qcmZkBg--.12499S2;
	Sat, 19 Sep 2026 21:45:10 +0800 (CST)
Date: Sat, 19 Sep 2026 22:45:09 +0900
Message-ID: <6dbd08d0d0ca288b77dfc7c393898d86.sh_def@163.com>
From: Hui Su <sh_def@163.com>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: mingo@redhat.com,
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
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] sched/deadline: Fix DL server divide-by-zero for inactive CPUs
In-Reply-To: <c52c9e8c-260e-49a4-a88e-229e0795d07b@linux.ibm.com>
References: <20260812123252.2355986-3-sh_def@163.com>
	<c52c9e8c-260e-49a4-a88e-229e0795d07b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXqIjlka5qcmZkBg--.12499S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1UAFyrJw1DtrWfCFyDJrb_yoW8JFyxpF
	W5K3W5Gr4DAry0vw1IyF4DJw109rsIy347Jws5JrWjk3W5A3yIgFyruwn8uFWUGws5WF4a
	yrs09wsxuF4qkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi6nQrUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6QbjQ2qukeYjgwAA3c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

> As for the patch, the same division is unguarded in several other callers
> in deadline.c:
>
>   task_non_contending()     (this trace)
>   inactive_task_timer()
>   set_cpus_allowed_dl()
>   sched_dl_overflow()
>   dl_bw_manage()
>
> Would it make sense to guard inside __dl_sub() and __dl_add() instead?

Hi Mikhail,

Thanks for the report and suggestion.

I agree that handling cpus == 0 in __dl_sub() and __dl_add() is the better
fix. I audited the other callers and reworked the fix in that direction.

I'm planning to post v2 as a two-patch series. The first patch handles
cpus == 0 in the common __dl_sub() and __dl_add() helpers, covering the
other DL bandwidth paths as well as the sched_setscheduler() failure you
reported. The second patch keeps the cpu_active() check for the newer
debugfs DL server interface.

I'm splitting them because the helper issue predates the DL server debugfs
interface, so keeping the generic fix separate also makes the review and
stable backport scope clearer.

I also added targeted tests for the task_non_contending() and
inactive_task_timer() zero-CPU paths, as well as cpus=0/1/2/4 accounting,
root-domain rebuild stress, and the set_cpus_allowed_dl() bandwidth-move
path. All passed on x86_64.

I'll post v2 shortly.

Thanks,
Hui

