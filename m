Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372221E098;
	Thu,  9 Jul 2026 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606947; cv=none; b=G3TcFU1Osv+KJs6twasILJhXc10im7p99+1DPaaSj1VqIScpKEzOrdbLFXHsxi3TFs0Ebxo2O7KAYFBLnnYxTafi/QrZSVMl7WvHxLnCV/GrLi2RhdaDi7SlHeiFJ6bCWNmSS+pAfY+9i2I4GV/BXDY3yEgVaBBx0dz9/fihTGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606947; c=relaxed/simple;
	bh=s5381n1trsYscNMAirkC5WSZZqb4jbYbyDzi7jZd+i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JK9eRW9u8fGNwJNenAALNVwYXaIQhy7cgBI8IDNhC04SqXerNsUnMWpJrkDpmjnNyQtJ72uer9PvbBBPnJcpV+Sz0yjHN9CzzCAK6lK1Z/TxARj37S2lTcT0nbC/tIiu5yer/7fyiLK4EK4pm+rGfxHk3N77E7QYxgOkYPu976I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pFzKKCK5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pFzKKCK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD191F000E9;
	Thu,  9 Jul 2026 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783606946;
	bh=sgXrUQkmCDVtsWqbs4V36y920B23PeNjLAPQUUnUwSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pFzKKCK50fniSEB/52TnzsE7Y/2SpWWP6em9d3vP2BEHEmEj3+MV3JwnxQf/HEW7+
	 U/WJYzKqpGVDIM/X54k4uzuKgKhdOM4e9u7NyRsQZenH99C8Ubob7KbEubRB6VBuEQ
	 3jHXrHn5955OALFjxDieS0cZ/g+fednSXu/4O/J0=
Date: Thu, 9 Jul 2026 16:22:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ujjal Roy <royujjal@gmail.com>
Cc: Linux Stable <stable@vger.kernel.org>,
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
Message-ID: <2026070948-lively-exchange-a458@gregkh>
References: <20260709101327.9508-1-royujjal@gmail.com>
 <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh>
 <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>

On Thu, Jul 09, 2026 at 06:35:04PM +0530, Ujjal Roy wrote:
> On Thu, Jul 9, 2026 at 6:23 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jul 09, 2026 at 06:12:40PM +0530, Ujjal Roy wrote:
> > > On Thu, Jul 9, 2026 at 4:34 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Jul 09, 2026 at 10:13:27AM +0000, Ujjal Roy wrote:
> > > > > Hi Greg,
> > > > >
> > > > > Please consider backporting the following bridge multicast fix series to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.
> > > > >
> > > > > 726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation")
> > > > > 12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
> > > > > 95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
> > > > > e51560f4220a ("ipv6: mld: encode multicast exponential fields")
> > > > > 529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encoding tests")
> > > >
> > > > Why is any of this needed in older kernels?
> > > >
> > > > And 7.0.y is long end-of-life.
> > > >
> > > > And why, if this does fix issues, was it not tagged for stable to start
> > > > with?
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > I already explained this in the email thread, "Please backport bridge
> > > multicast exponential field encoding fix series to stable kernels".
> >
> > Sorry, but that's not here (remember, some of us get 1000+ emails a
> > day.)
> >
> > Please explain why patches need to be backported when asking for them to
> > be backported.
> >
> > thanks,
> >
> > greg k-h
> 
> Sorry for breaking the thread. I understand your point, I will
> maintain this in the future.
> How should I send the patchset that addresses the conflicts on 5.10.y
> and 7.1.y? Shall I send the conflicts patchset as a series via a
> different thread or how? I've never done this before, so I'm asking.
> 
> Here is the explanation for why the patches need to be backported:
> 
> History: The multicast stack currently supports decoding of IGMPv3 and
> MLDv2 exponential timer field encodings, but lacks the corresponding
> encoding logic when generating multicast query packets. As a result,
> query intervals and response codes exceeding the linear encoding range
> can be transmitted incorrectly. This can cause multicast queriers and
> listeners to interpret different timing values, resulting in protocol
> interoperability issues, membership timeouts, and premature multicast
> group expiration.
> 
> Testing: The series adds the missing encoding support for both IGMPv3
> and MLDv2 and includes selftests that validate the behavior.
> I backported the series to v6.6.123.2 and verified the accompanying
> selftests. The selftests fail on the unpatched kernel and pass after
> applying the series, demonstrating both the bug and the effectiveness
> of the fix.
> 
> Given that this is a protocol correctness issue affecting multicast
> query generation, please consider backporting the complete series to
> all applicable stable kernels.
> 

But this really seems like a new feature being added, it's not fixing a
regression of something that previously worked, right?

WHy can't people just update to the latest kernel release to get this if
they need it for their environments?

thanks,

greg k-h
