Received: from mailer241.gate86.rs.smtp.com (mailer241.gate86.rs.smtp.com [74.91.86.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C5F2DB7B4
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.91.86.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785702153; cv=none; b=Nivxqiiv7CeVyF9kdjfdtyBnraZykqcfPDq3CnMAg0a8ZwBXKg9mslSYaX/JQW/uvQjhSodPODE300rf0tMOmML4n9wUSCGN93Nm/2tSvlVSVWolGUS27cYjrl2ned05Yy4r0EFOs0p7WWoJKOYIS+ipoG4XGStlJMUtYc0VztE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785702153; c=relaxed/simple;
	bh=qltARmYzXUm3qHAeK/h0ZIoqQNWedRlot+Q0d5xsxlg=;
	h=From:Subject:To:Content-Type:Date:Message-Id; b=iSr1oglhTdXwHq4rZnWYJVw2BbNAljR626EHoflf8t//nk4kc+szeu4o7k5KincT3ryL/946dIo3GliXrAwBcezzNqbPE6A1e4VYj5xbFJM/0ZDFbh6CLHWoVdATnDa+M6tYVcw6sNJRNeKmW9w9szBZg33AYuahS/EWYOhxsBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=computergamingpc.com; spf=pass smtp.mailfrom=computergamingpc.com; dkim=pass (2048-bit key) header.d=computergamingpc.com header.i=@computergamingpc.com header.b=KKaDYhKx; dkim=pass (2048-bit key) header.d=smtpmessage.com header.i=@smtpmessage.com header.b=dN/Z2UZQ; arc=none smtp.client-ip=74.91.86.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=computergamingpc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=computergamingpc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=computergamingpc.com header.i=@computergamingpc.com header.b="KKaDYhKx";
	dkim=pass (2048-bit key) header.d=smtpmessage.com header.i=@smtpmessage.com header.b="dN/Z2UZQ"
X-Report-Abuse: SMTP.com is an email service provider. Our abuse team cares
 about your feedback. Please contact abuse@smtp.com for further investigation.
Received: from [10.0.16.130] (unknown [10.138.12.176])
	by mtl-mta02-out1 (Halon) with ESMTP
	id 13cf993b-e0d2-4240-9bd1-6f4534914304;
	Sun, 02 Aug 2026 20:02:24 +0000 (UTC)
Received: Received from 10.138.12.169 by Caffeine
 (s0-aws-app2-swarm-manager-4) with SMTP id
 0b14e043-d796-4cf3-8eae-d47557f9a8b3  for stable@vger.kernel.org;
  Sun, 02 Aug 2026 20:02:19 +0000 (UTC)
Feedback-ID: 9194450:SMTPCOM
Received: from ObaTech (unknown [191.177.202.7])
	by s0-aws-app2-mta-in-2 (Halon) with ESMTPSA
	id 0b14e043-d796-4cf3-8eae-d47557f9a8b3;
	Sun, 02 Aug 2026 20:02:19 +0000 (UTC)
From: "Computer Gaming pc" <sales@computergamingpc.com>
Subject: Availability Update: Memory, GPU & Server Components
To: <stable@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Reply-To: <sales@computergamingpc.com>
Date: Sun, 2 Aug 2026 21:02:19 +0100
Message-Id: <20260208210218CFE6711280-530929AC26@computergamingpc.com>
X-SMTPCOM-Sender-ID: 9194450
X-SMTPCOM-Tracking-Number: 0b14e043-d796-4cf3-8eae-d47557f9a8b3
X-SMTPCOM-Message-ID: 0dbc182e-cf53-487e-b3dd-64773d1ad9d9
X-SMTPCOM-Payload: 
 hyFFowMMdPaVtp03aS-NFVmAT1xfiz0OtvYcuAwJf0KbVrKaQCMZTsAdHauLVvrf1-fOa5BGMchgOKJYAA9STxvo2uNkSk8GnqsLeGvpUIfmlKNpQ4mawckoxlbZrIREC1KyEPyTPxBvFPraxdHDmmiEVOA_Xtu9-pCDjq54qp2Pp4a3j8I2ROXEvxfPuvLe
List-Unsubscribe-Post: List-Unsubscribe=One-Click
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=computergamingpc.com; i=@computergamingpc.com; q=dns/txt; s=smtpkey;
 t=1785700940; h=feedback-id : from : subject : to : content-type :
 content-transfer-encoding : reply-to : date : message-id :
 list-unsubscribe : list-unsubscribe-post : from : subject : to : date;
 bh=qltARmYzXUm3qHAeK/h0ZIoqQNWedRlot+Q0d5xsxlg=;
 b=KKaDYhKxwwr/32352PdcLYW4xRvAnQykHOHbwVkPWq5nblHtHAcyTVAY9M9ABkkK4qbjt
 Ogf3o/mhg9dJQ0+q6CbRSO3PwfczY7TzZ6kbKEntMhtQ9zf1MH0bCpUNFNMiS+zIKjHZ36F
 GQeXUjR/V6cJJ0Rbi+k0C65Fpmf8qOnN3CO62HUiLB2B89URmAshWSwGdWagSw40tVlf4Fd
 6D3wvtt0B6g27Ytze8AzFuS85i+nuY2uXx1BQJeUZYeArfUvdSDfJiSso9dq+I5qieeUq3p
 /IblYy4IPwX2QgtiYzodnndKq9MytiWrYyXOafL7ykoJAf7Lv76dlyETaQKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=smtpmessage.com;
 i=@smtpmessage.com; q=dns/txt; s=smtpcustomer; t=1785700940;
 h=feedback-id : from : subject : to : content-type :
 content-transfer-encoding : reply-to : date : message-id :
 list-unsubscribe : list-unsubscribe-post : from : subject : to : date;
 bh=qltARmYzXUm3qHAeK/h0ZIoqQNWedRlot+Q0d5xsxlg=;
 b=dN/Z2UZQ62+3tJV/BB0jQPvjDu8QxtiHBpKg2L3Kc3hcgIEWFOsLZoRHzgV0uibzMy2/k
 sKQkPIKiCDWroW67c71bWkqa+7K6FzuzkI7Ty3LnbTs8tpzF+iwSrktkLKQO5+rjZ48wlPD
 csNaJUHXTc6MLFph4LKKwuYNRS2yFqIw6DRxUncH9ZCVlUmg4zdAyse9/FY9vvtciAmGNCf
 c9nYAJyUpssJtVmXI6U7JQsi1T3HBytk3ZMmVPDAvDFmf1bAJKPtg5zxCKO+Ez8alR/pD90
 SJOJnB2UyyrrmKugw22Lc70GdUMH9ZYAxQ66qjma2F5WzTca+0riGL9xfaCg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Dear Partner,
We’re pleased to share a current snapshot of our available inventory for
immediate dispatch.

Memory Modules
32GB 2Rx4 PC4-2400T (1,500 units) – $40
32GB 2Rx4 PC4-3200AA (1,500 units) – $40
16GB 2Rx8 PC4-3200AA (1,500 units) – $20
128GB 4DRx4 DDR4 PC4-2933Y REG ECC LRDIMM (980 units) – $170
- DDR5 64GB 4800Mhz ECC RDimm 2Rx4 Samsung (Qty: 500) – $750.00
- DDR5 64GB 5600Mhz ECC RDimm 2Rx4 SK Hynix (Qty: 500) – $850.00

GPUs & Accelerators
RTX 5090 Founders Edition 32GB (90 units) – $2,800
RTX 4090 24GB (45 units) – $1,700
RTX 4090 Founders Edition 24GB (90 units) – $2,500
RTX A6000 48GB Ada (54 units) – $1,100
RTX 6000 48GB Ada (51 units) – $1,200
Nvidia L40s GPU (12 units) – $3,000
Nvidia H100 80GB PCIe (9 units) – $20,000
Nvidia PRO 6000 96G Server Edition - $10,000.00 QTY: 17
Storage & CPUs
Samsung PM9A3 2.5" SSD PCIe 4.0 7.68TB (115 units) – $650
7.68TB SAS SSD 2.5" 12G Server Drive (140 units) – $650
Intel Xeon Silver 4214R (120 units) – $140
Intel Xeon Gold 5220R (130 units) – $200
AMD EPYC 7542 (97 units) – $450
Intel Xeon Platinum 8380 (95 units) – $450

For quotes, availability, or inspection scheduling, please reach out 
directly:
sales@computergamingpc.com
Call or WhatsApp: +1(774) 559-1248 | +1 (641)232-4364
Thank you for your continued partnership.
Ann Sam
Computer Gaming PC Trading
2500 US-6, Iowa City, IA 52240, USA
To opt out of future updates, reply with “REMOVE” in the subject line.
