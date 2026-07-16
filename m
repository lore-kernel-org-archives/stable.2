Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A9C25B0B8;
	Thu, 16 Jul 2026 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190866; cv=pass; b=Kfm+KZv1uJX4wtHAenZSQFD4C8wvavhZvEmrp4ZnK1xRxBxNqLBEMlU0vVfX0japnT8sKyaSnbFz3PMGx8s0G2DPBb679wgGVq2cF5kPO4oaZpdVooQZl/TCPvzKWESNaB9xN18JVSheJx1e8x91APYhO1AeW2EnxQmudcSANUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190866; c=relaxed/simple;
	bh=B0ul3NWpSQgRWUdKpoEiF1FxO7394qh4vON5Eeb0tx8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Rf+6VAnGA/i5SHEpZHlr3CoyoKilG9OoZgksFIP65vDvFIYMUyZKIFDpC7PgaEZHuQfqleeg96aqyEjk7blYDWppFGKitiNPLWMy3X7MqjLiY5k28gjByg8mYoFQa4jYwYDPfhM8nzUSCe4J/ruLRj356RRj4RIYX4eqNub7VS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=iOP0IZHI; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=WiUNWe5d; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="iOP0IZHI";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="WiUNWe5d"
ARC-Seal: i=1; a=rsa-sha256; t=1784190846; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HpmUiKEpgfKW24nLQnTftZVieNEcMwzGIA28TBwLXNCcOfbJar6McQV3lB5fuLv6A/
    wriZJWHYcPYCc1uWRIeYmMhxz2gJDruTcQXZOcWBd3Tin857KvXscJHN/jENieJ8sn6s
    8BpBmxJqTOYxqAf3LHnoWQH/M7H2qeGPUowj7k8vOYbLCJmWlgj3RBRTIyh8ZAQeA8OA
    h7aVb+7jVjw3/jMacPDn5uK3rIl2jGSIQTvz3yDfzZkK9R6OQNe4DCWMK++48yP5pwbU
    LmtYdXUuMFyNMd3TageiK3MobwmxdR9bU6wSBPv1TAnv9qvIPzNSKvvqFWiSw2+NVjWN
    sW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784190846;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=B0ul3NWpSQgRWUdKpoEiF1FxO7394qh4vON5Eeb0tx8=;
    b=JTST9sHFhKaQH7HftPpKdAG6lu795z8vUGlKa36xB5jFyhQSFGV3nOHbUgSXzyM9Ku
    OO/rjX7nysVA2Zsf754lL1qF2V1VAf1qyh9BZ4jXvJPWQHmuHibA6xWSQz1nonkeSd62
    1K2NO8KFZ+YcXXyFSRa/2jwgz8n5a4OMQovxILe4FSD/BeV0kDFM+wSJJzVGDuXw8Edv
    sE3c4wwxtAKNXEOYN/NXaKFQ1k5PBqY6hvNowWDQ/FFpDIKMYmz6nAX6ghC2igPGO+nh
    V5ftm1JiVEeMhMWb2y0Iii0wZ/KNaPIfMChwY/PLQ+Xj4w/QDosM5fAfj1Cg9WVy/OkJ
    rmDg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784190846;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=B0ul3NWpSQgRWUdKpoEiF1FxO7394qh4vON5Eeb0tx8=;
    b=iOP0IZHIZ23N2TGodRZRQVHBnuJ/AT4dU3zqSUJ8oxsrIO5fG5H8voH55BtKQDFQzB
    X9I6oH2uTm5b/Sx3OYKXAxdy7hW46q+VgwbT3+J0mH0DLfN7jYtoH0FhLi8KSZ6g9Ur9
    RgIqVUVsTYVdC8ZpEQ0eyYUvWWwolzx8ZKrCkf/MAXeqqqMjQsvfDHyitK6hn1S+tZXp
    GKVVv6gR05nWTDBIUrih4PoSQKDO8nAF3Si/6OLIfXhDryWG64EZ0moVBbcjjmxjA8kq
    WM5w1wqmEQoUaVpXQu5kP6Lg4fwrpUbVnUO86l+wwxyRoFNr212XlwU5TP9h6ptjkbKv
    p+lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784190846;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=B0ul3NWpSQgRWUdKpoEiF1FxO7394qh4vON5Eeb0tx8=;
    b=WiUNWe5d5vgFQxeU6Oghy4+2exNIpA1uIhmbFrO6Jk1y6y/XG+khB1u4Ju57N7aDAF
    J4Jd74BNAOXz0xxS+tCw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeDgZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Q4b76426G8Y6aU6
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 16 Jul 2026 10:34:06 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] i2c: jz4780: Cache clock rate at probe to prevent CCF
 prepare_lock deadlock
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <aliLbNJ51Ns0dIHX@zenone.zhora.eu>
Date: Thu, 16 Jul 2026 10:33:56 +0200
Cc: Paul Cercueil <paul@crapouillou.net>,
 linux-mips@vger.kernel.org,
 linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9421BB47-EFC8-4D82-989F-82A84FE46749@goldelico.com>
References: <c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>
 <alf7rSWaLBO8WBkR@zenone.zhora.eu>
 <36148F30-156F-4E74-8765-D718F6FE7E76@goldelico.com>
 <aliLbNJ51Ns0dIHX@zenone.zhora.eu>
To: Andi Shyti <andi.shyti@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> Am 16.07.2026 um 09:43 schrieb Andi Shyti <andi.shyti@kernel.org>:
>=20
> On Thu, Jul 16, 2026 at 07:44:20AM +0200, H. Nikolaus Schaller wrote:
>> Hi Andi,
>>=20
>>> Am 16.07.2026 um 00:07 schrieb Andi Shyti <andi.shyti@kernel.org>:
>>>=20
>>> Hi Nikolaus,
>>>=20
>>> On Fri, Jul 10, 2026 at 08:58:35AM +0200, H. Nikolaus Schaller =
wrote:
>>>> Fix a severe AB/BA deadlock between the Common Clock Framework =
(CCF)
>>>> and the I2C adapter lock, which triggers when an I2C-controlled =
clock
>>>> generator (like the Si5351) is registered or modified under the =
CCF.
>>>>=20
>>>> During a clock frequency change, the CCF acquires its global =
'prepare_lock'
>>>> mutex and calls i2c_transfer() to update the chip registers, =
stalling
>>>> for the adapter's I2C bus lock.
>>>=20
>>> I don't think caching the clock rate once at probe is safe.
>>=20
>> Ok, valid point to discuss.
>>=20
>>=20
>>> If the controller clock rate changes afterwards,
>>> jz4780_i2c_set_speed() will keep using the stale cached value and
>>> calculate incorrect bus timings.
>>=20
>> But: is clock rate ever changed during operation? Usually it is =
defined
>> by the device tree constant.
>=20
> That's what you are saying in your commit message.

The Si5351 clock generator driver is connected through this i2c bus. And =
that
is referred to by "when an I2C-controlled clock generator (like the =
Si5351) is=20
registered or modified under the CCF".

Only then, this bug faces surface. Because that driver changes it's =
clock through
sending i2c commands which also ask for the lock.

But again: how would you solve this?

BR and thanks,
Nikolaus


