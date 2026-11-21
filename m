Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795281835;
	b=PFPFani9QXtzW53iw0xehvUWCqjnqWSy9m/3wQhtqzYFNUrtbtyMMCKHAgKk32bxuAYj
	 xbb4irFNMOjTeu4eSxAr0XcQICzqpB75kjb5sRrbwlN0/UEa1vUWkCzDwv43xgmhEWUv4
	 XiyJ0gdwY7RVEfb26mNl7bhlSo/IMObbeJZQCbHOQVD4GTLg8VjmShb+LnsXQAOnVlFhy
	 EP3O9R6CQQ2+uvD95r6q0ubmWIzrhc3U66Mqv1UYRWQ+5SGQP1KF6sC4uCHyUl4bm+nuw
	 5DdHf8EzWK7LIfchPKLeEviee7FroRrkqyULQfEEspnqlhhbnx7faMcZk1TH34mMrug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795281835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DoN+jG5Rec1QoyXW9HZrwy95eguN461fzv/CVFtCCEg=;
	b=5q8EoevHzTAbOhYOZk4rz285oDSTNmJS9zPCDmkJr+IW7aGzUuuVRwljwPyaVP7sH/yB
	 /R4EeYxcw3YK1gOqBGJaZT5SQL9MB9prnJjnsu3C5dGY75tRJHZvukyEdJ8vNapx90BRZ
	 GDkkyTzXhvBbWa1RcNOeDoYLX/PHgFgmnsfLQZ1Qicbk18Bsc4r1ZexPxyXx9pXulrIYl
	 g0TMXZHxZQCeNgES6vppj9OOWrGG/WYhXqV9qMNJdJcfNWRlzRif0lgMfp0dnmVbNLuIO
	 DeW4680IMGKQb1XV/D9xuXr8EohbrKioR3R19pOIH2z/m5EK4uPwN4lidQt/BeVvcVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F3gb6nun;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E991606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 17:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E991606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F3gb6nun
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so18935935e9.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 09:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795281834; x=1795886634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DoN+jG5Rec1QoyXW9HZrwy95eguN461fzv/CVFtCCEg=;
        b=F3gb6nunfOxohpA7FVOv6KfnszdYpDb9WP82vTw19QrSAAmnQG3pE0GqjqKbDi9k0H
         jUZFucmuBDSwmrthhIWCCjB7a+zhwww4n4cZ5w95TW7bwOeUAjNNHywm1DZE//YGUaCm
         d8GX9lZ2n39RKAlgNP81zHrRvwc62Ywo41UBMAHgZ3JG5xkSsZFCjxJP+7BLC5hQaiA/
         35GR6GwEKWOc2+UOM1HikHRfMwohnsH6GNNtycB1iyGXr2L12nerQIeDyU/0mnvQ7Iz0
         q1BHqsxkxOzpeIARsvVKxc2GIFQp7HJHwGxgkrDfloOQ1t/kt1zrQEhnwHySTm1wOW6j
         RUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795281834; x=1795886634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DoN+jG5Rec1QoyXW9HZrwy95eguN461fzv/CVFtCCEg=;
        b=Yr1laRTAvxX8I6PGorjXR/FFS7T3mPjdRGPjWGsGZ5jxR58l5BeAUVbfb1E3eV2Kdj
         JI+h3LrAPlZ2VmI/Pv2I2DoqwOlq9jJ0Lj/cZ90kX6qkD5RBzKQyGwoLusymsnndlM2C
         FEj80G37DeU34+ZhH/w/7cKcsrwVSZfuTBtAOV9vEx0vEl+sA2YGF4+cfQYMMGTEykyL
         Dc8jtuDx6/naFxpQN12+cJkSkeboEGma1zUmmzMUvicXF/mzy2QQhG61070h7p0M5Vex
         iQ+l8HyeA5Mc+tOCQ2ePCdX1c7CwwUPezrwYQgNLidPGb/qwx4FmMmUl64hVVrkgQvc0
         4UsA==
X-Forwarded-Encrypted: i=1; AL+hErFiKF7gIQeHU/OWSoUGEKCqQH6WtQPcC5yk1UyARqVz8eVrxEZU9olSNt+YmXPQ0Dpqa/Uh4p8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uzD01YYbQ5fOTkSgF0YVLSUgh3KxBUV2tcJhCZcUXxM3QyfrT
	Y6lgduQlw0Va27C/A7JxiUGJ2AAOFDqunnZC0iRXerXMVued0lTK9J0W
X-Gm-Gg: AZFdTZfXVHtbfu5rZhMetXfDBIhZ1YtaXmQhQsnaphS8nOXoqPZhWHK3C7XSzRdIFSt
	txlpG1RQYaPSwD7cSTwTJ4kM0mMMiTxGv15wJu2fu/XPzmb8RkKIQSqQ9VF2yGM2qLMcg3v9Kpy
	APmxVUU0CzIcRP0t9ZCCw8EKq4Fm5ROeCsHXCUQKmhbMEuOJ7W0YeS/7WmSylblZP/wJ7T8uWDC
	ti5s0ISM6QtLCmVgM0vThEB0Hx00xgDgobcVvyUgOAoGr5zXSiAknyEPufBv8M/IiEMav323L0P
	MYfle9yevQTn1tVcAJ38Ogp3MlU3v7CHMztUAaT7zjPvkuYuwf9x3LETV1ffoyEPlKAhArQJ4cg
	Vw9HwaCQPJmdR9+SFi3uQ+3LTtmEu8lY6sYdwyofph+x/2dQnhqqmTBSe2eaW2i8W5kMR1BcnHC
	iPRAkyhWf4XckDJIosxfdGnChiwPd4m6y+Jc7S4znSWn3K+O/WXsRthxFzo7+d3ICgxrmT4uPtp
	LvRbAzDa3j7cmKaFKsDIMSTQ1ohyUNu1gLefAhvRUb9OUBC7wqmB+91lXdcjS3IsQHwuyQ1h1li
	WuWbHpRjnxf4tRn9EP4+SKwtjCyButkE9WAoJmYifOdKXjjd8V3ptCLR3WcMmRCxxATAmu+m86d
	W
X-Received: by 2002:a05:600c:8b5c:b0:4bb:741d:ea0 with SMTP id 5b1f17b1804b1-4bb8880f621mr154274825e9.17.1795281833492;
        Sat, 21 Nov 2026 09:23:53 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([37.111.157.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm207307265e9.5.2026.11.21.09.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:23:53 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shichao Lai <shichaorai@gmail.com>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	syzbot+dc208a8cf8d37cf3e5ac@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: [PATCH] usb-storage: alauda: track media_initialized per port
Date: Sat, 21 Nov 2026 22:19:56 +0500
Message-ID: <20261121171956.1455-1-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Commit 16637fea001a ("usb-storage: alauda: Check whether the media is
initialized") added a media_initialized flag to struct alauda_info to
prevent divide-by-zero errors when alauda_init_media() has not succeeded.

However, Alauda devices expose two LUNs (us->max_lun = 1) backed by
info->port[0] (xD) and info->port[1] (SmartMedia). Storing
media_initialized in struct alauda_info shares it across both ports: once
port 0 initializes, media_initialized becomes true, allowing port 1 to
skip alauda_init_media() when its media-change bit is clear and divide by
port[1].uzonesize == 0 in alauda_read_data() or alauda_write_lba():

  Oops: divide error: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:alauda_read_data drivers/usb/storage/alauda.c:953 [inline]
  RIP: 0010:alauda_transport+0xe5a/0x35c0 drivers/usb/storage/alauda.c:1187

Additionally, alauda_check_media() never cleared media_initialized when
media was removed or before re-initializing on media change, leaving it
true if a subsequent re-initialization failed.

Move media_initialized into struct alauda_media_info so each port tracks
its own initialization state, and clear it when media is absent or before
re-initializing on media change.

Reported-by: syzbot+dc208a8cf8d37cf3e5ac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dc208a8cf8d37cf3e5ac
Fixes: 16637fea001a ("usb-storage: alauda: Check whether the media is initialized")
Cc: stable@vger.kernel.org
Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>
---
 drivers/usb/storage/alauda.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 5e7f99ba8..5493f25a7 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -96,6 +96,8 @@ struct alauda_media_info {
 
 	u16 **lba_to_pba;		/* logical to physical block map */
 	u16 **pba_to_lba;		/* physical to logical block map */
+
+	bool media_initialized;
 };
 
 struct alauda_info {
@@ -105,8 +107,6 @@ struct alauda_info {
 	unsigned char sense_key;
 	unsigned long sense_asc;	/* additional sense code */
 	unsigned long sense_ascq;	/* additional sense code qualifier */
-
-	bool media_initialized;
 };
 
 #define short_pack(lsb,msb) ( ((u16)(lsb)) | ( ((u16)(msb))<<8 ) )
@@ -471,6 +471,7 @@ static int alauda_check_media(struct us_data *us)
 		|| ((status[1] & 0x01) == 0)) {
 		usb_stor_dbg(us, "No media, or door open\n");
 		alauda_free_maps(&MEDIA_INFO(us));
+		MEDIA_INFO(us).media_initialized = false;
 		info->sense_key = 0x02;
 		info->sense_asc = 0x3A;
 		info->sense_ascq = 0x00;
@@ -478,12 +479,13 @@ static int alauda_check_media(struct us_data *us)
 	}
 
 	/* Check for media change */
-	if (status[0] & 0x08 || !info->media_initialized) {
+	if (status[0] & 0x08 || !MEDIA_INFO(us).media_initialized) {
 		usb_stor_dbg(us, "Media change detected\n");
 		alauda_free_maps(&MEDIA_INFO(us));
+		MEDIA_INFO(us).media_initialized = false;
 		rc = alauda_init_media(us);
 		if (rc == USB_STOR_TRANSPORT_GOOD)
-			info->media_initialized = true;
+			MEDIA_INFO(us).media_initialized = true;
 		info->sense_key = UNIT_ATTENTION;
 		info->sense_asc = 0x28;
 		info->sense_ascq = 0x00;
-- 
2.53.0

