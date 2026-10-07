Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135752D2381;
	Wed,  7 Oct 2026 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403777; cv=none; b=KWjLuLFRbk3yDgGH6r6B12t/VHWzz0keZXAd3jGi/pgp8qveqc5DmymXFNRaYEi/WuRaFPjML3rTB63EW7FZXg2CfFE9zaPQ53uD/Lu/PIWYOg4VJlgGRxG7bYT0T7IJY1BS3+6cKXqJZwbCGvCSwBhoJHNEBGLOPmjQeBzSxWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403777; c=relaxed/simple;
	bh=fYLJEJcwKgGPopEORbNrWszT2SB69WTLxu0Bze7Nzx0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RSh5EIZDy1FqWxFaq7z5Vh5R+C1DZS67TF2Kq/+Z4fUspTqVVnXVmYDqpmJRFPhG5fS/kAxW47eYaleAkzlnq99yWS8BJVt5Zd/GXpN4TGAoPiAtpgchL9oqrNCsgEQ9EoPPtXQ0Zy6B4I6+OzCLT9uQd89vOQoVE5mUP5To8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAmaYRPY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAmaYRPY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791403777; x=1822939777;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fYLJEJcwKgGPopEORbNrWszT2SB69WTLxu0Bze7Nzx0=;
  b=YAmaYRPYVzzUTt8nYmj2JFXDKRnli+zt86x26hjx1ZzntTbWz0gf5s5e
   KaAv9iTVAskPL6up89L4ATmJrvO4gx8HenAbyGU2etM9qz0Ooticnvm6q
   e00dJjtHVv6KsNr9XH7VO4YIJ6dJrxfVYAxTcqzxzDJWb4I7w46Mg45FV
   02M7BpvAzd6rfMVXSU8Cj0ykN2wvItBLDSAnru/H+kXshrrs37vnoXIJh
   WUnNjceMfv312myulJ0u5JuQTJGVNxKEUuvVmse+0Y50cRujXVfbel2c3
   gcqu5+I+of6lJlFKlNrK8uTrktdi0d06QqZ7NYv097xYg+CYkJvzMmwjF
   A==;
X-CSE-ConnectionGUID: FVEboG13QGircgeVl0x2XA==
X-CSE-MsgGUID: Jg9Yg/wsR/y5cYk7LQDsnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="186101"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="186101"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 13:09:36 -0700
X-CSE-ConnectionGUID: larUDTC7TPaF2b55KORFcA==
X-CSE-MsgGUID: lYhiMT9zSOerODLRwzqi+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="254929"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.38])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 13:09:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 7 Oct 2026 23:09:26 +0300 (EEST)
To: Hugo Villeneuve <hugo@hugovil.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Hui Peng <benquike@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, 
    John Ogness <john.ogness@linutronix.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v7 1/2] serial: core: fix baud rate fallback in
 uart_get_baud_rate()
In-Reply-To: <20261007130637.49588f6112bf892604dc4e2d@hugovil.com>
Message-ID: <a846724d-0080-1df4-e78d-179e589c3aa2@linux.intel.com>
References: <20260930125901.778868-1-benquike@gmail.com> <20260930125901.778868-2-benquike@gmail.com> <2026100156-watch-balsamic-32db@gregkh> <5085df04-f813-8b3f-1d05-87d5bbf00499@linux.intel.com> <20261006112932.3b9c8acd3bc2bfcf1d17b264@hugovil.com>
 <8fc5361a-199d-3bab-da86-f967906aa39d@linux.intel.com> <20261007130637.49588f6112bf892604dc4e2d@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1296411136-1791403766=:1171"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1296411136-1791403766=:1171
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 7 Oct 2026, Hugo Villeneuve wrote:

> Hi Ilpo,
>=20
> On Wed, 7 Oct 2026 13:38:55 +0300 (EEST)
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > On Tue, 6 Oct 2026, Hugo Villeneuve wrote:
> >=20
> > > On Thu, 1 Oct 2026 12:46:05 +0300 (EEST)
> > > Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > >=20
> > > > On Thu, 1 Oct 2026, Greg Kroah-Hartman wrote:
> > > >=20
> > > > > On Wed, Sep 30, 2026 at 12:59:00PM +0000, Hui Peng wrote:
> > > > > > When uart_get_baud_rate() is called with a baud rate exceeding =
the port's
> > > > > > maximum supported speed (port->uartclk / 16), it clips baud to =
[min,
> > > > > > max - 1] and encodes it into termios via tty_termios_encode_bau=
d_rate().
> > > > > >=20
> > > > > > However, because the loop bound is for (try =3D 0; try < 2; try=
++), the
> > > > > > loop terminates immediately after try =3D=3D 1 without re-evalu=
ating
> > > > >=20
> > > > > But try =3D=3D 1 should keep the loop going as it is < 2, right? =
 What am I
> > > > > missing here?  Do I need more coffee?
> > > > >
> > > > > > baud =3D tty_termios_baud_rate(termios) for the clipped rate, h=
itting
> > > > > > WARN_ON(1) and returning 0, which then triggers a fatal divide-=
by-zero
> > > > > > (Oops: divide error) in uart_get_divisor():
> > > > > >=20
> > > > > >   WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_bau=
d_rate+0x136/0x260
> > > > > >   [ ... ]
> > > > > >   divide error: 0000 [#1] PREEMPT SMP KASAN
> > > > > >=20
> > > > > > Increase the retry count in uart_get_baud_rate() from 2 to 3 it=
erations so
> > > > > > that clipped baud rates are re-evaluated in the third iteration=
=2E
> > > > >=20
> > > > > What is the magic 2 here, and why turning it into a magic 3 someh=
ow fix
> > > > > things?
> > > >=20
> > > > Hi Greg & Hui,
> > > >=20
> > > > First of all, I'm withdrawing my Reviewed-by from this!!!
> > > >=20
> > > > Lets hope the submitter can finally get his/her act together and no=
t make=20
> > > > unlisted changes between versions or send non-sense.
> > > >=20
> > > > While the code change is still fine, it seems the submitter (or mor=
e=20
> > > > likely AI) has changed the changelog from what I read when I review=
ed=20
> > > > this. And the new one is way worse than it used to be so not being =
able=20
> > > > to follow what's going on is very understandable given the lacklust=
er=20
> > > > explanation that remains.
> > > >=20
> > > >=20
> > > > What you're missing is that the baud returns happens within the loo=
p, so:
> > > >=20
> > > > try =3D=3D 0: use new, if baud is out of bound and old is available=
, switch to=20
> > > >           old
> > > > try =3D=3D 1: if old is also out of bounds, there's the last resort=
 rule=20
> > > >           towards the end of the loop which is applied forcing baud=
 to the=20
> > > >           accetable range.
> > >=20
> > > Hi all,
> > > is it at all possible that old is out of bounds in the first place?
> >=20
> > Apparently it is, given the WARNING above (unless that too is fabricate=
=20
> > by LLM which seems well within possiblities given the track record of t=
his=20
> > particular submitter).
> >=20
> > > If yes, is it something that should be fixed?
> >=20
> > I agree.
> >=20
> > I think the scenario here is (but take it with grain of salt, as the=20
> > information seems to be constantly changing thanks to LLM/submitter=20
> > failing to keep one's act to together) [1]:
> >=20
> > Tested in QEMU against Linux 7.3.0-rc3 by setting /dev/ttyS1 to B115200=
,
> > lowering baud_base to 9600 (max =3D 9600) via TIOCSSERIAL, and calling
> > tcsetattr() with B57600 (old =3D B115200), reproducing the WARNING and
> > Oops: divide error in uart_get_divisor() on the unfixed kernel and
> > verifying clean execution with 0 warnings/faults with the fix applied.
> >=20
> > So when rate gets lowered, it should alter the termios to prevent what =
is=20
> > here seem as "old" having an invalid value.
>=20
> That makes sense...
>=20
> >=20
> > [1] https://lore.kernel.org/linux-serial/20260930041216.155911-3-benqui=
ke@gmail.com/
> >=20
> > > > try =3D=3D 2: loop exits =3D> WARN_ON(1) triggers.
> > > >=20
> > > > What we'd want to happen with try =3D=3D 2, is for it to use the re=
turn baud=20
> > > > which is within the loop body.
> > >=20
> > > Then should the "return 0" statement be modified to "return baud", an=
d
> > > possibly the WARN_ON() removed? Then you wouldn't need to increase
> > > max try?
> >=20
> > IMO, the entire loop constructs feels somewhat artificial in this case =
so=20
> > I'd prefer to kill the loop entirely. But such refactoring is not going=
 to=20
> > be a minimal fix to the issue.
>=20
> Yes, when I updated uart_get_baud_rate() a few months ago, the loop
> also felt a little bit weird, but I did not remove it because I assumed
> it was working ok if we assumed, like I did, that the old baud rate was
> always valid.
>=20
> I tried in the past to simplify it, make it more logical and
> understandable by normal humans :) But I always end up with
> something not so simple and obvious because of all the special cases
> (B0, spd_* flags, etc).

Trying to all that in the same function surely gets problematic and=20
repetivive. But how about adding another function/helper that is just=20
called multiple times to avoid duplicating them?

> I am still trying though, maybe I will have better luck this time :)
>=20
>=20
>=20

--=20
 i.

--8323328-1296411136-1791403766=:1171--
