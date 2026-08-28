Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAAC26ED4F;
	Fri, 28 Aug 2026 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937888; cv=none; b=HWO5FJU/0x/IhcWzCr2u9s5kN/QYyesSCHIbERGrifaFJqHSHKcaUMa/tSvBr1WClW+VmM4OEAodVkVSbDF/1ps7PxUsjRBIR1aKcAJCHIZHyDhUjtBdnufU5imELKwM17xpmyLrhf4KIQ+ZNMSJttxaaZ2OE2FhzYsp4iH4miw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937888; c=relaxed/simple;
	bh=naD3aYsaI9MItRel4DbxjhG4PnXgbqZr135fPyidkDQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HXbwyOsyT5a37OXmRp9u/KHiEZYmKtgoAq1fpuHFjYSYLa5yuEc3qjUZHpppHagfYrZQ8hCa8xP+PpGuToZpYttQfVi2f37Nb8kO4Hdt2SLLJJPC4pKW94e98Z5BynSUg2x7Z4CMv9KL6E4suIOoLfo+bmm4MLK9REy+c2W0zDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Igq6r7AD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Igq6r7AD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D25D1F000E9;
	Fri, 28 Aug 2026 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787937886;
	bh=scPdLZfc2SB0r686g8wZjiJts1QHWKPxa8rdWScqbic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Igq6r7ADqcLSF6y8LDBz3PqV0hIkwWCJIjFz+XOQkdYDCpanXKnlmfsAPzXG/4GuG
	 MAPUyQVonkgL2+cbqgTIW68YlpNgb0pROee9CKtBkVqxaRB9UqaflxrbLqqUYe8fOi
	 Fh/k+VMJs85bRMPYPIb0swFZzUirV1L8rpqiH+tc=
Date: Fri, 28 Aug 2026 10:24:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
 bgeffon@google.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] zram: fix idle age_sec underflow in idle_store()
Message-Id: <20260828102446.3eb7f3dc779753b831e33fe6@linux-foundation.org>
In-Reply-To: <20260828083149.45760-1-jiahao.kernel@gmail.com>
References: <20260828083149.45760-1-jiahao.kernel@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 16:31:49 +0800 Hao Jia <jiahao.kernel@gmail.com> wrote:

> After commit 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking"),
> idle_store() computes the idle cutoff as:
> 
> 	cutoff = ktime_sub((u32)ktime_get_boottime_seconds(), age_sec);
> 
> Because the left operand is cast to u32, when age_sec exceeds the current
> uptime the subtraction wraps modulo 2^32 and the huge result is
> zero-extended into the s64 cutoff. mark_idle() then marks every entry as
> idle instead of matching nothing. For instance, running
> 
> 	echo 86400 > /sys/block/zramX/idle
> 
> on a machine up for only two minutes marks all newly written pages idle
> and hands them to idle writeback and recompression.
> 
> No slot can have been accessed before the system booted, so an age_sec
> that reaches back past uptime cannot match any slot. Return early in that
> case, without walking the table or taking any slot locks.
> 
> Track the cutoff as time64_t rather than ktime_t. Both cutoff and
> ac_time are boot-time values in seconds, so a plain arithmetic
> comparison against ac_time in mark_idle() is correct and no ktime
> helpers are needed.

Thanks.  Sashiko asked a couple of questions about this change:
	https://sashiko.dev/#/patchset/20260828083149.45760-1-jiahao.kernel@gmail.com
