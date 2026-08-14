Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6656346E00C;
	Fri, 14 Aug 2026 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713350; cv=none; b=bsgzifKHVfr3q1MQ7UzcB6VMHb9qFYsQsIEhdUVXzc0tLxHnqWUEx70EwjYnRuO5G0OvCZ+qkJp6ssgBIIiOIC1Pv6Baw9Fd7YPlO5nrULgN8nXT/dx0A4B6wPMwhO0O4vcdX6uOu26av2TAi881YuIIS1KfLfPAyON7koauwn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713350; c=relaxed/simple;
	bh=9bZLUknVVSQr+/jN71YLE/+fUkjzQfTgf4/RHci1fIU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eoh4Jo+EPdped7wj38Xu/8zzJehpvvDu18mobLAlzcb9QW1WpWw6pvyxahS1LsSJudLCT7MHCts9rL/zON7a1f//aRNWt3b7KeXIihCnGgJLXuyu3kSnrHGFxfblwtFsYGvcKhLcjMDnu1E/Pu9dtCLaG0Mu5trMcoqQF0QVQlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=xUP/Ge8O; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=kpvyJB42; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="xUP/Ge8O";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="kpvyJB42"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 67EDExGg017734;
	Fri, 14 Aug 2026 15:15:04 +0200
Received: from lubuntu-18.04 (host-80-183-189-234.pool80183.interbusiness.it [80.183.189.234])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 405BB121689;
	Fri, 14 Aug 2026 15:14:54 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1786713294; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9bZLUknVVSQr+/jN71YLE/+fUkjzQfTgf4/RHci1fIU=;
	b=xUP/Ge8OIgeFwydRaQSsKgEMZ+Y2EJnMflXA9FygP5FBZjIrtoLc/HRnWCS0BnJGoK2sWU
	oiz0tpih8pVJdAAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1786713294; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9bZLUknVVSQr+/jN71YLE/+fUkjzQfTgf4/RHci1fIU=;
	b=kpvyJB42Z173z5Tr4c2R9H4hbNLU5BQ3c22rlSdk7iwKa2sdJUD0bj9WgEiHJ+BjJPXxac
	Ov4MGq7RScWsxClN5JuSErMPJeOMff5I0xLsABm3+BGbMXPQAnwn6MM+bgl+2icHDXS0mS
	guJwXcsgA6CvukMj7SqpRlQl00/YQ0D97kwvfsUC/xc8OKU0grmafCVXr+Y5BN9qqMRBp0
	i8LMDhBh4raRHk6NNX+LXNfIKF8v3gUEBgrxM0qRittTdFPfNBS7SsLmpK94jA6ZubfW+O
	S5EWa1MTcbxukTRRvo+p/3EX3gttifZdKwXi+gW+ljLK3A0Qy9xYMcZuCh00hg==
Date: Fri, 14 Aug 2026 15:14:53 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Xiang Mei <xmei5@asu.edu>
Cc: dsahern@kernel.org, edumazet@google.com, netdev@vger.kernel.org,
        bestswngs@gmail.com, justin.iurman@gmail.com, alex.aring@gmail.com,
        davem@davemloft.net, horms@kernel.org, idosch@nvidia.com,
        kuba@kernel.org, pabeni@redhat.com, stefano.salsano@uniroma2.it,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v2] ipv6: rpl: add NULL check for idev in
 ipv6_rpl_srh_rcv()
Message-Id: <20260814151453.4d45d5af5fd7bcecf0e0dbdf@uniroma2.it>
In-Reply-To: <CAPpSM+RCXzepVid2qnPky33Sx4j4uy-gWZ74UuG6E1k3pGsKeg@mail.gmail.com>
References: <20260521200859.816b8923b5f27bba6124461e@uniroma2.it>
	<20260814052541.1198373-1-xmei5@asu.edu>
	<CAPpSM+RCXzepVid2qnPky33Sx4j4uy-gWZ74UuG6E1k3pGsKeg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Thu, 13 Aug 2026 22:31:18 -0700
Xiang Mei <xmei5@asu.edu> wrote:

>> [snip]
>
> Sorry for my English. I mean, if you agree with this patch, you can
> take it (it's based on the proposed version you mentioned).
> You don't need to follow our version of imp.
>
> Thanks,
> Xiang

Hi Xiang,

thank you for testing this and for the kind offer.

I will go with option (a) from my earlier reply [1].

I will send v3. It is identical to the diff you posted, so what you tested
is what I am sending. If you want a Tested-by on it, please tell me and I
will add it before I post. Otherwise you can reply with it once v3 is on
the list.

[1] https://lore.kernel.org/netdev/20260521200859.816b8923b5f27bba6124461e@uniroma2.it/

Ciao,
Andrea
