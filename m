Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4183F39EA;
	Tue,  4 Aug 2026 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830708; cv=none; b=JYNAGi/y6SZDvA39p2zWiu68lEqIWuaTOJNWCKTMH6qYZYQMqgddAN+8srbxaDTZG6Ti+uIStgEZJgpiPe44fIdpOTEqeM8/mGLESiysPkSRgfoI3fkF6tTk8FdEf6XM8bl/VXZk9ZeP2CEMNyqSLB2bLjOkdMCuxwJMXueoL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830708; c=relaxed/simple;
	bh=we1aL2u2OJHpX7f6AxPP6q+3fRXXdH/4wVnWhe1VCPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/1qa3icx83gTG6oP+/ldIZuYl8oiTuHAaTRdS/fr2tU6hJh2K8a+2HJ3OEMa3E7xL37A/Yx1k/qruA3kHFu4m6eRRjb+Sv/Un+VNrCLvdFiVBDyLGSbTLuD6j6tgnuS0mA71FnQwIpoFyVDfLODffSm0kmHO1HJc7VWyanSg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Ic9iooQ4; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Ic9iooQ4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jIdOuiLKenbu7yg3o/ZRE0+gje33E8BVBjzOz2eBMCE=; b=Ic9iooQ4WBp/TwtzcHm3AwIHEe
	ud3kPAkeWRjK9NeUKG91xPEKKalrH5SxgDmTb4g/tlVGe7RP1yAbS+BldDV+15K+fvPlCicOQ/RS1
	5LhjtAJVstdVIZ434euyBic8c6UmkXDhzqkmW0xRPtwjGLArSlqPlT6PYgh7yeYTaih0oEeN8NWJJ
	9bRI4UxCR6GM73JMGKolhK9A1FpzdsJ+HtpMrRQ4l4424agP9pLAXEPGZsJbpM0oIcUy93kEK3Wt/
	VppL5cCuayFJPe1XpNZHRCCm+33IxITu1PJrp9sXd77qjMW5NKg8B089p2h9rNtXRPFY8x4XKvDE3
	CVHSAWxA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wrA8z-00D00A-23;
	Tue, 04 Aug 2026 08:05:02 +0000
Date: Tue, 4 Aug 2026 01:04:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Markus Boehme <markus.boehme@mailbox.org>
Cc: stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12] netconsole: avoid OOB reads, msg is not
 nul-terminated
Message-ID: <anGdHcAGMUbblP2c@gmail.com>
References: <20260803184129.24594-2-markus.boehme@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803184129.24594-2-markus.boehme@mailbox.org>
X-Debian-User: leitao

On Mon, Aug 03, 2026 at 08:41:29PM +0200, Markus Boehme wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> [ Upstream commit 82aec772fca2223bc5774bd9af486fd95766e578 ]
> 
> msg passed to netconsole from the console subsystem is not guaranteed
> to be nul-terminated. Before recent
> commit 7eab73b18630 ("netconsole: convert to NBCON console infrastructure")
> the message would be placed in printk_shared_pbufs, a static global
> buffer, so KASAN had harder time catching OOB accesses. Now we see:
> 
>     printk: console [netcon_ext0] enabled
>     BUG: KASAN: slab-out-of-bounds in string+0x1f7/0x240
>     Read of size 1 at addr ffff88813b6d4c00 by task pr/netcon_ext0/594
> 
>     CPU: 65 UID: 0 PID: 594 Comm: pr/netcon_ext0 Not tainted 6.19.0-11754-g4246fd6547c9
>     Call Trace:
>      kasan_report+0xe4/0x120
>      string+0x1f7/0x240
>      vsnprintf+0x655/0xba0
>      scnprintf+0xba/0x120
>      netconsole_write+0x3fe/0xa10
>      nbcon_emit_next_record+0x46e/0x860
>      nbcon_kthread_func+0x623/0x750
> 
>     Allocated by task 1:
>      nbcon_alloc+0x1ea/0x450
>      register_console+0x26b/0xe10
>      init_netconsole+0xbb0/0xda0
> 
>     The buggy address belongs to the object at ffff88813b6d4000
>                 which belongs to the cache kmalloc-4k of size 4096
>     The buggy address is located 0 bytes to the right of
>                 allocated 3072-byte region [ffff88813b6d4000, ffff88813b6d4c00)
> 
> Fixes: c62c0a17f9b7 ("netconsole: Append kernel version to message")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Link: https://patch.msgid.link/20260219195021.2099699-1-kuba@kernel.org
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Acked-by: Breno Leitao <leitao@debian.org>
