Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDA84A3842
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346533; cv=none; b=pyaxozSoiiBMwb2uR6VbtkG0tWA20X2rocd6PfpqbMpFZ/IklyF9A28f5EFbNlEfjNN+w28Opp0uLUIxW2N9okteSh1YhrpC/DenKMq2jGJ5fB0PuBSXxp9Emd1IjgjYUowKN7fUJbGVV26HyD27+qXnCTxFHjysals3NfEhqIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346533; c=relaxed/simple;
	bh=atEDZ9lHvTLdxtH/D2w4OyiXLZ8Ca/lEv+y8IwOvDXA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BPLhC+EsL8bIEGAmkNDUktsvQy0/OOIfeacmf2C0aKK1e+bxlu9uZAW8rjsPOovA9OV7MW8VyZTsI7XRNcX4kalS0v14Bpl6/ZjolXZU32zURU+JfGx/ER+aQ/lEDYO3uhvOAZY3ZRnA+Kjzf1TvCXOLZymHG8LLqCFlJrx4Qv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rOZLMA1c; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rOZLMA1c"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BA1704E41074;
	Fri, 25 Sep 2026 14:28:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8DD3B6073B;
	Fri, 25 Sep 2026 14:28:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B98B3102F08C8;
	Fri, 25 Sep 2026 16:28:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790346528; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=W/+kj95A0keJmlE1z/uE4wA1Qp+xDwWA7rtH1WDrO6I=;
	b=rOZLMA1cTjjK7cKnBvokDQC+LvYEHE1EEnHLZ7WYPOp3whhV6S37HNg4V8UgBqn8GStQ6U
	21bXHf6XNiFcO3X+wPcRefElmWdfibqRPPuEhfDdQTiD+5Y2jHVELnm45LTT7lO34eXg/z
	InV7R+UKswvRBKF5ZTVYVLL68QO9nViZwr7E2Xwi1g1jR2563/n70ep3uJRIErxdXSJOsI
	QRYojsIeqDigvRYY8riPsY291avt8h+oA/PciOz2IpodSbtYsxlIv2OwreDrewj+DRlJ8Y
	89+qJS56c80IfFMR41dG1wgJMBnyRXOf34P6FSFe/0lhlpnHhmRPifzw5K8BOQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: akpm@osdl.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, richard@nod.at, vigneshr@ti.com, 
 stable@vger.kernel.org
In-Reply-To: <20260917102244.2146654-1-vulab@iscas.ac.cn>
References: <20260917102244.2146654-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] mtd: maps: l440gx: Fix double put of the ISA bridge in
 init_l440gx()
Message-Id: <179034652764.1166139.12125541879074181935.b4-ty@bootlin.com>
Date: Fri, 25 Sep 2026 16:28:47 +0200
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

On Thu, 17 Sep 2026 10:22:44 +0000, Wentao Liang wrote:
> init_l440gx() takes a single reference on the PIIX4 ISA bridge with
> pci_get_device() and drops it again right after the lookups, before
> the flash window is set up.  The pci_assign_resource() failure path
> then calls pci_dev_put() on the same device a second time, releasing a
> reference that is no longer owned and underflowing the reference count.
> 
> Remove the extra pci_dev_put().
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: maps: l440gx: Fix double put of the ISA bridge in init_l440gx()
      commit: 521ad948e04934b2d70ae899bc016bbb38802e90

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

