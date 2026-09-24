Received: from mail-ej2-f18.google.com (mail-ej2-f18.google.com [74.125.228.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B34AEBDA
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.146
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286099; cv=pass; b=lZmE9hFTsIyxEW2ceUB6k9VAl4z1X2Yak9JcUtLOrLJVapZR0a6gP7ZYHzaPHp0I0WyAA8rb/YNuP0GN1K1pQIUaBCyygHcmlk9a9pKVtuyC7e+j+HldbDw9cCjxuZCUpQgXFL2CEvY2A6Ej66mwGF8NrpdGitkE15cI/UnRcxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286099; c=relaxed/simple;
	bh=87GpcxVJ6wlRutNZWnNn10feaLHPsEDPE/16T1OQ2W4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DM4Om4g9sAkCsXIXBXmxAV/zoBjXaVToUdohxN7ZsHmrzPAqSuLJZSaW16MNKUfmYnblrvy0nmF0sWLhjOFFzLKScnkYyqVf+7Nb/0PDO2Rri/XoxHHnr9qf6jm0v3SSG2u+t/teisZtulmJ50m0FKsdPIq0HgMaRhtO/WGoEYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbVQsZVx; arc=pass smtp.client-ip=74.125.228.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbVQsZVx"
Received: by mail-ej2-f18.google.com with SMTP id a640c23a62f3a-c254fa65080so27808666b.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790286096; cv=none;
        d=google.com; s=arc-20260327;
        b=cPKZxfhLwPqhOshRFLzL2dwlgLptonz4jH+0cuvGBAnvQSwjVf8N+yz2E4xyolgocx
         TcJxjvSAL9O32PxLK0DYBCapMygNzF/HRjlbyDzoV6oefvEzplNncjcTmPD0Gyz30m5s
         xgMaKb3OQxA+hb97ETdV3mxqjMuYtVyMPSRjBSiLc5sDYF8aV9WsjJ4Kuq+wydfEx+Bm
         U78OdcbHEP9J/BC9QpCAgi2lU0jlx4tvEl45XUgKHG65H/hM7HoRL+laJDP2+XDlt3S1
         ofAuVXGPfJEpaWxywRmmcxXGqoOnIWKkdXy1pZGKwJNvGICKVCfU0vLDfGxK4lgoh1bU
         Bv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2SQz060QqCvrL5IKb7FfmYdL+k8EGntsJZoM76fEKWQ=;
        fh=NW8RQq4ZHZsDZeumQlzNQSsGFEIRz6TrB533rKYYu2s=;
        b=GPFZPDgrer0K0Tj40p3BUdUHyN5yAqcGeHUH6SO9ItuHRzGkEiN7DJV57KnoqmtXVw
         dci9Lz69bbEQCQohbySsPa1x4uGDKVlxQdjee/2yhpGFnebxecQt9yxv2NO7eI59ZoYH
         Xrgr23/EVJSUyTcA6v/P4oRUERjmnRuRenH+qTv2GQgI6MSgUD1wAusQOR3Y8Tmsmk8m
         JwBWWNJyFjk1ZEV2wpkZvHKkl53s9vA8tAu9zK/E+xr5qh6+2CzvZ/RzPlFEczTDq8M8
         qqLHIfuGSjuu/Uzk7rSz1QdGwpw9XKWUr+hfpm4UtZmIUMt9FD7ATDyHn5xwqDU8VDhA
         oUdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790286096; x=1790890896; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2SQz060QqCvrL5IKb7FfmYdL+k8EGntsJZoM76fEKWQ=;
        b=XbVQsZVxihKwvODXYXjNOXR2+LSzGEPG5A2YupQVxoUgT4soJjX3uI4+1+H9VHWFgy
         yH0d2PLNTOpYo0K1t0HmW0JhL7gg+nUxQRH0O0pJAlHohNM0VYRXjK5g7pnAXnQiD+wH
         gONBxArOnD/kSoU1LZ9ZoisWKk+lWDZhaLVMBkHf8P/mP0CN7j9vM3k1CXv85+aZRZdl
         Ily+kwx1kQNeezZ2P2Epg9rtFik2j10EVHLvOcnnC+WLuR3Epd/iookz2hwni3c9PCK1
         8HpjVfbgZHkk+o3XhDBQXewSionEyZbpUXjfM7QBZrodfLeLSxgYFQcKWf21M5FdGJEL
         uNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286096; x=1790890896;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2SQz060QqCvrL5IKb7FfmYdL+k8EGntsJZoM76fEKWQ=;
        b=wnkYQKbp2nGQTU9vfrdZhllPZW/ZsXi9KDfqX+IgjWZ+D57ESln9BrmsL6G5goSJq/
         Zy22WTXOr8eG3Y/Bo5w8hHu6JxfgBecV/TRKsRWxfekPC1N+ozigYjM+lLdhUK+iHF2R
         5qYoaV09dgDvFnylKw4pJiaAmrYZv7L3BFjMW9I/RBwQfYuKV45omf4MiK2XrnVRSXsu
         jt46e9oWabVm78doQrh0fxkJVmQygsNEXO0GaVB5y89IqkJrPULol/k+2N28W2LTSm0l
         ilPiys8CrXkRLeGdbLQ99kHuVcnll1lXGOqFmH5klcy693GMpElhvZZ8xSm2YgqxvAt9
         pyEA==
X-Forwarded-Encrypted: i=1; AKwUvBz4xqOKvuvosA+kMphCZFjUEBc1sJ2nxCdc9sbfo6H7JJsUXWFIbNZK1lXDCGgtuMi6EMx4eRo=@vger.kernel.org
X-Gm-Message-State: AFuF++nryyY8owo6fVTmSJhDvLXiTAK4PHZV0bPWYxneaqTymCcLvvYR
	WXjFkliq/5NhtWsRefJIUFi6XvyZBfYOqfuXisHMlDvngi4/o5zDHeveLImntBN0YAmOL77gW5/
	iEkt5Vc+hBbeg0B0PvpUdPUIGuVr2lw==
X-Gm-Gg: AYBFou06tJbcvyOb1tVOGwbXQNBPDH+VFgur6OT3BXIug0snB/3gQDKBqoBGaI2fU4P
	1phLXCbL59ys/D0uYUdrPrrx3cb7e+W8A6bhEHNCQKysNIqWpNozd6i1tIrWYovYKtTnz0yhyIl
	Bk875DtUTWK6HTTXM5Nvh++Ttk2yY9u0e8EKfzLEHUX9v4yJHONmlDA2L+fbzOeXTscJ8x1CDrQ
	iXBsnFTYOqEr7SoV+uN+uVar5s5caSq6sayX3EJ7YxIkojIYCijP1qB/vxDHtoG3YU8nk+USaVd
	D8r3BouVnW3jJh/n0QlI8XKuvBT4KX3BcOoJ0rMzn3JSA98RBchmYGD3UA3WRtmOtbuxSfby/Bn
	nMWjy7oXB2BPU4KDDh5MdhgKtLeNTLmkT99IC0OoSYsNnML5j461mFHy5P+iKOZ99
X-Received: by 2002:a17:907:d10:b0:c24:adf4:5c73 with SMTP id
 a640c23a62f3a-c2ac2310342mr324229466b.1.1790286096374; Thu, 24 Sep 2026
 14:41:36 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 16:41:33 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 16:41:33 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 24 Sep 2026 16:41:33 -0500
X-Gm-Features: AclHuK-LsOlMArYi-bBBEFBbSJHVTEpwXw5N32xMJ3oCEDVV0k2jabu7ooErkFA
Message-ID: <CAGEsz8EXYLRxnOFOD=FxKn6QFFFTGhqDpsvs3q_dZw5dna8fTg@mail.gmail.com>
Subject: [PATCH v2] usb: dwc3-am62: shut down refclk on remove
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org
Cc: rogerq@kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, mhun512@gmail.com, ae878000@gmail.com
Content-Type: text/plain; charset="UTF-8"

dwc3_ti_remove() relies on pm_runtime_put_sync() to invoke the
runtime-suspend callback and disable the USB2 reference clock.  The
callback is not guaranteed to run: autosuspend may defer it, and a
reference held by pm_runtime_forbid() keeps the usage count above zero.
The following pm_runtime_disable() then cancels pending work while the
clock remains enabled.

Balance only the reference acquired by remove without requesting a suspend,
then disable runtime PM to drain any operation in progress.  Disable the
clock explicitly when the stable runtime status shows that the device was
not already suspended.  This also handles CONFIG_PM=n, where the runtime-PM
calls are stubs, without double-disabling the clock after a failed resume.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 6661befe4100 ("usb: dwc3-am62: fix module unload/reload behavior")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
Changes in v2:
- Add Cc: stable@vger.kernel.org and Thinh Nguyen's Acked-by.

 drivers/usb/dwc3/dwc3-am62.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 632634d6e..2fb9e088f 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -319,9 +319,11 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 	reg &= ~USBSS_MODE_VALID;
 	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);

-	pm_runtime_put_sync(dev);
+	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_dont_use_autosuspend(dev);
+	if (!pm_runtime_status_suspended(dev))
+		clk_disable_unprepare(am62->usb2_refclk);
 	pm_runtime_set_suspended(dev);
 }

-- 
2.47.1
