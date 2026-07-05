Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202B7378803;
	Sun,  5 Jul 2026 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783250115; cv=none; b=ofvJuXeJDAxmkHq7Me6uqNhxJo4oTkUBhzDxBhVWqwLIh/bdTiuOhRZzh65HdSkDJMbHRtk9JMFGQLkZCj8QySRe/ajNpkOA9kUkiJRIPuDSmbqgau+aleI/wgEcB7qL/ob2WU0FJ0FNqjPSmq2bOuu7jTAH97wM6Mm/Kzkwi0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783250115; c=relaxed/simple;
	bh=aD9ZBo2SLLrF1nIIS9T1G0CIeqJSuPLpxOtou60uVB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlU0vlHg8X+fe6U37KpBxpoc4grdEHDxyxy6i/DhxY3ZK+kAleU2Pm4Lggs5SeE5e6au71wRiy2OraeKQSAyOfY+MJ38n3qTx0YtOuraM80PWFs5Y/reMurLDt3HuyzVTPo9Y76o7gGFL3YVO60Lyb84oufTQzczD8vBlLQQGck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=C7DZ9JEw; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="C7DZ9JEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1783250079;
	bh=YpUMti/yb9vDI9mdWfs5f+qVc9ziBhPA+Fp8+HXcxDw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=C7DZ9JEwDdGFqzhAWzqePcDXjS745Dqb47QiYnKgXBEUhmwA1LS349M2jjEWI7LKa
	 0eFJUmMnuJPqx3xvlfoNkmrnaZXVvLJ0kGmkv9gWRQw6Ob8D+PDfbqGrh9RS5QxKMa
	 1FYkZuzFF409C6IiKMvTmbIZq9XcfGWMsuGAnXDk=
X-QQ-mid: zesmtpgz7t1783250074t30e9ce5d
X-QQ-Originating-IP: F6p+GAxTpf2D1tz3899axNjZyJxjKqWAWfVIYFIeDIc=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.195])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 05 Jul 2026 19:14:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9482115873622163101
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ntfs: fix hole runlist memory leak in insert range error path
Date: Sun,  5 Jul 2026 19:14:09 +0800
Message-ID: <01B02B3C02CE4CD1+20260705111409.3834024-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5A2D944D5FE68879+20260705100554.3797781-1-peiyang_he@smail.nju.edu.cn>
References: <5A2D944D5FE68879+20260705100554.3797781-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NMMSTmykDl9bQFHl+clUd3LVTh3Vz4mcK3OJ4HPtcf/LAnTFoL0HuiF6
	Bcjx3jlGEZvYpgx8ubUH09NQKKmLmJkn8zQeWU3oLI9qfkxfwO5ssOSbIYBrKnRRFBwr1CC
	bJv4kuk8DV9p5Q9RzzTJzlr3DQzkxvTqYUwJonYk7H5NpO8Rh8rk9/bpc7kFuQirA+ZyRUZ
	v5dAEhL9vCqExCk6IW9U0QFahnHbicqBFZIVvWoj8M0IK674sgroCI98yN1IYMqFcrlh2wx
	pmuyDEMb9edeR3D5XKJZ7qEQ4RGnkm6c86dgANhqJiFqL65jELay4qEr0XTRUGn4+CaAw8c
	CuEPBcuVmtpsKGN1+E2lUYmBMOLqKaTRmC9acrQjhsoTofUvTnBhaev/sh3u0IMoDsfAKZu
	z5cD4kj8dQKcvQggCjTSSZI6tpukop56nqFGdcol05megEHb5miRsLYBgqyc95+6L2mdd1G
	JS+6IqM9RqXFciTBw8ghDLljaPj/i+HJWDXQaaMq4Nwk+NOoNbmRB1tJEb2Y9YUVeTBWGgr
	wRZmoRU6MX/TnIn0Z40x74I/Fc3n4AlRLmPWUF7sW6fTd8q01l1HBUvJ7HjioAHs0hXoTTu
	QFPNB/TFh4eZaotn6WitHu/UUQGGbMMT+4/9onFF5tWDvx5ZPJJswSQH5wycM9vi+d/KL6S
	Xgk5GKvmU0FbLoOqaiv115muminkn5kpvxJUnPdBTFtmXCDcJBxd+27UEx4ghcxZvXEPRx8
	xZtLXOVBMlAZPqok5oJ6AOjvFog3Ma6OnCQDQEqisPzgjQN4q/cEG19HsnFT9KxMx0biOxM
	opxAJyxcG46PuXyaKAJv69YcvRV8lH4OHRmTZEBQz/mLHMQ5BU4zxqhGCIwp3wbT4HYgCk6
	P7ZLz/DdsqckqJPqWlSrzvulkebA5e9Y4t28qgOUlRxgVPR7/4aAOodTyfS9yqlAO3I0fqs
	zAtMTWvjR2TzSYT6XL2Kt//XeMiij/8lmMzWkkvguDrcLIas4+rn8UU/mUxUIsZJ5IizjSo
	6aIdsyiJN1IVixjmDRwbHxCFSu3lqo9mti++FDesMQkI3ThqB3IgdqIdOYuTw=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

ntfs_non_resident_attr_insert_range() allocates hole_rl before mapping the
whole runlist. If ntfs_attr_map_whole_runlist() fails, the error path drops
ni->runlist.lock and returns without freeing hole_rl. This leaks memory
of sizeof(*hole_rl) * 2 bytes.

Fix this memory leak by freeing hole_rl before returning from
that error path, matching the later error paths in the same function.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
---
Changes in v2:
  - modify commit message to resolve checkpatch.pl warning
  - add Cc: stable@vger.kernel.org tag to the commit message

 fs/ntfs/attrib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index dd8828098511..55603df0a2ed 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -5325,6 +5325,7 @@ int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s6
 	ret = ntfs_attr_map_whole_runlist(ni);
 	if (ret) {
 		up_write(&ni->runlist.lock);
+		kfree(hole_rl);
 		return ret;
 	}
 

base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
-- 
2.43.0

