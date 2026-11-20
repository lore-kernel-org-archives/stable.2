Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187041;
	b=4eXGya3t1BHwWCLgZNPRsG3g0IlwJqar/C+3pi/uIiGVTbHfQSK4Vznu+SaYCNYKVwmd
	 Xynd4BPB36XluLOveT4fbqRjscjDF5o3KGnM2pbh38soosZEH+J8aVvuqBNeJtevi65B8
	 YeXn7wok7BUi82Erp/ygoLiJqrQfYCL6W42yJyH3aUmc6FJFBNFFkXPod/rJndYeLMHeu
	 1vJ1sL623ySEQnRe5ICgCClcua86pqzSPlr24Ee72RTbFPlAJgBHO5GcrNjPP+qcKdSF4
	 qWAN0LQ4dHwA48kTJTa5TIJI7T7c3J7wv0+/BaguJrERpNfsqpw5ixuXL+uy6Frglgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187041;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=PPlgudp8kDoJrGMgm5LS5TFYAYMRC1AIU9IQdrQKlfc=;
	b=aopqyFlOKIuwu5bBaJOl7kAzVqP6M8QkWEvMkJNdzUUtxpK4FpTb2e+cc1eRAnPjlxid
	 0RorS6lQx0ZsURSnlygKsDfWh3Z6M/uysKzTYBLvJrfS+CJXhxBUlomEVtTkexgiVppyp
	 PC4hFstOkHMLioDbdsFO6Va6om82XM7Irz49jZJ3lohU+6T8wTqKOY8SZhou8f8h7zG12
	 FaoiQGS3r9ZiQBjOgO3ZK6U+gPNuL+mx3eThKojHvIa1QDOnUQsvcf6HjY7KpcFl06qea
	 wJlH2l4mxtbR3Y+GWtBpnTlNS5IPf9nO3nJSemATS1FlwsIwT61o1tutrSi8TyehNMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=vF5PatK9;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34DF606A827
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C34DF606A827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=vF5PatK9
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 32E18C62220;
	Fri, 20 Nov 2026 15:04:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 77572601B9;
	Fri, 20 Nov 2026 15:03:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9636B11BC02EB;
	Fri, 20 Nov 2026 16:03:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795187038; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PPlgudp8kDoJrGMgm5LS5TFYAYMRC1AIU9IQdrQKlfc=;
	b=vF5PatK9+yan2jGusie8MfaHibhqHKzP8xWR3hC/VYtA/s+jg1dYmo59YA1s0ECkKMg3GX
	lZiZHWOMmZDrCU2nntBKiNMiKdaBugPjycIrWd2LQLWGTYyCH6vqkvUwjgTP7lk2Tf2Kha
	05oLrv7beJkBHPZpkAx6zhnSp/Dd3rDFlo6wqpvvm/eP0LukNITz7sVaJmKiBjNLynJc46
	EoycnSkkEGFZh3axC7C7HJoOvYN1kxCMTXdIZ904T7h/2gQ4A6+BeMSn8Zmc574+lvjYwF
	bELZKZWpuRPk/1d4v/oqTaCARHEfQwxeAT8xYhGMkWHYaC0amhyFgdzjltkVfA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261108-submit-intel-nand-probe-disable-v1-v1-1-eb0471429e09@gmail.com>
References: <20261108-submit-intel-nand-probe-disable-v1-v1-1-eb0471429e09@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: intel: disable NAND when probe fails
 after scanning
Message-Id: <179518703726.3404688.15982261234436640386.b4-ty@bootlin.com>
Date: Fri, 20 Nov 2026 16:03:57 +0100
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

On Sun, 08 Nov 2026 14:05:17 -0700, James Hilliard wrote:
> Operations issued by nand_scan() enable NAND mode in EBU_NAND_CON through
> ebu_select_chip(). A failed scan or MTD registration releases the DMA
> channels and other probe resources without clearing that enable bit.
> 
> Disable NAND mode on both error paths, as the removal path already does.
> Keep failures before scanning on their existing cleanup path.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: intel: disable NAND when probe fails after scanning
      commit: 7ea6736eeb01e5f8703fbbf95620a5f52f49fd19

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

