Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A143CF208
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052709; cv=none; b=JbFAncINNI/1zHo9xtNsidQsRxdorow1nflg7wcCh2+qKctlrOAL1AkthiLuLadZ9aZuh7yD04SAs45IuCgNRYxdq4ib79WUamE2jQD5NoNXPeJAoNqfCi9E9+J38seP/RT32Luh4r8BXXHf6jfWtEz8BnHeuGtsvKe2RpFeftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052709; c=relaxed/simple;
	bh=hBsP5eEDHNHagwaJe9v18Ny2Nwb2L1p/CxMZ7iJOKHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0FNkwm/fqqPFizkHT516XVvkpEoZufJyWJtGr/oYVc50HBHdmSUC1rrILQq4X4b9v9krkDdgtfQR9j7hEuMgOEMeWljIJEm5Mq9nMtj48HLj6OhCfmeHreKgAsYXFGiqhMzKzUSRYkkqPoQik0c51GPRsGMbMdo/AYfKydE8q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtCFLlhN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtCFLlhN"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso1581605a91.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784052708; x=1784657508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SRXfPs9aJXVj7efeegqyZcry94icAjp1/Aq1dXdDufk=;
        b=XtCFLlhNJaxLgrqIWjkZsJSg6Mwqc5pYdVeqLpJwzjyF4BZMuTacLHH2SWoSQhfabJ
         rsGI6u1fEtWRBpYNL9xhd60+IEl17PUYDCG9CmJg/0lWW/9ltgra9TfHWYjQ3eoH0d6p
         XLMIPNwfbUSxK9Tz+hrMJU/lmO4SLmhMYL4RDSlTx7M4ifMY3oA+aAy3shclSyz2mh9G
         o3u2wSCV0bfr5pun09UrBwDhVwGRUFCH8KVLcAp5FH4p8rKHoyTf0U3bDM/3EoAuBlsZ
         RSnExGQJtS8jMtYYP9XxrZMPTwSCaKs6FSV05AL2bY+myPTuGLQnwn+HG/olC74uqRI3
         yjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052708; x=1784657508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SRXfPs9aJXVj7efeegqyZcry94icAjp1/Aq1dXdDufk=;
        b=J17WdWUVZoRNFCz3v+dekkiZsdjyJfHFFYXsM917pDXrchKjULa7QMwOl+eAZYOcAD
         nbiIs8AmWvpafJQGL97tZJV/YCkkzUCvOllBCFtLwCRNqZVoj2JdZRTzW9hVfIEge4+k
         IhqTBWbdg28O61Olv+wrgSvWmL+zy/FgxBw0qI/hFKiDdpq2WAkqE5bCp/C1QBjOLbdD
         c+2ROQB7N2XOmV92NVc+SuuXZk5aHW0qsvK5XTmKCHRg8vkb+LZHoqs1h3k9d2HcCNn+
         G3e6lVIcGGLGXgCvCynayq5hAU8XAbkRoaUAGd2w/kEZNjV2d1MdEU2rkZOGwS3szm6P
         ALAA==
X-Forwarded-Encrypted: i=1; AHgh+RqezzeMj0jNO0ZLbpHIlewXWadxyAt9CEYT7Dey5xvsw26OYvUb5LKHA98M7Bl62MtBYDQ5Yv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0AwgE8h9Zqn66ld7EQXoC39wjfz0ZHTTnPdx7c2IUVipLJ5L
	mY0N0uE8JG4PdetNoXkAfRKnbjbtJ0amiH7wGllIqG1aZI42LpkhY+DvrvouFnyP
X-Gm-Gg: AfdE7cnCTUzunc+kxyKDPhEYybSQIEQ4Zc9wLHgDDxqdqwyMS28HTVs+QyMLKgK1Wg9
	8quBc41hKgB+BMaXYWxzyRgTeDY089qwcFg6g8gZIGc/LY6AqqyVZQboinjD274vLASV2WGTrBH
	t6dhBwq2EJBmNit/9XH1ZASqJ0/wL2G/heFLvAY02rxYEu8pzHDBmeE1DeAg4DJfplsgax3a7Bg
	lS3OQ9j9VxWM2bvgSh2QNiUQDZr+OSqHqtjAY692b/DRQGNCPukQMuSsg1SpSOSQyGkAxpBSBEJ
	CqDJjJmnzHLeLraB+2cqvPkEFSOO3KwpvSJtKxlka9wIicRJQwDJjSpS0qxtr/fXpffg5KztiEk
	CLZIgXywVPwbKrPllSqbmOkC7sdiZPzV91Br+RD8Ri6z7K1mxAh1aHrliOpnXrvLAsCGu6HVOUs
	Eqms7o+fUe+D83vsfO
X-Received: by 2002:a17:90b:4990:b0:366:52fe:e749 with SMTP id 98e67ed59e1d1-38dc73beb6dmr14747011a91.5.1784052707688;
        Tue, 14 Jul 2026 11:11:47 -0700 (PDT)
Received: from nixos ([2001:579:62a8:47:3869:b665:31a3:e072])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6080dsm62416288eec.17.2026.07.14.11.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:11:47 -0700 (PDT)
From: Jay Vadayath <jkrshnmenon@gmail.com>
To: gregkh@linuxfoundation.org,
	johan@kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jay Vadayath <jkrshnmenon@gmail.com>,
	stable@vger.kernel.org,
	Lukas Dresel <lukas@artiphishell.com>
Subject: [PATCH] USB: serial: sierra: fix slab out-of-bounds read in sierra_instat_callback
Date: Tue, 14 Jul 2026 11:11:42 -0700
Message-ID: <20260714181142.10976-1-jkrshnmenon@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <https://lore.kernel.org/all/2026071453-reminder-ageless-dcea@gregkh/>
References: <https://lore.kernel.org/all/2026071453-reminder-ageless-dcea@gregkh/>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt-in URB buffer is allocated based on the endpoint's
wMaxPacketSize. A device declaring wMaxPacketSize == 8 gets an 8-byte
buffer from kmalloc-8. When such a device delivers a short packet,
sierra_instat_callback() still dereferences transfer_buffer as struct
usb_ctrlrequest and reads a further byte at data[sizeof(*req_pkt)], one
byte past the end of the allocation.

Reject the URB when fewer than sizeof(struct usb_ctrlrequest) + 1 bytes
were received.

Cc: stable@vger.kernel.org
Reported-by: Jay Vadayath <jkrshnmenon@gmail.com>
Reported-by: Lukas Dresel <lukas@artiphishell.com>
Signed-off-by: Jay Vadayath <jkrshnmenon@gmail.com>
---
Apologies for the wall of text in the original mail. I wanted to include
the artifacts inline so the bug could be independently verified. Just the
patch this time.

Same shape of fix as Jiale Yao's option.c patch:
https://lore.kernel.org/all/20260712170012.3503601-1-yaojiale02@163.com/

Tested with the reproducer against v7.2-rc3. The KASAN splat does not
appear with the patch applied.

 drivers/usb/serial/sierra.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 6e443aacae07..4c6e7120695e 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -575,6 +575,13 @@ static void sierra_instat_callback(struct urb *urb)
 				__func__);
 			return;
 		}
+
+		if (urb->actual_length < sizeof(struct usb_ctrlrequest) + 1) {
+			dev_dbg(&port->dev, "%s: short interrupt transfer: %d bytes\n",
+				__func__, urb->actual_length);
+			return;
+		}
+
 		if ((req_pkt->bRequestType == 0xA1) &&
 				(req_pkt->bRequest == 0x20)) {
 			int old_dcd_state;
--
2.51.2
