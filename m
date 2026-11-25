Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598437;
	b=kn+j+0y8NROYtDjf+zIJByJxeAa/aEAQt8VGw3Dzv/T2HObZy59GawXktClwh3ny0eqm
	 JidIsaJfyIsRpwhaeH3n7ZLjAN5cnqFnOu+5vtoMntEBlna5ouF7QAHgL0Rox9JFklCd1
	 5+wI/qrpvXd3yLwzoeoU3opmZXlp/7JfvAKInirlWc/8ULokUSIPlpvmm2sh4oZelhRaw
	 YPNjUnCcUDhFYMABhhmyAr1tgacVO/mTRIRUjDfRF4DuUZHD3zLZ93GaD8C6Op5ZP5SMB
	 GH31GQq/PK/COVAm43iyAh37MLJ5ELG8JmXjE25WAGfIK9H5Wy5XxtfXFhnVLlTSiHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598437;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A0RgOElBwJJDomLUhRT0GMZ4m0uB6a3WEPZ47yWgujo=;
	b=cREnQUwpGAg7WB7rNuLxu+uwPZMhdxOzH0Bkxvz/06TpUyrQXC+TgSk3Y6uIX4CTjDdk
	 VkmW5eXM9y9NpxYp0hvOLGQzZnlRYpqPXiR1hovNaG7INIX6OOpm2HDlPZIyg9+ZvV/GO
	 3T981kpOztR7vlWdqXwskbPx0k6NIbaxQmXYid5KEputvmgYJMetyfyJKKh8/DghKGQ9C
	 T2g6MoXqY4DoYKWjWR4r4PT6KIc3LAufrS7AASrSgylt2u8RLLOcSNG5+qqEC0kQ7i+qR
	 5j3+uwfAUT2jk64yamc6Hy0t4KUA+tRhvtxGn+heUjpbT9fQ/Hvrlbvv+qklLkzSs0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=TfT+Z0xJ;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C78606A68D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7C78606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=TfT+Z0xJ
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EE8993FE35
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1795598430;
	bh=A0RgOElBwJJDomLUhRT0GMZ4m0uB6a3WEPZ47yWgujo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=TfT+Z0xJhaUU17MQcs7AW7nwl1KcarFPvugCIyR+g1LUeB/+u90K8LAAsFOyJGNQI
	 qnTkOExerRIEDJVuH1sd9Avq80j+u/sFMmxcywtsGujiFR4B56n5URBYZ2qFnxZphe
	 XDNoRs4E69yhUuZaE04cPRUG3CIwLzZzk3i+Xc5zIuPGMiTOvVrX7M3d3VTMNWaBwH
	 uLH/LGlYYuUiX2oudE9cfrnnQQbk/s3Z/Jo6KMUfsqADUp6K+DaBlpJLUco4WlfGHA
	 FQAcjgz7jkSfQUVScd/z0JsmZAN1HHvWi5/xbniq62dH3mzKt0m2m8a5fgNQxE+cA8
	 NO2/WOXxwGSyLvdDMlVvIEDYjmqs0GvSMRWakFM8Lbl6u7uOeoLcIBtowOeUMovDuX
	 2t2OgZ5PPg+ZrglfCER86itEoa0YwAh2TEKvKfX7okaox9eEVXRWm1Bq6Paecd9T+q
	 iCReMZcd5FPjcDRTMq3cux7IDV9z75y55ulysD6Gg54cC7Cwm9E79MDUSk4ixYZa5G
	 HchqZl0l0hUj8qJ+EyxU05PGuW7GST5FZ/X5PLk5NWhTUQMAOAwE5RTmuI1k0QevmT
	 u68XwkEJVESBId+swKSNogh58pAuQCevrAOlqj8scjrQ/omvh8gqfcu0TeT/177TZb
	 sQ6+5WV8FpY/BO+bFHIkbhAs=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2f0381f07a0so57781955ad.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795598429; x=1796203229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A0RgOElBwJJDomLUhRT0GMZ4m0uB6a3WEPZ47yWgujo=;
        b=CpzPEApkra6M76jxXatxdxHLewue4gs0CW6APhOAiMFGq94R0rkNKIoMBcCUXASH50
         wsxPZT/jqpDCFzvbhSLq0PvgXP9LtR5HkwQQUcgjMDv2OmGQ/mziMmsY+DU8+Y0+scEI
         u5BV1/VTnevLf6vxnkNiNkE9i31xA1z5qFdypOgp1aH4/5z74EEHTuyOQi5ktWTQlV+T
         gtRavY+owQmhFsIlOh2DZljjrr3sQb4wFt+0bhErgAj78tMDglDNOSzAxFKNKIxa6/mb
         F8j432NojD4McsEJf7VbVUlsSewPiYvaF5KWZYq2MgcgVZ1BpCqm1SvWi3duYE1DbPwX
         DCoQ==
X-Forwarded-Encrypted: i=1; AL+hErGn8drIiniOlBvXJwCFPhxoOdUS/igGghoIQHWgv3I9jsazCr5xb51bMCj9E34fSM2tCoFRZ/A=@vger.kernel.org
X-Gm-Message-State: APuU4Z93g5e5+PRYgPH4jFvAUjQbAztiYHWRO4MNm2jP9mWu+1vFm7Ac
	zpFOOILOs/2N1dneMEYvcCBUiQHX7xyXhqGb28sKrFr6+BZ0Zc/3oNvZMb4GrwXGAxLmftn5Yyl
	54sKIOEuOqUdi3LvEmqTiI732wk10KhOnG9nUAgbWWxCn9xGzWTFb2fjh8du7fVSw9Lf7N8/pGg
	==
X-Gm-Gg: AZFdTZceV27JzoEj2KLKSeIgjGMP0w/AyORCIEplCh3WdniCTGvBC3407sjBDvdM//0
	ulWJXvuxQcwo4vbwGpPMW1IjXHc1D/swl+egGsdSJAR7nS4rw2mbL8ubn3OKxYu14txBgKjmdDd
	IY0BE/yHlDnwZJn/X90BUmQkGmvm3JUCgBrWwp41WCyBCoAsjD7DCGK7s/O/F04BXiTNxBFZfby
	gS1l4i/6LX84B5iynmtESYarNCjL0PmmY8HbZZhgxG/ERkf4+x1eWKQZ9CkWoSRqAhuIm3tu853
	1OJ6AkMD3Mn+4WtqwmGMLH67DNUKoG25TRlT40fQNbgiMiVNWFu6SLMomgtVu4UD/o84KY2fZ23
	GhUSlC4JRePjo/ZdfluMzh7R0/abMIhtD/3OHwSUppO7fje6EvvB2nnqKyHngQRaDya6P50P6v5
	jq9FfApeAm7SBP2lh7ilit4LwwOhSxow==
X-Received: by 2002:a17:902:fda5:b0:2ed:fb0:bfd6 with SMTP id d9443c01a7336-2f031e08699mr142488165ad.11.1795598429367;
        Wed, 25 Nov 2026 01:20:29 -0800 (PST)
X-Received: by 2002:a17:902:fda5:b0:2ed:fb0:bfd6 with SMTP id d9443c01a7336-2f031e08699mr142488065ad.11.1795598428998;
        Wed, 25 Nov 2026 01:20:28 -0800 (PST)
Received: from resolute-linux.lxd (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f099a4d875sm42673685ad.37.2026.11.25.01.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:20:28 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neill Kapron <nkapron@google.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	linux-usb@vger.kernel.org,
	Aristo Chen <aristo.chen@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] usb: gadget: max3420_udc: fix out of bounds endpoint index from wIndex
Date: Wed, 25 Nov 2026 09:05:29 +0000
Message-ID: <20261125092004.15562-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125092004.15562-1-aristo.chen@canonical.com>
References: <20261125092004.15562-1-aristo.chen@canonical.com>
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

The MAX3420 has four endpoints, and udc->ep[] has MAX3420_MAX_EPS (4)
entries. GET_STATUS for an endpoint, and SET_FEATURE and CLEAR_FEATURE
of ENDPOINT_HALT, take the endpoint number from wIndex, which the host
controls. The driver only masks it with USB_ENDPOINT_NUMBER_MASK, so
the number can be 0 to 15. Endpoint numbers 4 to 15 index past the end
of the array.

GET_STATUS uses the indexed entry to check the endpoint direction. If
that check passes, it reports the halt state from that entry.
SET_FEATURE and CLEAR_FEATURE use the same unchecked index to update
the halt state: they change ep->todo and call spi_max3420_stall(),
which reads and writes more fields.

Stall such requests. Both functions already have a stall path for
requests that they cannot answer.

The driver has been in mainline since v5.7. Commit 0ea39e030a80 ("usb:
gadget: udc: Handle gadget_connect failure during bind operation"),
first in v6.7, makes the gadget driver bind fail on this UDC, because
the driver has no pullup callback. The next patch fixes the bind, so
this patch has to go first. Mainline v5.7 to v6.6 have the driver but
not that commit.

I do not have the hardware. I tested with a KUnit test under User Mode
Linux that emulates a MAX3420 on a fake SPI controller, with KASAN and
UBSAN. Without the bind fix, a SETUP packet sent to the emulated chip
after the failed bind got no answer. With only the bind fix applied,
UBSAN reports an array-index-out-of-bounds in both functions and KASAN
reports a slab-out-of-bounds read in the driver thread. With this patch
as well, the test gets a stall for endpoint numbers 4, 5 and 15 in all
three requests, and there is no KASAN or UBSAN report. Halting and
unhalting endpoint 1 still works.

The bug was found by an AI code review. This patch and the test were
written with an AI coding assistant.

Fixes: 48ba02b2e2b1 ("usb: gadget: add udc driver for max3420")
Cc: stable@vger.kernel.org
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 drivers/usb/gadget/udc/max3420_udc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index 6dbea43022a7..d3a4c824a732 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -536,6 +536,7 @@ static void max3420_getstatus(struct max3420_udc *udc)
 {
 	struct max3420_ep *ep;
 	u16 status = 0;
+	int id;
 
 	switch (udc->setup.bRequestType & USB_RECIP_MASK) {
 	case USB_RECIP_DEVICE:
@@ -548,7 +549,10 @@ static void max3420_getstatus(struct max3420_udc *udc)
 			goto stall;
 		break;
 	case USB_RECIP_ENDPOINT:
-		ep = &udc->ep[udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK];
+		id = udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
+		if (id >= MAX3420_MAX_EPS)
+			goto stall;
+		ep = &udc->ep[id];
 		if (udc->setup.wIndex & USB_DIR_IN) {
 			if (!ep->ep_usb.caps.dir_in)
 				goto stall;
@@ -596,6 +600,8 @@ static void max3420_set_clear_feature(struct max3420_udc *udc)
 			break;
 
 		id = udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
+		if (id >= MAX3420_MAX_EPS)
+			break;
 		ep = &udc->ep[id];
 
 		spin_lock_irqsave(&ep->lock, flags);
-- 
2.53.0

