Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CD7286A4
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 01:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788743003; cv=none; b=M2PPYeKWHAJD20jJmJ49X5xUgOjyXbp4RVFUXuuJ/BOSO2cWBGIMJGZnX/zGY49nhCanzjR5tz8C1RS/nLWJ0rUQYZRB0gs3nMliuMq0mjV/SMTFb6pnCzjbuuXrTF+++EvU5I6LIPpXhaay+7cOLV+iXtCmW0XpLqT0+rnZkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788743003; c=relaxed/simple;
	bh=OVak9tL2byUvu8cSSyvrwsL3yhG+KmC3husRegqMfEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdySQzCB3Sc6cvl07QuGD0t4kkdZJA0VEPAYZNf/ejpyw5acZOCDg+DP82OxLkA2McBYLb4FrebgBVaXO34DGDPj2ii2IxYyO7PPLYYkoWFZE7QB4n8QnKaH9aj7oGw4mEeNdr16LDEtsvS9IVdCkvzGazujOobG/QgJ1BXKtlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP6bC+DI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP6bC+DI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC171F00AC4;
	Mon,  7 Sep 2026 01:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788743002;
	bh=WaUeF5JCeZgK1wUNbhoMVmx0N4TVvOWfH9o/f4lv8vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LP6bC+DIEeho4JfNJXYmxZHGWwTMv4+WjaDCZokfMOt+x+v5UBOY68efNy+kgTgh9
	 zQ+Wi5yRP8vcCfEGBhIkVTX44Iwxi7Y/AHa4MmtjngdC0zC42bY+sQjgzlobVh5kVH
	 ICSC2DVe117eyTLIrKWOxDxuiL8WrR3Mu9y999Z0FbFGv8P+Z9QpradFtBP5ILL+p7
	 Zh5oMsGIgBFM07qFHpqERgXcL0ux/zUImmY3GCwqD82vU/VrGJiogIudd5I2SZq8QY
	 VmSCA0Zjx2w6dBDX/HnZBfRBJZ53NhRw2BwW8GvsM8K4zD6Ktb8GpGmfNRuQX4nb0u
	 tvv/KD+bjq7fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] cifs: fix loff_t underflow in cifs_remap_file_range() when len == 0
Date: Sun,  6 Sep 2026 21:03:19 -0400
Message-ID: <20260907010319.1950366-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-dweeb-catchy-bac2@gregkh>
References: <2026090322-dweeb-catchy-bac2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 6c322f5cf7476ded7a9a20f7be72462065a03c68 ]

With len == 0 (clone to EOF), the effective length is computed as:

    len = src_inode->i_size - off;

If off > i_size, this is a negative loff_t, corrupting the ByteCount
in the FSCTL_DUPLICATE_EXTENTS_TO_FILE request and inverting the range
in filemap_write_and_wait_range().  The existing off >= i_size check
fires only after the ioctl has already been sent.

Snapshot i_size_read() once for both the bounds check and the length
calculation, eliminating the TOCTOU and 32-bit torn-read risk.  Reject
off > src_size with -EINVAL.  Treat off == src_size as a no-op,
consistent with __generic_remap_file_range_prep().

Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ added the missing unlock label at the existing common unlock path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsfs.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 900ac4d04d901..228087c90de25 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1117,8 +1117,19 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	 */
 	lock_two_nondirectories(target_inode, src_inode);
 
-	if (len == 0)
-		len = src_inode->i_size - off;
+	if (len == 0) {
+		loff_t src_size = i_size_read(src_inode);
+
+		if (off > src_size) {
+			rc = -EINVAL;
+			goto unlock;
+		}
+		len = src_size - off;
+		if (!len) {
+			rc = 0;
+			goto unlock;
+		}
+	}
 
 	cifs_dbg(FYI, "about to flush pages\n");
 	/* should we flush first and last page first */
@@ -1134,6 +1145,7 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	/* force revalidate of size and timestamps of target file now
 	   that target is updated on the server */
 	CIFS_I(target_inode)->time = 0;
+unlock:
 	/* although unlocking in the reverse order from locking is not
 	   strictly necessary here it is a little cleaner to be consistent */
 	unlock_two_nondirectories(src_inode, target_inode);
-- 
2.53.0

