Received: from mailer241.gate86.rs.smtp.com (mailer241.gate86.rs.smtp.com [74.91.86.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45A52E8B83
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.91.86.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045068; cv=none; b=nLLGrISje26KWABhl0eJ59Sk99DZ7bbJMtWvwLpYv/66lwPlDLRdabJgr91okKopxnJHeib0Bf0q9Vp4fL/C7URPlDtqF9fAPxECkilCXlFySUPZCfJGGZj9+ziAfmamZwDdYzXROVl29+hcNYTGdISIZhplnlZdfFa5Q8rSS7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045068; c=relaxed/simple;
	bh=w2lh7ptEnPTKkoQwNFhNxV06/VvmaNakq+TNlN/nnRU=;
	h=From:Subject:To:Content-Type:Date:Message-Id; b=ZH2YzHpGT51yHQwYXb7lQsvSOQMxu8fcK4p9saXneTAjtra+T3iOxvDeFp51YJ3o4iE6TysGLl5Q7KYGEBG9iWEg1htpLGnjgSkBZWLVejBintc/Rmz/mfPNOfiuAYpy7L3VTTgtbWNlu8h9j2WjGaCNl/vWtLlHr3ZjFr57FG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=computergamingpc.com; spf=pass smtp.mailfrom=computergamingpc.com; dkim=pass (2048-bit key) header.d=computergamingpc.com header.i=@computergamingpc.com header.b=cDlLYEVm; dkim=pass (2048-bit key) header.d=smtpmessage.com header.i=@smtpmessage.com header.b=fzKkhUbw; arc=none smtp.client-ip=74.91.86.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=computergamingpc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=computergamingpc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=computergamingpc.com header.i=@computergamingpc.com header.b="cDlLYEVm";
	dkim=pass (2048-bit key) header.d=smtpmessage.com header.i=@smtpmessage.com header.b="fzKkhUbw"
X-Report-Abuse: SMTP.com is an email service provider. Our abuse team cares
 about your feedback. Please contact abuse@smtp.com for further investigation.
Received: from [10.0.16.252] (unknown [10.138.12.189])
	by s0-aws-app2-mta-out-2 (Halon) with ESMTP
	id ff413e73-8089-49b9-8df7-6a20563000da;
	Thu, 10 Sep 2026 12:37:38 +0000 (UTC)
Received: Received from 10.138.12.155 by Caffeine
 (s0-aws-app2-swarm-manager-1) with SMTP id
 d43bf343-aac0-4462-b3dc-f283f4a12634  for stable@vger.kernel.org;
  Thu, 10 Sep 2026 12:37:08 +0000 (UTC)
Feedback-ID: 9194450:SMTPCOM
Received: from ObaTech (unknown [191.177.202.135])
	by s0-aws-app2-mta-in-1 (Halon) with ESMTPSA
	id d43bf343-aac0-4462-b3dc-f283f4a12634;
	Thu, 10 Sep 2026 12:37:08 +0000 (UTC)
From: "Computer Gaming pc" <sales@computergamingpc.com>
Subject: Current Inventory Update: GPUs & Enterprise SSDs Available
To: <stable@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Reply-To: <sales@computergamingpc.com>
Date: Thu, 10 Sep 2026 13:37:08 +0100
Priority: urgent
X-Priority: 1
Importance: high
Message-Id: <202610091337082DF2346837-7CD7C33BD7@computergamingpc.com>
X-SMTPCOM-Sender-ID: 9194450
X-SMTPCOM-Tracking-Number: d43bf343-aac0-4462-b3dc-f283f4a12634
X-SMTPCOM-Message-ID: 890b4da2-655c-4e39-80c6-1b55835e69e3
X-SMTPCOM-Payload: 
 dfJemDD78dXkwXlRdIy9O1dsuFIjZUACX7Jm6W6bzqKccDOobsidgtzAdyHk9bb1FSHNVEyj-VJ0KSdSij2MFvKSH31LxmZxJwGjWNSEwuUK97Pln1US7xoqR2pQTKeQDZ-qaLHsn5n3dbgqFO4tfisMs9MYR6WAnqZUV0m466-oE6ZbDmDm36pWaDG1GgZB
List-Unsubscribe-Post: List-Unsubscribe=One-Click
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=computergamingpc.com; i=@computergamingpc.com; q=dns/txt; s=smtpkey;
 t=1789043849; h=feedback-id : from : subject : to : content-type :
 content-transfer-encoding : reply-to : date : message-id :
 list-unsubscribe : list-unsubscribe-post : from : subject : to : date;
 bh=w2lh7ptEnPTKkoQwNFhNxV06/VvmaNakq+TNlN/nnRU=;
 b=cDlLYEVm+VOQEEb31/3KHNsF2pjiehkhvnZP2v9IUJ09TYa24Qhyh6keMZjLV6LhlIW+2
 tlhb392DzX3AE8+4Rl5jKFNE/62ljyVqcImlmIEyaL75S2DhkawdUMGXAazfOJwHG9e0ULz
 unVqlxSqIqU/ad5ly29MJlTQBc1e4HoDkvSh2gOzs4Z1jrKBqVDouYJHAP03trRlw7c91sN
 B7rfed78G4psoVbxaf6mAorQOATbus+bikrbKKBoGCuBgSI+aVtb+Aibb8sppta1QTJxv+7
 HosvBemAxe9aVGSzi/z/ytfjDEnoDoavel2Z0RvPr0DO5bQwB3zlTDmEpQoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=smtpmessage.com;
 i=@smtpmessage.com; q=dns/txt; s=smtpcustomer; t=1789043849;
 h=feedback-id : from : subject : to : content-type :
 content-transfer-encoding : reply-to : date : message-id :
 list-unsubscribe : list-unsubscribe-post : from : subject : to : date;
 bh=w2lh7ptEnPTKkoQwNFhNxV06/VvmaNakq+TNlN/nnRU=;
 b=fzKkhUbw0IqeDyHFEsHreKHZrz11RbnymNN2J/amq1rmS1laNGmfBF4Y2hZ60JlI9FPkT
 1Ez32dAwoQNiRtbK8CvujNahhcyWaJahMkJVRQ7aIy1gz6TaBzd5HymukwQ7R6YrPN9Q2RV
 bbwma5kj6kgXDA7VHkQOob2dyVFhiFyKqpLObMfEpdrilRRZg9qT3whojdNLMSzSV5zirVy
 t2yMSJkwUCPeNHaMzvDcsXTqBJeic8QCgZxjb2eJlC2XwQJ/7jkr4Ah5y+lbltV/J8QOrjz
 5KgmgPRrU2fq+0dj1jnAsVO2MfR2X/bBol4ghSfJ8dsoFO/cmnT/2zIJRhXg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Dear Partner,
We’re pleased to share a current snapshot of our available inventory for 
immediate dispatch.

Memory Modules
* 128GB 4DRx4 DDR4 PC4-2933Y REG ECC LRDIMM (Qty: 980) – $140.00
* 32GB Dual Rank x4 DDR4-2933 CAS-21 (Qty: 1,500) – $1,140.00
* 64GB Dual Rank x4 DDR4-2933 CAS-21 (Qty: 1,200) – $1,450.00
* 32GB Dual Rank x4 DDR4-3200 CAS-22 (Qty: 1,500) – $1,150.00
* 64GB Dual Rank x4 DDR4-3200 CAS-22 (Qty: 1,100) – $1,450.00
* 32GB 2Rx4 PC4-2400T (Qty: 1,500) – $45.00
* 32GB 2Rx4 PC4-3200AA (Qty: 1,500) – $45.00
* 16GB 2Rx8 PC4-3200AA (Qty: 1,500) – $20.00
NVIDIA H200 NVL 141GB — Qty: 10 — $26,500
Nvidia PRO 6000 96G Server Edition - $10,000.00
RTX 5090 Founders Edition 32GB (90 units) – $2,800 

Solid State Drives
- SSD SATA 6G 3.84TB SFF (Qty: 450) – $120.00
- SSD SAS 12G 960GB SFF (Qty: 470) – $300.00
- SSD SAS 12G 1.92TB SFF (Qty: 560) – $350.00
- SSD SAS 12G 3.84TB SFF (Qty: 560) – $150.00
- SSD SATA 6G 1.92TB SFF (Qty: 450) – $100.00
- Samsung 990 PRO 1TB NVME SSD QTY:410 - $150

- HP (HPE) P43331-B21 64GB DDR5-4800 RDIMM QTY: 390 - $1,750
- DDR5 64GB 4800Mhz ECC RDimm 2Rx4 P43331-B21 (Qty: 500) – $1,750.00
- DDR5 64GB 5600Mhz ECC RDimm 2Rx4 P64707-B21 (Qty: 500) – $1,750.00
- DDR4 64GB 3200Mhz ECC RDimm 2Rx4 SK Hynix (Qty: 500) – $1,450.00
- DDR5 64GB 4800Mhz ECC RDimm 2Rx4 Samsung (Qty: 500) – $1,450.00
- DDR5 64GB 5600Mhz ECC RDimm 2Rx4 SK Hynix (Qty: 500) – $1,550.00
- Intel Xeon Silver 4214R - QTY: 420 $350.00
- Intel Xeon Gold 5220R - QTY: 410 - $450.00
- Intel Xeon Platinum 8380: $450.00 QTY: 410
- AMD EPYC 7542 - QTY: 490-- $380.00

Storage & CPUs 
Samsung PM9A3 2.5" SSD PCIe 4.0 7.68TB (115 units) – $650 
7.68TB SAS SSD 2.5" 12G Server Drive (140 units) – $650 
Intel Xeon Silver 4214R (120 units) – $300 
Intel Xeon Gold 5220R (130 units) – $300 
AMD EPYC 7542 (97 units) – $450 
Intel Xeon Platinum 8380 (95 units) – $450
HFS001TEM9X173N PVC10 NVMe SK Hynix 1 TB - $85 (500 unit)

For quotes, availability, or inspection scheduling, please reach out 
directly:
sales@computergamingpc.com Call or WhatsApp: +1(774) 559-1248 | +1 (641)232-
4364
Thank you for your continued partnership.
Ann Kamila
Computer Gaming PC Trading
2500 US-6, Iowa City, IA 52240, USA.
