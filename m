Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792812647;
	b=wq7mMSbPdLWbKEGCiuNcnp+K+BNAOPdwR6lpB1lfahQUrWyyfWtvHkZhiWRF8aH5UK1l
	 KucUug5DaikJOeydSTWvT887HIBYRbMc45aIMBaid6kS3mxSpfPyAra8itpZq7Oiuu2Pu
	 XC8jT1CoZytwaeah5d8U2EmNnFXVJdmdBrkI3rjPZxem3zm1PFCwYqIRLhFavJ8bM+zwn
	 pVrG/JIm0Zlve+hOYOD85uU07V/ey2hkVn7EMBh2fQ3UjOdVvZE2AMOI9Up6yFvoZQoph
	 NvqaW9qvy61YcNjqmLLgTWguFizeakG+9mA/9F2SEMX9rNGfyHFn2Fjawx/CwckCRTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OZMDdE1sz75D6sUxXlzqCF8BQygc6BjWQNC85XiMV0U=;
	b=2zjHzOZktipI0VbW7BCT7LDiQg4/U5B8Ci7zOZoesObDlFuYvNa5VY3l8HW6Xk2JlNGH
	 X6NwG3R19fFpsSDLmP19pG9IfebZBv/GRyHe4NVjB2VJ2Uq7phCbfugPmTGtL3Rj58Q6A
	 xoRbBMEQ/FC9l0jbIsoTzQocprtRj2liG6m2ThEGGEuc4kE2Xac79SmCSzRtvhpep0Cyk
	 qRdKJsnpeIOo2o/Oe1ugKMWivAPE13KvmcRNsB4SASlkglxoGBxiMrpk++r/Quka7++EL
	 kE21iJzJdw8uQZKQwLxwFpFMPGUkXtakYWMrgEbT2+RnZ8J72SZRil4rTzBdvTBGUdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Gtu0Vp/H";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FC606A321
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C14FC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gtu0Vp/H
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36661f953e4so2548696eec.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812646; x=1793417446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OZMDdE1sz75D6sUxXlzqCF8BQygc6BjWQNC85XiMV0U=;
        b=Gtu0Vp/H5EfWSIIaFdMd9y7DYtDlr38BhaEIteYiOBAlHVJ895c6jCEOTfnuMjRiDr
         gb9Bnui5eMkyisoYaH8xLFFDx1KWNMq9FMgEjUkXHXht+ZenwbpFIoJCDHT8zLEmVelp
         AJZ2lODAamK/P9ypcWuohJNCyhbwdRCIJnWBArEhgDYadnYESPOXuRxSMVIh3g21bIZN
         wzB9IqC9grdxl4hXkY/fM+Qjju5xqt55WHV5MBEl32CEyqNPY5FjVJGzCDAwfRj1NHcg
         buY0NPqeRxJLAeI858zPtQa9ceBlv4o2CUJmA6XhlcWWxOEvVxLy+UcIDBRwVixMS6hx
         gz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812646; x=1793417446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OZMDdE1sz75D6sUxXlzqCF8BQygc6BjWQNC85XiMV0U=;
        b=KwVNGa9ZwfNqHPFFItP0o2RMpG+hRPclfbF+1XKxIBuXkW/cSahxaLKeo8TQ/Y8DpW
         clFmzOu8ntW2E4F04rsB9CVWQaZSBDOESMOpgTmBPGy1KueVwHTVMpPwWK87z8g7YUo1
         T4ddLuQBHeRRQq8pmp/VVOJnQJ1N9HeqeBxpQtbWtAoPFHdnxxjaxYXQFKKC3TaG3xna
         WNqv6jcsWhJFVGw/1jLmTz5FXbN2hSZGNwYo6Sc/xk0r4nrdXELQV3gL1/GbrleBzrKA
         wngf/+cVuIFqql00z3vpq2dJ8iY9MIneTH/Tyd+ZcmkPUm1YA/wfYI1Y/eDMRhqlURJz
         Fh6A==
X-Forwarded-Encrypted: i=1; AKwUvBzLCSVWkL/9sifKsjdLD0sd4MSvQUSzi7QELWu9PypObvfEsO+zr88qV259msQgRazVxqmnKPs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI18agMIeOUnUxIfIDY/syc9NbNaBOpLpl3xnr2boHH/vXaOE59
	cHSTgL0vJ7AA+tKa9aIev6qcHOK2t3huC1LMZPUiB35YLw3pR0DptOEC
X-Gm-Gg: AYBFou1UGkUDY8jPse+BSWH18UHMjKJacxGcoUImIO4MzhiHTUi3mO8JtrOSDmc3EI4
	cL2ArJozDWl+GAjLFF3MDfDXe9qfZ8i1l+tlxGzUCLMxZoHtkCMiW2aCNzaZNQWNvgR5vPa0XQY
	z2fausj3ZwpLVWxdUK/991JXKmIXNWThbsqfVRfHlbyHD7kVJ21mC9WrqKOuCQVE6vTDV7mVcfk
	7l9RwoeJl284r86vVdn6WoleCcZ8cT1pNl8gQq81blq1vkJmPQNFE+DJSKpD9hRzKeWv9nQ5dFC
	i9HEvHvSiPwiF4mzG6HokFFUHIHut4apblI5eMRtXFL1KDETnsSrm/qo4uvPjCxvGb1DNU4revl
	kMRdSblikfE9SEIQBVRFAlO7AXyrBc/aXkuMbPYJ/uFbha3s0m19HGU8B5jRz9G268eZjtn8PWB
	jsJMBffwNQDSAjTVcizMjF1tJzCyRRsIRW0UarDBPgSYUrw2Rmn/w6WOIGc8d15gRa/mjNJOn8L
	MXROOXZRzE/RE7PEIMwmWmBVy3i6m3/59IFngkdEGtBpncectl3ljKsGOJL0XbFMXWhlupC+Ovz
	MCJLf8ph2TdzWzCunZi4fAutLR/8RGObVWqawiefVitzTBe42g==
X-Received: by 2002:a05:7300:8816:b0:369:e930:6bc4 with SMTP id 5a478bee46e88-369e9306c7emr1047457eec.30.1792812645741;
        Fri, 23 Oct 2026 20:30:45 -0700 (PDT)
Received: from jmoon.tail8e743c.ts.net ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ecf087sm2827283eec.27.2026.10.23.20.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:30:44 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v4 0/6] HID: wacom: guard against NULL input devices on successful probe
Date: Sat, 24 Oct 2026 12:30:34 +0900
Message-ID: <20261024033040.316652-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
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

When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
the corresponding input pointer is set to NULL but probe still succeeds.
Subsequent irq handlers dereference those pointers unconditionally,
causing NULL-pointer dereferences reachable from a spoofed HID device.

This series adds per-function NULL guards across all affected handlers.

Changes in v4:
  - wacom_intuos_pad() now returns 2 for the normal path, 1 for the
    NULL-guard path; wacom_intuos_irq() applies "result - 1" uniformly,
    suppressing the spurious input_sync() the old "return 1" would
    trigger (Jason).
  - Added pen_input NULL guard at the top of wacom_intuos_irq() to
    protect its helpers wacom_intuos_inout() and
    wacom_intuos_general() (Jason).
  - Added pen_input NULL guard to wacom_bpt_pen() (Jason).

Changes in v3:
  - Fixed wacom_dtus_irq(): DTUSX is pen-only, so do not require
    pad_input for it (sashiko-bot).
  - Added patch 6: touch_input guards for wacom_intuos_pro2_bt_touch(),
    wacom_24hdt_irq(), and wacom_bamboo_pad_touch_event().

Changes in v2:
  - Restructured per Jason's review: per-function checks for dtus_irq,
    graphire_irq, and the Bamboo handlers.
  - wacom_intuos_pad() returns non-zero when pad_input is NULL so the
    report does not fall through to wacom_intuos_inout() (sashiko-bot).
  - wacom_intuos_bt_irq() guards both pen_input and pad_input (Jason).
  - Added dev_warn_once at every guard (Jason).
  - Dropped the cp2112 patch (Benjamin prefers Dmitry's series).

Jinmo Yang (6):
  HID: wacom: check the input device in the shared report helpers
  HID: wacom: check the input devices in the legacy irq handlers
  HID: wacom: add NULL input guards to wacom_intuos_irq() and its
    helpers
  HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
  HID: wacom: add NULL input guards to Bamboo handlers
  HID: wacom: add NULL touch_input guards to remaining touch handlers

 drivers/hid/wacom_wac.c | 127 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 5 deletions(-)

--
2.53.0

