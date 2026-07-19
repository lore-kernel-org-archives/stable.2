Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8115B153BE9;
	Sun, 19 Jul 2026 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784465634; cv=none; b=j/oj8B9h/qT34uIA71DoIvCJH626uyc8aWaMuSF76RduCnirfxVsggPWutjFyn0XKgKC7ktKimEpWkcFbm0DAkxC+5o/EKcwtRjTWf/TJa6wf4gSo4QD8s1rvXago5P/d3JOfIsZstyB5MOp6MGmqSKuKOhZPhKoQb3cau6CnTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784465634; c=relaxed/simple;
	bh=8U389L9n9leu3mtmI0AqAenATf38Tlkc+LIYUnR8gHg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H10Ac8ariu5we0TZt1WFAeN6q5jXqzWEUBUi0EFX80l41fLfi6RWorzS3aZm35cWnZh0iMJkub+sgitu7SQuB7cWeAavtzFActslIsJTtfqakeY5EDCjUnYAnkTSAF0gkxcvZX6DcofhoQSb4DrDWgf4ELwATmFBIzvzr+N1H/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=dpIE2mGf; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="dpIE2mGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1784465624;
	bh=8U389L9n9leu3mtmI0AqAenATf38Tlkc+LIYUnR8gHg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dpIE2mGfQV9bihoNl/00WHenYCV9d6GZviFv9QUh24KUdpt9o7NP88Lpu6rr//lRl
	 +mEIzjuixRQGA28wNlREe32ae7gXyfuVBSq9mak9r/x5G8fMJ5WZjm7cPGgFL8ZabW
	 8fu5A+jb92fIJjxpigpK6x0W2Tz9y5KG4CSn5jlM=
Message-ID: <d869fc2e2fe6eec530a65a2e93b642fad1fd9903.camel@crapouillou.net>
Subject: Re: [PATCH] i2c: jz4780: Cache clock rate at probe to prevent CCF
 prepare_lock deadlock
From: Paul Cercueil <paul@crapouillou.net>
To: Andi Shyti <andi.shyti@kernel.org>, "H. Nikolaus Schaller"
	 <hns@goldelico.com>
Cc: linux-mips@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, 
	stable@vger.kernel.org
Date: Sun, 19 Jul 2026 14:53:39 +0200
In-Reply-To: <aljCGkhZEQHzZVSW@zenone.zhora.eu>
References: 
	<c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>
	 <alf7rSWaLBO8WBkR@zenone.zhora.eu>
	 <36148F30-156F-4E74-8765-D718F6FE7E76@goldelico.com>
	 <aliLbNJ51Ns0dIHX@zenone.zhora.eu>
	 <9421BB47-EFC8-4D82-989F-82A84FE46749@goldelico.com>
	 <aljCGkhZEQHzZVSW@zenone.zhora.eu>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andi, Nikolaus,

Le jeudi 16 juillet 2026 =C3=A0 13:41 +0200, Andi Shyti a =C3=A9crit=C2=A0:
> On Thu, Jul 16, 2026 at 10:33:56AM +0200, H. Nikolaus Schaller wrote:
> > > Am 16.07.2026 um 09:43 schrieb Andi Shyti
> > > <andi.shyti@kernel.org>:
> > > On Thu, Jul 16, 2026 at 07:44:20AM +0200, H. Nikolaus Schaller
> > > wrote:
> > > > > Am 16.07.2026 um 00:07 schrieb Andi Shyti
> > > > > <andi.shyti@kernel.org>:
> > > > > On Fri, Jul 10, 2026 at 08:58:35AM +0200, H. Nikolaus
> > > > > Schaller wrote:
> > > > > > Fix a severe AB/BA deadlock between the Common Clock
> > > > > > Framework (CCF)
> > > > > > and the I2C adapter lock, which triggers when an I2C-
> > > > > > controlled clock
> > > > > > generator (like the Si5351) is registered or modified under
> > > > > > the CCF.
> > > > > >=20
> > > > > > During a clock frequency change, the CCF acquires its
> > > > > > global 'prepare_lock'
> > > > > > mutex and calls i2c_transfer() to update the chip
> > > > > > registers, stalling
> > > > > > for the adapter's I2C bus lock.
> > > > >=20
> > > > > I don't think caching the clock rate once at probe is safe.
> > > >=20
> > > > Ok, valid point to discuss.
> > > >=20
> > > >=20
> > > > > If the controller clock rate changes afterwards,
> > > > > jz4780_i2c_set_speed() will keep using the stale cached value
> > > > > and
> > > > > calculate incorrect bus timings.
> > > >=20
> > > > But: is clock rate ever changed during operation? Usually it is
> > > > defined
> > > > by the device tree constant.
> > >=20
> > > That's what you are saying in your commit message.
> >=20
> > The Si5351 clock generator driver is connected through this i2c
> > bus. And that
> > is referred to by "when an I2C-controlled clock generator (like the
> > Si5351) is=20
> > registered or modified under the CCF".
> >=20
> > Only then, this bug faces surface. Because that driver changes it's
> > clock through
> > sending i2c commands which also ask for the lock.
>=20
> If you make a claim in the commit message, I expect the code to
> support it.
>=20
> You say that the clock rate can change, but then you store it
> only once at probe time. That immediately suggests that later
> rate changes will be ignored by the transfer path.

I think there's a misunderstanding.

The JZ4780 I2C host's parent clock rate does not change here, so
caching its rate should be fine.

The clock rate that can change in this setup is the one of the Si5351
clock *generator* that is a I2C device.

>=20
> > But again: how would you solve this?

I believe you have this problem because your Si5351's clocks are
parented to the I2C host's clock, am I right?

So when you try to change a Si5351 clock rate, it will get the clock's
lock and the clock parent's lock, aka. the I2C host clock's lock. Then
trying to send a I2C command will indirectly trigger clk_get_rate() on
the I2C host's clock to be called, causing a lockup.

I think the solution would be, and CLK people can correct me here, to
just drop the relation to the I2C host lock. Your Si5351 clocks are not
derived in any way from the clock used by the I2C hardware in the JZ
SoC (unless they are?), so I think they should just not have any
parent.

> It's not my role to give you a solution. I'm just commenting on
> what I see.
>=20
> Besides that, is that an issue you have encountered yourself? Is
> it a frequent issue?
>=20
> Thanks,
> Andi

Cheers,
-Paul
