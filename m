Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2FE23ED6A;
	Sun, 11 Oct 2026 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738720; cv=none; b=Kf/icvwUckW/UDqBL4U5dsYjbxCiKfJVT8Vpqcm8hOAzSkeA6nuR+D59Hb+32I4HYCLnOCMKIHimR1l39ix04ZzhXBkgnwAE3quwqJVLdLSL2X3wKqazSO9iI4Z00xt/2rOehg/cvxjStdb4XN100fYnh8acvmUrIiDp9tEifd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738720; c=relaxed/simple;
	bh=oyDBxZS+LvhyzScug2ls846IS3pqP/GArQEKPFYIf4Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITM5KR8JrxVB01atU0a/78EtmtxErfZReY818W9fyl+pUGV2qdizbd7CyvIvQcRgyuOArlGGg78BB3Sg0ZW9YnrGG91favmxNp9Ps0WTeHqERVz2TC+V22dFXfCMuqvi9AwY4BYU61RZou6AbyeXXatQKdvc0i2gvpQmVPU/UUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ji9ME9+v; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ji9ME9+v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:Message-ID:From:To:Subject:MIME-Version:
	Content-Type; bh=oyDBxZS+LvhyzScug2ls846IS3pqP/GArQEKPFYIf4Y=;
	b=ji9ME9+vgAj1xa2qc/GVU/ooFBwr4JYgdnIlzr5Ch+eEJxFWQ8NNjm0UWvnbEt
	qjwPfVxkfmJB+66P57qiMoudSNAyEzBVn4UUPb6t27wvwrtmN+8ToR4QtKp5mVQV
	pN9QnRteyMMZJvPU/kEGhaZusPoNCowXThY+rqHd/AUG0=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3L77awstqK5YCEA--.1926S2;
	Mon, 12 Oct 2026 01:09:48 +0800 (CST)
Date: Mon, 12 Oct 2026 02:09:46 +0900
Message-ID: <d4c69652718677b25a157eef31552bad@163.com>
From: Hui Su <sh_def@163.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org,
	void@manifault.com,
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
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: idle: Respect task affinity in restricted CPU selection
In-Reply-To: <asufkdwCQvilJEqr@gpd4>
References: <20261011025256.4180374-1-sh_def@163.com>
	<ass0dexwariQCOtC@gpd4>
	<20261011131700.1351541-1-sh_def@163.com>
	<asufkdwCQvilJEqr@gpd4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3L77awstqK5YCEA--.1926S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4rCry8Jr1UGF4UAr45trb_yoWxuFgE93
	sFg3sxXw10yFs3uFs7CF109FWUZFZF9Fy5u3yjgF93u34kGFZ8Wr4kJF1F9a4Fk3yrAr45
	Jrs5Ja4fCFn09jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1qg4PUUUUU==
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwhx11GrLwtz1LAAA3Z

Hi Andrea,

> Sorry, I suggested this, but I just realized that we break
> SCX_PICK_IDLE_IN_NODE if we do this. What if we factor the check with
> an helper?

Good catch. You're right that deriving the candidate from task state also
needs to preserve the SCX_PICK_IDLE_IN_NODE constraint.

I'll factor the restricted path into a helper along the lines you
suggested, with the candidate derived from task state first, followed by
the task-affinity, caller-mask, and node checks before consuming the idle
bit.

I'll also add focused validation for the cross-node case and send a v3.

I'll keep SCX_PICK_IDLE_CORE handling as a separate follow-up rather than
mixing it into this fix.

Thanks,
Hui

