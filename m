Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645322B594;
	Sun, 19 Jul 2026 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784475520; cv=pass; b=fcRV2TF5arzR0W708EhoL8mNRI1uJQvpuZp/sqCi4KhO+MP0C2OuTDQeeDHNVcVKmhE4JtTSeZJdEIbrzf/HDjYlgHaIk3wIdl3nXu6KEUymgl5KDdErlDlVnSLpRa1nL9LxAiRSROW5XSiuMfRIGqHvM9p/8bYQG6sW6lonV7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784475520; c=relaxed/simple;
	bh=KBX6ZiZ/9vnudTKrYmVvyYrWlGwC29w1bnVhe8kO5ng=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=URuUn8Nb4YEyzo2a15haSTsOfXSVexjfvCIfCcDzJqvJrDaS6x1ForsDizr4ADVnCjmA3U1OJTcIagRLR2hs/LZWbSLUMjosaIAaRl17jX1NHwd5kHP915RodLTlkDdTY2c5Desd5SGh+8qQPoYPFjzmnvCLDpo2FkAH/EjgsIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=SIkXPD8Y; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=jqMrDIwX; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="SIkXPD8Y";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="jqMrDIwX"
ARC-Seal: i=1; a=rsa-sha256; t=1784475506; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kju4gQH+q7a5wr2O4G85Z4pYTbyS9sOYAZBq/V5VRlsguwjIXw49WZvArbyCOEtRpK
    6eG5me7elIx0XDwqh/xMM6j7pElBD7VN/pFXwK/lH6eTIXGirFIBJui05zXKCewHcHWa
    5nmtPIVzJaUFuLMp9UFKisyDQ/D5thKy1P/+cioMoZZ3aBTxrcbghb51yEHKEFzm0XFU
    mKCdgMxXtlOOXC0IAdfulrr8GQwkM1s56TBqHZJXgWjRVfBPMYEVs3KAmf/VSXmbaX81
    J/SNmhXLIdDCpFcFsFlMelnFkTzYOLDdp+81T3BaX0V0E2pLCvl966+tsXOSmH66TIRR
    OWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784475506;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=u/JCs8fQlddPmKg8eJUPplCbWk2Oa8TpGF5Ma9k4XaE=;
    b=pf+zb9Yio1nRNYWG2S1+op1YaLZkOtV+rwmpltdg0FHJr+FLwIgm5qjsgw6C93ZGZg
    QkWY3VLQCeLvYYU3mer9fYl+ruHn0dGHAU/dBFchwPsmfp9Sa6RufFaIRxFRSMCMEVWY
    +yE7+Qu9EtPsO5nGhZpIP+05S6EZs8xOzrMcEzPxnYZjynGUrH6/t3uSanLZtxdNNgtG
    xJWxRih6jaArOcX3C7zJzG+Kaiv8N7YjJfUPKcHQSprA6gIlcw13lQFDqvkt4tkhcU9e
    6rvPIc2dd2yHIzguUzSDDWKlNadH+WrbaNLI/SNvmqEOtIKnOJsmA5tO4W9UkNWrz7A0
    IqKw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784475506;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=u/JCs8fQlddPmKg8eJUPplCbWk2Oa8TpGF5Ma9k4XaE=;
    b=SIkXPD8YBicTptxFlkavzn9p+ra1tHY3pgc4+w2pbpYX/Tmvr4LeUUqgpyKQqBPRzP
    tFVfJWIpGIQXxwfEhAC6uWOvQoDV56tdOyxsLZEGfxchW+EluTNzK9l0kQWsZs411o0z
    hHpz2qaBbAffLrkX8kkhG8kjkRcOdSj5ve8ch6Oa8Cp9muFvyPWI68B4jrvZHaORTSjH
    VDmNhdtzGOpolDIZFJ54GQ9MW7zH2DqBm5kPDKeqkm6qIrd7nEyECqw4UxV+MAN5CEo6
    RrUEi0kmpyrDVcnA3h5LTS2/UCVUB39I58VKB68+t4NHyVLt7fCUsusfbwiPcqDwcboU
    +m6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784475506;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=u/JCs8fQlddPmKg8eJUPplCbWk2Oa8TpGF5Ma9k4XaE=;
    b=jqMrDIwXZoFky6LuXjRC3zOlbkWlO6IBFbX6KtEyF0wul5ygbGqWMeCiTKBweZUR0o
    wnTuQPan38f4cB1CUjDg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yfz8Z"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Q58eac26JFcP5IH
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sun, 19 Jul 2026 17:38:25 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] i2c: jz4780: Cache clock rate at probe to prevent CCF
 prepare_lock deadlock
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <a08203c004280827fda87fc4c83660aedb446440.camel@crapouillou.net>
Date: Sun, 19 Jul 2026 17:38:15 +0200
Cc: Andi Shyti <andi.shyti@kernel.org>,
 linux-mips@vger.kernel.org,
 linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1629D165-4BF0-41A4-A528-A377DD5F2588@goldelico.com>
References: <c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>
 <a08203c004280827fda87fc4c83660aedb446440.camel@crapouillou.net>
To: Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> Am 19.07.2026 um 17:07 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
> Le vendredi 10 juillet 2026 =C3=A0 08:58 +0200, H. Nikolaus Schaller a
> =C3=A9crit :
>> Fix a severe AB/BA deadlock between the Common Clock Framework (CCF)
>> and the I2C adapter lock, which triggers when an I2C-controlled clock
>> generator (like the Si5351) is registered or modified under the CCF.
>>=20
>> During a clock frequency change, the CCF acquires its global
>> 'prepare_lock'
>> mutex and calls i2c_transfer() to update the chip registers, stalling
>> for the adapter's I2C bus lock.
>>=20
>> Concurrently, a parallel transfer on the same bus (e.g., a GPIO
>> expander
>> handling LEDs) can hold the I2C adapter lock. Inside the transfer
>> path,
>> jz4780_i2c_set_speed() calls clk_get_rate() to dynamically calculate
>> timings. This call attempts to acquire the blocked CCF
>> 'prepare_lock',
>> creating a circular dependency that freezes the system or at least
>> the involved processes and workers.
>>=20
>> Eliminate the synchronous clk_get_rate() call from the active
>> transfer
>> path by caching the peripheral clock rate once - inside the private
>> jz4780_i2c structure during jz4780_i2c_probe(). Update
>> jz4780_i2c_set_speed() to use this cached value, decoupling active
>> I2C
>> transactions from the CCF internal locks.
>>=20
>> Assisted-by web based Google AI.
>>=20
>> Fixes: ba92222ed63a12 ("i2c: jz4780: Add i2c bus controller driver
>> for Ingenic JZ4780")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>>  drivers/i2c/busses/i2c-jz4780.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/i2c/busses/i2c-jz4780.c
>> b/drivers/i2c/busses/i2c-jz4780.c
>> index 664a5471d9335..d729cec9cdf2c 100644
>> --- a/drivers/i2c/busses/i2c-jz4780.c
>> +++ b/drivers/i2c/busses/i2c-jz4780.c
>> @@ -141,6 +141,7 @@ struct jz4780_i2c {
>>   void __iomem *iomem;
>>   int irq;
>>   struct clk *clk;
>> + unsigned long clk_rate;
>=20
> That's a weird spacing. Should probably be "unsigned long" on the left
> side.

indeed a typo - should be

TAB unsigned long TAB clk_rate;

Interestingly checkpatch.pl did not complain...

>=20
>>   struct i2c_adapter adap;
>>   const struct ingenic_i2c_config *cdata;
>> =20
>> @@ -246,7 +247,7 @@ static int jz4780_i2c_set_target(struct
>> jz4780_i2c *i2c, unsigned char address)
>> =20
>>  static int jz4780_i2c_set_speed(struct jz4780_i2c *i2c)
>>  {
>> - int dev_clk_khz =3D clk_get_rate(i2c->clk) / 1000;
>> + int dev_clk_khz =3D i2c->clk_rate / 1000;
>=20
> You cache `i2c->clk_rate` but only use it divided by 1000, so maybe
> cache `clk_rate_khz` instead?

Yes, that is more precise.

I can update and send a V2 with a revised commit message.

BR and thanks,
Nikolaus

