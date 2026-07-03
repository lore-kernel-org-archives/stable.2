Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3D416D01
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091841; cv=none; b=RqHY9diD1UzVcF8yG78M5uoovxEK/P0wbsR8XWF2PNcLjPsr19z1LaymcaAlE9cbjE3bPluDv9oBsLLjBiNUb75OVjbEODEnHDgV7oM9xc9gD/Tu05Yu/tdx7YOlBHCDyNDf5bbM2skX3o9xHln4yjgpypBq06CkfJ1kTs8xgjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091841; c=relaxed/simple;
	bh=72x0DNJXcD5r3U1QyiCbruH5a/0EpHLWqt+m0uQv8Is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DQimfbuxsDA29db9dRmAoTalLGKOT7OvfNm8RLhW4nj5TrJe6/w0lhsOsdXn0Epzo+oB+gnnf99LAMwNphFrIQB6NiHu9mq7yvwxMsPWEpMGoKIt7J4GpSENiZ5fkRrAdqdtrqDIZ8qG8K+nXZzPcYlbNQ4S8YNTINBjw5+n33o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oHpgVRwq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHpgVRwq"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b8d99342so186785e9.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783091838; x=1783696638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xk5nWQTYsldtMRW9zLzMfODn+++NEGC3EIHM2mCJ+xM=;
        b=oHpgVRwqcmppPi/9q4Sf8t+iqzY4nHInld8yGAl6YWdfg/t1zR6BFOhcvk453Zobqw
         fDJRVFHof8WRP4fz8uuesu3cR/ZZwISH0JFCGI/nig0WIc8+blf0DGhGeVHxE9VrNT94
         ldthpjj8u6n9j3RrrfuBQK64J86zWM6YHEAZhSvUuo4DC4AbZryrZ1ZcDwfVSUhD6g6U
         Mbbm8OskO+Rrj0k48/AInEG5/m1142KEWDQ+/TG7bBFYHtEpCzW+Bw8XqXQ6D1OwMyx1
         tRiY3eZewrhIWdz/7xqN0YAFdBW8R4ZcUSvq4IGCH2jPyg/Vpez8oz3DP7FuasdCjGHh
         Hbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091838; x=1783696638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xk5nWQTYsldtMRW9zLzMfODn+++NEGC3EIHM2mCJ+xM=;
        b=DIY7TBCI/KcQ2tMIuIvbU29pXlewVDcKILDvJXhdJZIFcPUQFFoVH3TrUNNp9s+ctZ
         0U6lQaOTwqg6GUOHd4eVKFzWwEN05h99qgCuFAak/vXO3F4rsDtoj5ZiNHSBKvHsg2Kz
         Hm5/dvpkU9wABA4gJYAhmHoFsp1FTrkM6mm+2TLyDSKyboXTZUe+8yImIMXvtSmFeo2S
         jmpUsxQin77V+ciiX9UQS7Pb5ieCJAJp7azg088StfhQS248fRTYIOe4XINg3sU6kYXr
         /ruVWZa7NyD5QjdRZxEfH4eyNf9nUWoCaz4l5EMlAr9PeaBiDL8OiYLRgvMmhfX1RLE5
         RhMg==
X-Forwarded-Encrypted: i=1; AFNElJ9kqOIIOXWgqR7z+O6JBiSvA3wti+6q/rW3I1WFDckKB1BvjT8xzocL6NPJF0ZcCPi7HMZOnWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4E7pVFWf3vGCS7QTEdcfoLfeDP/SOpXPwej20iVDMpwhhMDt9
	hKMDqsJwJa3Ux8o1HUuDZj0rcBnyxaIEmHCoEfNPYmAJgK8YVSusDaae/b6oFWhE/g==
X-Gm-Gg: AfdE7cnVJXzFEappR/RiArZdv1+euUI31Ok3kc6O3O3z5adVpek9rW1oFfeqQCPyHVX
	+14EaK3rlbTrn82b6iqf/xenLiBYUeG8Uqt/x6jt4sgU16Ur0JdZ5WHh18Qoc6ahg0N6wEW0QK9
	IX5kfJZBt64aLi86RmWNOH0fWYsGR3hS4SDmbprysnHx2dEAzLcs5NzHVfGXO042AdCB7fB2zn9
	p32Jzgx9AhUgCec90ZJPo4UEEfDFzS8Hni5nyrULoS2K+45P0iWPJsiOVqyk2Xchi6PCdVzcT2t
	3LeVSFhsbXzrt4cjyTTcfYYeo9b7HrNC0cHfLabt+bb7D2n7axTW7hj49eNjpl7oTfi06Svqbiz
	O8Ayaw2qTjDGQNpOke0xmxM6TfVOlabm/8XzmMTD85IV0hSyZyxax25Za2je4HTvnaZFBo8kLLB
	yBQqgc+0ttbE4fAcHYEF5HRHSqGDiDAY9Yezpt2qG3Vb2CBMM3a3ktTRfzeaMq+CjJuJBN3tA=
X-Received: by 2002:a05:600c:791:b0:493:aed4:8d03 with SMTP id 5b1f17b1804b1-493d1047f09mr7765e9.9.1783091837691;
        Fri, 03 Jul 2026 08:17:17 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdb62d3sm65241445e9.8.2026.07.03.08.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:17:17 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 03 Jul 2026 17:16:49 +0200
Subject: [PATCH 3/3] HID: rapoo: fix missing hid_is_usb() check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-hid-usbcheck-v1-3-e80259ff625d@google.com>
References: <20260703-hid-usbcheck-v1-0-e80259ff625d@google.com>
In-Reply-To: <20260703-hid-usbcheck-v1-0-e80259ff625d@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Miao Li <limiao@kylinos.cn>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091826; l=1231;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=72x0DNJXcD5r3U1QyiCbruH5a/0EpHLWqt+m0uQv8Is=;
 b=UHqfAqA+nBILdUKR8Wt2ucHWqHmjpSKN5oWTt0sLfntQmW1lZIYCVUCx/OOYF/tNzG7C3W9Gb
 QRbvEydowKWBB+TeEH/mUekflp3F4xHbwtk8G7cLuUT2Z84WAWQn9uA
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

to_usb_interface() can only be used on a hid_device whose parent is really
USB; uhid can create devices that identify as being on BUS_USB, but don't
actually have a USB parent.
Fix the use of to_usb_interface() without a hid_is_usb() check.

I have verified that it is currently possible to trigger a kernel splat due
to this bug in an ASAN build, and that this commit fixes the issue.

Fixes: 00e005c952f7 ("hid-asus: check ROG Ally MCU version and warn")Fixes: b3b1c68fb726 ("HID: rapoo: Add support for side buttons on RAPOO 0x2015 mouse")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/hid/hid-rapoo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-rapoo.c b/drivers/hid/hid-rapoo.c
index 4c81f3086de4..5c9c396fabf7 100644
--- a/drivers/hid/hid-rapoo.c
+++ b/drivers/hid/hid-rapoo.c
@@ -36,7 +36,7 @@ static int rapoo_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	if (hdev->bus == BUS_USB) {
+	if (hid_is_usb(hdev)) {
 		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 
 		if (intf->cur_altsetting->desc.bInterfaceNumber != 1)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

