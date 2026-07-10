Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099A42A79F;
	Fri, 10 Jul 2026 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783689701; cv=none; b=gD8X49LwXgnoXM1LXjt6JNIA8uZhe/tJ1spE6ELAn/Y11RYOYSuL5Q8j5VcnLY08699nDxJTIjitJ2u+/ZrkmsDHI+2Rn0nOHYEj7jDYjhyLN9yroiY3FdAgz6+Air5aG7Rh5M5fdwv06HRtyDIjtmZ9vxoz3OqN5VsFrBU+KNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783689701; c=relaxed/simple;
	bh=yMV9poYSLXS/3RgppG/pvEj1WqVKNCUnPlsBkB/oi9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeUJ1dFeFstNHcIKamIb8mlJzOPFjrOsIycFO4Z8fU44SWPIza3iQvZW7bszzyfB2Piktq2UgIjVMn9GnenzpqcwbCYRzLezIX6iM7Xp9eLsLzeMHM8PqyQLQqXyBakl8+cy6JryT/+mPa213XI2z6SKRJE+0zE3HvBXoYMbEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qaBxxKPb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qaBxxKPb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=3jUJlmtzH8od6MWoclW18ZkJp5mBapmJ5Ck79kLYAyk=; b=qa
	BxxKPbvfNAoasihDNphVMqkx7RXwLmXxUKcGONp6rFaCvzTG9GJvlRfa++o4RxofPaXT5wzJZLb54
	SYr4FWe5LyQZx4BM8mc8kSnGuKDlRsA6fvydOeH5p/LDpKAdu4Rfx9IWriNht/wKZ5xNJK+YZwSB1
	iRHw51ownvBEFhw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiBAW-00Be2B-88; Fri, 10 Jul 2026 15:21:28 +0200
Date: Fri, 10 Jul 2026 15:21:28 +0200
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
Message-ID: <797773e2-b155-451b-ae97-e8a005fd2d86@lunn.ch>
References: <20260709101327.9508-1-royujjal@gmail.com>
 <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh>
 <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh>
 <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
 <14350a31-ffc7-41fd-84d3-6cfb2cb96841@lunn.ch>
 <CAE2MWknt86W6yCtuS_RupiuwiDqXT8wZqENM2DjiW1R=eY8qdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2MWknt86W6yCtuS_RupiuwiDqXT8wZqENM2DjiW1R=eY8qdg@mail.gmail.com>

On Fri, Jul 10, 2026 at 02:40:39PM +0530, Ujjal Roy wrote:
> On Fri, Jul 10, 2026 at 1:31 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > > History: The multicast stack currently supports decoding of IGMPv3 and
> > > > > MLDv2 exponential timer field encodings, but lacks the corresponding
> > > > > encoding logic when generating multicast query packets.
> >
> > RFC 3376 says:
> >
> > 4.1.1. Max Resp Code
> >
> >    The Max Resp Code field specifies the maximum time allowed before
> >    sending a responding report.  The actual time allowed, called the Max
> >    Resp Time, is represented in units of 1/10 second and is derived from
> >    the Max Resp Code as follows:
> Here I can give you some input. Default value is 10 seconds for which
> the protocol value sent on the wire will be 100. This means 100 *
> (1/10 second) = 10s. Similarly, setting just 14 seconds will cause
> issues. The protocol value transmitted on the wire is 140, which, when
> decoded as a linear value, results in 224. Similarly, values greater
> than 25.5 seconds cannot be represented directly in the 8-bit field.
> 
> >
> > Let me check i understand the issue. If the user configures a value >
> > 127, linux continues to use the linear encoding, but a peer decodes it
> > as a floating value.
> Yes, you are right and that is what it does till now. And the Kernel
> applies same to the QQIC field as well.
> 
> >
> > 128 linear is 0 | 0x10) << (0 + 3) = 0x40 = 64. So the peer sends the
> > reports earlier than required?
> No, it is not 64. This becomes (0x10 << 3) = 0x80 = 128 again.
> 
> >
> > 255 linear is (0xf | 0x10) << (7 + 3) = 0x1F0000 = 2031616. So the
> > peer can send the reports much later than the 255 1/10 of a second
> > than userspace expected.
> Yes, you are right. But the calculation is incorrect; it becomes
> 0x7C00, which is 31744.

Thanks for correcting my maths.

> > I think a much simpler fix for stable is to clamp the user space
> > request for setting the max response time to 127. That seems like a
> > one line patch.
> In mainline I encoded the value according to the RFC. We can clamp to
> 127 in stables, if we are not willing to take the entire series. This
> will force user to use value < 128. Also, please consider QQIC; a
> similar encoding issue persists.

It does not force the users to use a value < 128. You would need to
return EINVAL for that, which i'm not proposing. Returning an error
could break user space.

By clamping to 127, we don't break user space, but we do avoid the
kernel bug, and at least to my superficial reading of the RFC, we are
"language lawyer" compliant with the RFC.

	Andrew
