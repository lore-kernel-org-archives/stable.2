Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C72330B30;
	Fri, 19 Jun 2026 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901519; cv=none; b=OgUi/rKaVuCpniqclDvTx7ehms/aDsyomoHpFEMMfLPePB8z4YbEhfRxXXsD7NzM7IoOnvREnLfRIPdJUVxidRgT2v0HqwenNtxvGOH9DMfhICFA4SuiQkxgs6KbL715Orsdb32SAKme3Edcttun20n3+iHbySjZsHsmwoos2PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901519; c=relaxed/simple;
	bh=kKmXsHMakcX+AcUV5b9G2IEP7NtVx3VprW8uWnQOD1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1FlLcPnVesf3JwKZCSjp2LusSFfKeLGk7cqzMZd1bWLnGTiOA76Ef2Pl7JxTkUs3dKceNK0Yj4967FT+ak4HkJ6XNNUDmC5w02pby5gNeID12rJSml2LwK28A+2FsaiVST99B4T3P8kTa4ESC2YjGwDmuJZ6BoQcsOZ30cGubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 54EBAC0CC3;
	Fri, 19 Jun 2026 22:30:08 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH] ieee802154: ca8210: fix cas_ctl leak on spi_async failure
Date: Fri, 19 Jun 2026 22:29:42 +0200
Message-ID: <178190096345.793016.14917236922404403238.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260421073259.2259783-1-shitalkumar.gandhi@cambiumnetworks.com>
References: <20260421073259.2259783-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Shitalkumar Gandhi.

On Tue, 21 Apr 2026 13:02:59 +0530, Shitalkumar Gandhi wrote:
> ca8210_spi_transfer() allocates cas_ctl with kzalloc_obj(GFP_ATOMIC)
> and relies entirely on the SPI completion callback
> ca8210_spi_transfer_complete() to free it.
> 
> The spi_async() API only invokes the completion callback on successful
> submission.  On failure it returns a negative error code without ever
> queuing the callback, which leaves cas_ctl and its embedded spi_message
> and spi_transfer orphaned.  Every kfree(cas_ctl) in the driver is
> inside the completion callback, so there is no other reclamation path.
> 
> [...]

Applied to wpan/wpan-next.git, thanks!

[1/1] ieee802154: ca8210: fix cas_ctl leak on spi_async failure
      https://git.kernel.org/wpan/wpan-next/c/e09390e439bd

regards,
Stefan Schmidt
