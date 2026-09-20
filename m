Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977292EEE67
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789910591; cv=none; b=KOzpSLCNWsykRrKfqeSp3x8V9K8xWMjGDU5JoSrKgnpphfJCzMTAuFyeRFUWZwAi7yX09/PpWCFx+8cafNr+ldD+qhaMMKzmOT9gY3w1dwn150RVtiJsli1UBdKIZF1qmEXeYfqQsz4aFIERzp9oOUkz/6alimrU+3QG117fHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789910591; c=relaxed/simple;
	bh=8vV8cCJ+6eZcKQ1SFAzh2G4y77glvAtKW3F5PJIB5AU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dvVbkSZv6lv/eLKNr2mLQBU0uSym1fOwSKRWyCmwoAjgS9q/7ZAbsGLRGcmuAsiVk6Pz49raMaJjBF91Jx0bKUuiIX2oeQMp0YXR/Vtp5a+muIdTPlKsiEW6KryHQ6hGzmno0dIcu97Fvca1vpo2ErLtYPUhuOUAlHyycvTDnNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zxZceTrC; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zxZceTrC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D1E96C5CD5C
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 13:23:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EF098604C9;
	Sun, 20 Sep 2026 13:23:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50E70103286A4;
	Sun, 20 Sep 2026 15:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789910584; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8vV8cCJ+6eZcKQ1SFAzh2G4y77glvAtKW3F5PJIB5AU=;
	b=zxZceTrC/U/Wh0gJBakYE+QKIcMtXDWM4PXY2A5W8WG852SPa3tSfh89TsZ+WOVCV7Cusm
	8YnPkgMztHcd+Usl4qPDF7COB36UTCRqM6f3J1oHARGPlUPoYh7ap4VBv5GH8fQpxUEiR0
	ldG0LZGyf00N9rL7Pue59ej2LlEwbkdg0/fufUVB/gayw+yeGtblbsqbs+4rLCkLGVFkfS
	iaO9PHGImE35MsmCXo8t6bZ8CfI/08rSqotdPfuMQeWWLWZBcYSAaT9NWU/vJ1DjpF4oQp
	rneiOQEli7B283b9MUn3V7slY2sE3EC013+wJHkQmn2ZeRqD7S1jz/dzH5Fayg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: intel: fix OF node reference leak
In-Reply-To: <20260915163407.2487869-1-lgs201920130244@gmail.com> (Guangshuo
	Li's message of "Wed, 16 Sep 2026 00:34:07 +0800")
References: <20260915163407.2487869-1-lgs201920130244@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 20 Sep 2026 15:22:57 +0200
Message-ID: <878q4w9hvy.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 16/09/2026 at 00:34:07 +08, Guangshuo Li <lgs201920130244@gmail.com> wro=
te:

> ebu_nand_probe() gets a reference to the NAND chip node with
> of_get_next_child(). The probe failure paths release the reference with
> of_node_put(), but the successful probe path keeps it for the lifetime
> of the device and ebu_nand_remove() never drops it.
>
> As a result, each bind/unbind cycle leaks a reference to the NAND chip
> device node.
>
> Drop the reference in ebu_nand_remove() after the NAND teardown using
> the flash node stored in the NAND chip.
>
> This issue was found by manual code inspection.

Feels like what you say is not what you do. Please align the code or the
commit log with your real intention.

> Fixes: bfc618fcc3f1 ("mtd: rawnand: intel: Read the chip-select line from=
 the correct OF node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Thanks,
Miqu=C3=A8l
