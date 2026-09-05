Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A74CB8D0
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788626713; cv=none; b=s3jNwSNFelY1CXqavFh5kjf9Fl7S30aXtZJfYHxMeqzsFPbtJdKWmW2gE4kPSaNE+I+01i9IszstFthwmUru/CYy/pcWUhhtvGHH7VapZ4pITkskSX/EGNOfVDdNFBeP0QS1aP85zMBBPPLN9XwomEkXsDs2ENF4ojuYyRm655s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788626713; c=relaxed/simple;
	bh=zXRC/RdlmsiuexVeqwFjarsu6yZ7PSNCPNwsKWzg6EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJoHmX9lU/MerPdhxmNbZRNnsRh0u7AZLs8nNUiFdbEo/49UgmGIPgczL17/qg0ATy/+lzmRtRm7hyn0V8kRWfmOVlPzkkHMAoPqO/iDHatrStL+jpZjUY7BMruijvnYRU/Ako8AyYv7EIQ1Nfd1zsS+yDjefEA9qauiR0lsaDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV7CslGA; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV7CslGA"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9103f5b813aso14728376d6.3
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788626706; x=1789231506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iebef4UkUnASKv8XcTx3vwRMvhVbFEWfZRLdXca6h64=;
        b=VV7CslGAVnHj0gm8JK0n6CeO5ODOlecicnnkvks3hTB+JxVBe1fVZlpQaFnY6YnL5b
         rBO0J4TR+BI8nfs9yAGodxNqmzezpUyKXHfFLDUyxLy6H5j2kFuBTa3vZDi9VQTLYTUm
         dFbv/itBx/dpP6fWRtZ7GJM5yA7wKDAFqXHVz7UQOffB7X8VXv0QZD6bb0PS3jE4IPsi
         2+pjaDDjAP8aX9jLBAMGSnp8qAtvnbRsK0xwpXvKs7RpXcwmp7n2uik0L1Vmk22kNjCI
         ZV+PHKzxFxW8bmLE20cPmR1v3qdJbNj8Cx+xoCjJKnS4gF9XZKIetdjUOvnfy8a/vuHx
         82MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788626706; x=1789231506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iebef4UkUnASKv8XcTx3vwRMvhVbFEWfZRLdXca6h64=;
        b=tTl4L2hY2Nep6Ek1kA0d0R5BnoGKjvtET+wtZrjWYXJ4+5Ms4E+3rLOgKKlIz4aStP
         J9L98eiwjxS9QMn0W76JT54z5qJLGyC/npTGMAzUnimrzU4wwTyK+3seyIWm0DHXq7G9
         P4lzxiR9KS8xpSWeHHhjT/eQTLx1esC/my5fS24zNomqz3xdV8lFSv7qbDfCgMtl2ZsM
         QTW/wjL1hqzbJTdUYa1MARF8w/xhnJTEmKtQ7eHDj2gcCFWZK/jAnKfp+iFWOjRFWy4/
         QGcwbk/Rh6xkZPrXoVMj5pkTnDQDubOzxa2d/dyuFZHBmgHZmrG4SXLKayXMWXchvcfs
         FOpg==
X-Forwarded-Encrypted: i=1; AKwUvBzswhdyq7E5StOEs2cU1+3u3pQLnfGIDTQ5AM6L+uifGBYK5hiaGiIGGRDDJ4CwGsJS0UAnrjQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mKk5QfwaGrPr9cAsM2rnn9D+3jRf3Gkyq4MgBmIey5+wKs93vB
	X2sjqd63PXRglzn3MApPFlkuYY5z7hJjqAqLnHcitwBddQwXza83H8Xn3j7eRneEXr4=
X-Gm-Gg: AYBFou0tWFaYUwdDHKXXMLdkh6azL7IQ/vAGXp/MOsrudhbLoe0DhJxiNnAz/f6uw3j
	V6B+jgM2YNR1OZpyDfLVEZPk5konpezxy+Pgd+0x2LeH1muid2h9lL9QRanRXk4eGfhYIeQzedi
	FzM4wPBMNCCswQhHWZEpHah5uWoNsuJVvGwLDTJ1gc1YUIdOwDORkbiRj5LxDJtNs8hjQUVKBeA
	HiG2T5DsjHUcnBUotxmLEff35Nog1svnEHZi8z6Lz6zdPwvwOUXGV2P91W6MO9O66/eTrmOKbHF
	WeOgXranJQ6Ml7b2I1ZbcObC+PrOaURcrRoAPH598xjXFqqLeKatLlNjgGuVibRqxatQo5LteHg
	s8Aqm3Swb5yduI2HJJz6TVQSqjHzs88azkZD3uBQxciU33ye3wHeykBdktdsV0XoWScrigULLSv
	c2N8eRW2/ejzmwZZF/Dmr8Fw+w1Oz2QF2OGoMwfO5rnQFO9ZFW8N8apUdGH5salCFHNjGa7dvbY
	c3qD7aoau0ThcngCYA3++hnEz6RWcudp1HnmQ==
X-Received: by 2002:a05:6214:4904:b0:8ef:91c5:8edb with SMTP id 6a1803df08f44-9103ef23c37mr177612896d6.10.1788626706129;
        Sat, 05 Sep 2026 09:45:06 -0700 (PDT)
Received: from dave-desktop.lan (modemcable053.177-58-74.mc.videotron.ca. [74.58.177.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9104067ac52sm48984326d6.27.2026.09.05.09.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 09:45:05 -0700 (PDT)
From: David Collin <davidcollin899@gmail.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Collin <davidcollin899@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] usb: dwc3: host: fix dangling xhci pointer on init failure
Date: Sat,  5 Sep 2026 12:44:47 -0400
Message-ID: <20260905164448.209348-1-davidcollin899@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aptV-QHKGbMqw1uP@vbox>
References: <aptV-QHKGbMqw1uP@vbox>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dwc3_host_init()'s error path frees xhci via platform_device_put()
but never clears dwc->xhci, leaving a dangling pointer that
dwc3_host_exit() dereferences unconditionally on removal/shutdown.
Clear dwc->xhci on the error path and return early from
dwc3_host_exit() if NULL.

Fixes: d07e8819a03d ("usb: dwc3: add xHCI Host support")
Cc: stable@vger.kernel.org
Signed-off-by: David Collin <davidcollin899@gmail.com>
---
 drivers/usb/dwc3/host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index c5674161b2b0..74117cbb2f42 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -219,12 +219,16 @@ int dwc3_host_init(struct dwc3 *dwc)
 	return 0;
 err:
 	platform_device_put(xhci);
+	dwc->xhci = NULL;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dwc3_host_init);
 
 void dwc3_host_exit(struct dwc3 *dwc)
 {
+	if (!dwc->xhci)
+		return;
+
 	if (dwc->sys_wakeup)
 		device_init_wakeup(&dwc->xhci->dev, false);
 
-- 
2.55.0

