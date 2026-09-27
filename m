Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4C63B71D6
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 04:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790482313; cv=none; b=CXetH6oqFMlrVMN4EN6PiQVPV1CtoALl6fN2wLhyLWkE4Y2DUT7dMPXOT61jjrfhaHzSE49MI/S0olspzs3fAno1u5R19CpXTxp0NcygFdzLpg4YaQIfeT8yLA2HQaBzgP9ozSAG7alcJgllWuHmEeclGYQGXnAzDiEfeAvk2oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790482313; c=relaxed/simple;
	bh=+u6WGUMv6TbrgHonB6iwsulOiAc0jmsYE/FzuoVESd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t57mFe4PJpDno62FAULHte9nHA/WbvUjGd3jMdfJTTt4Z7OVykvqwjbFAqdKPkg21sBbsYFoBkAo7mda/bWWreB8hMHIxy+R/mq8MhN7gZ/G1xbWeyYJpP1RliSUDy8x8on+/I6l6luj6t7AWaf3vW6u63XnyQiseWUHH/Q37Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTfuNaBW; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTfuNaBW"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d31bda43so826779a91.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 21:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790482309; x=1791087109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=en/KrVBGuUfquYbiweIku2w9tHZ37eqsjbRgRDssJCk=;
        b=TTfuNaBWZrijWLZ2O5/uaK4rBK2Hr3KwY+7Ns7wq4yVlgpPGqPGyXDFOc6PxCauKu8
         kgzr4r3jZFsyiPFh6JxMnMLUN0EoyLe9jmoMC/ex6FKmfmYo0dXfPv0XP59m4K/g0UDO
         ts/FfIIFvt4wGSky10O6MQB3p8rsmmzwBX3ELfu2yoq/tWvN08eVH8Vn+BUNnhire+tD
         fF+MDG1O5qf7QHUAuIg30zS25JZTu2lW5lmJnvssHQHuucnuzOfZql9cIzOjARtbqLpb
         FtFy3ntKE8SYdXaNVEhbikeZaM0ZprmALzXefuk6tv5ujgzXZEXriaYR3LKFh8eglrr1
         dqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790482309; x=1791087109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=en/KrVBGuUfquYbiweIku2w9tHZ37eqsjbRgRDssJCk=;
        b=Scs6iOCCAAEy+clXf1H1paoSCsujubm5lWXi8jB+TqrE5sii2X/2PspgQmyPahkR4L
         2ZEIoVbSrZrDKr87msI6MXCCv8pVzT1P01g/kBy/SDXJXqqwFSaPpN22kZhkz2Gp9KPe
         HXGf+26zkWK/28BqVVvydEfS0QxDpDu3eY33260GR0AsiY/DQ16rWeHxzxfSeLPr7dHT
         j5jeBBc5MvKzR3HeZpfxhf+T79wgcpIHmKEEgtjL0SjCVL/tLMykx/r9vD3So/5Njivz
         Qnwtst8UN3Varqq9wdfhQTFBkBsAW99fiQNPSPQdmc6C9qn/nO75JOW0iSOLvOZiKk++
         6vNA==
X-Forwarded-Encrypted: i=1; AKwUvBx4OeX0gmTy6RivSXHh++Z7a8m6SA7HOPy3j0HbJRtyEPIFkpNShQ86yxJemk9/u/NAGmdOW8M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLhfV6fMQo8bHQ4v22QvATtiinlA88iAS2Bsbs6LiUOiVCvRfT
	RWVE1qzgasZIHWWtl2k0cIfRywsuAfEhAT7/6Q6J9gVxnaE7wOCvVHq3
X-Gm-Gg: AYBFou2F2PbdCnIg2cgVSOKSkdLviaUC8eG4a6PjgdD8++rdcSE791qa6vbupoVKibA
	8KTqcA/rOrED+rOqExVztMbAtlM2E2H9eSiV2Yg435f+ce7EQtZAbuLaXDGBf1zjEQRBJ656P9F
	zRlfI4nD6mxCrWZUyHtpqSddbnHBmz3fiDKSaaokNqQZCHyWe/z3Vv/BGxgfSl5dGsYq8OWyWfa
	hfR+HlDfh7uDJxl+wJDRyeBy2UB+4WiMHFS6gFTZx4pg4uo0QwGZom0VxVFDy/XEfFHC28D7nbH
	Rsa/NTcdCkky/FaaLpmhGVibkakHDVE7rALvgkHn7OqJxsxaFlqxraMTT5+fkRQsEtOHHyT6xjE
	D3+AQUFgjHTt67mRXnIuFpUUN6czaPOCbXVas4k9/nEBpJLTvadEJlhvGSmWznfzYPM3oQ9P2Wo
	sikN/+lcVQKu+P/WFdUnF758EGXVJcZHeMzhmA/ZBWje9/Tyy0HIsvanaGUbXCYQY0BOdifIQx3
	7/8A6sqqfXGS+0pLQ5cWgqH/yizKS83kw==
X-Received: by 2002:a17:90b:4c0c:b0:3a0:f2bb:53c7 with SMTP id 98e67ed59e1d1-3a0f2bb5768mr1762019a91.30.1790482309408;
        Sat, 26 Sep 2026 21:11:49 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b4f6345fsm5542732a91.1.2026.09.26.21.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 21:11:48 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/5] HID: wacom: check the input devices in the legacy irq handlers
Date: Sun, 27 Sep 2026 13:11:35 +0900
Message-ID: <20260927041138.4112920-3-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
References: <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>
 <20260927041138.4112920-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_penpartner_irq(), wacom_pl_irq(), wacom_ptu_irq(),
wacom_dtu_irq(), wacom_dtus_irq() and wacom_graphire_irq() take
pen_input, and the latter two also take pad_input, without checking
either.

As described in "HID: wacom: check the input device in the shared
report helpers", a partial interface leaves one or two of the three
input devices NULL on a fully successful probe, and wacom_wac_irq()
still dispatches to these handlers. Seven locations fault, each
reproduced on linux-next 20260925 (x86_64, KASAN) from one /dev/uhid
device plus a single UHID_INPUT2 write:

  wacom_wac.c:137   wacom_penpartner_irq    pen_input
  wacom_wac.c:227   wacom_pl_irq            pen_input
  wacom_wac.c:244   wacom_ptu_irq           pen_input
  wacom_wac.c:303   wacom_dtus_irq          pad_input
  wacom_wac.c:326   wacom_dtus_irq          pen_input
  wacom_wac.c:391   wacom_graphire_irq      pen_input
  wacom_wac.c:444   wacom_graphire_irq      pad_input

for example, with vendor 0x056a product 0x0030 (PL) and report id 2:

  BUG: KASAN: null-ptr-deref in input_event+0x44/0xb0
  Read of size 8 at addr 0000000000000028
   wacom_wac_irq+0x2b27/0xb3f0
   wacom_raw_event+0x68f/0xb60
   __hid_input_report+0x398/0x4d0
   uhid_char_write+0xa99/0xfc0

Check each pointer where it is taken. wacom_dtus_irq() and
wacom_graphire_irq() serve both pen and pad reports, so the checks are
placed per branch rather than at function entry: an interface that has
a pad but no pen must keep delivering pad events.

wacom_dtu_irq() gets a check too. Its only dereference is in a
dev_dbg(), so it does not fault with CONFIG_DYNAMIC_DEBUG=n, but it is
unconditional in the source.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Fixes: 862cf5535c0c ("HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD device_type")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 177a1e09fd05..794c2865064a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -128,6 +128,9 @@ static int wacom_penpartner_irq(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pen_input;
 
+	if (!input)
+		return 0;
+
 	switch (data[0]) {
 	case 1:
 		if (data[5] & 0x80) {
@@ -174,6 +177,9 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->pen_input;
 	int prox, pressure;
 
+	if (!input)
+		return 0;
+
 	if (data[0] != WACOM_REPORT_PENABLED) {
 		dev_dbg(input->dev.parent,
 			"%s: received unknown report #%d\n", __func__, data[0]);
@@ -233,6 +239,9 @@ static int wacom_ptu_irq(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pen_input;
 
+	if (!input)
+		return 0;
+
 	if (data[0] != WACOM_REPORT_PENABLED) {
 		dev_dbg(input->dev.parent,
 			"%s: received unknown report #%d\n", __func__, data[0]);
@@ -263,6 +272,9 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->pen_input;
 	int prox = data[1] & 0x20;
 
+	if (!input)
+		return 0;
+
 	dev_dbg(input->dev.parent,
 		"%s: received report #%d", __func__, data[0]);
 
@@ -299,6 +311,8 @@ static int wacom_dtus_irq(struct wacom_wac *wacom)
 		return 0;
 	} else if (data[0] == WACOM_REPORT_DTUSPAD) {
 		input = wacom->pad_input;
+		if (!input)
+			return 0;
 		input_report_key(input, BTN_0, (data[1] & 0x01));
 		input_report_key(input, BTN_1, (data[1] & 0x02));
 		input_report_key(input, BTN_2, (data[1] & 0x04));
@@ -307,6 +321,9 @@ static int wacom_dtus_irq(struct wacom_wac *wacom)
 				 data[1] & 0x0f ? PAD_DEVICE_ID : 0);
 		return 1;
 	} else {
+		if (!input)
+			return 0;
+
 		prox = data[1] & 0x80;
 		if (prox) {
 			switch ((data[1] >> 3) & 3) {
@@ -363,7 +380,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 	}
 
 	prox = data[1] & 0x80;
-	if (prox || wacom->id[0]) {
+	if (input && (prox || wacom->id[0])) {
 		if (prox) {
 			switch ((data[1] >> 5) & 3) {
 
@@ -438,7 +455,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 	switch (features->type) {
 	case WACOM_G4:
 		prox = data[7] & 0xf8;
-		if (prox || wacom->id[1]) {
+		if (pad_input && (prox || wacom->id[1])) {
 			wacom->id[1] = PAD_DEVICE_ID;
 			input_report_key(pad_input, BTN_BACK, (data[7] & 0x40));
 			input_report_key(pad_input, BTN_FORWARD, (data[7] & 0x80));
@@ -453,7 +470,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 
 	case WACOM_MO:
 		prox = (data[7] & 0xf8) || data[8];
-		if (prox || wacom->id[1]) {
+		if (pad_input && (prox || wacom->id[1])) {
 			wacom->id[1] = PAD_DEVICE_ID;
 			input_report_key(pad_input, BTN_BACK, (data[7] & 0x08));
 			input_report_key(pad_input, BTN_LEFT, (data[7] & 0x20));
@@ -468,7 +485,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 		break;
 	case GRAPHIRE_BT:
 		prox = data[7] & 0x03;
-		if (prox || wacom->id[1]) {
+		if (pad_input && (prox || wacom->id[1])) {
 			wacom->id[1] = PAD_DEVICE_ID;
 			input_report_key(pad_input, BTN_0, (data[7] & 0x02));
 			input_report_key(pad_input, BTN_1, (data[7] & 0x01));
-- 
2.53.0

