Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751733;
	b=IlzGFnI1RGLOU0O4c/GHUmMGCnIYW4chdXtQterS8y9P2bycJxrt+2A05NUkoMZymoQ5
	 M63PNj9uEuFF/5hpx96t16jKXt0zsChZ5d2OFWvLcstKel/DSu6QQxgQj0XRDHK5s6e5P
	 8pz30Z/MuCKYoARijcS/9CiCdP/cy6e0qikfSt9koYjU9p63nMfELYO7ytQCHoQCFPP3O
	 /7BkMA1oi2WAXOdVt7wyJZVU0iXIxBEHadVQt/DowTEnargrfIYAO9c4G+9cawl3qqLwD
	 sA1z1zNvq3DIz1O/bBOwDbD5Dca33HSPTyy+ME5RmMzzsnNIUgbzbNO/XPo6aI7J9fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751733;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=JUy2Lmpej4xnERTXpUx7lz/gMVfiYLOHU2C0M4X8NCE=;
	b=qIF9gmeRb7R46qVhMzqg7pqOO5NTLfGGq8R2qE12TAPUTEfpHtz9Yz+eVUejHT/ERWKB
	 GROktUpwCpAr7qUqkVqkfcxhZLbup3Z8Ftm8l2u59rzyUBda2N6NR0l/QPDEhr4fScNcX
	 X8PwMhIbN1i6XqQ5kZLK/1q7CcKxFPYAuuUCrsao4bPVcHaxYd6LiRnzAjjUyUzVLS0T8
	 rXd3+LvZeV8OeUrah2KBETnKgZNiDfeb7yWOJ/2Lifaf/U80ymsiIJbbFUPZIovwI0IyO
	 f9iryj9CM2N/ZdNqCZegegu6Kjo6VPKTu8YrZXf94zz9nLuzG0lMqLbAp3HNAAYtCbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=qSzFV7sI;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719A606A31D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1719A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=qSzFV7sI
DKIM2-Signature:  i=1; m=1; t=1794751731;
 mf=PHdhaHJlbnN0QGdteC5uZXQ+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.net;
 s=s31663417:rsa-sha256:Y+EZWlcBt9dIWRWSS9rs7v3YmSoP
   UWhzGVNwmkS2T98gdXtw1lmF4HS/NP60ZdlcSpG6vt/mZa2FAoRLax+T6xkpVoeHYhmOz4biwIZ
   kKUwT/atXDz8jVF2ZAwu7DRNikeYAv4eXf2gzCK5mZ1FPPsvt5eU0EoP8iWKqaMblkowsE2R/Au
   ZQbuoCSqQZJeQM6l7f6q4A22xfbsvr7gJghx+osPPs4EMZcviNK2OTg2YYI7H3QDOcyhY2w7vQc
   LBjexG27NAOo9GCqRCVMSGTrrcYqJWX6PWfJMkXLfSe9Uoe+HFgiiuJICc/+WhbJqC1GyIZbM8T
   ycDiCa1ibZeuhA==;
Message-Instance:  m=1;
 h=sha256:
   E9jGeJWkqatQxmE7ggRSW0sqxmLRWZXEmbk2/hI2CS8=:
   HnOwQpmKBtCLoScExv0yxLqFIJvU9f5XcAl+vtj/TRo=,
  sha512:
   +QhEzRr1QaZWaMIpbRkkEm//sf0ove114tZv/wIDoCUwviln0ywnzJ5g/99igwOuswByjdjKzURK9CSiNJmE3g==:
   POrytf1dfEja9CckZja2BRbX3YZ7Be1EkP7j2u7+UP57r4Vyh4zM4LxZvWkJZ6ZPjqGuDcl3VRE3Tx7FxgBjtg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794751706; x=1795356506; i=wahrenst@gmx.net;
	bh=JUy2Lmpej4xnERTXpUx7lz/gMVfiYLOHU2C0M4X8NCE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qSzFV7sIhlMxWx6yXVOdYXcGDyJOL/G5dCZKgECnSPIsrI1PjDfV7B4lwI4igDoW
	 dBe6p3R23IUOPgy4LiZ5djaaYOV3mR/lipwgGUPsAPFJe4fQzgiAJjwQ5JlLxW9/g
	 X7SlURh5eV2LibsRCsrQfrjwmsDuGNgZ3Fd025ilkOGgQZR2B+mTZi9EQo2O+yfUC
	 BZWswcO8e5Amw2vX4aHCfGKmBNyyGtu5uDmbz0H71jaj+QDAv+uE1zg2UgL4p35Dm
	 AIFAAoE3/zE/ohEApgZdFLQBcQ/JHnJtrRE+AjCvSE84ZoMjwCNe/sY8ATkeKlQr7
	 rn/Ds9Xyevklcy8wDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5rO-1x6eAU33I0-00Kda7; Sun, 15
 Nov 2026 15:08:26 +0100
Message-ID: <490e6ccf-0cc0-4db6-b076-5d4ac5f5b8a4@gmx.net>
Date: Sun, 15 Nov 2026 15:08:23 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] qca_spi: Avoid unsequenced accesses to jiffies in
 qcaspi_netdev_tx_timeout()
To: Nathan Chancellor <nathan@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, stable@vger.kernel.org
References: <20261114-qca_spi-wunsequenced-v1-1-6b219b906db7@kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20261114-qca_spi-wunsequenced-v1-1-6b219b906db7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RjQUwp8PlpDQc9bo9XKnnJYGvo22/SEcWUYCRCqOv1b/+0Ud2Ou
 LPpC2S7PtSwUVyToCIfnwapl5QthI9sDZIdw+mdXwqa1L9g9Y7PMUKoI7a7mzmtpL4iHNfr
 6CnCZLmw5iRyOzMNMjRkbpmrDD0+LUMI0CIFXIHPAPYxDQkn/kYrNm39+wNwR3X+Ke/30Fj
 0NsVhNtzMI9aws14GT1oQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Kq0QF+Nllcc=;4U2hG9HqgmdsnivUQkPNb/bvXeV
 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

Hi Nathan,

Am 15.11.26 um 05:39 schrieb Nathan Chancellor:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in
> qcaspi_netdev_tx_timeout(), which can break the build with
> CONFIG_WERROR=3Dy / W=3De:
>
>    drivers/net/ethernet/qualcomm/qca_spi.c:805:16: error: unsequenced ac=
cesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>      805 |                     jiffies, jiffies - dev_trans_start(dev));
>          |                     ~~~~~~~  ^
>
> Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
> 6.5.2, unsequenced side effects on the same scalar object are undefined
> behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
> function call is indeterminately sequenced, meaning any side effects in
> the arguments are unsequenced.
>
> Add a local variable to hold the value of jiffies before the function
> call so that there are no unsequenced side effects, clearing up the
> warning.
>
> Cc: stable@vger.kernel.org
> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QC=
A7000")
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2197
> Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c7=
4750637fc82dfcc423 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/net/ethernet/qualcomm/qca_spi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ether=
net/qualcomm/qca_spi.c
> index 38a779f4b866..3ea745d4aef7 100644
> --- a/drivers/net/ethernet/qualcomm/qca_spi.c
> +++ b/drivers/net/ethernet/qualcomm/qca_spi.c
> @@ -800,9 +800,10 @@ static void
>   qcaspi_netdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
>   {
>   	struct qcaspi *qca =3D netdev_priv(dev);
> +	unsigned long j =3D jiffies;
>  =20
>   	netdev_info(qca->net_dev, "Transmit timeout at %ld, latency %ld\n",
> -		    jiffies, jiffies - dev_trans_start(dev));
> +		    j, j - dev_trans_start(dev));

In general agree, but imo the jiffies itself were not helpful to debug a=
=20
transmit timeout in the first place, so I hope we can avoid adding a=20
local variable here.

How about this:

netdev_info(qca->net_dev, "Transmit timeout, latency %ld\n",
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 jiffies -=C2=A0 dev_trans_start=
(dev));

The timestamp from netdev_info() is much more helpful.

Thanks

>   	qca->net_dev->stats.tx_errors++;
>   	/* Trigger tx queue flush and QCA7000 reset */
>   	set_bit(SPI_RESET, &qca->flags);
>
> ---
> base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
> change-id: 20261114-qca_spi-wunsequenced-a81e54616844
>
> Best regards,
> --
> Cheers,
> Nathan
