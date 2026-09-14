Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE446DFFC;
	Mon, 14 Sep 2026 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389682; cv=none; b=WCaIPp2+aC+t56mwL+01BoqiCu3gdY/QgBZ8CKRZYkuMnxvAZ2cdR2GJ1M8N3+wDT5zzLwJZyM5MLjBR+3cDyxQHLvswoZ7OQkyVWyUIS9IVJELO1EWxrwBc7B+O1hUJVMY0XxBWpMpfdwGDmJjNRAtNqRxyHIMmuSjXPGG6+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389682; c=relaxed/simple;
	bh=Tst/gkuYm77XHX34KHxK3ewavYdSJA5DNW/zjPpoDBI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=OnX3QaJNC9QytWlUu0QeawlU93xs7N9SwdYx+UIplpOefXKihj7ikoMzQ9FdF4BqId9ZnIyKD+Nc0NF3f4z4vkaVbFssmga3XKbVriV9isaDH+Lqpluaxc+ujJyJtWueJ+JzWJ+y5lckOaayBGIwFoMg976uT/w+feF+hzVSlWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv/C2vGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv/C2vGe"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C05CF1F000FF;
	Mon, 14 Sep 2026 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789389680;
	bh=Tst/gkuYm77XHX34KHxK3ewavYdSJA5DNW/zjPpoDBI=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To;
	b=Rv/C2vGe7WkLGwuhP9jXnFEXcjrsmNOPAzPudfslA521TVBLb2VEZWJefjnjfsEFh
	 xamCGE/Xa/i9ip1fRSkkzfKfb7PL44rgu4BTjO6JeTbzTfVY2VokoNJUP4hc2fGthw
	 tPT5WDIIgWr89aPyPVL6cKZxGcRUJ/nqP0zrXQvn5rbdFUEbNO/JAOIIre8NZr7n3Z
	 WuJraoLWO+GQ/HbagQVnNTqOrbJttFQAArshxr9EzOCN7gd1tabGWZGZY8WMvWfoPE
	 cyxrfSSpjX/7lucJKqk1z+O7wXtO+ie/nwdC1hOPEgs9mDNaBpY8S3vguUSBN+gTZx
	 dcLvdtkZ918pg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=bf82c561be75f375517875bce1e7e11225900b8e43d462a84e4d39fe35d1;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 14 Sep 2026 14:41:16 +0200
Message-Id: <DLF1P95EJSHN.37NQ86W91QPUU@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: fix the lock left held by
 spi_nor_rww_start_exclusive()
Cc: "Itai Handler" <itai.handler@gmail.com>, <pratyush@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <vigneshr@ti.com>, <richard@nod.at>, <takahiro.kuwano@infineon.com>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20260914081149.1916589-1-itai.handler@gmail.com>
 <20260914081149.1916589-2-itai.handler@gmail.com>
 <87ld94owzj.fsf@bootlin.com> <DLF191CC4QMM.1SNYEHUFJ9GK2@kernel.org>
 <874ifsovtz.fsf@bootlin.com>
In-Reply-To: <874ifsovtz.fsf@bootlin.com>

--bf82c561be75f375517875bce1e7e11225900b8e43d462a84e4d39fe35d1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Sep 14, 2026 at 2:34 PM CEST, Miquel Raynal wrote:
> On 14/09/2026 at 14:20:05 +02, "Michael Walle" <mwalle@kernel.org> wrote:
>
>>> Michael, since we already got a cycle with AI walls of text just to tel=
l
>>> "fix that damn conversion", can I (or you) apply that other patch, so w=
e
>>> can get rid of these? Let me know what you prefer, although I don't
>>> remember where that thread is.
>>
>> It's already in spi-nor/next since last friday.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/log/?h=3Ds=
pi-nor/next
>> https://lore.kernel.org/linux-mtd/178913311701.1915651.47916242157873961=
87.b4-ty@b4/T/#me3b51a242469a4d9722089e18547e87fdc65d7c9
>>
>> -michael
>
> Since that one is "big" I would have merged it through a fixes PR. I

A big one nobody cared until the rise of AI agents actively searching
for it? :)

> usually send one around -rc4. So either you push the patch to mtd/fixes
> (or I do it) and drop it from the spi-nor/next branch, or we keep things
> like this, which is also kind of ok.

I can move it into fixes though.

> Regarding the use of `git push -f`, I know Richard, Pratyush & Tudor
> highly dislike it and avoid to use it. I find this tool pretty useful on
> branches like ours and prefer to drop a patch rather than carrying its
> revert, or messing around with merges. I prefer a clean history rather
> than the absolute lack of -f. We already have the (Linus) master branch
> milestone which is set in stone, I don't get the need to create one
> ourselves.

Yeah, I'll probably use a force push as I prefer the clean history
too.

-michael

--bf82c561be75f375517875bce1e7e11225900b8e43d462a84e4d39fe35d1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaqfrbBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gRgQF/XoPoGaXw3p8qCLuOz5PYHYF1BVcAbGa2
3yP6x7R66ihbclmy7cQmVK6Tow16TjbCAX9HiUB0cjuGGIn4ZTNluGxjK1lbFJTo
L1DJS7ASKZpRQ1PykvKqc9omfy8QGHlYL9E=
=I02L
-----END PGP SIGNATURE-----

--bf82c561be75f375517875bce1e7e11225900b8e43d462a84e4d39fe35d1--
