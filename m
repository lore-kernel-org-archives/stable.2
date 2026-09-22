Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE04FC8C3
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075070; cv=none; b=gyvt/sdqHVCVqfOE6S1SuQ9i9ckyIx4waqZ3blaL05h3ThL8SwdCsEBGYO1Fzk7lno/SdXU1IeLCbEwPYY/3lFegsCOsGGlBEAYiOsJZJ/hxlXbmbFhPDEDrQewmS55dEBjRYqic/GZF7+yVGwHcSxvRMStCc2SBXdeUpvIIsPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075070; c=relaxed/simple;
	bh=vLYre3cbf4sLfnwbZ9Pp2FiUTReY6mUYTJtJW9g74Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV9jzHnx6Bv+PWB95C7E3LncYYFxNf2WzzjtmXZI7VGiHEhyuWxifQN2+yAfU/JDTweHlJgpl1xmIwJewEduus12/RuNv/P698IK+nuaKI2vWSPrQlorIMEpf3TtrKCuHE2ota2FOko4enyrydeMf8QC4UDwe3SrDj7F4iZ0kEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2PaVVjz; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2PaVVjz"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccff31419so33926975e9.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075068; x=1790679868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cfMMf6+TRacX49feBfuctGsDHFIFB1FxrhQ6Xj4tmEw=;
        b=m2PaVVjzf/odJ/gH/nVYdQPmUNA9RhDECzmtQYphacclDaWzDTFMGkZ2py9HSDdjpp
         zZW4I3U1hoBwMpKWpFhF2g8ITTPNwyMmi25FPGBCalQ8me+kgPf9fYci9kSX64rYcxK1
         zX15Fw2LHQSye6MAd5UeQLQvrU8FloNakO3Y5LdADOgWqCd4i80uAFZGHY82mNH7Bzs7
         Rc/vjZTV9ayLq1ZVbb4z6Uy+GSJz+68XuPlmRyFgFcsJORROOZ1/ITU0pCyyijkPrl+H
         q3MDYLfsH1U1uMTV4bIHRxikkXK4uWpz2DBYe3sYnyqKFEGjUvo0RmDz0dTQ9GHd+seb
         Tdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075068; x=1790679868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cfMMf6+TRacX49feBfuctGsDHFIFB1FxrhQ6Xj4tmEw=;
        b=f70MTp//1oZD6p9fNpoqP1jUYQ873Uw/O7B+/SLI5VJDK7Un5cSUixbFlzlQo5tT+V
         rZwXYDGCXDQCnPIivxWoHjT3x4xPd7yDDWulwoh2cwu7cuUYWtQYH5VIUtA+bYfq1aZ0
         xdWw55Q9/SPoatIxs5DTxTVt/avYpciOLES09do8jolY/jyK1Y8F9EL7/ewVeBwNR9j7
         LiOotJKhw0L3/ziCodhe761QFNz6+BUHBtBECnkvhfb8cw4IEqxelEncwaImyyEjo+nC
         QoFWIGSpk0YncSROsItxxHZsh9tS3HTL6Y+6ejdhFWuKfv8cGMd72o3f+kwMqVkBW+tq
         RMtw==
X-Forwarded-Encrypted: i=1; AKwUvBzYmU4x3Yv49qszyK+KOEc3EeGqJa5EqP1gkX4GeqcHXvv+r+kITXqXunHfw6Io8NVfU6+oFpw=@vger.kernel.org
X-Gm-Message-State: AFuF++muRhDAowLmP1cNhMf/6Lm2GX2axO+7iAhKTo0OMMIoPPEOuPwj
	lfF1gA/gEWUNrSr6Z3w/dP+Eoj02DBC/cnLcFF6b9zH7/+c2Jg4EFsAV
X-Gm-Gg: AYBFou08Hzm7jOLM8AofSKKjyG8nT0HJ3SNsEMOO+Ft3cG91bkJ/1hwbM8P7HDL+JlT
	V6XwEOc14UHXikq7PE3QZMlhgOrWFr5YH3BpwgYC8YuY9uQyQgkb61GMuWk9VcFymWcmP9SXt1A
	h482tl/eUXYD4OIBO0hrHg7r/imE3FL2JgT68Y3UPt8KUw7gBsOWtOGQe1qWYzwuQSTvYQ6D02e
	no/ccmMYAJE2driTd4pTIUf8NqqHz3vaimbdW7eOVJ7XWPMK0SVLlxWNjBV3nWuVzJigv8ayLs7
	if0EVKl4akQBfU6inC5Ibvj5ra9djnpSRF/tn2/AdyXOJ/hKCI9AJID6UWADxEFbHd+6b1ueVER
	JDpU/46eUgsRm4yZK9lUeiOfh3zJ0KnqAoL/CPzNQt2WFHjsl5/ykLlZF6p6hwhjW68lqtfSsxW
	mt13jxWaKqHAWoYEgWJ/vNLPiNupwKkJzBun508l/cr75bKH6sBLu4w3x1RS8JNbVX4JBxwoiPT
	8dLqyCQDPk=
X-Received: by 2002:a05:600c:83c8:b0:49c:ff3c:973f with SMTP id 5b1f17b1804b1-49fc573f531mr185139415e9.24.1790075067459;
        Tue, 22 Sep 2026 04:04:27 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:27 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 12/26] xfs: check di_forkoff correctly in scrub
Date: Tue, 22 Sep 2026 13:02:07 +0200
Message-ID: <20260922110221.1431-12-hackerowskiy@gmail.com>
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

The di_forkoff check in xchk_dinode is incorrect, according to LOLLM.
XFS_DFORK_BOFF returns a byte count relative to the start of the literal
area, not the start of the inode.  Therefore, this check won't flag
di_forkoff values that are larger than the literal area but not the
inode size itself.  Fix this check; sadly the old APTR code was correct.

Cc: stable@vger.kernel.org # v6.8
Fixes: 6b5d917780219d ("xfs: dont cast to char * for XFS_DFORK_*PTR macros")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/scrub/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/inode.c b/fs/xfs/scrub/inode.c
index 65b13e311916..46e9bf4a4317 100644
--- a/fs/xfs/scrub/inode.c
+++ b/fs/xfs/scrub/inode.c
@@ -607,7 +607,7 @@ xchk_dinode(
 	}
 
 	/* di_forkoff */
-	if (XFS_DFORK_BOFF(dip) >= mp->m_sb.sb_inodesize)
+	if (dip->di_forkoff >= (XFS_LITINO(mp) >> 3))
 		xchk_ino_set_corrupt(sc, ino);
 	if (naextents != 0 && dip->di_forkoff == 0)
 		xchk_ino_set_corrupt(sc, ino);
-- 
2.55.0

