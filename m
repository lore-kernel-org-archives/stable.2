Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D04AE107
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346572; cv=none; b=WKzHnR+GrB3EsMe6vwe/5uflrFQx7m26uTtEOsIwKiD68aGm03nHcIdvKBgGDC4YqqNgbdHwR56VWrdJ4qwUn1KxKjDj64nFpvBkHiJeoiEieAwD8/FSPLTccu6HZU23k1sDg83ah0+9nU1obQjO2H0TSweldOuB4N/imicNtI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346572; c=relaxed/simple;
	bh=VeSs5cmiAUtV0NkQNYKeRFCl4UH0bE+Kf9EsIFOxtFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oCD72LzP+apPSsCsdaShhOikTxSZWSQevz3a4rGq6BaqN5RkvA3HssYCdRkfPNj116SK8bWiP/j6m/VgW7956d5vZU1RVmwG5NoJSOVs5tRq9s6Jlpz+qtkE7y1VMOcSi730LJvTuT3K41C6MKJ/cX+2xMlITrtl9GNSkUndUpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ruNyRvz6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ruNyRvz6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F1E7C1A1026;
	Fri, 25 Sep 2026 14:29:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6C0E6073B;
	Fri, 25 Sep 2026 14:29:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45606102F08C8;
	Fri, 25 Sep 2026 16:29:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790346567; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/zsMfQoDD/lZKMF7U8S8qDEqm4yspSHi8mABifI/pZQ=;
	b=ruNyRvz6YmK91zDExwSnTvG8CpzsmG+ZpSG7XVnGQsEhFUCY4hhwUxqnS51FBAXtHUFqjc
	MLfb2mNczQkcenegsVz8TtCBw+nnjBebUh3UuZ7xAP9h7yk3KB3WtIOAKYJU9XBOlTV4Ev
	EwI86UxVBNb6FI5WZF3IubsyhR/zO6CRXpf8MVZtZx4Rx1WsEcRcraRQ/4KCEzEd/ZywFe
	wqyrq9vUZc7AJjcJdnsJtsyN3X/sk4By5LvxToKk5e6lLIhaNWWQB6HueNm/yMniNLyEwD
	4OgIZAOm8REOREHK7uSMJgdO69te7tgR0rv1yfepecECFDjzZudaJluA/Jycqw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com, 
 stable@vger.kernel.org
In-Reply-To: <20260925125546.1020149-1-harshit.m.mogalapalli@oracle.com>
References: <20260925125546.1020149-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 1/2] mtd: virt-concat: unlink concat node before
 freeing it
Message-Id: <179034656614.1166139.3939385190248779696.b4-ty@bootlin.com>
Date: Fri, 25 Sep 2026 16:29:26 +0200
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

On Fri, 25 Sep 2026 05:55:44 -0700, Harshit Mogalapalli wrote:
> mtd_virt_concat_create_item() links each new mtd_virt_concat_node to
> concat_node_list. mtd_virt_concat_destroy() later frees the node after
> destroying its concatenated MTD device, but fails to unlink it. A later
> list traversal dereferences the freed node, causing a use-after-free.
> 
> Remove the node from concat_node_list before freeing it.
> 
> [...]

Applied to mtd/next, thanks!

[1/2] mtd: virt-concat: unlink concat node before freeing it
      commit: 532caaa2f445b22b74b88b4023a810426772db54
[2/2] mtd: virt-concat: unlink discarded items before freeing
      commit: 112a666bd82e96e4a01e0cd8a0fb9c88dd0bce38

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

