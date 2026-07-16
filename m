Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B72134040E;
	Thu, 16 Jul 2026 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204360; cv=pass; b=DAk+sId4kRj9m+n4ky6DjYujeI3VrdtZpS1y9ipkild0zcFIBZJuhSEPy8303V+DGv4JdzwPp1LdGMWl+Svo132tMNEbgwuaL89s+/Sfl0I3aDapwtcGs4wXwl8xC9cnENyfrTJXWspynWdeuk0DvUxXk/7pH+iQGeXpFFYmUYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204360; c=relaxed/simple;
	bh=86ktuEqjR97JcjqSyoT6TZbOAkVWaTCAmVx1ddVDk/s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Xi2qQVC/N/Y8C00TdOCUf0uB51wA39e6/OO7rzSvnsxsFpnhuKmS7MTKlkGPN44CEggLfzIf6zs/Esn4rCbldi977H0nEUtyEedI4sDBE9kkvYvZGk+uX9znJWMM89mVo55/61cBKSjgz81aaO01R0zviSk40y3hxsfXfI4cR04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=OiE+KeNG; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=iyZKomec; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="OiE+KeNG";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="iyZKomec"
ARC-Seal: i=1; a=rsa-sha256; t=1784204340; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Tzw9DS5+HRIniAteMyAK3e0Bpuzg7FXjz3eTYXmf4yIK5Up+mVNJzidMUnioYsgi+f
    UYGqxv/sMqpeihkPL2b9DFPt7t9ECx7Hn4UhdXcmbEKVzOWn+fb4cpJLZzkAepUIsUrD
    JnLgHEitJ4iuQshZ13f/P6jkJSqBK6ekVt67gUhV4WIGvAus8/u4KIy4AtwIZs3QauOj
    FTz9XNyj20H55LZNCT5VFes0xuEFjxvtGCC0PVNzSYE6byH9AG23wAE9vuQyuL58Y0Aj
    FjNlWL5gfKYNzV9C/+XMSI8r6RyVLrIX2VPHCcKbYmeaWbVHl61l4bI7bALZ1M0/tAX3
    2Vdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784204340;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=86ktuEqjR97JcjqSyoT6TZbOAkVWaTCAmVx1ddVDk/s=;
    b=tIAgvq7qXcsQ/lQVG6HVVqTeePbnD7cPkHrBjAmNwmFzL+QJ6LeEAN89hlgX+rYK5S
    /qiEs72JuHkklF+5e4HpXNcv3mxZnrZVoObqaYvwnCEL3UPZW2nllznefZHdwqx6Ikfg
    ZwC4P3HTHNit1mlmh9QYItzv6LA+pTleKmB3/+JQFl88Xt0G5Qnq7I42t3lyq/lFQMhA
    R0O9CIFa234DyQzuddsCaNT/UcCYj8Ez4/46EnATLhUOZPXL7jlBUuzcW1AUrvJDpcs8
    rX8JDOtYGvUJ6Lvz+l0inHDoqjp2uNV8+zbVZqWs0crtI8MWGDMHhaJMV0BSyLwoIdR6
    wFIA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784204340;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=86ktuEqjR97JcjqSyoT6TZbOAkVWaTCAmVx1ddVDk/s=;
    b=OiE+KeNGnXaSILHJhsaO+DbH4UIGX5PwZOB3inV72i6SoLnuwTC9GS+W3ZthVl6+Mt
    fkBXz8TkOl/w0HgZbeQSdlDTKgqgNo4ojN4loIjedt/iytmb0mvRV+mWWOMO0VAsMG72
    AsH/4zc9IAaTiro0UGEMhxFPn9i5oAlgacQeYll/ch1Ai6BGXO+bJWNeBnNHBinoSMPC
    Qjn83lW/Jb3eUZ8DcU3LNB2MRscIYvN8s4H9YN8fVnzeO63j4yFWtapbiJUqFJ8j5DPg
    freZjgEYt85XwufsG4Qd7CXmpfHf6uGCCjSHfnK/0gSVGm0dyzJngKSysRaC/0xmtC6V
    hFfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784204340;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=86ktuEqjR97JcjqSyoT6TZbOAkVWaTCAmVx1ddVDk/s=;
    b=iyZKomecSnhxzvdpaC79o19OPcENwSSBAQwnuGdq6rdJG4diym77S1WKg60I30UkRE
    xyPRef7nr0DBVNlRoqCA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrS0JpbnciN91aF+UY0Pm4r8tXCtzZjxu6AAT8="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426GCJ0bfR
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 16 Jul 2026 14:19:00 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [Letux-kernel] [PATCH] i2c: jz4780: Cache clock rate at probe to
 prevent CCF prepare_lock deadlock
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <aljCGkhZEQHzZVSW@zenone.zhora.eu>
Date: Thu, 16 Jul 2026 14:18:49 +0200
Cc: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 linux-mips@vger.kernel.org,
 Paul Cercueil <paul@crapouillou.net>,
 linux-i2c@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <500EE2C0-B916-47DF-874F-EBB2CF1C779D@goldelico.com>
References: <c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>
 <alf7rSWaLBO8WBkR@zenone.zhora.eu>
 <36148F30-156F-4E74-8765-D718F6FE7E76@goldelico.com>
 <aliLbNJ51Ns0dIHX@zenone.zhora.eu>
 <9421BB47-EFC8-4D82-989F-82A84FE46749@goldelico.com>
 <aljCGkhZEQHzZVSW@zenone.zhora.eu>
To: Andi Shyti <andi.shyti@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)

Hi Andi,

> Am 16.07.2026 um 13:41 schrieb Andi Shyti <andi.shyti@kernel.org>:
>=20
> On Thu, Jul 16, 2026 at 10:33:56AM +0200, H. Nikolaus Schaller wrote:
>>> Am 16.07.2026 um 09:43 schrieb Andi Shyti <andi.shyti@kernel.org>:
>>> On Thu, Jul 16, 2026 at 07:44:20AM +0200, H. Nikolaus Schaller =
wrote:
>>>>> Am 16.07.2026 um 00:07 schrieb Andi Shyti <andi.shyti@kernel.org>:
>>>>> On Fri, Jul 10, 2026 at 08:58:35AM +0200, H. Nikolaus Schaller =
wrote:
>>>>>> Fix a severe AB/BA deadlock between the Common Clock Framework =
(CCF)
>>>>>> and the I2C adapter lock, which triggers when an I2C-controlled =
clock
>>>>>> generator (like the Si5351) is registered or modified under the =
CCF.
>>>>>>=20
>>>>>> During a clock frequency change, the CCF acquires its global =
'prepare_lock'
>>>>>> mutex and calls i2c_transfer() to update the chip registers, =
stalling
>>>>>> for the adapter's I2C bus lock.
>>>>>=20
>>>>> I don't think caching the clock rate once at probe is safe.
>>>>=20
>>>> Ok, valid point to discuss.
>>>>=20
>>>>=20
>>>>> If the controller clock rate changes afterwards,
>>>>> jz4780_i2c_set_speed() will keep using the stale cached value and
>>>>> calculate incorrect bus timings.
>>>>=20
>>>> But: is clock rate ever changed during operation? Usually it is =
defined
>>>> by the device tree constant.
>>>=20
>>> That's what you are saying in your commit message.
>>=20
>> The Si5351 clock generator driver is connected through this i2c bus. =
And that
>> is referred to by "when an I2C-controlled clock generator (like the =
Si5351) is=20
>> registered or modified under the CCF".
>>=20
>> Only then, this bug faces surface. Because that driver changes it's =
clock through
>> sending i2c commands which also ask for the lock.
>=20
> If you make a claim in the commit message, I expect the code to
> support it.

I still do not see where you read the claim you criticize.

The commit messages says:

> Fix a severe AB/BA deadlock between the Common Clock Framework (CCF)
> and the I2C adapter lock, which triggers when an I2C-controlled clock
> generator (like the Si5351) is registered or modified under the CCF.

This clearly says that the clock generator is I2C controlled.

And that the problem arises if the frequency *of the clock generator* is =
changed.

It does not say anything about *changing the I2C bus clock* itself.

> During a clock frequency change, the CCF acquires its global =
'prepare_lock'
> mutex and calls i2c_transfer() to update the chip registers, stalling
> for the adapter's I2C bus lock.

This describes what happens in the current code:
- someone wants to change the clock frequency of the Si5321
- this acquires the CCF lock for this change
- the driver tries to read/write some registers from the i2c chip
- for this it does some I2C transfer
- which locks the I2C bus
- the jz4780 driver tries to read the I2C frequency in its I2C bus =
driver
- and the system (including I2C) hangs

What is not clear here?

The patch fixes this by caching the i2c clock rate and avoiding that
an i2c transfer asks the CCF for anything.

>=20
> You say that the clock rate can change, but then you store it
> only once at probe time. That immediately suggests that later
> rate changes will be ignored by the transfer path.

Where does the commit message say that the *I2C clock rate* is changed
or can change?

It can't be changed by standard API and therefore its clock rate can be
cached as proposed during probe of the jz4780 bus driver.

>=20
>> But again: how would you solve this?
>=20
> It's not my role to give you a solution. I'm just commenting on
> what I see.

If you can comment, I simply expect you to have experience to give
a hint how to solve it differently.

> Besides that, is that an issue you have encountered yourself? Is
> it a frequent issue?

Yes. It comes 100% if you connect an Si5351 to the CI20 board or
others board which use the same driver (e.g. some X1600 based one).

It is likely that any other i2c connected device which registers some
clocks is running into the same problem.

Therefore I consider this as a fundamental design flaw which is solved
by this patch.

BR and thanks,
Nikolaus

