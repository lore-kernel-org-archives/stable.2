Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8C3D8107;
	Mon,  6 Jul 2026 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319078; cv=none; b=Vy69AD1j12VKTJFzYRlV/T9uLnFOBQslI3FV2itM94pAAkZjGzNffljHn1sVGKi6BzXQ8MeKNtUAyNjiMd+TJJQ4jnWqXPTchTbY2Mb+MkZYY1u0SsKli8cbjthPugiSlHz8+1Y8bm1E7DLGSmqB/E35TM8o/GvwryC2DQnGHgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319078; c=relaxed/simple;
	bh=U112A6fp2fgh6C2mtY+UkJGb6VsIWxDu9MX14j5pzSA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nTTnFcCo7e+SC+eukAspUV9W5TYAX9jsoUW/CqD6tn/UVeiZJ1quxYKt7/XCsiZyvbFKQpRBAKbtd5yLwYpqybS71WKkaqz0DAdde4F2icbpHGRz1JNPx0LokeQtE9uZLjIOLOtZGLPflpRAjHcI5zna5Go/axnqjIV2yPWPVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aljpZuCZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aljpZuCZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D6CB64E40CA4;
	Mon,  6 Jul 2026 06:24:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A4459601A2;
	Mon,  6 Jul 2026 06:24:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D767911BB98B6;
	Mon,  6 Jul 2026 08:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783319067; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Oq5IY+f0PZd96xg7+KB/yGuleN1P4zmQ4qPvPNwL57w=;
	b=aljpZuCZmDVT+Sq5fmb3jnoC/djpA37MygeS4Q0OV/oaV84WvfTgTcONdlU7Npl0D4lLWe
	YK51e6Zh5CtYD22AyXlNJynQC4W7Xx4uy0sKOjdvvwUlTnom3felAktY6Doto+0xHNBWFT
	VJZ4u3BO4QEpyCnpCdsTr5dJZk/bIusxr+kjX0s/m8umk8QbR0RROGqd/emodYyOe5giZJ
	3ZvvBzl7u7cFoavhNzpHExJ/qOv2vfieY5dngoVdoweR1UAUKTDdvMXEyQCgJ1zxmwXhmy
	rifIamNrKNfIIFrKfjYBh/gWtoovtUTR8RzxAlOCWr5hL/jdwe5JLuNUnOIaQg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260703074052.49260-1-pengpeng@iscas.ac.cn>
References: <20260703074052.49260-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH v2] mtd: mchp23k256: use SPI match data for chip caps
Message-Id: <178331906575.868671.5495065528182166347.b4-ty@bootlin.com>
Date: Mon, 06 Jul 2026 08:24:25 +0200
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

On Fri, 03 Jul 2026 15:40:52 +0800, Pengpeng Hou wrote:
> The driver stores chip capacity information in both the OF match table
> and the SPI id table. Probe currently uses of_device_get_match_data(),
> so a non-OF SPI modalias match falls back to mchp23k256_caps even when
> the SPI id table selected a different part.
> 
> Use spi_get_device_match_data() so SPI id-table driver_data is consumed
> when OF match data is absent. This keeps the existing default fallback
> while avoiding the wrong MTD geometry for id-table-only matches.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: mchp23k256: use SPI match data for chip caps
      commit: d322e40f4edf92bf0ca329e5aa4ae1c0316feb38

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

