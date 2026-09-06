Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90453202C29
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 19:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788723046; cv=none; b=MokzWw9JBFYjgbfO9JOykzguKmOIb8YiulDdQz56RMmSC9DK5aLP5kpTJo5TJ1zjJ/UEinfmUDxu5JsNs7tdt2bEaNMx9GXxuXI6srVk5SZXuC0Op5MzOOW7Nmzob4ED+kUrV6EVJHl6BeXE8wD8gHi7XsGe0pehvla30tKwkG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788723046; c=relaxed/simple;
	bh=81fW8voMDRqkdzoDDTim94XYMPsK24BZkIk3zA+LYTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTbJ8UDRyejlaw1PG3ctSit4A7ZIIc+91iTUO6VV2XGvm9fPhuwfLYD/sHlID+OP/N/KKyahie137wgyZujem4dRKGyDQbC0A2dTa9bkRvKmSO7Y4c9tfR4lF9ZvEM38y+bdPP6KwRfxiI64IJh/0ZPLvXkGmKoXMsZl5V5wgeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmMRXf8t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmMRXf8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA27A1F00A3A;
	Sun,  6 Sep 2026 19:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788723045;
	bh=OgarsnZFkntx1QK3wsZ4AFGNcowL/gxaxLm7NX0Putk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XmMRXf8tBJbGcgvPoWlTJfxy3mo1SJhtlrAmDF+qgFWzgvuPO2+kHAeZ+s7ZgiTvx
	 TFU2M8ASj0I5xkMoVcl0WDUcZ3EQhKnDa4hnLkZg906XFfAbdX6CUYPV2BhpzKzo7E
	 4m7DyePZ32lhTr2uFjTR3vl7M9GUZoB+Ruol+cZobC4kbJQLY3cV1CNDzIcJ37o1Ay
	 W1tNO/kWBW6zHHOFNHm57w9dgjdKktXmlSaDci3lBkwk1sP3GRcAWkzziTUW8YkT5G
	 NZwzpXYrzp9MO4K2KoR/HLRJoYmlHMrNBpZNrH7/UcxyBx0RDDj7osiloriqu9bsCB
	 2OrDyBo3cVuIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] cifs: fix loff_t underflow in cifs_remap_file_range() when len == 0
Date: Sun,  6 Sep 2026 15:30:43 -0400
Message-ID: <20260906193043.1791564-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-serotonin-marsupial-e485@gregkh>
References: <2026090322-serotonin-marsupial-e485@gregkh>
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
index 7bdeaecc6c508..e3572c30be4f9 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1171,8 +1171,19 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
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
@@ -1188,6 +1199,7 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	/* force revalidate of size and timestamps of target file now
 	   that target is updated on the server */
 	CIFS_I(target_inode)->time = 0;
+unlock:
 	/* although unlocking in the reverse order from locking is not
 	   strictly necessary here it is a little cleaner to be consistent */
 	unlock_two_nondirectories(src_inode, target_inode);
-- 
2.53.0

