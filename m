Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA983502A6;
	Thu, 16 Jul 2026 05:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784180696; cv=pass; b=PJxNGDfh5BxOm1YDgSZrj1T0LqKa4zWY4b2pwD4ACT4Bel6ULxWYWJOBahDb6vLjet7f5kWMOKnA11FYLiMCpcqrvT29u7YOM3af8EJh51KGLhyp2yK9f7MsmnO2CXmIyJGD9dpxjcm/m/7FqRMADirLRFlA0AyDMBteotQdlZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784180696; c=relaxed/simple;
	bh=2PCkMDvWWcH4DCgVA86f2HeJRrIp15gTjszgHbB/Gk8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=elHcvvcSWrunF6j3be5QfuCtB97KytP8lDdijit7ACf+9ojJFZlRi6cxi34iOQfh2p4J9e/5BVNzffnSEnH00x5t2zRhhZaLxBzy3FEt5gwNY/H1x6T9KdEoBov3547LLu2D6VY6WjDdTBQ7iunA5lEKR1srgYxOSkb241iqxsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=XewNvTXu; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=/6G7JcFj; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="XewNvTXu";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="/6G7JcFj"
ARC-Seal: i=1; a=rsa-sha256; t=1784180671; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=grh42za+CfXnXYzwafiYmlonxp82ZTcX25XrjDgk0WAJSiz50Oq0JOcFUS/VUIhcxV
    GWFHZC87M5YFfRsS25YeiNI6gN3+Lm0r86Voffjkh4DCkHNBan1T7drUjSMlSfnw5geg
    1Mc6/N6tFMq5l2kIhi2Au+GJl0lfq4wXZDW7c4wBXuSeLsPCXoMpZEFhOakS8CNVX8JB
    v01o1s71PfckjZnFiM1e/jQmW6KTQm/0w9X+9E5iTZRvQvhICcTRvhuvh6HAzdX/mgJv
    cwnn51nwVX59rRZg7Qgc5NMvGy40PNY+v0NMmt6OnyF4oxB03MyU75wOLoXSAihJAgxv
    io7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784180671;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=2PCkMDvWWcH4DCgVA86f2HeJRrIp15gTjszgHbB/Gk8=;
    b=Q5uc3jHm2pKeldJwf6HfCO3wBPnpAbmv4cSqM8gNzbAOaDymMVzhzgd1X6fjZJKInT
    QtlHKQV0SVV2lo2xjoKtcmv+kJ7O7S9UDqxnp3K20WyDfdeIQDSu2+ZNULWsg9YxBTy+
    J5X1uT+DUqUbhuLKJpJhNEFWqRQ+cJLMgkviyBA2eRdCmIAuOavl1EX58xEZE9umdkxt
    W2rP8mBgFyeQxN6gvpXV+qJsKxmotKyIBPKF3wen1Xp0/BA97pDUGxmeYXgs/lEG2k+k
    9AdjBzvdmkIzBbTv6Z6RuVacJV3mSlIKAoOj83rL4lBgclELy6+eQf3sExoZ40/dGjnV
    PKEg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784180671;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=2PCkMDvWWcH4DCgVA86f2HeJRrIp15gTjszgHbB/Gk8=;
    b=XewNvTXu1hU9vl43cwi128tkvIbdqd4wQ8sThUriuARaUVrj3W2ncYQeL2RZBgwrZe
    f4cX1yXYQS4utDs/tUjNqPtkOmpix8mUi68pkDDv2xOZVnr1Wj3dylbvuA2kOlq4VWKe
    6STorx5Ed9the/T01CCP5++wmMj9vwdYMFVoZlz2F8paq8a8O0Oj8l8e4iduCqlBSzoY
    PDzPdxcb08yGA2i8U+M9tgLqmExp3yWZ2ddDKYqzXS+P2V8dVt2jVISL/J41W0URhIa1
    NTLWoSknousWv7CUtWOX4SndYcxqnYlnacKqJq5yDR4643UhIIkhNGN25zaBJLsfXtYD
    Wgsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784180671;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=2PCkMDvWWcH4DCgVA86f2HeJRrIp15gTjszgHbB/Gk8=;
    b=/6G7JcFjVzIuZuGwSA5MgAw8FOBvOs8F2CTQwTQXMT/vA4TXeXb8fW4y9G9N2YnTm+
    BiGXZcvgjOqWqlK6TQBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrS0JpbnciN91XW8E80PWrsnO/pbEWoW6mxNf+m"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426G5iVZYF
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 16 Jul 2026 07:44:31 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] i2c: jz4780: Cache clock rate at probe to prevent CCF
 prepare_lock deadlock
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <alf7rSWaLBO8WBkR@zenone.zhora.eu>
Date: Thu, 16 Jul 2026 07:44:20 +0200
Cc: Paul Cercueil <paul@crapouillou.net>,
 linux-mips@vger.kernel.org,
 linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <36148F30-156F-4E74-8765-D718F6FE7E76@goldelico.com>
References: <c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>
 <alf7rSWaLBO8WBkR@zenone.zhora.eu>
To: Andi Shyti <andi.shyti@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)

Hi Andi,

> Am 16.07.2026 um 00:07 schrieb Andi Shyti <andi.shyti@kernel.org>:
>=20
> Hi Nikolaus,
>=20
> On Fri, Jul 10, 2026 at 08:58:35AM +0200, H. Nikolaus Schaller wrote:
>> Fix a severe AB/BA deadlock between the Common Clock Framework (CCF)
>> and the I2C adapter lock, which triggers when an I2C-controlled clock
>> generator (like the Si5351) is registered or modified under the CCF.
>>=20
>> During a clock frequency change, the CCF acquires its global =
'prepare_lock'
>> mutex and calls i2c_transfer() to update the chip registers, stalling
>> for the adapter's I2C bus lock.
>=20
> I don't think caching the clock rate once at probe is safe.

Ok, valid point to discuss.


> If the controller clock rate changes afterwards,
> jz4780_i2c_set_speed() will keep using the stale cached value and
> calculate incorrect bus timings.

But: is clock rate ever changed during operation? Usually it is defined
by the device tree constant.

What is the API to change the clock rate during transfers? Is that even
possible?

BCM2835 appears to have a hackish solutions to register its own clock
divider and provides clk_bcm2835_i2c_set_rate(). This never happens
during normal i2c transfers so would not block.

OMAP does the same as we propose: call clk_get_rate() once during
probe inside omap_i2c_init() and never during omap_i2c_xfer_data().

Finally: how else can you prevent the synchronous call to clk_get_rate()
for each i2c transfer?

BR and thanks,
Nikolaus=
