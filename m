Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5C3876C3
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787599243; cv=none; b=T2W7EBj/UadKV2ZgfMSoN0QoVokf/bVtRjIR4bUbMQ7GLlhY91YaID66sPqznyBPZ54bFpzBZYqR32awhzIdebNoemkOkiIxG3f4DnkFtjUAoGD21y7M6m7PRwEqgzQNGzYLN5tQMNgFFi3lTddigaz4UUbRNgIbiFqienbhnt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787599243; c=relaxed/simple;
	bh=SE6RYF4RgqjvqxfmIETCl0Y+EcovjINzHj0ntk3zKQU=;
	h=Message-Id:Mime-Version:Content-Type:Cc:To:From:Subject:Date; b=OH3vzS7c56aQJjdBqFNzv4wIAgg/ceZuqCJQGjvaL3XyJgOaAYFxF4Ut80i4qe6E9WQDgBErqnJRwr2jmsPMJYDJRoX/D96yeLrfoTBrY7khJWLoJkuBEOy6NMgQ23XRwx2WbPk31gGqvoaNsQcMyOx+v4kGkB3z53I2JWUL3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=RsRhVuSY; arc=none smtp.client-ip=71.18.227.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="RsRhVuSY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787599222; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=eDOkDSGQUi9t79Z89S+frzk+NZ5ly+DCESN3SLosnUE=;
 b=RsRhVuSY/eQGF48jLbLsfhUf5snDwN8BNoaBGhnX70mhfycr8ynN+P8KhwbpJ6oXOdg01K
 TfnRRtCqpAQeqUcPzwb9El6c+118SbI/TjrdhHaxjhJ7t4GmSwRq4TDjPWQlDxB0SCFV4H
 SzL4xZqncxXsYGAgeaep39MIYgKcYDqKgQXHoHSD85Nap5KjxP3z+jUqmVY32vxRBlOhnc
 RVJyG6tTD8OTWcMFIY6na2+k8+YdKAGRrZTzWVCOGgmWf5XRLZJhG/TjZOfNxiTQoDSRui
 FTDjIY0t+IwrKmAjwObF4wEcq0Q7qjbYh0CX2VRrQbbED/rDkOZmRENPq4GJ3A==
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Message-Id: <20260825-ttusb-dec-overflow-v2-1-4d1263c03dff@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Change-Id: 20260825-ttusb-dec-overflow-0d1f7fc2e308
Received: from [192.168.9.107] ([111.42.148.146]) by smtp.feishu.cn with ESMTPS; Tue, 25 Aug 2026 03:20:20 +0800
X-B4-Tracking: v=1; b=H4sIAHCZjGoC/32NQQ7CIBREr9L8tRhAocSV9zBdCHyExBTzqahpu LvYA5hZvUnmzQoFKWGB07ACYU0l5bmD3A3g4nW+IUu+M0guNTdSsWV5Fss8OpYrUrjnF+NehDE 4iQduoA8fhCG9N+ll6hxTWTJ9to8qfu1fXRWsx2ql7FGrUZizi0i0dw6m1toXHZKF0bMAAAA=
Content-Type: text/plain; charset=UTF-8
Cc: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Seungjin Bae" <eeodqql09@gmail.com>, 
	"Pengpeng Hou" <pengpeng@iscas.ac.cn>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a8c9974+f41955+vger.kernel.org+me@cherr.cc>
To: "Mauro Carvalho Chehab" <mchehab@kernel.org>
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH v2] media: ttusb-dec: reject oversized packet lengths
Date: Tue, 25 Aug 2026 03:20:17 +0800

ttusb_dec_process_urb_frame() derives the packet payload length from
the PVA/SECTION header, up to 8 + 0xffff = 65543 bytes, and uses it in
the bulk-copy state to memcpy() into dec->packet[], a fixed 6148-byte
buffer. A malicious or faulty Technotrend TT-USB DEC device can
therefore drive a heap out-of-bounds write of up to ~59 KB past the
buffer, over function pointers in struct ttusb_dec and adjacent
allocations. The only existing length check, in ttusb_dec_process_pva(),
runs after the bulk copy, too late to help.

Reject the packet in the header state, as soon as the advertised length
is known and before any bulk copy. Both PVA and section packets are
covered, and the check leaves room for the up-to-five bytes appended
after the payload (4-byte trailer plus one padding byte for odd-sized
section payloads).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Seungjin Bae <eeodqql09@gmail.com>
Closes: https://lore.kernel.org/linux-media/20251230195041.36768-2-eeodqql09@gmail.com/
Reported-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Closes: https://lore.kernel.org/linux-media/20260402112800.39716-1-pengpeng@iscas.ac.cn/
Assisted-by: GLM:5.3
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
This bug was previously reported and fixes were posted in Dec 2025 and
Mar 2026 but did not receive any maintainer response; it is still
present in master. This version also rejects section packets (not just
PVA) and accounts for the post-payload trailer, which earlier attempts
missed.

Verified with KASAN: without the check, a crafted packet yields
"BUG: KASAN: slab-out-of-bounds ... Write of size 65535"; with the
check, the packet is rejected and no overflow occurs.

Changes in v2:
- The v1 mail carried a corrupted diff (a "\n" in the dev_warn string
  was expanded into a literal newline), so the patch did not apply.
  Resend with no other changes.
---
 drivers/media/usb/ttusb-dec/ttusb_dec.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/ttusb-dec/ttusb_dec.c b/drivers/media/usb/ttusb-dec/ttusb_dec.c
index 825a3875989d32ddbb65589f7015acee96a44c9e..58628846d9e23b225c9939784bcbae7825642fdd 100644
--- a/drivers/media/usb/ttusb-dec/ttusb_dec.c
+++ b/drivers/media/usb/ttusb-dec/ttusb_dec.c
@@ -700,23 +700,33 @@ static void ttusb_dec_process_urb_frame(struct ttusb_dec *dec, u8 *b,
 
 		case 5:
 			dec->packet[dec->packet_length++] = *b++;
+			length--;
 
 			if (dec->packet_type == TTUSB_DEC_PACKET_PVA &&
 			    dec->packet_length == 8) {
-				dec->packet_state++;
 				dec->packet_payload_length = 8 +
 					(dec->packet[6] << 8) +
 					dec->packet[7];
 			} else if (dec->packet_type ==
 					TTUSB_DEC_PACKET_SECTION &&
 				   dec->packet_length == 5) {
-				dec->packet_state++;
 				dec->packet_payload_length = 5 +
 					((dec->packet[3] & 0x0f) << 8) +
 					dec->packet[4];
+			} else {
+				break;
+			}
+
+			if (dec->packet_payload_length + 5 >
+			    sizeof(dec->packet)) {
+				dev_warn_ratelimited(&dec->udev->dev,
+						     "%s: packet too long - discarding\n",
+						     __func__);
+				dec->packet_state = 0;
+			} else {
+				dec->packet_state++;
 			}
 
-			length--;
 			break;
 
 		case 6: {

---
base-commit: 66fb95a521110da673090294561844c9f76ebe64
change-id: 20260825-ttusb-dec-overflow-0d1f7fc2e308

Best regards,
-- 
Shengzhuo Wei <me@cherr.cc>
