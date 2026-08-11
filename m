Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAF6426432;
	Tue, 11 Aug 2026 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441745; cv=none; b=fRP1bA38AHKmnKYafPI+/lC8/+A87T2DsOuKB3gLCUp2OWp/9EuKpEAbgE1e9XxtOwcib44MyfHb+xCKAMEUqT3Tzt2HMLlY8n/Mw1Sfs09Xr+iHMoCdhAN9CVinbY/Ck60oYLS0cU++pJR7YGjFEdgl8dvPBJwE5sS2bE27EIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441745; c=relaxed/simple;
	bh=ksTWRhb8Gp8pGQvgXAC7BD1Yp4E8lQUUp4nbnjn5nB0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AQJRU0/+/En1suIcBhWzJHs9qqjNAwIqam2Ktd6XzswGcvUufUToC9cFr9LGV+ZZEeStybbNH/PVjsTAVtwuKSv/iEt22XQY8e6abbn+APDnA7VTAx8czcoMcjo2exZ10E7PMg3Fu3B76R3P1wYJPIMgMh3ngNgB0rU9Mjq1Wr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.190.160.193])
	by mtasvr (Coremail) with SMTP id _____wDnAD3273pqPZaEAA--.1138S3;
	Tue, 11 Aug 2026 17:48:39 +0800 (CST)
Received: from smtpclient.apple (unknown [10.190.160.193])
	by mail-app3 (Coremail) with SMTP id zS_KCgCHUXX073pqWBo6BA--.63816S2;
	Tue, 11 Aug 2026 17:48:37 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v3 2/2] ieee802154: cc2520: fix RX tasklet use-after-free
From: Fan Wu <12321260@zju.edu.cn>
In-Reply-To: <87ik5hoycq.fsf@bootlin.com>
Date: Tue, 11 Aug 2026 17:48:26 +0800
Cc: Fan Wu <fanwu01@zju.edu.cn>,
 linux-wpan@vger.kernel.org,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Alexander Aring <alex.aring@gmail.com>,
 Varka Bhadram <varkab@cdac.in>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <491F951B-3C7A-45AF-8842-C581A2BA6ED4@zju.edu.cn>
References: <20260811010359.131381-1-fanwu01@zju.edu.cn>
 <20260811010359.131381-3-fanwu01@zju.edu.cn> <87ik5hoycq.fsf@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:zS_KCgCHUXX073pqWBo6BA--.63816S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?MyHexgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WOLxKqyhwpBSLiGVBMoefQCf/EGNP3brOFDkOGh/q1EXLbl
	eLbx/yBZc2EBjQsfIimp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc
	804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY
	67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y4
	8IcxkI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUU
	U==

You're right. I failed to trace the receive-enable path, please drop =
patch
2/2. Patch 1/2 is unchanged.

Sorry for the noise, and thanks for catching this.

> On Aug 11, 2026, at 16:28, Miquel Raynal <miquel.raynal@bootlin.com> =
wrote:
>=20
> Really? How? SRXON is only set in ->start(), which means radio is off
> until the user asks for it, which can only happen after proper netdev
> registration.
>=20
> It feels like the rest of this commit is pure AI hallucination, so =
I'll
> stop there.
>=20
> Thanks,
> Miqu=C3=A8l

