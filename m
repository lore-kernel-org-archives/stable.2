Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05D4FC8C3
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075052; cv=none; b=N5O4VDO2zl9WqKSaZLFwiw1esvTALAlLpwg1CFWqUrxWspD3t0OhSjiHQx3Uea8HC5GupYe3o4aDWh7FOGsMDIvSUNzq8ARcw137/VOf82/+38sPRqEtg2GD7YhAvAq0XVQb+WNJPonstAaxHkImQpf33JfNdPE1bvf+fKCR+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075052; c=relaxed/simple;
	bh=j7gZ6TXkXJoVoi0DjjsB8LTYhg+sFQDgu1glaic8P9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fp0zgp4vbKWrXNG3kaTuk5W/19DUw7J9ZSFoovSRF0qj0YRIMnU494Kv1JKSx9zPcMov74xoBSzIr2DUTB76z9CCJZytWcXZhuAM8EulmlDBfFgwWzB8VeC6FYNd6dO4eEf5jVR57E5pNag5SsbGJ/hp4Xy8nIrWRH0eHsMemQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFVhzlWs; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFVhzlWs"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so22443105e9.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075049; x=1790679849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ws6kEEuC6Y/oD+AA4pY7PwVscfGt7TVB6ytG9AOlwN4=;
        b=KFVhzlWsFT/J1nyvr6fJYGAWtKKg5Sxdo9kOGnLycUEx1Z3MNPN880fk/EeZRYnxES
         cfN5fuSPF+Yw5trV1EDcZlpB5VB5DEEMb1PWALiQ/yyKlP5duQ0h/QgS0tf3jGYI0fvx
         fDOnZ8RuTCu5IIZKOSVHVwxauTVTVa20GSPlIpChl4KJZnUdx/xCDwdl9B+Yusu8ZB5D
         sv7YQAmR+VV4hqrtSLDXrw10BvdQk0MOfVY1PiuU4WZoR5TA+01QnrFp4NCYu09vhrG6
         kOupS+lTGOY4Gqz5pL5GZlb+qGDf/aVKOdlIuqVhSt8ltBRuoxNvte2YAFN9G6eydbwd
         ywiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075049; x=1790679849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ws6kEEuC6Y/oD+AA4pY7PwVscfGt7TVB6ytG9AOlwN4=;
        b=rye54xoGCtStnQx5SjCQebShYLk16llbEEkEWp8Av0xYM+Tu+xJMzisco7ugvbTofp
         LvuO0pJTYa6fBN6gBFDpZdzYxsMKKty0X0gImx6l1qlt1CcyLxoXC9QpXIfLDyHBzHAQ
         xLhZ6fXeFG0waLBuD8CJLUAqV8bSUPQ1d1yNImpUpb6SVMDJJ8RFpZmSUbmdUcxZN0rq
         N44DJh65qvX34+VZS4awYQdDjJW/XDFVQERakkaaEEzlAQBfQFf70/3ihYuzehGemL49
         IjjzGlfhzdee+NuRCBqwUKTvSvN5pipz4UIxMHlLB/k95EF+UGTqTRbRsoszyYEU8WCv
         LNNA==
X-Forwarded-Encrypted: i=1; AKwUvByLmZAHeveHP4U2LdKEVBkOPsNDY0tDJjVtLY5x9n7XlioLF55SDYZnuPae/L8XoiRSfsAeaYE=@vger.kernel.org
X-Gm-Message-State: AFuF++k8f/1+zFwxgbz4OqpVZoNMyUiTYbDP3QurqkfR1CFnbDJAYwEW
	YsbNiN1o9XCS6nMK/WPbCNPOmWkmvhcqaGHJICrqBUkCt5tINSLOyO0V
X-Gm-Gg: AYBFou228HJIpyxFNhRyrkG0FoBfxi244nk3rTfR7ZsNt6UQTND8WPYpoLcj4Zlr1f9
	Gz5WrDGqjrD+m7oqEbdXwnrlOUvs/17GrsqBQ8SynsLiNbiuwvbgmAaH3Ovu34ZJxn0R8igkzGy
	zlulah89o3FXWdiErCBB2Odd/Wc5bPi70t1Tv5LkkEhkeu0+RYVdx5i/fgOOonFcsMKdXf5AvMR
	dCGBR+YboKu949SNl55uwca7/qMJ3+OFktmi5gPqu9xHVOw/dj+iTZ4nkSKcrPyJU1LJhzwvxCn
	bJ5oK35y0HDDMnKB/m1j5dkZrtGzAidQ8cEJKVcg46nYJ5jnzSnco6B7rqt3CwG0c9DT3Qx95vT
	x6xOiF+YqRcdyj1OI3PlnNkDOfiSLyj/E0G18KMULUV9lNW4Ih2pse6cD8lIeIt/oGEC641wmnD
	YxVXqDo5OjZwFc8XeL3PTmfZpn6q0L21JZPFxCjraaTjiZUS9f0YXwFtTm+4yMyd/zKz+yVxPCx
	hBGWchDct0=
X-Received: by 2002:a05:600c:83cf:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-49fce783698mr111268985e9.19.1790075048655;
        Tue, 22 Sep 2026 04:04:08 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:08 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 03/26] xfs: fix attr fork block count checks in xrep_inode_blockcounts
Date: Tue, 22 Sep 2026 13:01:58 +0200
Message-ID: <20260922110221.1431-3-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922110221.1431-1-hackerowskiy@gmail.com>
References: <20260922110221.1431-1-hackerowskiy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

LOLLM points out that a file has an attr fork, it will call
xchk_inode_count_blocks to set @ablocks to the number of fsblocks mapped
by the attr fork; but then it'll compare @blocks (aka the count of
fsblocks mapped by the data fork).  We already checked that and we never
do anything with @acount, so I think this is clearly a bug.  Fix the
comparison.

Cc: stable@vger.kernel.org # v6.8
Fixes: 2d295fe65776d1 ("xfs: repair inode records")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/scrub/inode_repair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index 8bc508336aa5..b87c22146233 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -1702,7 +1702,7 @@ xrep_inode_blockcounts(
 				&acount);
 		if (error)
 			return error;
-		if (count >= sc->mp->m_sb.sb_dblocks)
+		if (acount >= sc->mp->m_sb.sb_dblocks)
 			return -EFSCORRUPTED;
 		error = xrep_ino_ensure_extent_count(sc, XFS_ATTR_FORK,
 				nextents);
-- 
2.55.0

