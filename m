Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9814B4A7CB1
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400556; cv=none; b=qqAV5jQJ4UqqwumfTCA9aYiNPDX03mziiV8w27YzMb6MiXC3xaOygdlcsa0o6THlE+nSb0TxG+D8asvNdgSfeO7kzlg5kfx8tlUSZ0FB4NhFW+V49KCS3l6QqA2b4bU1mjnCSIU6Td84D78UOJbhCAimBRu7pO4s/z89nJX/174=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400556; c=relaxed/simple;
	bh=eF9ybIO73BvXJx/tfM15TxxY0Adrd/pDfCRrQG6zpJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+zwJrJulRWAuS6ATcqYzu5SpPqh2xEPa69765u/TKM99R81UYHtY/TU8qY7AJHmxPIwMZn/iNUpgPD4iOZFx9Uhz/aL2fQgxfTNB345ITDgX+qlrYdtWFA9PGuMTHqXK7r22mKFVEGg+/QyIsZwmpBmWb8EWq62oHzl/BHl7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZK/ENO2r; arc=none smtp.client-ip=74.125.229.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK/ENO2r"
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-139b659a45eso508017c88.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 02:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792400549; x=1793005349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SS9kJ1jH1xG6CLAUi3XRMYbxFYxyeHVEus5/yx1itww=;
        b=ZK/ENO2rN2TZeuiApTi0/qB8qiJrAAE80GgDWCvwwP8dL2ZTy5i9Pz70z+UeUgJHby
         3S82CcH+cC2/NhwZMF+7sjc5KClPEX4F62m3AiHAklTrePFYeYBOXfZWdvi+3FIfPFuW
         M9ncQRUKVqiwm+ka4lz3IPyb5po/cjid+qotIGvWmO+QqfGS2VI3s05NC+e4tQzBzaf7
         s0BSHTbM5+L7ObnGu29xgI7kNK97H+PbSL2Dhk3GjrYkISoyYPkJezBUMfKZKNT9H0ol
         BjDWF60CSZX/owIN7DtTj9UJsHBHWXu8ZQpsV615J01bKdv4skcv+IbR6dTiedNIp5Qk
         J7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792400549; x=1793005349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SS9kJ1jH1xG6CLAUi3XRMYbxFYxyeHVEus5/yx1itww=;
        b=IxBVrZi02A7ag++lIPB8i9VosvbRZiOO0Jjre4qm3r7HQ3sKTpo2TOV/s7hngJApKj
         oE3qTSEDahiHzMbT+7jpLDdk+52RigfGMKbIC63HDoA1saabtsCxiZbJHK+dx2s0Bzyu
         kkMs5eOhPXJnNHhnVrDcTo8UY1dJjU8WqdWiejmPXHSqKycE/I+V8itk1/icVtUxpKA1
         nI0M6Hq8+hVItBZFN1ZTKL5PqMEImbIHWlow32Kxqm/F/3U2mObwOwCnwvqUHmNKJsoX
         xeQ0M0A8RVCWTbfiaBWAL7aRPQNMJ3mDem7I3yD4NjmLet++D6MDskDny9VeBVp3qGma
         9qpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHlWueTO/dcvKwA6osfKDFa6TYnPctBeb4ehtbZbpDgZQut2wGRoUIkS+zPU4w5EYokUSmSfg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPXa5+AmRMkKgjFs5O2Ww3+94vy25M/z31Ratno1WFOdRJdLq0
	as+iD99jarqIL5bFTTvacfdJSD2qzHRd9gzTpR7Hj27CN50qx0HoDgwA
X-Gm-Gg: AYBFou3lXz4ILbb9QylrGnuQOoCdoYDV72XQFXGysA/lauXIurjY7gNNjEZKCF4JFGR
	JzrX1eS3yrUzopdcy4NhuizHJfilI/DAlN4L6SonyWAQs7hox+XxsyjCrQRZFXngyhJyAt6YWLX
	wf8A8EXHjGTPjzSk6V+oeephr6KBgd8wQpWb6Y8rGLR7A7uDY7Lz6u/TgNFGjBTP+PiEThfk+th
	r+hNCaDCIoFgO5j2BLZrATG4HBfsHAKkpkWzk8jGDRkbgcE556oGAd3IYWOoST0izciwpX3LZNx
	ldO8p80BdJ3AP3cGJPXIxUk4lWTO2bAm3lFrZBSO5+S4cloUCI140kWv0lSDr45tCy9dZkJmkkL
	JUaYGw5smsbAvfhq1IQW8Wj7ebTSg1HYXgEfs0nd6tmlUHqF3BtiS3oCXZJR5XysO1iw/s302+l
	Wx3gFIrSupQGOtDTVjNLJKyygpXHd5eiXjbyaStCK/Fgy5KZ+IZcPj3/5JcamspwJRqWWRYBE3X
	qn34VVofWbnz+EXjhorr6eyTnl4pBMJgag=
X-Received: by 2002:a05:7022:eb44:10b0:14e:d0ba:7569 with SMTP id a92af1059eb24-1850c502379mr10698378c88.6.1792400549264;
        Mon, 19 Oct 2026 02:02:29 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm27085064c88.17.2026.10.19.02.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:02:28 -0700 (PDT)
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
Subject: [PATCH v4 3/3] fbcon: Retry rotated font allocation after failure
Date: Mon, 19 Oct 2026 17:02:06 +0800
Message-ID: <20261019090206.1094958-4-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019090206.1094958-1-yyaqia@gmail.com>
References: <20261019090206.1094958-1-yyaqia@gmail.com>
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

