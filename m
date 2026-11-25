Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604553;
	b=MjC2Vb0TFL2SNdXQUsiaDA91RiiM1l0RSq5FGP+rgnSy15IW9vxgdWrmTQOyPsgiOyN3
	 ImzzcmYWJQ4xaPIdTlk2EDMAKePZqWiJCvmx0AYW6hmiFr5yz0fOnqxSQCIK7b45M1QiL
	 JZQL6kpY/fztLfhT/UjsU+nagc+fXp0EymQI5UBjEn1QYPIqkr1zMgXLPfjzTG/NnyFrE
	 tlx1M6Ci0RXn3nRTlmgGBYkZxxHoBLzSF6xIIkBC9QIqoYzkihZb0M13E9JtHDWV07QMK
	 WpC/DkG4s1/br+rab9TPhi9FQGo7RSDoN7KMQkIJex5zql5x6teGJqePTmeS5dkYlWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604553;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JgbHbPXC5zcXTtnSzaQeeQYHusyN+VFcvZik3SSrqc0=;
	b=Af/ZcmjWNkgHkN+lBD2v9UkGI4q/KovVECrEGuMN4DPR5Zni1H96Y5F99Dsf2k0rnNZY
	 jeumPsWY7qci4OiDWvAVs0UXesioumXlmB9v2vhg2uFzxQl+O6JZyGPneZl3DgfmjMcno
	 8my2gvctKoA8Lwl6lhfkoFG9mrNr4vDiarEIEXKf3m45tiTSJm5UBKZWhfGQUJedDe6TI
	 y/8ESg+sFgGYz2bQWdaIQ1afG/xuYsuNq0wI42FQ4ZC3FsUhHMYox1zOnXFhxwkyWZ9ed
	 VzqFO7usNz/Y0mSVNADjas1O9BPpfpG31Kw9AyO/KfXit6WcquAZfpDavRGLrsX7Iaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eBFyUavl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856B1606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eBFyUavl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61B91F000C4;
	Wed, 25 Nov 2026 11:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795604553;
	bh=JgbHbPXC5zcXTtnSzaQeeQYHusyN+VFcvZik3SSrqc0=;
	h=Subject:To:Cc:From:Date;
	b=eBFyUavl2NN+newB/Q+3JhbgOtAAZtyeRbhvLVUjMMJWfKV0Mn2Cs9nwliBdYv0hu
	 FkJmLNBNZeGLXcqmBApZAegBJnY4C07LAgexOCjOKUAu8QIFvPSQ7XHWpu3UWGIU/7
	 jxUfWRPs/SHuuylZcjwiSkZjRm706KaJe6tvgpOM=
Subject: FAILED: patch "[PATCH] ovl: do not read the flags of a put upper dentry in lookup" failed to apply to 6.12-stable tree
To: amir73il@gmail.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:43:30 +0100
Message-ID: <2026112530-preplan-eldest-5662@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7031366be218f291592a7ad38bc34a7cd1459737
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112530-preplan-eldest-5662@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

