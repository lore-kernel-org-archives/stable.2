Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870839;
	b=bslNRpCbdcGSGZvEzsvDJqpdxtHrLvhRkiBqYaRZpkkW2FoRDGBAF30AAQblBEwi5+5S
	 pUIJSpE4IrpsVplRTLc48ljm8R+/pPq9K3ysUjhN3GiU6uECZ+CeOIcD73FizvR2izWBE
	 hc0LcnrFkGKyoCF+V8xq9nprdiIhHP+YswTmcYFzeQI3rju82dM8gV6b+7B5j+nKbqrtC
	 r6M3QyrteP4GQDvodw7Pu43o/s6ETm8o2v8RjCepu4syDdDkZ266Qi4SzA3tXvnUXapeb
	 S86qTSufdyq0+rEqDNrBE2Nm41pqpy5+0cDJul1etKu4o9hbPUfQWvasPfWPxu1BQsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870839;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HtaFQhW6t4dhRpUkmGtJXgAedTYd8o7/yOUNl5897Yo=;
	b=dpWsWBWgxIkhAgQ8gNP5TN0qOlG4kil0rzuKKVKFf4p1hzBafUnfp7BUB/BhM3oDA6VF
	 D/XRDzZ+BcXeo+C5tmG9F/pOAgtq6k7GB1LJvVtqq1zX2g7hWmTvRkhA4IDWYKJgjABtV
	 poB4egtBsfKQY+6G2BGS52t4OcnfKGqlNZocVKDJh9GUQRrNrtEc0zBuExZQbaHYqixrw
	 joUtHUzXiLXa4oIS+g6lNf0K7XOlXIcX1d/7pzm+gL1VtBnZZG75OkY8yaC3KoL4mp8hI
	 PaRyKkna4hmBji+LsNP7HsBez4jh/f/m/1NS+PzKe/3hlofpAvkXzSIgvpAxNmLlkAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=Pe3hbS+g;
	arc=none smtp.remote-ip=115.124.28.52
Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43277606A32C;
	Thu,  5 Nov 2026 09:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43277606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=Pe3hbS+g
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793870834; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HtaFQhW6t4dhRpUkmGtJXgAedTYd8o7/yOUNl5897Yo=;
	b=Pe3hbS+gpBYeKH3gQqmL6MYF8Wn8TDGx8GZIPS0KPPbfmvX3mYETeFTl6jsTgfoRVkx7nFAaLW/PdpjxwAdksOLD6UJa7nLd2kiyEfSirCtzXxn6wjReRMjk41n4MAjPL6Oe7crfPDY3EYcGAIFVazW5OIHTTSPoMAzOqILvxK4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07304177|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0275975-0.0014351-0.970967;FP=10079317485901471634|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023087102;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jxMLlie_1793870833;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jxMLlie_1793870833 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 17:27:14 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: nkapron@google.com,
	linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhugl3@xiaopeng.com,
	Weibin Liu <liuwb@xiaopeng.com>
Subject: [PATCH] usb: gadget: f_printer: clamp GET_DEVICE_ID pnp_string to ep0 buffer
Date: Thu,  5 Nov 2026 17:27:12 +0800
Message-ID: <20261105092712.27838-1-fangxy@xiaopeng.com>
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

The GET_DEVICE_ID request handler in printer_func_setup() copies
the configfs-provided pnp_string into the EP0 request buffer.

The pnp_string length is bounded by the configfs page size, but
is not limited by the size of the EP0 buffer. Since the first
two bytes of the buffer are used for the length field, a
pnp_string longer than USB_COMP_EP0_BUFSIZ - 2 causes memcpy()
to write beyond the end of the EP0 buffer.

Limit the copied string length to USB_COMP_EP0_BUFSIZ - 2,
ensuring that both the length field and the string fit within
the EP0 buffer.

Fixes: 24b7ba2f88e0 ("usb: gadget: function: fix dangling pnp_string in f_printer.c")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/usb/gadget/function/f_printer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index d295ade8f..17ccce78d 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1022,7 +1022,8 @@ static int printer_func_setup(struct usb_function *f,
 				value = 0;
 				break;
 			}
-			value = strlen(*dev->pnp_string);
+			value = min_t(int, strlen(*dev->pnp_string),
+				      USB_COMP_EP0_BUFSIZ - 2);
 			buf[0] = (value >> 8) & 0xFF;
 			buf[1] = value & 0xFF;
 			memcpy(buf + 2, *dev->pnp_string, value);
--
2.50.1

