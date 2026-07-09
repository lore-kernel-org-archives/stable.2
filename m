Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9802F1DDC38;
	Thu,  9 Jul 2026 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601606; cv=none; b=V9fdo/NqmdxOoYso1vakEAARyziysGgtsGOic4t+TYjpGDIYEcaI4sm9Oo/lG2474BHME/IE+9qGxdh0N/2MegrRGCzC12v/jFJLEmkeLufSgoJGHH33oCamMt1XYZ+O4RHDLBHxZVBGy40Iku/BfIBsNPrxNpqnzzKQyJjEMvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601606; c=relaxed/simple;
	bh=Gks40DwTF7lpnNGUWCq6Su2IsxFpLdIIk05dTz1WGzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+64z+egBnV3vwpOh3AOKbDysDf02OoufHm4V8h28PFmQfuIDzbuNamVIKtKnfGL8g+t3Y1DWl7L6jEpAY+4jgHyAaYua/tRISMoSOcNcE2EfekWKPdhlfXR4NLmb/L4cwycwevoCRYzZ/ri4gVY5dlTUmXc1cHDk6ymraUoDQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TfPkLmUg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TfPkLmUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C82B1F000E9;
	Thu,  9 Jul 2026 12:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783601605;
	bh=LqGl0ixyq4SH9RTf2iFKxtFYd+p29Yp4u/jnU1NbX74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TfPkLmUgTqMzB9VMEz8wZkp5JPfZpRCHBRWfkD4BQrmLjXeEmDDu7lAsvCleKXWQC
	 5SZCrv0py30AH/ppfaki1zJ4ZCaDA//byzamlddmG4nWlUybQxxNeRIDV6xKV8CR+w
	 w8k6cpM7nKgYMcN1R+PO8atjiG9o6XlfCBv9IPDQ=
Date: Thu, 9 Jul 2026 14:53:21 +0200
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
Message-ID: <2026070954-activist-left-8303@gregkh>
References: <20260709101327.9508-1-royujjal@gmail.com>
 <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>

On Thu, Jul 09, 2026 at 06:12:40PM +0530, Ujjal Roy wrote:
> On Thu, Jul 9, 2026 at 4:34 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jul 09, 2026 at 10:13:27AM +0000, Ujjal Roy wrote:
> > > Hi Greg,
> > >
> > > Please consider backporting the following bridge multicast fix series to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.
> > >
> > > 726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation")
> > > 12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
> > > 95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
> > > e51560f4220a ("ipv6: mld: encode multicast exponential fields")
> > > 529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encoding tests")
> >
> > Why is any of this needed in older kernels?
> >
> > And 7.0.y is long end-of-life.
> >
> > And why, if this does fix issues, was it not tagged for stable to start
> > with?
> >
> > thanks,
> >
> > greg k-h
> 
> I already explained this in the email thread, "Please backport bridge
> multicast exponential field encoding fix series to stable kernels".

Sorry, but that's not here (remember, some of us get 1000+ emails a
day.)

Please explain why patches need to be backported when asking for them to
be backported.

thanks,

greg k-h
