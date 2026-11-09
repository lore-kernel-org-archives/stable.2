Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794244556;
	b=ymBXRxCCQwYqChdHBsOSdgWBOJy4PqZtTJIFlGpnlaeJqw4VSrhf1QeshM+5Mh3wJyux
	 3/vKlp4S5kPhAp5hUsTUl16rXsNm7t6qtFYOLV3/p0y4AnkW4Fpi0PF9jPQosOZAIT2Nc
	 QT4u4h7QGNyitQ8krwBUcsAbNQwGvjC1F+4zDsLbXAt4jKgJJMW4g25k1z4WDf0/J/4j1
	 +q0LuY1wkncSKxjaWUMq9IVmOpEJavJeNbWVUai86ZqwR/xW/mBOKiDVBaA3ccBlxmUqi
	 2gXCmZ99ZF2Lb+nJ3uFovmf7PpO8Q1Gz9fx25xpwqSCqOR24xUUwEMZRbkWy25UzxXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244556;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hAyVKQNXWEvDV18f6Ws1s35eT9OxUv+MInf6BhY5vP4=;
	b=eO9R1qnVfU1L1Zo1tqYq8CbKIpT4q+CquJEFofnb0tZLds0Nha5Uin+A3y2oinLkg5Tw
	 QXLNQw7S51yntJ+IKES1F/V92g00r3n87f/Orsxf1ZF8s/PT+leTPBKiX2DkZbm4qmT9H
	 7ekNZ4d+mosydCpDQIC0QU35GCJ57wMbuD3gWQ0938tpyKMYA+xnCLlNao6xt3em0zdZh
	 ojKuhqAXJg2gfDDuVD7NvAvJau/44rVAkxgYqNHlC/O5SB5MrThDvAfhwsnUt7ilT+lgs
	 fo21dpRokO8LAwZ4RgBWNxhMnZPK83RPti2xZ6wfSGZWvl9WSY1Uqj8ygpVNioZ/PQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j/1hLmlX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A76606A31C;
	Mon,  9 Nov 2026 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/1hLmlX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794244556;
	b=g+7vTeLGba+3TikqA2+gW8yFtLo+czzce6GDGiZqeR6mx/8kZCw9AYR/A9pST5ijIuFo
	 eI7dCARZmnrC6fRIQWeUGnkPIiVF+I8ga8NaXVatdhIdZjNls3eE6UCKl8AmZ1WzMl20M
	 PrqgpzmnqAMzh21z5JFFAkmsGz9Q0OoGCeWnfA+HPtS5IOz2wt5hkuLduT7DHu9Y4LPBq
	 Hujbx2c7eLXd2fbYEiZfZV+Ll7XMDGemhPuDPcMcpJX0iEx0j4Xr9kbOYLyPPKwcDJEmb
	 RJ55V8V7GOgGDXEl2lWk8LIKu3HKQRj5/6gkqapB3iQvKfcOia1CG8cVNg52QuJhH1g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244556;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hAyVKQNXWEvDV18f6Ws1s35eT9OxUv+MInf6BhY5vP4=;
	b=xoTdqnMgjF43jbykxgZEwXyIRNuxY+C4CyIo4m44pyZ8Qnl4hJ8fWa2haCCNdyD7I4d1
	 hMCBxBcKVVaTE77zud9y0hBVO1JmLNqHJGxGVahIvGqlXXevaO00Ob4BXBNbWgfCWrEO5
	 bzZi5BK5fVjWgbq8IuIZFzrXcri8TET+39kWI2ZHDopH1l5mP1YKefcigvzgSUQsiEvsi
	 sCsBHZEKiO+i3wxW0PXkdVtlx3c4PM8uf4aZDWGypON4ZjlOukn/hWyVMAYnAGsoz9IIK
	 gfM1IpJ9AQiE3r0ErPHoAmWyBTArGHPY4N6YAQjSPN37fGJhYaSiXyIOopLXQZ9gtGQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 81C431F008A1;
	Mon,  9 Nov 2026 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794244556;
	bh=hAyVKQNXWEvDV18f6Ws1s35eT9OxUv+MInf6BhY5vP4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=j/1hLmlX2wneU5lbKV4JRevJEBTKFsngH08qCa4u55yRpsV8h9haSsgnBd1M/EJMG
	 LYubpArL3mtS1KBvahQL0ylrh+wJtLZsBhycBR3Kkzgn1vJlVlvxk9m9fpK7hWqEcy
	 Zzp+MMviTtGOHXvwjh7JeHq16NMkXusjdSn5AyZ1b1apGHvcPO06yVHGReL7LLNtBG
	 yKuSGT998Zhv13t8cIfRlg7q0dvZblWW23zrpUp5Erz65ZYmIvrgb3LKSRIT1NSu6G
	 QcXk/J9Lntrh1mOFeTDMYWww5zLKhzOQ6dPrQ/WXOzDaWi+6GjOuXHAOprN0TKbPeP
	 9pKfxVQE/tTOA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D068348551;
	Mon,  9 Nov 2026 17:15:54 +0000 (UTC)
From: Ivan Verbovoy via B4 Relay <devnull+ivanverbovoy.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 19:15:55 +0200
Subject: [PATCH] Input: da7280 - do not advertise FF_GAIN
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-da7280-fixes-v1-1-09cc3650261c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBCF4VeRWWvSS1LiVcSil8FYIB1EIt5ds
 fxy8p8LGBMhQ1NckPAgpmXOUGUBYXTzgIJiNmiprVLSiOgqXUvR04ksfDDW6uhqYyLkZE34Dbl
 ou9+8+wnD9n7AfT83JOVbcAAAAA==
X-Change-ID: 20261103-da7280-fixes-bc3662da833d
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Support Opensource <support.opensource@diasemi.com>
Cc: Roy Im <roy.im.opensource@diasemi.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Ivan Verbovoy <ivanverbovoy@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794244554; l=1634;
 i=ivanverbovoy@gmail.com; s=20261103; h=from:subject:message-id;
 bh=+tqVB3FFlOvTrxuwLoZlTGemlkZKQe11KqmDZ4ghgME=;
 b=XqGYSR/7q15sJpPAK7Uho+UjtaZTkO0DnDGaX9Y1u0dwatFlIUeVHZZF6L8dDnxHfuHcLi1Zz
 EZfHPuL7AU0CCx/a9jd3bIpfc4EydqRug4g2IvZ36+ADClp9OMQ+H2J
X-Developer-Key: i=ivanverbovoy@gmail.com; a=ed25519;
 pk=0AchqTH1hJFToIUeFfQRlVzzuaWQDs4e75SxT2y3s8c=
X-Endpoint-Received: by B4 Relay for ivanverbovoy@gmail.com/20261103 with
 auth_id=1396
X-Original-From: Ivan Verbovoy <ivanverbovoy@gmail.com>
Reply-To: ivanverbovoy@gmail.com
Content-Transfer-Encoding: 7bit

From: Ivan Verbovoy <ivanverbovoy@gmail.com>

The driver sets FF_GAIN in the device's force feedback capabilities but
provides no set_gain() callback. input_ff_event() checks the capability
bit, not the callback, before calling ff->set_gain(), so an EV_FF/FF_GAIN
event written to the event node by any process with write access to it
calls through a NULL pointer.

The driver has no global gain to set: a constant effect carries its own
level, and a periodic effect plays a pattern from the device's waveform
memory. Drop FF_GAIN from the capabilities, so that input_ff_event()
ignores such an event.

Fixes: cd3f609823a5 ("Input: new da7280 haptic driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ivan Verbovoy <ivanverbovoy@gmail.com>
---
A NULL set_gain() call on an FF_GAIN write, seen on a Surface Duo
(sm8150).
---
 drivers/input/misc/da7280.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
index 995d3f7af41a..4c60fd4fb932 100644
--- a/drivers/input/misc/da7280.c
+++ b/drivers/input/misc/da7280.c
@@ -1226,7 +1226,6 @@ static int da7280_probe(struct i2c_client *client)
 	input_set_capability(haptics->input_dev, EV_FF, FF_PERIODIC);
 	input_set_capability(haptics->input_dev, EV_FF, FF_CUSTOM);
 	input_set_capability(haptics->input_dev, EV_FF, FF_CONSTANT);
-	input_set_capability(haptics->input_dev, EV_FF, FF_GAIN);
 
 	error = input_ff_create(haptics->input_dev,
 				DA7280_FF_EFFECT_COUNT_MAX);

---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261103-da7280-fixes-bc3662da833d

Best regards,
--  
Ivan Verbovoy <ivanverbovoy@gmail.com>


