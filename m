Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464862;
	b=vo9+0Nmr+Q3Szxl2iONgu4gVzhedNclqONsksujAw2pag214yFH3eVHeYwthW4jw9Gq1
	 PgnNMq1fjB6pudWZYz16O97rnR13nQynJwlJeBpH83p8yRHAF3RTNynimzkxZzJi2WHn0
	 lA3D2wm0g1vT3FQmLHCf5VTvEMPNWEZpYu9rDM1XWSQ5rWa6Ew+iAdRyqZlvBzXITl6Ep
	 KYHGbdDlPTNf+J2DyzITN19tAToESLDKDW4bn/cgBkDphvSUv1QlywyT/8564Jn/o7nvS
	 ICjCG4zdOJQiF7OqEBKFrOJtFXflWFZaJQP9JO8dtAI6TKz3jHry9CHKH6CS/zkzeDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=cPrfk6ONyb8N7CKSwNcuu5XHZjwnL6CQE/ckKsJyYbw=;
	b=OOLOY1AO+mfuW1p6ZNLB42BopsgJnZ8Y/uiiBL2W4s/4clRdXB0Ru9JRXPqY7bT8xoyA
	 cV9W1xpeWLUtRngvDOwIK+oeFl9BcpBET9Odoi0Mhd4CDKlzx3rftNi6ayL0a3U4gPtLO
	 2hCbLPr1PfZLFJNMoFjsEvECn/wzko9LOW23rARxYhGFDDNG7MjO2JmUjy8ZoPlBT4xpH
	 CIm7lRk2fqkNOUeYXWJCMbB5DwTd0MQkL6BcxPPRkMr9vXDLUiochApZkkGGIcZdxCAxa
	 oofNMWpkRN0p38uY3SZY7+W45HR1NJ6T7q5kAJGx1G1qbwXNxbiSQEuoWnl9YHEMI9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JeV+denR;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD32606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDD32606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JeV+denR
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386177b0516so10005511eec.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795464861; x=1796069661; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPrfk6ONyb8N7CKSwNcuu5XHZjwnL6CQE/ckKsJyYbw=;
        b=JeV+denR+5MWRUHToxTFJvsyZ8ujMCOgwKYy+o+jl7EIKxx+bBL5XrDvz6e2cyVCaX
         SnhZkQv3I+Krw5EzRl+89Y3QSLSGt9/ZESoRF+70TEywkQvSGPkogEoeGFNJbaHBiiU9
         FtlOcadUp2OSkcri2qUgsuqT1CKhgn2piOTjpE2THBopgdX5PRvtPdu4SaK3H3irXcXl
         jiZzGqBYvEYe6RlGPMj3GDA7AFZbCrcVl4ZHzmx66PMbzOnqfQUEcOlvvMVQO948Q7DZ
         +IywqbUre79GDnHgQD4B2k+4pOWOeOGSTXEBm6cYk7PbOREmjDH4pNjVVNNGR9h14eRd
         rK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795464861; x=1796069661;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPrfk6ONyb8N7CKSwNcuu5XHZjwnL6CQE/ckKsJyYbw=;
        b=kLHof16O5JZRRfB3sFGzLdQoWkGfMZzx101QP4KLH/1tcYNTtId041MOK0+0z94Y1j
         RQSB/THGdie+I1MYO2xJS8aa+tkcDqQoxVRG+oqLRYeR/rJ1eVI97SwYiSD7VnJK5BNf
         bfM9hJT3PDat2wDFseRHQcfjwEYZn/1h9ln4rvfXSeRZPuxPdXB9m1B1wMdB++tmwYj9
         mJmYC/9fwkgyvQq/pVc4tASlJEXpJ/Vt5C4XQO7+VQs9z67OfRpf1q31qWITkUZAovqm
         HZO5XHycah6+DscjWpg+hq2pxyTKyNikSIBx9uwQZ6ndkLdIp/GYFQOpIBHqWF8ICKly
         wQbg==
X-Forwarded-Encrypted: i=1; AL+hErHNQHlnWGCUmfRrQBQq2GVE9YYs1dgsNRe538kKxXJsaxy4KT6rw6IS1UoA4sCrcLTidfPhAxc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wX3DK6ReeovOu2dR3nXongYpAWP3731hF+uSiK25JP/JbHWYM
	NaVhMprjvgBL9ZDydkOJZKlp0uUC+YJGKk94mmGFgMmvt2iuyOkqZ+C/sZKR5cKzDpc4sbyJx0k
	qZFOP4qkrKqqwvvib6g==
X-Received: from dycai24.prod.google.com ([2002:a05:7300:fb18:b0:385:58ae:e3af])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:87cc:20b0:358:3426:d601 with SMTP id 5a478bee46e88-3856c0d0961mr13564449eec.2.1795464860602;
 Mon, 23 Nov 2026 12:14:20 -0800 (PST)
Date: Mon, 23 Nov 2026 12:14:20 -0800
In-Reply-To: <CAKfTPtD17e-veL1QgrhO6i4nsKyA3QfOEm8jNinJ_zf+vc8RDw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com>
 <CAKfTPtCQpVhtVT7Mhqe1=Ukcmc1pX8Jgn9ypb64--8cJ-7G4BQ@mail.gmail.com>
 <20261123160934.2289260-1-penghuang@google.com> <CAKfTPtD17e-veL1QgrhO6i4nsKyA3QfOEm8jNinJ_zf+vc8RDw@mail.gmail.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261123201420.3970775-1-penghuang@google.com>
Subject: Re: [PATCH] sched/pelt: Skip dormant cfs util_sum under scx_switched_all
From: Peng Huang <penghuang@google.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peng Huang <penghuang@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 18:07, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Yes this seems a better solution but It would be good to reuse
> __update_blocked_fair() which already does the work for pelt signal.
> Regarding your issue with util_avg == 0 whereas we still have a
> util_sum != 0, we can use delta_sum = gcfs_rq->avg.util_sum -
> se->avg.util_sum; in update_tg_cfs_util() instead. When util_avg == 0
> we will be sure to clear util_sum too

Thanks for the suggestions, Vincent!

One small detail in update_tg_cfs_util(): under CONFIG_CFS_BANDWIDTH,
gcfs_rq and its parent cfs_rq can have different period_contrib, so for
non-zero util_avg we still want new_sum = se->avg.util_avg * divider
using the parent cfs_rq's divider. Keeping that calculation while only
skipping the update when gcfs_rq->avg.util_avg != 0 or
se->avg.util_sum == 0 preserves period_contrib alignment and clears
residual _sum whenever util_avg reaches 0 (and similarly in
update_tg_cfs_{runnable,load}()).

I have sent out a 2-patch v2 series implementing this along with reusing
__sched_balance_update_blocked_averages() in scx_enable():
  [PATCH v2 0/2] sched_ext, sched/fair: Drain blocked fair load on scx_switched_all

Thanks,
Peng
