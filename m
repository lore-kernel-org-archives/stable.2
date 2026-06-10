Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61233689E
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114940; cv=none; b=Otj8SJ5AglopuDWjKtooeYJlyM1i0wvscLrS9t/yXSZrkl/OuHjUpUM1Hz3SMVJ7M1P/naE69aFBWiOJ1zEEs+M54XBpBT6dhXMPlqQxNyTiex8N9uzQttY/rzchzOyUvP5TMzaScoWZHM5N5lhZzGN7iMLhlbfufl3TI/s+OA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114940; c=relaxed/simple;
	bh=gdkRLsEYdTfbD6NMnn7No115YeZMwlYuglRnCd5Nnlo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sn1Np3GwIQtDJ8vn5UfltNVyvtG4MdqJAZUS7nUBoPo/bLydGOOnTS++BDzR/TaH1Tg8kDP7dlycUw+jDEkNkDmaTL9BKrSaz176PZjBmN8rzDMv6P43e4L7X2OX2UKl8ac9MNHeY3HPes5AOTiUihGY7CuPOme4nv0gd0eXZZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vu1mzTCr; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vu1mzTCr"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137eff27f36so347882c88.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781114938; x=1781719738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1tVvKPjpVOuOIT3ExmpgiKRZJ1awT71IaVj9uNbuWBI=;
        b=vu1mzTCr/FCEFLlIOTM8uGQXkiuv4YhppwUbiMu52uTd3CIwm35mH0wjGmax9/zM2S
         cbzNNaacs0U/ZB/fRLtI+6J+wsFzeIQK2S6IQ7dnoZZnpkPjFuKIFLznaRaucW5EK3hr
         9fyyFrNpGEIRayCM2ReVU+00Zee4AxcCLA4Wp1ggURPNdEeSTM/2YakAHmET2JzI5SI1
         b/g7IpyBKZokKJ1t+UdKEX76jjFsD1ZgQHl4ZXgf+f7NJhWYNO02JYqtiXHWqwTDh/Qx
         oZIom5dt2/z+WK6s2XWrTEqdYNU6GxD53/ixjcVnW93+pczF/TH2dJZMqQQhiMFDtNkP
         knQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114938; x=1781719738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tVvKPjpVOuOIT3ExmpgiKRZJ1awT71IaVj9uNbuWBI=;
        b=aN0YZ5Z0pgMsPPdftp8gns2P7Q2hzCzI8wnwyeT+LC1wTlDrpCSbQck9BJ0vhgJibN
         gKPAo8XyS5qfnk5thwkrGCCUyLA8fQm/8BsBcQHdYZrI+xVi/tmm3OLd2rcC13UyAUGq
         wNUTK8CMb6ht5gYEsEceMSH9BKYDwOFpP9trU3HOn8uHd8nxLQTK95WtCnJQmcS3Ayee
         /ORtCoXYSXc7uxh9FsN9TWJFnXUSyzOsu7nW+6J7GvkFbNhLTTPIY+P6PO+8qbTgGDfY
         FguAqg2MdM0lBitpW8UjBHHVI1/OqmwKuqFH+fbl2Vma6ZUu8XeRNVVeiqNC/AMy541k
         c9pg==
X-Gm-Message-State: AOJu0Yy0UTgLYQT6P0CQ2QdJn5MOPwcEnwYwPSN1zfowc5h8LenvOSm5
	uydlU0+PFSmkY6QvNhXVDK8QJ+2Oax/WdAXdJn9GOdWDV1zvb9lRBtPYxcRFVksY5Izd2uefL/h
	ubih0PB7yxHeeCcADbK1CNmG96T6z7g6eRaYOptN6uMVZ+grG6nZOe9BHM5us8kf9gzKmXGc6Ys
	AOjp8yWQUQhAlKcFoz3GaZrBy3vBOpXLkITc27/fyYKZr2IiE=
X-Received: from dlbtu17.prod.google.com ([2002:a05:7022:3c11:b0:137:e4cf:f531])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2403:b0:138:3613:db7 with SMTP id a92af1059eb24-13836130f1amr2334449c88.1.1781114937721;
 Wed, 10 Jun 2026 11:08:57 -0700 (PDT)
Date: Wed, 10 Jun 2026 18:08:37 +0000
In-Reply-To: <20260610180841.3091635-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610180841.3091635-1-cmllamas@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260610180841.3091635-2-cmllamas@google.com>
Subject: [PATCH 6.1.y 2/2] usb: gadget: u_ether: Fix NULL pointer deref in eth_get_drvinfo
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: Jianqiang kang <jianqkang@sina.cn>, Neill Kapron <nkapron@google.com>, kernel-team@android.com, 
	Kuen-Han Tsai <khtsai@google.com>, Val Packett <val@packett.cool>, stable <stable@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Sasha Levin <sashal@kernel.org>, "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Kuen-Han Tsai <khtsai@google.com>

[ Upstream commit e002e92e88e12457373ed096b18716d97e7bbb20 ]

Commit ec35c1969650 ("usb: gadget: f_ncm: Fix net_device lifecycle with
device_move") reparents the gadget device to /sys/devices/virtual during
unbind, clearing the gadget pointer. If the userspace tool queries on
the surviving interface during this detached window, this leads to a
NULL pointer dereference.

Unable to handle kernel NULL pointer dereference
Call trace:
 eth_get_drvinfo+0x50/0x90
 ethtool_get_drvinfo+0x5c/0x1f0
 __dev_ethtool+0xaec/0x1fe0
 dev_ethtool+0x134/0x2e0
 dev_ioctl+0x338/0x560

Add a NULL check for dev->gadget in eth_get_drvinfo(). When detached,
skip copying the fw_version and bus_info strings, which is natively
handled by ethtool_get_drvinfo for empty strings.

Suggested-by: Val Packett <val@packett.cool>
Reported-by: Val Packett <val@packett.cool>
Closes: https://lore.kernel.org/linux-usb/10890524-cf83-4a71-b879-93e2b2cc1fcc@packett.cool/
Fixes: ec35c1969650 ("usb: gadget: f_ncm: Fix net_device lifecycle with device_move")
Cc: stable <stable@kernel.org>
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://patch.msgid.link/20260316-eth-null-deref-v1-1-07005f33be85@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/usb/gadget/function/u_ether.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index e972de236be5..83dfc5008b68 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -147,8 +147,10 @@ static void eth_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *p)
 
 	strscpy(p->driver, "g_ether", sizeof(p->driver));
 	strscpy(p->version, UETH__VERSION, sizeof(p->version));
-	strscpy(p->fw_version, dev->gadget->name, sizeof(p->fw_version));
-	strscpy(p->bus_info, dev_name(&dev->gadget->dev), sizeof(p->bus_info));
+	if (dev->gadget) {
+		strscpy(p->fw_version, dev->gadget->name, sizeof(p->fw_version));
+		strscpy(p->bus_info, dev_name(&dev->gadget->dev), sizeof(p->bus_info));
+	}
 }
 
 /* REVISIT can also support:
-- 
2.54.0.1136.gdb2ca164c4-goog

