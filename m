Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612BE346ADC
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782109932; cv=none; b=qaZqKPkePlYppY0yteERfn7PGPA0OoZTBQuPcT99toP4515YhmV/7Z2qEa2sxh+Kb7a0HIZ+1v2A/yMyJFqP5W2tBHowoYjJZRhmMOZHjtmVoGfgEy4wqJRRLhfh8Q2dm949bfighymi1NZgf9Vj6AY5YSnFrnQEbTLPMxCx1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782109932; c=relaxed/simple;
	bh=sO2VCjgYLWsbatZblwFdOv5SQCJmlXlUk9frEctl7uY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LYyvVU17hZk5tGmcKOphBdjvrNR0rWkuP/QBB0l/XiCZZ91gTTSBjMQVyqlzAYZfSRzzWOjo2Rpdo8pWCZsMd6K36gUJ+/TZeWm7e+ryekIwBNCggKDwr8vkPou2ttaQ43sv3SK1AEkTg7ZTwC+Mq2LdBiSxIbg0lI1QgJ7rJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/Q6mZX0; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/Q6mZX0"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c88b7c92577so1689517a12.3
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 23:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782109931; x=1782714731; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGVBPdCK3AGzwKRru1pGLY4f4womJDI/YrwxL+ueu4M=;
        b=l/Q6mZX0E/0VyWp6ZOj4gp9au98oe6czEZmIOsyfS96XOxGYIvCayxXOQicpgXaqpu
         r+lP9a+wCU0oAvn8BGccoX6hcM7kX/WPS4n6U4LhXILYRJj6Cjf1tqgSjRKvMYHfZksj
         vQ6cZX6TiYL5F/oX/Z5aHBfzqKi54UeKD7jjY12MD9liD62N8Li+r9wls/ZIkp/Ww7+D
         3AgmEcpzRb0+2ZBCgatjpuOTSux4lix2jDdaY7s2VU7s/65o10S1n/wScbyjYlfdsBWR
         VPejJQiDomn5RLvMMgZYlIDNX6RpdBo2kohFH0utCKi0YwlU3I2DL3Sb/lkeR2pfySj2
         07mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782109931; x=1782714731;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGVBPdCK3AGzwKRru1pGLY4f4womJDI/YrwxL+ueu4M=;
        b=dSq5Pc3u6ON+Kx907CehFY8dUaVLEgk2L69vMJth2OmbKb+yexgPWDYGxaWVdY9BqU
         OaKiESNiRrtZyZwby+3HskEALofL2S72RjxklrrZcxOfFITUk7fdqKE/RyNJ8fuVOvFH
         3miMmG0LzFAZfxqrYB29g6G6UTdUTjduXpQ8txHYmn4xrYpTTEUuerLVEPMCj49LaALW
         46CCPsWmkkIHQhVqWNSJkRk6zl0JYJf+xmEI1WgVGf0J3FjSnOCMaOuNrtgW+G/VDmDN
         u8Sao63nIZC98jBMCIg+ZjRCA1T1y+TgVJze9FFSbiAHp5HeY1OV5Cjjupo9ASgHbAnq
         BR9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8nyxcjijpcqRqH60+F9FvKP3jWc7RQQnbOLO4iPXLvtIYwSLYwhwV7lRymCNLRERsRY13gqAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvC2BHPBOtYpRs/PP6NLJwpMtf0fM8DzLpLYxOnrwpiANv6aE0
	B37PgyCT1P1TAElMcKKWqchp3jiGrE9/GMkWCzsr5nAngnqFVwtLoXho
X-Gm-Gg: AfdE7clkQAHMnIdmgtopuG3hBKB/IGEqePofR4zynOdQDaQjBv0JgzLT5Rek9QfYCsN
	O/0iEYPbj0Zoi7c3/zS1q9RhJ3p93aytpe/Pbhtc8dUbJ4MENpAFU+XiuiGS9fcvgSkZt8QFUb2
	RGAkp+K0OwbFzvoVhFb9oHpBLJ3fDVgZdWXyGnoKWJwKqi87qNa1dmUiJDVzb8mp1mcDnd/qDiJ
	7/6Fe5w8AGrKv358JYhDrzx2PNWTdrCAFUTtRfxQrmA1HTvmmoMBNFguhqRwNkxcQg24tO5xA0n
	vuw7eZy92fhxUCrWoiXlwbUAxryfMvLOjIhj1lyEVK31IDDf/dt1WSYLZiYCXzjpzKke7SXOQa0
	UEoVIbn93sWuM/A5M+amo/vJS2m3fL8ZlgKcDG32l+w2NeFpLFqEcXCe6Jg29IY/ILm9MREBmaq
	sE/y5r2BBwjjB++JLo6i6FkadPeZmRU5+EC1yZ8Q==
X-Received: by 2002:a05:6a20:1443:b0:3a8:7fb:ca0e with SMTP id adf61e73a8af0-3bb33953900mr15603997637.23.1782109930425;
        Sun, 21 Jun 2026 23:32:10 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bbffc2329sm6230436a12.0.2026.06.21.23.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 23:32:09 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Sven Van Asbroeck <thesven73@gmail.com>, oe-linux-nfc@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 [PATCH] nfc: port100: cancel cmd_complete_work before freeing on disconnect
Date: Mon, 22 Jun 2026 14:32:05 +0800
Message-ID: <178210992563.2193984.1212513889352740911@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

port100_disconnect() kills the URBs and frees dev->cmd. dev itself is devm
allocated and released once disconnect() returns. It never cancels
dev->cmd_complete_work.

A response or ack URB completion schedules cmd_complete_work from
port100_recv_response() or port100_recv_ack(). usb_kill_urb() waits for a
completion handler that is still running. A work item it already queued is
not cancelled. After disconnect() frees dev->cmd and returns, the worker
runs port100_send_async_complete(). Its first accesses are

	struct port100_cmd *cmd = dev->cmd;
	int status = cmd->status;

so it reads the freed command. That is a use after free.

Cancel the work synchronously after killing the URBs. Nothing can
re-schedule it then. Do this before freeing dev->cmd.

This was reproduced under KASAN on 7.1-rc7. With the current code the work
runs after dev->cmd is freed. KASAN reports a slab use after free read of
cmd->status from the workqueue. With cancel_work_sync() the work is
cancelled and the report is gone.

  BUG: KASAN: slab-use-after-free in the cmd_complete_work worker
  Read of size 4 (cmd->status) by task kworker
  Freed by the kfree(dev->cmd) in port100_disconnect()

thunderbolt XDomain fixed the same race recently. A delayed work ran
after disconnect had freed its state. port100 has the same shape and is
still unfixed.

Sven Van Asbroeck proposed this fix in a 2019 RFC [1]. It was never merged
and the disconnect path is still unaddressed. The earlier fix, commit
f80cfe2f2658 ("NFC: port100: fix use-after-free in port100_send_complete"),
only added usb_kill_urb() to the probe error path.

Link: https://lore.kernel.org/all/20190205160118.27491-1-TheSven73@googlemail.com/ [1]
Fixes: 0347a6ab300a ("NFC: port100: Commands mechanism implementation")
Suggested-by: Sven Van Asbroeck <thesven73@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/nfc/port100.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index 5ae61d7ebcfe..2483864806de 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -1618,6 +1618,8 @@ static void port100_disconnect(struct usb_interface *interface)
 	usb_kill_urb(dev->in_urb);
 	usb_kill_urb(dev->out_urb);
 
+	cancel_work_sync(&dev->cmd_complete_work);
+
 	usb_free_urb(dev->in_urb);
 	usb_free_urb(dev->out_urb);
 
-- 
2.34.1

