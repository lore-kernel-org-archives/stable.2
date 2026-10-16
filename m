Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B6E3C1991
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122359; cv=none; b=Ixsepuo9XLqVZV4iWdeaGmfOZaVbEy0huZv551ORQUNgkPOqXb2MbnFPRamzJ72zyPTY8UnVw965w6v/Rxkhyc5gPPNtMRImON1LE7WapkT4QSLd+oMWAsF25pBS0pDmudm/3A/XyRgsF7VTXwPS15npcBBZir3A4OUPFLPOie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122359; c=relaxed/simple;
	bh=WnSQZDNJL9uStHjJfld+aO4hEqR5unnU5IUqR5eY5Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J37Kv4gevsC5RxtRm9Czrkfxe10Ug1Zoz4HtvvpzvOThQnMTPPp5HZTqMaxTcBA2SFpNgz/i/NGKTDQ/UYjhzqg0rsvCER9S7O5faf2UkrfHUpmA27CHPVTrr6iKzyGkcZ7icpu5W+dWWwmnYjMsSnTTLri9PLuH38KUpvyWJn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHgDaGQa; arc=none smtp.client-ip=74.125.229.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHgDaGQa"
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so1742850eec.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792122356; x=1792727156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qZAMtIxyqaOU5P+355zxZjtsgqUUs04q64AQMCXAlLY=;
        b=LHgDaGQavx9zoz0CnljBdZLS17tEswmX2KpLOHjRNEhsM77miJw+Lv5pvgtv+PYfP9
         kn8JMOjEnxp5iWoRjhyO2UTdInjKLnxr9TcZagwb6tzZSNefxcTe47FnzZXT+10hc+Wh
         Rfx8ZYfcdI4IAb/a1Kedvhdmshej0J5jBCvrhspfqVQO/N2zxg5cZEtgXmSsWpXXcXZ5
         0idKefeD9oG+Gr1ryqiy/9XH0kbRsi7h4JYRNu5F9adPWiYZjdtdMabecPGsAy6VMt8t
         +gqOTwJEogUMPT4SB7FA/N4+t7PmlJhehMt6slrT73mrj2LyE3g1+t8Gife6/MWJOo1q
         m+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122356; x=1792727156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qZAMtIxyqaOU5P+355zxZjtsgqUUs04q64AQMCXAlLY=;
        b=BFOh/w9afs1YanSbs+5vyZ6Ucsab+BHKf4D5MOKBnir9KCj65ppVBKrPa9/+ZhYI9q
         JIYvrKphfdmJOUFmRd/Y+Y3w9fdcLRvegGi8QiE8zJ7ndRLN8btIXw+L99fBzKujPPMy
         rUR95GCDGLm9x2hhsfZe7mAeLhycVM+To+wyVK5iaB82/qeZ/NLJCCyNY3oTr1W1koYD
         9fELPGg9fDzOYN04yYPKqnxA0AplwVONL58/lWZxN5T4VO8u2VPzbFOpYS6wzpg5+feF
         P0OmC25VmlWBZs4lTSgzYvo1BKAg4X5ek5aCRriPZiSnUZ4QbyjVBlsc58X9QGs7mL7R
         auiw==
X-Forwarded-Encrypted: i=1; AKwUvBzHxLNEkvE4ltf9qh9ByaNarn7AZvSkli2KfAP3VvgwkXo00iwCW1sdjYCqgIziZxD4b9C3aVs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJn5ld78QTnhQiF57tp9rkpMUURoTXFtlhSiT7MIh1QQDmnNtm
	dnFBaV13U04V6JJWjl9b51Ev/+eLcsBMDKWQIW+Oi8/pNUAQHzKwQxxX
X-Gm-Gg: AYBFou1AtB8fBybKMiTCph8hCquAKjo7XU7Ip0R+wwN/yhXfymPD8JuuF7K1xb8Krd+
	CtRDTkh6xPNbYS4Q/ScCqSwYFBTd21ySSvwlDWJkd5Gb15o3JukH2xnlhaV6E2wTa2InNt1OtRl
	LOOwthYljRLc7shphmlbxBafJZZXV2jVDP5c/UzLEl/lJ3jcBr89w8ydfGBUX5uEINX/VSWrGBO
	IL8IQf3V6knWIDqQ3JIJOjwCgtMkopD09+LuS99Em6kDn/XRkiAnGYO+M5pxfKVyuPtyBvEfHnt
	on9yPVxSqtTKaLYocQaa7dQzMTQihnyQPcapRK/LvWKI9kGFWWN/cWFP6BQZUJ77MU8IeH2L6Mk
	9enXFSGUlnlciZa3WQAabQwWeyckp2eimpyFyYxbcCMYM9C9xujG/BJsKbsAyFb6Cnnt0wtPGQu
	sQJEFCws8AUW9Os1jH3YY0wdvVfYGzU0/40bzp5cDwRljmBGfeLg7LVDuXiHcQSbGPJD3aTO+FD
	11NcJAoevLGl5YcqTkk56ozzmNga7z0B2moxd8=
X-Received: by 2002:a05:693c:41c5:20b0:35c:ba31:6fef with SMTP id 5a478bee46e88-35cba3173b2mr12712550eec.36.1792122356200;
        Thu, 15 Oct 2026 20:45:56 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608297f4f7sm2434229eec.23.2026.10.15.20.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:45:55 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
X-Google-Original-From: Yao Yiqi <yaoyiqi3@huawei.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	Yao Yiqi <yyaqia@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] fbcon: Retry rotated font allocation after failure
Date: Fri, 16 Oct 2026 11:45:33 +0800
Message-ID: <20261016034533.445862-4-yaoyiqi3@huawei.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016034533.445862-1-yaoyiqi3@huawei.com>
References: <20261016034533.445862-1-yaoyiqi3@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yyaqia@gmail.com>

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() records the font, its geometry and the rotation it
is about to handle in par->rotated before calling font_data_rotate().
If the allocation fails, the error path clears par->rotated.buf, but
the recorded font, geometry and rotation already look up to date, so
the next call takes the early-out and never retries. The rotated
putcs/cursor ops keep returning early on the NULL buffer and the
console stays blank until a font or rotation with a different key is
installed, even once memory is available again.

Also test par->rotated.buf in the early-out, so a failed allocation is
retried the next time fbcon_rotate_font() runs: at the next
fbcon_switch(), fbcon_modechanged() or font change.

Fixes: e4ef723d8975 ("fbcon: Avoid OOB font access if console rotation fails")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
Changes in v2:

- The early-out now also compares the font geometry (previous patch in
  this series); the retry covers the combined key.
---
 drivers/video/fbdev/core/fbcon_rotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 660a3fa81bae..7afd63dcee7b 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -25,7 +25,8 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	    par->rotate == par->rotated.buf_rotate &&
 	    vc->vc_font.width == par->rotated.buf_width &&
 	    vc->vc_font.height == par->rotated.buf_height &&
-	    vc->vc_font.charcount == par->rotated.buf_charcount)
+	    vc->vc_font.charcount == par->rotated.buf_charcount &&
+	    par->rotated.buf)
 		return 0;
 
 	par->rotated.fontdata = par->p->fontdata;
-- 
2.56.0

