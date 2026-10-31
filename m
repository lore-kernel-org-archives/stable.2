Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793467749;
	b=Y7NL94MMK79WdL7VUqSGPDgG6TFb1flTha8Z49yTNHRy+NzBKis1A4Y4mzcdMsIYVxXv
	 psD/iff22sWtwCAZN15RdlUgYcUVdPfb/HSYGd9Muf5Q/pCmrN/ENGv5juVvZQMqYEoG8
	 7kzc/FxKqEvKBSTCppRwTw0LLwtYqjrtDzEr9MatzLpMSfn7tbmStu95tO5dpKn1KBswi
	 K1LjomGK4yBFb5bXWB8j4TSc8K5Xe8jRHBDSX9s+kscMsLgFkfCTpib/icNM47Rdxcs3i
	 KAcvNB+iD3W4bO7eagryDGHIHkCAELmtOaH5QwqM85zNmT+FlHIYEQuUiO6p2JIXJZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793467749;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FKmueVCGRcuZBIHCsJR/B5UULYSvaoNnz+4Pg3U8f2Y=;
	b=fCnZuz/y39VVXWIVtjPhVNbdkVMaSl1NJMX7OIQgs7p7iuFUpjVU6jh/KxoXebUjKQWg
	 FSo/Hl2+N92PMYUzxj9shZNI4ndt19cE0Mp1dYFMCBCTFq9askGxOyfHLWQnRxXM5ihwi
	 Yf4l4xk15K0K0TjF/mn+SMqvDJfVZ232nlUND4nZCRxpJdbMJmMxeesZ2D5euMf4xELa3
	 BWiE1boNIZkg0JmCkHlLrBMgMPV96uK9Kt2XIjB+sKRJvJAoQjtUOs1Bgc7aLsyFdp6OF
	 JfBneqbBeSW+M3zV1WSoXqdMLaZ5uUf7TXTndgEIvzUCM1pBDkw4WJGh38sCkn/LQOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=loussU1J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A53606A323;
	Sat, 31 Oct 2026 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=loussU1J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A9B1F000C1;
	Sat, 31 Oct 2026 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793467748;
	bh=FKmueVCGRcuZBIHCsJR/B5UULYSvaoNnz+4Pg3U8f2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=loussU1JL3PFSsLQzU4dbaShzWV8CYZj2upYd4J9A/OIDsJgHrFVbj++Llbgqb7/T
	 J2cing2PIcjR4D/piPXlQSaKJU0sZHwzn7eX+YkOsOd65PBf53mzTqpA40p8DmX0nu
	 DfbyVlvoxHmmFciSag1GWzn3LoO3EK61perlp2JbYtA1LJm3UB0BSF3p1U3tVuGoFY
	 Nz20xlAjDR4zWFERUQ1lwsJPkI5+YlrKrOK353/t/AlAzckEuwqpAAqbrj4Jz4AVVD
	 Fr/os9bCLg421VgtCTL+IND3C0AgbuRCOllNUiPbSaoa3AmcI/UoqBz0TIshDvulM3
	 ynx46E2GSb/kA==
Date: Sat, 31 Oct 2026 17:29:05 +0000
From: Simon Horman <horms@kernel.org>
To: Chengyu Liu <19290937@qq.com>
Cc: khc@pm.waw.pl, netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] hdlc_fr: shut down the LMI timer in fr_destroy()
Message-ID: <20261031172905.GR257209@horms.kernel.org>
References: <20261028032310.2832307-1-19290937@qq.com>
 <tencent_01EA70DD2A37DFF1634781DAD4E349400008@qq.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_01EA70DD2A37DFF1634781DAD4E349400008@qq.com>

On Wed, Oct 28, 2026 at 11:23:10AM +0800, Chengyu Liu wrote:
> fr_start() arms state(hdlc)->timer when LMI is enabled
> (settings.lmi != LMI_NONE).  The only deletion lives in fr_stop(), which
> is unreachable on the protocol-detach path: detach_hdlc_protocol() calls
> only ->detach() (never ->stop()) and then kfree()s hdlc->state.  FR's
> ->detach, fr_destroy(), tears down the PVC list but never touches the
> timer, so unregistering an up FR device with LMI enabled leaves the timer
> armed on top of freed memory; fr_timer() then fires into the dead
> frad_state.
> 
> Shut the timer down at the top of fr_destroy().  Use
> timer_shutdown_sync() so the timer cannot be re-armed afterwards,
> matching the CVE-2026-63803 ppp fix (ppp_timer_release()).
> 
> Initialize the timer in fr_ioctl() when the protocol is attached and
> drop the timer_setup() from fr_start(): attach_hdlc_protocol() uses
> kmalloc() (not kzalloc), so state(hdlc)->timer is uninitialized garbage
> until the first timer_setup() and fr_destroy() must never run
> timer_shutdown_sync() on it.
> 
> This bug was found by static analysis and confirmed with a KASAN
> reproducer: slab-use-after-free in the timer softirq after rmmod of an
> up Frame Relay HDLC device with LMI enabled.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengyu Liu <19290937@qq.com>

Reviewed-by: Simon Horman <horms@kernel.org>

