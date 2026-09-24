Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6108E221FD4
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233469; cv=none; b=jPx0zh3wulYMoSKm4W988cjMQJcb4ZFByjn+XIQo2hVp4Tse1cHva2jIBZCkbxYJQUtloNNg0ssF7aTxmagRL8sMyQoeKw8b3AvUEvn4Ol6w2fwGB2tkK4s0Sk6MNQR3M5EIe/xe4rYEfE65zBvbTkiHkJlo02G/BLp9G05gcKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233469; c=relaxed/simple;
	bh=hSzjj5EWj93aJkVCLgJoqkSUV4JeHbR4WsKjyBSNkqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2TktxR8wLEBAm0u/I3bsPp+Ax/+8urwoLobxAERHismFX2ZuUK0Vh0IKhZgK6sBwK5JgB4yavx3yTdrTC81Oq9olxxns+oIWFkME5QraLyCCbQnFo5u14j7o6i/jGisR1r3uuCnXoVv8kf1IJdAHJis/NRU9z9phP5PvMIPMHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AASOGoCP; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AASOGoCP"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91a931f66so8876795ad.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790233453; x=1790838253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y2LTg3vvPFgbzPTkmqn0IohkH/9PUn3rBZlX6gCR2Kg=;
        b=AASOGoCPmgpcvKwW6C5Pij6fWD8oWuFePAYlGNEP4mei+K+IJw9mF+JkIpQtNfBW3R
         stxNIIJwQPht3FDyHXjXhQp1geXi+E7nnhl4xbqWLJkDEYe5Z5v/Ty/fgaTrrjdf926c
         hTagZ9ZJ4z6ZiRBbabJnvcvRZUdXOZMnfMi3MfspG+oz3fs68Edx/NAzWoy6TcGZVh5I
         jEcnjwaswU01AsVQO0AmnRM0kzy+Eivj9n+s/OgKsyxbNY1qMzx5UuGMPzBIZjtu24XW
         T5PizlQ1hjSiixUYz/GUJ6/1IhYIk8kbnuW65IJ5IfRPt/SO/3ajhjlJTNGQYQyvuhdU
         0vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790233453; x=1790838253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y2LTg3vvPFgbzPTkmqn0IohkH/9PUn3rBZlX6gCR2Kg=;
        b=eSc33IU4bXYXkoJ3I1TXXgfcJZu6DFEdAm/ak2OPmhJsNENMScGDqO6XqHURv7BG59
         xNG6ttdnYg/r5tP4n792e78mU9Pfy4mt3frEKUf9zpGiWWS6qEy2EnqHx88c+zw1+m2O
         DX+2xiyAca8XXjLUiRUIY17/IPXnU5JajKfEU7sbCnxLgHzMupMdEBjtkIh4SrNFRd5+
         TGMFUdeSTQ8RloyyhIWz9BM4fEDQF9db8BP961kNrYGs6npTkCAWs0eYAd0IIr2HHWW9
         /+lZrbpkNSw4pzTOmMFkXxgK1PV7WnxEGRGdWicuTFACpIj6YtFkhThi1mdkafFHWmif
         MY9A==
X-Forwarded-Encrypted: i=1; AKwUvBzqt3dEKjyohnlL5x40qBN4E+Ky6fKLh3PbohljtgrOl7erTKAghFaejeWueTpCTIyn7AGN9Dg=@vger.kernel.org
X-Gm-Message-State: AFuF++nULkJTna+kwUxf7DjE/LRjDIKXduPuiOGN/hNY/hcBKPWYmbrU
	0/hlQD4XCzMP/XvILDVSE1OeUpBRojM2R0+s1MNyHKdCETnU+R7qUhUX
X-Gm-Gg: AYBFou2oEHQN40r/MGapLP7sgr3us0Hyk7SZwvXj9cc5DQnUpMXy/n5YbKX/eJP+E/S
	sPCP+oXmGp4Cj3MOQxXghFbH/o7NvprAtYYaCE+M++BJsYeB/8KBZ3mtmn4O1jcHPW82NF5rekW
	Hrx6ggqWAb9jZQNxAeFU/r52ydctKpS93fiHzIHeHWyT6Fwqk0iGM2V72smJBc4/zqs44Z9BS+w
	MZKjlwqzt0Cs7lI+JLJ9uyHrri88jFSYlrpAfKzQrlhVcpTUGOfbb1jZ7DOP1zGpC+FS6TL5t9E
	s8qjUIPV3FAZyKF8qbC3g1bI8jwNXEtWuDNoekJcrHOtYfbpNjfxp9Fp2TSApQQQ7601T/tiH1M
	HzvvPGNT6mjYlxrhmf5gNaYZlr8OIPuOUosN3a7Gs/TOj4ipLkIFZ3VDpr3wCoCaUOeTzVfnhCn
	MAihjyFYsE9H+pcyo4uCbitIyfWWu4pRiWrJbIp0gjL5jTcvhh9hm1NGhYPewHep87pMg0kz9X1
	N5/Ha3EO8I4u7sTIUW0n4I3ODCvrSKNrhzlUaDnW8HVw1PITSO0zmjf/fBKtoiZ4xxGV7wi6vsN
	Qwd4xKlAJUVXpBDnT64+
X-Received: by 2002:a17:903:b4e:b0:2dd:c100:4b75 with SMTP id d9443c01a7336-2df7dc5aa2emr13480375ad.44.1790233452740;
        Thu, 24 Sep 2026 00:04:12 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a60c4a8sm21543205ad.79.2026.09.24.00.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:04:12 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2] hfs: validate allocation block parameters in hfs_mdb_get()
Date: Thu, 24 Sep 2026 07:04:10 +0000
Message-ID: <20260924070410.2629558-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hfs_mdb_get(), drNmAlBlks (fs_ablocks), drAlBlkSiz (alloc_blksz), and
drFreeBks (free_ablocks) are read from the on-disk Master Directory Block
without checking their mutual consistency against the partition size, and
failure to allocate HFS_SB(sb)->bitmap returns -ENOMEM without releasing
HFS_SB(sb)->mdb_bh, HFS_SB(sb)->mdb, HFS_SB(sb)->alt_mdb_bh, or
HFS_SB(sb)->alt_mdb.

Validate that fs_ablocks is non-zero, free_ablocks does not exceed
fs_ablocks, and drAlBlSt + fs_ablocks * (alloc_blksz >>
HFS_SECTOR_SIZE_BITS) fits within part_size, and clean up via
hfs_mdb_put(sb) on error.

Tested in QEMU against Linux 7.3.0-rc3 by mounting a crafted HFS image
with drNmAlBlks = 10 and drFreeBks = 50: on the unfixed kernel
hfs_mdb_get() accepts the inconsistent MDB parameters, causing filesystem
corruption ("hfs: (loop2): extents (cnid 0x3) bitmap corrupted"); whereas
with the fix applied mount fails immediately with "hfs: inconsistent
allocation block parameters in MDB" (-EINVAL).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Validate consistency between drNmAlBlks, drAlBlkSiz, drFreeBks, and
  part_size in hfs_mdb_get(), as requested by Viacheslav Dubeyko.

 fs/hfs/mdb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 277de712f9d4..665753a2cba9 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -214,6 +214,14 @@ int hfs_mdb_get(struct super_block *sb)
 
 	/* These parameters are read from and written to the MDB */
 	HFS_SB(sb)->free_ablocks = be16_to_cpu(mdb->drFreeBks);
+	if (!HFS_SB(sb)->fs_ablocks ||
+	    HFS_SB(sb)->free_ablocks > HFS_SB(sb)->fs_ablocks ||
+	    (sector_t)be16_to_cpu(mdb->drAlBlSt) +
+	    (sector_t)HFS_SB(sb)->fs_ablocks *
+	    (HFS_SB(sb)->alloc_blksz >> HFS_SECTOR_SIZE_BITS) > part_size) {
+		pr_err("inconsistent allocation block parameters in MDB\n");
+		goto out_err;
+	}
 	atomic64_set(&HFS_SB(sb)->next_id, be32_to_cpu(mdb->drNxtCNID));
 	HFS_SB(sb)->root_files = be16_to_cpu(mdb->drNmFls);
 	HFS_SB(sb)->root_dirs = be16_to_cpu(mdb->drNmRtDirs);
@@ -305,6 +313,10 @@ int hfs_mdb_get(struct super_block *sb)
 	}
 
 	return 0;
+
+out_err:
+	hfs_mdb_put(sb);
+	return -EINVAL;
 }
 
 /*
-- 
2.55.0.1082.g2b9226bbc0-goog
