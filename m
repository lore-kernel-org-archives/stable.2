Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71BE13A258;
	Sun, 19 Jul 2026 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784467423; cv=pass; b=hQHgKsqHgHkkwJNMP6qC/ctzTeeHmmnUhzEzur+gYgUdIuv4yXei/yRhUMbH3GkzAGg79lTWgOLQYJSVityej1hfYI4BHOT1Rteg4wX4ZWi8B5wsePiKxMdW0kZE3RySmsfI3vSFyxeaeGCBU+4SFGik/RAsR2PqL1r2HdD8z64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784467423; c=relaxed/simple;
	bh=8A9azq+rPIsMLeZDTSN6xxxhJnYwCPTn3W7p1XJb0/o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ah3WR4ACPB05Ndrjago1rwcdyx5g1aVRsyYLgG0Fqrz+eGpyTEX+D4wDHalumFnQcXV1I77Fvu/EdN0gJn4OpmDptucgu9AX7caIqjrTFoSWGwzoQCmQuLMd0GrWmI2iC9tuAF3k0UEwbEIAauvHlE8UuLVR9iKhtrh+l03rkqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=mNmm/C7K; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=800mHr0a; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="mNmm/C7K";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="800mHr0a"
ARC-Seal: i=1; a=rsa-sha256; t=1784467403; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=H7XJ78ceemKj8P0WaD9uVYPoiMhmjwDAW9aOAi1SJr4ZoSSy8nUs8BBoVhxBbNUow9
    roQ3xHb76x2k4qRZkxW9ceF1vXbjGwcRUlQNyHG9nDvN4wdpLrBD5nnD4BhQfGHO38h5
    wSTKLadNJF7v5nD/xOXW9YH55TQEP3K0rvyDitxTR04YljF9XfJ4yYHGbq6QSsOalVRA
    /DQ/gDNwNecIpcMquyzfOoL8Mh5e7cBVAwRCSkZlFl7fYNt+RAQsu54RLhC/pg0NPOi4
    yzj/yWelZ83OininhWc41niebrpcNAHIWAOCKs7ESUlaZT6f4wIgfXmIt3rr6uG9JH2X
    qjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784467403;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=HYfkpoBJMWefz580488BFqWF51N0KciV5JzoWV6Dd1c=;
    b=s6czvuMsFr+yLOuk9vEmMKI2n5WJOmrWSWKdqCiaI7kkt0N2+AJ2tEdDFl3Osmayuh
    yKwBgPmokmxeBKY3nbfuvYqmPKJPaLqb9eZu8vZbJPyamfQzdx2i5hcEft73BRSsDTWb
    hyegCCd13FLTdSarQm0YQY/834vWtl5nqNuOm68QGmUo/kJBeXUEAjV2fl0zCiDU74xw
    6tx4+yJwLnfP5bkpGgOE1kWNe985slIr9OZvexwf0lePoUvYN68PuCVfLUdD2/qGRt7I
    ec2URuajOpywBmtdrcBqU6ARVifNM/FCjV59nMW+S/6zve+3X2kPLtM0QSqwN40i+tOD
    v3YA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784467403;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=HYfkpoBJMWefz580488BFqWF51N0KciV5JzoWV6Dd1c=;
    b=mNmm/C7Kn+45DWyAl+gq5Us88dbke1oN2x1JrAfW1U2qLYt6Zu8dIQ1A+FbIIAt+ts
    PMamOuT7+XjHjdJWv98b4JhWUwoL46rN0chcLUn30G+lPK0RDUErlp07ZGWN8domZa5J
    z/x2JB6TQRldYj2rlxsCRe5et0VWvxVybq/wCpwR3G3bn8E9w/K9K4PChbBqGy8Ni1BE
    Pkw4HX7zVl7+EXNkedRWhJBzrRGWw7otAIS/JsivBsyK2JyX4LznhvDPdUbza67Rvp4h
    rkIapGdGd4yEatUG1jR3r2cN7Ob2YfHViJIEhgm1yZOZrEyATxRm1/VQHyDo640Ql9E1
    5kxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784467403;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=HYfkpoBJMWefz580488BFqWF51N0KciV5JzoWV6Dd1c=;
    b=800mHr0a2In0XxKdUxHlGckHUZy7HNoco2WDKQ/Dwp1oo+ZA5wz2ptuNWMGTxY7yXs
    YHssqh85oQUKZp0SjQBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ0JoInciN3JyLCGNPVWcns8O5VzNQLiZpJpg="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q58eac26JDNN530
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sun, 19 Jul 2026 15:23:23 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] i2c: jz4780: Cache clock rate at probe to prevent CCF
 prepare_lock deadlock
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <d869fc2e2fe6eec530a65a2e93b642fad1fd9903.camel@crapouillou.net>
Date: Sun, 19 Jul 2026 15:23:12 +0200
Cc: Andi Shyti <andi.shyti@kernel.org>,
 linux-mips@vger.kernel.org,
 linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E96B15FD-5B86-4375-B8B2-2051AC477F0F@goldelico.com>
References: <c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>
 <alf7rSWaLBO8WBkR@zenone.zhora.eu>
 <36148F30-156F-4E74-8765-D718F6FE7E76@goldelico.com>
 <aliLbNJ51Ns0dIHX@zenone.zhora.eu>
 <9421BB47-EFC8-4D82-989F-82A84FE46749@goldelico.com>
 <aljCGkhZEQHzZVSW@zenone.zhora.eu>
 <d869fc2e2fe6eec530a65a2e93b642fad1fd9903.camel@crapouillou.net>
To: Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3826.700.81.1.8)

Hi Paul,

> Am 19.07.2026 um 14:53 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Andi, Nikolaus,
>=20
> Le jeudi 16 juillet 2026 =C3=A0 13:41 +0200, Andi Shyti a =C3=A9crit :
>=20
> I think there's a misunderstanding.
>=20
> The JZ4780 I2C host's parent clock rate does not change here, so
> caching its rate should be fine.
>=20
> The clock rate that can change in this setup is the one of the Si5351
> clock *generator* that is a I2C device.

Exactly.

>=20
>>=20
>>> But again: how would you solve this?
>=20
> I believe you have this problem because your Si5351's clocks are
> parented to the I2C host's clock, am I right?

No. There is no direct reference to i2c clocks:

/ {
	ref25: xtal {
		compatible =3D "fixed-clock";
		clock-output-names =3D"ref";
		#clock-cells =3D <0>;
		clock-frequency =3D <25000000>;
	};
};

&i2c1 {
	clkgen: clock-generator@60 {
		status =3D "okay";

		compatible =3D "silabs,si5351a-msop";	// 10-MSOP =
package has just 3 clock outputs
		reg =3D <0x60>;	// 61?
		#address-cells =3D <1>;
		#size-cells =3D <0>;
		#clock-cells =3D <1>;

		/* Connect XTAL input to 25MHz reference */
		clocks =3D <&ref25>;
		clock-names =3D "xtal";

		/* Use XTAL input as source of PLL0 and PLL1 */
		silabs,pll-source =3D <0 0>, <1 0>;

		/* Don't reset PLL1 on rate adjustment */
		silabs,pll-reset-mode =3D <1 1>;

		/*
		* Overwrite CLK0 configuration with:
		* - 8 mA output drive strength
		* - initialize output as floating
		* - PLL0 as clock source of multisynth 0
		* - Multisynth 0 as clock source of output divider
		* - Multisynth 0 can change PLL0
		*/
		master: clkout@0 {
			reg =3D <0>;
			silabs,drive-strength =3D <8>;
			silabs,multisynth-source =3D <0>;
			silabs,clock-source =3D <0>;
			silabs,pll-master;
			silabs,disable-state =3D <2>;
			clock-frequency =3D <8000000>;
		};
...

>=20
> So when you try to change a Si5351 clock rate, it will get the clock's
> lock and the clock parent's lock, aka. the I2C host clock's lock.
> Then
> trying to send a I2C command will indirectly trigger clk_get_rate() on
> the I2C host's clock to be called, causing a lockup.
>=20
> I think the solution would be, and CLK people can correct me here, to
> just drop the relation to the I2C host lock. Your Si5351 clocks are =
not
> derived in any way from the clock used by the I2C hardware in the JZ
> SoC (unless they are?), so I think they should just not have any
> parent.

The problem appears to be deeper, that an already locked clock =
manipulation
requested from the Si5351 drivers issues an jz4780 xfer. Which asks for =
clock
information. This then tries to acquire the same lock which blocks.

And the next i2c transfer from a different i2c client tries another =
jz4780 xfer,
which is locked because the previous one with the si5351 never =
completes.

IMHO the standard solution is never to ask for clock rates during i2c =
xfer
but only once during jz4780 i2c probe and cache this value. Drivers for =
other
SoC are doing it the same way. And this is what this patch is fixing.

BR and thanks,
Nikolaus

