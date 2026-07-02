Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2E373BE4;
	Thu,  2 Jul 2026 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993466; cv=none; b=ZTjgDs49GOiCiaCwH2EiFQiC+8iInwzuzDAPCj4qCrNfiFq0w9JQrDdT/pQNSnzqEGuVSXBvF0/c+QFqXsQt3JEtoen2sN5nRt337LDBocsfZmMx5jQXyz8eGUFM2w8qSBrIXSRL1BNObhqbTE1oCr4jlT/1I+pUk1ttI+wEZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993466; c=relaxed/simple;
	bh=4OAvIbKk1ROd+xOgt15p9gEsgjYco48UGEuUCINMlYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=EVGFu2fQau+OCaLgD4FVuUP6fSYA83AALQL7he8bK1IPJCgYXpd5y/g8I9UVe/StJXgAIVNdLMJABB7rBV8lZ7KnY0W2Gpdt5RfERKaIUisfHfKn/n6ll0om+UeFahV68UzeXUOvakx2GTapTYL6dTdj125jlEuFecnEoZmyFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=n/TYhyqI; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="n/TYhyqI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1782993465; x=1814529465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XCkz49E19Etc5iFn8o8j43bZJGIh6w14Def27S1kOQQ=;
  b=n/TYhyqI1+DQFExhmXnHK6uCMjBJhh3L48qJ0d7aJNzF409Z4kire8DX
   mv9gua6hJE+8ZlKLYHZhjmFKKfvtzBNSap/1R43RypWpvEWzTQBex9SEn
   NlPTGLfnu6NSIe2NM63TviMo+5NivDQ0ZoBOUfIyYRfPik8As7IA18Hx2
   DpLHTsQBCpW1SS1a2LyXWsTnGZhQUGm7KgSX4aXBi07N25BkAhLc0G0xU
   0d3ft5VQBFPBMo2whOkVs30kgmO29eY+nPYz7Z/1X2YiTcjf52i5gqtTj
   MvHU2bQ4FsrKOpKWaDozT/SCpq8tDy3ED4W8OzQJh/CrtF0+zEzYLJr6h
   g==;
X-CSE-ConnectionGUID: 4ejd4uzNSGqN+sH0hbni0g==
X-CSE-MsgGUID: C7kalaF1TD2ohysTFS7eCQ==
X-IronPort-AV: E=Sophos;i="6.25,143,1779148800"; 
   d="scan'208";a="22945047"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 11:57:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:3682]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.112:2525] with esmtp (Farcaster)
 id 73beebf7-0d64-45e3-9112-7eb54854c385; Thu, 2 Jul 2026 11:57:42 +0000 (UTC)
X-Farcaster-Flow-ID: 73beebf7-0d64-45e3-9112-7eb54854c385
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 2 Jul 2026 11:57:41 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 2 Jul 2026 11:57:40 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>, Marc Zyngier <maz@kernel.org>, Thomas Gleixner
	<tglx@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, David Woodhouse <dwmw@amazon.co.uk>, "Ali
 Saidi" <alisaidi@amazon.com>, David Arinzon <darinzon@amazon.com>, "Zeev
 Zilberman" <zeev@amazon.com>
CC: Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH] irqchip/gic-v3-its: Reconfigure ITS from software state on resume
Date: Thu, 2 Jul 2026 11:57:15 +0000
Message-ID: <akZPM6SeJiM8th0N@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260507183102.1897629-1-doebel@amazon.de>
References: <20260507183102.1897629-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Transfer-Encoding: 7bit

Hi all,

gentle ping on this one.

Since the original posting I've re-validated the fix against current
mainline:

  - It still applies cleanly to v7.2-rc1 (and to v7.1.0).

  - I reproduced the original failure on *stock* v7.2-rc1. On EC2
    Graviton instances, hibernation resume fails 100% of the time: the
    ITS comes back reset, MAPD/MAPTI are never replayed, and the ENA
    NIC silently loses its LPIs:

      ena 0000:00:05.0: ... didn't receive a MSI-X interrupt (cmd 3)
      ena 0000:00:05.0: Failed to create IO CQ. error: -62

    The instance then has no networking after resume.

  - With this patch applied, the same kernel survives hibernate/resume
    cleanly: 9/9 cycles with zero failures, across all three Graviton
    generations (Graviton 2/3/4, i.e. Neoverse N1/V1/V2), networking
    fully restored on every resume.

As described in the previous message, this is the fallout from 713335b6ee29
("irqchip/gic-v3-its: Implement .msi_teardown() callback"): device
teardown no longer happens across a suspend/resume that keeps the MSI
domain, so the ITS is never reprogrammed and drops interrupts after the
hardware has been reset.

Could you take a look when you get a chance?

Thanks,
Bjoern




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

