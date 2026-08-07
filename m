Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35A125DB1C;
	Fri,  7 Aug 2026 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107212; cv=none; b=rxlMFSkWRWXl+zizD1m3uBc6eNFVoaQErVhWOts/rarQchH2pwt+wKqSlA4OD55SIujZxyR1ZUStkkfBQ6TghJNaCnphLCm6gIFWyCTvQL4SqGvY4z0v/SWgN0S3n9uYPI/KP64wHkI4lReRLYmbgIlGtWH6sCqdY4F0/dxjZcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107212; c=relaxed/simple;
	bh=rUkBAjb3eEuDoy2WuDuyIP98jM9oBwsHgsWuCSkxWrc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=L0LpGNBjHGRbNh+G9CfbvE21qdUrT5FzODNX7GWxoLnoLv8zxzek1bj6hkvnl3u73sMVE4xAfCbx661vbdCu6Uswtt0VUdkLYPZWjpAeBEeo0rJARiqGGkX4sieN6+bv0iwkdw0SVqjjtfZzydHs6BLI2PHFD13Kn7eO0JLDoOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.190.163.182])
	by mtasvr (Coremail) with SMTP id _____wCHgD8j1XVq5NxyAA--.38353S3;
	Fri, 07 Aug 2026 20:52:52 +0800 (CST)
Received: from smtpclient.apple (unknown [10.190.163.182])
	by mail-app3 (Coremail) with SMTP id zS_KCgB3jW8j1XVqOqsRBA--.31227S2;
	Fri, 07 Aug 2026 20:52:51 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] ieee802154: cc2520: fix FIFOP work use-after-free
From: Fan Wu <12321260@zju.edu.cn>
In-Reply-To: <87pkzucdft.fsf@bootlin.com>
Date: Fri, 7 Aug 2026 20:52:41 +0800
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
Message-Id: <4A1FAADE-AC28-4197-8547-EC7EF5ECE927@zju.edu.cn>
References: <20260806050328.422480-1-fanwu01@zju.edu.cn>
 <87pkzucdft.fsf@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:zS_KCgB3jW8j1XVqOqsRBA--.31227S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?G/yVVwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WPoyxOUvSJwEUFKaRvEar3skd5reE36IWJNXy2ehh2UXY9E
	R1h2aZX6O1ig2+h8hVCp9E6mavGmQbzmcFsnzP86
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

 Thanks, this is a much simpler solution,  I will respin accordingly.

> On Aug 7, 2026, at 20:39, Miquel Raynal <miquel.raynal@bootlin.com> =
wrote:
>=20
> Hi Fan,
>=20
> While I may agree on the problem, I don't like the solution. It is
> overly complex. If the problem is the fact that we might queue works,
> what about disable_work[_sync]() ?
>=20
> Thanks,
> Miqu=C3=A8l

