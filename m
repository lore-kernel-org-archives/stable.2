Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57941285C8B;
	Wed, 12 Aug 2026 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493640; cv=none; b=HXoQArKr74yQ0/kfH0KSWnVL15ym2LTgBONimmmnZMH9sIq3brCUqX2cZKx3DOmfXE954Ix0QY62epjWDRuD3OcCbd/dRe9lY2BByvqp71C/D3D39gvkWVucJVS1E70gvwX5XP2XmSJkyodnM4FuyOdEtX//pb19cPQNrmVCRXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493640; c=relaxed/simple;
	bh=Vrre/c5A7Wz5bRLO6riBq6PZZObmEldb/gAeCaQKYFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXOmn1ViE9VDI7WYFCQuIr8kp4hT9+v/bxDEubd9M3DTN4FUxSBOrrQ1Td8oVdTEZXTe9bVL96nGIslp9tGYq1j9wZ0O3XRmnDIRNyu76uWXQwTRxhCLoj2MGV6xK6Zl5TxMOvzoHvMONL/EYQK8NRnqLuC3AJfeNooH5/uyz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YcQXNkR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YcQXNkR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD1D1F00A3A;
	Wed, 12 Aug 2026 00:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786493638;
	bh=K906TWK3NX4+ZpiFv6QQYIMRy2gKRZnzgTB4Few++Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YcQXNkR+vw9/ibatGK4jbM+armsihiYQcgu0F8rBYfWGFc3ssBu9PAHUsf3+YcUB2
	 V2kjLAJ6wOpgawDKeBuGyQHgdNGOJtUtLH5tLrN0atHfblBZ6+RN44V6UjPxWc+2hI
	 WhLndLDlrVN6p1nxN/dUFF0m1xMsry/Le1sdMIcE=
Date: Wed, 12 Aug 2026 09:12:26 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	George Zhang <george.zhang@amd.com>
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
Message-ID: <2026081216-goon-nicotine-6d62@gregkh>
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
 <2026081106-pebbly-cahoots-37a7@gregkh>
 <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
 <1caea72e-b9c8-452b-a3ff-5690d948b4fc@gmail.com>
 <2026081151-reabsorb-calamari-7442@gregkh>
 <8a0fad2d-788a-403f-a880-2f97c6708275@gmail.com>
 <CADnq5_Pb=ox3nWfdpb3Qeo_eSQayuc7UqUOnm0x+WS+EQTVWjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Pb=ox3nWfdpb3Qeo_eSQayuc7UqUOnm0x+WS+EQTVWjA@mail.gmail.com>

On Tue, Aug 11, 2026 at 01:25:14PM -0400, Alex Deucher wrote:
> On Tue, Aug 11, 2026 at 11:25 AM Sergio Callegari
> <sergio.callegari@gmail.com> wrote:
> >
> > On 11/08/2026 10:08, Greg KH wrote:
> > > We aim to be "bug compatible" with Linus's branch, otherwise the
> > > "pressure" to fix those bugs goes down.  But I defer to the maintainers
> > > of the code involved if it is being worked on, and they want it
> > > reverted, great, we can do that.  Otherwise we prefer to leave it as-is.
> >
> > I understand. Sorry for asking about things that might be obvious to
> > most people here. My expectation was that only a selected subset of the
> > patches on the Linus' tree were to enter in stable, so do we really need
> > to have stable "bug compatible" wrt this bug? The original behavior was
> > not free of issues, but they were rather minor (a reporting issue). Now
> > we have this very bad behavior where the display remains dark.
> >
> > To make the matter worse, on systems that have encrypted root the screen
> > remains dark also on that password prompt (observed with plymouth).
> >
> > In any case, I managed testing 7.2.0RC7 and it is fine again.
> >
> > Looks like the Linus' tree has more changes wrt backlight, and the
> > interesting ones are probably those in the cumulative fix
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=973fd9493ec21f12e760fbbedeb7b0b2317c02f4.
> >
> 
> Thanks for testing.  It sounds like we should revert the change from
> stable.  There must be some dependency we are missing in stable.

Great, can someone send a revert?

thanks,

greg k-h
