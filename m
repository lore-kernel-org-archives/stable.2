Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998416;
	b=QojKPMM+IJI9MN90oz7JlXAlsKUdHWRDzH8KhZ+LHpQ2kQMji2AgC7MBvXmSIe2+rA7J
	 2Z0TrXSMqSjgpxCO68BoBbN0rq9UdXFxVOrqsTiJCzBy4pOx6aTQK1Fa72He0Q6N9AYFT
	 3frsYiFUczb7O3S3ZX+fAKFNDOi5jflCXhCPv8NczFWk089SyaZ3mEMqHrEl2i7Gvdi/y
	 VHnw4ng+5ZhvAkBpTzT1gjUdOVKOU7VmO0e1aNorVt8wIVMROMaA7IDPibaN3+X9ChVTJ
	 e+eHXVn4/HgBgShYYTuz2UvkAmAkGdo4Kx3p2496WQh0guv9kULgq81QUw6dBfUiScg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998416;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pIcHjfIpdJyWMV4q9kPoKJ5mc7N/xPRL1n4LrSiMDjE=;
	b=AO1dsQY0BJoNKXTeFKZGiwFYNT6ABypjl2DlIvMFO6qnRi/e7D8HFiyLJmtGdyn9i31g
	 69FmRz6GpC+8IhsNZwnKNCccje4Rc/ucnCVkAfkkuVL/kD+KM9l/G0c8wK08FsVr0/ah3
	 rlVTQAn2hR0UxwMXvo4uWkaNl2Xwll4yO+AUt1T+NaWvZ6ZeSC0DvBDjT64hbznWmblFW
	 Upt0WJuNw5Afjw01iKfYwOgBv834Qs4UVkQp9ebgr4nn09KY4G+7b+Q6Rzre2VSTU6yDM
	 NIXoH8b5bCY5ragV16WzUCPTdcrgrsHIOxaTPl1sMKy5nNlHYl8m1MM/EVGLuCufzpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=UEB6tFgY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3803606A31C;
	Wed, 18 Nov 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=UEB6tFgY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06831F000C4;
	Wed, 18 Nov 2026 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794998416;
	bh=pIcHjfIpdJyWMV4q9kPoKJ5mc7N/xPRL1n4LrSiMDjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UEB6tFgYglkDL+apiYc1otTYRGwSUty8sjDU3sPAnDlhqpYruJdLc9hakJ8S0Gzs7
	 2jgwGqQic6S2OSqUa9kfvy2RTfSUhxXm51wxvCVgLM1Fji41ouj/5V9efOp83qMQxG
	 nrou0lz+l15T45J4TTnmBi1gMPmLk8fHmmsc7H4M=
Date: Wed, 18 Nov 2026 11:40:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: asatsuyu.liu@gmail.com
Cc: stable@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, puranjay@kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [RFC PATCH 6.18.y 0/1] bpf: reject NULL arguments to four kfuncs
Message-ID: <2026111850-shiftless-popcorn-a566@gregkh>
References: <20261118101748.2335815-1-asatsuyu.liu@gmail.com>
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
In-Reply-To: <20261118101748.2335815-1-asatsuyu.liu@gmail.com>

On Wed, Nov 18, 2026 at 10:17:47AM +0000, asatsuyu.liu@gmail.com wrote:
> From: Yi Liu <asatsuyu.liu@gmail.com>
> 
> Hi,
> 
> 6.18.64 still accepts NULL and PTR_MAYBE_NULL arguments for four kfuncs
> whose implementations dereference them.  Mainline fixed this class in
> v7.0 with
> 
>   1a5c01d2508a ("bpf: Make KF_TRUSTED_ARGS the default for all kfuncs")
> 
> but that commit is a broad verifier behavior change, it was not
> tagged for stable, and it is not in 6.18.y or 6.19.y.  6.18.64 is the
> current 6.18.y tip; 6.19.14 is the current 6.19.y tip.

Ok, but then properly backport that commit, do not od a one-off change,
that is not ok.

thanks,

greg k-h
