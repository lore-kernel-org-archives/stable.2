Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407674;
	b=eDAxALdocciTGZaK9oxqj1zFUycpMdoeiKKfBdWG3JDZZub10NpY66zOxaBSKwT3lx6X
	 7JSv0YHvvoNHTzNGx4+dAJo89cmyoLVwznl5sX43Gsvk6KeLyLbqk49654UV1SwnwkGBn
	 a++P5p+bh5jiRsOWeEcZ8ux9i/8sk7tHn4QU9f68YpXwCJyP3LhyHicG8sPXkoDgzKMdI
	 6mTNlM6QZe8GdJPfw5Ls6sIjjlqZhxri25o8dJp1tpYaHqC6FrwBgn2eoGo60Q1MBk0xB
	 bXiN/IfZoUsmrjGdr15d0ZN/004Mf9Sy9iJpKHH/17PqU6LhSWrfW2wOZAbmrj5YWtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3lcAY4q+qNuXrOlRujle6G1kafferflNNP255tdpCqI=;
	b=vkvpva8WM6hUHOCCh9O6eRR2E3jQvjmjzocgncjkiVWHG6ruydoVjLAIfCuZcfVya72S
	 1UXh3m1pQxKnjRyDWNXvovbAVnpklYBvekkcYI5EPXDjU/joDzMKeNXmQw7K2FdQErsYt
	 1tmdQjCzLcWMdXvF06vE6DDMtGSveZSSZLfaK0V4fWADQOXzZP7MFuTC58QgBExoAxu5A
	 l86PNBH36wPBsEPb2/3bka9WdPBQ5KutKanPi2PYqEhaQkboO/M+br1Yz3wzUbJIToqIS
	 4Bg+tyNkmygfisS5t+gw/7kDDkWg3/1FSNJFqTItKuBk9m5vSv2hyhUrAzk+qnaIt2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a++1msNE;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67856606A682
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 04:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67856606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a++1msNE
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-38431138772so3663925eec.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 20:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795407673; x=1796012473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lcAY4q+qNuXrOlRujle6G1kafferflNNP255tdpCqI=;
        b=a++1msNELjCBBUe4+xupGZNZ5/B5lHc/WI64n3cKoQyuZ+DdaEzNCqqoEfsqjKW3ug
         oM5i0Hz/l/CE0JS+wgWSBzk2nFPJftbQdAmPflY+lx5Xi69nr9Tw/m4sSRWWP4/Fztu+
         IcrMwIbyQ4cifeRYBV9WWYSgJyyBKiGkcz0B6JYueIjMzR46nf5uqYq9lsS8tJRhubxS
         t/wSWFBDbsSMr9mf6yz62c9/7bHLrjIK4/it6PBuEKKDV3DWcZB/OwjCe/npE6bW/kbh
         8G1NhZIzQERmeGN/XvSQtymJkMCEa1Fe/pIxPyJTcIBk3s449y3rgxsNOFImGXqqY7Bg
         OM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795407673; x=1796012473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3lcAY4q+qNuXrOlRujle6G1kafferflNNP255tdpCqI=;
        b=gXGMbOTdrzyWg+yE5PWEZf+9Nt3VQelRfhOnuQMtc3/ZbkOiHlXzfcx5srP+B3Sh7O
         nN3WRJhYhu39WrbixpBACKms8dnLk4sMzC6zKwr4/WIXgO6L7x+PMqgM7OrtUInAHDd1
         SMF3dXoOCIcbEf5aQRZ4JbZgKKw1zuItD3RKVQXmNQbwgyPIMOCgi7LzZxcpY5iOX9U1
         OpiTYLCOtnysvZVeQmzCd+qcCP/Y+vTMUOn5fxpVicJQxMBQwh84slyPzHDlbaJhOyJq
         64jCj1+DLK8As4drmHZ9vaROTbidGYxCE58nDYqbf0xzNzcJkRsL/Wpu9DDreZHJyayt
         LnnQ==
X-Forwarded-Encrypted: i=1; AL+hErHnTRzBveIf9Uox6ipL6eQ9cqO+yPNapzMsGMTFZbrgGBK7JsMrfAB04cg4YF+2NXY+0DZ/ALI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tnUuOr9xcVUDcOobqgzFhjTQUZ5aGw02j0Dgq9dgZ0fm7pSCx
	0GymJTKgvgLNdh4BcUjhqbD2U/v15ZHXaFw32RtuvywUsXqICgcKEeeE
X-Gm-Gg: AZFdTZfJ1BlKX+bSe3CpNNhjlgNl2BtPUmpGbq3BAPwX1ZZMrgBwyLvdX2zLj9a3+E3
	+q1YgLEBX/esy0IO5URJsJ0j5KVbLaimHnHFIjBLZFa8VeHBA3vxcD8RZU8RSy+Uz3+dQ2GZrvD
	4fbkWQ1l9nSDzFbgUTrPmfvaavxqVg6RK+15LUgUxsqOZ0GwkQmvNrojskJ0ZdEBprPyJUvBRkk
	KyyWBqQHIlaQnBRf+/3CkkfjmmTrnwtoRLwrgBbs3u2X+iY8SuQZt31rO/WvE2sg1mLgza66lxK
	gajmIaArlhXUeiUTrH2g5HH8Z3nh1fPY1TFfVQvgHalkl6B6jWqAC43ahHCuWjawdIcmksJDX7/
	rpwVEfoUkF2BXBIEflCQAIAlEQfI1c5AHUisF1u7FmoW2UTX/ESniOqJgs14lRXXJU5CqAgsNQA
	j5p/GrwaejopwsI8f/NhgTRCWxVdRGlxnDbyYLbWgd4sZI+TUXsRVOINfmsoy4j01JSs4myunFk
	r/5qfUEulDaLId0y+3zBVY1Z8Jne7/OhY+Hpt7KXiEUa2KLZETcFRl7PWV8k42HWuTCeVFharEy
	5SVWvtWxMtPIMW6DR5h4Mzp0HCsaWrgafEN9jCHoxcH853Ss0PEMAU841ieOchHBCp6MpTSHc44
	3ka7Gd2AY+tzbT9Ccb5JthpGE3ymU/YN/cddTch67MC+KVSU=
X-Received: by 2002:a05:693c:65c5:b0:386:b5ce:4627 with SMTP id 5a478bee46e88-386b5ce496bmr502496eec.30.1795407673528;
        Sun, 22 Nov 2026 20:21:13 -0800 (PST)
Received: from spark-da2e.tail8e743c.ts.net ([211.105.22.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm30804737eec.15.2026.11.22.20.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:21:13 -0800 (PST)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org,
	"Claude Opus 4 . 6" <noreply@anthropic.com>
Subject: [PATCH v5 6/6] HID: wacom: add NULL touch_input guards to remaining touch handlers
Date: Mon, 23 Nov 2026 04:20:15 +0000
Message-ID: <289785de10fffc66131938162155c1c3e3743a90.1795405057.git.jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795405057.git.jinmo44.yang@gmail.com>
References: <cover.1795405057.git.jinmo44.yang@gmail.com>
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

wacom_24hdt_irq() (also handles WACOM_27QHDT), wacom_intuos_pro2_bt_touch(),
and wacom_bamboo_pad_touch_event() dereference wacom->touch_input without
checking it.

As with the other handlers in this series, touch_input can be NULL when
wacom_setup_touch_input_capabilities() returns -ENODEV during an
otherwise successful probe.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index db8d3432dbd7..c48f957f8970 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1489,6 +1489,12 @@ static void wacom_intuos_pro2_bt_touch(struct wacom_wac *wacom)
 	int num_contacts_left = 5;
 	int i, j;
 
+	if (!touch_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return;
+	}
+
 	for (i = 0; i < finger_frames; i++) {
 		unsigned char *frame = &data[i*finger_frame_len + 109];
 		int current_num_contacts = frame[0] & 0x7F;
@@ -1660,6 +1666,12 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 	int byte_per_packet = WACOM_BYTES_PER_24HDT_PACKET;
 	int y_offset = 2;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (touch_is_muted(wacom) && !wacom->shared->touch_down)
 		return 0;
 
@@ -3450,6 +3462,12 @@ static int wacom_bamboo_pad_touch_event(struct wacom_wac *wacom,
 	int x, y;
 	bool valid;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	prefix = data[0];
 
 	for (id = 0; id < wacom->features.touch_max; id++) {
-- 
2.43.0

