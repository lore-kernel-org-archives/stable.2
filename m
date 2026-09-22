Received: from mail-wr2-f27.google.com (mail-wr2-f27.google.com [74.125.225.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABBC3EDAB3
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051590; cv=none; b=TsNWWfVZwsRVILQXyVl80uY+hAiR3mHxERcE7zNdNbAee1AvLXGpFsRYo+EVPw1j+ISXiInoAfIDU/FVbDHQ7pP1GgC6k8NU9t25RAn+5zqNMH1ANyT8Si8+P+Hapx9EYrmJTMxpgEGcu+4bP2miGS45Fp4Y9ZOk71b8XILAyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051590; c=relaxed/simple;
	bh=B6CpHE1fDzJtw02VVA6XiCr6+jtSG7DDQ8B6ZbaZFOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kFCZytWtYL4J9SYIgAM6ePz1k0HOj80mXFGFyqXQ3JIlFRVCYpdErInwB8MShWTFrNn8qN9u4dEl3E1sZrPvg4yBZ210hbSb/DFJnK9koQdpvfIYjBir1qtucMZJCgt1um9EkzPeB35+jUKYM8sF+cgQoSvzhRCb/rPpOLX/9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5ALZ20X; arc=none smtp.client-ip=74.125.225.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5ALZ20X"
Received: by mail-wr2-f27.google.com with SMTP id ffacd0b85a97d-4843796e373so2052410f8f.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 21:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790051587; x=1790656387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HkSG5y+EkU99t9dm75vxcWD0esNMkVyz0Y8AlZlwrNo=;
        b=C5ALZ20XsUS209xtO44XOm2SKIv/Ca/2QIKM9Tjwe7AMCZD5vMz1RYQtZq9+BXOXVM
         E0xorcAV+5MYEVcEAedy23NdDNYzh550mNTRYdRl/Nqqws7c8uSJq97sHgBxkBHb+brC
         /JuAqOZ5aebzMjhSE2CmiB5x9gBRKGkS7/hQ9IG/97NokkGhkSOTxo8qdBi99vJXUvNb
         DZ+7WxGcmXQ43EyzL2BEaBKGO+bBsSK9m4vVl5R8JOlOQcnfps7+aZ2JEUakUDZhxlGQ
         6cete4GNS1ZH7fUgpLQO6FabTpAR5tPrk0120UeQVFu++SLFk8fdIC58VGijA5GfJTYW
         aOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790051587; x=1790656387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HkSG5y+EkU99t9dm75vxcWD0esNMkVyz0Y8AlZlwrNo=;
        b=GeZE988uChdkKYy10m/L+cC/uBvZRIgm0U7f8nUW7v6SZxAdIhD5/GRR45tkQd4DKi
         /Vb9HlsxPKBRDqC5aE2PCzjoaFzu9v8U84+tG2i1dk5REXbOi9F7guDDUD6dUatCiAwv
         vSRjlYnwzAAOl6phrWPB6nXblfKpo8HWsLZeXzI21b/bmCeH3NS9+dgHzQmxGlRfpcir
         hfr+kVIAkWmc7h/glOzcyfrGfGyiFN/niSw+HsZQTHbuofjrpXXyLAu29pLcKJ4zWXgr
         cEEkJcbU3C8KGy1Wx4NNWbWn1I3KMEhlFbOAFU/oUeXKBq4xW8X1nXethRTJWiGnJP3M
         nHog==
X-Forwarded-Encrypted: i=1; AKwUvBw3o0vRTnfj3JEzunkqEofrqD9YWQKAVu44Ra9cgnIpBE5uRwfCKwNIvgNJLL7xoQky7yMQR64=@vger.kernel.org
X-Gm-Message-State: AFuF++nQwHxDRNcJmPXi99onT4UUdrrI5TZ4DbD1fSPKHErzAEzagVZu
	3ttgTO27Sk2AL8mVcSrzBliQqPgNbxQd2J49dN4RlPqqak0xqhAqKbPQ
X-Gm-Gg: AYBFou1/tQtN8E070tVLhyC1gEXZIyDSBlZMkiTxsBvIwbtzDRzGqApObykrDeeOKrj
	F4eLraotu2oMUebiFdNAzw4XfcAAtIPcU6ikIrXzUfOyUYDwfQkeHat5pR6j/+3DaMboRGijDjg
	KlojGTTjOoX3yNy/tHS7ZOYBPBzHO5kQN2ACUx68wneJqx9xbnbnwFlLvYato2fBAYyq641q538
	hjxr7Khe3xAfym0fae0hknHEgLHaUavB55VBOnAY3JlmcdhKTjdjTNVyUjYxlwQMUDwrEvlZuEZ
	ZwtLvfyPUQ9SuXin5AUg73ReLl3ykt1b0TuzfCs12AykpVTcJOwks1L4ogZJW+0VeUeHAsSTivk
	t2Tu5JckbzeIWVZdCLVmtBkMNGhU1UaRseAiYmLK2wpUzrXB4F9QpJFl2wrBLAhhDxHkksUObr5
	f4ynbnOUnzvqSnvn/ZS44M08jfk1L0E1Mvo94g/YGhsnWteS6Ng/LAhZSfO3HMtscU05M/MAd1L
	Z14hfWL8Q6g/yrZdmgKHp/3HjsGOb1X+CzD1K8/OYSdAZggVRULbKd9Tfb+8a+T9KLF1QvxbXXq
	IXtm+tE3Ob21a/WS6vuES74mYrHHTgFIr5YHhVOUQeO4dFQy+3/3vrTwSK+SgbYvtm7Qj1n3veo
	xEahoVA==
X-Received: by 2002:a05:600c:3b98:b0:49d:1f10:8b9f with SMTP id 5b1f17b1804b1-49fc56dba0dmr220453475e9.7.1790051586799;
        Mon, 21 Sep 2026 21:33:06 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a5e6-3401-ecdc-1e24-2e52-02d6.310.pool.telefonica.de. [2a02:3100:a5e6:3401:ecdc:1e24:2e52:2d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862773ee0sm1751410f8f.6.2026.09.21.21.33.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 21:33:06 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: include the final partial cluster in sync writes
Date: Tue, 22 Sep 2026 06:33:01 +0200
Message-Id: <20260922043301.15101-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_attrlist_repack() synchronously writes the replacement attribute
list before updating its mapping pairs and freeing the old run. With
512-byte clusters, a 544-byte list submits a 512-byte bio, but the
write returns 544 and repack accepts it as complete. If the later
buffered update does not reach disk, the replacement list lacks its
final 32 bytes.

__ntfs_inode_non_resident_attr_pwrite() converts attr_len to clusters
with ntfs_bytes_to_cluster(), which rounds down. Before repack, its
synchronous callers used either cluster-aligned lengths or lengths
smaller than one cluster, where max_t() selects one.

Round attr_len up so repack writes the final partial cluster before
publishing the new mapping pairs.

Fixes: b1d732e62a5b ("ntfs: repack $MFT/$ATTRIBUTE LIST")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Built fs/ntfs/ at 444c7dc82415 with W=1 and NTFS_FS=m for x86_64 and
i386 using GCC 15.2.0. Both builds completed without warnings.

Runtime-tested with QEMU 10.2.1, x86_64 TCG and virtio-blk cache=none
on 4904082812d5, a v7.2.7 stable queue containing b1d732e62a5b. Test
hooks called the normal unlocked update, forced the optional expansion
to return -ENOSPC and used a 64 KiB reserve on a 16 MiB image.

With 512-byte clusters and a 544-byte list, both kernels paused after
repack and before the buffered update. The old code submitted 512 bytes,
returned 544 and left a marker in the second cluster unchanged. The
fixed code submitted 1024 bytes and wrote the exact 32-byte tail. A
1024-byte list wrote exactly two clusters and left a marker in the
third cluster unchanged.

A test hook returned -EIO instead of submitting the 1024-byte BIO. The
rollback restored the original mapping and all 544 bytes, and freed the
entire replacement run. The image cleanly unmounted and remounted
with the unmodified queue kernel.

Runtime coverage was limited to the repack caller, which writes at
offset zero.

The base's scripts/checkpatch.pl --strict reports no findings.

 fs/ntfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index cadf623d54d48..d8d3a7b7b8a9a 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -3761,7 +3761,9 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
 			struct runlist_element *rl;
 			int bio_err;
 
-			lcn_count = max_t(s64, 1, ntfs_bytes_to_cluster(vol, attr_len));
+			lcn_count = max_t(s64, 1,
+					  ntfs_bytes_to_cluster(vol, attr_len +
+								vol->cluster_size - 1));
 			vcn = ntfs_pidx_to_cluster(vol, folio->index);
 
 			do {

base-commit: 444c7dc82415a353b57e43189f276124cc5fd785
-- 
2.53.0

