Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380183;
	b=RJ21Qjc/MZdOniw3ZWjVeZJM14WuqUnolQQZAbLsiLqrbrkKylDwz49aF2JmeWDis3mw
	 iyZSHWPM1tO7Xbl/UBZ/cWizmk6ZHYN3l2hya+blhDwhLhE2yamMAnAr1ybPk77vZ2SdD
	 skgEAB5b5p0gbY9MJEOeSPur8rRnAwb5TXWJSu6N6PaZ80b8i1ijkyb4ytERFmYNILKru
	 NkVd/dQOYiNLvnNVi9LvgSfyZtBzzSVRPXDHLH8TDpmgpZ/GaDAg8pPf+i/hvEscOJY1F
	 4mRQQOH7VoNK61K1qAWcCXRMajndAywAmzjmfm1dnHaJn0jZFiOmQ2qoSZV5gFUoZ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=jZGS888auqidm4dyipWzlAJPphh1S18LX24ea2d7R8o=;
	b=AaaqYIOn1NWljtpvXJEuj5TJvsrGYf40Szg/dq4ev4lOIY7oojbwHL/ufbV7kXCQMSwl
	 7MBHPuw8iHCeou7VzH00w0/aZUdTmexnTHrmaN6n8shtqmDhYc7tQtjvWjgeuOtE1PRRA
	 Du4rCPR1/uZiLAM50ttFLE897eXRNcAmauKNwgyxrbZ02HlugY4XdtHlFS4U0Hb6mPwPv
	 9RMOgRPc8fSLUDMVCzXfum/elSb1hc9Nf6JWwalElhvR2wIfwDw4B6QgEuGUaFisERbCt
	 U1ykwq/GE/nziBHCVm1zePqv3KTBXm3rcOsn7IckGM1kMAw0is98ihE895MAaLpxNmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfxHh38D;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9B606A338
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13F9B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfxHh38D
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3720addb068so5222996eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380181; x=1794984981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jZGS888auqidm4dyipWzlAJPphh1S18LX24ea2d7R8o=;
        b=xfxHh38DIVXPpsdcjuU8pKLEB2mK63aFJd7Xf0/+nIUJDjugA4HkTepQxYcL6HRZ7g
         2EcAeV07/9DTk6OKKSedGBjRPZrqBUMcMA7mJLxUAMoeZ7Vt6+igoV/Zg1UL6RikXLlk
         71J7FJxjxEdJQzRMTCBE5YfxqQel447lkS/7KiGU9bC4syVAdvytlNuaSnwUEyrAS2uu
         QxHp9lIzqShCZjJmMomKTT3PX3OiFyaGTvs2U96NU/blOoCpoqCNUY74UCuVHd3mvLBH
         Daj9oufapdgCwLPaJnQYx852SZa0qXB06Y/BfW+N/UJ9EdBoYqZ3cOCjbcSoJ+HlUZXd
         zW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380181; x=1794984981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZGS888auqidm4dyipWzlAJPphh1S18LX24ea2d7R8o=;
        b=LmBvgDHl2E+b/i+kohYlGdc7xGfa3BTkoIfJKqDQc8LjTPFdNi0uNzR6WBR8RivR13
         m5URoFSyh6AlkQJGeq+VXmlv2UZpKrZtzBjujCeH5eqCgwZar7o+zR8GK3M8T156UOFs
         Cvxe00veAOWRrFUmbvzmnSEpGgyK6i8yc0Gtx1u1D62T+ebAG+aMqAf1g6Fv4ZTToucQ
         U87hrgTSV7T6FEluTalC8nPcyTgKh424ygj68NngRP0D0GV3IXFjCfvX+oQw8asvZD63
         sbMc/kY3tnSWGk77RzYU0xfJHXBwHEJuvMBnA/God+5h55oDNu1COhJFtPdjZHaf6XGv
         VHqg==
X-Forwarded-Encrypted: i=1; AL+hErEXAfC5MSHundePizQnWLSKIyHQ0QQpbf+kn0bZ1bkIVXFlkxKb9ig4Y8hhRceByaAmVUqG008=@vger.kernel.org
X-Gm-Message-State: APuU4Z/D67sj75gZVnN91fY6p+FZJwvkNOnfxGuRm2SOJZpyoSq49mR5
	C6lBADsvQR8dlO8kt74zLpvBoVZjXvWs0UyrUBSVCUenIQiTr0X+UJwZ
X-Gm-Gg: AYBFou3DU23Dw6H8cfASiK3vdp9C0sYS6LyhFp4hZRp8smVhKaupgh/0epNxiLLhV/P
	UuHvtayaIyKBDtIqh90aXNxkPc/ey9OPzVTzPoHFx+MPqS/EymcWQv0VGq+E1rPg/PT9N5CzMXj
	GqEUpm975RnmvGuaY0jhR1DTkQKnhoMTeurwOe4dAEdhOMSJFO3i728bx+slE2rpW3RVElybDjx
	3p1l5B5SRWwV8F+a6ohgUk2WRkzqeHL7+aX5ls/DciBCZxHoEAp9YUSJ4kDx9EClwyyMPq0GZvR
	bw12IB7D52ruTllTsTPKH2QcswwNOVxJJrVij+Uik1ZBTe1UL9NtJAjG0FMgi7tebwCYtjs38ox
	zY8IDMIWGqwImmF7NXEfMro4uHs8oo5vDyVa160zizeqJ9H7fcKO2A16SFYECerV4/moZxr9U8B
	DysiPpWep9ev4K5w+HtDh/9f5sXKWk3N2ykHliLpk/snxGv0eeLL9ItLY63eNWQV8PONeLCcJeg
	/jIDfKQ4fkzkSuKZo1p5Iipuv2XGgtB1nGX0TTY3vWrRlzvaQZvvDO5mhyooTdOSoYSvsjQAqy7
	7qOQ+swrqbm1xqQjI6ucosoT9j197hBH24BmL+0rJI836g5L8ArsA+vCr2oZNNvnvMI96JBq6SR
	4xzgUPkUDrC2/1RXF+w==
X-Received: by 2002:a05:7022:ea8a:b0:160:90a3:ca8c with SMTP id a92af1059eb24-1b3c0334a40mr1624823c88.7.1794380180963;
        Tue, 10 Nov 2026 22:56:20 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:20 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:47:59 -0800
Subject: [PATCH v2 01/33] HID: logitech-hidpp: fix G920 force-feedback
 initialization timeout
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-logitech-hidpp-v2-1-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Commit 544315e40172 ("HID: logitech-hidpp: move FF initialization to
.input_configured()") moved Logitech G920 force-feedback querying and
initialization into hidpp_input_configured(), which runs during
hid_connect(). Because hidpp_probe() calls hid_device_io_stop() across
hid_connect(), incoming HID++ responses from the device are blocked
and g920_get_config() times out with -ETIMEDOUT.

Temporarily re-enable HID device I/O around g920_get_config() in
hidpp_input_configured() so the hardware configuration queries receive
their replies during input setup.

Fixes: 544315e40172 ("HID: logitech-hidpp: move FF initialization to .input_configured()")
Reported-by: Gideon Heinz <gideonheinz02@gmail.com>
Closes: https://lore.kernel.org/r/CAPb1+K1-pirdLGZ1wTUw26G6pvhg7rGP3QZ172ys5DB7rNCf5w@mail.gmail.com
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 60fc6b86a085..85d8d168ff15 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4096,7 +4096,9 @@ static int hidpp_input_configured(struct hid_device *hdev, struct hid_input *hid
 		if (!list_is_first(&hidinput->list, &hdev->inputs))
 			return 0;
 
+		hid_device_io_start(hdev);
 		ret = g920_get_config(hidpp, &data);
+		hid_device_io_stop(hdev);
 		if (!ret)
 			ret = hidpp_ff_init(hidpp, &data);
 

-- 
2.56.0.542.g3ef89b7020-goog

