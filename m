Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBD44CAFB;
	Tue, 11 Aug 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465378; cv=none; b=Di+ThgsyBtdtjD4lSxweR+rT2HhhcPp9HS0t4IlGszoxvbl9CqoK2siEyCCeBXXoTteJ2trRTJMeX6ykMBzNq5MKjeGaU4Kb0gzfKjuD7+tgrbvVAk+Q8lU8Qz90Dmlx3zh0Y8l5SyxMePc4+I/NR8v7OoDHYwLjClvkQPqNW50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465378; c=relaxed/simple;
	bh=A2q/UILe52+P8UAsVeixpqogjUqP2qxXK0L+EDqFDlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgLfPLiCk3hTyDJpHzIFHd9yPcVWfetpt8VlruE07g/mc2BiuZMrV4Q5QiXjd4V6vQmNCdlQhzcqAHL7OdDoeAgwg1HJ2ELCXUo84/MTk5hBdqJQdX/FzdMX3nBYUIwTlNrXHM5QeRL9gk1rXqxzqh/UhQ3hq1M1l5jiLA/tH1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=WRyuk2l6; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="WRyuk2l6"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1786464833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jmf1SJruZQUuZ/Dccv6+duhLwslNSx4256rGf8s5+3o=;
	b=WRyuk2l6PDg6L0PyCxPWp1G3BRPQbVklwyf1wfRc+43bTvWu5r1lHkomqU9wutlHh//Qpl
	7DpQMVjM+CGAm2oH+gzs5oGdlUl9sjKQ22v/NPJt7/sRXTqW4uEQEA/CJYpkUMU9Pu39h8
	pFOhDJ5Vy3HUt5EgG8fv6zZ+RggHtM6Y61IekVcHWQ7CdE+leNZziH+CtLR9upJHCOeJIq
	nIqa/jl7+hpx3HR/mRThI8rL9a5H3pDwRVTNTz2NfruZp0Wmjl3LDXy/tSj6RuZrDyMWIe
	y87YdmgoELKRXV41AR0wFLziMsmcZnb0wmS0DtK9b6ZXXAuO0qgzCXpDxomqEg==
To: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	stable@vger.kernel.org,
	Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	David LaPorte <dalaport@amazon.com>,
	Gabor Juhos <j4g8y7@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 0/3] Backport fixes for SPI NAND on i.MX6UL
Date: Tue, 11 Aug 2026 18:13:35 +0200
Message-ID: <20260811161342.533280-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frieder Schrempf <frieder.schrempf@kontron.de>

There are failures with our Kontron i.MX6UL boards using Macronix SPI NAND
chips on i.MX6UL that originate in the introduction of the continuous read
feature in 6.12 (631cfdd0520d19b7f4fc13b834fd9c8b46c6dbac) and the absence
of later fixes introduced in 6.18 that were never backported.

This series contains these fixes picked from mainline, applying to stable 6.12
cleanly.

Cc: stable@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-mtd@lists.infradead.org

Mikhail Kshevetskiy (3):
  mtd: spinand: fix direct mapping creation sizes
  mtd: spinand: try a regular dirmap if creating a dirmap for continuous
    reading fails
  mtd: spinand: repeat reading in regular mode if continuous reading
    fails

 drivers/mtd/nand/spi/core.c | 74 +++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 15 deletions(-)

-- 
2.55.0
