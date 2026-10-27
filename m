Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133453;
	b=EWcmxrtFTvE+OXNlUaRYaRTANNBs0QKB1wa+XEgHYsOdFvnUteYCld2xBUqrxaObKAB1
	 SblGc6gV18ZTQZz/zcMyN3ystw54ipHLJYN1sTFmgdBPG5vRlaKf9aHsjkaaRC/lgyCiq
	 ihSETjmfn5EKNuzy2XJ4Q2wGTBYV8EdwyZsB7pG7H4DJ0nvf5fa4Vcscuc0ih4tRQc+Oa
	 8JO6sr96SXX+sUMhigkA1ep7eDXP8P8P4YshdD+/z8vNVoN9l1RBOfYGHCkPw6UeHHPxK
	 v3HlkQVkgMtwmEKWfPIN+Fum5TQp/udRk7UHT7zj011zw6Cx0ZyuahgQDmWJQ3K6hrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133453;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=wUv2shmSnp3EKpQLizhxLT20/UDWKKocXenHDKyrGK0=;
	b=WLRn4EXTvSRJVp+jd5/AnWGrX0mOEHPRLQOf/xTdlwu7HQLFEo1GvQ46GWHp35kcLHV/
	 0h4Tgbvk2M+YWXCcr8007/OiKN8z05Yo8IMyZO1dAEBGcpibiYR0Epl8xB/5VnCIgKtAg
	 gWthnTb67k/KjultTj1tEsRMKnCFt/0SJjEHu64LIMYmC92KX1K7aRDOnEobJBJhcyaMR
	 97kRfAoX4l1nfOK/xZi2C2b6+W94EMz1VxCsn3lbUnflw7Kx7m9n9UZ4lVTZM02y/GLYE
	 VyPJiP1r0EWcd8oF2MjY6XsZiVc9pQxNgdXthUd0YjdXz8ZHpCcdsqw3r2abX8lh43g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNuZTYRU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01E606A31A;
	Tue, 27 Oct 2026 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNuZTYRU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73F31F01825;
	Tue, 27 Oct 2026 20:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793133452;
	bh=wUv2shmSnp3EKpQLizhxLT20/UDWKKocXenHDKyrGK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XNuZTYRUhFIfqgBAa5IwJ+aEhapNxOJ6L/8Y/USHryvJNiBhpKSmrjbhzjFTtSwuS
	 jAeoFYlJO6AKdm06N7r5SnRMqYc+U3G0+5/og3DS62czFxyiUApuCQip2ERCo2I4md
	 47NaqmkvzqTedhcTyTcTgFaGqJP7Yuy/19wQNqwc02ZLwrIPX2CnyFvXXo6VrAJ5ga
	 ambIg6mvv5gaBudoBQ5QJN8a/Eks//bC1dIkdNHCTIadEqXli2vtCgbSkTq2ULUgZR
	 v2DdFlP3wk4YgCOq5gPe9XY00TafymmJAQ/9qMv+hyHjzCHRJYpaHkevOiTLFwRIbM
	 iOFYMDj+drckg==
Date: Tue, 27 Oct 2026 17:37:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: lv.yating@zte.com.cn, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	liu.qingtao2@zte.com.cn, he.yilin@zte.com.cn,
	zhang.cheng35@zte.com.cn, ye.zhihao1@zte.com.cn,
	shen.lin1@zte.com.cn, dai.hualiang@zte.com.cn,
	stable@vger.kernel.org, hu.shengming@zte.com.cn
Subject: Re: [PATCH] perf machine: Fix NULL deref in
 thread__resolve_callchain_sample()
Message-ID: <auELiZHf3HldL5wQ@phoenix2>
References: <202610271154.69RBsOlq045164@mse-fl2.zte.com.cn>
 <CAP-5=fUbpxz9HQV+BRd62Yk+mQ5Bq-G3XvcK8ea3W8E3BqM6jg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUbpxz9HQV+BRd62Yk+mQ5Bq-G3XvcK8ea3W8E3BqM6jg@mail.gmail.com>

On Tue, Oct 27, 2026 at 08:21:16AM -0700, Ian Rogers wrote:
> On Tue, Oct 27, 2026 at 4:54 AM <lv.yating@zte.com.cn> wrote:
> > When recording with -j stack, resolve_lbr_callchain_sample() can
> > dereference a NULL 'chain' pointer while resolving the branch
> > stack.

> > $ perf record -j stack -e branches:u uname
> > perf: Segmentation fault

> > Fix it by checking 'chain' for NULL before dereferencing it.

> > Fixes: 29be60c93d2d ("perf build-id: Mark DSO in sample callchains")
> > Signed-off-by: lvyating <lv.yating@zte.com.cn>
> > Cc: stable@vger.kernel.org
 
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied for v7.4.
 
> I wonder - this failure points to a lack of test coverage. For LBR the
> main coverage comes from:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/record_lbr.sh?h=perf-tools-next
> Could you help expand the tests to avoid regressions?

That would be great indeed,

- Arnaldo
