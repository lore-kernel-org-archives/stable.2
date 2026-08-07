Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912F537206E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111222; cv=none; b=ZRdNkzMKRGKcD3m9zKeB04tnz3WQInutfMZtPsWEE48ek5qTdC0bluDN9MHSHYDe6vifdm1PTr6KCJCCF8MAFZPCdwrLxCU1gPGphnSVIQRFh7+f54P+Gfca24C1auKo3L7HOldZm0koGXkR4m10l3EGI43bTL9aOPNe0mNMqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111222; c=relaxed/simple;
	bh=Xn+BFWZbdPVrOcHhjg3bIwYwaidUiCiyDWFvdV/spvs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nTydhjM3HE89+lv72Cmf4ybA5b8tvC4sx2HQGUHC52ZdpX6ITHAOI6pYZ9XMsddqd/N58NAcMhENukb22JfamTDYD/+fPdTy+K0mDIP43YnNq+FcmNmxVh0qkWCa4TY1gBPEHMeQD8j/s5/RzQTOZa53FLOhpQdukxmYxeJfDrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KjLpGExN; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KjLpGExN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 706EB4E4113A;
	Fri,  7 Aug 2026 14:00:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 40E85603F0;
	Fri,  7 Aug 2026 14:00:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 10F3211C37965;
	Fri,  7 Aug 2026 16:00:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786111211; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=C1oNEWoCvhuqR1zgrzy/BsEFkhQJQXIeKnt2pRb+ABQ=;
	b=KjLpGExNJZ8Nq39nRGJmXC9XjTfOcz6BqwGlZAXqeSOVHBnhDNpsr25bsbcK8GQE6+zI/3
	hDcMwszv/2Is3XBBRH+8H/8yRyhERh/1P07oePjcRv8xl0bWWpOKuCc2achlwJRd1/HoI4
	pkDA+qWpgHUslw4OS2z8R6BfvRQZeW83fbGLGKr+vPUzPygO3dsboJRzVFpwTVD9p/5J9S
	Aee0CBM/q6A11PFKr4ZNOol4ZjNxkQCfRPdmO0OMHXeoIbhjIAd5sc1g/YveuRxX+9MVA8
	Jy1jAZtp9U63OV7D77qHYYzg/o4Kz/7E5Nb0ybIKj0C5JvVW3t3HuONDsTexlQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Huang Shijie <b32955@freescale.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260720115725.10096-1-pengpeng@iscas.ac.cn>
References: <20260720115725.10096-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH v2] mtd: rawnand: validate ONFI extended parameter page
 sections
Message-Id: <178611120597.758547.13517822399489917781.b4-ty@bootlin.com>
Date: Fri, 07 Aug 2026 16:00:05 +0200
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

On Mon, 20 Jul 2026 19:57:25 +0800, Pengpeng Hou wrote:
> nand_flash_detect_ext_param_page() allocates the length declared by the
> ONFI parameter page, then treats the data as a fixed header followed by
> variable-length sections. It reads that header and advances over sections
> without first proving that the fixed page and each current section fit in
> the allocation.
> 
> Reject pages shorter than the fixed header, track the remaining variable
> area while walking sections, and require the ECC section to contain every
> field read from struct onfi_ext_ecc_info. Use device-scoped diagnostics
> that identify the malformed ONFI section.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: validate ONFI extended parameter page sections
      commit: e5e415262330bd70f983e091d8919d9dcd99e475

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

