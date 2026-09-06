Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30462576E;
	Sun,  6 Sep 2026 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788693714; cv=none; b=qytibUgNDK4esDwbGT2seaJCzYYtoTIiJCwvq7bZnw9jjaMCEUZkKd/MwfKt3wKvC8Rj2NGVFt5TSU5m0yJjrifGerij9BP1pk7D80MT68F4IEcWVMAasO1ELO5LEWFxXs+hA1Durvod8QWfIqEn0E8UqnbAMPE08+a8nJHH3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788693714; c=relaxed/simple;
	bh=64JzUqT0jBXtjS2UM/g4PJirm8Yphht5T0U3TxzkjWU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Gqe6f/nHRyOQRdFkp7VDpqxPLICa8bXTORCz+1wC2OKHOX9PsOrPMGNNCNUcwMjWjr6m1XDFoDHwr6cGLjO8EEXs4r1oMIj0/tRxL2o5+QbxOKmDFTyw4vGFtqmhugWivSUFR3DaGl9B+Owx2WY/qbFD+RlVepAiDuJXXKFydC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=jGTIPV8W; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="jGTIPV8W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1788693647;
	bh=hU5drRsukxKTZr6Wttsq4VqOiCpjnWKHL3L2R4CN/6o=;
	h=Mime-Version:Date:Message-Id:From:To:Subject;
	b=jGTIPV8WnA7IDUuELWPdtVK2O0eDDJojlQ13jKbgAuAI1eru93zjxltQE1QYq+btf
	 ABVL9nZ1NJr8FSGRCTp9iA+/BxwUqFhMr4QSAeneZp/Aiw5IPLK/RwdqS1xmWcRWsZ
	 +FXnEuxFtgiqmDIvkZBo1eCuqx04FktT+7dwzeas=
X-QQ-mid: zesmtpsz9t1788693645td04f833d
X-QQ-Originating-IP: DTpauE77uDk1X7buhFaDFSwHJ4/UV6jAd8hGgoHJ2L4=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 06 Sep 2026 19:20:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6232298470301250172
EX-QQ-RecipientCnt: 19
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=536c7c79d9464b992ad1d7b5be05ae3641e4b875bba8fe2b43dc9e787550;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sun, 06 Sep 2026 19:20:40 +0800
Message-Id: <DL86Z6P8P2YI.160YXDVBSSC6I@linux.spacemit.com>
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Yixun Lan" <dlan@kernel.org>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
Cc: "Aurelien Jarno" <aurelien@aurel32.net>, "Michael Turquette"
 <mturquette@baylibre.com>, "Inochi Amaoto" <inochiama@outlook.com>, "Alex
 Elder" <elder@riscstar.com>, "Haylen Chu" <heylenay@4d2.org>,
 <stable@vger.kernel.org>, "Stephen Boyd" <sboyd@kernel.org>, "Brian Masney"
 <bmasney+clk@redhat.com>, "Jerome Brunet" <jbrunet+clk@baylibre.com>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 <linux-clk@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] clk: spacemit: k3: add CPU PLL rate tables
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260903-k3-pll5-pll8-1800mhz-v4-1-afafd9cb47d9@linux.spacemit.com> <apmuG46sBg2rGzCD@aurel32.net> <DL67LEVCXFA5.39M5FO7JGKWZS@linux.spacemit.com> <20260905220746-GKC53903@kernel.org>
In-Reply-To: <20260905220746-GKC53903@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NGf6Juddf2av1Bk8NfLKPcxvsFIALwEmDxNU0SXF7DhV2BjuVFczEfwY
	htGBs9UrUW2g01HBaf3PYHQEPBbEAFKJMkgPqfklaw14hJa146zEVYgNoVAu5pi1+y/vm0+
	sknWUEKuL7RRn9vBURBozE/F8Ix80dIx73+UskZL6KdM9L/TlmXtpGNGVAr++cRKTi6DZxd
	KYsfletsNI0co3Tr1Gsm7CDG6vZQlDr5Mib3V2io14GwwOHywbrg4Yv3Ajq2NxnQApc7cin
	7frk8Zvem3GJ+tZ8vXTcw1W/AESr7tkxMys4mAhWl3NhsXjLMigz+ewR5wBPFqpuxRFT3bg
	Wy1H08tbESosANSaIpplzCEsHQJiL9zugfvwimN1JuHPLg/VPiB8A5E1KmyRGwv4oL5gydy
	+YyAqTBzB5fu4CaOAOGtcx5IQ983rxUHkUU+T7Cs4HYhpVCbFlDHNxmZB6kCuUfJNO/fp+i
	NV6hnRxQ+nZqrOUOcc8ANvoKjFXCKnvaTKdP1CNc2WjfxttRC20WBjnVYBaSf/DGp3Zfw+F
	M13LTFGeymqG+/Z/OfW3jP1V5VntKUK/uIY0xLZGvJ3gD8Enagj1RHVDUHBjsipfJVmKNee
	ABv3lC/vlgW25+PDX2iZYbUqPw/2z2DsL8MGgWmgDyUBYCI0fN0e/JGxLAXQGKdwDD1/PYk
	J2a6/WBgbjjIyIUBKmo0XUsR7E5mgnNebKiLjIDFlTSMzmTlcsr62UCZXzub3Cr76xb0vfb
	aDDrZjhWd0bmjeouQscdj6img/k9w0+N9/hS8aNNNlSbo8GABhIjM3vQrblXolEnON+VXtJ
	g4kdifuEVS9pYHuuwgHD0+q6BMU93Lj7uo4p16delEx4w0IHw5yWp1wVqayi26t1aP5sHXJ
	BZa09ftphjJtRC882MTF3WVYlakJW6ONMaZNeqB5f8eiDfh2dis9w9cXfc/P7guY41IgmHO
	B1uel3MGhme/iyz3Pjpbw4miiNktGwmFv8Lk3nfClmxI0QA8PsWrRmaUkXYZf9HJjwPRie9
	L4ljc/liPlIbUPxxH93QDtULvq9p+2r1ctQI7/XIEFs/2BBOmeoXiQ9kEyWVKhpkBaUpIU9
	Bt+hahoSmjCcEEMTEg+37UFzSRBjrz9mw8KSophvK7m2Moop6xGYrOmRoKYCEDvKg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

--536c7c79d9464b992ad1d7b5be05ae3641e4b875bba8fe2b43dc9e787550
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Yixun, Aurelien

On Sun Sep 6, 2026 at 6:07 AM +08, Yixun Lan wrote:
> Hi Aurelien, Troy,
>
> On 11:24 Fri 04 Sep     , Troy Mitchell wrote:
>> Hi Aurelien,
>>=20
>> On Fri Sep 4, 2026 at 1:27 AM +08, Aurelien Jarno wrote:
>> > Hi Troy,
>> >
> ..
>> >>  drivers/clk/spacemit/ccu-k3.c | 96 +++++++++++++++++++++++++++++++++=
++++++++++
>> >>  1 file changed, 96 insertions(+)
>> >
>> > Thanks for the patch, it makes sense to add all the values, to support=
=20
>> > future firmware changes. The values match the ones in the vendor kerne=
l.
>> I forgot that you had a similar patch as well..
>>=20
>> >
>> >> diff --git a/drivers/clk/spacemit/ccu-k3.c b/drivers/clk/spacemit/ccu=
-k3.c
>> >> index 92b930d5ff30..950bf531c734 100644
>> >> --- a/drivers/clk/spacemit/ccu-k3.c
>> >> +++ b/drivers/clk/spacemit/ccu-k3.c
>> >> @@ -29,15 +29,91 @@ static const struct ccu_pll_rate_tbl pll2_rate_tb=
l[] =3D {
>> >>  	CCU_PLLA_RATE(3000000000UL, 0x0b3e2000, 0x00000000, 0xa0558c8c),
>> >>  };
>> >> =20
>> >> +/* Keep the firmware default as the first entry. */
>> >>  static const struct ccu_pll_rate_tbl pll3_rate_tbl[] =3D {
>> >> +	CCU_PLLA_RATE(2000000000UL, 0x0b292aaa, 0x0000ab00, 0xa0558686),
>> >
>> > Is it really necessary to put this entry first? I guess it's the curre=
nt=20
>> > default frequency, but we have seen it can evolve. From my tests, the=
=20
>> > driver seems to just keep the value configured by the firmware=20
>> > independently from the table order, so I am not sure it's necessary.
>
> I agree with Aurelien here, the default frequency isn't a solid stable se=
ttings,
> which it may changes in the future
>
>> I think keeping it first is necessary. If the current register settings =
do
>> not match any entry in the table, ccu_plla_init() falls back to the firs=
t
>
> Isn't it a bug if all frequencies added still couldn't cover all settings=
?
> I'd simply suggest to bail out and yell loudly if there is a mismatch
>
> I just don't like putting specific frequency at first one as default,
> this logic is kind of fragile and tend to fail easily..
I checked the Rockchip PLL driver. The RK3036, RK3066 and RK3399
implementations calculate the current rate directly from the hardware
register parameters. If that rate is absent from the rate table, their PLL
init callbacks return without reprogramming the PLL. With
ROCKCHIP_PLL_SYNC_RATE enabled, they only synchronize the parameters when
the current rate matches a table entry but the register parameters differ
from those in that entry.

This approach seems preferable to me. Would it make sense to sort the rate
tables by frequency in the next revision, and follow up with a separate
series to calculate the current rate from the registers and preserve
configurations whose rates are absent from the table, as Rockchip does?
>
>> entry:
>>=20
>>=20
>> 	ccu_plla_update_param(pll, &pll->config.rate_tbl[0]);
>>=20


--=20
Troy Mitchell


--536c7c79d9464b992ad1d7b5be05ae3641e4b875bba8fe2b43dc9e787550
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCap1MiA0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQv+TcBAKuYgm3NzSdu2AewDdZD9GRhXTKU8Kg7xc4yVrlo
nVfcAQC2ZNkxsjsFJBZyiwSwQYWdYZq+bsxMX1yf4dEkWAOCAg==
=J7rf
-----END PGP SIGNATURE-----

--536c7c79d9464b992ad1d7b5be05ae3641e4b875bba8fe2b43dc9e787550--
