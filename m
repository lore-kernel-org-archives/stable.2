Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795716119;
	b=A0PBMvVYwD6FNRYxfbfDPMyx2biHxIXuPshZ342MsVv49osByOjbUhDX5Q/yzb59TvRF
	 MdpLSZDavz0nG7JYr+zVQuVHpaz1merasTiknz28fuf7ekSNC+8qhrQCORwwB9wX7XsXP
	 b+KTPqvzEAk1sYV+g/LAL+DMhye0Gqdrc9exIG5UWogfOisjJtEj5JGJ9o8xxA6iaAuXZ
	 81EEBpwbqUEIXYv5jtxq19LWGvfGaggsFbGIe0Oadd3EV4EdV58ANQEyMFnaIEtfYXNxL
	 63k9ve3OCWY/+RyqJ0zwt8D8fllKmiVGP4gKfNdxktEOA8tD/XnmKivBBQh5e7gNyug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795716119;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=kl7bg688dXQ0GAc0QXvKBX0thFl5TKdWcSAQVME7qL0=;
	b=BFz63vJXeMffM/qQvlU/naQGsSX+0+GCmjBW5xtOymPhHXBBVxhhMhZoilMhGNB/NWlm
	 8LOhwGMygXoorORO9aiRtJp3fNLuLdsfDRDj7C8iax55PjWFDoQREJnbjyLgZ/QftHwAB
	 i6khb7962UuZKtba+1q+df6Se2yGBnVNeZpOlWz7WVWp+cV45lEbb2iaZDuD0rIaQTA9a
	 zExr9ngyADOcC0Saa60FJjNhkJSg1n9GONxS05SLs4mUOQN4pPZHDE/XhCoZLSo80RYpA
	 nJuyaQ3EWMeG37DGW4Iag6Hmyl8MfTNFBuSd1VZ5qOzbYsmVbb97Q0dOE+YKnDnpD+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=B3bSM3ji;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B267606A31E;
	Thu, 26 Nov 2026 18:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B267606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=B3bSM3ji
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id ECF84C2B9D5;
	Thu, 26 Nov 2026 18:02:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7EB9660558;
	Thu, 26 Nov 2026 18:01:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0528A11E69167;
	Thu, 26 Nov 2026 19:01:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795716111; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kl7bg688dXQ0GAc0QXvKBX0thFl5TKdWcSAQVME7qL0=;
	b=B3bSM3jiUK4noIe6e1knXOQNbSpWZfGs3R1GXa6wZ3FImgsCFptNW6q0DzKt+gmqZvJQwr
	dSDr5dkmCUujMxkPkyiCmAu5OIPMV2KCIB5nIqOnhcWe8/cpFFuLy0q5S2eyDqRrlFYASw
	BLVGru3+EVfYM60JVxcPnUdxeTeLHvaURR2I7Jo2V2nROSta4wyy2wmxD06IUhaWbe+A/C
	n4ZaOb7a3xXMHJ/zTBslsJw4duEKvRGRIzNtI+1kIUoRR0GvZCZ9NKhKTzCvAgPMUOh6gf
	36MLWOi+y2LzIHyIWhRKguPoWy8G4K0y5cLjKMrqBLFbP7dAdE+j/2+nFrRqRw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Stefan Agner <stefan@agner.ch>,  Lucas Stach
 <dev@lynxeye.de>,  Thierry Reding <thierry.reding@kernel.org>,  Jonathan
 Hunter <jonathanh@nvidia.com>,  Dmitry Osipenko <digetx@gmail.com>,  Boris
 Brezillon <bbrezillon@kernel.org>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-tegra@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: tegra: drain the IRQ before disabling the
 clock
In-Reply-To: <20261108-submit-tegra-nand-irq-teardown-v1-v1-1-2c570ad4a22c@gmail.com>
	(James Hilliard's message of "Sun, 08 Nov 2026 14:05:55 -0700")
References: <20261108-submit-tegra-nand-irq-teardown-v1-v1-1-2c570ad4a22c@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 26 Nov 2026 19:01:45 +0100
Message-ID: <87se0nv5di.fsf@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 08/11/2026 at 14:05:55 -07, James Hilliard <james.hilliard1@gmail.com> wrote:

> The managed IRQ handler remains installed until devres cleanup, after
> removal or a late probe failure has suspended the controller and disabled
> its clock. The handler can still be accessing registers at that point:
> it signals the command and DMA completions before its final register
> accesses, so waiting for a NAND operation does not drain the IRQ handler.
>
> Mask controller interrupts and release the managed IRQ before dropping
> the runtime PM reference. Apply the same ordering when chip initialization
> fails after the IRQ has been requested.

Can we instead include power mangement in the devres logic? In general
when one need to manually devm_remove/freee/unregister(), it means there
is problem and the solution is incorrect.
