Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990203E714C;
	Mon, 31 Aug 2026 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170852; cv=none; b=aKXSYP9D9FYnWj+typf9rRBTOmLmc1yGb4tr7zN8YsKKXLCaFrwCgS2KRy5KQ3BVNSo44ySBBwR3a/dJZJgXkrAjkw5lTDgM6oe/s3Yqa+zIjOWNATAOrKyZjqWFOBM1uNX1zvXUxut6C/Z1KeiKlhi/yc7ckTrJrJdf9WHOV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170852; c=relaxed/simple;
	bh=CKDvWF0ui5pn13nr7UoA/5PU88Wqt9/Kw0pgq4FBRGg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=pxRvXs0dhVvYJ6CrZKHUI3rK2nKUAP/AmRApNd17iwXakpjB9qdgFq9BRKeBf/PY8MageTDJ9rujgw+/urCs3ZBMzrR295ULSrUK0y+xwhYfQaiGqncgr4ouSc5tAHaN5ogJc+xZyUvylfO16DnxRbttJmQLU14RujYSPnYs3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SmH/N28A; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SmH/N28A"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D32F14E41441;
	Mon, 31 Aug 2026 10:07:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92FDD60231;
	Mon, 31 Aug 2026 10:07:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77FB811C78AE2;
	Mon, 31 Aug 2026 12:07:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788170846; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CKDvWF0ui5pn13nr7UoA/5PU88Wqt9/Kw0pgq4FBRGg=;
	b=SmH/N28AQE63Hm6ogNyKsBeYnuoP6ubOF4PGCw6JN3UQTBFwOd3eftodZ2zmVIgZqjfgXW
	hdt9NfomvtbQxGUSEPPcrGWfnpsYLV5J5MzgDYfgRPbVrhzvUH4hRfZxWnSqvU5FC9sJRt
	GHVLldzFj+AkULkiTa0l/no2pq0tbiQSTNI58o9n1R7810wmpywpH8mkH8IvJmAkOtuAKo
	o0d/FaobeVvwhF0tE31edMK1n+MN0G+7sP6mF8F3aLKPFtIldVu3oORxon5yxBnRIPrZZz
	YIIDjyu/+OxEBWuxdoelW3tDS6FWuDEBFqzPB0vigfHEUxb+sdyQhYBAzf/kPQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 12:07:22 +0200
Message-Id: <DL31NSK4T9VI.1CM5I9PRKJLCS@bootlin.com>
Subject: Re: [PATCH] mips: select CONFIG_WEAK_REORDERING_BEYOND_LLSC from
 CONFIG_EYEQ
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "Rahul Bedarkar" <rahulbedarkar89@gmail.com>,
 "Paul Burton" <paulburton@kernel.org>
To: "Jiaxun Yang" <jiaxun.yang@flygoat.com>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "David S . Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260828-eyeq-reordering-llsc-v1-1-0c5a69fc5124@bootlin.com>
 <DL0P7NCKVU0I.ARBMN6GAMMBS@bootlin.com>
 <cea78eaa-aea0-4d1a-9695-8a6d73750216@app.fastmail.com>
In-Reply-To: <cea78eaa-aea0-4d1a-9695-8a6d73750216@app.fastmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Jiaxun,

On Sun Aug 30, 2026 at 5:05 AM CEST, Jiaxun Yang wrote:
> On Fri, 28 Aug 2026, at 11:56 PM, Th=C3=A9o Lebrun wrote:
>> First off, sorry to net maintainers for being in Cc of this patch.
>> get_maintainer.pl added you and the MLs because the commit message
>> containing "xdp". I deleted the MLs in Cc but forgot the individuals.
>
> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks for the review.

> Can confirm weak ordering beyond LLSC is necessary for all MTI cores with=
 CM.

Only CPU_LOONGSON64 has "select ..." upstream, so I wondered if any
board apart from Mobileye ones were missing the flag. An LLM pointed me
to img/pistachio_marduk.dts and img/boston.dts which looks correct.
I CCed the board maintainers.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

