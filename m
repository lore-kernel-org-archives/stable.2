Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE072EC09F
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293412; cv=none; b=UuGU9Yn/tNIf4eg5NES83AsMeB6z3zOL8lLNnxD+eGCVckps3/hg95143GEaXj59KuFnDyV8spsMhv65BPGatiBI9rqV7WpPojqgo1qJWQJzHe0v237dyaVLdB6KDYsYz1rreNUdL8YjOpXD+0DpZdmpmntXwJyTNYsk8LdIY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293412; c=relaxed/simple;
	bh=D8CFwLPp5KatUW5AZ7GtpjRwh++f82p7zALAB4npO7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGcJr95NjF4acg1kUxoDM3yU4IF1OQWjXIipvIMx5UkL6HgknQTzFZaTaZjrmQnOCW5BRzlJYrOqS14m3cgk+O4TI4/SX2bRBF2rmm9myWWMeBmfNC3n/+dMgqrrHAJRBnJ89s2t4EQtadeQbR0GbYFBp2HvioeFfluf24GXDp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSH5b1UV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSH5b1UV"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8454c5a280aso1120524b3a.1
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782293405; x=1782898205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=04Y/Pe8XmMfRpuwlfV46g/2VJTxETiC/sRNVRFinUHU=;
        b=MSH5b1UVo9mDNudBLwv/KkdWEX3cM1XrNJwmnVpGpVQgM1cAq5G0oGy1KkLl8DAus1
         6Muo1CLjhv/t+nWaMZSqwqicqUk915yntntUlhQ2VOQQdRdrYReIJ1O+DW+BT+AZxCjo
         PrLswFn9kP3Am34VvvIpK7RWV5ApwYRzknz5ZHaRlQuuf3CXiZrHOBppaPht1S7wP355
         8MvJTGTX9er6c1VYK41UFmH9GCVcgFVrDVR7+cJp++XsV31dkONr/akjr/+tJ6SJDRGj
         b9h+QzHmJPDCjbXH3ByvLkgzWPrfEbynVGYjsR6qLsUriKN4uH660aKgGjwnaM5xq3M/
         I7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782293405; x=1782898205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04Y/Pe8XmMfRpuwlfV46g/2VJTxETiC/sRNVRFinUHU=;
        b=KwEW9mJJMXjGH24cwya5Md4lVBADKwhjtMU6iLTIOIgU8ahwkeUk3v8+XQNDfG3Lz2
         nU3wQj3qd3BBDhWyAWgsU6e4EkXDw3CptJ6Qwrr/7JzkY6RHSfPSRxkV+FABGGGZiMbV
         de46ReZ1c4fRiBbbvE2fJQCKb+6Dh5ia98wHqFDOwQ/E44Qe3ckzxNYIFSkpWdll7Qcy
         3Wx22vXHk1Q8uHwjDu29pJ6FL3T7bHqJlqoWpTicv/mxxfp5dZYHUIwrz0ot3QmLCseW
         HF0oeEm07o847cNdfmbu6QLFW3XZF/aqg6a7ybW8Ry21KEfTPKavAVODaG/g+a/4H20e
         S3EA==
X-Gm-Message-State: AOJu0Yzpu1mO+b687Jz75Q98km9v7wCSg/lG0MhZDApZnNvCb5H6mAgP
	wCebI5jbXiNZXi340OS5PIwvyuY1ku5iiWTCnMFYEVFize0c+jwTz7Yf
X-Gm-Gg: AfdE7cnUvWVK62uw3yJzN9I7agw3EzUY2Qaa9Ja8O/ufjszJPOGJPrYpM2ooLe+aMRS
	sv1xiAz5XM+IlnL5BCrKXD7ujIEUwoTt7NAknvmYw4oEuCYt5jxEBvE0BdRUdIwslveh78bDmkl
	mMi7wrBnqjegoh85E6jVmfmxI3Cgz0zkn8yXCnGuKcCBwB7O7SaZKs5s4wL+UPPse1dGXsGrI+H
	ME2y2DaAjPsTKSPrfLO7XczfE3HNRKMweaZrBVcc/zH9oIjqX5cIgM1MeT5HgeqyLCoG+PHyamR
	Afhe3bSMzcCEfDsjlHGrVKYyxIiNZk8K1x35FXOc7WvRw7yCRbH+8jg3eSBoYjItDhkjwNjbYon
	LGduww5KnX2GbFhNXHoVg/DYqD+abpHGXJy1qLnhIj7dKzv5xzgqgEkb/bXlhe8oPaWtECSk+9Y
	y96rxawZYTZVvSew6TCohym2ytUOBfUzGaCBmgAHOp4jP6IcyfD1YShBokyvIw8WsD6Q==
X-Received: by 2002:a05:6a00:2e9a:b0:837:f111:b70 with SMTP id d2e1a72fcca58-84591b23fe1mr6791752b3a.4.1782293404586;
        Wed, 24 Jun 2026 02:30:04 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fec0f7sm1679883b3a.22.2026.06.24.02.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:30:04 -0700 (PDT)
Date: Wed, 24 Jun 2026 18:30:03 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: Please apply 736b380e28d0 and eca856950f7c down to 6.1.y
Message-ID: <ajujm9+82N1g/HgF@DESKTOP-19IMU7U.localdomain>
References: <ajuR7rZYU943EG6p@DESKTOP-19IMU7U.localdomain>
 <2026062417-conceal-driving-0ebd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026062417-conceal-driving-0ebd@gregkh>

On Wed, Jun 24, 2026 at 11:00:45AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 24, 2026 at 05:14:38PM +0900, Wongi Lee wrote:
> > Hi,
> > 
> > Could the following upstream commits be queued for the active stable
> > trees?
> > 
> >   commit 736b380e28d0480c7bc3e022f1950f31fe53a7c5
> >   ("ipv6: account for fraggap on the paged allocation path")
> 
> I do not see that commit id in Linus's tree, are you sure it is correct?
> 
> >   commit eca856950f7cb1a221e02b99d758409f2c5cec42
> >   ("ipv4: account for fraggap on the paged allocation path")
> 
> Same here, no id of that one in Linus's tree that I can see.
> 
> thanks,
> 
> greg k-h


Hi Greg,

First, sorry for confusing you.

The commit IDs are from netdev/net.git:

  736b380e28d0480c7bc3e022f1950f31fe53a7c5
  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=736b380e28d0

  eca856950f7cb1a221e02b99d758409f2c5cec42
  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=eca856950f7c

They were applied to netdev without Cc: stable@vger.kernel.org, so I
wanted to flag them for stable handling but I send it too fast (before
merge).

I will resend the request with the Linus tree commit ID.

Thanks,
Wongi
