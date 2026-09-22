Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD333C1B6
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037756; cv=none; b=loIkGf6wNIwLNHx0LBWGvH+aROxodfI5LXice+XECkwjofORlmyjZBv/xXwIe0/S0HXKkK7rvSBlK9EDHRAzArINInXL2cEpMPJo8B5u3rk64uNdvLuAY6ZPl4xL+9XKA30ajgigpJ2T+Oz9tIcnL9MZ2ssq6Eo1K4suJ/VIiQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037756; c=relaxed/simple;
	bh=UC+u28CzOknk6Bl7uM1FB1PHcM9TThDpGwcLmDudxdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRBkV5C70FpaqEjXUlJf/KfjaXm81l6LjzKc5K4fnS1O8IX0arvIFCpPBPMl/VqvSxSZjbpyj+UKLNiF7TV1a5COz8Fv60r3z2cbQQDAlDwWm94dgIvcFHXKlAtWS46gjamVvvIOP7RG7fEr8e/+ldGKltPHImxxn1vMCOjn7+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6Kki+37; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6Kki+37"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469d20963so2327001b3a.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 17:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790037755; x=1790642555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2fzEHL3uGZbVafqnyo5a33w4pQPCPZyrCo11bWJZYaQ=;
        b=Z6Kki+37+A40nlmMETK9hMq9rb7I1FUBttJ6hjzzRIgFu20p75+ZNRPaYTjqOuIJa8
         32htA9hQEEfUoVKqZCYMiAiWwirBrGvLkelIqZH8A12Scp3Ukv2sk1QnGPQt13tAr9gl
         rGLN1sL+kOcoYReQXw3QV8S+7yucL6hckS27nHipNGzBtALYHNAdScNBZzX6Zv3IpYcq
         3WiJbdbiYhCoUAY1KwJ0xDhgc0O6D3SI2Pm2JOONpUULhtIU67SvLIx685Loh00mSRh3
         WxT2Eupfz2uLurCBE7ha33gYvO5OJ7rMX3We639XwwX/2hcGSjzcyZY4pyUMaygR9QlD
         utPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790037755; x=1790642555;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2fzEHL3uGZbVafqnyo5a33w4pQPCPZyrCo11bWJZYaQ=;
        b=NrH8prq4uT2Rwu82ZqPzDPa5qmaqzkVIMQKcLOg2GddEnwhp0Pa2ge44c1zkYUKpEI
         DmmLDRk10pDSTNZvZVPN2RmoLsceiSA3sEtFnE5jYEVXRra9i87IqPVssQ+8BIVARHiG
         xbdEIA3fi9HZVVJnZPwpi8MmSbZ7OcuNvopiWNJo0foxf6NLBofu5R9jIFI8sAYLo21b
         6E34ia/9CdnoL4N39RR4g2UiiosUEaRxoLW7/SWMJMjwrHyZteSfDNDutkE4JWkmpV5G
         bWpyExhexOZvhDNzZ3LwxT6Vpg3ctirHxpgGWhIHuPovMa315P/ytiSIEim7z7wOOlSu
         MZfw==
X-Forwarded-Encrypted: i=1; AKwUvByWkivMbNYU0lhnZVGg718n5esTHWj7HfqAUPqU6d1Lnqb6k9gl/nj3kOm8bWMF1G6i2agM77E=@vger.kernel.org
X-Gm-Message-State: AFuF++kwDc40c0qNZPTw+Uv3vKp7IHGIPXT3A3JYkELMnsN0FWKvy5x1
	9KeGZvYuE/HUlGuDwoPe/0k63gQqnNvA3/lmcI/lFY8mXkw/Mhmdjx3z
X-Gm-Gg: AYBFou0fGhvKCl+c7I1LImB+tlwR/XgLk808ScPBy5Jh+lMgFMNStjeV4eL55FytIu9
	Km8uP5ckGTp/Z7bmHAafxIK6UM0vx/6oBMHt9cDt5GO+EatoB2JzZVujpqgP/t73+pg7a4SO0Bn
	4ebNoxgxADNHjjvIuzjC4cDam9dE1qPWk1ApGfeMMIPP7KK9MUjHr8THpqRDJ2L3ISr4En9u8BX
	tq4T6hCba9MU5vJiJ9iYYbI/fzDOZzZGguHXA2rPfQO5rNDjMr+JnJ5P50B1D7fNqiaiAYoNxoU
	yYBNcFgunETdKfpaWaHziz00sv626IkN+Gb4/wEuq1aKjA7oh+3kNRkH8maCFd4w6rgiuDuk1ym
	JZMXunIOBfxqgJMNOspA6qKDRRrnV5+Vzz3K2Nj2ioqDdO10JNA7zA7ogiS2i+p0Xf3Wc1a83Hl
	Cq1w7kKZ3LcK7bVRELvszCBTexVxkNOlA5m28dGvO/+fZ9zKrAwGTQXORt6I8IjftjEuPzSt05T
	LTv2luz9GpsukWNRg==
X-Received: by 2002:a05:6a20:6f04:b0:3dd:a195:fa15 with SMTP id adf61e73a8af0-3dda195fd21mr13316377637.58.1790037754689;
        Mon, 21 Sep 2026 17:42:34 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756a18d4fsm18626a12.11.2026.09.21.17.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 17:42:33 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:42:28 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH v1 net-next 0/2] net: Disallow buggy TCP transitions and
 IPV6_ADDRFORM.
Message-ID: <arHO9Pk2DBzVOTLV@v4bel>
References: <20260904033543.2635540-1-kuniyu@google.com>
 <aq28mdNpi3ssjgXz@v4bel>
 <20260919142035.4d0e11a8@kernel.org>
 <2026092048-splashed-trespass-d2da@gregkh>
 <20260921102310.49c9e008@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921102310.49c9e008@kernel.org>

On Mon, Sep 21, 2026 at 10:23:10AM -0700, Jakub Kicinski wrote:
> On Sun, 20 Sep 2026 09:45:14 +0200 Greg Kroah-Hartman wrote:
> > On Sat, Sep 19, 2026 at 02:20:35PM -0700, Jakub Kicinski wrote:
> > > On Sat, 19 Sep 2026 07:35:05 +0900 Hyunwoo Kim wrote:  
> > > > What is the plan for stable backports here? Does the uapi change rule
> > > > this series out for stable?  
> > > 
> > > Not super well defined to be completely honest.
> > > My gut feeling is that we should wait for it to reach Linus, and ~rc3
> > > then pull it to LTS. Which would mean 2 months from now (mid Nov).  
> > 
> > Once it's in a released -rc, why not have it backported then?  Why wait?  :)
> 
> To be clear - it's in -next right now.
> 
> > > That said, I am personally pretty unbothered about local exploits.
> > > There's too many of them. And because of the serious exploits
> > > (remote, VM escape etc) I think people are not deploying stable
> > > much more rapidly and with less testing. I don't want to inject 
> > > a de-feature under such condition.
> > > 
> > > Adding Greg and stable in case they have a stronger stomach.  
> > 
> > I like to see the stable trees match Linus's whenever possible,
> > especially when we have known bugfixes.
> > 
> > > Also FWIW I believe that Eric D is AFK at the moment, and he's the only
> > > netdev maintainer subscribed to security@, AFAIU, so y'all may be aware
> > > of more things than I am...  
> > 
> > Not any more aware of anything other than the normal flood of crud...
> 
> Okay then, I think we should just wait for the merge window,
> and reevaluate if^w as new bugs show up.
> 
> Hyunwoo, if you have bugs in the queue that are solved in -next
> I'd hold off on sending the fixes unless they can be triggered
> remotely or from a VM.

OK, will do.


Best regards,
Hyunwoo Kim
