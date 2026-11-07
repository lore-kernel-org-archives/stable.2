Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064739;
	b=GlcbA1Po2XNCn5CyueKJrN+/mTWQQYe/fDb9wGNBxeEGVwLM/3dVplw/w3ydCQnQgXbn
	 QQrqlsxisWC8kVL+tTirHyjoeZyMgDGIXsY4YVyhh9Wp0Xy42vE3dGlYtvvjA98Nmr4uk
	 8Tl7m0u/XLuOFp6ixfgGnP6Xs/gys4xe4ET0XMc22+cVz0wTvSYyeaaLsHhuszc2qJ0G1
	 7ng/nXuiKGCFuer6kuIAG1bJTKe/zp7pNI5Gt5vF8xlOsrIWLoMveNA7IXdvi8L5ED2VM
	 9ysoFPCFlSfbHhPe/Jnfly0Mjq/bdOt+TUci/tXqu6eLLCTf2fOlrT6cUqyhqTNMG7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/FMecL4/Be4U19AOcEGGR/s5+PksX0yjLPbC5lOfnWY=;
	b=iQn5HFyI21SepFQfgSCnJh5TdM32YjjiSjMinAqU53+3ZukOI1pFuJHrlD0ep94Y3tPK
	 tFN5l8RRF2Eai3NQfIZFegAv+t4XjPgLsV/FrcFTJiwjpj2brSGNqQdMRWFJm0Vs/jrjz
	 lgQe7vfg6mnVFQVSw81lj+sFabXyaYP7iAX6YUbel5YYeNTypGvwhDzD3weNZWBAvMDAF
	 T2WzGUdcr8NQveeObXKGzi4pdSgRIFlpLynkhQods/sq/LUOf0lGi9pd1MMKdiQQCy4dt
	 kIY3bKvVqaZ2MrnENyed09AaVuFSVcYpJ/JQmRWYgcfT27AgijrS1CUT2/8rjgJ6P5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TWbKXYbx;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281C1606D81A
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 281C1606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TWbKXYbx
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso2517657eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 07:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794064738; x=1794669538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/FMecL4/Be4U19AOcEGGR/s5+PksX0yjLPbC5lOfnWY=;
        b=TWbKXYbx7w/Wom34yDTrCrj66CgMASixb1QRY5kDrAsLcQ+8GeRlWZbp8QjFk2HMXr
         8xPcv5OfkRP5wOz7qON0ZaB1RVFi1MEInGfO/7IfI/7JctuED/yIOd/G2ft83jl9h42M
         VDx7pxhGLdebmulu9qy+mLr0C8dmbB3vvKhc9uKrjNP9XToGBkUYlOJ/gy0eaWp5Tl0h
         bNtJkwjUWsuUTOofmv5qnNYpn2fPy0SfabTHOY4alEGj16k5cMdABmT3dvuzZkvIpXhv
         55DdxZqMXdUwM0v1YTco9INseeLN1gfvEq8Y8TFC0zNYMt30qeghkT8Fq/xrprEf3Qeo
         1IDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794064738; x=1794669538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/FMecL4/Be4U19AOcEGGR/s5+PksX0yjLPbC5lOfnWY=;
        b=EzziYSK+ZzZSa60ZtzpSBJM9UeFigTQlaOq6AwagpCImBoKfKwpGe69OtKFxMQwXjk
         DdG2lI40E8m4EbLNCIVv5zw+eXmhRjOogWRAMd5pFa6edOoGoltJXbewTnVAnCNNGsWo
         2rKKd0gbq8QKWbaQuiXPif8ZhVVHUiNiEnxdV0K71LaRDE+ntypvfJ22b78ezYlw7Q1h
         BnQgeEBVGN7mlQr7/p7Kd8yqkTmZe0MmUmwoj3Hksv98oU0qHbqRTWlmqMib67NcjjpU
         tQqdNuLCRcNjN6CL38t78N1T8p/auwGbDlxB4NuOJHGJ8bxuAVASs7Vos8lJZihhDLvm
         +yeQ==
X-Forwarded-Encrypted: i=1; AL+hErHsYrG2knpO0DM4MjeGXuIMrjdKuKNo11XI9WwyiAeU7u/4ZcPl5BbAiJGFD0Az+hXuTcgXcxM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZnqBKs/6dkQvUvfL+qQYTy9vecalOBjgDGsyxLizhYJG5l0JT
	AV4mBAab0ZW3Bsg+42o5WE57L1GSQCwFSG6hnC/mndVjJk1XfL39eTz/
X-Gm-Gg: AYBFou3ebr2KqBsByizD6IAmb3sheVAjHytYioYwyyL2NpsWdFbMaJKHHoAJg1yKyL+
	bjNXY5N4ilEzHFaFj3Ee3sZYs61HWgZUakCzIEXCMYZv0ISkwZDE2bBmDJrnjTuBkNRfciejv8c
	NUEoUzXAOneub7EGRNAi7bul3lOZEPlf0pZNRUnZkUMfhNzBRo5ZugnLjjCzKdOf9JkGdx7jiTS
	j88tzgbGtoemdABjqlJzVFGXOavll9g0T1BRDL5hsKqX133ksKSAxP/ksP74x/ouyUkNGjCQuqk
	V2xUADEDl2I5RLATNwBIaCDUz2AtgTHbQ1/ZgOogYKYoZSAjWf2TLnDTsehDB8aALiM/ldYBS8q
	YYQvPddfSDGIcPSLIF6vFA0TKul7hQ8ZGvwYEmPfMHAv5VjkMRKFfQU916ieeENXfg3NxGnpe/h
	9AyZl+lQM3jgjwIAwCVdLa1OFSFHCIRLdfPlpDCrvCAE2BHCAPA85vnUQbbninxKTMEb8gJWEwW
	/w/ix9HtIA7oOqieQ4vQDe29KLjgRY04FeezODy71fgHb8LcPs2+qsP8Y9VFpP5XIOK1vf3x9wH
	JhsRvrWKdGESzJXQKuQsUow7mf84FmJeNqYNtMymeSxdNJK5
X-Received: by 2002:a05:7300:dd05:b0:36c:9af3:22eb with SMTP id 5a478bee46e88-36f76e0ff40mr8378888eec.34.1794064737923;
        Sat, 07 Nov 2026 07:18:57 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm22259736eec.10.2026.11.07.07.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:18:57 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: sl811-hcd: delete the driver timer on stop to avoid use-after-free
Date: Sun,  8 Nov 2026 00:18:46 +0900
Message-ID: <20261107151847.3754846-1-hj351016@gmail.com>
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

sl811h_hub_control() arms sl811->timer (sl811h_timer) with mod_timer()
for port reset/resume timing; the timer callback dereferences the
hcd-private struct sl811 (sl811->ctrl1, sl811->lock, sl811->port1, and
register I/O via sl811).

sl811h_stop() deletes only the USB core's root-hub timer
(hcd->rh_timer); it never deletes sl811->timer, and nothing else does
either. struct sl811 lives in the HCD private area and is freed by
usb_put_hcd() after sl811h_remove() calls usb_remove_hcd(). If
sl811->timer is still pending when the controller is stopped and the HCD
is freed, sl811h_timer() runs against the freed struct sl811
(use-after-free).

Delete sl811->timer at the start of sl811h_stop(), next to the existing
hcd->rh_timer teardown and before port_power(sl811, 0) halts the
controller, so any pending sl811h_timer() is drained before the hardware
is halted and cannot re-enable it afterwards. usb_remove_hcd() has
already stopped root-hub activity before sl811h_stop() runs, so the timer
cannot be re-armed, and sl811h_timer() does not re-arm itself, so a
single timer_delete_sync() drains it.

Found by static analysis and code review; not tested on real hardware
(needs an SL811HS USB host controller).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
v2: delete sl811->timer BEFORE port_power(sl811, 0) (top of sl811h_stop(),
    next to hcd->rh_timer) instead of after it, so a pending sl811h_timer()
    is drained before the controller is halted and cannot re-enable it in
    the window after the lock is dropped. Corrected the log: only
    sl811h_hub_control() arms sl811->timer (not the transfer scheduler).
    Both per Sashiko AI review.

 drivers/usb/host/sl811-hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index b044977..b667732 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1516,6 +1516,7 @@ sl811h_stop(struct usb_hcd *hcd)
 	unsigned long	flags;
 
 	timer_delete_sync(&hcd->rh_timer);
+	timer_delete_sync(&sl811->timer);
 
 	spin_lock_irqsave(&sl811->lock, flags);
 	port_power(sl811, 0);
-- 
2.43.0

