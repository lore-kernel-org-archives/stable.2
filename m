Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484840;
	b=MjVYK/MyXDu319dFPhmWOIgouQU1zvtgJjbzNrHrENOcGm44tz9Unh66g2eWE8AzJCJD
	 cQJkNrJAsvw/pKH+nmOmfRlyQM/3LkXwRnor9B6as6nIAiRN3EfTT9LR9MFOrB3fh7lvv
	 d59SboEM7knkQSmRdIr11m/jUSc1nClkkr3KT1sZ4VrTGXheC13AA7HQjm70lSTiN751+
	 YfxVhjLtmO1BnIIiqjL2cMlP5ptL59hRB6Zhp+PCHqAQeGxb+L1eMmlHgpRA/9no2CADd
	 bRac9mh3fKAuC2D0v7OT5CEu4XCxlXCJ1Hjo5Ol1BN6DemBBoldQoUR17xigC0gFW8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kX5wt9uloTBUKENvuugEarR+eHumxWJlY0qWlOLNBew=;
	b=wsUFiSQZn6yD+ICrHNmFNY4jpLTaaq4CiNevcGN0BAHI8SZ0nNAIxz5IvD0pmzI7kLle
	 9aV1orfsV3dwfSQMKW0ILXIuv6KAWLMTqFEUcsZEgmauO8muAogWOY3J43OtS9o0EdH4U
	 LleSQpeaHkf4KaDA0e4w/ASZ4xzdxGHSDnqBozCR3ZCao0uDSrBTdbTtnHJSHbtWZfYT3
	 sjv96ITWEcMdYm5ZfgwH7X1mQvBZGHj/MyfKUjKMjhMZKfeaGW7akGYZyPAtyJN9Jg8DW
	 SB8i3AFQRuyIx8Jtw3AFvANzdashBbwiKBv7k/3hZleJJD+oIMyfRPMuL5VnWGMSnzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=iUAtxhlc;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9260A3814
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08D9260A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=iUAtxhlc
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ccacc75a997so1292679a12.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792484839; x=1793089639; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kX5wt9uloTBUKENvuugEarR+eHumxWJlY0qWlOLNBew=;
        b=iUAtxhlcoUBtjAQsA2ZKXqqDMSMvLIdtm9auFahckVtDcaW8+Ak6DrnJYAllkMPAbW
         m7WHL1NJfvdBHNa77/9ZX/1+LxT0UzpCDKG5VdiWRP5P1/wX7aGXoyNn7WUUcyPDK0eH
         6EtKfSXwGJ9cXaG9+VGSYz03X8BEAzQbVMDbD2bw+EC/jGpUsAYElhgU+2PZh1LdgJL0
         j7qfUrEFB1p+AfT7q1qdQGlHZgBeuwQe0qK1nihU/vuXYjiXy20mp8WEWGlV/EEV0+XM
         UcYwqLeRdq/pYDWdpDNvV2avQAExYjyIZJZ548BT7KRGtY32bfv51lnqR7Y0hyVfX1Ek
         c/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484839; x=1793089639;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kX5wt9uloTBUKENvuugEarR+eHumxWJlY0qWlOLNBew=;
        b=AaCQ6KhYUZDov/5NZap5T40pM0sTCHsXTJ5k0gzHpVg45IxTgirAY4sIBkz69zbXDj
         Yn8ynvwInxFLpO4RaIqiSgurx6QFLpJNUIvsGxt4vIqv/8mxqHXW3hXPMEme192/fo2G
         BcABCowmjVtqYK476alsIETNaPIrOBYNFDKd12y6q095ENOPyFk4Y67SsXzMymcmOWXk
         XVNBbJytNIsK+kUoTo4j7EFm9b02vo7baTu3pnFdDCMF2b/HjgzAs9cIu1HR39GfFD+9
         QubcoPWauGqxR1Xn4ucDZ+nfBiY18bTy0QUn6q/Arknyo9LOS0BGCgPJdLmpGH15EpeO
         D3wQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGMJIToVtxwjHelQNHIywqArijH/rpBzQAtWfkzdk+Gss8UsAYIhX+UAzSSLa9FY7rlO2wNms=@vger.kernel.org
X-Gm-Message-State: AFq9FYJp2R5hJHfN7fg6QzM02xuWdOOHnA5vhwNpfrY5Oc4PV2I6TBEY
	oj2eyTMIdmjv2oy+vDlYgLrKpt2xq/QuVV7voFhiAbP0Z/ZENgvvpLjZ3FQXbj2/eD0icLix9ka
	nmX7vOX0J1fLGsYTXY4WgIA==
X-Received: from pgp6-n1.prod.google.com ([2002:a05:6a02:62c6:10b0:ccb:62e:3f01])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a120:b0:3e2:257a:a61f with SMTP id adf61e73a8af0-3e226025463mr9267663637.59.1792484838935;
 Tue, 20 Oct 2026 01:27:18 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:27:17 +0800
In-Reply-To: <78888420b7c60d2d5177cbf76f5efba04fab5d7b.camel@mediatek.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261017084403.875420-1-stanleyjhu@google.com>
 <2e042211ca0ebc974ad5ec4c0de9f3f93b3c75c0.camel@iokpp.de> <2060a8da-581b-46d1-a510-779f4df716cd@acm.org>
 <78888420b7c60d2d5177cbf76f5efba04fab5d7b.camel@mediatek.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020082717.3540301-1-stanleyjhu@google.com>
Subject: Re: [PATCH v2 0/4] scsi: ufs: core: Factor hba->outstanding_reqs
 helper and fix double completion
From: Stanley Jhu <stanleyjhu@google.com>
To: Peter Wang <peter.wang@mediatek.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@iokpp.de>, "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bean Huo <beanhuo@micron.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2026-10-20 at 11:16 +0800, Peter Wang wrote:
> So, should we remove the call to __ufshcd_transfer_req_compl from
> ufshcd_abort, which was added by commit
> 64180742605f ("scsi: ufs: Fix the SCSI abort handler")?

__ufshcd_transfer_req_compl() is a wrapper around
ufshcd_compl_one_cqe(), so calling it from ufshcd_abort() has the two
issues Bart noted. In addition, ufshcd_abort() called it without
clearing BIT(tag) in hba->outstanding_reqs, which left the command to be
released a second time by a later ufshcd_poll() or LU reset.

In v3 6/7 [1], we replace that __ufshcd_transfer_req_compl() call with
claiming BIT(tag) via ufshcd_clear_outstanding_reqs() and calling
ufshcd_release_scsi_cmd() if it is a SCSI command, matching the end of
ufshcd_abort().

[1] https://lore.kernel.org/r/20261020082110.3511797-7-stanleyjhu@google.com
