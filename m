Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=71.18.227.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629055;
	b=LAljM0y67NnFwp3ODngIXZgwSOzdjO69FsqhFw670i2SOGb34cgao1zXU7dWVw9vaoXP
	 Ue6uplZmACZ3aVQYKU7Rw9K7htvq+a8DXSsL9oHyEB8OiHM1VaCrqrYiQ+q2gg0yuCZ1/
	 dOLccJTxySlPJ2lb3Y78H99DEMgIGTR5hUwySa51mcfQc1KfDmVw0rFTQLPlT3tVgO9uu
	 7XzDCmoi8PLHU8ZU6NVpPi7W5y2IAKDlwIvK8UheGhM3By143MjWrcxkRQxgqyIBDWZkc
	 9NpdrQ/qQjKX1X4nVRRd6H8cs4x/tJG1XgL6YwgZ9qpkegq5bHuZ3m8smgrWMQmF98w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629055;
	h=DMARC-Filter:DKIM-Signature:Received:Content-Transfer-Encoding:
	 Subject:Date:Mime-Version:X-B4-Tracking:Cc:X-Change-Id:X-Mailer:
	 X-Lms-Return-Path:X-Original-From:Content-Type:To:From:Message-Id;
	bh=UETLk1dQekRKIibLsMQYa9UEIKc8XT6x173PcXv7ydk=;
	b=qUD9TApeY6RzObW0Z6w4q33eAXzDzkxg7LUeTIlaIRM0M9Txup47sviGjXB9btnVJGBL
	 I3VDPdgJTOTCH0bUCRQMAfsBNu5eJWb/6SyreZmgrrNZhXuRdD2TuYLsJa/R87Ld4bmTN
	 yfRPoUV28rIajD5uIeeMrc1IT5QgH/5Qnk5WChW9vn+uPpEbKdoCKTrNRitZ6A4S4tYWt
	 W8YzZBOqOb+ASMUdbMLi6nwvybsfYKP4atYudP6IXMFZ1UC8xvo1OGxn8Ejh55LoBj0OM
	 KKqhoYkdEoV+rFUUFQSYhdE4OldybMe0P9OZbxGwPyA/nFjng/CXVN2cv6skoIbXuvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cherr.cc;
	spf=pass smtp.mailfrom=cherr.cc;
	dkim=pass header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=JY0Q4JGk;
	arc=none smtp.remote-ip=71.18.227.2
Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25093606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25093606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=JY0Q4JGk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1793629040; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=UETLk1dQekRKIibLsMQYa9UEIKc8XT6x173PcXv7ydk=;
 b=JY0Q4JGkbzEoqaB5iqiyXIOHU6WLKEi2rncgK0ZIGJ7nGHZMghZxKeE7nVBtbdfrXkOjqK
 QlR+QRx0S2zaOkj9VfN5oIhpoJ4q11o09bYiUGjseJsMbhavExaRch6aMjRF5Tx1POtdLD
 +C6ggqPkXOuTu0mAEV0kJgj+qXxULtivKXfk0vPzcapaGh0VOmMKPeg5b6T/Fhkdmt0I+3
 /Qvd8IDzsQqS1NcoUKfdkkX08xXJQsmbOSzqCTCUgKpOm+MVd/fjbHCvvSj/jb/wCvj78/
 YuFbki68SXI9EuNOJhJDgB9l3C9cJcmfxg52qeUhB3YYATUdEwrd5j3kvDwBoQ==
Received: from [127.0.1.1] ([111.42.148.145]) by smtp.feishu.cn with ESMTPS; Mon, 02 Nov 2026 22:17:18 +0800
Content-Transfer-Encoding: 7bit
Subject: [PATCH v2] HID: pidff: fix undefined shift for infinite duration
Date: Mon, 02 Nov 2026 22:17:11 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGab6GoC/yXMQQqDQAyF4atI1gZ0iDJ4leLCcZIaF1YmYymId +/ULj947z/BOCkbDNUJid9q+toKXF3BvEzbk1FjMbjG9W3jPAbCXaMIxiNNuazRFpWMPgpJT11 L5KG898Sin7v8GP+2I6w8518OrusLASO2RHsAAAA=
Cc: <linux-input@vger.kernel.org>, <linux-usb@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
X-Change-Id: 20261028-b4-pidff-duration-shift-8df4f6451448
X-Mailer: b4 0.16.0
X-Lms-Return-Path: <lba+26ae89b6f+73fd85+vger.kernel.org+me@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Content-Type: text/plain; charset=UTF-8
To: =?utf-8?q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>, 
	"Oleg Makarenko" <oleg@makarenk.ooo>, "Jiri Kosina" <jikos@kernel.org>, 
	"Benjamin Tissoires" <bentiss@kernel.org>
From: "Shengzhuo Wei" <me@cherr.cc>
Message-Id: <20261102-b4-pidff-duration-shift-v2-1-83c5f8c67484@cherr.cc>

pidff_set_duration() computes the infinite duration as
(1U << report_size) - 1, but report_size comes from the device's
report descriptor and can be 32 or greater. This causes an undefined
shift. A UHID test on x86-64 triggers UBSAN and programs a 32-bit
duration field as zero instead of 0xffffffff.

For report sizes of 32 or more, store -1 in the s32 field value to
set all 32 bits without shifting. Keep the existing calculation for
smaller fields.

Fixes: 1a575044d516 ("HID: pidff: Compute INFINITE value instead of using hardcoded 0xffff")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
Changes in v2:
- Swap the branch order so the default operation is unguarded,
  as suggested by Tomasz in review.

v1: https://lore.kernel.org/r/20261028-b4-pidff-duration-shift-v1-1-65028c6b4a37@cherr.cc
---
 drivers/hid/usbhid/hid-pidff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 22951b7ecd17..50906890fdad 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -394,7 +394,9 @@ static void pidff_set_duration(struct pidff_usage *usage, u16 duration)
 {
 	/* PID defines INFINITE as the max possible value for duration field */
 	if (pidff_is_duration_infinite(duration)) {
-		usage->value[0] = (1U << usage->field->report_size) - 1;
+		usage->value[0] = -1;
+		if (usage->field->report_size < 32)
+			usage->value[0] = (1U << usage->field->report_size) - 1;
 		return;
 	}
 

---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20261028-b4-pidff-duration-shift-8df4f6451448

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>
