Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2151E4AA3F4
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403041; cv=none; b=ZCIVMl1KrtcNlKzCdDYqiEfOb+nStEPRGmI2Bmm9/OQmpB2LRC9XWTBqmEAIB87WnOFP9hw3gz3KDBlaUVdwwmnsz18/xzu91HGYgYbj9XGbk6JWO4IKS8Gc4wRo/EreKwhZZC5w0RuovZwYQdcpDnzPTl1ZRNMsUNvUnOOuVKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403041; c=relaxed/simple;
	bh=eF9ybIO73BvXJx/tfM15TxxY0Adrd/pDfCRrQG6zpJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrYMZEJNzGPU0BZykg9j8swT3Qr3lRN3A1ruk8pZdTTht2gBm0rGm41YCNMalwhPmD29hnKzgxkVfOW1o+OJEem9ZMPRGGYoidm04m46X+7GJTMX9xO1fNnbHC8wZf9PB98cs9L87ZEcH1MGyfl8CVHUsw8bnVRNX4lPI9u6y2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZLHAr+5; arc=none smtp.client-ip=74.125.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZLHAr+5"
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso1862534eec.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 02:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792403039; x=1793007839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SS9kJ1jH1xG6CLAUi3XRMYbxFYxyeHVEus5/yx1itww=;
        b=CZLHAr+5SX+9O1+UKYUHozqaxF2RfMchhttSCgzxcKinJil1RdzUOe07aDVb89Dfsi
         ONyShNKWZhj4smiq1Cm8hyyN5E2sRgdpHp0mln5BucMZtPhbmILte6x1yK9sLQQvIIe7
         Q8IRR+fb+Gqe2GB9lwtoYS4DpAbIDF5dlOH6iUKoNfS0JWxeqYlCTCjE06kH8lcAZl8O
         r1BOSBW5oqmyA67DDa/5yX5gkDGmdj4sqAKc4CmCNycam4OvLSudgfllbg3LiEnjhWIS
         XqIJOI3m2k6YEPrQYQ2mZVbp7tuchL7XHn1XavSIEX7Qq5mUgic/Dz19Mq1OtiyHvFTM
         9Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792403039; x=1793007839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SS9kJ1jH1xG6CLAUi3XRMYbxFYxyeHVEus5/yx1itww=;
        b=Yjg7xLF/FBrUfiWlE2nIfrENaBjpYhg8b6ko+bIboIORkYvh4s3X8vT0YGUe2FjvXx
         bEdmUgjd0KwsM+WB+cp9aZ3OUHuEquH28o5vEVeyuMPoWg25qWN8lK12oxldSljCmMpY
         S+Vi+lgonbirPHfB+vI6XuNKqdgCURQ16HuZDWaM98UIKmbfQifRZyauD98UL6J6IwGq
         tsbKNLNZabU4WfV2Mbjd5nI7Yrg2bRZeqw8diODmf6WdI1c0pd8nS2h9+C4lAqI6LBRK
         P/H2+wqbTAGQp1oyVjQq7pmBkJ5AnN+PL/oLnNwVvXujg1PFZQ16NMvr6nJsbMvCNkEh
         l3Vg==
X-Forwarded-Encrypted: i=1; AKwUvByXIjix9wjxUHqbEK45aqQQTDiAqOIy1J32Uuy/QhxzpRqdkZ8so1PIbkLXC4E0Y3+ugNBSUmU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQEhm2mHO3d/OT4RFXNbDpaqOVt0dCgz3ermhFb9dkKiyg0e7q
	nV+vJmNximJPXdEnQ5yoWRPkhKLyErmvarBP2ssr6IVZoyr4szXPmMgu
X-Gm-Gg: AYBFou1cdjxgCLbsMPC3GQcaud/9PNMz29ep5DIGCyKtsz8x6UDlZ62gG/r+honBheD
	rswh3bBNQSe7nrsnpE+iQUSiIGyNP9vy1NScCRLUr/dO9FQzJOCvoxQHysBmPIew2oVURSg942N
	vy9f8djBmEcZkuLkKQh9SakyfcywSJhik9yAdfmMMZOoOzrurwQqyWA7DixE9ctdnrgyualOod9
	Ga4xt6Xw00IzEbUKih+/DkLGCh96jugFL9nax5tOC9pYIWoHMJn+wV4yCklexf2fjyRPNayIuHD
	ENWspS4uRhcGpQZ6v+17FRmO9Yz7NtFJn5IjdjiheZx1ICEPdfaXrA8R9yQdZYActSh992wwhWV
	yAM3/3cSKK/dsBLqbvCNeryTzv7DY7+G+CUfpVEWfWSqA7jYohtwlwkfnq62tlQTtPsCid8R/bA
	vokCGt4KhrVJJUzCw7Il+0Vy69mKGVp/2eMbRe2nhTy6VjdAWa+S4HxTdoko3EZhOnZEB8Rcjc/
	imjIETLSxBi5g0mn4qIZloUHl+sIT7DhrQ=
X-Received: by 2002:a05:7301:6404:b0:360:f13a:ff0e with SMTP id 5a478bee46e88-361a1b539f1mr10748987eec.23.1792403039178;
        Mon, 19 Oct 2026 02:43:59 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607bc950f9sm34370074eec.0.2026.10.19.02.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:43:58 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	Yao Yiqi <yyaqia@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 3/3] fbcon: Retry rotated font allocation after failure
Date: Mon, 19 Oct 2026 17:43:31 +0800
Message-ID: <20261019094331.1128871-4-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019094331.1128871-1-yyaqia@gmail.com>
References: <20261019094331.1128871-1-yyaqia@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() records the font, its geometry and the rotation in
par->rotated before calling font_data_rotate(). If the allocation
fails, the error path clears par->rotated.buf, but the recorded key
already looks up to date, so the next call takes the early-out and
never retries. The rotated putcs/cursor ops keep returning early on
the NULL buffer, and the console stays blank even after memory is
available again.

Also test par->rotated.buf in the early-out, so a failed allocation
is retried on the next call: at the next fbcon_switch(),
fbcon_modechanged() or font change.

Fixes: e4ef723d8975 ("fbcon: Avoid OOB font access if console rotation fails")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
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

