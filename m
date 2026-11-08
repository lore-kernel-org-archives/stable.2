Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145220;
	b=2YiptTqH9IX/vqnbEEhQximHSd41LhEgorBour5gwhTD5VTUO+nTJnAOH5dK8pRLfReM
	 CjEyqKiFtq4WCmCazg/beET72Ez/HedAHIHn9k9HQTbEP/WB7Km7xBbKRU7VegBc6r947
	 wErzJpUp+lNcfLvKcD/C6hq//JRAltliK1raqwfCeflWLu5je1AadO7OwbFlIwgMO3NNj
	 oKvjtQus5KN5Lc09erAbpwyTN19KQWCcNFD3nJWzoviwzaW6vOQ7crd4xtM2x8hA8CQ0K
	 kG80Hx4XnGeUIudmlEI+5MnzF3JBnpLK+cGy96/rqXFAndUaIfYgZ6sb9jgzKnarhNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HCa8+1l9l1LJd5eY9Gi4hJK+TGF8pYWhbphz19Tl5cE=;
	b=GAn13/zfhkureUEoctdDbaeq7weIPOV9o9X080R9S3Md2wVW38mo5Rfs82jdBbZlf0yZ
	 Od59QdWbpRe1bDR8X/06+GXLkkp5YDLiGJts6xHdzRBg8g3mDE68iAomKjb0vZeiV4cZ1
	 pBfzrodjTaWyr70+TAEsiZ0CgfUjmiLTZT7VmnhsgyMS0ETuzKt4bL9PPc4ACopTUdwhH
	 vNq/LE1cIaIqDFw7gYFHnjNl9yh3wPd6pvqQfZfX9JdEUndqV4rBf2GmTk9CejUbrS7zC
	 Z5rG3dfnBp7gGEJ4tRlV5dBzpl6ErEzGUVnxDwV+mGmorayaE93uK8xTo0oedppl6QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e16XaiZe;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96420606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 13:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96420606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e16XaiZe
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1ae18eb9b69so80782c88.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 05:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794145219; x=1794750019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HCa8+1l9l1LJd5eY9Gi4hJK+TGF8pYWhbphz19Tl5cE=;
        b=e16XaiZeLjFiJzZ4yWhuC5nleaQjirotE1wjpBOurW+JbGOwqzoNfQSfBcGaaRSdJr
         WEFfUvrpC7ZMcYDJlIQZ3V819iVTpYG+QyvktBF+D5mgtRhwv6VQAaup4bo50gRa00dw
         fNeO8B5WXtACt42ECLy/r1lGXAR0Ixn2GUhc94tNH+do7lCgT+1BtTg+H8S4dHFwIt/9
         4/iZ+H7GS4XFWrzdltdv0gpg/6k3TYxjdeC7t3QKmKTSs/ELPBoL6o1scxNQavayR/aO
         HDRkiJbuaL1gQoVtIAIpRGbu02dfCNX/UEnLKd+AD69KYYmRIMT+gqqXu21/XyGKSwj5
         psaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794145219; x=1794750019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HCa8+1l9l1LJd5eY9Gi4hJK+TGF8pYWhbphz19Tl5cE=;
        b=oE33W6yLppxYr0HoFZ5ymATb9Qcc48CISsGsccrPeOS4/VW87VOQjopZzNDuMBoyIA
         pVlXK0/BnRVLgp0K2B1qZvyoee377hDN+JM/7HvHoGC3dlj2jX+OlTB/2XiYrZfX9ahT
         TArdUHnxl/k2AycGzWYFCKIEmH3K0gRwmadcdhYfvRrKyAbzwoIUmy/5crmFDKokH9T7
         SiVYfzZbyO7Sxu+9ian0cOATzFuqeiBAPkkWRcIcqI76XsUG1MHtIdwqtGQUJejlFJa9
         5g1Lf6ECfHJgceg/FXc2iWGmPloHP2yvJNluiA4jr97pYArxOe4O0zq2gIhU0TPzZs3P
         578g==
X-Forwarded-Encrypted: i=1; AL+hErGG8excil5zEBFbYG5Hx4KNdkXg97/GtNiCCMLa3SEiU3+c6SSY1BvJLHtDRWb7A4C+d7xVNZw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wyBilq+o/1QNtJAzZtIJhkK5yviyYOqp5U/fQghV+Debo9KHb
	oMY1WOfWNFLy3C5TZugt7zNm4uUiC4y/8zV5cF/ZpgnpPZPyomkEj1tQ
X-Gm-Gg: AYBFou04ZFwcSCgiGq2aPmG9VQdluTucP7z51lPduIKnU/S3uNCqWf+6xdMOIJpF4mG
	418Zb+4ZweuddC1qf8/cCqfbXuswwLwsATd6AMxwEYNT/WWZbVYi6QratlpNWAlYCk8vc5WXpyJ
	B/kqClU8Xr8yKM0X28eW/ikfYMsKc21zzim+2xGMLrMOoibGTPiMK+TS/UMVSqGKjcB8iUqw255
	A05db7Ndw5PFZgef6drC34QQjwTQ/+DUqnEA2iH/zXN8u3W88++Jt7spP0asMqGgMdKen3j2eYd
	5YMDZvopzswOlV7G9kQzL5U+kKol4gBoBmDYQzS3MGEYymbbtoznVai3VuBLhqJGGcoQHtJFfuV
	7NWDO0+frxumyf2xPaPqyoFKRvEpHY6jpI3YnFOfKHJnjVj5tskrfOZAfT7/ZExnm33STkszwrR
	08CcxZ0TWu8lHxbQ7wJ20O1/hBR48LyKIp+rX7m15vCgI8ONaAgOXuRESsMyqKp8s8LRewAtiwy
	SjEfQseNOtLhqGkhuT+DHe+3TdibHc2550g3fbyEzQScGOJ8pCfZbVkW8KtIdG47tR3UYp7kQdk
	2oROKvrYFasikYDEAegQqn7i/dpEmh8SJrYXFjOMbXMm97z5
X-Received: by 2002:a05:7022:ea86:b0:160:6a5b:7edf with SMTP id a92af1059eb24-1b39ff1124cmr2107985c88.44.1794145218579;
        Sun, 08 Nov 2026 05:40:18 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3757214cbsm5435920c88.13.2026.11.08.05.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:40:16 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] usb: phy: cancel charger work in usb_remove_phy() to avoid use-after-free
Date: Sun,  8 Nov 2026 22:40:01 +0900
Message-ID: <20261108134001.536207-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

usb_charger_init() (from usb_add_phy()/usb_add_phy_dev()) initializes
usb_phy->chg_work, which is scheduled from the exported
usb_phy_set_charger_current(), usb_phy_set_charger_state() and the
charger-type detection on VBUS/charger events. Its handler
(usb_phy_notify_charger_work) dereferences the usb_phy (notifier chain,
dev, chg_state). usb_remove_phy() only removes the PHY from the lookup
list and never cancels chg_work, so a work scheduled just before a
provider unbinds can still run after the provider has freed the usb_phy
-- a use-after-free.

Cancel chg_work in usb_remove_phy(), after the PHY is off the list (so no
new work can be queued) and before the caller frees the usb_phy. It is
done outside phy_lock since cancel_work_sync() may sleep.

Fixes: a9081a008f84 ("usb: phy: Add USB charger support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/usb/phy/phy.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 5a9b935..caae749 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -731,6 +731,15 @@ void usb_remove_phy(struct usb_phy *x)
 	if (x)
 		list_del(&x->head);
 	spin_unlock_irqrestore(&phy_lock, flags);
+
+	/*
+	 * The charger-notify work, scheduled from usb_phy_set_charger_*()
+	 * and the charger-type detection, dereferences the usb_phy. The PHY
+	 * is now off the lookup list, so no new work can be queued; drain any
+	 * work still pending before the caller frees the usb_phy.
+	 */
+	if (x)
+		cancel_work_sync(&x->chg_work);
 }
 EXPORT_SYMBOL_GPL(usb_remove_phy);
 
-- 
2.43.0

