Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6021F53D9E0;
	Wed, 14 Oct 2026 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988253; cv=none; b=VwTXOMBP3n7mKbaD/dd4DDhF7MdnPnlAEe1hTuJuJfcYfhSP4h2TBNpGeZSLl33yKt2edYT1+o2az0U+/zyuGjoxtlw465fs1bbJf+meFvgMkZi9LVUwkdZoAdQnKrltW0UZ8KekUKL9l5YAQaEz+0shjXEyjMWF/ToaBAxruRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988253; c=relaxed/simple;
	bh=fMBeam/zOOgKWNtCnDtUC7mnmy/TtsBEDUY4nS0LHGA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=tsR1X3CLuOvWKAePrJNrDb31SE6GlZEIqEeaFiDmGEMyK66zBjr91PWqjFR9vxOpG93+xtHDaHFLq23hPwvGx+GYt/XAPpXFGkFMZHQy+K69tQKVbqHPyDnu5fpT2l3AqAUHx6gcNtaCVn3U8RYiNQH9YxW+e1N7SfCdCnhcvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUwHJa0K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUwHJa0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CE31F000C4;
	Wed, 14 Oct 2026 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791988251;
	bh=dKfIAC0YXO8UqRJ28sEGEIpaahHp44GZxTk9EsGyPsk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=TUwHJa0KsNAWxA1Uu0qoMNH4UlCHKBky1cH+SPuj28RAsBRrNeC3x+tEAoMCyMTUK
	 GY6TubNY5o9CffmODMx34dKmc7WlJC8ukJDPIPZtAkdyZSvmqmzznLxS5VRI/Lj4b4
	 HV7Pp75YOi3VC3sctDZkLB13ogKsVtAIQHqW9776bekes9xf1ltZAHwHGrsDAl5aAo
	 iwzGEdZ+lbMm0l1WRtFY06LKip3eSjlPs/s9cehn2W7yy9482MuCtbjsy5Vxoxexfp
	 4ru5WHuB+Q+AZd8SWDQ/l1rNo0FEbRWwWtRs7e+/BG5bH+D+RitYBvCE2WY4EsTorp
	 3/2nnZTyRqpgw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 16:30:48 +0200
Message-Id: <DM4MTGIILY95.YZSDZOIBBZZT@kernel.org>
Subject: Re: [PATCH] driver core: take parent lock on deferred probe
Cc: "Johan Hovold" <johan@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 <driver-core@lists.linux.dev>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Mario Peter"
 <mario.peter@leica-geosystems.com>, <stable@vger.kernel.org>
To: "Alan Stern" <stern@rowland.harvard.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261013140615.1226992-1-johan@kernel.org>
 <DM3WA69YX6WE.2Q4DY9MIU7A0L@kernel.org>
 <ba24846a-7403-4bb1-a0cb-869cf1d44e05@rowland.harvard.edu>
 <DM40HVOBKMFI.3W1DK371ZWI80@kernel.org>
 <9803935c-11d9-48a0-8d4c-95c478a724a8@rowland.harvard.edu>
In-Reply-To: <9803935c-11d9-48a0-8d4c-95c478a724a8@rowland.harvard.edu>

On Wed Oct 14, 2026 at 4:38 AM CEST, Alan Stern wrote:
> I was going to suggest that the driver core could acquire and release=20
> these extra references automatically for devices on a bus with=20
> need_parent_lock set, but it looks like that can't be done because the=20
> bus_type might not yet be set when device_initialize() runs.
>
> However, is there any real reason why the driver core wouldn't want to=20
> guarantee that dev->parent will be a valid pointer up until the time=20
> when dev is released?  For every device that has a parent, not just USB?

I'm not sure we don't have any cases where this would create cyclic referen=
ce
counts.  Like with the kobject API, the separate device_del() step would br=
eak
circular reference counts.

From a quick check ALSA seems to have this cyclic topology.

> On the other hand, there's something a bit weird about this whole thing. =
=20
> The problem arises when you want to probe a device whose parent has been=
=20
> deleted.  Isn't there some sort of protection to prevent that from ever=
=20
> happening?  I mean, doesn't deleting a device imply that all its=20
> descendants have been (or are in the process of being) deleted?  And of=
=20
> course, deleting and probing are mutually exclusive -- they can't race,=
=20
> right?

Yes, that's what the dev->p->dead check under the device lock protects agai=
nst.
But the new code accesses dev->parent before acquiring the device lock and
reaching that check.
