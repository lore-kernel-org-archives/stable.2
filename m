Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4762AE68;
	Tue,  6 Oct 2026 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300584; cv=none; b=Vw9E9qgIC2dVv9B6HdM1UVfbrnzZ8NNnJMfnkleZxjnF0KR7ODr4uYf6FyHXCMnWTkL1zGzCCqxvtTp2fkMw7xdRXwdWsGybRJR42KTLQy0y1Zf8+wGF5TKZMEkxfpVArJCAOAgxkn0W1Ja4G/jHFXe0LafauxGrXApYs4a/Vr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300584; c=relaxed/simple;
	bh=g8bv1+wIZP/QRUx1xtIJH/rS0/4yQSzFnGF09kc0t1Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S76+iZKLxnRvT6KIHeCWk59ZApboi/Yc6CmOvwwEGXRY2jLEux7XhgDCFshf6CiOLSXF2qThqdgB140ZueNl32V+fgP2FF68xh7jUcsn9vBt3W8UWZgs2/p/D1xIT92me7JCAtsRhRUsnTorLu9wxpDccBCRzwuYq6v67qAcrXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=vQKPFWcg; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="vQKPFWcg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=x55jydplZIB8fjiWZCWr9QhfPtiWmP58Q4OUrPsWF+U=; b=vQKPFWcgNUbm+8/qUXoPweKllk
	8z2q8DQ1hjv6VcK/9PsD0tDGcneamubQzyM8cJGYYn2UFK2TYpqs36M7OioCLfXj1aab/++x2bOti
	9imfFyfCBmBPGUau/v2ZfIH9Z5QNxPm2Ew7DkyJaAHXqG52M2zcXqgb5F8QMpqFwVCMM=;
Received: from [70.80.174.168] (helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xE76h-000000007Kt-4BB5;
	Tue, 06 Oct 2026 11:29:33 -0400
Date: Tue, 6 Oct 2026 11:29:32 -0400
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
Message-Id: <20261006112932.3b9c8acd3bc2bfcf1d17b264@hugovil.com>
In-Reply-To: <5085df04-f813-8b3f-1d05-87d5bbf00499@linux.intel.com>
References: <20260930125901.778868-1-benquike@gmail.com>
	<20260930125901.778868-2-benquike@gmail.com>
	<2026100156-watch-balsamic-32db@gregkh>
	<5085df04-f813-8b3f-1d05-87d5bbf00499@linux.intel.com>
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

On Thu, 1 Oct 2026 12:46:05 +0300 (EEST)
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 1 Oct 2026, Greg Kroah-Hartman wrote:
>=20
> > On Wed, Sep 30, 2026 at 12:59:00PM +0000, Hui Peng wrote:
> > > When uart_get_baud_rate() is called with a baud rate exceeding the po=
rt's
> > > maximum supported speed (port->uartclk / 16), it clips baud to [min,
> > > max - 1] and encodes it into termios via tty_termios_encode_baud_rate=
().
> > >=20
> > > However, because the loop bound is for (try =3D 0; try < 2; try++), t=
he
> > > loop terminates immediately after try =3D=3D 1 without re-evaluating
> >=20
> > But try =3D=3D 1 should keep the loop going as it is < 2, right?  What =
am I
> > missing here?  Do I need more coffee?
> >
> > > baud =3D tty_termios_baud_rate(termios) for the clipped rate, hitting
> > > WARN_ON(1) and returning 0, which then triggers a fatal divide-by-zero
> > > (Oops: divide error) in uart_get_divisor():
> > >=20
> > >   WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_baud_rate=
+0x136/0x260
> > >   [ ... ]
> > >   divide error: 0000 [#1] PREEMPT SMP KASAN
> > >=20
> > > Increase the retry count in uart_get_baud_rate() from 2 to 3 iteratio=
ns so
> > > that clipped baud rates are re-evaluated in the third iteration.
> >=20
> > What is the magic 2 here, and why turning it into a magic 3 somehow fix
> > things?
>=20
> Hi Greg & Hui,
>=20
> First of all, I'm withdrawing my Reviewed-by from this!!!
>=20
> Lets hope the submitter can finally get his/her act together and not make=
=20
> unlisted changes between versions or send non-sense.
>=20
> While the code change is still fine, it seems the submitter (or more=20
> likely AI) has changed the changelog from what I read when I reviewed=20
> this. And the new one is way worse than it used to be so not being able=20
> to follow what's going on is very understandable given the lackluster=20
> explanation that remains.
>=20
>=20
> What you're missing is that the baud returns happens within the loop, so:
>=20
> try =3D=3D 0: use new, if baud is out of bound and old is available, swit=
ch to=20
>           old
> try =3D=3D 1: if old is also out of bounds, there's the last resort rule=
=20
>           towards the end of the loop which is applied forcing baud to th=
e=20
>           accetable range.

Hi all,
is it at all possible that old is out of bounds in the first place? If
yes, is it something that should be fixed?

> try =3D=3D 2: loop exits =3D> WARN_ON(1) triggers.
>=20
> What we'd want to happen with try =3D=3D 2, is for it to use the return b=
aud=20
> which is within the loop body.

Then should the "return 0" statement be modified to "return baud", and
possibly the WARN_ON() removed? Then you wouldn't need to increase
max try?


--=20
Hugo Villeneuve
