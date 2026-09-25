Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2021D4AB3CC
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346534; cv=none; b=n5bRplAMUNDX+yvhG7BS1J91FUBnmcglMJwsdIwNsQsQ1g5SUUZE7VtSkmoEoDVHqX1QZmTmLksCDB5DzF3VcLLURztYAaQZhaaejK4/LyNxYF1mx5pdGdf09Y3kVX/ujQmjqS2PE5LhJvbke4eOKo+ovALTCd72qsiice/i1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346534; c=relaxed/simple;
	bh=S1yyYoIfsXDNk26tkXJrV63IZblVCGtxk56PBE1zovo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZoBG1BB9R/NzB4oWqV0NDvwbBRN7H3jziYe2r8+22WRXy6hiL8sZh3vGUa3y+uIfeSk0PA4RPsIe8p0+46KWL65jUuNcyctSXIrAu3oP2YeKsT0R5RmIMye/l0NPFRGY4BPeNEQ30wDELP3K+n36BvBwm6ucgkmEQz/2Q9QlXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GV+OxjOc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GV+OxjOc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 25195C653FA;
	Fri, 25 Sep 2026 14:29:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3CE3C6073B;
	Fri, 25 Sep 2026 14:28:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 203F0102F19F8;
	Fri, 25 Sep 2026 16:28:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790346530; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=48TSY6/XqUrQC7pG5irCkd7o+Gn6x10HSD/mfjLBu8w=;
	b=GV+OxjOcXeQg3GbndjDmYQeb9rE2x/7r3ExFjXmTu4962hzCt84kcQSZlBLn2/8Tg1517J
	5nusq3BIDopS/69XOdSFuNGzwpGI//SSx7HdnY21MdHSXY2TUIXN9qzSnwXRDQLGNJVGnI
	LaPYABgMW4bnfAqCPNSpbjHTWkC4H5fj3/FKoWUSnumTwgwXBZoAtSI5kthmvJdy9qNaJX
	m6gsfmUMe3OpBPgeNsKqXOnFjg3Xt83euUFU+9/y8ydHlzwWlpvGD1ywVoivGQk5Qa13KY
	ZplEsJr6U+DQYHFa2OB8OVsE9N9x8tYJkyG07+4hs0P1N7xz6cYraDyd9ZKwVA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: akpm@osdl.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, richard@nod.at, vigneshr@ti.com, 
 stable@vger.kernel.org
In-Reply-To: <20260917102407.2146727-1-vulab@iscas.ac.cn>
References: <20260917102407.2146727-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] mtd: maps: l440gx: Fix double put of the PM device in
 init_l440gx()
Message-Id: <179034652899.1166139.902487494191174396.b4-ty@bootlin.com>
Date: Fri, 25 Sep 2026 16:28:48 +0200
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

On Thu, 17 Sep 2026 10:24:07 +0000, Wentao Liang wrote:
> The PIIX4 PM device reference taken with pci_get_device() is dropped
> again before the iobase resource is allocated.  If pci_assign_resource()
> fails, the error path calls pci_dev_put() on pm_dev a second time,
> releasing a reference that is no longer owned and underflowing the
> reference count.
> 
> Remove the extra pci_dev_put().
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: maps: l440gx: Fix double put of the PM device in init_l440gx()
      commit: e6ca524ee5b2705be30ea19ce2e55122d9f9ed8f

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

