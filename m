Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10455282F3A;
	Tue, 30 Jun 2026 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799448; cv=none; b=Y6xFhCeG8z0RGVaaQs6M6jNxyQMGFqIVnJ6LjmL+e1UUpsPKircivoI0lEMGmPE8HvkCPfCs+c56D8j6z4a9KNcGm18XYLcO3+RYj9YDENqBhl1LJOeGufgzMc+EtdIqyJUeBnr2qb/S0fNEWYe3VjE80yYaNdPKtC3Gv66Ckj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799448; c=relaxed/simple;
	bh=P7FZWH93rHZWuFh/aZdpqdlx5le9GHubji2VVHluguI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AcDMjCnlEITw7NU2AKNa8lOu+9ieA6EarcwNx8jOR7rXGNp3K9cH+dd+3EWDkwIWiSgjzD9Jpz4MlykEMfBYT/S/mGBmpbJFaEyl6WZxjejTgmKLPyGYaeHyrhRgQITQcJVqHntUg1etXRSGJtV9K6CchuZcBEXKI82wqgWgtYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7a98dca0744911f1aa26b74ffac11d73-20260630
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a8dfb044-ee7a-4486-8d54-18ab8a570e5b,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:8ada8ee015e162a3bf54aed1b7d7ee48,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7a98dca0744911f1aa26b74ffac11d73-20260630
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1234571968; Tue, 30 Jun 2026 14:03:56 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: validate error codes from untrusted disk data
Date: Tue, 30 Jun 2026 14:03:50 +0800
Message-Id: <20260630060350.40957-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ntfs_lookup_ino_by_name() returns MFT references read directly from
disk, which are untrusted data. The current code extracts error codes
via MREF_ERR() without proper validation, allowing maliciously crafted
NTFS images to trigger kernel panic.

The MFT reference encoding uses bit 47 as an error indicator, but the
lower 32 bits can contain arbitrary values. If a malicious image sets
the error bit with a positive integer (e.g., 1), MREF_ERR() returns
that positive value. Returning ERR_PTR(1) causes VFS to treat it as
a valid dentry pointer since IS_ERR() only recognizes values in
[-MAX_ERRNO, -1] as errors.

This leads to kernel panic when walk_component() → step_into()
dereferences the bogus pointer at:
    struct inode *inode = dentry->d_inode;

Fix by strictly validating error codes: only accept negative values
in the valid errno range [-MAX_ERRNO, -1]. Convert all other values
(positive, zero, or out-of-range) to -EIO to indicate disk corruption.

This prevents potential security issues and ensures proper error handling
for corrupted or malicious NTFS filesystems.

Fixes: 1e9ea7e04472 ("Revert "fs: Remove NTFS classic"")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/namei.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 9c1c36acfad2..e3ec1f2663cc 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -236,7 +236,18 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 	}
 	ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %i.",
 			-MREF_ERR(mref));
-	return ERR_PTR(MREF_ERR(mref));
+	{
+		long err = MREF_ERR(mref);
+
+		if (err < 0 && err >= -MAX_ERRNO) {
+			ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %li.",
+				  err);
+			return ERR_PTR(err);
+		}
+		ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %li.",
+			  err);
+		return ERR_PTR(-EIO);
+	}
 handle_name:
 	{
 		struct mft_record *m;
-- 
2.25.1

