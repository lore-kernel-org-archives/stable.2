Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103932;
	b=Z4uKXBMpOXQtWMCqXPOIoK5IbWhb7iWC29NtzSKRjaxUvO8DiNnQWs/kIgfb4kI+jPVN
	 KiqJl1dDre7mqjWluB1Kkp1lPiZf1xsIoFhMk+9IOxa96hpIxk5HvQdJxlFFMLHsPOimq
	 yNHLe5auzWCkM+btHm0y8Fl0CYmarxzxhD+fy7RPE8Ycc1JDQf6OR/IVgMFKbpGs872eA
	 7kAFeojFneyXf8vpgbN7HTG0os+j1dEbm6cm7EbbO3Vrn8wqysG7VFD56bFrwEv8pi0as
	 crWN+/6nYWvbv9MXzaLD+aEC+YIqdexXT9uUsYlAYggK3kluvQ4QGdP0soOXGGq8nVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103932;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FAdS4BWmwO3+sFTq7Kut36ppic9RAnx4z1UJ7r8XW44=;
	b=wqj7vMt3VNuzlzZPeqHSetA+0/GDDackWlkGDyRSnbXx+DwkKkZCM6jP07zDhx5SM7ZU
	 GQpDIj+0tZ7D/KcKlIPyrrdp2gMtOQkklrv2iWVClP4191xWTI3qBbWAE/7jQc28eBL4L
	 QiXV1IXb2mvzsYXh19MjmDPFA2THDkyD/TPIZLw4ICSohP/IG4GTeQZjVzZMCnP0FqaN6
	 iP7cUGkU/1YwGCBdnv8+t1KGPLn11S0LLUeg5Aj8Qst6R0dFlF3NZDBne88glL0MJ03Rd
	 kdBlM46X/PnT+6CU4AwoHZyIzVJFdZq1MyogQn4hGikBGTPN9MIGAT3SlBc7SVII+RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=interstellar.eu;
	spf=pass smtp.mailfrom=interstellar.eu;
	dkim=pass header.d=interstellar.eu header.i=@interstellar.eu header.a=rsa-sha256 header.s=protonmail2 header.b=cjCtaGPM;
	arc=none smtp.remote-ip=109.224.244.107
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF5606A31E;
	Tue, 27 Oct 2026 12:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49AF5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=interstellar.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=interstellar.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=interstellar.eu header.i=@interstellar.eu header.a=rsa-sha256 header.s=protonmail2 header.b=cjCtaGPM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interstellar.eu;
	s=protonmail2; t=1793103927; x=1793363127;
	bh=FAdS4BWmwO3+sFTq7Kut36ppic9RAnx4z1UJ7r8XW44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=cjCtaGPMPwm9N7Oyb20tGkTMetg/5Xrk8B3CDLugkvwU6ZHT2aIgeRDd3yf9i0YVs
	 TmZMTCc2Xv2lqd9pZlYeC1XFhlBdD4Pc5y1dr3GzhumO1iysIgoJq9x2CGSDFR4+SL
	 AG6L3kutp2GafFS6eEly4h92dF6+FX2QNK1qkwhpDyRv4ViC9QBRAKJyycuo15oAtx
	 EwoiU7rDNZBuol2CaXTJUcaMl2sFA4kKZJa9IH2GDloAARlphYsN+oF6vLJlNuF9nO
	 4+oi9Tg0kUvm96BfuxlMmyUyaAhECgUqNBBPd2wmpWys+LC3b61ulGCy3usAXRqyIy
	 muOy2e+Ez6xjg==
X-Pm-Submission-Id: 4jDV7n0pPzz1DFF5
From: Francesco Orro <ncesco@interstellar.eu>
To: z0rc3r@gmail.com
Cc: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux@roeck-us.net,
	huangwei@kylinos.cn,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: acpi: Assume UCSI 1.0 on HP ZBook 8 G2i 14
Date: Tue, 27 Oct 2026 13:25:24 +0100
Message-ID: <20261027122524.817021-1-ncesco@interstellar.eu>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026-ucsi-hp-zbook-8-g2i-v1-1-91002e9ef073@gmail.com>
References: <20261026-ucsi-hp-zbook-8-g2i-v1-1-91002e9ef073@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ihor,

On Mon, Oct 26, 2026 at 01:47:52AM +0200, Ihor Urazov via B4 Relay wrote:
> The same firmware defect on the HP ZBook Fury G1i 16 was discussed in
> "[RFC PATCH] usb: typec: ucsi: acpi: bootstrap PPM on HP systems with
> empty _DSM func 2" [1]. The defect was reported to HP as case
> 5166176673.

Thanks for picking this up, and for opening the HP case.

The Fury G1i 16 is DMI board "8DE2". Its "UcsiAcpi" SSDT (BIOS X96
01.05.01) matches what you describe for 8ED9: the mailbox is
0x30 bytes with 16-byte MESSAGE_IN/MESSAGE_OUT, _DSM function 0
returns 0x0f (functions 0-3 only), function 2 is a stub, and VERSION
is written only on the EC response path (_Q27 -> UQDC -> UETO, copied
from EC0.UB00/UB01). A PPM_RESET through function 1 completes in
URST(), which sets RESET_COMPLETE directly without going through UETO,
so it does not fill in VERSION either.

I have not run your patch on the Fury yet, so this is based on the
tables only. If an 8DE2 entry next to 8ED9 is wanted, I can test it.

Thanks,
Francesco
