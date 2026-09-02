Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A3399D02
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353466; cv=none; b=CzVSN0RH1hQnrvHupWoHEz+KozDirh9ExvcawkSyYjibL92M0RDytEpTe3biB0SW5GZnzuXIacxsRpkoAoiSPRut7379pZpL60cKvMKCZcKBhCL9aneZjI20qUxqrqNh/gQMkwPaA87Lmzm6/3mtZTo00ocacr/tre34j9BmI2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353466; c=relaxed/simple;
	bh=ecEXFaEnVYmO2e9QRthYzOTSjlkOMF5vYVDqij9XjYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYXmc8l2R3T2U15gg1dydkcMVnOE/Om3R5eKTIcEQ1+haxCG0Ri+KN4WZjPZ+wsoFcFEnMyOO785yRXpJh6vV6TrU2RJLGNtSgJQhO2XMrg23PlqasoUlkFezXsnLblUTT9cJMq534itVwYQ0q8Q6+q+nAGuQQJ+wMk0Ovl+XT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btf7j+4U; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btf7j+4U"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1e1ff659bso1040751a12.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788353465; x=1788958265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T7SlBp/TfciBcHcfPFcBhzWo1fIummbWtE2eKXh7ROA=;
        b=btf7j+4UFuxC8r9oy2GI3vmN7AJcLH+ZVC5qUpgJWnVnrH3eeZYpAa4nN0E6Ck96i0
         ID0ftUa0hkOfzIg6FN447fVMsVs0usUxmeRLlIg1muRyVTwHFIXQbU/gf/bNhkcVdfsC
         gtMJp8fYzxNYjOMJrtrTwUoxtNtLocSOxwehHZo/Qrzc6HO3aoNQ/YdjxqROVdMY+OBT
         70vAtd1JI04F7rcFVTJKdmeH32KwBU9GOSYMBcIWsDnsJEqC8AgxrwTEpxFNGl6EUAY1
         5CFHkIVjuICogANQDEHMVg5Rd6doPNzBGje5QZyvrESCscmAhHFHXTdSi3qLb5NutonU
         rOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788353465; x=1788958265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T7SlBp/TfciBcHcfPFcBhzWo1fIummbWtE2eKXh7ROA=;
        b=Lj3m/yG9B5O+6wjsygAm1oMK+UBTxgetjoDnV9SNhbKX0ONJfXJAx/z56N40/3/+hQ
         uEUGXKPq6E1fPYpMSGa55pzNSHlnJ2vn8ZOCRSa70yNOjEFAkR4enTvHX3mR/1lxD6CW
         VjYnpvgX4f0um3LCGRN0UrISpavhid3xAEjp8N/lBJsShIYeg1RVAgD2908SBZe18/KC
         z169P0dTWCp/x3eYACFyZfItMUz84rhqdKK2CSgCr65z6zvNKEFVtbbTMi6roEB4wYq8
         ndGT15U6GbEelysRHVKpQgwnz1dK2HFPtGVUxQ/YzroDoHZFTrwT5hmPsZ7qIUncV4wq
         93XA==
X-Forwarded-Encrypted: i=1; AKwUvBzsx+ThwMBUqBrZAfTIXmX6IIABF5flCNktJ3iDXby/g/iRky3GfJ14B6TtnkIUrXYmpcOqlXs=@vger.kernel.org
X-Gm-Message-State: AFuF++m5FuMaU2bCrXRbZVb+ZuR55Zs59yIqv8liSHhWcZbwbNJqVcDa
	PCz7Cp+GcMJ6apPVLr9+7BUA+z9Z2FB9FUmsNwckTqvRpPjCk+CU//ZQ
X-Gm-Gg: AYBFou104RFgx5QpLeIfTC3mRZaYxuAK9ehzBfm0KSoQWaoyveFTf5TVR+hGc34zAyP
	BZmab/FN8VM7CebROhEZFGGyqZyFt/QVV7d+8LayXs/Xx+UbVrBZyVNPiggrv7E1iTZVeye8fsw
	Es/t06Lxm9RWBBK6zmceg8Kok4na2FX5V0KJLnCtcFE48/vkoL1Cg+lpiqlVdX1JayeT0ZwjAcQ
	c3MJpSEf4LddrGRFBq9l/y9Uj3qys2VN6xfFzKY6/2aPNf2gbpDXGk+xwwPZF0ZmhtYOOGQZDQU
	m4iOjD1hvH0V5cYD91XLiFZUF5XU11HG+byqXvGB0jBvW6gd69CrW8WwFyazPoMK7LOmMB2mNfa
	Lh7YPSrcteGcYyKxb0lWc7It/Oj/E49szI5WpTg3s3ZPpZ7fXQZgKxvo7Iv8Y3MT0vU3GaOjGxt
	wrkwIurRvnKOermWBWM6uJht7grAFYB3E7MmtfY+lCRzC7l0oD8h4DTJygQfEoWxxjT9a0kNFv4
	6nxYkOEcwfjDgsu+lncBtejUUDQcju6DVH/MHjQ4DBErlqTtiYD
X-Received: by 2002:a17:90b:3b8d:b0:398:c292:ac80 with SMTP id 98e67ed59e1d1-39aedf55732mr6562063a91.10.1788353464642;
        Wed, 02 Sep 2026 05:51:04 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d76463csm11856219a91.9.2026.09.02.05.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:51:03 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH] ALSA: rawmidi: Return the error from snd_rawmidi_input_params()
Date: Wed,  2 Sep 2026 21:50:58 +0900
Message-ID: <20260902125058.19499-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The snd_rawmidi_input_params() computes err for the three invalid mode
combinations and for resize_runtime_buffer(), applies the new framing
and clock type only when err is zero, and then returns 0 anyway.  A
caller that asked for parameters the kernel rejected is told the change
succeeded, and the substream keeps its old buffer.

The open_mutex conversion turned the early returns into assignments.
It handled the output sibling correctly, which still returns err, and
left this one behind.

Fixes: 94b98194b62e ("ALSA: rawmidi: Take open_mutex around parameter changes")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
Reproduced on 6.17.0-35-generic with snd-virmidi:

  INPUT  buffer_size=0  -> ret  0, errno 0
  INPUT  avail_min=0    -> ret  0, errno 0
  OUTPUT buffer_size=0  -> ret -1, EINVAL

The same rejected parameters report success on the input stream and
failure on the output stream.

 sound/core/rawmidi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index bf504e27f73e..f9cef3c61861 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -782,7 +782,7 @@ int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 		substream->framing = framing;
 		substream->clock_type = clock_type;
 	}
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL(snd_rawmidi_input_params);
 
-- 
2.43.0

