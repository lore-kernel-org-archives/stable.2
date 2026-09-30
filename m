Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB8463B8B
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756396; cv=none; b=XfcnWQ1N8mG/IXRv24gWL1+356M737saKUh2HZ66kcrITNOhedHcjZQNLe8AgQTm++1+AVr5YQlPQG3zBKOsMluymc7w4BDAsUycx/T8gV4mfcy3Ghlk5zcckHjNnWUJIXD9ZkVhMikQGiy8CDCJAJXzGmRdt1yC+2ffnTNM5bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756396; c=relaxed/simple;
	bh=+y4xSMYmkh3bFalgboi6xyjy2Uegz5ftgAeqbMaePrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWYWMxwYK2F9PxB2z1P/0NG3oVsXu4tcnKIUGOrgTtj4suagqdN7QRQncCCBWpPSjys0fHj3iUkZTbUQO/eXyUVHS4Gw0sRG2p/W9vDx8/nJRO7bs9vUUg2gQh4v8kirB9MceApaAWIQaQ+1Awm8cqoSPtR+kXUajw7ijUlezNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gthhM9a5; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gthhM9a5"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso2866527a91.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790756391; x=1791361191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KtJOE7/gGMS3z1mCUhci+rV25ZYpqBSPOr5/pEn7pO4=;
        b=gthhM9a5ododqIOnLL2lCXP1x62HROLuzZliVC/3SbivvowTybghNJ9uz/QTiX4mEj
         ulc8yvJ8IkXxDJelDMGIFuKtxNZEWNoVSD+6TOKVS0pJuKoqLwyHHWMLsnkricZ4Mqup
         XP4UrHvBOVP0+oDIiTM8DITqh9evcvVd2tDgWiOp5Zt8mPhSsG4gmC00HjHvPCNgQP21
         S9Z1eLeS+is4asSaPkANL+RBpUIUA/Cj3DMhSr1uFjhI4i/uZOW3fPwCpgM+fwuxxBkV
         s2Jgqpr56voCG3V5/L3SHEkLSG/tLFvZg6c4vBUI17PmVtB7LXL+IajVFxvHsUZ4fD1t
         XsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756391; x=1791361191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KtJOE7/gGMS3z1mCUhci+rV25ZYpqBSPOr5/pEn7pO4=;
        b=KWMzXfCZkH3oDvX00RI6iQlghS17oTJXFjgac3T2E+UkWPuBniJLdyjPLbPN2wdbXj
         8eFSo3SwVX2AooR31+sW3prx0ymI5einuXiEvAY0JVZXg3b7wfYQ/EdwVRs7RqQENhrP
         5ejfuYbF9ZVRKzQH7Y6gpHD956Hxu6c5qWVlTqGp3wJKn8ZwN378Ah4s7ui5PM14jFdE
         oxcgq54MDSCNbNEfmO428IiVRZAt+lfzRh6q6MSmUfxRsgXrrj/eHfziKDwyoC7VNrcl
         TG8akH5iGAJcr4iMg/joIGARwEjpf+4TlpYGpDrAtf6nizw4YPjaWn2h7NY1AcnOffGD
         nGJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXOc/qnfjK7AItdAsUYBefbRcDREE71ukEaPb7auHvQJjowjO9JouAtplZdiTIRtFOGFZxheg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOjIVZYvcB/VVozmRLuynd4bpRaBRkz5D5Qd14aYfbSgRKeusq
	PFxHbA5VEFQSUPsfeLZnZkqnCbn1p6dsINuacnKmT9ySULWLqME36blJhSpSP9yT
X-Gm-Gg: AYBFou2BR2NirA5YigGfzIx3z9kTk5GKBHKkPa5IPOEGwKl6Rdh+alK7kF2dj1I4ZsI
	VbL9Q877rdyacEtMLNAWUStXg4rnuRRgpyMBtj1Q4eHnMFarY1b4YnYVIvBGJ3xRdekaaxGB/K1
	H9rLntEYWOGD2EGMNxxij9LVU1cP8k/VgKGsWgkU7lVauUEQtoTSXhjSWZH9EltLC6RpO04oeVm
	cGjgoLo7K9w8b0WrZNtg2IYhmfKz39AEKy4Kl40gUog71w+Du/iKRy8S0226bSFBAh5Fj58ko4R
	OIkqyGnEL7r7MjdeH8AWII113svQCAukewo563hYAywQyXQqkPNaMnIP2B+POOfTDWTwErG7Z20
	QsCVLsoUDGxF/tECy1xdz25pQlE1ulx4EcgO8ICDT+U9tTztF6ps0HSOswNvEuo+NhGGQ9SyT1q
	DOg77mX+J50SG8TpwakgKdRRgkzuTqTGizI2CumTasbsWOw2BUeyRW+kUIBg9+wUf1XM2h018Ow
	CawF5ZZqOl0npfo9C0IbMx5Sc5gJyhbVDW6E9ZsT/JqK00GllwgZ1fF4L2veQfw+CsBefNqP3Fo
	I1VKyLRbPyY=
X-Received: by 2002:a17:90b:3c47:b0:39e:6c6a:657e with SMTP id 98e67ed59e1d1-3a4d1984829mr624739a91.65.1790756391173;
        Wed, 30 Sep 2026 01:19:51 -0700 (PDT)
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
Subject: [PATCH v5 2/6] qnx6: release bh on error path in qnx6_block_map()
Date: Wed, 30 Sep 2026 08:19:43 +0000
Message-ID: <20260930081947.511613-3-benquike@gmail.com>
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

In qnx6_block_map(), when sb_bread() fails during indirect block tree
traversal, the function returns 0 without calling brelse(bh), leaking the
previously fetched buffer head bh.

Call brelse(bh) before returning 0 on error paths in qnx6_block_map().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 fs/qnx6/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index eb6b5dfbc599..3c880854c867 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -242,8 +242,10 @@ unsigned long qnx6_block_map(struct inode *inode, unsigned int iblock)
 
 		block = fs32_to_cpu(sbi, *ptr);
 		bh = sb_bread(inode->i_sb, block);
-		if (!bh)
+		if (!bh) {
+			brelse(bh);
 			return 0;
+		}
 	}
 
 	idx = (iblock >> (level * sbi->s_ptrbits)) & (sbi->s_ptrbits - 1);
-- 
2.47.3
