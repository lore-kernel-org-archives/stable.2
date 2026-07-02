Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D41D86E4;
	Thu,  2 Jul 2026 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002195; cv=none; b=ip+lXsWmRuWvjANho70vOOWIEPo3ae50PHGqsOlA0xaQ8lPeYXs+b6GpwBqhjFj5u8EhH0LQpTLAYuJ7Zv42KKbziZvEEgos8qY/kIwwfcgJWHE1/Yv213k4aj1u20cluXp+PqcZJwB2upnohbfcZcD2KokqrkgCMxSmjLMFs3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002195; c=relaxed/simple;
	bh=N9CiUzfveiKSfNKcnnofw5fkXZVWxTpVPfEpxdad3H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjhYWEHo3F6ITmKDRioQh1cuYoWX5foVG2chaUKvB1+HUxkh1RkZA0Gkm+VKNRa3AJpDtOhrksPZvRPPEYUosNLzeDRmR2AKd29NHh7wNABqsgHKsexxw2xwG8BCRqyAvlYBclLgtDXfqkoqKX3Mz6gtwX7jOoKvqU0WDFp/oMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VLRG5QSx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VLRG5QSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321C21F000E9;
	Thu,  2 Jul 2026 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783002194;
	bh=TvMG/L57vNYBQCE2dS+MQv8x6hlxZY8ENHAizbR5Un4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VLRG5QSxyrZqqwlmQEyMrrrXaEf20kAus7K/6Gl5G5kYtELjRvMNFn7bxdT7ENpY4
	 mkdgoqiiIoXiDnljaxrhHHR57jUGjKhjHaxej/mQ1BxGugYYrc6w4uiqMDtCzgKJaz
	 ybt5wBtdjRP+F/pm0laMnWc9OqodLwvpawtx2pQk=
Date: Thu, 2 Jul 2026 16:23:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Clark Williams <clrkwllms@kernel.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org, x86@ekrnel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools/lib/bpf: fix const-qualifier discard in
 resolve_full_path
Message-ID: <2026070259-slider-mortality-f9ae@gregkh>
References: <20260617011303.3969027-1-clrkwllms@kernel.org>
 <20260617011303.3969027-2-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617011303.3969027-2-clrkwllms@kernel.org>

On Tue, Jun 16, 2026 at 08:13:01PM -0500, Clark Williams wrote:
> [ Upstream commit d70f79fef65810faf64dbae1f3a1b5623cdb2345 ]
> 
> strchr() now propagates const when passed a const char * argument in
> newer GCC/glibc combinations, causing -Werror=discarded-qualifiers to
> fire on the assignment to next_path. Declare next_path as const char *
> since it is only used for pointer arithmetic, never written through.
> 
> [ clrkwllms: only the next_path change from the upstream commit applies
>   to 6.1.y ]
> 
> Assisted-by: Claude:claude-sonnet-4.6
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks nothing like the original, including stripping off the tags :(

Please be more careful when you resend a new series.

thanks,

greg k-h
