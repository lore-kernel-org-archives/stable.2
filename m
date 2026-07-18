Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D064243F0BE
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784360442; cv=none; b=XbvwOj+t2CW288zZVmWoUsVNrnmhkhs6/MAVrxUBkXF8WBBkLS5XBPZlTKa0+oZAphkDyIXBe1DpHInLc2o27O5p3yBN+QG9GSy89uhaC4nMawsrszW765GduO4HzUGrkbO9OHwv0E4MrjSrlNXIs+LXI82y5Jfy2gR9kJpWsWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784360442; c=relaxed/simple;
	bh=CHqctaXOh1YRZ6r+fEuQSQe/xUi6dXaEscZOn0peo18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbHbVlSaBiZkYqujs5WGUrvbQOHxE7cFXIb7ySXyw/ycNznf/kpWiJtBRess7mNEtp5XG395X/wllZB4HlOBc5+osVAHvQcAnlML7HeSjCSKGhjt4T379LrxYRnOsFUYW84Wtzhsvbro2/R2Ib4FdXAOb68e9VEMdHMLnxvKN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oIYg6s5H; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIYg6s5H"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381b831d535so5994289a91.0
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 00:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784360440; x=1784965240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4sz+zAG3Op3BP7KFhD4nzcWAAX6/+g0R994WeqVfx14=;
        b=oIYg6s5HLIDMc3ITOkP51RXdF3lw4smzJ9e+oK5O0nflXZhRV3DlsO5YOshePUv+D9
         59j6KdYJuJIpAtsR/eBlHbzKTb69pvtPVKmVEgg/1N9+687+B+Q0rkzqVADcXq4w0CVc
         iiNkDsDfF0YxPr3oAotrzIatxGavtbYv8wRH6XCYDLKpt/tFoRvl+Fzp4CyYUdvuUZlz
         kNFKVg7YMG/bXksEmc4r7fTVrMKOKhrFzXgMlbt+mruRrzTEdrUkX/ym75P9oQq7T6oe
         EItB4mP4FF6kK5EwfdXjqCVkOz2rpwL1zCK5lZv5BQCZ32JA4aojqz1XK29zy5l6gPr8
         OXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784360440; x=1784965240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4sz+zAG3Op3BP7KFhD4nzcWAAX6/+g0R994WeqVfx14=;
        b=Zaceh0Jyzp+tmRbL92Lpvmtp5G8HCQSVmHV5k+dSEXJ2Gegp7ITGWQ/R8GaUarFjU4
         xpv/MDwLrZCJkCo62mmj15aEF3PJ0CSbtEdUhaNRNxSet+h9qMLxfWmQMM4i+B9vn7Kq
         BFeX89lF5aumM0u3j6ObV7vbUkezew9Z1bASWyANdsLsWsz0Q3FTaBgGd4moQcfZxnGt
         R4ov+UHDmDBW+DG6QDn83LeIY9YMzyHDMwgiLYMCWS43hQ/PJYQxblM7qtZuY3uaac1I
         Oi/oAJe/HxdehhaD4go08V1Ck+Cs2CRwKp1Nd5ipK6eGweR+5DRJOkRyt6NcjSMiyH4j
         FS1A==
X-Forwarded-Encrypted: i=1; AHgh+Rr+cHShSfF4Fez6of2Y8zGq+4R01RZnsEr23gcLNg7pGoi6rQd9RZkNmAGO50Mwsdv7yHee6q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxln0DHAo8X7BWU1yfbKKkDZGgid+NJBKcJVHXKi7ogvib//PlL
	XAwPqm+XpgVuUQd+3qP3kHKIfwCxqaWb03VZjvgmfkc6ufaFnrxbfUlV
X-Gm-Gg: AfdE7cmATI1dq+swh//eFoL5dlFpW0CVKTaNQDxnDuvAVLJbqqbJu5yyPNp7tapUfSH
	7r29j430nTSOCmsP2eXukEcAn7xXjimHfCIc0kqa9VrIj1/9jQXB7iJINrTMq1Pf5L/EphFt8CD
	lQGvzICL1cEjcbB3zn94XIRTrncXzjZ8MW9sWtvEaRyLZ8y7NP8r3XQjhCJmo2OooBE7hDS7Bil
	phOcSKgmv06k4zLE0J1Mces0Rui8AEIkUSIZohGvCF6dgWurJZOhnGTzpASm6tmpuIxldtQGT+0
	pz/d8gXBJ/2q+8EWOE7nQvQ6iNskqJ39orFp8dD0/Y6DtPK4IVAvw6SAUS8P4sW8U7C6tUjgNJL
	C2juh46ynp3Or0TtQPslCa5Wf9wGd4vOf+BIDAt1CL+wZgNUl/LM8YDM1kzJHusIaBO0Ua6vTk4
	BmKXzeh8HP+CRK5rjHMKM0crrW5aEX2cnt0ajDmSFTidfwZLw3EOeCdTnmnRTPR0pMtZ8=
X-Received: by 2002:a17:90b:1dca:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-38e4b454d1cmr6489775a91.10.1784360440044;
        Sat, 18 Jul 2026 00:40:40 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e3a0d7a5bsm4311651a91.9.2026.07.18.00.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 00:40:39 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: James Ogletree <jogletre@opensource.cirrus.com>,
	Fred Treven <fred.treven@cirrus.com>,
	Ben Bright <ben.bright@cirrus.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: patches@opensource.cirrus.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH] Input: cs40l50-vibra - validate custom data from user space
Date: Sat, 18 Jul 2026 16:40:32 +0900
Message-ID: <20260718074032.1864861-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cs40l50_add() copies the custom data of an FF_PERIODIC/FF_CUSTOM effect
straight from the ff_effect the user passed to EVIOCSFF, without
requiring it to hold anything:

    work_data.custom_data = memdup_array_user(periodic->custom_data,
                                              periodic->custom_len,
                                              sizeof(s16));
    work_data.custom_len = periodic->custom_len;

The driver then reads two words out of that buffer: custom_data[0] as the
waveform bank in cs40l50_effect_bank_set(), and custom_data[1] as the
index within the bank in cs40l50_effect_index_set().  Neither read is
covered by a length check, and custom_len is fully user controlled:

  - custom_len == 0 makes memdup_array_user() call memdup_user() with a
    length of zero, which returns ZERO_SIZE_PTR rather than an error, so
    custom_data[0] dereferences it.

  - custom_len == 1 allocates two bytes.  A bank of ROM or RAM keeps
    effect->type out of the OWT case, and custom_data[1] is then read one
    word past the allocation.

The bank value itself is also mishandled.  It is masked with
CS40L50_CUSTOM_DATA_MASK (0xffff) but stored in an s16, so a
custom_data[0] of 0x8000 or above wraps to a negative value that passes
the "bank_type >= CS40L50_WVFRM_BANK_NUM" test.
cs40l50_effect_index_set() indexes vib->dsp.banks[] with it before the
switch statement's default case gets a chance to reject it:

    base_index = vib->dsp.banks[effect->type].base_index;
    max_index = vib->dsp.banks[effect->type].max_index;

Require the two words the driver reads to be present, and hold the masked
bank in a u32 so the existing upper-bound test covers the whole range.
The da7280 haptic driver already range checks custom_len this way.

Fixes: c38fe1bb5d21 ("Input: cs40l50 - Add support for the CS40L50 haptic driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/input/misc/cs40l50-vibra.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/cs40l50-vibra.c b/drivers/input/misc/cs40l50-vibra.c
index 996d6c38cca4..7ef4534fea2f 100644
--- a/drivers/input/misc/cs40l50-vibra.c
+++ b/drivers/input/misc/cs40l50-vibra.c
@@ -139,10 +139,10 @@ static struct cs40l50_effect *cs40l50_find_effect(int id, struct list_head *effe
 static int cs40l50_effect_bank_set(struct cs40l50_work *work_data,
 				   struct cs40l50_effect *effect)
 {
-	s16 bank_type = work_data->custom_data[0] & CS40L50_CUSTOM_DATA_MASK;
+	u32 bank_type = work_data->custom_data[0] & CS40L50_CUSTOM_DATA_MASK;
 
 	if (bank_type >= CS40L50_WVFRM_BANK_NUM) {
-		dev_err(work_data->vib->dev, "Invalid bank (%d)\n", bank_type);
+		dev_err(work_data->vib->dev, "Invalid bank (%u)\n", bank_type);
 		return -EINVAL;
 	}
 
@@ -326,6 +326,12 @@ static int cs40l50_add(struct input_dev *dev, struct ff_effect *effect,
 		return -EINVAL;
 	}
 
+	if (periodic->custom_len < CS40L50_OWT_CUSTOM_DATA_SIZE) {
+		dev_err(vib->dev, "Invalid custom data length (%u)\n",
+			periodic->custom_len);
+		return -EINVAL;
+	}
+
 	work_data.custom_data = memdup_array_user(effect->u.periodic.custom_data,
 						  effect->u.periodic.custom_len,
 						  sizeof(s16));
-- 
2.43.0

