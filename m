Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0EE3EB7F4
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623695; cv=none; b=X124r5PVDc74p1DdZcySo+2y8H1avDaMxgMzs6Qitu/cJIkglszUeT4Zb++58UQZ9RsRCAKwTL1qIjTacGCCvQOMB5TRP//a5I6snlI3L83h+0WnNvU50kOgfKz1GJqOzMkGKOQxr2BEXfSQT8DwyErr9sacvIYgMsVMUhz/I5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623695; c=relaxed/simple;
	bh=lAM5b6+OIjaOvHNXh0hpCmmkd4xeYGS8UjTaFjairtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ssSqVVwAkbEWFbX1uDkFTX70kpgeQtZl8eRq11cqsJjXohIBZyGvB3nn3uoAAigXCZ1EjJVd/D9a/KFLvmulcZ6uHeO0W4jV3SAEDygWIBYQGAA2NVTIWKainOcJ2E8Q5RxMgzXRUpTOWVZzvBrRzhRM6iB9uzVjiiWRw42HXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=ucwiudbi; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="ucwiudbi"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35834f72d94so685458eec.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 02:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791623691; x=1792228491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2EcMVNGvoUCyg4a+/GXdBm3s3zoBcyX1bcILDBo8ZBg=;
        b=ucwiudbiuFPxoRgwOxXDuOEodDaDRSx0nyKbvf8B1qyGkgprdWK+hLbdTf3ZBKZTbm
         cYrMjHYIZnKEFk0gRt8cIpzI42i7hpxDEn8fky8NCfuQYaVIS6/CWyvn60uRXZ+kkbx/
         U5hteBAdhzeUt8bZrDfRZCi190f2PYWeAJhLI+IAEyxfCZVv8TUH0tGVGplVCA/KIrz8
         of/lGMGM0cziFRJ5Ah+ZgDOtr9V3xkOmXlWa8Y4isn3VoXg/RRpPivbHAta4hcUV0YYO
         jol9yIF7cepBduV2u6WtzxXeNOfjIGZVInXYB1xbU4jgWlXYkwIZwISOIrH8B8VbUJHE
         YU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791623691; x=1792228491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2EcMVNGvoUCyg4a+/GXdBm3s3zoBcyX1bcILDBo8ZBg=;
        b=PJG3awUp6vZBbLKCIPk2+ScNpl+jwayhaO/RGXdZusFCRqug8imc0BZZSa3vPkbmt3
         atKeAsIyLA+VebvXRALrBBGDuM/FqvUJZwUHD8n93Hc4kQnnVdifdqIY4GIXA8WQzMIb
         bD/8zHcdj+lOHfXNQXduWbKfxPIIbKcy95MdGhR/zzmt02T3a5NmTokbNmEVSpLaVuas
         zZx1eYNwxDWJoDFUApiiphrWQVqyOCP6e2mKS9FTj9pLSCBeKoPpPUrHbOqqUHJxrnRX
         bKnT3s2/oKQx0t4gA8oi7+c68Rnhoof2pc2XAhTSrCth9kCIM7zBkZrkr1KpOHP16w+T
         zeZw==
X-Forwarded-Encrypted: i=1; AKwUvBwvUsrYLh1/kriSIVARSvpW5CuayZEHXMzlKapNYRG0n+8fLmYqvNZQ+pf9uBwV7jKQZ5xCEMY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRg2DUqPBEL3FQBrABTEJ/72HrhQuakJR42rJ+THEiXkXSv+f4
	r1UsRwqpKBGZK7Sbz1Plm/FmCWVwgPgnKnj9XyilyoPKai7zSYBrsW17HSLpnLBOJ+w=
X-Gm-Gg: AYBFou3dMVC/xzoH594M0qfIuThdCP2cjej+kb1II761nkBOIUQ7YcmIe5AdzqUYkaK
	NIc8ReTFhCtiPmtHElHOAm75gTdB+G176RsXiPwlyHFm97UAL89gEHpA8zyanrpqXgUC/mDLbTt
	W1bXN+J0tAfnz7SeeYD5J0jc+nH3ykB35WIxGqyQYOEdtUO4X+ctbL6UBZIZjVSiedEuxiW77ej
	H20fqM6Xc7AwcaSxhCsljhVm0+yX7tRrnZ/1AjJah0X6tM3ja4Lut729SsH29LVBAlUc6smJOV3
	H9q1LZ2JJtp3uCY6CEoYrOmtBWUlwwGWzdHZh4JgniUDmjhwa/UGTlP5nVcd4GQN7G82bTnO8VT
	M9CJeOtIk8firQ2qdr/J/1PLZs5WAx594j+aYDWG9M4/bKsslG7TE5sqCzcJ2hTwhIhDl/iN6tk
	J7J5aaDBPrklmZ+ve9pqd4kV0vITjLlxcI/Fafn8n2ln90jSDxomYzUSjc4YwPb5s5B4+58VmUn
	YvnxL2G87FkZpO/oHRV/w==
X-Received: by 2002:a05:7300:8803:b0:351:735e:2ef8 with SMTP id 5a478bee46e88-3537df50e9dmr6407629eec.7.1791623691332;
        Sat, 10 Oct 2026 02:14:51 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c95f:28ac:324a:cdc3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b53dsm12287561eec.6.2026.10.10.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 02:14:50 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH] scsi: mptfusion: reject events with a MsgLength outside the reply frame
Date: Sat, 10 Oct 2026 18:14:32 +0900
Message-ID: <20261010091432.1788497-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptsas_event_process() sizes the event payload from the reply header:

      event_data_sz = ((reply->MsgLength * 4) -
          offsetof(EventNotificationReply_t, Data));

MsgLength is an 8-bit field chosen by the controller firmware and is not
validated on the way in; ProcessEventNotification() only looks at
EventDataLength. event_data_sz is a signed int but is then used as a
size_t in both the kzalloc() and the memcpy() that follow:

      fw_event = kzalloc(sizeof(*fw_event) + event_data_sz, GFP_ATOMIC);
      ...
      memcpy(fw_event->event_data, reply->Data, event_data_sz);

A MsgLength too small to cover the 28-byte reply header (MsgLength <= 6)
makes event_data_sz negative; it sign-extends to a huge size_t, so the
kzalloc() under-allocates and the memcpy() runs for ~2^64 bytes. A
MsgLength larger than the reply frame makes the memcpy() read past the
frame and leak up to ~940 bytes of the adjacent reply.

Reproduced under KASAN with a crafted EventNotificationReply (reply_sz
0x50); MsgLength 255 over-reads the frame, MsgLength 4 wraps the length:

  BUG: KASAN: slab-out-of-bounds in mptsas_event_process [mptsas]
  Read of size 992
   which belongs to the cache kmalloc-96 of size 96

  BUG: KASAN: out-of-bounds in mptsas_event_process [mptsas]
  Read of size 18446744073709551604

reply points at a fixed MPT_REPLY_FRAME_SIZE frame, so a valid event has
7 <= MsgLength <= ioc->reply_sz / 4. Compute event_data_sz before the
switch and drop the event when MsgLength is outside that range, as
mptsas_mgmt_done() and mptctl_reply() already bound it to ioc->reply_sz.
Doing it before the switch also keeps a dropped BROADCAST_PRIMITIVE from
leaving ioc->broadcast_aen_busy set.

Fixes: 3eb0822c6740 ("[SCSI] mpt fusion: Firmware event implementation using seperate WorkQueue")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/message/fusion/mptsas.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index c362f09a8c555..1812b871c47ef 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -5009,6 +5009,18 @@ mptsas_event_process(MPT_ADAPTER *ioc, EventNotificationReply_t *reply)
 		return 0;
 
 	delay = msecs_to_jiffies(1);
+
+	/* Bound the firmware-chosen MsgLength to the reply frame: too small
+	 * underflows event_data_sz, too large over-reads the copy.
+	 */
+	event_data_sz = ((reply->MsgLength * 4) -
+	    offsetof(EventNotificationReply_t, Data));
+	if (event_data_sz < 0 || reply->MsgLength * 4 > ioc->reply_sz) {
+		printk(MYIOC_s_WARN_FMT "%s: bad MsgLength %u\n",
+		       ioc->name, __func__, reply->MsgLength);
+		return 0;
+	}
+
 	switch (event) {
 	case MPI_EVENT_SAS_BROADCAST_PRIMITIVE:
 	{
@@ -5105,8 +5117,6 @@ mptsas_event_process(MPT_ADAPTER *ioc, EventNotificationReply_t *reply)
 		return 0;
 	}
 
-	event_data_sz = ((reply->MsgLength * 4) -
-	    offsetof(EventNotificationReply_t, Data));
 	fw_event = kzalloc(sizeof(*fw_event) + event_data_sz, GFP_ATOMIC);
 	if (!fw_event) {
 		printk(MYIOC_s_WARN_FMT "%s: failed at (line=%d)\n", ioc->name,
-- 
2.43.0

