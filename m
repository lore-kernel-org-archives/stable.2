Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390EF2EFD9B;
	Fri,  7 Aug 2026 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111211; cv=none; b=VsdNb3qD2kO/BrGbDnUzypg87PwHH0gZok0YZNjuNNrSUfgwXkEfEvzGfC3xv9/HJqY/j5VKl6hA2BetvV/2b/6t97p2vJVqGvkhWWuauZePGytnXfnR0dGrWbP5J0OO2K6kBt4ZktW0ObOoQtqBmYMPi0Lw0n5gOEWUjcLtHaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111211; c=relaxed/simple;
	bh=xmG/NPg0GmFOm20+Nd46Wy+Xi3gpzg2Isav2aK2vxAk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lMb8Ifa3NWQdjJOh0+Lx6U3j628HTAdr96/M41ALWD6JushjgY22vzO1/rIsyXmgbHELD0JeLLHs10VDVzMtH/lgfZk74EUX4Xq9GXHQfQf3y0hsQtlgWAv8h7CWsvTBJAYvYvhM7zRZqS+f4RmImKI5KQ8GQ6GR7xawBcAjMoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PQrsfncO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PQrsfncO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7C8BD4E4113A;
	Fri,  7 Aug 2026 14:00:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 47C08603F0;
	Fri,  7 Aug 2026 14:00:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 177EB11C37966;
	Fri,  7 Aug 2026 15:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786111199; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4gM9Hs5ShzCeXGCv14su7opd+QccVz8d8pho9Y+66Fw=;
	b=PQrsfncOOgntaYQKdJswy8Y1a1dS8HNjsnUOv4ZA+MUHmp5XdWv2IyX/I+b5r4JRQy7Tq0
	km+3F+qNPuVyrVF5dGu2nUBpAECjdatVPh6iFzno81YmJlhg/PNBV47cFjjSex9CZfOuQH
	8RP5PfeDZ9h0w0Obo+18kPiY8sUgboqVpdGhr06Y1DVusb4BYXyHaZTjVjqdSzHYmM6OX2
	F5bHuAiUrAQ/a0+BhtITn4+4e+1/CAMSNHcbvoqIt8F5a2WEMQopNDPaloUKdwM2xnDr1l
	jTGrWl6yWL1GD+v32UgDrNiuSR++7yoRQJOoREToa0pK3EpjFTm+jSryzrwPxg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Aleksandr Mineev <sanderrrs@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260717155051.50-1-sanderrrs@gmail.com>
References: <20260717155051.50-1-sanderrrs@gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: fmsh: fix FM25G01B/FM25G02B Quad I/O
 read dummy cycles
Message-Id: <178611119790.758547.8725356694959417850.b4-ty@bootlin.com>
Date: Fri, 07 Aug 2026 15:59:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 17 Jul 2026 18:50:50 +0300, Aleksandr Mineev wrote:
> The FM25G01B/FM25G02B datasheets specify a single dummy byte for the
> 0xEB Quad I/O read-from-cache operation, but the generic
> read_cache_variants set uses two dummy bytes for the 1S-4S-4S variant.
> The extra dummy byte shifts the data phase and returns corrupted data
> with no ECC error, breaking boot on boards using these chips.
> 
> Use a dedicated read-from-cache variant set with ndummy=1 for the
> 1S-4S-4S (0xEB) operation.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: spinand: fmsh: fix FM25G01B/FM25G02B Quad I/O read dummy cycles
      commit: 8211f2d74b356a02fe38aeea5b74030ac156461f

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

