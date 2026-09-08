Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C94E4B489E;
	Tue,  8 Sep 2026 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900158; cv=none; b=aV96WB8DvB0hHr/X+kG4gL8I0yd1tZYuypbAZwxdvvMELOjHHWxRc6pSMtwH8hpzladK4b5om428sHpdOM6OvrKzwacuoU6MEyHBirvYL0WN5IywLW85YAb8JxLXmZJyg6+hgdiOLFzdrq/D8kQE7CDd2hcIFd9TllWZu/OCEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900158; c=relaxed/simple;
	bh=oB7ddjmueOS9dIT+geS/vfuLILaUzI+Uh8quCQHB5Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PidfOEeA6HE9ddjsNdp6w5Y5ixy1pfFhn3WFkJdaDtVeYZXqh2s4h/9RdGP82yySiW1AMd1MKnBytj/0K1I0jirCGFI1AP1fMg1omtBdn3aU6KqhXktdT1yOdl8kxC4AummY6OxumeLJp6lr6B3/HSybOQ8WVByXVffNfsEqSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obyoNDZP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obyoNDZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3201F00AC4;
	Tue,  8 Sep 2026 20:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900156;
	bh=j/etTlugt+t38bDZYesRkzHn2Pa7Crcl25ZwV4raeN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=obyoNDZPWFRS0inJVT+06Ou3g2FPHMQnShYu1SWc0jcPAPtLt2RzdK5BPcyeWL5xq
	 fcX2iiyLqkIJyVjUoSu9nY8AM8NVBGMKupZSl2TMC1qKhLdD41h9ulgRKiTk3VoPGY
	 Xe3VNOFyuNqeXBmWCE2jmf3Q9DAdMqzB+vXTjVELMAAyEzukMcw3gqU0dzyx09YskK
	 rWSpjqrjQRsQmrBqyksKss8DEgOsEwwcuDFdqzqjXIL6LsgAUXrbZvMqJcuhMoSSJc
	 L8NKx5Fy9BSFSBldrmCijVHEeyBk3Mm901ExzSKeIZalp7V2rEY/kXJvoAqWWTIi23
	 1/oABhfNaC36g==
Date: Tue, 8 Sep 2026 17:42:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Wang Yan <wangyan01@kylinos.cn>, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, james.clark@linaro.org, atrajeev@linux.ibm.com,
	tanze@kylinos.cn, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] perf powerpc-vpadtl: Fix off-by-one in auxtrace_info
 minimum size check
Message-ID: <aqBzOdmxHyTRoLcG@x2>
References: <20260824025553.363863-1-wangyan01@kylinos.cn>
 <61dff746-7b62-404b-89b2-3c9d73419d71@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61dff746-7b62-404b-89b2-3c9d73419d71@intel.com>

On Mon, Aug 24, 2026 at 08:55:52AM +0300, Adrian Hunter wrote:
> On 24/08/2026 05:55, Wang Yan wrote:
> > min_sz is set to sizeof(u64) * POWERPC_VPADTL_TYPE, but the code reads
> > auxtrace_info->priv[POWERPC_VPADTL_TYPE], which needs at least
> > POWERPC_VPADTL_TYPE + 1 elements.  POWERPC_VPADTL_TYPE is the first
> > enumerator of the priv index enum (0), so min_sz evaluates to 0 and the
> > check validates only the perf_record_auxtrace_info header itself.  A
> > PERF_RECORD_AUXTRACE_INFO event carrying a zero-length priv array then
> > passes the size check, and the subsequent priv[POWERPC_VPADTL_TYPE]
> > read runs one u64 past the validated region.
> > 
> > This is the same off-by-one fixed for Intel PT by commit c4362d5e1a5e
> > ("perf intel-pt: Fix off-by-one in auxtrace_info minimum size check")
> > and for Intel BTS by commit b9fb8225951c ("perf intel-bts: Fix off-by-one
> > in auxtrace_info minimum size check").
> > 
> > Use sizeof(u64) * (POWERPC_VPADTL_TYPE + 1) so the highest accessed
> > priv index is covered by the minimum-size validation.
> > 
> > Fixes: c4bbd4ec2e50 ("perf powerpc: Process auxtrace events and display in 'perf report -D'")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
