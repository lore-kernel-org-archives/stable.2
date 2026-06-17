Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF73F9270
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693165; cv=none; b=Mk7oSsklBagXAT6rDR7wGsloyszeJYyzFfBGfdb4qRYK9ETF2yqsQDFsmARCruXVLPjfwy6s9MEgbeHnlACYkfsA9+/iB5o+bYQkht26sp/hD620K8svhw9imexi+V9hmlCgvlW5Ibu51smQStYHHlkk1y5/4fdvxSaWeKEokpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693165; c=relaxed/simple;
	bh=DoHyOXb44cEyFyqCcOZbdpPmjWaqhtS2t6SyiBCeGuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILkzgZBCs1BSXLKrfOLp5S9nr+VOHGBVnyi0g+DguqVjaf+cO9jniH/HisIGRN8eGqQEjhvr1KF9cK4C1jri838o5ShDU7oO8luOUk4A7E+VbYEnz30zT4CqNDYM8PcWcKrofsQ9WtdGp2zK7QMhzMq3G5QkWtZLMJRlVn9UxiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvcuRsNi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvcuRsNi"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4626fdc829aso535791f8f.3
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781693163; x=1782297963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ArPXWKSoKZlKEVktoEQrEi4JptJyJihdjMkeBwI/mo=;
        b=mvcuRsNiZVPN6ASzBX1hqK4Ju4haK+p/7Yo2jBqJYSbicA/N9V086nnyreYW4lxTlp
         UC4MD9VmTZDx1hOW9N91BSp9md6w96VLxlV190cQcLbnsW6jzfP+soRPK0XkkQO5esI0
         CdrOLtrMV2nE34GH63C9DLEU5K0bcYcNtShoxL2Hu8EGcdmYGQYFmS0ZK4RBeo+IycuU
         KjAKb9hMJ7g7UsIitnBJKvdsb+OFcpP+V/qcQwLwSgGShob0n0Uix+Gv/vvEB30AIlUg
         1AjtkjwnRPuHaNvcMfgR6nwPu0jlSfIpZJe7OwLyqrECjJyAngg7FdFyBR1h3aezVw/+
         evQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693163; x=1782297963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ArPXWKSoKZlKEVktoEQrEi4JptJyJihdjMkeBwI/mo=;
        b=KvYtmXR0WmfKjs4dxHpEYrELKgDJazhLCi1sBg35MJiaONVe9N3qZOUbg7Xzx1vZ8X
         Iy0sBurLb90AcRMPFyFWzZSW4g1fJY61iwDK8+1w3aFmdfKF0wWc7P48xJ8yIIgz26gk
         9l5KbpXr4jWEdW3xb61gR4/DsxwA1ZNNwXIlEXj3wbtnD2OhSopTWpWN9YMt479MrBzR
         7mWZHmAVL3CD6vVZ8TtxciYbUYoleR+GynxpGm26+VsJJUNi0bsnt+whVeCwt0PdSltM
         FXK9IlZcJxMdT9T4UlojlNQlXyMsMzxiphhgbvSFjcncklXJ5KWR/NvfSYo2dalwWRmR
         NU+A==
X-Forwarded-Encrypted: i=1; AFNElJ8+XsBQQtp7Kh51Bk/0dFc/nn7J/u5QUF2Y5tI7ti+I4fHlLcWr+fG1dIjkzqWhdRDI9d3Fgm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsmUNmgpBQzLxN6ZgkdDMs8m2PSzzHNEhHjjRgUVTY0Ch4dPqP
	AsYNP+qNd8V29SJuTCJfiKCMvHgIOvTpm8gGdrZxYrXaeOY+mQxba/4R
X-Gm-Gg: AfdE7cmLVKu0f0GbyHq6QNCFdBxfa1DWFBGtVzsGHGP9HELsJGn7qpN0HZUPS7Dh1Un
	WwjkHLdTLe5DYeuu5/uf8j9Px4OHengZp/9TKfb4Q/aPEuvecjFXoBHxPWiPtRYy03219i5n441
	QX/mROWd2Lv5uo5DKXnyZPKhBXFOmaHfth5BqPxyJ4k2WMLbUI3Q8y4jEAat1ThGeQjM/VsNera
	iNREmlHfWm/zCuh7yK9iO2w5ti170SDaUjFgrmdjRf/UqtAk5NIFaQpjW3fc5Xmqk/KGxVY3wRR
	egdn8a7lykzXXQVK826zIr4w6VEyh5rMoQTaXmnDzUjYzeOvIJIByoYHmKuuzqwn1n+AMpyrIy1
	vyAWaR6VVwJjoD2Xf4mooY+5pkS6twXR6SwVwWv8nY/rKgPd2JNlAXtecpC/JTJFuPkgcxcwHJd
	UWpM6jj/YflmiFAlSqquG23qssCWPZRbVWmsMw7xdJcwj/MtgUiwnhibVFOuu3B7n5DzBxjds13
	aNX6a12cEo/h7T2HZcRwvLQckncbtVoIkDqSDb9FbS7Na5HxToZIl5Qliy977dtlS8KFTxIp0PX
	kBjMRu2V6mzmndNf3a0xTXHZYPb3IPE=
X-Received: by 2002:a5d:424e:0:b0:45e:8547:f21e with SMTP id ffacd0b85a97d-46241d60255mr4193090f8f.36.1781693162804;
        Wed, 17 Jun 2026 03:46:02 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00e0cbb4a619790abb.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:e0cb:b4a6:1979:abb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d70sm53282324f8f.19.2026.06.17.03.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:46:02 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:46:00 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, stable@vger.kernel.org,
	patches@lists.linux.dev, John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 054/522] selftests/bpf: add generic BPF program
 tester-loader
Message-ID: <ajJ66F3oNlhqhKAv@mail.gmail.com>
References: <20260616145125.307082728@linuxfoundation.org>
 <20260616145128.305073045@linuxfoundation.org>
 <b6b679743c2383b5a367c5d72404b056dfebf080.camel@decadent.org.uk>
 <2026061719-danger-ensure-f276@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026061719-danger-ensure-f276@gregkh>

On Wed, Jun 17, 2026 at 01:53:29PM +0530, Greg Kroah-Hartman wrote:
> On Wed, Jun 17, 2026 at 10:01:56AM +0200, Ben Hutchings wrote:
> > On Tue, 2026-06-16 at 20:23 +0530, Greg Kroah-Hartman wrote:
> > > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Andrii Nakryiko <andrii@kernel.org>
> > > 
> > > [ Upstream commit 537c3f66eac137a02ec50a40219d2da6597e5dc9 ]
> > [...]
> > 
> > There seems to be a fix needed on top of this: commit f00bb757ed63
> > "selftests/bpf: fix to avoid __msg tag de-duplication by clang".
> 
> I tried it, but it didn't apply at all :(

I think it's fine if we skip this additional fix. As mentioned in the
commit message, it only affected one test and that test isn't present in
v6.1. In general, BPF selftests are not very likely to have identical
expected messages because we often include the instruction index in
there. And it would indeed not apply without backporting a few
additional commits. Anyway, thanks Ben for double checking!

> 
> thanks,
> 
> greg k-h
