Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=71.18.227.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633001;
	b=i+WeI3T1UXgAn6ROnhj70wWoN8vRTazt1tbSenbanpSSjgy58YqCNowXbK7vyXsCejKs
	 Y1EbGFiZ+9r/rZhzcI47CbU7Ith6kyG+PufHemNbgGi6jmFwkr6RiIgc5swdb53TX8v8n
	 y6yT3RtFhxqk9lpfvw4Qm6ivXM8omWwgoKhL/dVu+Rnz/v+tqOBTOZQgVE8Ngy8P+HyIk
	 wjaw6BbOMrlsFwwPinel73q2Cgxz4/usVoDNUdqr7PZxcPRA2nLwY2aVVKkpmMWVSv1OU
	 d4aZnR++ircd9jvr6Xg8radLlDL2Nd8AbrT74u54bzPQS2ifcHolQi06lV+JsB+PzRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633001;
	h=DMARC-Filter:DKIM-Signature:Content-Type:To:From:Subject:Message-Id:
	 Mime-Version:X-Original-From:X-Lms-Return-Path:X-B4-Tracking:Cc:Date:
	 Received:Content-Transfer-Encoding:X-Mailer:X-Change-Id;
	bh=guPZvxLd6vY90xPInQ08JAkLKvg/HCQkXV27YDibAYk=;
	b=ZbB3qVKryPsJq3mgnkrPYiZccrYQk9eDR2Ctt/Nlclb/Z1g4tc1avRMpbNZjK/kEe7HC
	 QtTPLmf8fCzXwnAza1ozgrmzJj+4y72EZKJwKdtcNYDXwbSiZVxMpUmiyGb69JlcUQZ/1
	 8jxPUwR/e+A3Apo8wvoPP+XDZKoEAihw3SJHpdfr3+51euaWk63bZjWiKksDyNel1Zp+l
	 gV6fM5TLhzIeFzoFxkzNYmcf29X/06mz0+uovPaDH2Ypa/X9iDZedTI70gBjrA/SFQgeL
	 1LWx4lRehjWHhOIYIKP+gNxKQ9nx7ADjB5EuJBVLchayUXEbrEVuf1TKuSm7yid3cvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cherr.cc;
	spf=pass smtp.mailfrom=cherr.cc;
	dkim=pass header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=jIBlJPg6;
	arc=none smtp.remote-ip=71.18.227.1
Received: from sg-2-1.ptr.blmpb.com (sg-2-1.ptr.blmpb.com [71.18.227.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E594760A382C
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E594760A382C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=jIBlJPg6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1793632994; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=guPZvxLd6vY90xPInQ08JAkLKvg/HCQkXV27YDibAYk=;
 b=jIBlJPg68+S19w6K78CKfhTx1Bc6Oh3IhTAOVAUM6UgTTsjhcHe8jaP24ir3SvriymBxZe
 zsAA2PKmgUsjiTFd/EPJVWru5uAVDa1mZrDj8GuTU6rdkP25V8ycfIVsle1YwBV/AxPL2b
 mSt8AyGqulhhZHNlqDvMQ7n9fhy9qEawGiK1a1vdD022ZBGA0Qdq0Q4mvz/OCefihPZGHi
 7QyFAOyGe5lw+1Cx1D3E8NJb3VkNtQV10eDPkoMjNofBadkljpRS0GBtAC+x0Bffz2NFx1
 Zo5lzG1Gw/Jm3kbc0SSF9w4eGwTzgkyFgXGgjfX7wT0AUAzg9MVMroObPFCB+w==
Content-Type: text/plain; charset=UTF-8
To: =?utf-8?q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>, 
	"Oleg Makarenko" <oleg@makarenk.ooo>, "Jiri Kosina" <jikos@kernel.org>, 
	"Benjamin Tissoires" <bentiss@kernel.org>, 
	=?utf-8?q?Micha=C5=82_Kope=C4=87?= <michal@nozomi.space>, 
	"Paul Dino Jones" <paul@spacefreak18.xyz>
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH v2] HID: pidff: bound the unit exponent rescaling loop
Message-Id: <20261102-b4-pidff-rescale-exponent-v2-1-a75bcca65fd0@cherr.cc>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+26ae8aae0+3d8e8a+vger.kernel.org+me@cherr.cc>
X-B4-Tracking: v=1; b=H4sIANuq6GoC/yXMQQrCMBBG4auUWTvQDLUUryIu2uSPjkgaMq0US u9u1OW3eG8nQ1EYXZqdCt5qOqcKOTXkH2O6gzVUk7TSu1YGnjrOGmLkAvPjC4wtzwlpYRfOvoO 4AX2g2ueCqNvvfb39bev0hF++QzqOD8/8BhF9AAAA
Cc: <linux-input@vger.kernel.org>, <linux-usb@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Date: Mon, 02 Nov 2026 23:23:08 +0800
Received: from [127.0.1.1] ([111.42.148.29]) by smtp.feishu.cn with ESMTPS; Mon, 02 Nov 2026 23:23:12 +0800
Content-Transfer-Encoding: quoted-printable
X-Mailer: b4 0.16.0
X-Change-Id: 20261028-b4-pidff-rescale-exponent-1d5c4e218e6d

pidff_rescale_time() walks the device-provided unit exponent one step
at a time, allowing extreme values to cause billions of iterations
while ff->mutex is held. In a UHID test with an INT_MIN exponent,
EVIOCSFF took 3.1 to 4.3 seconds to upload a finite-duration effect.

Stop rescaling once scaled_time becomes zero, since further
multiplication or division by 10 cannot change the result. The u32
value becomes zero within 32 multiplications by 10, and the u16
input within 5 divisions. This bounds the loops while preserving
their results for all exponents, including wraparound.

Also warn during initialization if the duration field's unit exponent
is outside the range -8 to 0. This helps identify unusual device
descriptors without logging on every effect upload or changing the
rescaling result.

Fixes: 8713107221a8 ("HID: pidff: Rescale time values to match field units"=
)
Reviewed-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
v1: https://lore.kernel.org/r/20261029-b4-pidff-rescale-exponent-v1-1-3ba54=
accf767@cherr.cc

Changes in v2:
- Following Tomasz's suggestion, warn during initialization when
  the duration field's unit exponent is outside -8..0.
- Add Tomasz's Reviewed-by.
---
 drivers/hid/usbhid/hid-pidff.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.=
c
index 22951b7ecd17..4540f49fe6e3 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -354,9 +354,9 @@ static u32 pidff_rescale_time(u16 time, struct hid_fiel=
d *field)
 	int exponent =3D field->unit_exponent;
=20
 	pr_debug("time field exponent: %d\n", exponent);
-	for (; exponent < FF_TIME_EXPONENT; exponent++)
+	for (; scaled_time && exponent < FF_TIME_EXPONENT; exponent++)
 		scaled_time *=3D 10;
-	for (; exponent > FF_TIME_EXPONENT; exponent--)
+	for (; scaled_time && exponent > FF_TIME_EXPONENT; exponent--)
 		scaled_time /=3D 10;
=20
 	pr_debug("time calculated from %d to %d\n", time, scaled_time);
@@ -1428,11 +1428,19 @@ static int pidff_find_effects(struct pidff_device *=
pidff,
  */
 static int pidff_init_fields(struct pidff_device *pidff, struct input_dev =
*dev)
 {
+	int exp;
+
 	if (PIDFF_FIND_FIELDS(set_effect, PID_SET_EFFECT, 1)) {
 		hid_err(pidff->hid, "unknown set_effect report layout\n");
 		return -ENODEV;
 	}
=20
+	exp =3D pidff->set_effect[PID_DURATION].field->unit_exponent;
+	if (exp < -8 || exp > 0)
+		hid_warn(pidff->hid,
+			 "duration field has unusual time unit exponent %d\n",
+			 exp);
+
 	PIDFF_FIND_FIELDS(block_load, PID_BLOCK_LOAD, 0);
 	if (!pidff->block_load[PID_EFFECT_BLOCK_INDEX].value) {
 		hid_err(pidff->hid, "unknown pid_block_load report layout\n");

---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20261028-b4-pidff-rescale-exponent-1d5c4e218e6d

Best regards,
-- =20
Shengzhuo Wei <me@cherr.cc>
