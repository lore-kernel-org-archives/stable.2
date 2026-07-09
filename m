Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467AF44999A;
	Thu,  9 Jul 2026 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627303; cv=none; b=XE+f8fYNSYVU1nKaEyYniDth4eHk9E4dJrsB7IlrLPcAVaCSh+X5XPGMx1+sg77HSwk3Of08qZ7H2lvSRU48gR9gMOc3zJ7B6YCUDCT20xZNEJGbgbLT30Tm+gcK2vdN1tMKk0U2mr6y5JW5vn0ho2koPgoekvPH7xIxFDr9d3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627303; c=relaxed/simple;
	bh=CeMM0B0qcj6ewFqS35ZZ/kiWtBn7Q1jqgx2fBeb/gLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skd325xvAK0Z2RGc+8BdrFRT42V2UQpkl2G6gDKK3QO+79pcjXiXIh23yibvuchRXYAoxRO4YCfO6tgoS39P2f0chDcMFWEk/nOjmDkIL+Uk5A2RrMeb5oKw2BNrx+e8tybWzkzh1FF+q9PCbMf1ApQoTH5DeStKulC+h88ODm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ply6acT2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ply6acT2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UAWvgdFAf/8CeLWdRcuD8jP8ushvhPSTsLSESkZgTuo=; b=ply6acT2fZnIJR5eKI4onZSYxJ
	aSr5DWLmCvvE6s00MXXYtv7u7hwCL/ixr/K8CoDVlqZTM99W55pmVZjufq+8V3qO0T1oCkkJ/CidF
	P9h+ZbSCyQ/rZJS1f647PNMhIDPZjemDp4OO9ZIVUPR8nDEp+hfJOhxEsIwteL9Zd0D8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whuvu-00BXx6-J0; Thu, 09 Jul 2026 22:01:18 +0200
Date: Thu, 9 Jul 2026 22:01:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ujjal Roy <royujjal@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Linux Stable <stable@vger.kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>,
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
Message-ID: <14350a31-ffc7-41fd-84d3-6cfb2cb96841@lunn.ch>
References: <20260709101327.9508-1-royujjal@gmail.com>
 <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh>
 <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh>
 <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>

> > > History: The multicast stack currently supports decoding of IGMPv3 and
> > > MLDv2 exponential timer field encodings, but lacks the corresponding
> > > encoding logic when generating multicast query packets.

RFC 3376 says:

4.1.1. Max Resp Code

   The Max Resp Code field specifies the maximum time allowed before
   sending a responding report.  The actual time allowed, called the Max
   Resp Time, is represented in units of 1/10 second and is derived from
   the Max Resp Code as follows:

   If Max Resp Code < 128, Max Resp Time = Max Resp Code

   If Max Resp Code >= 128, Max Resp Code represents a floating-point
   value as follows:

       0 1 2 3 4 5 6 7
      +-+-+-+-+-+-+-+-+
      |1| exp | mant  |
      +-+-+-+-+-+-+-+-+

   Max Resp Time = (mant | 0x10) << (exp + 3)

   Small values of Max Resp Time allow IGMPv3 routers to tune the "leave
   latency" (the time between the moment the last host leaves a group
   and the moment the routing protocol is notified that there are no
   more members).  Larger values, especially in the exponential range,
   allow tuning of the burstiness of IGMP traffic on a network.

Let me check i understand the issue. If the user configures a value >
127, linux continues to use the linear encoding, but a peer decodes it
as a floating value.

128 linear is 0 | 0x10) << (0 + 3) = 0x40 = 64. So the peer sends the
reports earlier than required?

255 linear is (0xf | 0x10) << (7 + 3) = 0x1F0000 = 2031616. So the
peer can send the reports much later than the 255 1/10 of a second
than userspace expected.

What is useful here is, 'maximum time allowed'. The RFC does not
appear to say how to pick a value between 0 and the maximum time
allowed. Which gives us some flexibility.

I think a much simpler fix for stable is to clamp the user space
request for setting the max response time to 127. That seems like a
one line patch.

    Andrew

