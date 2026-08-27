Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9F53F39D1;
	Thu, 27 Aug 2026 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820319; cv=none; b=goGv848fIxoGmzQXmKl2PFwCCbdmIxR/24GdfL4uioJ+ge4/as4beHjc3kcDNVdBN0M4EH2jzKU0neGUo8/nva4M+vEDrf44dcqSPTsi81b49kfGXGpdRPRXMGpuJJLgVWiqNm5Su1eKhm7ylts0NXKVH+4i6NcB4IouxivUvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820319; c=relaxed/simple;
	bh=4Bgb8Ks8ORJZQI+Q5OtaZYmlbYL3o1UYZygCCGgaZvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jX4vzeNdLCdfr8oaSLrj6UtwN0a2Y4gIZkYulLoyABNDPcPR5i4p9Enn6asdKBfMNaDd2gLihe0UYRLRvxFOBeAx2uu+bb3PP9l2EjXSa89OTw2BWHwsCtKgZrsi47RaTiJprJrdi7LMYEzXEnBY6NYd7ooYva+z2ddoeGjWF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hZ47xYxS; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="hZ47xYxS"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b89f5ffa;
	Thu, 27 Aug 2026 16:45:07 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v5] mtd: spi-nor: core: Fix mutex leak in spi_nor_rww_start_exclusive()
Date: Thu, 27 Aug 2026 16:45:02 +0800
Message-Id: <20260827084502.2794139-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87jypcdku8.fsf@bootlin.com>
References: <87tsoigz8x.fsf@bootlin.com> <20260827082656.2772784-1-runyu.xiao@seu.edu.cn> <87jypcdku8.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa04264f23a03a1kunm724801185d503
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDThkYVktNGkgYTkIeQ0ofHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	5VSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hZ47xYxSI2yFtfwGl/7HTcfUTMfdWjqOYesNTf57QZXRGfHhnF2Q0GTpL0aWq7QDuh4gg6HPSxbZwqLsFth3wdY7mE7LLFfClpCHceooN2u9ikcoMGUKey3RtcUUhbGxfgn9fyKWTbSANupwaCA4ldA/X5QPKc8JNnfmuvUoSQc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=4Bgb8Ks8ORJZQI+Q5OtaZYmlbYL3o1UYZygCCGgaZvc=;
	h=date:mime-version:subject:message-id:from;

On Thu, 27 Aug 2026 at 10:33:03 +0200, Miquel Raynal wrote:
> This paragraph is a bit irrelevant, we don't really care about the
> feature itself: there was a conversion to scoped mutexes, this
> conversion missed one place, you fix it. That is the justification, but
> fine, let's stop iterating on such a trivial fix.
>
> Didn't I send a Reviewed-by tag already?
>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks for the clarification. I agree that the commit message should focus
on the scoped-mutex conversion missing spi_nor_rww_start_exclusive(), rather
than explain the RWW feature itself.

Sorry for the extra iterations and for missing your Reviewed-by tag from the
earlier thread. Since v5 is already sent, I will not send another revision
just to add the tag; I have noted it for the patch application.

Thanks,
Runyu
