Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6679547074;
	Thu,  1 Oct 2026 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838497; cv=none; b=RKe+5wpKJcq6hiDFc+1mteUTA4Y7obz7e2gh1R+Y8N7Mbc3/wAkBLvIxSCl2K1zczC7yzfGGzLXIHLtGSPQAd+OEyyhFPscCkc2sPzO9N6iaRt06pKRyNgAObxE5WIkQDQu+Hy44NSZbQEzWwWWBhZ5qT74pAyj62d1ZEwUclUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838497; c=relaxed/simple;
	bh=nbXgcRbx4i5BTLZ8EzF2YcTdwfj6YP7znNDB2WMKF1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOOUYh5mXZ+tPbd/CsrqrYCMlMRkWN11FzuTTezadhbP8A2aSX9X1uwYVRpRrYh4Qo9lVtvFWGBwlXY6AmFZa5V7MkEFNpHHiiAc3KJgAvju3mwNFSAwTMcG2dDY5iStQUwa0/IZAbow2xMzoqzeXh4qpknVM1vXPg6A4KosnWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tm/Y533+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tm/Y533+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ezn1/5i1OKioygyWwMMHCtWeGbbfzgZse0+udSMI8ss=; b=Tm/Y533+Uegl1mXDMgHAjYnLzK
	87KbPYIyyIisz24b+9tUWbSkjr9ELrZ+QvjSoVisH7ATuTLvwZXbCMeTJWuEEc3lYhu1tZ2spYR56
	aDKZfmptlTqG6sQYeEXk8EjqLOjoOmg1mFRJ1p/n17b8b1g561P2gawiGeDh8UDVV3IyXBqSA/5tm
	J125TJnPzE72H4WBUk15757ip/NFtWliCfpYjxiThujImSRhyD3v/LN7ihQ2P/0hZKYvVmDWeR8CF
	8heQI0fg1+5EpKMEZpcgYuCkqywJgt72mSVPbrXA45Xhwtney2tvDf0RdTJ2AFGuXVQ/E+4Q5kr35
	vAFUs9dA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCAtY-00000005u1N-2s8c;
	Thu, 01 Oct 2026 07:07:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9E4AE300390; Thu, 01 Oct 2026 09:07:55 +0200 (CEST)
Date: Thu, 1 Oct 2026 09:07:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, ast@kernel.org,
	bpf@vger.kernel.org, james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
	song@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] perf/core: Replace perf_event_header__init_id with
 full header init
Message-ID: <20261001070755.GQ88198@noisy.programming.kicks-ass.net>
References: <20260929182108.794434-1-irogers@google.com>
 <20260929222332.973435-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929222332.973435-1-irogers@google.com>

On Tue, Sep 29, 2026 at 03:23:32PM -0700, Ian Rogers wrote:

> Rather than splitting header initialization between callers and output
> callbacks and saving/restoring mutated header fields, replace
> perf_event_header__init_id() with
> perf_event_header__init_header_and_id(), which initializes header->type,
> header->misc, and header->size alongside the sample_id fields on each
> invocation.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 33210aff3ee6..c1b2d0c9b2af 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8119,13 +8119,18 @@ static void __perf_event_header__init_id(struct perf_sample_data *data,
>  	}
>  }
>  
> -void perf_event_header__init_id(struct perf_event_header *header,
> -				struct perf_sample_data *data,
> -				struct perf_event *event)
> +void perf_event_header__init_header_and_id(struct perf_event_header *header,
> +					   struct perf_sample_data *data,
> +					   u32 type, u16 misc, u16 size,
> +					   struct perf_event *event)
>  {
> +	header->type = type;
> +	header->misc = misc;
>  	if (event->attr.sample_id_all) {
> -		header->size += event->id_header_size;
> +		header->size = size + event->id_header_size;
>  		__perf_event_header__init_id(data, event, event->attr.sample_type);
> +	} else {
> +		header->size = size;
>  	}
>  }

I've renamed the thing to perf_event_header__init(). Also, I've done:

	header->size = size;

and restored the:

		header->size += event->id_header_size;

and lost the else :-)

But yes, this is better. Thanks!
