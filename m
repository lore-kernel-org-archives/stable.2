Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4232E7386
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970256; cv=none; b=Ok+bn8Of3ikkg/DZE19cC6YRGTXrJq+7SVbiUgZ3edGnPT4sqEjx0Tjm+3CMYXcK6boLXvxQ7Na0UQgTd+MygVefp3wzssQBVVIjlch+pwDSuHsznAs2qrYXuuYQBHclL69F7xIKaV8cFU/PaIXfQKzxL7HZiDGBCZiTA3O4l0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970256; c=relaxed/simple;
	bh=g4PvjzPCcElQbeQlLfU+ZIN83VWtV1OZbgKUmeLbFQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BCBWPn9L2Rj0PTWxR1/O/YtUJzxJQVRB5Q+p4NoKc65OAGdFCsqmY5wdagKLNAOUpdYPl/vi6BCB63F59P7UdsMI0oBVB6v/L/55pRXVXlFdBsFfDTHHE6tLuIT4+5wjpH0kcxBlYUmwVaAobQl3tf4R1gKXUMpngr7XSPxun/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqJvhqtR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqJvhqtR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ceaf8a1265so15532335ad.2
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 02:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784970255; x=1785575055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JNJX8bhf9EovDC7uNam6NgXdE+D5leJXoA9qIm65qSA=;
        b=VqJvhqtRBhH226OHk4Bm8Mj8w93P8bwH4TstpmoGQXTFUbxys9BgP4lvhFhiAHDFC3
         AOlMbqVO3qpS/4DYi4gTkqypdsKlXJdlah5OMg/A8H9jQmFvr3nnSoulvOn8h/n2w9EE
         5yoL4Yi45bgP0aeCGiFDbrW6fBxGyH8NXm3S+viw5xpAi5Yfz/xdRhFupgegYjaV2CjY
         7u1U05nfbE4o5Fia1dtXREY1+/3UPM5aE6kOKLoCyhtCk3szKNieyumC/rtRMYoLew45
         tcSPwV52YA9u9qrnol9qYbHolmAzWO6RAeM4A09MWvc+vHRvpuC/ovPWZTVzZ019eg52
         k5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784970255; x=1785575055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JNJX8bhf9EovDC7uNam6NgXdE+D5leJXoA9qIm65qSA=;
        b=fxup07VyxFDYv1kjQQOZzWHO8XPjwIItV4qMaokm1TOrtjz8cue4JTaVFIdSaGd8A5
         chPOM3bjmfUPZRYzwMTFEnV5p6JuaTLTB3NfVzNLuMYRJuGNPkHEa/9KD3xMuBt0eEfs
         LCTNFsz6P3Bpdlhhzmz1+Au2IeNxch7f0mR0EM1niWAENfXZXChco7GV64yZyu22CWUj
         /X5hqY+FmrL3n1AgQLwPHmdduyJSUozBSeW2mCYC2Hzvi6BmgVqc1uQ6UCg3SaIvY/Uz
         93NRy7PjZGQo+wgMAHfCc6tDHPtWb1MSz6FR+6+tPSDI6AGYxGxHGs/SZDzM0kwE8Lnv
         HlBQ==
X-Gm-Message-State: AOJu0Yzkmwf/TQoJ/Vl+vrEeab2kQvtixiPVYCZcgQWwaFm2z9AV1P1E
	OoCNnm2oVXgh10+BX8TK6ZmrscTYu4wwNAOdxZBEredwpkdkmLzxGOdg5T8oRg==
X-Gm-Gg: AR+sD121gkSCGfdHW0WCMZFevwXrutlbqC066KbI+SAB6M8K8np3HR9uBjKvvzqt+d2
	OQmMjEdTfi/tHNXrgS7uOw97x/6WhPDU8iUHtiZaeM20PfYiz7kJ8RCnvn7FDWRdi7YSyFEJJhV
	QNOOPYnHSW6rfiZ+8r7g34jF/FWYMIpJ71Du3luNGcc0qduqSThiFUz8hPGFOhNWWy8PGrRwHFj
	ep4J5SOKJjYVeRuvT6X6K+BBrnm4PsBMyGujqexYiReZ42Vubfm/3sr9Q+CJPLcdI7Qn+13F6wr
	54S0jk0Zs0k3MqUzZlJPzwCEx//VPmlMbQwgpw2boL432HeAqdMEu/SKR83EFYIAo1HG98n5ZT6
	6+BPCd1ili8l9pB8l6uu9FP9n5EuH4YGw1oYOoqdmbCtfOiXu1t+YekTdzPfFXP0a5uR63tj8Lv
	5/JuuimzTmau2WggR1KA==
X-Received: by 2002:a17:903:46cc:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2cfde67beebmr16593625ad.2.1784970254783;
        Sat, 25 Jul 2026 02:04:14 -0700 (PDT)
Received: from localhost.localdomain ([14.218.53.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e26e9sm7423475ad.23.2026.07.25.02.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 02:04:14 -0700 (PDT)
From: Junxi Qian <qjx1298677004@gmail.com>
To: stable@vger.kernel.org
Cc: brauner@kernel.org,
	joannelkoong@gmail.com,
	mszeredi@redhat.com
Subject: [PATCH 6.18.y] fuse: fix writeback array overflow when max_pages is one
Date: Sat, 25 Jul 2026 17:04:08 +0800
Message-Id: <20260725090408.29442-1-qjx1298677004@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026052021-bless-hazy-b0ae@gregkh>
References: <2026052021-bless-hazy-b0ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_iomap_writeback_range() appends one folio pointer and one
fuse_folio_desc for every dirty range that is merged into the current
writeback request.  The merge decision checks the byte budget against
fc->max_pages and fc->max_write, but it does not check whether the folio
and descriptor arrays still have another free slot.

This is not sufficient for fuseblk, where the filesystem block size can
be smaller than PAGE_SIZE.  With writeback cache enabled and max_pages
negotiated as one, contiguous sub-page dirty ranges can fit within the
byte budget while spanning more than one folio.  The next append can then
write past the one-slot folios and descs arrays.

Split the request when the number of already attached folios has reached
fc->max_pages.  This keeps the folio/descriptor slot accounting in sync
with the send decision.

Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
Cc: stable@vger.kernel.org
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
Link: https://patch.msgid.link/20260506122415.205340-1-qjx1298677004@gmail.com
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
(cherry picked from commit c3880a7b10e487e033dc6f388bda118436566f7a)
---
 fs/fuse/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 79d1b502e..585dd9036 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2140,7 +2140,10 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
 
 	WARN_ON(!ap->num_folios);
 
-	/* Reached max pages */
+	/* Reached max pages or max folio slots */
+	if (ap->num_folios >= fc->max_pages)
+		return true;
+
 	if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
 		return true;
 
-- 
2.34.1

