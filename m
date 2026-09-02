Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E800D3C4575
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363775; cv=none; b=YOPgeLADv6T5L0U+geFHKuxjuSt/HFkcDkZ4cLqpStXnOMrYoenWLXiypmlZ+m2/UsejNjXM8xbWT/QiQiBx7CnpslCFlEzv6rMIE5I6zS1D46zwmi3DPYwAmmijDWqD8T2p+DjIddhDstoE2T9mdx6fTeIeAn5+7bgc+JkklPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363775; c=relaxed/simple;
	bh=OgEi9WMqBJ8E4IXMjK5D0CkwwPo/FO/dKn8PbTUpGIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PssKC4pCenxIJ7XzcurEGN3+FVdn2bMv7vt3Ix9nmFWupdxnAGZUyHpqgLEI4WH5eDsiJHmA26a9DycRIVCAWlv9cNIO6ca/+9c9Jy52pypj+cMnOwpJfRqjR2H/KjP0TQiT9ftd8mvVE3XCgfm2WRabABnWH5JO+cs3GAhqPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFZ19I3C; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFZ19I3C"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-495590dde14so12561165e9.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788363772; x=1788968572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tkCOea6tIQttao4Q4gnUxT8VpD52QN8Jk9jItuqC2g0=;
        b=LFZ19I3C78xfyF2ol9I2494U+wuypn0gTyRYdOwQV2e3+JLETyP26qmQgHdIAc/Asp
         enj41cSOuTaORHMtu2dXJNO2VBsab7aE+HoU+uVYxh6wkaWBffVvLCu2mzAS1edeemuG
         swIiQ6rp9WU4eul0Rd7/Usne/cyNoJjbcmd9eK/OK0uz9IgMsc/RxUC7zZu46eoWCel/
         Rsfp+xioXwRzF59kYCfK3K4WHylNPIUHlv9MQn+z/FT4CwwH+w1HGLcZkSDLd48ODkG+
         8ZTj8ithqblRlZQLJnOeStBIZ6+JCsGeKNr+IJrFE9XG6ykr5VsKqwoTDYOlDQ7NGgzx
         aXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363772; x=1788968572;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tkCOea6tIQttao4Q4gnUxT8VpD52QN8Jk9jItuqC2g0=;
        b=jaLxjdPiYR3IPJZCCDHbDB/21a4xNg+Zy3GdtDTEmgx51ZyYJevVwr/Xhho93o177H
         oSBfXy5hQwWYLgu9u2m5QY2LnopIHV2luGh8Qo5i4h7FnfcTBwkrrRsVSWpd0PCwJc5A
         uDvIJfcWou707EnoV4L3NKlT2H7+4b/+pb7O0rWT1y+ij/onQ5Y/hCADL7u2zx4kO3iv
         jpdqINsmoBtIUYSqw0OvH7j4/0NgVP6Fv2DVe3qsWVUl9XVLBvz+pa975Cy9hEmSj03y
         sUrU4ZsgP9hDaOHqrHHgzUQN31+/scmhHNN7rYCOVnvkFOCy0V30JEkzU2Wuj0JtPHpa
         7Fvw==
X-Forwarded-Encrypted: i=1; AHgh+RqD0phbx/1wWXw1bk5wrKicewN6JvtwBvB8ilgcl/hXX/2WuXJvrz4/9QGdFV5dP2Qdv5i/jfg=@vger.kernel.org
X-Gm-Message-State: AFuF++lOfSu+3GXW5X1Wg1lHFhdTQsmDRLWzJePpCEcLDYhNiZpbDIok
	fgvbAmTfjI6hhmqoxXeNaKm8SzQwQuonKcrSAZ+LO0Ct7Y2Ferdc3hgC
X-Gm-Gg: AR+sD10znPQszyBu84JnsnM+5MeCrPZLvTzkoQkUIZmwwdRFhZ+Aq4jtxcAw+vUxoeo
	WmUByiVNLQQp9EHJrGZX42dzVzAridx95DbzgEBBjhoxPQAh8BehdZ82L1ysHLJEpIH9DDC2gCy
	xHFuYXgO+UJx4MX5+MmwRY7j/pnSQhoWtRQCqFUJjkZ0OYfqCBM9Yj5OjIyGfq5EzPy1NoVxNYu
	NXIvYwA27rmaEkWTl3ZqZupOS8WDMTBeNUOW4aB0YLWBCLO7yT+XvhQXlM9TdrgCscJFvGEHmh4
	Lerrp6zwrSTjWVdX0OpbsUn/jPbOakbDEJ4t/xL9um5kG2ySuX+lPUAmTtLoBfBzv6YYT70/uNC
	zeCBhjLXIwuR7l2ST+SNC+nfgiBK1aZbaPuT7URB1CarzPgYK0RJPMcdnXOoYvv3vCnFvb9dQmg
	5XENBAnY649f8ydlTFa6yfpQTBWkp2/sL2X4n0nPWyYmVo3VqiZy0mVgFnHFdwb9Txmfb3uBTTA
	i0TOJ5uJ3zo6RMK1Kyqu05V2g==
X-Received: by 2002:a05:600c:8714:b0:499:b65d:1250 with SMTP id 5b1f17b1804b1-49ce580d869mr109336155e9.2.1788363771670;
        Wed, 02 Sep 2026 08:42:51 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce47b9817sm57993845e9.1.2026.09.02.08.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:42:51 -0700 (PDT)
Date: Wed, 2 Sep 2026 16:42:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Usama Anjum <usama.anjum@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, vladimir.murzin@arm.com,
 ryan.roberts@arm.com, peterz@infradead.org, catalin.marinas@arm.com,
 stable@vger.kernel.org, ruanjinjie@huawei.com, james.morse@arm.com,
 yang@os.amperecomputing.com, cl@gentwo.org, maz@kernel.org,
 david@kernel.org, ljs@kernel.org, will@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v2 00/20] arm64: Preemptible this_cpu_*() operations
Message-ID: <20260902164250.40852ba7@pumpkin>
In-Reply-To: <9789fd67-205a-412f-90d6-42c401d3babe@arm.com>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
	<9789fd67-205a-412f-90d6-42c401d3babe@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 12:55:12 +0100
Usama Anjum <usama.anjum@arm.com> wrote:

> On 04/08/2026 6:04 pm, Mark Rutland wrote:
> > This series reworks arm64's this_cpu_*() operations such that they do
> > not need to disable preemption, avoiding related overhead in the fast
> > paths. Instead, the ops begin/end a "PCPU GPR" critical section using
> > unconditional/posted stores, which should be very cheap on any
> > reasonable micro-architecture. During a critical section, should a
> > (preemptible) exception be taken, the entry code will apply a fixup to
> > the GPRs containing the percpu offset and the generated percpu address.
...
> tl;dr
> Comparing this series with the page-table series [a] gives 8 improvements and 3
> regressions.
> 
> Fastpath is a Linux kernel performance benchmarking service. The table
> compares the both patched kernels: positive values are faster, negative
> values are slower, and (I)/(R) indicate statistically significant
> improvements/regressions. Unmarked differences are not significant after
> accounting for confidence and noise thresholds.
> 
> +---------------------------------+--------------------+-----------------+-----------------------+
> | Benchmark                       | percpu-pgtable [2] |   gpr-fixup [3] |         gpr-fixup [3] |
> |                                 |    vs baseline [1] | vs baseline [1] | vs percpu-pgtable [2] |
> +=================================+====================+=================+=======================+
...
> | perf/futex                      |              0.55% |      (R) -2.80% |            (R) -3.34% |
> | perf/sched                      |          (I) 1.61% |          -0.39% |            (R) -1.97% |

Might be worth investigating those two.
Something odd is probably happening.

David
