Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD403417377
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786436904; cv=none; b=eNdmDqJ8MnD9m9iWThg1FIWgqKaOChTKwo9gNAVqzFLorx7IkOGI5OAk1FrtwJTf0LfFlOE9Sviv3dwqC6SkPor/EX+YE5qG/uQr4Xh6UfbHFS+GncCapQiq0HoNVW1fhzgSjI4Xuzi6Fh8tgHwoOMF83wqOS9iNTBUh2teDSBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786436904; c=relaxed/simple;
	bh=VbRSEXzw2tVb9Xu73pH713PpnbMIkgqrV5EAylcnHJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=louMASaKyjkrwmc+eNKi3Xydzthclob6cULaMr22t17+/SMA6MNXyxkLR156r92bec5kJ4I22XZzs2Y+ycOW2ykoxCBI0ZTtC8S7nVo+1aG6se3pcpFCGiaxqw33UlknCMkg99Yh3Kv1CQMq+IW0mRkazL8+wksIuQ8gDvIwxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gKJGhV2Y; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gKJGhV2Y"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B3A2B4E411AF;
	Tue, 11 Aug 2026 08:28:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7FD036033C;
	Tue, 11 Aug 2026 08:28:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0385C11C4BBD5;
	Tue, 11 Aug 2026 10:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786436895; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VbRSEXzw2tVb9Xu73pH713PpnbMIkgqrV5EAylcnHJM=;
	b=gKJGhV2YVNtDg5Bioywqp0l0yywXqGcv0V0Qdjb4r7sMKcayAYrYNT+DWN4M2UtUz5JrRD
	UOWSenvX4BG4DPFSM5NfXZ9kA74WYpPiW0mqdMEle2m6UVLoOh+x23vc4UOhBiEfDm623l
	UmSysActHYGR4Oc2dE2xEBAvdA3qLueHy7b7F6oCfPOdGzczfH8j2qoXNEoPXjewO4IdTu
	/+GS1OW0DOJOHIWFrUOJRDgFbYjAsPCACYFa4mfKVJY0+rR73ADSmPKf2a2nutfWInON/g
	A1DyB1amL0YKnWKYl4D+u77t53psq9RiDG9E94jpr9B2e122lV2w1BSG4C37Og==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-wpan@vger.kernel.org,  Stefan Schmidt <stefan@datenfreihafen.org>,
  Alexander Aring <alex.aring@gmail.com>,  Varka Bhadram <varkab@cdac.in>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ieee802154: cc2520: fix RX tasklet use-after-free
In-Reply-To: <20260811010359.131381-3-fanwu01@zju.edu.cn> (Fan Wu's message of
	"Tue, 11 Aug 2026 01:03:59 +0000")
References: <20260811010359.131381-1-fanwu01@zju.edu.cn>
	<20260811010359.131381-3-fanwu01@zju.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 11 Aug 2026 10:28:05 +0200
Message-ID: <87ik5hoycq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/08/2026 at 01:03:59 GMT, Fan Wu <fanwu01@zju.edu.cn> wrote:

> The FIFOP interrupt was requested before cc2520_register(), so a failed
> registration could still have let the FIFOP handler queue RX work.

Really? How? SRXON is only set in ->start(), which means radio is off
until the user asks for it, which can only happen after proper netdev
registration.

It feels like the rest of this commit is pure AI hallucination, so I'll
stop there.

Thanks,
Miqu=C3=A8l
