Received: from sg-2-1.ptr.blmpb.com (sg-2-1.ptr.blmpb.com [71.18.227.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888D02F7F07
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598587; cv=none; b=g0GqZOX4Anf4s+nq4B65Y0W8sTCks51T4eBnCViS3x1k8Wm+s1Kh/1DQ7pYMZhuIb5RyqCbpRL5OJiSzQPMmbfafZf9/DWppObdOoVMUbvo1Bj5Iwo4hNDcGqfiIt6B1OidnrJdnn6v6nqbL0v4OedMSD0FNqjvN36oIdilFqLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598587; c=relaxed/simple;
	bh=6aqCyFLQBZesmvBWX1W46oCQO6Jf+ui1R/iiFYIua9Y=;
	h=Cc:Content-Type:From:Message-Id:Mime-Version:Date:To:Subject; b=E8QdnXk3uFeUGONm9VbLyKPEdWvABO7mgvTEOXy7QZf502gCwDVit95hsBpAtF/qffIJpOlZUyzs+WdHiKjwcEAScSoz/UziZrXhawP2GQJp+u0smpY4MZSym9F2a/nz8E++He8b5kA0kUMjMzJxYFQr6IJ22iF1KkCZG7czrdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=viMpvSLL; arc=none smtp.client-ip=71.18.227.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="viMpvSLL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787598578; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=nAyowMZq96i6Smr40pLaOJtQSkR5kjC0c4zymu8KcV0=;
 b=viMpvSLLtYDLAVq+iFgkYH41k5LxIGdEho2zpAiu83aNe0VELc54AGBfgrkqJNn+WB+yws
 9Ni6ovY3h3WtraD1CQOJl7fL0F6v+8Rj0DseJJTpKHeiihjR9VpuSnbs+jLKKSPcL2MjTz
 AVRW8yP7R3qKOhRm3dA9+ri+egUt/cBQ5OUqpPwOVmim0/nRg6WuCF9CHbq2ixDAB8yX+A
 2nke06qv3vb7RTGe9+IqprR3pKGKZJ/cYCQ52H9XRdH0jlRzlkVPwUx/HjRlK6il2ZCdLH
 DYlqgeOcU2d7/wvq4ympVL22J5TC+0Pk7pd6pOqckcN0jaXEunWv1qJdpmd7YA==
Cc: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Seungjin Bae" <eeodqql09@gmail.com>, 
	"Pengpeng Hou" <pengpeng@iscas.ac.cn>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a8c96f0+8ffd18+vger.kernel.org+me@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Message-Id: <20260825-ttusb-dec-overflow-v1-1-1b655b465718@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 25 Aug 2026 03:09:30 +0800
X-B4-Tracking: v=1; b=H4sIAOmWjGoC/x3MQQqAIBBA0avErBswo5KuEi1KxxoIDS0LorsnL d/i/wciBaYIffFAoMSRvcuoygL0OrmFkE02SCFboWSDx3HGGQ1p9ImC3fyFwlS2s1pSLRTkcA9 k+f6nw/i+Hyd7Y79kAAAA
X-Mailer: b4 0.14.2
X-Change-Id: 20260825-ttusb-dec-overflow-0d1f7fc2e308
To: "Mauro Carvalho Chehab" <mchehab@kernel.org>
Subject: [PATCH] media: ttusb-dec: reject oversized packet lengths
Content-Transfer-Encoding: 7bit
Received: from [192.168.9.107] ([111.42.148.195]) by smtp.feishu.cn with ESMTPS; Tue, 25 Aug 2026 03:09:35 +0800

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
---
 drivers/media/usb/ttusb-dec/ttusb_dec.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/ttusb-dec/ttusb_dec.c b/drivers/media/usb/ttusb-dec/ttusb_dec.c
index 825a3875989d32ddbb65589f7015acee96a44c9e..bbdee2c1604c424f8452e5a8fdde8ecd85d23fe0 100644
--- a/drivers/media/usb/ttusb-dec/ttusb_dec.c
+++ b/drivers/media/usb/ttusb-dec/ttusb_dec.c
@@ -700,23 +700,34 @@ static void ttusb_dec_process_urb_frame(struct ttusb_dec *dec, u8 *b,
 
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
+						     "%s: packet too long - discarding
+",
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
