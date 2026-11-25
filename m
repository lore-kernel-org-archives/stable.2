Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627597;
	b=g6woxF2RNVBuZK/5y7kutNdp0AnIzNBddEvrdcdYACY73fN7G9l6cQ9PknvqHFpRiagG
	 WdbAeE0Dlz2Nfi4R3H1QHkllYdzGZ6D9dPM1wmpTm8f6k4bRsLQumDoCfjA6LfjQd6R59
	 y2lJ5ac+Op4FA8RmtzxBiBBHdRVsmkJcweFllu4KnYDGWIDXXpDWL67ZzIf7rcBGxpxGH
	 M2RAYvCwCZxOaqBXDjmJY/CoFid2s3XrZBhjwbVf70XONbeVO+WWPYTSWNWRakgbY6XMP
	 iznvWDFP+kMi6noL763nbJttjd2xodnSMEjxZfy0JhPw3fzzrATRHLdQ3jnrxto5dpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627597;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=+kcgLCIB0c24wlzMsfmh89I7nogKlK+/Ldltxbk2hOc=;
	b=Wi1aQq0EO35gaXtqj7sUg6Kjp0BI53jOgzyJ3F/VUjFCeb4RFuwy7WEB7Cx0qcWJRRk2
	 ztjiLDEGv4YbhWpym/NjIw98yYdHOYtcQZ41TWqWk8m5ATgTvFYsr/HPJZzhZwmSSmTGN
	 hP8kCnhlE510BEkqxLrb9JlvdBpBy7we7pWF/17EBjA/+akyK5cD8Sj1eelW0F/yGfPJN
	 VLNsltpMaVYmMndn12zbEDeZ8ETwRQghJLu3cKHVXoKIqFOwUB/gaXklO0xX+6cmbhrMC
	 J3s8kqF3TvaWGhXMXcF3TERxGX69BMHgg/1WIuK0NeRETBzVUYe9M0FpTvRjAHX/GyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="nu/Uopsf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC15606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nu/Uopsf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5371F000CA;
	Wed, 25 Nov 2026 17:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795627597;
	bh=+kcgLCIB0c24wlzMsfmh89I7nogKlK+/Ldltxbk2hOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nu/Uopsf9biNlYt4IG9WgD5k1vRWkoY0P165VCxEJFKGBgT+fEoE5BA0nVbpSitwF
	 BDTUw7MpAuDGdEiuirCvAIV726mY0/VlIscyUWIDjhwi/zUGS9LQLX8GHRCLw6e/Ob
	 R33ZltbJ2O9viJYiZsVCpZHw5ITflJ3E0Wg/AdKM=
Date: Wed, 25 Nov 2026 18:26:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, cve@kernel.org
Subject: Re: AI tools for CVE backporting/Fixing
Message-ID: <2026112521-comprised-attic-3f9e@gregkh>
References: <CAH+zgeGo9V_DRG_2yRAEw82bk6SMsV_JRxSOM28p7q02oTKE9A@mail.gmail.com>
 <2026112521-paramount-panoramic-2531@gregkh>
 <CAH+zgeGEXm2crJT+gENkckm0o2xAACXHj4Lf4vxTD_nUXij4Hg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH+zgeGEXm2crJT+gENkckm0o2xAACXHj4Lf4vxTD_nUXij4Hg@mail.gmail.com>

On Wed, Nov 25, 2026 at 10:49:19PM +0530, Hardik Gohil wrote:
> On Wed, Nov 25, 2026 at 10:41 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 25, 2026 at 10:23:33PM +0530, Hardik Gohil wrote:
> > > Hello All,
> > >
> > > I was wondering if anyone is currently using, or is aware of, AI tools
> > > that can help with backporting kernel CVE patches or identifying and
> > > fixing kernel vulnerabilities.
> > >
> > > If you have experience with any such tools or recommendations, please share.
> >
> > Nothing special is needed, what have you tried that did not work?
> 
> I have not tried any tools and looking for recommendation particularly
> for kernel CVE's

I suggest you try just about any of the coding models out there and see
how it goes!

Or just do the normal backport work, what is keeping that from happening
now?

thanks,

greg k-h
