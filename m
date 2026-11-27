Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748707;
	b=qy6XOwX5Oy5yFfYkg5diy6RMN3vuNhNVE4BF6mz1oBnqsy3mbEw2Fv7EN7rTFkKmdG+/
	 hfK0xEtX0hhVW8Nku4qEsxWOWB/IyhMZUVfBBJpXoOYTJCzcKkvvhXlxLZiNbjq0CrglE
	 jq0SwUyrgL9ZU+Yui4FpAHQWJhjY0DXdIFHHkKQ7xJFtUywI0dvHKBY60HNwrvUOyoUEP
	 XpYXTJw2ReuKFLTatG/HY/VZwTbNdsqo33BQO4biqP8jGsLT+azxmBY+99qM3X83s6GYO
	 wYWTQkjFKiv2hVFAra5GEMQBbEo86rNODgR3BTWjguL+FLi3ce/XQeoBJucITWY58CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VMJSDmNyEar0oZTXLe+VUV/WQ3gMi33nYR1P2XH9AI8=;
	b=fyYVUaC90S3Tl4yWNzyFozlv61psPUXNbrQhL/s3saJThM9vIYbS24NMgRWosaCtIZ6F
	 JJY2ulfek5qjA8usWS+LmDMDR5ee0BjS7qViomimBmlKQWEcyM0vwv8JyRMtDxBEpJvTB
	 NWCIs7ZLZWN2U74c5xFgPUYRkPM1jxHiNt1f74OhSHpghkDGpYY+pCr3GAwqK8ngLAi7r
	 pf2x3+ug7UxtOBGKCAuajwjrHXcQwcNdGmPiZ2N8TsojU+MFZK4pitYdTOENsrSbz+efW
	 9aeKJvw+ziotwhtjbvrL+YvuW+yhdqYGPHkOg/zoLSJjgh2pw3UhbfTjD0rYRHFlBiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AE38USPW;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5406606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5406606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AE38USPW
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-33e48934fa8so1474674eec.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 19:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795748706; x=1796353506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VMJSDmNyEar0oZTXLe+VUV/WQ3gMi33nYR1P2XH9AI8=;
        b=AE38USPW5TWl9F4oXD7LDVr2hn25W7zaqL+RZgZm15AUQjyNTmfZw9Yx759f6OTMuM
         CrQT1lS0N7x+8afjh1La6Lx4lTB8aNjjUYK82L73suD1lWk9IBY7F5Rjshn4cnWZPPim
         TDRhZEN+M7Cq1Xm5YD/8RiBL/Bkr61GHbql6IR9gY+4hV4aiW0XaPgON9g3V3k4dQiBx
         ggkpH3xj6SABmowixfpV0VyyFcYsMP/XMmOY+JbIg4dxSMGWkO4gla6lVIsITMK/UjjP
         +FJuJc2ncDBud2RcclfSFfjav620QfIJb9cBRFRaU02gjyj4r6gRVRirFHnw4MhalrkV
         MfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795748706; x=1796353506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VMJSDmNyEar0oZTXLe+VUV/WQ3gMi33nYR1P2XH9AI8=;
        b=ERANla8IH86RvFla/hcUFbsjua+FP5lQ2pw2PJutF78z+f/+Rge3p9jvKnVC5QNG33
         Ih6AqBogr2SUv1xpPFCSNMEjQFje3W0hTV7hjGmvpfaaE2sJjMcoo3CVH6U0cMjXfbA3
         W43HP5ROrkTg4t6mic2o8e3UgY2Qd5xZiB5Y1EXxGfCwJdB7y0tQY+h7R+3ko4QBKQiH
         lJi0kUJtEfaj59KJwgEM+XlvNMzS0SyP6018fObmJfRuBiWfhEMJSY2XefbvwF8KN+bT
         LXnQ49cqD1nF7a9nctpoj+GiVpWytwkY5QuctXGGKVG7e8cW+SGlncCLWaiGrYV4OziK
         3hlg==
X-Forwarded-Encrypted: i=1; AL+hErHp3AP47bZn+t/OWgRubYU35uRkrS2nc0g7UEWsd28jsMAS5J7xg/s+WnOlma7S2VTtC8yz0ZY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6P0ggWAsAeEEfg8T1BOFH7wzA5yIFVqgH6Db/0FgyEQgcq5ps
	ofOvvAK8ULMdZ7fxPGJakolB35TnPCJ6KareDNjyz/2Pj45Z51ZX9jSuu7hyaYP0w/JjGw==
X-Gm-Gg: AZFdTZcoLZJ/ZkCeipjSLXeQOupMyMNZ7B15H3KZgxc9pEnB7n1A8Mgn+fYWmubcDlp
	PXVqXKUThoBgWJ3GshnLV5C6PTQhpmSE+TbbF81GOp7NtvY8pq6BVYj9kO1SgPfMP/UbBo+EiHR
	+lTJWzJNInedXUH5u8Lx1GgvF22/30PlJN9CDm5i8E5Y0FZoXT1Lh4dEstysoO+AxF7oymqb3Pj
	rM3jCLbRpiClI5zoI1iYLs34N0lsQdvMIiIBSmHUu0blkh3uG51tuHKSjlmjDV1xEAcE5vRXqYN
	FrC54hwzlGEBgr0tGRsQAyAnyZ7I7qKLB3arrbMiNz9swLz+uUuNP1BSpjOm+6I/NNu7bp+dEkv
	9YgMZO2XEXYP11/ofQqdJVHzQGE+hgjHeDp41rt9GDfeR1LeVSj2/Xvniq8mm6qx0rkQDS0b09/
	Jygv4ma+Df1myuILYE+ZV+eK+jaI2R3Bj2gaYGRoRYhJjmYWicdC5GIy0XKSUSY7Lt0O1wBzKx1
	NZh3+MG5BVoNVwWsvdUtBN2NaCXDP6Pzysb40TsYXNXjJzwKBxS04VdaFWM45A+SEpaL39JyWNW
	txExc04U1QbwzWh7NuyNHN1V7n/TYLnyfMAQY/Wh9vtaKpEOStCcD9rsZCtCQBIeqVLuYzlfgFp
	JyqVNOA2BhgU+oPPBjIL0J3NpTLC7kzNW6GPWGka7oHh6zivJR1KUt7Nx5bNGRFMMSCPPS9Kfxu
	We7vareSUj2yIMl8XyTuGBhg==
X-Received: by 2002:a05:701b:4583:10b0:185:33ab:4d55 with SMTP id a92af1059eb24-1b5569101fdmr21655037c88.29.1795748705829;
        Thu, 26 Nov 2026 19:05:05 -0800 (PST)
Received: from localhost (ec2-54-254-160-110.ap-southeast-1.compute.amazonaws.com. [54.254.160.110])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm59613588c88.13.2026.11.26.19.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 19:05:05 -0800 (PST)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	stable@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Eric Sandeen <sandeen@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	linux-xfs@vger.kernel.org (open list:XFS FILESYSTEM)
Subject: [PATCH] xfs: fix log flag cleanup in xfs_bmapi_remap error path for attr fork
Date: Fri, 27 Nov 2026 11:04:55 +0800
Message-Id: <20261127030501.1618-1-jianyungao89@gmail.com>
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

xfs_bmapi_remap() was originally a data-fork-only helper, so its error0
cleanup block hardcoded ip->i_df.if_format and the D-series log flags
(XFS_ILOG_DEXT / XFS_ILOG_DBROOT).  commit 7cf199ba5a70d ("xfs: make
xfs_bmapi_remapi work with attribute forks") extended the function to
support XFS_BMAPI_ATTRFORK and converted almost the entire body to use
whichfork, but the error0 cleanup was left untouched; a later mechanical
conversion in commit f7e67b20ecbbc ("xfs: move the fork format fields
into struct xfs_ifork") preserved the bug.

When called for the attr fork, the cleanup is a complete no-op: it
checks the data fork's format and clears D-series flags that were never
set, while the A-series flags (XFS_ILOG_AEXT / XFS_ILOG_ABROOT) set by
xfs_bmap_add_extent_hole_real() are never stripped.  This is reachable
on the success path too, since error0 is a fall-through target: if the
attr fork starts in BTREE format and a three-way merge drops
if_nextents below the threshold, xfs_bmap_btree_to_extents() frees
if_broot but a stale XFS_ILOG_ABROOT remains in logflags.

In practice this does not crash or corrupt data -- the inode item
format and flush helpers dispatch on if_format and clear stale ABROOT
before if_broot is dereferenced.  But the code is logically inconsistent
and relies on downstream defensive checks; fix it now to avoid future
trouble if those checks are refactored.

Make the cleanup fork-aware, mirroring xfs_bmapi_finish(): use
xfs_ilog_fext/fbroot(whichfork) and check ifp->if_format.

Fixes: 7cf199ba5a70d ("xfs: make xfs_bmapi_remapi work with attribute forks")
Cc: stable@vger.kernel.org
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index dcd5faf3428e..9236aa80838e 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4520,10 +4520,12 @@ xfs_bmapi_remap(
 	error = xfs_bmap_btree_to_extents(tp, ip, cur, &logflags, whichfork);
 
 error0:
-	if (ip->i_df.if_format != XFS_DINODE_FMT_EXTENTS)
-		logflags &= ~XFS_ILOG_DEXT;
-	else if (ip->i_df.if_format != XFS_DINODE_FMT_BTREE)
-		logflags &= ~XFS_ILOG_DBROOT;
+	if ((logflags & xfs_ilog_fext(whichfork)) &&
+	    ifp->if_format != XFS_DINODE_FMT_EXTENTS)
+		logflags &= ~xfs_ilog_fext(whichfork);
+	else if ((logflags & xfs_ilog_fbroot(whichfork)) &&
+		 ifp->if_format != XFS_DINODE_FMT_BTREE)
+		logflags &= ~xfs_ilog_fbroot(whichfork);
 
 	if (logflags)
 		xfs_trans_log_inode(tp, ip, logflags);
-- 
2.34.1

