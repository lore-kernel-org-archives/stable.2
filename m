Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1930C4D486C
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731801; cv=none; b=HVmYk+uiJglAt9sG6FRjFXFQCBbt92lCfE/hC8Z4Y9/Tb/e/Gv06KK77A5yAfkfdcxKK3bdZWqRkqqOn3BwFEHsKVQRJvldt9wopuVCB4asd0nXbrOwM4vnkn3meQrZi4o+JViVG4IwjSbE8oe48Nz7X4z5pY8otGRPzAOT3AOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731801; c=relaxed/simple;
	bh=y/6rkcYR6tmvs24rDeEbZaj7hbvTLRhxny3OHHiTUYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcO+BK0StN5mmvIS+IHVgY0+PDdFq/fWEM5EkrVgYk8D+ClWgl8J6hDUzem0pVLDuhucX0kKTj6fol+G/5/aQaBZ2Ks3VnKyE2PV456VLPNqHru/dn4pegvJkvJZIA1wsfomlgoTTFuU1hLWLsOCP94Ei0ubLoz1wmdNUxxCY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DE5fEGBL; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DE5fEGBL"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fb334ddcso5202435ad.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731798; x=1790336598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8kyloGp73jNN9aWd5AokYOutez5h9JeIEBv6OC0m1qs=;
        b=DE5fEGBLC4/12wDJ044Q5vujnK3c68n+OoaHdPJ8T13Wd0wrSlKIGfVH3rOZeAmGT+
         mRcPm1ENYm8vdySPB9zW20hNFsnUvGFbmaa3BPfh+GSOhViki2iau9XSTUb0J6S/76uk
         7/Sc65Qp3d2pkJBohIoFsSF0OuQqZOYwC6QN4CjEfAQcdk8XEzeMS3y06Q8PrdOhs6aI
         qizWQcBbSS1c1fYFDB8EoxEVIHUpvizPl8z2ClpMKA4FDb7fJgWXH5W8zWNVtlX9DTIi
         gh/FIvWsaLxTpS0rvt2hhIsNVW95RlpCix59cPFHdbGL2vYc8WxjXnF+1jX5IhweXaC1
         XiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731798; x=1790336598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8kyloGp73jNN9aWd5AokYOutez5h9JeIEBv6OC0m1qs=;
        b=EwSrTxCGXsnvecLa8zFTFv1fpPhT5CKUlk5FITSSmH7tC36XFB+GhXXI398dnoHtIS
         Is1BXJuTZx8pw5lW+CTq1U4CoTNQ3xznvfDg/P6XKCHsvaywGwTG+OQ1NHYEoj0aOA0K
         d4Qh3IsA1WICLNLPTNEaKDvno1K3yBqH0+IW+MJlBqbFXnh0kLlQZYH6Lhx1B6QPYXBD
         dJslOMyxZ2nnoDXG7nbGzfhCC12x5GINrSJpMmTr/OYOmMIJHv7OQgE+jlCXPwmNon41
         ovLqg8vKIB5CQzfJ8708GT2le8nMlPuCuqe2D+2tzV9An6Rb0M60f5DJEs9+6vTvpEh/
         BTyA==
X-Forwarded-Encrypted: i=1; AKwUvBwuoJL5Ld/gLsIvWMIHb1R3Io0npKLzixyU3Ld43SsePIwiS/nGRO+AJE7rScHQkxP1meAV/Rk=@vger.kernel.org
X-Gm-Message-State: AFuF++lr/CPprl4CYDxTIFW7mgT2y0/oLRTOElY/OpB9GxtpX2SmOloW
	+OZJBmR8TPAFmL8knn3yXCYM1jiTc+3ErTfh2Dr2dGuuBZHc1clkGRDI
X-Gm-Gg: AYBFou0vO44vRrmOO1Ogb4fCYKYnrkdoOq2fhRgklSJEAqRXBPCQ/euXO4hQRxeAOsR
	7+ll8fxuIqYSN5gNt5hcpvp+Ui+1qawiPZ0Zz5+LR3iB4r2x9omr7+VEFwV8tB6mW7FyifahT2g
	MF3+YIkGtjJ4GhH5hBnP5844Qjy9vvIwiIa2KhWICgdsu257yYAI/ZFrVE7jDsKd/1jEOIRMmFp
	cr1k5WJSz1XhXxxrnk7BM/EBxYNRORRy2DTPef9jqH1o6lGYIpfObsr15xOIGzuxfE5MwNWSMWM
	TPHr5MxpGlgfwxrSWKApMgqwquGfjzSkvmFPqC43FXgrAshFA2C/AR7V4WGJd8W1J8/UGtafZhS
	xLBrKOkh4FwEYLo/bmgB4hHSyGxMd54xQVfq1VnKdN1OFmNEVBKfkmOA+pZo8f3rFQ9EHlpwEko
	24wCk+LbgvgFH967Bf1ATHLlA1NFHato1VYtILzWlLxT3mgYHTE9vKi3Ex7UrMNyY/Qrgr+VO7U
	OW83VhTRI0AA2pCf+u0wQ==
X-Received: by 2002:a17:902:ce07:b0:2da:f1b1:56c4 with SMTP id d9443c01a7336-2ddb1ab3254mr53010075ad.3.1789731798119;
        Fri, 18 Sep 2026 04:43:18 -0700 (PDT)
Received: from 73ebd4c7787b ([183.194.144.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c286d98e7sm4603983eec.9.2026.09.18.04.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:43:17 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Carey <carvsdriver@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH 1/1] USB: cdc-acm: skip URB restart in port_shutdown if disconnected
Date: Fri, 18 Sep 2026 19:43:09 +0800
Message-ID: <20260918114309.3659635-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918114309.3659635-1-ndaugoing@gmail.com>
References: <20260918114309.3659635-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acm_port_shutdown() is called from the tty-port machinery whenever the
last user closes the port.  acm_disconnect() sets acm->disconnected and
calls tty_port_tty_vhangup(), which eventually triggers port_shutdown().
At that point acm_disconnect() has already called acm_poison_urbs() and
is about to free the control and read URBs.

However, acm_port_shutdown() unconditionally calls acm_unpoison_urbs()
and, when the ALWAYS_POLL_CTRL quirk is set, immediately re-submits the
ctrlurb and all read URBs.  If the concurrent acm_disconnect() then
frees those URBs and their DMA buffers while they are in-flight, the
result is a use-after-free in acm_ctrl_irq() or acm_read_bulk_callback()
accessing the freed DMA memory.

Fix by checking acm->disconnected after draining the delayed anchor and
returning early: if we are in a disconnect path the URBs must remain
poisoned and must not be resubmitted.

The early return is placed after the delayed-anchor drain loop because
that loop only cancels write-side accounting (wb->use = false and
autopm counter) and does not touch the hardware path.

Fixes: f58752ebcb35 ("USB: cdc-acm: Add quirks for Yoga Book 9 14IAH10 INGENIC touchscreen")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
 drivers/usb/class/cdc-acm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 7bc5329fa3ed..a7ef89a8da84 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -788,6 +788,9 @@ static void acm_port_shutdown(struct tty_port *port)
 		usb_autopm_put_interface_async(acm->control);
 	}
 
+	if (acm->disconnected)
+		return;
+
 	acm_unpoison_urbs(acm);
 
 	if (acm->quirks & ALWAYS_POLL_CTRL) {
-- 
2.53.0

