Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CBD4DEC39
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672862; cv=pass; b=TBVrkgl1tkAN8FuYv3mV7QnaqejwIAgqAHvyYa/L7nrGReiupDEDc/zfaaYPUDh3lc1e1HcsJ8v8Evz2CB16jjtnIDArBb9TjYlGCMGzNLcYwJ8jXGEe/ZHdeIhS4J8kRdSBaYIE4vtxwBoHM+4DzDwCGeb+KdN48gYnFredAIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672862; c=relaxed/simple;
	bh=b9QDa9jgDjFjOwt4VJXvXKJT/NU+qXv7vzZtc7dxTcM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jIJTr5arpj1FcU2TyCnred8PAs6sYUY+ipNCp0IohTyUjRNPNyyohd80kMJSFdd++mjCkGpRJtoWLJ9XXr6cJmLj0htH3l957zdoKx4N4UeD+bz5mAaDjg9cLE4fKw/J5h74nmB/IkAwRoLsi1hJOIJ6q/GmohF+/nJZiP19gFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pD7jIUHs; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pD7jIUHs"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a67fa7a64eso1951898a12.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789672859; cv=none;
        d=google.com; s=arc-20260327;
        b=mFH3RvPTY84UB9honbhPh67GCo/Zsqcubm0uQt7JZ+IpgFUZTpZmfi0e+1kBHBjufy
         YzRMfWhq42gACmHZrkyhP9lKa8TFQAFwlL04ya/i/iH+otAR8YRo5mlnHD8TcYzagLYL
         5tiQd2J8RUY3iRkOij6Wyk38dBAd5KwZx2I+PgP4lef/NzGAhoeZFs614lwDAVsKkBdC
         T4Fd6Sg64memhV1kekHSsgLhalp/72KGUv4OvZwf0/KDaIyik4ygsFC0CsiOo0u3f2w5
         T0fKMD0dLWD+8T+KrB2fy7Ch5qMnBxaCB4TB+2JwMPcUmOTjS7uKyyr2kGihZ85HqCqX
         KSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=J/A6MwTJDB3NeP/eALr2ie67LMze+zYTRsIK1+3o4Qg=;
        fh=xjfBXz4+9ZZzlrpXzVu8eOvgfJ4k62rcXrrX4pcU3iY=;
        b=orwO8YCrEcbN3GaWDRcH4u7LpgOqlDtUHeA7cmeFFKp15CJtwkSZXv5qneS5oCKYUo
         E97NtTziB2WmRDBSs1brc5nBPX2CaOfNKDGr0vzlUF8XQFEW/phHFUh9BSff7qkXkteL
         BRsAVCuXbflX8CBoU9wYBHQ2ekCVuI8hajKtUcojCT+vzCbNDmhKM8guEupFXabX+SkK
         0qhf7PEnYjVCjWZFvJX854pTbaLmW2nqHrp4u3i2GpSvc+IMJQqbBn4u5/9XEJF/2K4p
         l5znKnbUPlJCQ93nL5TE9VvgF771TsbxPKlvIZFieMui2yfn3ggys0IV3sEyyUlRbIVl
         9/3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789672859; x=1790277659; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J/A6MwTJDB3NeP/eALr2ie67LMze+zYTRsIK1+3o4Qg=;
        b=pD7jIUHsle3TBiQoOzuUuhbnc+dlnQP5N2AZvLOedAR4lMChd273hY8o7AUmPzhsol
         uV5bXZS6hAiKHkyg3X+pOTxqUlH5dXzSibYAvDdvIO0xBeG5QNViygc00le4zhHLkM+l
         KCyVOYuca+XdgxtPgRQqVvHynGK0AJxoLVx4Ki2JCnP5eIR9JBSxMbBbJZVSAmbem7RW
         R3Su80xiNWQrDpPBbXoGtm08CAk5kcIrWiSRhSTXhl0Bw9xKVETuV6cVKskBRyr7+FPK
         GNuR9Lax0UecR2pXSkqOPwSf/gDtmQ/227u2U5Ep5FJxMjxHyg9YoVgSadcyUlntB7rx
         wFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789672859; x=1790277659;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J/A6MwTJDB3NeP/eALr2ie67LMze+zYTRsIK1+3o4Qg=;
        b=KCY7wVGiz/PiGvskX/21F+8807086QfTKH+1RnEWHMmXdkWEd2mCunAW4cx6QsRQ5F
         QNGYBLeWsDnoAuc8TkcdkNRnTc/ZrpVdc14tPgjHzWB7fS1m4ThxBfElVALnTXT2nQ56
         k3GnaPH8amdgg9VrUdL1unKhGgYHDRW3Ma7QZs/98mYnQIxY4pe1HUHgNSRoFAG2Rq/X
         xf4099fTGIm1TKkxVCTay11GETk6KXXNn2ay3xCbzLoAhysUqzewxjtE6xUvCfAA/OFv
         J76T2TRoIZuF0X35YGwIwpeURGtQRjfuNeCO2N5hyk5LazXtDxx6doHAmSu5zbMzAdUy
         yeXg==
X-Forwarded-Encrypted: i=1; AKwUvBxJ3w3fuCfAYF4fJ8FtZnTrJSMKyDtSpoosv3WHTWWQELAm6VIJo9WPMLBvok9uk2M0Z9lG6CM=@vger.kernel.org
X-Gm-Message-State: AFuF++n5H3vpD3BSRcEd+9jbiylPZ+COoAcSSpsqsc0iU3T8+K+YI0iA
	Cp/mSLJWOwXS7AOzyfxp05zV6i4eazpnV91hNGP0T5bTkYoYm0njkpkWUzuaOBz7juJRdrOCbd/
	Ia1wSZJ8YLlXtZzHFGKiucfNBeQilUTkEi4KrBw==
X-Gm-Gg: AYBFou1xjiHPQ/vfKQhgFdsc/4Ph/X+ST/gx1gMDsGKw8yu8oogOAIt2irn0ow8SphD
	Mn3Nm4PoUknJXxFmvZJjRxf4qPWP6UI6osaLJncubLDWguZ9L8hq8MGOQbrSEyg0A0d/bRNTV+O
	7cotKfUlF0iPLEA7mh65bxCV6R3hJhfS/8D6vSeklDYGkRgPf37DdnEcrMIBvMtfSkRb9rhQlVX
	2Sh1jYnaGUpqpw+s8rdwCWd7N2369VP6P/5P4Dn7hi2HCCE7y3fdmIf2fhWzc0Cuyw4HV5edHHq
	DZcaIOem46MgAlVXMRfL0RfQXOA7RW4yLXEIVRb5p2t0Y8pvoB4XyjUuomH3PwD4KpDAPsrpJJv
	TODmU/78EcZ7xjSHBb4r5AxY/EvlqaYCwHmCmYnFYnjKe03OUi+8LTnMrZWh0x7/UYTRc
X-Received: by 2002:a05:6402:234e:b0:6a9:bc61:7f80 with SMTP id
 4fb4d7f45d1cf-6aa22418ee6mr5676940a12.27.1789672858973; Thu, 17 Sep 2026
 12:20:58 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 17 Sep 2026 19:20:58 +0000
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 17 Sep 2026 19:20:58 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 17 Sep 2026 19:20:58 +0000
X-Gm-Features: AcwNN1WxTWOhjEb7bBl6eypOV0BHfRXqW5W6uIymGwW7YeDpfpFb9TiYbq7J4Ek
Message-ID: <CAGEsz8F2eKsmV_tymO+9UD5xkS_tWhZo-b9Xom1_SiKuc-BCqg@mail.gmail.com>
Subject: [PATCH] usb: gadget: tegra-xudc: Disable port reset work on removal
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The port status interrupt can schedule port_reset_war_work to handle the
Tegra210 port reset workaround. The remove path does not cancel this
work, so it can run after the PHYs and controller resources have been
released and access freed memory.

Disable and drain port_reset_war_work before tearing down the controller.
Use disable_delayed_work_sync() so that the interrupt handler cannot
queue the work again while the managed IRQ is still registered.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB
device mode controller")
Cc: stable@vger.kernel.org # 6.10+
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3926,6 +3926,7 @@

 	pm_runtime_get_sync(xudc->dev);

+	disable_delayed_work_sync(&xudc->port_reset_war_work);
 	cancel_delayed_work_sync(&xudc->plc_reset_work);
 	cancel_work_sync(&xudc->usb_role_sw_work);

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.47.1
