Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F543446A6;
	Wed,  7 Oct 2026 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791392809; cv=none; b=MqAJ5X3Qo7UVcyCmwqDd0NUjo4GU5bxk519VrZnk7YL9f5zu3n91nambZx0a1zql4Mdpzg5O5TJCPRhweiaOWXaoNGBtl9O3wfyzJ6VxqrtNnoEMtV1dsGdRkoZV4Ae1NJIgT/frEr+QUpqHYnMHF0FLcbInaRHrKSB7qQfJtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791392809; c=relaxed/simple;
	bh=Gw6wC9QBZv52Tg9srbrSHMNh4qtrIzxufnnzrDhjoEA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FiBbEvhKBCRq26BG4B1Ou4aYjoOiFCihfx7uMH00Exo8qj6LE/7DieWNQnKT/BJjCWctgPIN0L40GuWypHTL8vYhh7oFDXZBzqC7DPDyCR4D+pDPxbomAbZJflpSpz8o0isQmoj+iQx1ALg9HM0IMpXIhtvDmL6k8hezmiBnFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=YiEsQZAY; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="YiEsQZAY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=brm2Lvc1kyCIbES8/7RtGeoGN5w+p1XdS6apX80DPsQ=; b=YiEsQZAYP2QtGI1yoNPNPNXJ3a
	m+0ZYreq6M3yIyWVfH1SjpMQG/IfnJi2oAASi0sU+69CNVMm5PSItmyFlP8NLPexHn6JpQOzx8U0W
	fI4sTRODRvJalRvNyYzn5ietQVRPqVZW+CP1r1QBzszeNc/JSUjFlmj3BDYFrkJAPJtY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xEV6E-000000000zV-1fFD;
	Wed, 07 Oct 2026 13:06:38 -0400
Date: Wed, 7 Oct 2026 13:06:37 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hui Peng
 <benquike@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, John Ogness
 <john.ogness@linutronix.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-serial
 <linux-serial@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v7 1/2] serial: core: fix baud rate fallback in
 uart_get_baud_rate()
Message-Id: <20261007130637.49588f6112bf892604dc4e2d@hugovil.com>
In-Reply-To: <8fc5361a-199d-3bab-da86-f967906aa39d@linux.intel.com>
References: <20260930125901.778868-1-benquike@gmail.com>
	<20260930125901.778868-2-benquike@gmail.com>
	<2026100156-watch-balsamic-32db@gregkh>
	<5085df04-f813-8b3f-1d05-87d5bbf00499@linux.intel.com>
	<20261006112932.3b9c8acd3bc2bfcf1d17b264@hugovil.com>
	<8fc5361a-199d-3bab-da86-f967906aa39d@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam_score: -2.0
X-Spam_bar: --

Hi Ilpo,

On Wed, 7 Oct 2026 13:38:55 +0300 (EEST)
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Tue, 6 Oct 2026, Hugo Villeneuve wrote:
>=20
> > On Thu, 1 Oct 2026 12:46:05 +0300 (EEST)
> > Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> >=20
> > > On Thu, 1 Oct 2026, Greg Kroah-Hartman wrote:
> > >=20
> > > > On Wed, Sep 30, 2026 at 12:59:00PM +0000, Hui Peng wrote:
> > > > > When uart_get_baud_rate() is called with a baud rate exceeding th=
e port's
> > > > > maximum supported speed (port->uartclk / 16), it clips baud to [m=
in,
> > > > > max - 1] and encodes it into termios via tty_termios_encode_baud_=
rate().
> > > > >=20
> > > > > However, because the loop bound is for (try =3D 0; try < 2; try++=
), the
> > > > > loop terminates immediately after try =3D=3D 1 without re-evaluat=
ing
> > > >=20
> > > > But try =3D=3D 1 should keep the loop going as it is < 2, right?  W=
hat am I
> > > > missing here?  Do I need more coffee?
> > > >
> > > > > baud =3D tty_termios_baud_rate(termios) for the clipped rate, hit=
ting
> > > > > WARN_ON(1) and returning 0, which then triggers a fatal divide-by=
-zero
> > > > > (Oops: divide error) in uart_get_divisor():
> > > > >=20
> > > > >   WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_baud_=
rate+0x136/0x260
> > > > >   [ ... ]
> > > > >   divide error: 0000 [#1] PREEMPT SMP KASAN
> > > > >=20
> > > > > Increase the retry count in uart_get_baud_rate() from 2 to 3 iter=
ations so
> > > > > that clipped baud rates are re-evaluated in the third iteration.
> > > >=20
> > > > What is the magic 2 here, and why turning it into a magic 3 somehow=
 fix
> > > > things?
> > >=20
> > > Hi Greg & Hui,
> > >=20
> > > First of all, I'm withdrawing my Reviewed-by from this!!!
> > >=20
> > > Lets hope the submitter can finally get his/her act together and not =
make=20
> > > unlisted changes between versions or send non-sense.
> > >=20
> > > While the code change is still fine, it seems the submitter (or more=
=20
> > > likely AI) has changed the changelog from what I read when I reviewed=
=20
> > > this. And the new one is way worse than it used to be so not being ab=
le=20
> > > to follow what's going on is very understandable given the lackluster=
=20
> > > explanation that remains.
> > >=20
> > >=20
> > > What you're missing is that the baud returns happens within the loop,=
 so:
> > >=20
> > > try =3D=3D 0: use new, if baud is out of bound and old is available, =
switch to=20
> > >           old
> > > try =3D=3D 1: if old is also out of bounds, there's the last resort r=
ule=20
> > >           towards the end of the loop which is applied forcing baud t=
o the=20
> > >           accetable range.
> >=20
> > Hi all,
> > is it at all possible that old is out of bounds in the first place?
>=20
> Apparently it is, given the WARNING above (unless that too is fabricate=20
> by LLM which seems well within possiblities given the track record of thi=
s=20
> particular submitter).
>=20
> > If yes, is it something that should be fixed?
>=20
> I agree.
>=20
> I think the scenario here is (but take it with grain of salt, as the=20
> information seems to be constantly changing thanks to LLM/submitter=20
> failing to keep one's act to together) [1]:
>=20
> Tested in QEMU against Linux 7.3.0-rc3 by setting /dev/ttyS1 to B115200,
> lowering baud_base to 9600 (max =3D 9600) via TIOCSSERIAL, and calling
> tcsetattr() with B57600 (old =3D B115200), reproducing the WARNING and
> Oops: divide error in uart_get_divisor() on the unfixed kernel and
> verifying clean execution with 0 warnings/faults with the fix applied.
>=20
> So when rate gets lowered, it should alter the termios to prevent what is=
=20
> here seem as "old" having an invalid value.

That makes sense...

>=20
> [1] https://lore.kernel.org/linux-serial/20260930041216.155911-3-benquike=
@gmail.com/
>=20
> > > try =3D=3D 2: loop exits =3D> WARN_ON(1) triggers.
> > >=20
> > > What we'd want to happen with try =3D=3D 2, is for it to use the retu=
rn baud=20
> > > which is within the loop body.
> >=20
> > Then should the "return 0" statement be modified to "return baud", and
> > possibly the WARN_ON() removed? Then you wouldn't need to increase
> > max try?
>=20
> IMO, the entire loop constructs feels somewhat artificial in this case so=
=20
> I'd prefer to kill the loop entirely. But such refactoring is not going t=
o=20
> be a minimal fix to the issue.

Yes, when I updated uart_get_baud_rate() a few months ago, the loop
also felt a little bit weird, but I did not remove it because I assumed
it was working ok if we assumed, like I did, that the old baud rate was
always valid.

I tried in the past to simplify it, make it more logical and
understandable by normal humans :) But I always end up with
something not so simple and obvious because of all the special cases
(B0, spd_* flags, etc).

I am still trying though, maybe I will have better luck this time :)


--=20
Hugo Villeneuve
