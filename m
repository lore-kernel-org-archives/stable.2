Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1BE44B68D
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116360; cv=none; b=QahqQg9Xo7KdCPXjK5ZUHaEx60SsvGqaw9IKTlLrWqi3PjJnrDUkAY/a1nx8AJkWgnsDkDQ0Y2ZCeQOTzb05nESCVdXRJglMp9PzrdDWbRScRh7xjQY4/Td9XSKUc68dx1mTKkHl6X+HrjpDLFO4MbbdjUW2nImorPRXHFDspVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116360; c=relaxed/simple;
	bh=W0KKEQjvprOowhhqzNy5pT4VFCUxCqk/sF/W6pg6t4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUXZqV2tJy+cpQEcHZ3otQM/EOmeUyEk7gVWLCynVvIDwKtjyQpMBmDdxeUQSxSJgkG8OL/S1mjufKM3izcFAnY21q4rsqpTrEi6mJMHZKZRatdv1Ionp9AnA9Cg0vw44rzUWk3RWBI7upxujaRt16qpkF1+z3Ygmk94e0cVFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qkcrOCCA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkcrOCCA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc73e322dbso64199145ad.1
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784116357; x=1784721157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LsuD+p/a7jppz5lNGczD7IlYV2q0inMB+mXZMgQrGAc=;
        b=qkcrOCCAaLaOrLj4Az06mjuDLhdKwFi9ZIFRf8XAZQF1l9SX+ywo4aZFPmlDYn1P/j
         Vhee+aRQT8K7Klb8/gASLwjGNrWvR5o5aA1UHGXR1DXZRuNQs0O/kCWeTxUmvY/Kv3Nr
         1m/vQWXRMetLqCEuzqoG4iyRH13tI7vVRxTceC8D6q3p6HA+WKlMce98D2XlX5YmdCcb
         QMRZEyAdZKxHbd66QIWyctuY86suDqXwOPPXbJpauzb6vYtL9dXuQyfFabQj7qlI4yMh
         0R3gkClGM77R86YOMo+VgbVPnuA4kw+9RjMMnv8W/1Hiu8/t7gLZhpwLQHZPMZCCqZR9
         og7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784116357; x=1784721157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LsuD+p/a7jppz5lNGczD7IlYV2q0inMB+mXZMgQrGAc=;
        b=D7rWObGKYx3Jd9ZiZ45Wb9bLZwPhT/X83Tp8Vcr9FjTNzwqSy2H/potr1c0Y1oHJ7k
         8TxDSXWBtQvKDZ3Na/Zesu2CqU7YA3FfxtzUMT5yHfV44mZxi02IrNluMKXChNbyLbkp
         fGoEJBXsYqz1HmcZP+NE1o1lRbcSjKKoW3s+sQ62TPZ+RZjYqNkRFTHFuw6gHd1InGaC
         TrEN4J5ZcCrYaMgt6RAJMBFdyxRHUcFqYcUMoa+4lUiWf3ZAUIdX32zW/L5meDDOcusb
         ZjcHdFw938qHOwh+r7mC7xF0BQ8gA/rHlffpPgnkpXXbwZc+LTlC03I4NYBWTMOTrGyo
         kDeg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3WVDDUyPHr9HjGAvP2V6cdR9eoLKEbM1eyipqZFNWUBe+g/KnvvTc+V//cEFlnIdTMNIzPrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtkQBk6MyatDUWwotZ3jrmOzUWbg4L4h8Da1V2SSxrK92B/eFi
	4f2EDOSGpqYlEGRlUqwtKCqXE6O03UB1On9T08Sxcq1AxZ69ZpgPiICl
X-Gm-Gg: AfdE7cl9A5kSFsQPszQNzK5rQAhsA/BXj1LrcpEFC32leYIPSAPqTHcb5J8qYKQTQoj
	14t6atYGuYvjiFhri+dJyfJ5DYDTnjAwP655L14SXA0SUWRFLWuaUhTMpumVoKMz6q+KoQvA3f3
	gP89dDi51GHmSG0cR+fkg/yQiIGrvRqCRgT6am+cqNgqogcF6JPc40WTDYc5qOyRc0i/jawnkNQ
	ikFZtVRg0r3QEguqpZTdpVsvqmwB6/3YSb71+KGkBHp3MbLe0OyzL+c0ACruH2aI3ELWzemf7qV
	/kIkW3ZSrP7fyBx0dFGByrF9RMH/tI+SCIhoG8nJ6kozHl/uRTZW6vb9GVY7WEyw6naKR/qE16l
	udFyN9VGufROpWnnUI9ncIw8qkuCe2yF7FODQ2BbxLCT3kqZD3Wcxj42zJ+Zcz7A2Wg2hpQD7Fi
	biLDgnLovMpYK44OPl+S4asNV4AsimLsWR2PlrmwRWQXU1nKeRPUsT9RVLHbfQue5Q/9sJQ9cA6
	KvoWw==
X-Received: by 2002:a17:902:ec81:b0:2c7:ebfb:618f with SMTP id d9443c01a7336-2cf03cac9d5mr21793895ad.14.1784116356954;
        Wed, 15 Jul 2026 04:52:36 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf106b271asm1001305ad.64.2026.07.15.04.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 04:52:36 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Hyungjung Joo <jhj140711@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH] fs/adfs: bound directory entry name length in adfs_fplus_getnext()
Date: Wed, 15 Jul 2026 20:52:31 +0900
Message-ID: <20260715115231.1585166-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adfs_fplus_getnext() reads the per-entry name length bigdirobnamelen
straight from the on-disk big directory and passes it to
adfs_dir_copyfrom() as the copy length into obj->name[], a fixed
ADFS_MAX_NAME_LEN (260) byte buffer.  adfs_dir_copyfrom() only bounds
the copy against the number of directory buffers, not the size of the
destination, so a crafted image with bigdirobnamelen larger than the
buffer overflows the stack-allocated object_info::name that
adfs_fplus_iterate() passes in.

adfs_object_fixup() may additionally append a four byte ",xyz" filetype
suffix, so the accepted length must also leave room for that.

The old-style directory parser (dir_f.c) already clamps names to
ADFS_F_NAME_LEN, and adfs_fplus_validate_header() validates the header
name fields, but the per-entry name length in the big directory format
was never checked.  Reject over-long entries, using -EIO as elsewhere
in this file for a corrupt big directory.

Reported-by: Hyungjung Joo <jhj140711@gmail.com>
Closes: https://lore.kernel.org/all/CAP_j_b9BqyQrk3D5nj6RSa=eGcs2HkRYsWc3WdXeXp9O3=z4nQ@mail.gmail.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
 fs/adfs/dir_fplus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 4a15924014da..c68c301d8903 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -192,6 +192,8 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 	obj->indaddr  = le32_to_cpu(bde.bigdirindaddr);
 	obj->attr     = le32_to_cpu(bde.bigdirattr);
 	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);
+	if (obj->name_len > ADFS_MAX_NAME_LEN - 4)	/* leave room for ,xyz suffix */
+		return -EIO;
 
 	offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
 	offset += le32_to_cpu(bde.bigdirobnameptr);
-- 
2.43.0

