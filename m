Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1735E1AA
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709569; cv=none; b=NoerkoAL+B3pNXbRyGm6EeGhKXuG4ymO2bLVatOd4Oe8ZTcn6AQZKmdp6o402Cf4cFIV/JvzwCSxgl5Ybs8y6jVNM0oycgrTPz83dEwVrwUyMMKyiSly0rUKBVmeXNFByiaz5BGBhCEbCAbt5c/WI0+8Kcbf2gUdPyU4792bhMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709569; c=relaxed/simple;
	bh=GGD3doikBc6PSikqErkHYK7Gf4jBgLUX8SPs+F9Dvlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzERIMDeU4C2N/tfamUbz889w0b/REF4vg/5W8TTrzqkIbGxDdmXv9sGg/yu7V+NxLZTQn0OCVjxPg3L+VC7oBcIrTCavgeq3vUId2icZ8R3h4pb6Jej1ZeDxKQuKNW3BB9NuCEzIiV3IMExEBjwisZMLR+IT6I3C1C2JhG9vk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dR1p4uYs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dR1p4uYs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BC91F00A3D;
	Sun,  6 Sep 2026 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788709567;
	bh=8H8dg2aei0gTjI0D/RDJHGrXajccjkD55r61MPn/QMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dR1p4uYsoZSy8KHFZtGwqurDjgR2LYUb1L27Zux3VQO702sKolsGhGcVZpD5vhvEW
	 PZW4vwav/J56ITFrgs8KETSlvFV0UoKOHkJjocmP54SYaUHnhD9ORRPXI6selQcj4M
	 GNZzcunBGvVtw8UqQD1wyjhq2pYNBfMW9FqAtrjYBo3ePz6bFEIY4JcqIoUuRhTwrf
	 1BVEKSt1/E1I9YwLVwMH1pmVhGYxW225SzyN2bJh29HXePaOExSWDFLLsY0Y98Y95W
	 Q1UCH57FN8H0enZhTmeZgnVGbNzzF+7zTDO0cO5sBn1ipEt97q1E5XSXs/t2mFDLnp
	 XLrdFGIR31QSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] ceph: print cluster fsid and client global_id in all debug logs
Date: Sun,  6 Sep 2026 11:46:03 -0400
Message-ID: <20260906154604.1504928-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906154604.1504928-1-sashal@kernel.org>
References: <2026090355-tradition-although-cffd@gregkh>
 <20260906154604.1504928-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 38d46409c4639a1d659ebfa70e27a8bed6b8ee1d ]

Multiple CephFS mounts on a host is increasingly common so
disambiguating messages like this is necessary and will make it easier
to debug issues.

At the same this will improve the debug logs to make them easier to
troubleshooting issues, such as print the ino# instead only printing
the memory addresses of the corresponding inodes and print the dentry
names instead of the corresponding memory addresses for the dentry,etc.

Link: https://tracker.ceph.com/issues/61590
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Patrick Donnelly <pdonnell@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

[ stable: retain only the delegated-inode parser conversion needed as
  context for the dependent fix; the remaining debug-log churn is not
  required on this tree ]

[ sashal: Reduced backport -- upstream 38d46409c4639 touches 19 file(s), this
  backport carries 1. Not backported here:
  fs/ceph/acl.c
  fs/ceph/addr.c
  fs/ceph/caps.c
  fs/ceph/crypto.c
  fs/ceph/debugfs.c
  fs/ceph/dir.c
  fs/ceph/export.c
  fs/ceph/file.c
  ... and 10 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 4bd3158bd624 ("ceph: cap delegated inode count in ceph_parse_deleg_inos()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4893545b930c3..4516fa908d70c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -437,7 +437,7 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 	u32 sets;
 
 	ceph_decode_32_safe(p, end, sets, bad);
-	dout("got %u sets of delegated inodes\n", sets);
+	doutc(cl, "got %u sets of delegated inodes\n", sets);
 	while (sets--) {
 		u64 start, len;
 
-- 
2.53.0

