Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B32408611
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742412; cv=none; b=pn+eRKuqgAB5BmkgEPF/c5BioghpdRnTTJ6R8i5C0mXIdjYaZU4MZBGL7cE8OU2HRwpfICG98jJ0zGbQZbTZ4XxAvD59k1+eG/oTUZjbDqE6wpDxISmvXFtgRuMBJqm5HeZFtVhAsf50Nh54boOLSzyY77El3AGm//rHNVxBgfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742412; c=relaxed/simple;
	bh=n2moP8sJR9BhHMurE5j8uV8hEciqqJxPDOsyZT57eT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co8VR+9J7zpfCE1rQjkCE7GNmPgDj/Qu2aAI5zsFMw1RMTnBGJ/sGvPOGtO1epsrjWlnulg9wSqxHuav33lB2L9Cms+g7KCwprssP11hXd0FXfu684bdLdOgZbJR1InRYabQjBcMJekUQhW53TkVc/x/jFeajvmzlTeuYK1kc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fe0zJ3MI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe0zJ3MI"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493a432c84eso14991045e9.3
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782742407; x=1783347207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeFfaIaYuJ4MPfGng2mUHQKnK1lD+x40upFL0+GBvfo=;
        b=Fe0zJ3MIZdeG79AwrWUFe0XWL+XHBFIxSZYDhE+SSYicAyxUvDR7p9KtJAT3Iv3LKo
         mfeyHP7tMNJ1iuhhtq16POCERc6tF5KSPDqqWJc7gO5gqsNymfxa9XYjTq+m3IfkNmC0
         c4R+/kJRsyK7L4zdXGIN19DsdqSxHr2VtQUy+YjaPgauim7kuT6SKugvaQwiy4QNSzxD
         MkA23GUiOMNSv3Ef8NNvn2mVJAMti442+FAq9K1Owhc4MuRDcH/QMkUWCwDMHPufOygd
         BlRDrOCNAzBFuMQjgXJ5+HPOg8aWe323XQlD5fviatKe/2ANyYOyuDjn/nb4t7x1phH1
         2hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742407; x=1783347207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xeFfaIaYuJ4MPfGng2mUHQKnK1lD+x40upFL0+GBvfo=;
        b=LgHX038P8B1eJe2dQDbarp8JO/FedlZPNHhUnG8cXQX82c81hbrbUmasPX9jM6dor7
         07hP5YPDQmNog9gnVZ1R4WROuDeTpnT8CsaphNpX+DTZhTkHS81bg0BpHlc9XZfh12Pr
         b+BGNqzYT2EfAmEnqWNe3lMtNrbzhUFiWNQnrnUeWcZu5JltDtaK2i3JH6kUQitTpklX
         yFLh4bj5lckZpfe8eupmA4i70DKSjR79e7527hATjhGMi5neEint6xu7RCZjQW22mnV0
         ILwp/dxAWVXhHyZwWqZo0f05hSE9RZR5uB1sR1fG+iO/RdhL8jhrn5vCM8ECgSqaM4yb
         nfMA==
X-Gm-Message-State: AOJu0YxolaM3D9627TFfO7UDwJtNTC3sKzaEzWaF9Z3es1Jf9O8jUdRf
	FbGdWd4O2EAe93+LJrJtsSC+dw/3511GY6clavkPbSlEe2tzRBvEm7Zg
X-Gm-Gg: AfdE7cmPd2qeU+5lGZ8RBQMWyy3kM5wABbdQDdybw6dYTKF9z+8d4djYQA083KnMAa9
	D+5lSb3BhF2lKRwLKCWCb4Q34V73wJrAlu79IKdovMix6t7R0hARvXdgSjWNZVu2C5hGhtwVyAQ
	5qtm5LnRNhq4gfMfmio2vnIa6wJ4EJ5dH7wJpxH9Eahfbti9q37J/JFaqNEIG4HoIQgDD72ANKG
	d6uy+mHQBWCF8wbaO6mIb++DR1KMNzA7drvAh+HcQBJ/LItrplhKkApJWYJzh/EnD1kcSew+B5t
	Wpm8paen2OEiDiK6+MSq3zfSzKNXIBgo4gVAmX7HFRBxhdeHqja/bsvERL2db6/rCdwa5Zcwxx4
	HI1gj0gd6Q4IjlELc097ZB0P0loYXNliSkX3IIz4t9xv3G0ne/mMeUy665VI+wnVkCHoT/b4h0X
	+pcCJiaF511UacmCrqKCkx7F3g8W8TjclnQeN0gHHcJz91B2Mx
X-Received: by 2002:a05:600c:a086:b0:492:6954:1036 with SMTP id 5b1f17b1804b1-49269541111mr229190765e9.14.1782742406763;
        Mon, 29 Jun 2026 07:13:26 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47290ed4377sm16140004f8f.37.2026.06.29.07.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 07:13:25 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 026AFBE2DE0; Mon, 29 Jun 2026 16:13:24 +0200 (CEST)
Date: Mon, 29 Jun 2026 16:13:23 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Wongi Lee <qw3rtyp0@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: Please apply 736b380e28d0 and eca856950f7c down to 6.1.y
Message-ID: <akJ9gzZrhXMUomcg@eldamar.lan>
References: <ajuR7rZYU943EG6p@DESKTOP-19IMU7U.localdomain>
 <2026062417-conceal-driving-0ebd@gregkh>
 <ajujm9+82N1g/HgF@DESKTOP-19IMU7U.localdomain>
 <2026062416-amulet-paradox-cf7c@gregkh>
 <ajum4HXbhgdRl6Vz@DESKTOP-19IMU7U.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajum4HXbhgdRl6Vz@DESKTOP-19IMU7U.localdomain>

Hi Greg,

On Wed, Jun 24, 2026 at 06:44:00PM +0900, Wongi Lee wrote:
> On Wed, Jun 24, 2026 at 11:37:29AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jun 24, 2026 at 06:30:03PM +0900, Wongi Lee wrote:
> > > On Wed, Jun 24, 2026 at 11:00:45AM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Jun 24, 2026 at 05:14:38PM +0900, Wongi Lee wrote:
> > > > > Hi,
> > > > > 
> > > > > Could the following upstream commits be queued for the active stable
> > > > > trees?
> > > > > 
> > > > >   commit 736b380e28d0480c7bc3e022f1950f31fe53a7c5
> > > > >   ("ipv6: account for fraggap on the paged allocation path")
> > > > 
> > > > I do not see that commit id in Linus's tree, are you sure it is correct?
> > > > 
> > > > >   commit eca856950f7cb1a221e02b99d758409f2c5cec42
> > > > >   ("ipv4: account for fraggap on the paged allocation path")
> > > > 
> > > > Same here, no id of that one in Linus's tree that I can see.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > 
> > > Hi Greg,
> > > 
> > > First, sorry for confusing you.
> > > 
> > > The commit IDs are from netdev/net.git:
> > > 
> > >   736b380e28d0480c7bc3e022f1950f31fe53a7c5
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=736b380e28d0
> > > 
> > >   eca856950f7cb1a221e02b99d758409f2c5cec42
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=eca856950f7c
> > > 
> > > They were applied to netdev without Cc: stable@vger.kernel.org, so I
> > > wanted to flag them for stable handling but I send it too fast (before
> > > merge).
> > > 
> > > I will resend the request with the Linus tree commit ID.
> > 
> > They have to be in Linus's tree, before we can take them in a stable
> > release, right?
> > 
> > And why were they not originally tagged with the cc: stable?  That would
> > save you time in the future as it would all just happen automatically.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Right, my fault.
> 
> Also I just forgot cc'ing stable when sending it. I'll apply it next time.

Small heads-up: Both commits are now in Linus' tree and included in
v7.2-rc1:

$ git describe --contains 736b380e28d0480c7bc3e022f1950f31fe53a7c5
v7.2-rc1~29^2~66^2
$ git describe --contains eca856950f7cb1a221e02b99d758409f2c5cec42
v7.2-rc1~29^2~66^2~1

Can you queue those as needed down to the 6.1.y stable series?

Thank you already,
Regards,
Salvatore
