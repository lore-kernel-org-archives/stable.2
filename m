Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96D428838;
	Tue, 16 Jun 2026 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611692; cv=none; b=RjZqwh63aYA8T4rCAqGc8K1ZY9Mf34MRE/fOariZTTiI+ZMudRX2P2+ipqa2U2LDPQ3QHoI8BqQNBuLA4MV9pCJgN3T5bL3dsPXBrmawEqWLpJ3NAhKv26176r1DnaFIbRFVbaGSOaxyUWuc71Y93VVGgqs/12iFKhhsIRb98+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611692; c=relaxed/simple;
	bh=BaAWpNVKQMEfnvgcIRLZekPNYX3WmRhGxIAXwl/oiYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzMS58BT4y1iXvuRH64+YqZjfov5n+uEigtqDT11a+rvfWQwneYNy7zi5OVIxTKKGN3/yZrwyo1kZ9v3TShNGwt1fZltt47H+/fu6aDdZr+gc20nZw/gSXVFVseZMs6+0RjgfDJazZfufVivNwBedkIOS2YPEOZes4ihKz0BvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yL9AqO4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yL9AqO4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77861F000E9;
	Tue, 16 Jun 2026 12:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781611691;
	bh=ETN6Wp86AZDI+LcqBkfjnsNtdRhZ5m1ZDNOvIe3MfuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yL9AqO4pqlllMumOFWjObo8QKCy6ePj9J2fHy8PwCGp4Gja5K7q8vlAmGdfz2O3rJ
	 V4G1c+1uKve1tW0NnXk0uRet/GTPYtUbafJq7Nx73ckplMjFc5QCafJPJqdYLUf+jb
	 X1gItlxLtYWD2cWDDcFc6ciueBg2Lmx3CzKwGKJ8=
Date: Tue, 16 Jun 2026 17:29:03 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
	"open list:BPF [MISC]" <bpf@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH stable 6.1 v2 5/5] perf build: Remove
 -Wno-unused-but-set-variable from the flex flags when building with clang <
 13.0.0
Message-ID: <2026061608-monorail-thread-bb53@gregkh>
References: <20260520163320.3073037-1-florian.fainelli@broadcom.com>
 <20260520163320.3073037-6-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520163320.3073037-6-florian.fainelli@broadcom.com>

On Wed, May 20, 2026 at 09:33:20AM -0700, Florian Fainelli wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> clang < 13.0.0 doesn't grok -Wno-unused-but-set-variable, so just remove
> it to avoid:
> 
>   error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
>   make[4]: *** [/git/perf-6.5.0-rc4/tools/build/Makefile.build:128: /tmp/build/perf/util/pmu-flex.o] Error 1
>   make[4]: *** Waiting for unfinished jobs....
> 
> Fixes: ddc8e4c966923ad1 ("perf build: Disable fewer bison warnings")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/ZNUSWr52jUnVaaa%2F@kernel.org/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  tools/perf/util/Build | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 

Oops, no upstream git id?  What is it?

thanks,

greg k-h

