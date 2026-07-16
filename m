Received: from mailer241.gate86.rs.smtp.com (mailer241.gate86.rs.smtp.com [74.91.86.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDC4357D03
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.91.86.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207168; cv=none; b=gevM719WZd+7fHPvDeC//9sb+9/O9Z7gYyvpCx4X9Lhjmto/XLK3fpkEOKKYPQYVRJlMoonOcXLW+02CkuQqNAC32ncgwiC9tuxSQwxPELlVmO8qgJbT6JHv0qNnfwHHr/lAQsaGFERy/4Mld95de2PqpQxYFAxu+04wKHSHH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207168; c=relaxed/simple;
	bh=Rn89dfL6FWPUehEVjmWIx5moDiRsrqTA+wfW2mcNVN0=;
	h=From:Subject:To:Content-Type:Date:Message-Id; b=BT+Y1N1rRhCvR9RQO6rWeKp8WF+ELWsSHtrZalNwof0hw5/YE901O1Xy5YJhATY0+niVJlNYfEKtZ+TytO/UXhTnS9ZHg8tlDGy4sYWSAOUhd6KnDj6DUk/rn7qNr4ZSaBQB4dATIe/ZJu37pIOr1qoIRWUgjveMYzScvdkojDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=computergamingpc.com; spf=pass smtp.mailfrom=computergamingpc.com; dkim=pass (2048-bit key) header.d=computergamingpc.com header.i=@computergamingpc.com header.b=cVThmWEr; dkim=pass (2048-bit key) header.d=smtpmessage.com header.i=@smtpmessage.com header.b=huMBrnLK; arc=none smtp.client-ip=74.91.86.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=computergamingpc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=computergamingpc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=computergamingpc.com header.i=@computergamingpc.com header.b="cVThmWEr";
	dkim=pass (2048-bit key) header.d=smtpmessage.com header.i=@smtpmessage.com header.b="huMBrnLK"
X-Report-Abuse: SMTP.com is an email service provider. Our abuse team cares
 about your feedback. Please contact abuse@smtp.com for further investigation.
Received: from [10.0.16.30] (unknown [10.138.12.210])
	by mtl-mta02-out1 (Halon) with ESMTP
	id d60737da-1e54-4b4a-9922-cff87e56355a;
	Thu, 16 Jul 2026 12:45:59 +0000 (UTC)
Received: Received from 10.138.12.169 by Caffeine
 (s0-aws-app2-swarm-manager-5) with SMTP id
 9da6c34c-6587-4c25-b854-195db5d9ee51  for stable@vger.kernel.org;
  Thu, 16 Jul 2026 12:45:11 +0000 (UTC)
Feedback-ID: 9194450:SMTPCOM
Received: from ObaTech (unknown [191.177.193.228])
	by s0-aws-app2-mta-in-2 (Halon) with ESMTPSA
	id 9da6c34c-6587-4c25-b854-195db5d9ee51;
	Thu, 16 Jul 2026 12:45:11 +0000 (UTC)
From: "Computer Gaming pc" <sales@computergamingpc.com>
Subject: Current Inventory Update: GPUs & Enterprise SSDs Available
To: <stable@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Reply-To: <sales@computergamingpc.com>
Date: Thu, 16 Jul 2026 13:45:12 +0100
Priority: urgent
X-Priority: 1
Importance: high
Message-Id: <2026160713451108F3D8BC42$C1A36F3E5D@computergamingpc.com>
X-SMTPCOM-Sender-ID: 9194450
X-SMTPCOM-Tracking-Number: 9da6c34c-6587-4c25-b854-195db5d9ee51
X-SMTPCOM-Message-ID: dcddf191-fd1c-40e5-bcea-65007b6648ad
X-SMTPCOM-Payload: 
 URsNS4f5Ygq8kSJUs5lFR_vLcmj43O6glhoZIZ9wUBQV02YOiAv8OwP56z_OM7gDspqS7yiFvmqgz5FgaJbQV8lklqYVd4MX2ADNTExEczMW5tt5Xd5UJ4-H1qAovySGiZxG12-BKdDqz60Q3L9dJJ4wra_vl2uxVwur9EsWAlOLm4C8OxmMdKxso54D8Gkx
List-Unsubscribe-Post: List-Unsubscribe=One-Click
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=computergamingpc.com; i=@computergamingpc.com; q=dns/txt; s=smtpkey;
 t=1784205937; h=feedback-id : from : subject : to : content-type :
 content-transfer-encoding : reply-to : date : message-id :
 list-unsubscribe : list-unsubscribe-post : from : subject : to : date;
 bh=Rn89dfL6FWPUehEVjmWIx5moDiRsrqTA+wfW2mcNVN0=;
 b=cVThmWEr2gSLKphxaxF2g11l0OAm/l7w8QRKJ8Qb7WXiq9v3AlIKjj9+owQsME0Lmh1Ke
 DFyMnY4THYh/H4BnX83m9OaJj8AVmuEpAKkUFEqa2TH5NqHqWEKPyheOKFr6pib+GUO4IJC
 pgeVJCCeZGbsfDoZ4m5axwMju4SdRAX+SHSbIpYLkLD5qAftnCb1Vx2dbtq8gIQuuWnOdei
 NEQLzrvtxw7RpgF337cjU3GnynVcZHvGz/tHAFR5LQBMNzPI11kSHuBHHOVoZQZLxm3Ek2d
 Z3lN3jEnIopwsZA4cSWlCyZYhO4Eh4jwWZFpLopZRvhq/dV+LqQGlKHkFrOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=smtpmessage.com;
 i=@smtpmessage.com; q=dns/txt; s=smtpcustomer; t=1784205937;
 h=feedback-id : from : subject : to : content-type :
 content-transfer-encoding : reply-to : date : message-id :
 list-unsubscribe : list-unsubscribe-post : from : subject : to : date;
 bh=Rn89dfL6FWPUehEVjmWIx5moDiRsrqTA+wfW2mcNVN0=;
 b=huMBrnLKRrD9MkNa160Jow+W8vtq5meq5F56DBsDFyNmJoh2Vao6bIOQ9iFX12BmBULKI
 fKE9wCrqBqqm/zVCyDgBqmNMx0xWqQlDPjMQZjCwIDo18z9J5cO0/R5b7P/MXNCCjCNRKGM
 iBPbcG0Saq7yRknLHf51v2ZW9TQpfJI36E9vmbVUEF0HtIRhm8WA1mLwddADQ1LE8Owbpc0
 StkpAC0gJ9p+a1veISxi08r5MkpmUMbtxg3gfQXysEClJKlY4sfrohk6d6c5eBhRGfE8+W8
 3Zc7Eb+nIW0gdGYTYLVd4KsDyJEiPYH77T2IYFkEPaYCfgojkQWjAjg5ZgQw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Hi
Quick update — these units are in stock and can ship today:

Memory Modules
* 128GB 4DRx4 DDR4 PC4-2933Y REG ECC LRDIMM (Qty: 980) – $140.00
* 32GB Dual Rank x4 DDR4-2933 CAS-21 (Qty: 1,500) – $140.00
* 64GB Dual Rank x4 DDR4-2933 CAS-21 (Qty: 1,200) – $450.00
* 32GB Dual Rank x4 DDR4-3200 CAS-22 (Qty: 1,500) – $150.00
* 64GB Dual Rank x4 DDR4-3200 CAS-22 (Qty: 1,100) – $450.00
* 32GB 2Rx4 PC4-2400T (Qty: 1,500) – $45.00
* 32GB 2Rx4 PC4-3200AA (Qty: 1,500) – $45.00
* 16GB 2Rx8 PC4-3200AA (Qty: 1,500) – $20.00

Solid State Drives
- SSD SATA 6G 3.84TB SFF (Qty: 450) – $120.00
- SSD SAS 12G 960GB SFF (Qty: 470) – $300.00
- SSD SAS 12G 1.92TB SFF (Qty: 560) – $350.00
- SSD SAS 12G 3.84TB SFF (Qty: 560) – $150.00
- SSD SATA 6G 1.92TB SFF (Qty: 450) – $100.00
- Samsung 990 PRO 1TB NVME SSD QTY:410 - $150

- HP (HPE) P43331-B21 64GB DDR5-4800 RDIMM QTY: 390 - $750
- DDR5 64GB 4800Mhz ECC RDimm 2Rx4 P43331-B21 (Qty: 500) – $750.00
- DDR5 64GB 5600Mhz ECC RDimm 2Rx4 P64707-B21 (Qty: 500) – $750.00
- DDR4 64GB 3200Mhz ECC RDimm 2Rx4 SK Hynix (Qty: 500) – $450.00
- DDR5 64GB 4800Mhz ECC RDimm 2Rx4 Samsung (Qty: 500) – $450.00
- DDR5 64GB 5600Mhz ECC RDimm 2Rx4 SK Hynix (Qty: 500) – $550.00
- Intel Xeon Silver 4214R - QTY: 420 $350.00
- Intel Xeon Gold 5220R - QTY: 410 - $450.00
- Intel Xeon Platinum 8380: $450.00 QTY: 410
- AMD EPYC 7542 - QTY: 490-- $380.00

For quotes, availability, or inspection scheduling, please reach out 
directly:
sales@computergamingpc.com Call or WhatsApp: +1(774) 559-1248 | +1 (641)232-
4364
Thank you for your continued partnership.
Ann Kamila
Computer Gaming PC Trading
2500 US-6, Iowa City, IA 52240, USA.
To opt out of future updates, reply with “REMOVE” in the subject line.
