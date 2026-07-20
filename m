Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0763BB115;
	Mon, 20 Jul 2026 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539503; cv=none; b=OaBC911x/+wqFFrMMForw9n39uIxzonVt6L5hAhK3dIySqK7FJEOlIk6d/yw365AaxAYDIEFVw/GOGdgrQZYJdayDb+hRPMAU3fX2Uv64iCqlJ/b+usFceWGHRboxbGuY/L/hREl4pAYcKQbQyA4Q4R56p9c7zb15Il7lrrd1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539503; c=relaxed/simple;
	bh=luVVtApggoFb+RlU9R22BdwL+Hlx2LE4vY/f9Ayma2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5Ev7A6kGbFW8pXEgkosG8A0L3Wslbrou0MU7AZewWzhX42xcyh5FxpFPa/ijdQsHQTIf9dUWbikOg874KfiwHeMCGZ9NrwPDcBGForqYU+8YDPUPvy2d/V1kBx7mI6a56q4BDD1LEK4TBFBcgaxS+FltJw6oA8AqF8YgtISfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=iF4S+NpZ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="iF4S+NpZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=luVVtApggoFb+RlU9R22BdwL+Hlx2LE4vY/f9Ayma2s=; b=iF4S+NpZ4JlSTgCPW8Ihgv3cYj
	WgeudhRT9S4HlZgPU6tZnlRPXmTbyb6gHMNBNObRxoya0Jago5yWsXg68d0Z9mG9HzbwjM8CsEIeS
	Q6ng3f/N8nDFeDE0Ko7p4DVRNZ3J9pjG/jqFPbAvL7WhGXN6hUNPX7kaLgFky+tt7b9swvaGm2xOU
	hKl0BnVDHcNnx8RotymI/lIfkIRp+E9rjs33SBFjIK3qLRzZbE0kZr/FMvSoE6PpyOQak/YA/o+KP
	q4GnRdR2FhLRmFKt4bidQwRQNRtzkfSN4zkSbX2mBKEauXrvu3DqE/A7zHSmVzJGaAMspELCI3TIt
	vivXqFjA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wlkF0-001KvL-3B;
	Mon, 20 Jul 2026 09:24:51 +0000
Date: Mon, 20 Jul 2026 02:24:35 -0700
From: Breno Leitao <leitao@debian.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, stable@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix context switch counter truncation
Message-ID: <al3ocaRVD0mZaDU2@gmail.com>
References: <20260717173252.3431565-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717173252.3431565-1-usama.arif@linux.dev>
X-Debian-User: leitao

On Fri, Jul 17, 2026 at 10:32:52AM -0700, Usama Arif wrote:
> This affects long-running systems and workloads with high context-switch
> rates. A CPU switching 1,000 times per second takes about 50 days.

nr_context_switches_cpu() returns "unsigned long long"
and rq->nr_switches is u64, so the unsigned int cnt truncation is real

> Fixes: 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read user space")
> Cc: stable@vger.kernel.org
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks for the investigation and fix,
--breno
