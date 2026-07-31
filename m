Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A6357CEB;
	Fri, 31 Jul 2026 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477922; cv=pass; b=SqLAFGO1zmzwqRct+4S5Kc2GtktnMT02+WOH3YwrVkw+qAaQqaM2uXmkpotrMmrhURvgchfkXfv38EXJnDlXC9kYm5BYnTDUMZypQ74iZmwl4yeCHHtxBzq3vtaj27+mTlRN3rP7F1E0NPA3Cqn6uNLwmreJGfGqxy9P31dDpxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477922; c=relaxed/simple;
	bh=FZPuiNPLColRGuD2p0o4n07puVxWjsu8hBU/ZFNjAL4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=H1tP0NqXc6TU71FQjRz0NMXhDBdRqmcX8tr3Jhg3ncbWzwo0qBU0LO2wsGpA965TrpSPf/k3+APNuBXbSs80aObLnqcLv7Z4oQrpel+1fdWuFX8xTtkgl+SQ1lPz2zSiZjyTIUvkr0oNc4m7MYLYb0/L3ZOGOMqHFJwg7fZmYQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=WzeMwm4I; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=xjQm0LrB; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="WzeMwm4I";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="xjQm0LrB"
ARC-Seal: i=1; a=rsa-sha256; t=1785477896; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cn54T8Pph86GPd3iNW60mFsdTv+cVok/7GC4P9/PJupPumyf58wt1gXGrs8+XH/cv/
    TCOD7YpgoqbIUhBHlTAGg6XawUucbqXJNZVVEEE8mAkRX8Cvd12CLyBNTjhBdHA57QZr
    foqe83lzKyvG0YFNqoQfZZC9bjU9K9QXzzPMBDqhQh/vSVQpnObDEMjuSP2DR3i46Ozo
    l38axfV9nphoWrYRXkpzhZDvPDyH82IFCrZXYct1W4HJ0e9sLZT0SIX6kIqRSKJiyxwF
    QRNUCKXG9G03nxfYH5MrOsJZbFYjbEmzN32giuLZD9lLCtewVOiJU54uhD1vGh0D3sKu
    9+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785477896;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=uuXJa+xDFktqYPmqVdoF+1ivi4iMQpzMIO1q+Wq+kPE=;
    b=gUVM0PmmF6d0UJDyOy1MGi6jSWjyiJlioYUcRjHCfJSQ4fz+t+n/KkypEzBbZHmn1d
    b8kZ57Spi8h88rrtDaYYAWTTL/FfJ9KE1fVO4d0DYwkZTy/k7M7BMgl1ZvaI1mqzOnDE
    JIy8dwesmO/mxbnB6be4r/+DjMd80q66Qs7hUVfzNNJSHrZkOvREpRMolICXSEyC3RYj
    13Tzq9oecEP0pKhuPFPFOSMhscg/ld2AIq++x7hQhzg0MD3S2mhoLr0uCaezebPgnR9S
    DqcIG0vtRSGtJM6A5dmG7sCi1BUO0tPeOflDcydogCFjKVXXEeu11VVKF6RCTkl5ltSi
    CFDg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785477896;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=uuXJa+xDFktqYPmqVdoF+1ivi4iMQpzMIO1q+Wq+kPE=;
    b=WzeMwm4IU75d9jmlhS2VGKBwsQ80aoylCPr9pBY15I4q/x4sVOGQjbnb/3m2GGnUaE
    RcgPxYBsZr73qaetTsyX9fTVD+L0xd0cRQwAdJR0YHGhiAC9vBDgp9xbrWCnY9sjrt4b
    ACbdYqRd0cYosLuNUKz7w3i+AK5FeKD82MgWlEt4UNqC2I4eP9g2HX1y/w9b3oSqn/u3
    BwTuA3QVDVgkn3eEqMLnw3BIdQ0FUfTqbl0ab1lfW+mvZhEgyb5ctDc9Vy8PFkZMZlXb
    NtO1ybgOGxxekD96SpHfp5q+7A072OEgJ9iyiCxh+p9VaKBG9//p+SykB41MHMiDyq88
    TmvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785477896;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=uuXJa+xDFktqYPmqVdoF+1ivi4iMQpzMIO1q+Wq+kPE=;
    b=xjQm0LrBPvtT9sc2Xfppam9927IebyDYOLywkDEs/gDNZ71vZbEFdg1DhwCA31NXXi
    w6G0Ohffz8gQcwHGLzDQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ3poGy8iN5FQZqiT/KMInHXoNih5eIi83vL33"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q58eac26V64u62v
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 31 Jul 2026 08:04:56 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH v2] i2c: jz4780: Cache host clock rate at probe to prevent
 CCF prepare_lock deadlock
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <amfGZudmo_oNgf04@zenone.zhora.eu>
Date: Fri, 31 Jul 2026 08:04:45 +0200
Cc: Paul Cercueil <paul@crapouillou.net>,
 linux-mips@vger.kernel.org,
 linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3C4DA12-B486-48F6-85D3-E11648EBE8C2@goldelico.com>
References: <2db6fd233aceb7238474e4833f4d25ca681c3ffb.1784492382.git.hns@goldelico.com>
 <amfGZudmo_oNgf04@zenone.zhora.eu>
To: Andi Shyti <andi.shyti@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)

Hi Andi,

> Am 27.07.2026 um 22:59 schrieb Andi Shyti <andi.shyti@kernel.org>:
>=20
> Hi Nikolaus,
>=20
>> Fixes: ba92222ed63a12 ("i2c: jz4780: Add i2c bus controller driver =
for Ingenic JZ4780")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> To be clear, I wasn't against the patch itself, I just didn't
> like the commit log and I raised questions coming just from
> reading the log.

Sorry that I did not get this because I could not see a question.

> In this v2 you are missing the changelog, please, don't forget
> next time to add it.

That is the downside of too much automation on our side. It did
not properly catch the case of a single patch without cover letter.
So the changelog is in the suppressed cover letter...

Here for the records:

PATCH V2 2026-07-19 22:19:42:
Changes:
1)  improved the commit message to clearly separate between i2c host =
clock rate
    and the clock rate of the clock generator which is controlled =
through i2c
    Suggested-by: andi.shyti@kernel.org
2a) changed to clk_rate_khz (and moved the division by 1000 to probe)
2b) fixed the variable type and name definition (wrong spacing/tabs)
    Suggested-by: paul@crapouillou.net

PATCH V1 2026-07-10 08:58:35:
initial version.

>=20
> I merged your patch in i2c/i2c-fixes.

Thank you very much.

BR,
Nikolaus

