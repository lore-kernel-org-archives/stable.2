Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771B1374E42
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483971; cv=none; b=lidXQ38hIE8nTi64z9wcvHjpvM44fFNGSksNTQgRL+CjxwMamCaWyeqLi3pUEBfZ6EjmfL0QzxHiBAFDr/AG1WHAyZXogZFzV38BvifhvVHEUIobTEURdIVWSJnAGxhnPoLtFQVHXO9a7II2aeWcPuQbzMhsGIaxsW0Wg7jS+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483971; c=relaxed/simple;
	bh=YhMG3fUk/XjIoLHujEEjCo8Xx/HTzgB3tQ6DnSl55zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjMq+wuTqBXGQW2KFfWue7gY3YoxfMU+fsJtOzbvnddLsoXZFINqDPgqDMsQaH/ahyuvHY5HmXEQMpniv9hNkpN6BZkTxz92KAb+1WS4B41m+Cw5vBzwXQZYINJ9/sjxSp9v4GE/2B7odNFBBWKTtsF1HiWx0F32idPZfqHxI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSIbLynl; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSIbLynl"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c7e8a176c1so1457694e0c.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789483968; x=1790088768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F87Nj6cbUlhN8QRz95TtuecHNAPdmCP6EjjN+M7wdxM=;
        b=MSIbLynlHZ8B6MpNrb7NQ6YMUvpug/Afg25eeHj/I7tIl0u2A2YF6P03IwZIz9vkKy
         5mdaHLXYsvZzkQ6SeKHbiQig+r2TSywFGB6Zy3nwqyeGrKndSxCjImmcc92bH/bRPpQb
         HF4VDGWwGmFkuO46L+8I5uyTKhI3TkyyQurPuQn+NzThChPDkEwY0QpC+w6bB59mSk0n
         Mfd5h/wD/kV8NipVGntbIy3tbkWgKsSf2KmZ2C/PMdXLLKQIK7XvI/ufyZv7rLSJ5wg0
         JKfjGDSzl91+zO5WiExCBP6QIf+H+ceypuQ4yIrnyPkNzxhDziDTMiesQUH1UtgaZy/N
         sZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789483968; x=1790088768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F87Nj6cbUlhN8QRz95TtuecHNAPdmCP6EjjN+M7wdxM=;
        b=guk4bsKrf9mqbeJpGT6TjlB2LojJ2WSVSZQtGuDVUhMNwOeZxGB5Si8ZHF24oWylRO
         O24KZn5PoTA07vBRWHwu/MFnZkYPcwE3jtShcbBbW3i4i2JLTW9vZU4ingE93bJW9QUG
         XLhV66o4FRLBjuHmrW98/et42dZzpRdTMAG0kvDHczrgAgNaeqzTb6d2swa/56gFQGwZ
         9Ak0GK7iDRWQ8Q101Vd4rZbp9jEbNyROAQEYllGvUCa60X+4TtvbyRLvSrnIqYxdZ04+
         SVkuboBboh7Ui4LblvXoJU8zWiI8h8Y7x/gA4+aMgCnkJlZ+vsE2vNCn/bDPDJ8sAAvU
         2VEw==
X-Forwarded-Encrypted: i=1; AKwUvBysFBBxRbYDbMwxRC2sFNDl4Wo2CmojuRrquBlTCVO198kXYZW2gU8Rd+3uk7hmJkE83bEWSZg=@vger.kernel.org
X-Gm-Message-State: AFuF++nDuVZRdQn1dn+9Xt3DCDg4cyfrpfMl0jFV4/AsV4CmhU+BLXS2
	705NEfpSARAO0XsIQmo/n06mqpFBpG61FPkz9sfW5Lqtywub25JHNpTUB+ZRsxNC5zM=
X-Gm-Gg: AYBFou2pv5oVJ7ultlu8j5mAQMN4EiQKptTMNGP/36lAkh58s4us3GMeUi3k7yzXAJh
	VSzVtKAXLZkaDx1+ScJJs4BcK3zL8H3aJRU02ibo7x7IfkmvtvNDm6xUM/CZMrOZmBdeU7/He5S
	AJsdDpCfcMOA8rm4JK70sXDl6JgOA+JzueOlM7iJXsoMrAWm9XTtumkvDbz0qPX39gUl63KvWNz
	D+41bl3Q7Ej/WMjJQ56APRCtrfzm0q2fWtMQ1cOgLbbPNbTI95VFQW/j2D1nXLbNxIw0lgynE6P
	ncp0AXb5E/Tzu7JA81BNj1pbSxXwG17omPoKSQM1LLptaWVGax7xVSVUEb2MbXAVsCGEhSDclcY
	2lfJ3CoOD+e052lKkmd+kJjTeQiEEh1FXP4Xt9BGeLLXMqM75NRQKxzv2Z9WfYBbWnax1S5clEx
	DPfvNA5vyeWKBinwCLS0kf2goR4QwsXIRigy9/KNtd0MRrLx4ofw5Y0zwtaxbfhkIZ
X-Received: by 2002:a05:6122:4f91:b0:5c6:58df:5826 with SMTP id 71dfb90a1353d-5c981d5fca1mr10648335e0c.5.1789483968151;
        Tue, 15 Sep 2026 07:52:48 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c84714c380sm15063108e0c.15.2026.09.15.07.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:52:47 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v3] HID: wacom: avoid overflows in sequence number tracking
Date: Tue, 15 Sep 2026 11:52:29 -0300
Message-ID: <20260915145229.3036596-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915111448.2726869-1-qwe.aldo@gmail.com>
References: <20260915111448.2726869-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dropped-packet calculation derives the sequence range in signed int
arithmetic. A sequence field whose logical range spans all 32-bit values
makes the range calculation wrap to zero, so the following modulo triggers
a divide exception.

Normalize the maximum and current value according to the HID parser's
signedness rule, and keep the sequence state and arithmetic in s64. Use
div64_s64() for the remainder to avoid __moddi3 link failures on 32-bit
architectures. This also avoids overflowing value + 1 at the logical
maximum.

Fixes: 359673ea3a20 ("HID: wacom: Support sequence numbers smaller than 16-bit")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---

Changes in v3:
  - Replace raw s64 modulo with div64_s64()-based remainder to avoid
    __moddi3 link failure on 32-bit architectures (i386, arm32).
    Reported by Sashiko AI review.

Changes in v2:
  - Normalize logical_maximum/value as unsigned when logical_minimum >= 0,
    matching HID parser signedness. Store sequence state as s64.
    Fixes unsigned 0..UINT32_MAX range that broke v1.

 drivers/hid/wacom_wac.c | 33 ++++++++++++++++++++++++---------
 drivers/hid/wacom_wac.h |  2 +-
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea856..af94f59a5d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -7,6 +7,7 @@
 #include "wacom.h"
 #include <linux/input/mt.h>
 #include <linux/jiffies.h>
+#include <linux/math64.h>

 /* resolution for penabled devices */
 #define WACOM_PL_RES		20
@@ -2527,18 +2528,33 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 	case WACOM_HID_WD_BARRELSWITCH3:
 		wacom_wac->hid_data.barrelswitch3 = value;
 		return;
-	case WACOM_HID_WD_SEQUENCENUMBER:
-		if (wacom_wac->hid_data.sequence_number != value &&
+	case WACOM_HID_WD_SEQUENCENUMBER: {
+		s64 sequence_minimum = field->logical_minimum;
+		s64 sequence_maximum = sequence_minimum < 0 ?
+			(s64)field->logical_maximum :
+			(s64)(u32)field->logical_maximum;
+		s64 sequence_value = sequence_minimum < 0 ?
+			(s64)value : (s64)(u32)value;
+
+		if (wacom_wac->hid_data.sequence_number != sequence_value &&
 		    wacom_wac->hid_data.sequence_number >= 0) {
-			int sequence_size = field->logical_maximum - field->logical_minimum + 1;
-			int drop_count = (value - wacom_wac->hid_data.sequence_number) % sequence_size;
-			hid_warn(hdev, "Dropped %d packets", drop_count);
+			s64 sequence_size = sequence_maximum -
+					    sequence_minimum + 1;
+			s64 drop_count = sequence_value -
+					 wacom_wac->hid_data.sequence_number;
+
+			drop_count -= div64_s64(drop_count, sequence_size) *
+				      sequence_size;
+			if (drop_count < 0)
+				drop_count += sequence_size;
+			hid_warn(hdev, "Dropped %lld packets",
+				 (long long)drop_count);
 		}
-		wacom_wac->hid_data.sequence_number = value + 1;
-		if (wacom_wac->hid_data.sequence_number > field->logical_maximum)
-			wacom_wac->hid_data.sequence_number = field->logical_minimum;
+		if (sequence_value >= sequence_maximum)
+			wacom_wac->hid_data.sequence_number = sequence_minimum;
+		else
+			wacom_wac->hid_data.sequence_number = sequence_value + 1;
 		return;
 	}
+	}

 	/* send pen events only when touch is up or forced out
 	 * or touch arbitration is off
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 126bec6e5c..74e7c5a04a 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -324,7 +324,7 @@ struct hid_data {
 	int bat_connected;
 	int ps_connected;
 	bool pad_input_event_flag;
-	int sequence_number;
+	s64 sequence_number;
 	ktime_t time_delayed;
 };

--
2.43.0
