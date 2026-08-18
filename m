Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD030336884
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087026; cv=none; b=VKuvsLW01HtmVwZAn8QgjcKTILUX6NlVb+UE3gEE4L8HcJ8xtS5NmIoKNlzGSNgYTSe3C3zE96UY0o93AqF+El5kFUvQKxNcz0fpmPeHb7Dl4p4UWgaaQAtGdDfJqlmiAvA2udeDfjIsAqaDEfWdqECeqbAs+u6Gh+j/DdRDnRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087026; c=relaxed/simple;
	bh=Ciga8fyK2UWC2s/b5cGw55pFzypHL9tfi1jBgKUzLFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jh3LSHfDuICf0oYQYMb1JIF7fJLRDrEvF8b5TOnUkooXFGxDvEE2tKYlgWPBi/s2B4Ww/QSRUG2wn+P3hUMUnSXUytJBfFE/yn36pSbJCyNpPcb2+8SWL44d2VF7ObBx3BRCRlMpAn+wJHMkVebw8IKNA7PtjivCM+vAscv0N7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+4VXr4l; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+4VXr4l"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so38245466b.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 14:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787087023; x=1787691823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Su7JG/xj7C0P3Xla66ic7tZrV6Rekk1QPQ97x1ZodVQ=;
        b=G+4VXr4laiwUjYBDJc1iSH3kniDzehfdw8uOAascpIjCWHa/5Q3DLrc4CljbiLLp/1
         AOS0wo4PWI756fIIMyECsXi4op87rwUevyawJ/XMIRNaC8ySurmze16B50WizNunSDsI
         +4Tc0A1nkRu69OAJZLqn+yikDxJqegqSr4Lbw4lo6zo3MZYTMtWMvoCM+orkMHRq8j1z
         vj1DxnMvFRLfOHmzcm1m2B+pTEcrvBS3nQCnLQ0zPwWshfp7DRemSKNBD71e9zB/M656
         7wvOrLETx5dmQR2pmDUTLVp3e8iPmEVTP7ARwbPzoiabZlvaPAmM8jmGkA46CkmWyfzX
         TRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787087023; x=1787691823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Su7JG/xj7C0P3Xla66ic7tZrV6Rekk1QPQ97x1ZodVQ=;
        b=ASTAEM8v+Np+2mXmkeXHnILNLcI6eUJK61p1/biqWguT/l8VW8bBDe+bVddROuojiE
         rXzl8auMbGKRJYQfE9OeUj0H4ZFRy7y6A+IvWWvNLCpIDOG7vfG+HGlzXBbEHr+Qmh3U
         lLojxm2KS5rxV76z3okzB6XzDJ+/c3fBwOj5ERF4l0oOWXpRyu3kpvyG8y8XJF5M0R1a
         E2p9/nmxtWal5yyCTZi7wZQ1Cei1484SI3Jsx+ysp7hXXRgqJm/+5NyNMDLSVxiS2Ivy
         00/Dxx8vr6Ht6MFBNiaWf/jYVJNkoIefaULz6HlcSBtr64UmgNopZlFcFHhTES63Zzzo
         GjfQ==
X-Forwarded-Encrypted: i=1; AHgh+RryM5iqr7aoJI8UKJKlszr0Xs1WH+BpmKjTRsgdirVGwCQsVAY8DUIAEQrgreBXQGboXAcU884=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN4JLkAMdIZYzN/P9k73oPCHqwt66vb+EK07+gDdGAW6jZZRb8
	/mab+BtJnkEqBnyaLWAUpxOOHFd4D0lPe5nbQvNQQw/7zbLhiLRWNk9l
X-Gm-Gg: AR+sD12crI2aWZqcLN81F/Kw583ths7nwUHd/0TJI/Fn6G1Ie4q3/afwO4jrjxuNM9L
	HfRzjODDBo+4Nmcnb/lZ3fx5juz6SeAUHCQyFIWUAJdR92HiByDJGnPox6VOetsjblfUlKExgAr
	HoCsk8ZAv1PpkDffBEGWpTdpLM22BaJKXAou+17cmAzq7TidK6lauC/w+CKU0D2RLHkfEmmwlOE
	UvpeB1Q4dSkd2Z23gpsWavCHbPbb329w4NmASvdkE8wFhg5yv0cJuUS7DHf7iFNWX9kasASkxGv
	h1v7Kr69P/gUay7qtUv6wzOzsearqSPSyRkBXXGGAFKGOlJHMhcUxvVF5DeZSZURTzsDvAEsC8S
	7WJAGGavcsFxoBdI82lud4DAw22BvNJhXMkahjurMi7dzG/WsK1AIAUkPMpEep1PdGFI68+kID3
	sfj8YPU6P87pEkA/E8D8ZtSYp+BNWivSrCGDnPggyM3aPPz6PfjNAqXmmfstQNG3JHH6Da1cHOq
	xz7367fQE+hCQxDJ6ZO6h7S
X-Received: by 2002:a17:907:94c7:b0:c21:f41:e192 with SMTP id a640c23a62f3a-c222a0ee20bmr66226666b.26.1787087022655;
        Tue, 18 Aug 2026 14:03:42 -0700 (PDT)
Received: from fedora ([2a02:6ea0:5601:6307::13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c219e3f64d6sm51888466b.32.2026.08.18.14.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 14:03:40 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] mmc: vub300: fix Use-After-Free of inactivity_timer on disconnect and probe failure
Date: Wed, 19 Aug 2026 02:03:22 +0500
Message-ID: <20260818210322.53266-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vub300 driver arms inactivity_timer during probe and acquires a kref
reference for the running timer. However, vub300_disconnect() sets
vub300->interface = NULL and drops the driver's kref without shutting down
the timer via timer_shutdown_sync().

If the timer expires after the host is removed and vub300 is freed,
or if concurrent work items re-arm the timer,
vub300_inactivity_timer_expired() accesses the already freed vub300
structure, causing a Use-After-Free.

Fix this by explicitly shutting down inactivity_timer via
timer_shutdown_sync() and releasing the timer's kref reference in
vub300_disconnect() and probe error cleanup paths.

Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/mmc/host/vub300.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 8e45dc1a4a12..9f84bd1531e2 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2350,6 +2350,8 @@ static int vub300_probe(struct usb_interface *interface,
 
 err_stop_io:
 	vub300->interface = NULL;
+	timer_shutdown_sync(&vub300->inactivity_timer);
+	kref_put(&vub300->kref, vub300_delete);
 	kref_put(&vub300->kref, vub300_delete);
 
 	return retval;
@@ -2385,6 +2387,8 @@ static void vub300_disconnect(struct usb_interface *interface)
 			usb_set_intfdata(interface, NULL);
 			/* prevent more I/O from starting */
 			vub300->interface = NULL;
+			timer_shutdown_sync(&vub300->inactivity_timer);
+			kref_put(&vub300->kref, vub300_delete);
 			mmc_remove_host(mmc);
 			kref_put(&vub300->kref, vub300_delete);
 			pr_info("USB vub300 remote SDIO host controller[%d]"
-- 
2.43.0
