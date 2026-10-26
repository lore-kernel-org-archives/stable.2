Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.127
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984311;
	b=Yr0DO+jrhuXOalMY3+d/33r/g9U3jQ+BdQOYtFihFjp6CHTCMUaBfdIIpv20FLOa7z4E
	 eNmv0VXsPePLGbpzD9GsL7nwu3xTKLWSJTjbo2UiMWQQR5zEEasfOuBjXgz7cE1KhuOjb
	 u78sTn9aBOon0C7R23G9xANBcTYEn1WdmF/l7kXBU8fX4hSQ7ZOESqW/njte8mgIi2vfZ
	 D3GhARpnHo7tFAvjnAFCRoj6eayttTxNNmSjebyMr5n2hXI+LgA+ZCruo+OLSDm6z2x1y
	 XbPyeyOxjuRyeQCchtJ9Pf4lCUyVRHiqn5u+4mJ3CT4RT+aj22DvSbmEy+GjFZtiWZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984311;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D5e6RWMfDcyV1F0L2JTnQ3pw+rEKxZ8VX2v6h/59qmc=;
	b=RYu6ChG4HB2JPlDTKvgvkX8Bh6I/UvJ0ins7VDlJQnekAqdWR1olddGkCUl0nYcM7uQ+
	 vJr9M6WQGfmtOA4Gl+rz7Qm4IEo4cej1APiBWVYhwdfKgj/uMGkbxxxVhpFqX6vELfS1N
	 r547kU/OtqnF0rgqqCxOPua2xffuCMeTlChFy7c27qv9aIR0JzZjmqhG09Ybr2pUtudxJ
	 lY1Ly4bxThRx/yDI341iCQPSf7CUQYQqOMivmBNnMohxih8cHSxNvnwCZxbMxKsSUjMX+
	 bgVgWwa8eWy6bdAhY7UsW8qNHA9ixU5bhs/8MpjQ0aqbcJ6jUH3ZXJc+UP/h4fmeCxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=u11TTGgg;
	arc=none smtp.remote-ip=115.124.28.127
Received: from out28-127.mail.aliyun.com (out28-127.mail.aliyun.com [115.124.28.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37109606A31A;
	Mon, 26 Oct 2026 03:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37109606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=u11TTGgg
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792984300; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=D5e6RWMfDcyV1F0L2JTnQ3pw+rEKxZ8VX2v6h/59qmc=;
	b=u11TTGggpyi5OUgkcBphUkmNpanuQoG7pnm2PCViUiQoFb99fA9HblvhxOeoSC99L37C1IcQ6vM8Ob3Tb5vS9H9saUdtkPWrNRTJeAr9a6uErhZA18go4c7yyYP8TrEYJdSuemEDvg19cpsCKpvcUXAaxzQ1KRB29EVuReRvIDo=
X-Alimail-AntiSpam:AC=SUSPECT;BC=0.654752|-1;BR=01201311R141b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_system_inform|0.0666771-0.00040374-0.932919;FP=350682130323022944|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jpV4g4E_1792984298;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jpV4g4E_1792984298 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 11:11:39 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: hminas@synopsys.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH] usb: dwc2: gadget: fix off-by-one in ep_from_windex bounds check
Date: Mon, 26 Oct 2026 11:11:38 +0800
Message-ID: <20261026031138.35911-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ep_from_windex() uses idx > hsotg->num_of_eps to validate the
endpoint index. Since valid indices are below num_of_eps, an index
equal to num_of_eps passes the check and is used to access
eps_in[] or eps_out[] out of bounds. This can cause an unintended
endpoint pointer to be used by subsequent request handling.

Reject indices greater than or equal to num_of_eps to prevent the
out-of-bounds access.

Fixes: b3f489b2b658 ("usb:hsotg:samsung: Determine number of EPs from HW configuration register")
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/usb/dwc2/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 0637bfbc0..b2a25cd5c 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -1582,7 +1582,7 @@ static struct dwc2_hsotg_ep *ep_from_windex(struct dwc2_hsotg *hsotg,
 	if (windex >= 0x100)
 		return NULL;
 
-	if (idx > hsotg->num_of_eps)
+	if (idx >= hsotg->num_of_eps)
 		return NULL;
 
 	return index_to_ep(hsotg, idx, dir);
--
2.50.1

