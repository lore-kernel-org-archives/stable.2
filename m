Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2D48E0E7;
	Wed,  7 Oct 2026 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369581; cv=none; b=ZCzOJ6GMVeC732BpyeIrXN3GC7h2rURL6GWZGn6IwUkiCfGkPBJYGfKM4Is1WWmmV7XhC68rroO0RTw8CV0WH49FcCDZPYDDzLAENxVFJQuL1PQC98JpGk+02r2xpPPhw2MTu+ggseCZ8iRbxD5EqVV6Y5f6KzAwivml5h/3oD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369581; c=relaxed/simple;
	bh=CQfZ/TTdImvt5pNIBELCOZKxr0fRpDg9Pi4deEYeevM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gJfMx8PAd8t1rmVpGmOhm59d7sTIj2EyAYcv9AdcXHAY2cun8Uic1zlJ0U9lPDFY28PVIE1rDGgHdzwjjvSbxQa9W0VPsAAl54aWMJv0sm2pKB8egvG9p6jiIaswxlTlWAcYP/QB+6K0wloEj0HTcJgo7sEBsyKMvMkgYRZIFwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXUdrVKt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXUdrVKt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791369543; x=1822905543;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=CQfZ/TTdImvt5pNIBELCOZKxr0fRpDg9Pi4deEYeevM=;
  b=LXUdrVKtP0E1Nvgo+OsKuozeiP8fqct3MpGcPvC/h4fJZ9aMtKCv6edZ
   T10BaPKMlUDWi+fx4na8FMqjJYXFu0SEXVI2L9D+1MWyiKKXWZJ6F2q1a
   SjKVQm8Xee0PkXrf3vUgyZu52oTqznM/7D/V1VKtg7a4wccCev4vYJdxp
   P89H4nNOf5DzHPav92bbGhZcXMP+xLjze+8phbqmynF7tZoLuelkOsZPP
   eANFHu3fyWH9rOjxvi/IkiB91Ll+fx1VZnnDQZWAHbQ77K9tXhT0aoGO7
   E1317YgEJezbrv87JIwwUKl751f1NSAcCXBJYJvyKj4qcZ0sc8MxSMqCp
   A==;
X-CSE-ConnectionGUID: rhtqXR7LTTebwh9rFqNBeQ==
X-CSE-MsgGUID: nVxa1k8XT0efWq2WF2xdTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="130350"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="130350"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 03:39:02 -0700
X-CSE-ConnectionGUID: DH09ZgH1QsiKw0+oWsJ08g==
X-CSE-MsgGUID: aJg7S88/QZKU9Rbew1R0Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="33713"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 03:39:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 7 Oct 2026 13:38:55 +0300 (EEST)
To: Hugo Villeneuve <hugo@hugovil.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Hui Peng <benquike@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, 
    John Ogness <john.ogness@linutronix.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v7 1/2] serial: core: fix baud rate fallback in
 uart_get_baud_rate()
In-Reply-To: <20261006112932.3b9c8acd3bc2bfcf1d17b264@hugovil.com>
Message-ID: <8fc5361a-199d-3bab-da86-f967906aa39d@linux.intel.com>
References: <20260930125901.778868-1-benquike@gmail.com> <20260930125901.778868-2-benquike@gmail.com> <2026100156-watch-balsamic-32db@gregkh> <5085df04-f813-8b3f-1d05-87d5bbf00499@linux.intel.com> <20261006112932.3b9c8acd3bc2bfcf1d17b264@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1422937546-1791368863=:1171"
Content-ID: <327f4c19-f0a5-b07f-6ae6-998483d52f5e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1422937546-1791368863=:1171
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <5b29c5ec-9369-89fa-5353-4f0d39a2c56b@linux.intel.com>

On Tue, 6 Oct 2026, Hugo Villeneuve wrote:

> On Thu, 1 Oct 2026 12:46:05 +0300 (EEST)
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > On Thu, 1 Oct 2026, Greg Kroah-Hartman wrote:
> >=20
> > > On Wed, Sep 30, 2026 at 12:59:00PM +0000, Hui Peng wrote:
> > > > When uart_get_baud_rate() is called with a baud rate exceeding the =
port's
> > > > maximum supported speed (port->uartclk / 16), it clips baud to [min=
,
> > > > max - 1] and encodes it into termios via tty_termios_encode_baud_ra=
te().
> > > >=20
> > > > However, because the loop bound is for (try =3D 0; try < 2; try++),=
 the
> > > > loop terminates immediately after try =3D=3D 1 without re-evaluatin=
g
> > >=20
> > > But try =3D=3D 1 should keep the loop going as it is < 2, right?  Wha=
t am I
> > > missing here?  Do I need more coffee?
> > >
> > > > baud =3D tty_termios_baud_rate(termios) for the clipped rate, hitti=
ng
> > > > WARN_ON(1) and returning 0, which then triggers a fatal divide-by-z=
ero
> > > > (Oops: divide error) in uart_get_divisor():
> > > >=20
> > > >   WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_baud_ra=
te+0x136/0x260
> > > >   [ ... ]
> > > >   divide error: 0000 [#1] PREEMPT SMP KASAN
> > > >=20
> > > > Increase the retry count in uart_get_baud_rate() from 2 to 3 iterat=
ions so
> > > > that clipped baud rates are re-evaluated in the third iteration.
> > >=20
> > > What is the magic 2 here, and why turning it into a magic 3 somehow f=
ix
> > > things?
> >=20
> > Hi Greg & Hui,
> >=20
> > First of all, I'm withdrawing my Reviewed-by from this!!!
> >=20
> > Lets hope the submitter can finally get his/her act together and not ma=
ke=20
> > unlisted changes between versions or send non-sense.
> >=20
> > While the code change is still fine, it seems the submitter (or more=20
> > likely AI) has changed the changelog from what I read when I reviewed=
=20
> > this. And the new one is way worse than it used to be so not being able=
=20
> > to follow what's going on is very understandable given the lackluster=
=20
> > explanation that remains.
> >=20
> >=20
> > What you're missing is that the baud returns happens within the loop, s=
o:
> >=20
> > try =3D=3D 0: use new, if baud is out of bound and old is available, sw=
itch to=20
> >           old
> > try =3D=3D 1: if old is also out of bounds, there's the last resort rul=
e=20
> >           towards the end of the loop which is applied forcing baud to =
the=20
> >           accetable range.
>=20
> Hi all,
> is it at all possible that old is out of bounds in the first place?

Apparently it is, given the WARNING above (unless that too is fabricate=20
by LLM which seems well within possiblities given the track record of this=
=20
particular submitter).

> If yes, is it something that should be fixed?

I agree.

I think the scenario here is (but take it with grain of salt, as the=20
information seems to be constantly changing thanks to LLM/submitter=20
failing to keep one's act to together) [1]:

Tested in QEMU against Linux 7.3.0-rc3 by setting /dev/ttyS1 to B115200,
lowering baud_base to 9600 (max =3D 9600) via TIOCSSERIAL, and calling
tcsetattr() with B57600 (old =3D B115200), reproducing the WARNING and
Oops: divide error in uart_get_divisor() on the unfixed kernel and
verifying clean execution with 0 warnings/faults with the fix applied.

So when rate gets lowered, it should alter the termios to prevent what is=
=20
here seem as "old" having an invalid value.

[1] https://lore.kernel.org/linux-serial/20260930041216.155911-3-benquike@g=
mail.com/

> > try =3D=3D 2: loop exits =3D> WARN_ON(1) triggers.
> >=20
> > What we'd want to happen with try =3D=3D 2, is for it to use the return=
 baud=20
> > which is within the loop body.
>=20
> Then should the "return 0" statement be modified to "return baud", and
> possibly the WARN_ON() removed? Then you wouldn't need to increase
> max try?

IMO, the entire loop constructs feels somewhat artificial in this case so=
=20
I'd prefer to kill the loop entirely. But such refactoring is not going to=
=20
be a minimal fix to the issue.

--=20
 i.
--8323328-1422937546-1791368863=:1171--
