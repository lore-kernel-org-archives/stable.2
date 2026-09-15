Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCCE3BCD33
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477034; cv=none; b=LhJeVlABOgyfVY5RjmdanW8S/BodyMWFELo1Lb5FBBJ4IKJKoULDNxscohsk6Y4PUkxHxVGa5HZKZrEkVpcNe3eZXgL55v7HvLQCEA0TLeJ+FUz+4G8t+IfWTszMDFz7Wxlsm3fC0hb7VwkxsUkj52kqRPImvXIYwGi+TMBNSWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477034; c=relaxed/simple;
	bh=oqb8nvlmmS3V1q8DiP4hXJCF9W9ruyOD2JpBI6MRZaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brZWhnw4Jaxb4h009gkx5Y/K8QhZ4TU0HVlUG27/7UBDEFp/IOGfq/OgbAwFAbKJ7Uzlj7uTIYC0RtgQwuFk1jyS/vjiuGZJezxFtVbzGVV9FbMRsnkEKfDElVbfYIjek5J+eeAvRfzypWuHWcFi3dPEQcFRl5q2UQWM2tYM9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U18zBuLn; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U18zBuLn"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78565b4db77so1734568137.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789477032; x=1790081832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L1JcDlshcJnjTO9t6bNJvx2l7c6AJb/4TmbKI6h+KKo=;
        b=U18zBuLn5Rbn7oZ6ar0E/kAW8p9VpgPj7hxgxSxntVl8HqDoLbUDHYZDIvwxUyW6z6
         1M6WQQsYViajEf/NayrzSSACOEMWDqSoDx5UuYVm5JEwQrc5xHIBNdHwlA9ceIoDieLa
         fbcV6QN3VL2jA/8bYp+FGrAeNtz7ujjTO/wvbQ1Kn5t7ROCEbSAbvp/MgnaSy81wmRh4
         jotEnw1UOJaMmketpKW4uM4nBbpD6QIeWErZ47YC3+msAgW3lp1CgmK1huM+dkDDfLAj
         Ufvn7GiSxw++BKBKtmcfYqwJtLfrNmbf2EZcOafLBNxi5vfgul0kHrxt+L7wxyWqNx3U
         CikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789477032; x=1790081832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L1JcDlshcJnjTO9t6bNJvx2l7c6AJb/4TmbKI6h+KKo=;
        b=14bBI50XpBD3JQ/uYisYFUTSpHerKsNpJgz1iA4OyduPUD7GXTOEmJYxh3pmUTsBJu
         GioacH+VwluJeNrH3Pzg8ppH6E2wVE707iSGzlTQ/wSJIf21xEF0Yckil5p3cL6fr/hE
         zQmrV5IeCPwoRngYLkUX82kZ9Svp2WUcplkS0s9lHM1iTiNoWEz1zpq3is0BnVOJ1zLs
         BsUFna6Eu8zqG9QAoz0qPUJYxD9X3/2RUiacOxZZvxTSP9aUdq86LhFvyyJkR2FOS5gU
         zP2Do749EQCRrQ2ExMfydEgc5C/oPYpDVXNVdtn48GE4a8fgz/NHEmyznzCuf1QwEXdr
         ch7w==
X-Forwarded-Encrypted: i=1; AKwUvByky5kueetXW8NEnwGoQy6mto960PPTI5/uMMRN++/RV49ZWGDLbVkbPANqwIeK8Xa61QRW2uw=@vger.kernel.org
X-Gm-Message-State: AFuF++ncjqG2Yvyib26HofWqw7aOeXB5kd2R+0jkn5BBrR+InGY319On
	tQA7OdNm3R9A3S00r8dSmDMrZAa1rVsxD0Mu+yWBu5anxkss0WxBI1lL
X-Gm-Gg: AYBFou2eXtf+qTtoqcjmisXx0VcAsGoICQTb07zeQGAD7qJ8huZwyYaOo1D8VjPTNJA
	g37fP1XCs3XHRCBEFn+sO0vLISD0Z+F1RjRdBgZC3GneMrBu5XbPUnFsOULRxrsjj9QZDVNVEQS
	yxSNyrEhE38U8byVZEGiPr4GSq7dwpK0CQ8uPEPszlhEp+rwFUEpsun5rqnL6Lgj7DD4P1EFVUQ
	lo13wp2TqWiSeXb0BjfGbiYsYvyv5JgjMfubgYFSIof1UHps7w7NPPrjjXqTuAIvaeCVgJcBy6B
	BinEui2aXMHGbpraimBu+MRU1rGP+5LPGVyqYoj3Yl1UQchyyH9DtgmG5uP0HzD/SVZLKrjyqNH
	uqY+htqfyfa37sdMQKH3bYb2yA3fN4hnaDVxlHrDi7dpnMWmOnx6Pwi/ba+N4hu8XJQaPpLJN6E
	7lnsNM9LvvwsA1Di35Sz9M8rDlfMwA2v7AOOrDY/9AVWdlcsgRFiy8y/egmloEVEfH
X-Received: by 2002:a05:6102:d89:b0:79a:62cf:2a50 with SMTP id ada2fe7eead31-79b58495f25mr7239387137.7.1789477032124;
        Tue, 15 Sep 2026 05:57:12 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7927cbdf149sm13113951137.4.2026.09.15.05.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:57:11 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] usb: gadget: f_printer: use the active RX list in soft reset
Date: Tue, 15 Sep 2026 09:56:57 -0300
Message-ID: <20260915125657.2849779-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

printer_soft_reset() tests rx_reqs_active in its second draining loop but
retrieves the next entry from rx_buffers. If rx_reqs_active is non-empty
after endpoint shutdown, this operates on the wrong list and never removes
the active entry, leading to list corruption and a non-terminating loop.

Retrieve the request from the list named by the loop condition.

Fixes: 25a010c8c1a5 ("USB: add Printer Gadget Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/usb/gadget/function/f_printer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 1857d78611..e3dc5d810a 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -940,8 +940,8 @@ static void printer_soft_reset(struct printer_dev *dev)
 	}
 
 	while (likely(!(list_empty(&dev->rx_reqs_active)))) {
-		req = container_of(dev->rx_buffers.next, struct usb_request,
-				list);
+		req = list_first_entry(&dev->rx_reqs_active,
+				       struct usb_request, list);
 		list_del_init(&req->list);
 		list_add(&req->list, &dev->rx_reqs);
 	}
-- 
2.43.0

