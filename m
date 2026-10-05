Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19314B44B4
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212173; cv=none; b=u/g1N3AXTwhZU1yHnBAl5VtoXRXP+133mWlrQSZc8pEt779F4IeCraTznZxRWt2Se7gN2YyjJDyNhVbbliuK1yvtolE5WRCAAEZXLOI/VltNbJO7sprh4aBRf1woUzsVwq2LST5ors8heOa8Vb1IwycAV8j/8212m7kHxqli0pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212173; c=relaxed/simple;
	bh=EiBKd8GStOUfIpi/gjn/hGQ8S/hVfxafHK2alIdzNwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hR8z1woN2jFl69D5rfgLvY2N1kf2Uv/ZoMvEfkC8fCvL/oIvGWScVXBKKuSgRKiI5MYWB0Xmn1GXobj92YN7VUoLRRMZh0h/tPWkjmLcmLXFhAIYo+aakWe9a04C7urNA+DmsF1O97qcX3Z/Jn5T+goALYBVfvN25DFE75YUifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7WsM2bQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7WsM2bQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49ff680331aso18822115e9.3
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791212166; x=1791816966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VEexO2lvA+9AjS4iDd6WKJuFeAIzg+vRwOGVTItlkVc=;
        b=Z7WsM2bQuOZWo0SPiHgIrBU9rVRCOw4GciHSKe9Y8KC2b6yE+/mhUg3FR6AVaEqCb+
         ImiIK6fCbJcPDTF4uH9Uw+AALKtFhzphqWw5zg/EVOTgYvkGn3xMP7wCVqinktJLqg+S
         4vcqBqJ6tjIZvqw8Ddkgm2vwTUlfv1ArzQ1t1ppPzm3ai/ZSSe4lkM8RsGguVOHZyhBl
         /0U6UCla35XUNTtgo7ORpegTMeonTjcZO86Iet9fbuXB+j2Tt5tx+Bu6E1IeZsMzzJZ9
         MVwmClGlROIN4gV+nqgb/IcVR1DzhJ/pEItXFOkf0O+8UC2dVBGM6LUsg5UBSxUPMYg/
         CnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212166; x=1791816966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VEexO2lvA+9AjS4iDd6WKJuFeAIzg+vRwOGVTItlkVc=;
        b=RdRejf8Q1FjsA98MtXg/6Eb8k/FcHTr/nsYosxxJYHu0wizkXowrSavc/gYbh4eKr4
         5u6Y8UwaanKjLy8dh3opdH+mrE3UqCVzkJIn0iuO3nYLwP2ST+J05pCT069aKLajJqKy
         D8lOnUu5GVytRWB+PsyoOdTboyUKnAqA1k97UomMGztGIKItMti0lLCU5D8lZuup9FyC
         TQkGOUg6xXP3IsKL/raGuefeffBKzQmuyz18V1XQ3Y7iAZJFHeQSVLrpH8NngWezeLVe
         uniS2z3pE7fuPWV2nHFJUwo/QNStX7PKlH9GudBNzO+/26RrxFUKefWyvaPP12MQciry
         6IUA==
X-Gm-Message-State: AFuF++m6JhAYB/f9qmeVmDxTSHMI4hNsbl4Msl2Xjsh6dsSogVjBEGWn
	ZtWWptShADkW2c5M7164yIDh2zNYDOobFnnurFJrDxTVw/u854vtskUaBmB/Jw==
X-Gm-Gg: AYBFou1Tlyr3/Y9CxFhrgzoVoOuOZ8QTFEiPy4bjesux1hKHtHJrUQXyh15ukjjVbrw
	cbGP+JSLShWjFcMkNlbVJ3083ZWwN93us5CO0R3PXT86e6l8tfeCfFnNfgjgvmU3vHVcPI2QCVy
	cgGB/GgLxkx5icyXnQ7ywDUgTRhidmYB7kUmPydKPGSonSqqRZPrzSRSzPBeEzEKG0Q8iXF4lu4
	ljrqGf3vOpA9HFusXpwW7KQCLe1AkNUtIKINkjYtmT0RtK27FGKP1buqSU6mTab4Y/kLtVLw1pn
	2AlKv4FPWuNt+RTw2xXtYYUdCykG9FzOMcE3McYLMgAJNCVh+oLkfgaHDrxggnU2iGZj3WTjemC
	1FNl/SY8250K8pO4XWivQ1jtacKZHElLElQEgolA9z5zfEQctwNPnTLp+BU1q5EJYOr61fGSIqZ
	eMHz/HpzYf7oS8Lx544AjIJUpoHgblqNha/w6eETOzJL5SnaqmnaDsJ9hYHZn+VN+mCewqbU+hS
	Ud0
X-Received: by 2002:a05:600c:c16d:b0:4a1:717b:7976 with SMTP id 5b1f17b1804b1-4a1717b79eamr47242805e9.35.1791212165729;
        Mon, 05 Oct 2026 07:56:05 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1776cfe45sm12380115e9.1.2026.10.05.07.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:56:05 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: Please apply 13221be72034 ("wifi: rtw88: Handle C2H_ADAPTIVITY in rtw_fw_c2h_cmd_handle()") to 6.6.y and 6.12.y
Date: Mon,  5 Oct 2026 16:56:04 +0200
Message-ID: <20261005145604.134614-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

please consider

  13221be72034 ("wifi: rtw88: Handle C2H_ADAPTIVITY in rtw_fw_c2h_cmd_handle()")

for the 6.6.y and 6.12.y stable trees. It is in mainline since 6.14 and
applies cleanly to both.

Without it rtw_fw_adaptivity_result() runs from the USB RX work: it
reads three registers as arguments of rtw_dbg(), which is an empty
inline when CONFIG_RTW88_DEBUG is off, so the reads still happen there.
Over USB a register read sleeps. On 6.12.112 with an RTL8822CU, the
only rtw88 chip with adaptivity support, this gave "Voluntary context
switch within RCU read-side critical section" in rtw_usb_rx_handler()
-> rtw_fw_c2h_cmd_rx_irqsafe() -> rtw_usb_read32() within a minute of
starting an AP, followed by "xHCI host controller not responding,
assume dead", which took every USB device on the board with it. With
the commit applied the same board ran the AP through a channel switch
test session without a message.

Thanks,
Mehmet
