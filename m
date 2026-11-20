Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186970;
	b=sQKeT5l7vtHKQB/MlyX/HT8jO2Mi0sCJirO5BvljvvlLL1EyV2MK8EGRy4t8obP+KPBx
	 KDCGoBqfeRMQt0IjklXU1Nki3CoVf5uLFtHulvA+KqnE1poKkEMWOXhrpBgA7FH1OWGWW
	 8HtzYpQIVVvoIGp0HKhbvhii0/vWf036Au12TbgXjgbzhXqHUQgBFfPPQe3xo2w9vmCdV
	 pC3P3DyWTEYRfDfTAsFz0j2ug1r3DYp4udi+3aUyKJSDiHUHmM4EN1LxUNPknXh2Obt1r
	 G2c6TzOHo4wna3vOhvtLB3VsEAYQTMrM+1nAxXX1T/bMdZwLKzHEXBToOgTMpN17nNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186970;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=eCJcsk7nKdE/zS/Mw/SS7quXmWWfDvd3Vyxw1OphYiQ=;
	b=ILEWvnt2Ynl8Qkj5buEq0pb1WV1BLhpPGLmMpsUNBsN9Y+7dL1N/62akPG1DMsF5g0D8
	 us+atRxC5xP7d9xiurXQHnhWbb6rLEflYy09UJArUsOFc4ukx2T5oh8yr7f1vdK9hw+V3
	 dsKGLrRtNhGPWBoCBpUUcUaeWpSGX3iJ64eZUSxmDCv4M6Jd5S2GISe3Y20WVV+gjP4Ne
	 GaGNbhpXf+OSfwfkJFz0wzkplGYDYtwUUOwyyUMi9EhMg8Zxf6D98EgvkAID9SNeV7cXI
	 XxUxfikigEQkgljRWzkhP9Dqf5NRL3YmShv6lMtGZLHx8O3rK2PfrIJz6r3Cly7DInQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mvfJrJIS;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3EF606A33C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A3EF606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mvfJrJIS
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ABCB51A174E;
	Fri, 20 Nov 2026 15:02:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 805B3601B9;
	Fri, 20 Nov 2026 15:02:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BE4911BC027B;
	Fri, 20 Nov 2026 16:02:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795186968; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eCJcsk7nKdE/zS/Mw/SS7quXmWWfDvd3Vyxw1OphYiQ=;
	b=mvfJrJISZSYm07vBBw4iF43fWAabOWg2boVfJFPB39RisD6iY9q30nyj60ph5H2VU7+61h
	thwRC9ePbnMQMJpiVpHJh6nQ0ErljTqNrd2pcRtLNqKpkk7PX+P54naI3d7g0tVJJRHtVy
	SShzP6sO9qRyKPaRYF7ZUTnB+q+ZuioWAZ8u8An7Zy/p+Koa+b2f4K73xKi/3PpqfMelXX
	+zrLPyJT/5bZipyIGRyw2s1JlzIv3oXheujAnfk4Gtt4kyWjjwrcpSk3qct7c44AO/Frk0
	de8xJXkYe8Bcd5xbhdUkZm43vsd+uG57mDOr3WOUhgm1oW3dhhctkiYT1Fv8kA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261105-submit-mtd-oob-end-v1-v2-1-734bffdc2914@gmail.com>
References: <20261105-submit-mtd-oob-end-v1-v2-1-734bffdc2914@gmail.com>
Subject: Re: [PATCH v2] mtd: core: reject OOB transfers with no complete
 page remaining
Message-Id: <179518696533.3401781.5807779748202005416.b4-ty@bootlin.com>
Date: Fri, 20 Nov 2026 16:02:45 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 05 Nov 2026 12:29:40 -0700, James Hilliard wrote:
> mtd_check_oob_ops() permits offs == mtd->size when the data length is
> zero. For an OOB-only request with a nonzero ooboffs, maxooblen then
> underflows because there are no pages remaining. The wrapped value lets
> the request pass the OOB length check.
> 
> The OOB ioctls can reach this case by encoding the OOB offset in the low
> bits of start. On a partition ending before its master device, the
> subsequent address translation allows the request to read or write OOB
> in the page immediately following the partition.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: core: reject OOB transfers with no complete page remaining
      commit: 656496952b7d3b7a0283351387a2e444df07f6cc

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

