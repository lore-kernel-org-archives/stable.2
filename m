Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1662314D35;
	Fri, 17 Jul 2026 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303340; cv=none; b=R9P8wJvmzPLXgIzFP/63cTt0mujxeJI6De5CI4JTobdNzUO6ZW0i7HBscbLNei9uVfPa0mDoIVeSdzUTWbP+iJUv0B9J31LsUThOJQ5ZB1+7XLJLF3XGOb2Cg2wnh6EBarcCYb/6/52vD+XyfpVULQvHrecSV7Vobq1GGWezd4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303340; c=relaxed/simple;
	bh=bzmwKRd365zUm2UdgQN5RgIwjEVgRCej5+4SK12u8kE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PUvtj8XQZb3iXQ7n0Oam40NHK3GbA6V+OvckC68Jg4hg4wREQ8kRO5NrfOgA6zC3yIPjugvMQzg51Y7BzaNXbAJ6v0UtUKTY7wG7/Xilc9yVzfona+dcGy5+LEwu52FgJBaxqzlftRnz1mlWORkWBQLnDhjVUOwmM/t3g+TUNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gNuVuP6+; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gNuVuP6+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5F5911A1068;
	Fri, 17 Jul 2026 15:48:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3320C60361;
	Fri, 17 Jul 2026 15:48:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6BBCA11BD091E;
	Fri, 17 Jul 2026 17:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784303336; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QbUDrpweXBkXnpB+1RVzuMysgABZvGWpm0FeF9Xeg9k=;
	b=gNuVuP6+VXY006U6LPgTO77zhT/M2ClBPpY4c2gNyVydZzTrONZL55waOlWjuXi630PmQL
	00QcQ5OJmTGV7cLYkWkux46lDD7burZYmT179kVrgs3Yj40U316ofgxqUBo8T2fg7G5FWq
	ssWj1llL2r6AQwimdg2l9k7VkD2CrR7UsXEzCCAMWifCgRH0VKwsY7PBWxXve9ePU/Ipps
	AdO48TjQe7ufoCHw5drz3KevVS5u3n2pYrY7KBHgPkaiosaujPlitfSI0pNntmyKgFyQZm
	kJ7V6t6dW5nmJbxUMVpBfvKYONZ4Z1BcBgL88Ndtkh4JBsnoAaFjTcNZXyPgjQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260708014712.99760-1-pengpeng@iscas.ac.cn>
References: <20260708014712.99760-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH v2 RESEND] mtd: nand: realtek-ecc: add missing
 MODULE_DEVICE_TABLE()
Message-Id: <178430333433.4128272.14238871340808286831.b4-ty@bootlin.com>
Date: Fri, 17 Jul 2026 17:48:54 +0200
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

On Wed, 08 Jul 2026 09:47:12 +0800, Pengpeng Hou wrote:
> The Realtek external ECC engine driver has an OF match table wired into
> its platform driver, but the table is not exported with
> MODULE_DEVICE_TABLE().
> 
> When the driver is built as a module, the missing OF module alias
> prevents automatic module loading from the compatible string.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: nand: realtek-ecc: add missing MODULE_DEVICE_TABLE()
      commit: 5b2444b4d575d8117809c57801562ef37ca2d4af

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

