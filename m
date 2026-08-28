Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7A3803F9;
	Fri, 28 Aug 2026 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787920745; cv=none; b=Zi+8XRLNLMv4dYgt9snPqrpo/wvZsVOc9lpAxvNoSSc/QLyKcX7oIAXIQ8Aa+pdPoIh/+fksSr2Vjs8X774iSEnpUI7lxvkl7dTCnAMQasOx5UbUj9SD5MRnePtokwuspDI0myjiVyW6SnOHvmNcmqUtJtYHJOAyI+foXoT1yb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787920745; c=relaxed/simple;
	bh=nsKi/2FRLVJEDGjBlGO9wladpeAcxx7YqxMiJMJMXpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPFoHWgliOg37EEJ6T2520t44UuDghZkcr+72ebEEIM1+TJnSMhae+4UrMtLVEXJWXR843od7yRiHHuhlOVrgFTk8pEAjt8YBlS8DUTFwADgOFxz4dBBPKxAhEOfufmvvCoNyl2HqxkzAzq7zOedwKKGKzR+QU6/f54zPilJiU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=PfywPigd; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="PfywPigd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3BOdjxSKnZAdimAFfuaPO248wtqe260hlhe20oL++7Q=; b=PfywPigdGTZEPz54BL/4rvfL67
	I0/EH5ficCBn1xXxgG6ucVh5kSZoOxLRzRlssmG+N6ChZKLevhVFvEQJrf9opUf8OfZZ53sA52Dft
	BIGCbrzhIEt8yCFFRlCxT3Kc5Lp11HPDGiU0DNCOoL3uTqBD+JOxOWeJQG/QBaJox747C0ew6/go+
	4+Fa4k3DCeCYzo4NpeFEAH+dnTNVSrDkG/R2ZwgQbx1onk2ZSqLTCikmaYRzkGL06xAQ6hJ7TcTIf
	ONZYdhq896aIcayJ1mx8iT74GddPYKrQXrCLVT3M45JQ9G/+OLnzhKDhIbqzWJAtURAt4nWF4s62h
	FpkAInFw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wzvqv-00GmBH-2P;
	Fri, 28 Aug 2026 12:38:38 +0000
Date: Fri, 28 Aug 2026 05:38:31 -0700
From: Breno Leitao <leitao@debian.org>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, yhs@fb.com, 
	kafai@fb.com, andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu, tgopinath@linux.microsoft.com, kys@microsoft.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] tcp: fix use-after-free in
 do_tcp_getsockopt(TCP_CONGESTION)
Message-ID: <apGBE3XHKeNohHF1@gmail.com>
References: <cover.1787870710.git.blbllhy@gmail.com>
 <d3f97f1acbf0010898148be6e6406e4b8b4a5c84.1787870710.git.blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3f97f1acbf0010898148be6e6406e4b8b4a5c84.1787870710.git.blbllhy@gmail.com>
X-Debian-User: leitao

On Thu, Aug 27, 2026 at 07:55:10PM -0400, Cen Zhang (Microsoft) wrote:
> From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
> 
> do_tcp_getsockopt() reads icsk->icsk_ca_ops->name without holding
> rcu_read_lock(). Since commit 0baf26b0fcd7 ("bpf: tcp: Support
> tcp_congestion_ops in bpf"), icsk_ca_ops can point to dynamically
> allocated BPF struct_ops memory that may be freed concurrently via
> setsockopt(TCP_CONGESTION), leading to a use-after-free.
> 
>   BUG: KASAN: slab-use-after-free in _copy_to_user+0x37/0x60
>   Read of size 16 at addr ffff888013505260 by task exploit/149
>    _copy_to_user+0x37/0x60
>    do_tcp_getsockopt+0x158a/0x2460 (net/ipv4/tcp.c:4585)
>    tcp_getsockopt+0x91/0xf0
>    __sys_getsockopt+0xf7/0x170
> 
> Fix this by holding rcu_read_lock() around the ca_ops->name access,
> using READ_ONCE() to load icsk_ca_ops, and copying the name to a
> stack buffer before releasing the lock. Also annotate the relevant
> icsk_ca_ops stores with WRITE_ONCE() to fix the accompanying KCSAN
> data-race issue.
> 
> Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Link: https://lore.kernel.org/all/20260821182449.79785-2-blbllhy@gmail.com/

Reviewed-by: Breno Leitao <leitao@debian.org>

> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4576,16 +4576,24 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>  		val = !inet_csk_in_pingpong_mode(sk);
>  		break;
>  
> -	case TCP_CONGESTION:
> +	case TCP_CONGESTION: {
> +		char ca_name[TCP_CA_NAME_MAX] = {};

nit: Do you need to zero this string? It will be safely overwritten
below, no?
