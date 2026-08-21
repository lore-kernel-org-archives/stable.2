Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F2E30C619;
	Fri, 21 Aug 2026 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787275099; cv=none; b=ERZzFPDE8CaATMhIMClMrdb72IzICyMFKDgRLTiXK3v/FCyoP9x06miIWxrDGvAnqwSECxkfNtlLgQrGEx0J7N4Vim0DdvRk85bRzbLsuJFvNTeLd3fNnFE5S7cLrPZqQ7FeMVEGRie0rjuvKRla7qboddkhCXpUZkjyUmw2BPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787275099; c=relaxed/simple;
	bh=V4KBPezujvLEYZQIAy6LZrHJ3s9IZRdJuUtkvZnlNOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QOWPLrMuruBP2mGg2wSLpJSm6ri5y1r9yH/yQRqt5V9SOtcA71H6GIbVDqsJ/tWLICD9Z/DCmpCYTDsl4F0QnsFnwgaljM3cVXhbr3i3Vyghe+wudXCACAoqC1QhOTeydKFU48lp/FbtXsxkiAlZRxwcRjh+D+cacZGWUYvK7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2c4fd48a9cfe11f19a56ed5b684f684d-20260821
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:67fda1e7-4a35-475c-a916-95bdb6d448d3,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:086a8dca4aae43578162ead21d663c29,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|850|865|898|915,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2c4fd48a9cfe11f19a56ed5b684f684d-20260821
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 70470155; Fri, 21 Aug 2026 09:18:10 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Eric Anholt <eric@anholt.net>,
	kernel-list@raspberrypi.com,
	linux-input@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: raspberrypi-ts - reject out-of-range point counts and slot IDs
Date: Fri, 21 Aug 2026 09:18:07 +0800
Message-Id: <20260821011807.2909700-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPY8ntBO5Rk6dEcRc9SgYKpgF6=KBxg7STpLT02whQ8pY-BW0w@mail.gmail.com>
References: <20260820065340.3765457-1-gonglinkai@kylinos.cn> <CAPY8ntBO5Rk6dEcRc9SgYKpgF6=KBxg7STpLT02whQ8pY-BW0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dave

On Thu, 20 Aug 2026 18:43:05 +0100, Dave Stevenson wrote:
> TBH I'd support dropping this driver entirely. Will anyone object if I
> send a patch to do that?

Fine by me. If it goes, this patch doesn't need to land.

> Can you just abort here?
> If this was with i > 0 then there has already been 1 or more
> input_mt_slot(), input_mt_report_slot_state(), and
> touchscreen_report_pos() calls which update the device state.

Yeah, that's a fair point. Returning in the middle of the loop
leaves the earlier slots already updated.

If the driver stays I'll send a v2 that checks all the IDs first.

Thanks,
Linkai
