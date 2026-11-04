Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804774;
	b=V+B9HKFXfKAnZwc9r4g/7xDiSHJA2lBGA4RhPQz3U/TqQGRH7rD1193THNn/MEubLhRs
	 njgKNbQ6EPT4UnMIFDgKhXWYamySoGACVBjWeEu6KR8GLzFkhM1OuhIg7CyRYEpBUYdq4
	 IVjPSWm5+dkidUj09DLaafkZG9AOeXllr1vDq+qXHKdhTN9HkD1Ti5my7TF56gVtouMq7
	 uU2Va8RPFpy2LKU8QE3VbgrU7gouBUlw4uAz9vYwggJNrbQNkrizlAbtWbY8nOqCP4B/n
	 R0Zil5YuWqim+6Ua4ZiM79S8T7KDNQTqvjQSdZ89o2LiE0ImZ8926VtBKeLqVNI63bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804774;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mpjy4N7ju8WFAnWkyGbCF8Zve0rYLtgmlfwqrLPcOQM=;
	b=33dp9+jJn/m6bBm1XUKX9w6+IbG1jgQYdM/sMVB5QMukThgg8GKS1cxBCABl91g9yG56
	 /cRnECWJaA4a62YTCFvINe3/SU0XYL/lvkRDizIgsbIRfrOivTXdM9RzneVpXPYoQ648o
	 3tBI2aoOqJS0Kuu+zKMcXkiqipe7FAxg/7HEvRyZDVucGbZSdaB/G7j18AFTFrJFGydoz
	 0GUWTvwb+Nf/bIxF8YB6fvKh9xDkze571ASPfBroGSgLXmWVtKBhLeoOyjAtlKodAuqHR
	 g8SzC42zJVf0n+mP/zdo5h7du2A67xYGvHBItjVPZnZOXYB5BTzLjukoPimjWNWmNPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iX3Lf4eE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED69606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iX3Lf4eE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ADF1F000C1;
	Wed,  4 Nov 2026 15:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793804773;
	bh=mpjy4N7ju8WFAnWkyGbCF8Zve0rYLtgmlfwqrLPcOQM=;
	h=Subject:To:Cc:From:Date;
	b=iX3Lf4eEqz5B8l+DNEBCDq9j29btCNtZUBAlGBQHFz1MKJjbHvh3DlhRJrttqpwdv
	 2F8/hejP6xDvJwxe6/rdOZJDinHOIFbC+SZ41/+K1q/C/sQdQjtHIWk/ZZGAgM3GVN
	 P3PdzoB5VQciOsXZMVnCO2OrMFXORqUNYoNdhfgY=
Subject: FAILED: patch "[PATCH] ovl: do not take a name snapshot in RCU walk" failed to apply to 6.18-stable tree
To: mason@kernel.org,amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:06:03 +0100
Message-ID: <2026110403-limeade-limit-5dd3@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 0b691c3c59a58aa6a2fc3f87c10cc1e399f1d33f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110403-limeade-limit-5dd3@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0b691c3c59a58aa6a2fc3f87c10cc1e399f1d33f Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Wed, 7 Oct 2026 10:38:39 +0000
Subject: [PATCH] ovl: do not take a name snapshot in RCU walk

A path lookup on an overlay over FUSE loops in the kernel for ever and
stalls RCU.

take_dentry_name_snapshot() needs a dentry that the caller keeps alive,
because for a dead dentry the refcount of an external name stays at
zero and the function retries without end. In RCU walk
ovl_revalidate_real() holds no reference on the real dentry, and the
eviction of the overlay inode on another CPU can drop the last one.

With a delay in ovl_revalidate_real(), a stat() loop on a 48 byte name
in an overlay over FUSE, raced with drop_caches, spun for ever in
take_dentry_name_snapshot() and stalled RCU.

Fix this by using try_take_dentry_name_snapshot() in RCU walk, and by
returning -ECHILD when it fails.

Fixes: 5be1fa8abd7b ("Pass parent directory inode and expected name to ->d_revalidate()")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: use try_take_dentry_name_snapshot() instead of open coded snapshot]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 18f56d463572..cc4b0959faf6 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -100,11 +100,17 @@ static int ovl_revalidate_real(struct dentry *d, unsigned int flags, bool weak)
 			dir = d_inode_rcu(parent);
 			if (!dir)
 				return -ECHILD;
+			/*
+			 * Nothing pins d in RCU walk: eviction of the overlay
+			 * inode may drop the last reference at any time.
+			 */
+			if (!try_take_dentry_name_snapshot(&n, d))
+				return -ECHILD;
 		} else {
 			parent = dget_parent(d);
 			dir = d_inode(parent);
+			take_dentry_name_snapshot(&n, d);
 		}
-		take_dentry_name_snapshot(&n, d);
 		ret = d->d_op->d_revalidate(dir, &n.name, d, flags);
 		release_dentry_name_snapshot(&n);
 		if (!(flags & LOOKUP_RCU))

