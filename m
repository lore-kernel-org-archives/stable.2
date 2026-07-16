Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341B82E7380;
	Thu, 16 Jul 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216836; cv=pass; b=ekJk3aw886JzntUSOm2u0n33yh2kszMlxRmWecsFyNpDhpUl4+Nc7PRC/0EnlCqMHV+9aVCaTy/u1GJbqf4awH7VuvAfp5h/wZ1VGU89k6H4hxQLc081UapME4COEnhGDbAFhdsKBFrCT4wG8m9z0GCbIA1hdV5Tq7GWFQN9xyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216836; c=relaxed/simple;
	bh=1hx0yJ3jK10AJqygvr6+N5F6p5W+b8ub4oFkklGbOic=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=g5H0suVRa92nCLs+/b1MYujIV+nyd6KJwXYz7dWNYW1Hd9Buik3I4omGwkduEfjt5xVyFTcUtZs73sDoLYDZv4VBt7HpnjBoDxyspq2G46Wmir3CQ4DPwGCJPeA95D07FoqskPXnkpUNHp7jNaWrrmToJZbUGcm1ugTOkqVv8ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=mjqSGiud; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=FcBIuHc0; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="mjqSGiud";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="FcBIuHc0"
ARC-Seal: i=1; a=rsa-sha256; t=1784216815; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Fr0A8QF6exF9BrO52nCOudGott7I46BY5pF4KoX5RNJXLeDFgrNaEhqD3MAbu+sdg6
    GAFvPKgc5C3x6r77f+dGBCIYior1+SJumo+6W8QlbD1koYlhKgxB4GUGFb2jJZHacUCk
    te6B9v+AMDqbt6YuxUSKXiEivCH405D33cQh2yXSQd2d9AOJ5Ajfr2dIh71D4CbgvaUR
    AR3LCJBgp1vqeLDKNtnemvz77IqMsOkgtwU/yz205+uFwGUd2ohNThAH2IgIMvo+7oDc
    KUskB7RqruaB7/xcRo0TsY/b+AHhcNj3RLNXyA2J0svR+Ri34r2QbQzR7aFcoWyNPN0G
    NpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784216815;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1hx0yJ3jK10AJqygvr6+N5F6p5W+b8ub4oFkklGbOic=;
    b=eAaBVm+DjzCglKmE13m8Fg+sM13OJti6i3k+arctcU2o4XQn4G+khGnBz9lLGrEkAk
    79hmxvAHhe08ZPgQB195pERIo293eckOCoTu6chUio9+7uY3NfEgigFBQ1SqheC1aOyY
    glnExQjxAXsNKzLqG9ravheUR9GhJY4GYxxaxonE+wvrkQEV7KOwUpTipIM6B85wMNNp
    p9bDAqnIi03aBrIkJIEkmp34jam9B7GA5aVRyJ9NuvvMn9X/qyxV1Q1GA2tfwDO/yvmi
    yUQ7d5SpuxiUKs+MWgD1QOOznY5yJdXptnN0+6NC4fmbtyIefNcTdhH71vDQrkqFg+yF
    p4QA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784216815;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1hx0yJ3jK10AJqygvr6+N5F6p5W+b8ub4oFkklGbOic=;
    b=mjqSGiud2i1J/Yj6vs5ngW6IPXFc/DIP1ecFj0R1nue5VnJSYkIDsgQ5bHbCvzEgMJ
    c4FnHdr70uPrHY1BxV6zDU28ZXOx5xg6HET6Z/7ke4M7OCj3/I1HvnYg8I1m0tk+/bEv
    1UWEA6PEYB9RxNDuxwytwCzUzNBLSjMIHU4/L3GBgfbu8N4Q7F4WudXajD+WCU9S5yti
    n9wxC50ElR/2VF7UuemJTU4MZsOdyAWAd+TcGBVzZ0AJsDiisbJoxihmtxb3XwtOFaD6
    WDStYDc/O9Xtr1RJ0pa4XsA5XHA1f+RGAXN+9LgW5B3HvRMBnioku76JIkzPruiD3QIP
    ssEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784216815;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1hx0yJ3jK10AJqygvr6+N5F6p5W+b8ub4oFkklGbOic=;
    b=FcBIuHc0zUlFJAoaznz6KUp55qwySNpzYaiA3dJGUp+YwTvbkjtgtXo6UyaJuXFZAv
    03Gy9fIBD2bSPtpFmPCg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrS0JpbnciN91aF+UY0Pm4r8tXCtzZjxu6AAT8="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426GFktcVp
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 16 Jul 2026 17:46:55 +0200 (CEST)
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
In-Reply-To: <aljysQFgUHuVDAgK@zenone.zhora.eu>
Date: Thu, 16 Jul 2026 17:46:44 +0200
Cc: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 linux-mips@vger.kernel.org,
 Paul Cercueil <paul@crapouillou.net>,
 linux-i2c@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2ADBFA2C-92EA-4930-89CB-A6C52E1E61C7@goldelico.com>
References: <c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>
 <alf7rSWaLBO8WBkR@zenone.zhora.eu>
 <36148F30-156F-4E74-8765-D718F6FE7E76@goldelico.com>
 <aliLbNJ51Ns0dIHX@zenone.zhora.eu>
 <9421BB47-EFC8-4D82-989F-82A84FE46749@goldelico.com>
 <aljCGkhZEQHzZVSW@zenone.zhora.eu>
 <500EE2C0-B916-47DF-874F-EBB2CF1C779D@goldelico.com>
 <aljysQFgUHuVDAgK@zenone.zhora.eu>
To: Andi Shyti <andi.shyti@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)

Hi Andi,

> Am 16.07.2026 um 17:08 schrieb Andi Shyti <andi.shyti@kernel.org>:
>=20
> Nikolaus,
>=20
>> Therefore I consider this as a fundamental design flaw which is =
solved
>> by this patch.
>=20
> I'm not arguing the patch here. I haven't even mentioned a single
> line from the code. I made a simple question and you keep

Sorry, but I did not read this as a question but an argument against the =
patch itself:

"I don't think caching the clock rate once at probe is safe."

This can be read as a "nack" and request to fundamentally change the =
code. Therefore,
I asked for suggestions how to solve differently.

> If the commit message is leaving room for questions then you need
> to make your commit message clearer.

It took me long to understand your misunderstanding, and now I believe I =
have found it.
It is because there are two clocks involved which can be mixed up.


So would you be more happy with:

[PATCH v2] i2c: jz4780: Cache host clock rate at probe to prevent CCF =
prepare_lock deadlock

Fix a severe AB/BA deadlock between the Common Clock Framework (CCF)
and the I2C adapter lock, which triggers when an I2C-controlled clock
generator client (like the Si5351) is registered or modified under the =
CCF.

During an i2c client clock (generator) frequency change, the CCF =
acquires its global
'prepare_lock' mutex and calls i2c_transfer() to update the client's =
chip registers,
stalling for the adapter's I2C bus lock.

Concurrently, an independent, parallel transfer on the same bus (e.g., a =
GPIO=20
expander handling LEDs) can hold the I2C adapter lock. Inside this =
parallel=20
transfer path, jz4780_i2c_set_speed() calls clk_get_rate() on the host=20=

controller's input clock to calculate bus timings. This call attempts to =
acquire=20
the blocked CCF 'prepare_lock', creating a circular dependency that =
freezes=20
the system.

The jz4780 host controller clock itself is static and never changes at =
runtime.=20
However, calling clk_get_rate() inside the active transfer path =
introduces=20
an unnecessary dependency on the CCF internal locks.

Eliminate the synchronous clk_get_rate() call from the active transfer
path by caching the static host peripheral clock rate once - inside the =
private
jz4780_i2c structure during jz4780_i2c_probe(). Update =
jz4780_i2c_set_speed()
to use this cached value, safely decoupling active I2C transactions from =
the
CCF internal locks without any risk of stale timings.

BR and thanks,
Nikolaus

