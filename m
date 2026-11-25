Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604544;
	b=g7F3QsMZGn4DS/ILsOJlwcgZU0cNuTG9HRHFK0/E6AtoQx2MaMhUBUJ5pfh3XHW/Noj7
	 fj8Dh2g5N/dGqL1PeEWKVZlYT9HzBD1h9fPP9Yg0qCVaubDPHbNFg1XO62hQLVE/wbJvH
	 glwQFfa+3n0j0++unaEWkxNavJCyXcqB3CQ9fnVRdH4a1Bj3tKic71D2LzbirLzGlIrPy
	 HvDu7XGVu04lLKY8MWVbSS5o61TMzl6+P16lJ88MLDZ9ngjKAXOSix9SA7BEz4umxuyj3
	 u735Q/vsj69dbvpfm9BCXIAZP+lAzK3tKk9tiOBY3rJVewCj1+Moeol5Ups2qMKbQ1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604544;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=am4olCwUf0xgyc9EGwas2FO/0A5QnPIKbgciV4Ox/Hc=;
	b=f1LeFFPIEyvlnrE62u/wd9UoNPOjd8w4/rNoL8RzewPUmMi1eN4ldeJGm9IzsiaTTFgj
	 ncM+uHx1BrlUnw22Y/IMnZmAqxnHAnddZ6q5FFoiEKzpceXVnzKiaAbDNpBB5S5Zv7O30
	 NzSeKwQ+sfMQANOXALw0hFFFhU3Ow40UApprt8D2tRZyTiIhnCSdwuWtMTsX718GCxxB7
	 /iSKqbSBPuZZ44aRbAmzpMKmQnkYekZO+MaOsqtalLhcQj3q0C/SAzFZJTXLZZWHKcK7R
	 KdfEVgzJk0dNes7KOBs8cwjtp3iixbBWfDocw7exBbn+OUMbIeN/UYDCywWHUZzXtuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lpxigqJP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A98606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lpxigqJP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62391F000C6;
	Wed, 25 Nov 2026 11:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795604543;
	bh=am4olCwUf0xgyc9EGwas2FO/0A5QnPIKbgciV4Ox/Hc=;
	h=Subject:To:Cc:From:Date;
	b=lpxigqJPZPX7bfy+Tmw5R8lkgG1b+5WlWjK1kb2B0b73MfGYSjrUyIGNZjAzu90SR
	 sKUBjnRLZi1DIWxu71dpzivgruapTf98tW2LmJsCS9MfkSsx6n1CLWHBNgznJRRdQ2
	 ZK5H9jG3d4Y1iKhQKP4CoQN1syJu2ms2nfMLV4Vg=
Subject: FAILED: patch "[PATCH] ovl: do not read the flags of a put upper dentry in lookup" failed to apply to 6.18-stable tree
To: amir73il@gmail.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:43:29 +0100
Message-ID: <2026112529-hunting-smugly-d292@gregkh>
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
git cherry-pick -x 7031366be218f291592a7ad38bc34a7cd1459737
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112529-hunting-smugly-d292@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7031366be218f291592a7ad38bc34a7cd1459737 Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 6 Nov 2026 13:01:26 +0100
Subject: [PATCH] ovl: do not read the flags of a put upper dentry in lookup

ovl_lookup_layers() passes ctx->upperdentry to ovl_get_inode(), which
takes over the reference. If an overlay inode for the upper inode is
already cached, as for a second hard link, ovl_get_inode() puts the
dentry and returns the cached inode. ovl_lookup_layers() then passes
the put dentry to ovl_dentry_init_reval(), which reads its d_flags.

With a local upper fs the put dentry usually stays in the dcache, but
with a FUSE upper whose entry has timed out, dput() kills it, so this
is a use-after-free.

Fix this by taking the revalidate flags from the upper dentry of the
overlay inode, which is the one that ovl_dentry_revalidate_common()
revalidates.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-986db859-840c-479d-944c-b9c43b93377e
Fixes: bccece1ead36 ("ovl: allow remote upper")
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 64d63b260709..98e846b3846c 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1382,9 +1382,17 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
 
 		if (metacopy_size > OVL_METACOPY_MIN_SIZE)
 			ovl_set_flag(OVL_HAS_DIGEST, ctx->inode);
-	}
 
-	ovl_dentry_init_reval(dentry, ctx->upperdentry, OVL_I_E(ctx->inode));
+		/*
+		 * ovl_get_inode() puts ctx->upperdentry if it finds a cached
+		 * inode, e.g. for another hard link, so use the upper dentry
+		 * of the inode.
+		 */
+		ovl_dentry_init_reval(dentry, ovl_i_dentry_upper(inode),
+				      OVL_I_E(inode));
+	} else {
+		ovl_dentry_init_reval(dentry, NULL, NULL);
+	}
 
 	return 0;
 }

