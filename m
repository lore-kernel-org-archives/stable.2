Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9720B493631;
	Sat, 22 Aug 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439756; cv=none; b=HRdrYXeP0Bxy9NlERB9g29x67GtWJRvf98iZDsmxVsqB1t2piQZfadeQE8fH/HzxSGaevcsT80z5nR3fk2Psps9fXgrQu/T9oMmJOTUHr1sYHHxQ1rQwaummlPXI61bx66aiJPy6hbSMDpR5c/sHpoQGS69KuJBBJ1jghSe6n48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439756; c=relaxed/simple;
	bh=fTpgioSFb9Rf+X01cAvQxmr3MIsacw3PltGOIHbVrro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgJ1SaxuvcghE/97Ihy4LDRIPhcUm573KVCvt4jRVPgzbdgjzijQ39aBBNVSptfa99sLkNcmelwpoNvecELEyYDCaCYc7tRxF761xJpR+xlInk0TMd6WCPV4ThRIQiQ+cvw0kk2eB3kxk7eaJefC1dcSDuxFVsUHKqo1liLy/Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knF+4JKE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knF+4JKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02141F00A3A;
	Sat, 22 Aug 2026 23:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787439755;
	bh=qXBkJK/5t6g1NrZXfIn0JhheJiyLe91f3b6gtxbx++Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=knF+4JKEUnglhMlhkmmKSWx5AmCWpSoEi+5tXJDePs8q54CCYtZzTXwinJh9tWoC1
	 qjiHD73UHxqlUr31uwU7X83716czZ3QhIn9CLs9BYefsXgf5Z35JV/kRWnQvYhdL7Q
	 AuE+Le4Pp4YoL8YqSGZdhZ+M6R21WXrphqL4IAgXOjHcLLsQ654ASUXa2obiLQsGHl
	 FtLHmhENteDsFeL0Un72YLt/zQ9NtEok+IRhsHTs4W6qrvw2M9cIFgcHj4g+9d00M6
	 MAya+UdthnLGKHFk7iF/8eu4C1pL4fTsI2nHq0tibSvPXHejxFxy/2aOz2E++bPKXv
	 CUvczqyRsoSLg==
Date: Sat, 22 Aug 2026 16:02:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, stable@vger.kernel.org, vega@nebusec.ai, Victor
 Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH net 1/2] net/sched: pfifo_fast: cap ring size and
 account to memcg
Message-ID: <20260822160234.7115ccdc@kernel.org>
In-Reply-To: <CAM0EoMnLnc2dtzRyaJs+V6Niq=39OQ=p-XC7M+FMTQ0ctSvmyw@mail.gmail.com>
References: <20260820095742.68511-1-jhs@mojatatu.com>
	<20260822134401.6545e4eb@kernel.org>
	<CAM0EoMnLnc2dtzRyaJs+V6Niq=39OQ=p-XC7M+FMTQ0ctSvmyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 18:14:49 -0400 Jamal Hadi Salim wrote:
> > On Thu, 20 Aug 2026 05:57:41 -0400 Jamal Hadi Salim wrote:  
> > > +     if (qlen > 65535) {
> > > +             pr_warn_ratelimited("pfifo_fast: capping ring size %u to 65535 for dev %s\n",
> > > +                                 qlen, qdisc_dev(qdisc)->name);
> > > +             qlen = 65535;
> > > +     }  
> >
> > Why not a hard cap?  
> 
> sorry, where to put the hard cap and what would it be?
> Or maybe you misspoke and intended to say "why put a hardcap"?
> 
> Or maybe in this case probably safer to just reject the change if > hard cap?

The latter, I'm asking why not:

if (qlen > 64k)
	return -EINVAL;

To be clear I didn't dig into the code, just read the commit msg, so
maybe you have a reason. But the "normal behavior" for out of range
params should be to return an error rather than silently clamp() into
the allowed range?
