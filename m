Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26E61FFC48
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756395; cv=none; b=fJLYfK/UHHdEkR4BxfmiG5eVXpNeu8Kw1d0Jh2+9D4n9krNRWPRl2Vdhv3/VOPkv//h/fvFo/BmfI8BAwjeyYNAM1maewOz+2Ek7oK9SPn2zYWgwNPHGyorxletUE+hEZwZIOw3XplaiCI0tGl5/YXN9dCk8mh8T9Xp1YSY8iy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756395; c=relaxed/simple;
	bh=5hD9XVqI+4PXRTEiMFVCtYvnNEvjFeZDmjYsnp//hD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyT/Ls3ShRuilXJ/qqSxPtpeedMMO6K0YlWIkFrjT0fk40dpFcXtdHiv4NnmEf8xj5M3WZdH0jlZP5Ghf8maKc9QTJ0CQCT6u+Fuo+rGcf3va1bwkWfPGktKe56O2duO3NIMwSpn7rzjVG3r9cVmSBj+9DQx3xOd1X23GNs6xis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2hpvbJ2; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2hpvbJ2"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e36so1661903a12.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790756391; x=1791361191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9jUtxKLRNZI7zQbmKekUxqQuRuxiBkqKsZtXk7alpZM=;
        b=n2hpvbJ2UHi9Wzw07T/GafyKlZ3x2/NYzkd8msvSgubsu1U+eYDvWDMtFQC8nNQlWe
         qZJoQ6+MTOBaqWcA51XICQJisb1c/5siyZ+KgbK7v79lvokLXMTPtTXtTbIJIV2vGP6R
         5IKvmIwNIXQkZGRtOSKrK8q9ppCHBnBVxpPeAJnCuMABz2oFBO8jgAkUSW6iF9kY8OY2
         bgT98g7PnCIeWdcT8IWa1nle1YTfVzBo1auaSd5y7j+ZOPgK9kTEuCxu9VRXQQhtNsAl
         6FKqdbFv8RZXozrNjuAds4EAX1kjxPpdlxiuPTDG62MV/dWbBDnseeE40t5UK5mMu0Tt
         emOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756391; x=1791361191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9jUtxKLRNZI7zQbmKekUxqQuRuxiBkqKsZtXk7alpZM=;
        b=0zQHtt6fr7S/1Lx79LbOrGw6Avm+3DXxJgGL8ZqznXjWykJqZyfEXjZmav3I3T1bwH
         1obw4RfHXPdPrYy3peHyhoFmvFRhQfdKgmhdbtgWx5D2GK0QuZmXVt9H5zIDsT1zm/Zo
         b8qQCCYvcKfNAr1paT0SBkzLzqGDKyrr0pBmvMXulmAqdcSqunGwDNibRvLPgNVsrG+j
         XnYjnyRYMYKajkCl1xcHSLjc/r5scmdQRgBg5mka0my9yzSLxOs/FF8Wx2KKhchHfMqi
         Aq8cO1zs02keI0xRccASKCjS3exj80/4IIZZG2xRubbX9GcDrS61dzw4PKQTb9/9wvmZ
         z83Q==
X-Forwarded-Encrypted: i=1; AKwUvBzPrQUGYmbIbALf/cXiJZNF98DreH7ToM4dhf7U8v8riRXji8YsjnqzfFwqI7pRs/l+hx9xGD8=@vger.kernel.org
X-Gm-Message-State: AFuF++niigEEklGyNmQoeaOOAoAiGYtsYnH6cvd71UUgRqHTtAxQ3JMK
	n0AuKJ+vcHWTAeG8dcFHtlfBlGNhmm9Qwbw+Bw2Xy9K3RK744zWDeFXxkB0rGjLH
X-Gm-Gg: AYBFou3GrFirJznleI/8wzdnAQebOVb822lvd2+fOKiAISHmQjqyp0aFdF8ndfvH/kh
	yj/6IzgocGRgrBroVJIBsUbPh2Pyae/BzjJBE1r35KRX44ifzZ+Re3jNf66mQmspMez+7zY9x2P
	jhzQpGSgHMgrkIWfgSFGa5zt83Mroj7/vgHBC2wZNdezb2q0zSvf3+tkjNgMEkZLaiRzAniHVeD
	09L/dCZn0kop+P5CdCG1P501wp0XcmSOjrOSToFZRKTc2CJtiBJQO8K8fzGX+6RKPrmwsknMLNn
	bQpPiO8H9GqppPI99L+MkugjoYTr1qCYko3oWfcmhQwCGdcoKcX+rgeuQ9Ze4EREfOjY+6rCVnd
	P7TDqB1KTVXLFdU8vZ5HfSm410fyoDKbxaNl+MKSfTgfilsvYGIskz4fB3SaAnpooMdY8fCs/XM
	qpOQsdCu530mUyCv22yz5FXW3RFbojogn6VnnSkV+I28GwyyqTf7iGkxzpemoEWUinHwHDE048I
	iQ8hDbYlu8H7q2I5UShQtu6aqRvLcimvCgHRPy7CSaiPQi44ndMAtAYQip2UEqtMw4xPWnXss63
	yGcC1BTP5A==
X-Received: by 2002:a05:6a21:918f:b0:3d3:adbf:7780 with SMTP id adf61e73a8af0-3de9e844522mr717549637.21.1790756390740;
        Wed, 30 Sep 2026 01:19:50 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7da126a49sm453319a12.7.2026.09.30.01.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:19:50 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>,
	Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v5 1/6] qnx6: validate di_filelevels in qnx6_iget() before accessing level pointers
Date: Wed, 30 Sep 2026 08:19:42 +0000
Message-ID: <20260930081947.511613-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930081947.511613-1-benquike@gmail.com>
References: <20260930081947.511613-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_iget(), raw_inode->di_filelevels is loaded directly from disk
without checking if it exceeds QNX6_PTR_MAX_LEVELS (3). When di_filelevels
exceeds 3 (for example, 6 or 255), qnx6_block_map() triggers UBSAN
shift-out-of-bounds reports at both shifts during indirect block tree
traversal.

Validate raw_inode->di_filelevels <= QNX6_PTR_MAX_LEVELS in qnx6_iget()
and return -EIO on invalid values.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v5:
- Restored commit description to accurately specify UBSAN
  shift-out-of-bounds reports at both shifts in qnx6_block_map() per
  Matthias Goergens.
- Added Tested-by: Matthias Goergens.

 fs/qnx6/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index a350280f2d47..eb6b5dfbc599 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -543,6 +543,11 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned int ino)
 
 	raw_inode = qnx6_raw_inode(sb, ino, bh);
 	inode->i_mode = fs16_to_cpu(sbi, raw_inode->di_mode);
+	if (raw_inode->di_filelevels > QNX6_PTR_MAX_LEVELS) {
+		pr_err("invalid inode levels %d (max %d)\n",
+		       raw_inode->di_filelevels, QNX6_PTR_MAX_LEVELS);
+		goto bad_inode;
+	}
 	i_uid_write(inode, fs32_to_cpu(sbi, raw_inode->di_uid));
 	i_gid_write(inode, fs32_to_cpu(sbi, raw_inode->di_gid));
 	set_nlink(inode, fs32_to_cpu(sbi, raw_inode->di_nlink));
-- 
2.47.3
