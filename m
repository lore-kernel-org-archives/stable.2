Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440511;
	b=j4sdtSsbjhX5UevmYQdlevoFwZyUlWMzs0zd+GZJ93fVByeE5cCizQsojgrkUs19+Kok
	 1qI8Svf5NrnHGEupe7zUIA+4/sybA9y/3oqpXAtLKSorEryxoVwektW1VuiGqf7D8XAHV
	 EoNJDUUTMKy5gx/95gfw12yHGrlmIlW+BCgwpXEfcM6Sc2p2Z7RJAxDJufwJ1Hm1N9TjD
	 c/zVAUCcEfYd9txxjs7e5FDpcdoIjW5LOWVPV1x7Il+KuBLVRPH/J2QRztMBZOsJSGorZ
	 mgWYO8Acuc25qRpoiw/lf/8AzYqWAKuO3cwCyzP6pMVPP+sCm0prYsIMwd5p5mL+ucg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZRdXRrWaH3GXnj/xf+WF4Od3Gq+lG/ySQbyFtokDobQ=;
	b=e17Xd3PP6l1OjqxAuBwioxgEGkULMmQAohQX0tk0G+ru+7FTVrPE2b3UJfoFW5rjBy9E
	 nCZ+rsv002hJKD/zXf8q7ulrLXKUGrBmOfF0mziXrqk+m3EQVerDbpuRiNlLoWxQHmSIf
	 ERHEjM5XfMtsSqNtJfhnnkCeXrziqi3TBekUSzbOCRKzb+jVbJ66ykFkyK0diPKtkR64k
	 j3lleznaflieNdbyKGcxZRARU+n8E3XRcnKWm8VggsC+/14TjI+d0eqaltur7ISCYbk54
	 PniAZS1n3OERD83lofIVoLw4K6xdl4QPwWVqT5y7hZyDcNej6BFZyJjgAF8mcxvMcZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A2Qh507H;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A69606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 09:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2A69606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A2Qh507H
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4be28b82so1592428f8f.2
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793440509; x=1794045309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZRdXRrWaH3GXnj/xf+WF4Od3Gq+lG/ySQbyFtokDobQ=;
        b=A2Qh507HjQmeA+P5m9XKhryYbdN17f8lKZGAWxv+nA+hICvwXHyi0LcTij2wosUvp9
         4T65S+6TaCqcUcWn5ZHncrl2EgOPVXsrxszLH3BT+nWa9T9s3U+uhdm8xtaJNmag0Hxk
         X9MIg4QnRZ82ONsxf+wgvsWa0D16q+cPDPkRZHGuDnEEXmkrf9UCXjZ3/758k38PLH6N
         QEolL4+/5vBJiHSpZPmG8GPzEAuQOp+cQfwjjZVO6jS9Hwzzf71bEx2GHHyiDMh199f9
         T6YXT0njlhFl5YkocjUKdhtqvluDoCaRLRtoHAZj6/KKwjubfvlSbvjENsT/TJ2NzC6O
         6GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793440509; x=1794045309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZRdXRrWaH3GXnj/xf+WF4Od3Gq+lG/ySQbyFtokDobQ=;
        b=mG1j/ZzU6XxHELaqsIiu4HabApBIHRInfRdxgZY1DD4VwKfAZWaDaFh+EubE4oigiA
         BLlLWBB1Ft1+0xVFxYcZDSxDGQkU+HGZT1r+1dc4NbU60bW/CAdP/Kgp+lrP5SaOkawm
         z1ILRw0HaY5xtuVq75ypjPM3Rk1+YU2rDc+ceCq9XI08j2UNOIGxeXCFPdGVBSBg6gJd
         RiylHoWG11EKwCuRcGRM8pOYXf9PMgo6ufRq7nbujE4G5Qcu7NmMkBE8Hq3qElvmSHw9
         GvThmXVATEGSp81z4gF6+bs2wU7O39hyo9XFhnCWGwTApioxOWX75S+TC33P25gU6Rau
         tzcw==
X-Forwarded-Encrypted: i=1; AKwUvBw0ZPrwiyZSYGG7si90x7KhhKuNDpk4hELQRCDtLGNuyj2DiQOCCQY1AaZX+sSQx9xrGnGwDIs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMB0HDDlKJUYwGr83hlO4i+Lvxa0r3i5XoRBo6otSDhCfLr86H
	0sgBXvRRAy501RcFb29A8Xwp8C5J+UmkVRLJbAW8F6elKDRGAoloBHol
X-Gm-Gg: AYBFou2kN+8LGLdOVz0/INSOQCX+2SjQJKP6o9N3jb7caCaGCy/4R1kgqj1z8YQHXZy
	z6utSHeovU6AC10kCLxGzTMp2U68VXZLpq/jYifQUsZyyM9p0Eczm1qh7fsJp65JyZW/YsmxQSf
	nApNlICcrqm+pkthW/C7f5gIAYkoHu23t/bIaxp6hLN8yl6wTwbMpxpTpU00XIRty3dIvTg/LHw
	ruxUpt+Ui7mFHDecYMxHcnHIG3lU//w9yorfU+RfCQsbEmsYNMSmevxAxPlVx/Yullihcjr9lIZ
	4gqFrIhVIw5Fast21WgZwwdc7SF8OA4OA+ASdAurfVUFiHPnV0gpwK5BjwJKVCdefszfPv3D4yQ
	Vdm8xj7pIEUu9Cgt1oStlJDD+C+hJkM3kaIGY178XZosPd7eNdrXC/oN4aFzfKBjWg5ieiTlb5l
	jvbFebXal8Q9qT0P4O2S/R8wJJIapnk68Wjj8PpdEIe1rk/g3da3CI2QnvHojQuPzfeeqsIhFj5
	Q3UIZn5wpzyHa64enD1HiXQgt3TrU+mywPsVxKMBPrnWaMmxxhd2TEMzknglLlHd1k73jNKWn3K
	KZkyLOkf1ayRDNYQ257vpqCs+17QXs5BZcLoM+vAzmSJUf/0w5Bc1G9aC5R3TWqJCR8B32UtH0q
	8LuVDcIJAXveC5fYG77bv+Mx69p/9rtGVyfXlICGa6p8+4YIv/mSBRQ0UfNXKRY7EAAU=
X-Received: by 2002:a05:600c:4752:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4ac18e5d4d0mr113107915e9.29.1793440509125;
        Sat, 31 Oct 2026 02:55:09 -0700 (PDT)
Received: from archlinux.tailbe3ea7.ts.net ([95.173.233.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a6bsm7869505f8f.27.2026.10.31.02.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 02:55:08 -0700 (PDT)
From: Ismail Tarim <ismailtarim7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: James Ogletree <jogletre@opensource.cirrus.com>,
	Fred Treven <fred.treven@cirrus.com>,
	Ben Bright <ben.bright@cirrus.com>,
	patches@opensource.cirrus.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Input: cs40l50 - fix OWT upload length
Date: Sat, 31 Oct 2026 12:54:34 +0300
Message-ID: <20261031095438.3070451-1-ismailtarim7@gmail.com>
X-Mailer: git-send-email 2.56.0
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

cs40l50_upload_owt() passes the size of the effect in bytes as the
val_count argument of regmap_bulk_write(). The cs40l50 regmap uses
32-bit registers, so val_count is a number of registers and the call
covers four times the intended length.

regmap_bulk_write() copies val_count * val_bytes bytes from the source
buffer, so this reads past the end of new_owt_effect_data, which is
only sizeof(header) + len bytes long, and writes the extra data to the
DSP beyond the end of the uploaded effect. The free space check above
only covers the real size of the effect, so the write can also go past
the space reported as available in the open wavetable.

Pass the length in 32-bit words, matching header.data_words.

Fixes: c38fe1bb5d21 ("Input: cs40l50 - Add support for the CS40L50 haptic driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ismail Tarim <ismailtarim7@gmail.com>
---
Build-tested only (W=1, x86_64 defconfig with the CS40L50 drivers as
modules). I do not have CS40L50 hardware, so this was not runtime
tested.

 drivers/input/misc/cs40l50-vibra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/cs40l50-vibra.c b/drivers/input/misc/cs40l50-vibra.c
index 7ef4534fe..68f0c40ef 100644
--- a/drivers/input/misc/cs40l50-vibra.c
+++ b/drivers/input/misc/cs40l50-vibra.c
@@ -250,7 +250,7 @@ static int cs40l50_upload_owt(struct cs40l50_work *work_data)
 
 	error = regmap_bulk_write(vib->regmap, vib->dsp.owt_base_reg +
 				  (offset * sizeof(u32)), new_owt_effect_data,
-				  sizeof(header) + len);
+				  (sizeof(header) + len) / sizeof(u32));
 	if (error)
 		return error;
 
-- 
2.56.0

