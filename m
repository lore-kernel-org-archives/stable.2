Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700915;
	b=A/uzCtXKLaKceTrgmlsYDz8B7k6ypENzS52BziL53TKhQrDGuirn4JDXkDeFAdOeSi0G
	 d1GCOOQ7djzNDRxV3GL2hesPU/5M5rJee+ovVbL+WlZZ000Nbf7BtBVaLfJCphKik6GJa
	 //i2RTHaxQPxYKM5fi3JeHthtpT5Il/Ul0zyKu2f7tSdyaV2Njbmz6dR3VgXXiyIopVbp
	 prWXbcH/CMt3lO6ntotH+ZhEWEofcZ4QtJiHU7xZPO+6SzAhKgShbVYHNKOkbpB8WdSff
	 fnAeHmAKtMFccwrFP8PYKQLcAUMVwM/X9I/er4eSRnuDTAT8HXHSxoTfWEbSssy+W+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700915;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=d9Hrjv+gC/gkYBTIVhCu1BOJY/TGbf/gHCclWQt4bSs=;
	b=i69WaV0YjbxPJsxHQB+gA9nsTYVYUljG+8k3rKmhO1jqG2BayXcmOpCX7iSymPcSVc9a
	 pj39pQjbAYXKgI4wv5SmS3/4wB9AXeFZn9iW5NHEO68Ox2DuCdUarv/bznDdqymb5rLgV
	 QrPLw33z2+iPafCQ125CR/j2LXzmxmd5FRrIxjerBlf7g+AudxfmWotvOs3+2bxgRytt5
	 kgecxGVoMxQ/xIxEsUgPqgvsVbHGiykESCYP0MNIQ59YBjMoF2NxDXOovQ/IpWCcaFKfC
	 0Is0bbV1DaZP4kTFcFuvbBSJSFS2yLVzx05zMSMwPo2mFQrYgmOY77dPjz4TP/7+B6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WIYQ+8FZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930706070AA7
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WIYQ+8FZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087911F00919;
	Tue,  3 Nov 2026 10:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700915;
	bh=d9Hrjv+gC/gkYBTIVhCu1BOJY/TGbf/gHCclWQt4bSs=;
	h=Subject:To:Cc:From:Date;
	b=WIYQ+8FZWKEGnTm6Id1UIeb1GXUHFiYti9qah3/ps22dRIcOeRTeYraNpQoUcQfG2
	 HojNsTRiE8xqW+i+tnymY46A6WemySg6Eh4d9CjtsLblqO16DQXrgNR2XTX5j+vsvb
	 +KV00d1vCWyEls/C2cg09jNwejjbJgO6RoGAWVFM=
Subject: FAILED: patch "[PATCH] ksmbd: avoid restoring only in-memory EOF after allocation" failed to apply to 5.15-stable tree
To: charsyam@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:15:13 +0100
Message-ID: <2026110313-diagnosis-specimen-de6d@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9455e920aebe41217cabff3f81e90da4c407fdb6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110313-diagnosis-specimen-de6d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9455e920aebe41217cabff3f81e90da4c407fdb6 Mon Sep 17 00:00:00 2001
From: DaeMyung Kang <charsyam@gmail.com>
Date: Sat, 17 Oct 2026 12:40:50 +0900
Subject: [PATCH] ksmbd: avoid restoring only in-memory EOF after allocation
 change

When SetAllocation requests a size below the allocated block count but
above EOF, ksmbd truncates the file to that size and restores only the
in-memory i_size. The larger EOF remains on disk and reappears after a
reboot. A 3-byte file preallocated to 64 KiB can acquire a 4 KiB EOF
after reducing its allocation to 4 KiB. Extending EOF this way is not
a reliable way to reclaim the preallocation beyond the old EOF either.

Only use this truncate path when the requested allocation is at or below
the observed EOF. A truncate to the existing EOF still lets filesystems
release preallocated blocks beyond EOF. Remove the in-memory-only i_size
restoration. The size check still precedes vfs_truncate() taking the
inode lock, so a concurrent shrink can make the truncate extend EOF;
that race also existed in the original path.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 1a0a8cff33bb..9c6345e63434 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8788,24 +8788,17 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 			pr_err("vfs_fallocate is failed : %d\n", rc);
 			return rc;
 		}
-	} else if (alloc_blks < stat.blocks) {
-		loff_t size;
-
+	} else if (alloc_blks < stat.blocks &&
+		   alloc_blks * 512 <= i_size_read(inode)) {
 		/*
-		 * Allocation size could be smaller than original one
-		 * which means allocated blocks in file should be
-		 * deallocated. use truncate to cut out it, but inode
-		 * size is also updated with truncate offset.
-		 * inode size is retained by backup inode size.
+		 * Truncate at or below EOF to discard excess allocation.
+		 * Truncating above EOF would extend the file on disk.
 		 */
-		size = i_size_read(inode);
 		rc = ksmbd_vfs_truncate(work, fp, alloc_blks * 512);
 		if (rc) {
 			pr_err("truncate failed!, err %d\n", rc);
 			return rc;
 		}
-		if (size < alloc_blks * 512)
-			i_size_write(inode, size);
 	}
 
 	fp->allocation_size = le64_to_cpu(file_alloc_info->AllocationSize);

