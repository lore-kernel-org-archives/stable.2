Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716409;
	b=HrsZKoYnnEgMYx54YN+ZFhmx+ZQE3G7c9tkGHPpFAc2YyafYpqiAJgihRUY27yfuQQnJ
	 LvvIYCrsGbj/rPLLEsTdm7Nt0ZNsnkoU6ufqCRMc6bgAc4lhT3RzyxwIUKq7DZE8bLo28
	 5n203Dks+AaGioL3P7nRlc47mzPqMOohs16W2ZT4PbfDrOdOq6kNIn7se9UOet2P5CHR4
	 6xJS+EYPdMPU4tWifA/fZGkGx3Zsi8dAG7zKfAbWvgUIFLSRohJgmoGgAB8RKJ0NKay1T
	 O5PwzPZvRHxM/qcHkYVMsW/yiZmDwVqHodKp+YK0/jJVDWWkn5gj0wrL2GTe7Yz1nHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tI+UwBYPAdWdAqb3dEv/Iv9MEi3mF5GYk2Iq/sV6Q+g=;
	b=LM5xocsShpdueliazh8rHPnwET6NS/5unVwEPZ/Nom9OQKiQu3SQIwPT1o5TqMhUEuyN
	 jT69ApH3dghXYYgLTylYVMI7edMVDt8SDxD23WhT4tyLE62ecd5T+vex28yQmexRLWmrC
	 aikQQ/8O1dingqDUwXR5Ub95OE5O+T4lWYSYGILe+lPYOCupMColhgm3XU4oh9+jVA3Ia
	 H2xSQ53hTvU3scOAekJe9uQTiEepdyGBdbylaxHXw0CzfZ7W/JB+myprjyavTwyv3ExUX
	 BVX9Px7Hzuy1oHIh32bm8xZHbf49bX+pK8sHidm72J3TjHS5WBkhUtfanzAUUoiyCvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OMakKWWq;
	arc=none smtp.remote-ip=74.125.227.133
Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5411D606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5411D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OMakKWWq
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3ae7c6a2d07so1152636a91.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793716409; x=1794321209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tI+UwBYPAdWdAqb3dEv/Iv9MEi3mF5GYk2Iq/sV6Q+g=;
        b=OMakKWWq92Jd+LPrw2dMjUdTbbCAHgwKqsXYpnakA0v1IJIkLsk4HcA6AbC23W5evB
         tBOnUGm/ka/t1RUwhJg+BHoPaU+s00V6u3Fe1ySkT1SBqwNnxJyzcLx+qHUoRYu32qhP
         tXVZErMxSmBKIh3vGaM8ZQnRggivAf8MstgCX58MI2A/pAiHxCjpybxhMMRYYxvK5Mqk
         m4teoOc30twESU7y+jNP2M7ZEUioy8qxI+whMvVDc98MA50iAUcLcIsXt8dD5CtmR1Y6
         gRxgV4ApYBNEUqoUkpRJ0jyPFall9y1XOJZnbNjJs2eYgcoJ/SYs/A50n2jOFhvZOc4G
         CQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716409; x=1794321209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tI+UwBYPAdWdAqb3dEv/Iv9MEi3mF5GYk2Iq/sV6Q+g=;
        b=Q3d+W+QOg/KlFYSxKBfYU6RXZd6FPE4EyaHgdu5pMbYp4nNXWV2gq3C8Em/EtMoWSW
         4mIoVkOInh3RIV5IVJwyYxGKliRWpSNEOW4OVFCmthF/uDy31+m+Dz43aXCGB+u1gTi/
         lg1Xnwn3N58ehnERFlrTPeJO0R7IBdGzi0DgKWp6J63ylo/pX+rOnP8LftztrqwM5rtQ
         Rfum+mG/iZwzFjbvtfXL+RlCLZNf1E8rU/XsJo6duhVuaRJqiT/eORvnwGLJUFz06jU7
         hwOhEvGMvXfq+lqEycryfTFNzRSi0NBgPmFVrm+mxb01q/9A8/KpEwIAHD+zEwj0UX3j
         BlKQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/pfqzyoCb2JwAqn+8X+WyR9obNZ6xnAqbo2WCehM8gdO33zaDVI82gCURqOSYnLGtMCQFdwg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bCwbO1KSgTeTlCsV5Ulj5z+R3dV+DlgI/GLof6czbZ0fxH4Rg
	DnTwr7xCL7PYwHRSFS0p3NnaDcRAUQa/TH0ZrQ2cqYu0bXzhkUeI6XgD
X-Gm-Gg: AYBFou3F/iCqoaS1WmFq26N+81saPA5qb5tAB9P+c6wmhufP1VcZwPlPT81t6fzzWGD
	sy1+jMvT4iQgkQA172xh8ad8OEUzDe0BK0D1WE1w3no/NPKGR2ZpRPO4brLUmQeLytPfiJLIFaN
	nHtBeJnWm95qiduIEE3DrlfGA4DxYjHBqpVTtI4MJs8kWSjB3WBn7m4OXp4EGsaFMzQeRW4CZ8e
	kT4X7l73lPm515iM/wAFT12mOIsoPXy3zvAiqB24GigrJtSnh9jOXWa8/5Jf7gPqkEnGM9gAsYB
	L5RQOETpApLs2XukE1v3JLMV996rCmhY11Qa72yb+wrV1v68zMPkLyxkcmSOxHJNQ/xGSYjMXwR
	YVViFScxQPwqe1lq0f/Oe1NvDAjPI5Y3Odga5ETVmyOlqqX996KuU00h/mBm7XUkbN91KTDNAdu
	WlJiJqUvj8t9tLBzHYNdp1tWn0io23VNGmLrby6BuN7Ezxa3rgaUzrcjlshNM0+sN6Ik/+6jdPv
	RC8e/Q8pjAIAfG/+jSZfmTF7r30aHDsyz/m4xwyt+LNa78EzyA8onNXRTwL+K6YlMhyg7PLRj2u
	/Axiga9S38YrSAdu1VKe7Tk1B8wTdFDzikI7kEehTBodznu/QBJElh0cIflVJaz9mpX0qydgqMQ
	xPkJ+PbwTGwCvhOWXFgOg140yICW5MCiZNQIsJLNUtdUmP8uSCHo32W3eth6GCvebcQ==
X-Received: by 2002:a17:90b:4c08:b0:3ac:adce:60a9 with SMTP id 98e67ed59e1d1-3ae8957cc59mr11107986a91.9.1793716408508;
        Tue, 03 Nov 2026 06:33:28 -0800 (PST)
Received: from localhost (ec2-18-182-19-4.ap-northeast-1.compute.amazonaws.com. [18.182.19.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9b0ec5sm4698225a91.16.2026.11.03.06.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:33:27 -0800 (PST)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	stable@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	Viktor Malik <vmalik@redhat.com>,
	linux-xfs@vger.kernel.org (open list:XFS FILESYSTEM)
Subject: [PATCH] xfs: fix inverted action for empty leaf block in xfs_dir2_leafn_toosmall
Date: Tue,  3 Nov 2026 22:32:58 +0800
Message-Id: <20261103143308.10870-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyun Gao <jianyungao89@gmail.com>

When a directory/attribute leaf block becomes empty,
xfs_dir2_leafn_toosmall decides whether to delete it by calling
xfs_da3_path_shift to find a sibling.  rval is non-zero when no sibling
is found and zero when one is found.

The code currently sets *action = rval ? 2 : 0, which is backwards: it
tries to delete the block when no sibling exists (corrupting the tree
by self-merging) and keeps the empty block when a sibling is found.

The analogous xfs_da3_node_toosmall (xfs_da_btree.c) uses the correct
*action = retval ? 0 : 2, and the non-empty branch in the same function
uses *action = rval ? 0 : 1.  Flip the empty-block case to match.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 fs/xfs/libxfs/xfs_dir2_node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_dir2_node.c b/fs/xfs/libxfs/xfs_dir2_node.c
index 19cb536e53ef..55244d153f84 100644
--- a/fs/xfs/libxfs/xfs_dir2_node.c
+++ b/fs/xfs/libxfs/xfs_dir2_node.c
@@ -1546,7 +1546,7 @@ xfs_dir2_leafn_toosmall(
 			&rval);
 		if (error)
 			return error;
-		*action = rval ? 2 : 0;
+		*action = rval ? 0 : 2;
 		return 0;
 	}
 	/*
-- 
2.34.1

