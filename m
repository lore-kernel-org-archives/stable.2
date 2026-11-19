Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071807;
	b=Wkw7cfM6qMxQt20x6qOwuN2oohawiSvHBg3sC40ilESdFb1BXU7xD42WeZpyYkf7lH8U
	 JokCCI+ZRLbM8sOs0SoiHXsfNaFBinPvtnDsuohJSXEsztihGYvTjDfyIetNuwIFKHIDK
	 COI7XaDcSTeo32oDn+/+yQ6eEIuTTU9HPIWDUzCvihAzvd2V1RziboBBNQh5FCiHfRJ8s
	 5pWHpGvTVBadcnNV6yeo0i/A5mbw+SGAdOR53pgJGZw3v2zhwtowrG54kciy9HSuQ/zL6
	 wH5KsKWZmNYcVyGCgEvQCIRgOShA7GsBZ1ZvY7tdWM49MypYELu+IOuhKIyTbEBoE2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rmF6Xu+9wYrDXpgVne1XB3MHrNc0Gs4/uTZG5IQjBTA=;
	b=a2oQ5t1hqzX+8NjAB6rZot1jyqnF8udfpcIxf1H/vNK0xCmz7kkaXWmnGqFr9AiqoMhj
	 ezqySADfTqWI5ItlxSZ8CF32WxZQikZZzb4or3EcUz5Mfz17sW+urvNWyjztR1HMf7MCj
	 CmCCVYiRSoD859dX3hrCKyErYspu4BsgFzBimK9tOwtAqGU3MQ38JdxSZngmUXNi+2wQe
	 Fpa52UX+IotTq1o4+NXhGqDZyULjYaVPvQwVbN39gVEIvGWcyd51w+77h1NpsNDSuLZz6
	 lXP44fMKjB2D5KYx/okF0wrPCtim5FoJ511sCPGYjwIAzFx++mUmyN3jh8A4H2oHWYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZLpnYgAp;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE54606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BE54606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZLpnYgAp
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2efddf749e5so2586925ad.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795071805; x=1795676605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rmF6Xu+9wYrDXpgVne1XB3MHrNc0Gs4/uTZG5IQjBTA=;
        b=ZLpnYgApRVjV6JLgCyz7VdxrSVlNF3dQjVpOiAd9MfestO1XWkzFc6IU3z8+L7Ykdt
         1mXavHvJn6C1fxopWwkl/zyoGDCEYOEmdIzOlF2WWMAo9IvM38lHUdgUhlRTxz7aIZRm
         nrDsiyDSTHHzWo6Xvyaees5uJeCDwXC1qrid1fX73imkbNY+pqe+VXL6/MWAnhNaVE+g
         QymlMBM+UhAtcXQ0kBfMTIGb60my1ZA7x5wLtbFGU0s+HZgxdF+Yud5gu6IZybfvAoWy
         6eFHgUBuERSHaGVDO3SlcFpycp7RwABHIFM4pt/Vtx+vbZ3GauyjKtKByk/rfJswXqKX
         7E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795071805; x=1795676605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rmF6Xu+9wYrDXpgVne1XB3MHrNc0Gs4/uTZG5IQjBTA=;
        b=QDaW5ce8tSP32MiEB6RDdh/XnabZwHasaaeTXbMxOCkXSddnOZqssuX20MgoOlsmmx
         /bWio5cqid6DYQgZzMD5zwz79rW0pZYeguN9qlHP6kBUA0yq/3LJbYnP+Z7+QlY2nqkj
         2eFlPFuWaiGE25hF2uOBeqUG+4xetPS+UVtilXTbFkxKACo8QlGJCr3/WN4Rb+tv1J/g
         h+x4Z/U5prQZZhyOYohARPpAzK87dcWHdngO283hPORJupeyE6IlTtpVgnSV9xd+RQf9
         bBs2yIk9O7bvwNmQkHkkijkwLbaJciyT5tgU2yfGdLlW5YjXksa/p6P3nBBqD3mPKJCA
         tIyQ==
X-Forwarded-Encrypted: i=1; AL+hErEpF3hrC6IUWJj5Ian3nLO1rPuSRcKOMH4pHr6PcXoi+MiyOZaapusltJdpEg9x0A2AzkXOuGI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8otJ7xWteNxsdMmqrIb4zeaUdwcpD5lVKngFlqys55AhvxlKwS
	xFE58KFca832f2NBGFtttQ8PTsdodq9/WmOBu7y/Qh5gJhyQxoLb17Vub52DXLYh
X-Gm-Gg: AZFdTZe+7SJecbvQ+f5fQZz57jZhvlWYotBsAFnBZOXI8cP9BQ+b5DeCZmBooYJx9oT
	NhBOx9qkWVXm/8bGQVyIruGl6CSkv07hKtGgIxWQyf5paRXopV69oPThp6sAKAys8qu/nJ8pMOp
	/rjA+tGzf3U2UQ0wX8xj0ENBn9e9cmgwYmVIHPnFB/rG+ljILqTc70H4uHousi5GSfElUzVpNuX
	fyang0t9MoWSXWwKYNepmBS8uAIRXVyQqhRwCi4WNTENI2W4B6HAbM7SrUFUXkn9Dc1uaxCu/lr
	4v+iNAMfXUS+t3NR0R4qdaD9/hPKarrlN4qjXkojNKh6g1ULR0gYFbB98cWdADvkdDgu4ewJh3L
	nSaiMWSsLkuFWChUexrV3D76LtunFqYQis7zNnxzVdtPVBgSaYm9RXWocWfRQPoXFgWtsyGe1X0
	sZIgyENYkz1AcQqMD2gLiT8navxu1ap0aAqkeuc3q469jaM8YTZm11EHd/yHNKAZD38aazKETg+
	y9urCo57nsvTAQYPiMLEzLStqbduD/12rfHg+EpFtzqqNOeVexMfV+djW6ITUhPQM6NOtoMaQfT
	jJf0DBOYI4cefpSFGE359tLDPa7KWQe5hvHil42jkoIeiw==
X-Received: by 2002:a17:903:384c:b0:2ed:520:2641 with SMTP id d9443c01a7336-2f031fff21dmr2143265ad.31.1795071805138;
        Wed, 18 Nov 2026 23:03:25 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff617f8cesm25297815ad.27.2026.11.18.23.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:03:24 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: jakeld@gmail.com,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH] fs/ntfs3: accept $Bad covering the last partial cluster
Date: Thu, 19 Nov 2026 15:03:19 +0800
Message-ID: <20261119070319.3803611-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

ntfs3 refuses a volume that Windows, chkdsk and the ntfs driver accept:

  ntfs3: ino=8, mi_enum_attr
  ntfs3: Mark volume as dirty due to NTFS errors
  ntfs3: Failed to load $BadClus (-22)

The volume has 64 KiB clusters and 7337721855 sectors of 512 bytes,
one sector short of a cluster multiple, so sbi->used.bitmap.nbits is
57325951. Its $BadClus:$Bad covers 57325952 clusters: evcn is 57325951
and alloc_size is 512 bytes over sbi->volume.size. mi_enum_attr()
rejects both values.

To reproduce, run mkntfs -c 65536 on a 256 MiB image (524287 sectors,
4095 whole clusters), then extend the $Bad run to 4096 clusters and set
evcn, alloc_size and data_size to match, in both $MFT and $MFTMirr.
ntfsfix accepts the image; ntfs3 does not mount it.

Compare alloc_size and evcn with the volume size rounded up to a whole
cluster. run_unpack() still checks real LCNs against nbits, so only a
sparse run can reach the extra cluster.

Reported-by: Jonathan Pitre <jakeld@gmail.com>
Closes: https://lore.kernel.org/all/CADjMKxV2F-vgD6kVoo58j83p9Cc-xn1U_L6T7V5Y+FNNHaGUNQ@mail.gmail.com/
Fixes: c4a8ba334262 ("fs/ntfs3: Add rough attr alloc_size check")
Fixes: 20fd9f64c005 ("fs/ntfs3: reject out-of-range evcn in mi_enum_attr()")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
Tested in a VM on 7.4-rc3 (20eef29b7c84) with images forged as above,
64K and 4K clusters: before, mount fails with -EINVAL; after, mount,
write, fill to ENOSPC and remount work, and ntfsfix -n stays clean. An
image whose $Bad extends one cluster further is still rejected.

 fs/ntfs3/record.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index d7785f9e8e09..22c5a2c56064 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -317,10 +317,10 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 	 * since "(u64)-1 + 1" is 0 and "0 > 0" is false.
 	 *
 	 * For a non-empty attribute evcn is a cluster index and must lie
-	 * within the volume (sbi->used.bitmap.nbits, set up in
-	 * ntfs_init_from_boot() before any caller of mi_enum_attr() runs).
-	 * Bounding evcn also prevents a malformed value close to U64_MAX
-	 * from slipping through the near-wrap "evcn + 1" upper bound.
+	 * within the volume rounded up to a whole cluster: $BadClus:$Bad
+	 * may cover the partial cluster at the end.  Bounding evcn also
+	 * prevents a malformed value close to U64_MAX from slipping through
+	 * the near-wrap "evcn + 1" upper bound.
 	 */
 	svcn = le64_to_cpu(attr->nres.svcn);
 	evcn = le64_to_cpu(attr->nres.evcn);
@@ -338,7 +338,9 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 #endif
 	} else {
 		/* Check out of volume for normal attribute. */
-		if (evcn != U64_MAX && evcn >= mi->sbi->used.bitmap.nbits)
+		if (evcn != U64_MAX &&
+		    evcn >= ntfs_up_cluster(mi->sbi, mi->sbi->volume.size) >>
+				    mi->sbi->cluster_bits)
 			goto out;
 	}
 
@@ -370,7 +372,7 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 		if (attr->nres.c_unit)
 			goto out;
 
-		if (alloc_size > mi->sbi->volume.size)
+		if (alloc_size > ntfs_up_cluster(mi->sbi, mi->sbi->volume.size))
 			goto out;
 	}
 

base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
-- 
2.43.0

