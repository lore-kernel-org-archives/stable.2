Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279146;
	b=tUqxJ/1kRFrH5sMLH/dvyDLlOn+AmlAqcbfI9yG/NEF41Ej7wSxEVITsTpDxDbRsrlQQ
	 ZAhvu6L7Go19BFVoB89mKtjorIZ8rdlOI4XSGY4nrfrhHeXSPhC9S3gM2iwPIWEqLYJcw
	 7NL4PnlIQ8+DjpjSd8Tb286QA3CsmXRgin/RChkS0ItrCBrfkVzYRzpKr27z61T9t5TgR
	 HV6GD1GPq6ACqQImSntsseNEHx71/gDYxK7Xh86Rm+rzBl84VyoqSp6E1Buv2QWagSpOc
	 hqzvSPnpVGcWnFOTPIw4I0o2gDGATC3fjmvxEiWENRa/9fc3GSU35ukM/Vrpn2NBomw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wNUOdm/IOUvvzJJ7mh0K1e4OLnQV405xLGrAKQJel44=;
	b=k+9eLU9WlIVAsA9opT0DTLkyP0ZXdK0L1bxp7bbJ2N1VUjeBEEL83iDyioqp/mRp6pGV
	 tYw9m/LyBq3GnNfGPvtFkt+Ebg3i5QbPbgaLZ8BlmXsNIcUN+P0dOX5Wnk73qMSw2Mq7b
	 Lfwj14bbeWxwpszYc43asraZHYkpDsNWAkccLih6p9WPY2lnUbF4VKhDKRKxf4u6sZZNf
	 LCNnmZSJuPg68ATBxrd4i+PUXNXb1CwqlHuFxyPGvCueR7rrQK6ZrxDDiepe98E6+FqMV
	 PjPFNz7HplGhpo6qdNQQ5sTALHbMwhvTl0sdqPD4i67XoWnnsTz8sbYfRAKZXBKd+CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b0Z1+RBH;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B8606A32D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E9B8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b0Z1+RBH
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-170135e43c7so1414388c88.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 06:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793279145; x=1793883945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wNUOdm/IOUvvzJJ7mh0K1e4OLnQV405xLGrAKQJel44=;
        b=b0Z1+RBHNX51Mk1N0BEEnymeLKvBCMIDV3LQX1GA5YjhmMxTeZ5GUscPtVYL0HzVM9
         CpvsnF6PXb/Rrwk5oLrQgUD3wmD26JQHPv8ZjFlZz7LG37/3k3fOuI8L2Ay8+HVpOLCn
         NwO8ma+ICHu7ei1tvcD26EGn+gYfWN983XV6d6b8TvJqxEuQjMBqjUoGoyVawac+1x9A
         ZhTf45ucKratTaL+vsJn851UpfsHfPrymSSHM9Za2dlxDjJ+pvqha14lE+8VXudb22Lm
         BnCz3gSIzNoE0KWZzBHGwvWwEKh+mZvjDmpnO0MhiEqguhkEbg4PLz09+Ehbr0A9tmrN
         IECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793279145; x=1793883945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNUOdm/IOUvvzJJ7mh0K1e4OLnQV405xLGrAKQJel44=;
        b=ydgp5o0qo2HBoegaCQJON+dqXrsCUryh20CK+Ubr163QxtbOpBJpw4sYdzeRGsaqbe
         a10GGFH3ragf3M8ghiATEV2v476qe6kCo0dxa16Osv+nrQ6bYjVgR4LugFmnlZyaG0wn
         7CSi0aLFnjdg+UsdhZB0Bb6+VPPdOtrEqJyV28CxbhdUDD5vcMjVR2tSDtwEer3MVIMC
         Xk73TQWDmV3KBEOyEXIWA8azDN9zZ3gCzGoHsbKtbqkGjhf7dIZ5k1Hijt/1Z2XeoKTU
         vyIaPusjniRgyY3ON3hXcROvaSeziMTl3JGh+aw+kOSU+0BGai95b4gAlQS72fooPKiK
         3tLA==
X-Forwarded-Encrypted: i=1; AKwUvBy5n21hdOOLc9FoRkpJytNiyhN0SHTQDvYN9mUm1Y75cQmOEEjI0vf6YZenBGkUajWKrTlc28o=@vger.kernel.org
X-Gm-Message-State: AFq9FYIihY19SqDSx+bnCWJrM+rywfAcLyEmRcZI51pjhEA/1ah5wr/e
	4rxR2unLEALVoPTpX22UH2fvYfk8hYYxHRuIK3db4QKAbeUkX/JJ/Yol
X-Gm-Gg: AYBFou0fv6a88O+W00EACaJ97KZ1LZI2jG11qDuGKL48NJtuiSRy53dZZ5+lZQByUVx
	M1rWPZuruUb6WIk7YkyBRGxvbIAHcfFKd1k6w21wHdUGEaPu8gBvaSKKYx5JBdEyTkUUsvq3FrL
	Gafw64C1kPLOuKcTW+QW/f/XI537Ko3D53NVyVNB2uCKvd9UbvObNjCyi2PdhhX6Pns3zdyUwVi
	5SiRkgOZBGm5GShTAB2DnZ2N+KDSWHf8rkpmArHTZKGX6y26+mzFmA4gBfF/vHorNryW+6Ijx+Z
	QnFH5ywoDeKvoaxXSST+NHm7ZuC2In4+f5ox3xUnwQE1ZyBJLOas8nTvHibaY7hRmjyRwVN3hSH
	SKz43zRwVDkkwYAseYReoc5fbKv9g9nEE/UCwWxA5fkNzmge56mqgpn13h/d5FfXj3Jh1M4Vjt+
	kqygsQ6PrpaOmqO1JEVds7UsiLH1cb1oJrB5LT/AENJdeQro5+IPCBBM5Hm7bInp+5muC9TpVjk
	8wIlC2I+unAmoDid2/o/9MAUy/QEdQ77abgWYMTtWhr6AWkUNVAJ3gfj8N8kFWhV76rUdK8dPmy
	az7UYb/mXTI6ULLtW/J7+aKnDQeA446Avm6fUuo5Za0/vH6Fpk0WIGpKRQwSQv/+KOoYYkO49Ft
	UmZ6IRDg934MKUExo8fmSaC+RZXYjPvObWvzxbhtb
X-Received: by 2002:a05:701b:4509:20b0:196:aa86:fcf3 with SMTP id a92af1059eb24-1a6cdb50d84mr7706490c88.26.1793279145054;
        Thu, 29 Oct 2026 06:05:45 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a760569d53sm15322824c88.23.2026.10.29.06.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:05:44 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: ump: Fix dropped data bytes at UMP System message conversion
Date: Thu, 29 Oct 2026 22:05:37 +0900
Message-ID: <20261029130538.1985867-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The cvt_ump_system_to_legacy() function switches on
ump_message_status_code(), which returns only the upper 4 bits of the
status. The case labels are the full 0xf1, 0xf2 and 0xf3 values, so they
never match. MIDI Time Code, Song Position and Song Select are converted
to the status byte alone, and their data bytes are lost.

Switch on the full status byte in buf[0] instead.

Both callers of snd_ump_convert_from_ump() pass the result on as is: the
legacy rawmidi input of a UMP endpoint, and the MIDI 1.0 path of the
f_midi2 USB gadget.

Fixes: 0b5288f5fe63 ("ALSA: ump: Add legacy raw MIDI support")
Cc: stable@vger.kernel.org
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
Prepared with Claude Code (Claude Opus 5.5). Tested with a KUnit case
for snd_ump_convert_from_ump() under UML. Without this patch, MIDI Time
Code, Song Select and Song Position come out as one byte with no data.
With it, they keep their data bytes. Timing Clock still converts to one
byte.

 sound/core/ump_convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/ump_convert.c b/sound/core/ump_convert.c
index 0a7972d91ec5..ecbd894f4c83 100644
--- a/sound/core/ump_convert.c
+++ b/sound/core/ump_convert.c
@@ -69,7 +69,7 @@ static u32 upscale_14_to_32bit(u16 src)
 static int cvt_ump_system_to_legacy(u32 data, unsigned char *buf)
 {
 	buf[0] = ump_message_status_channel(data);
-	switch (ump_message_status_code(data)) {
+	switch (buf[0]) {
 	case UMP_SYSTEM_STATUS_MIDI_TIME_CODE:
 	case UMP_SYSTEM_STATUS_SONG_SELECT:
 		buf[1] = (data >> 8) & 0x7f;
-- 
2.43.0

