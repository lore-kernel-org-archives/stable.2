Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604551;
	b=m3iRC3zIb2zIuK+m8pGR4THTOy2SB+HCkr0JMV8a+gtFenyHtH3G4Eu2LtVMZwSJO7du
	 HYYob/o6p33+d5yjNiZiFCCGmxc4PlYVFhGC5pPZQyF95x5QG/GDl6/aKAJDgOItiVylc
	 p6tNo7UXc1Qj9ibsqwx06Oqwmev3MM+GXf+J5SwwUzMgLp97QQnqVGcOp74D0BeK3allv
	 NJGjMF0P0bEV67TqJ4rIlEqv5Dih+/7DJJbno7IkRu3g/Vffm9062NPndKVpcL3wXQVY8
	 6NyZZ73OZVWZ48kNGKxnV9tr/q+vlRH0S+tdTizEEtmC9t1R2EKZgwalJ5bLoP+wTNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604551;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VUN2bl8xpGxe5pQZhcfsN5DtO4pjuve2EzPRFDNFV9M=;
	b=skSfb5VRDX8Gem49C8dMTIqwpf5GeKIV66O74dsHwS23wmtMW9mHE15g1YSMgDJx9DKF
	 s86atbbIk5gQvGcgLc1VdnfLC5B8TNjyHlWP5ri33J4CTVDAKpvYddPL7yQ8FbK/QPz7w
	 0xeNTfrvMenqcKIloFlu1PmRY2fxcdWgcGIBJl6seq45cTUsGAKqaTX3PzCBhlTn9wpo6
	 ODFGodpWyz9YtY6HM2KnxxTOCyRTJfZXz0qn92FyU5P0/imWibYmm8hjikUAAADDKEDI/
	 hQz87A8a7Pk57vFIKPTnup9/V32syZVCRx3PuI4I63+D4vFnp+09uzCj+wZe9YKzP2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="mamyO9/2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E29606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mamyO9/2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7757F1F000CF;
	Wed, 25 Nov 2026 11:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795604550;
	bh=VUN2bl8xpGxe5pQZhcfsN5DtO4pjuve2EzPRFDNFV9M=;
	h=Subject:To:Cc:From:Date;
	b=mamyO9/2BKvlLT2bqFkXWVeCIwIFs9MQqfHhtCGfMTVzAmLJvJq+L+QCSp8Qc3+zH
	 WbRflUWbk8f9yhzcV0IcXUke11ChuBxw5ICc5qhvLtPcUTvQI0JMfy1MpsxuxCKw4l
	 PsnkxPwIPtR4mbHOWtUZ6Tv2cF1iJ3zIwt0hW+gg=
Subject: FAILED: patch "[PATCH] ovl: do not read the flags of a put upper dentry in lookup" failed to apply to 6.1-stable tree
To: amir73il@gmail.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:43:30 +0100
Message-ID: <2026112530-unflawed-limes-7ee6@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7031366be218f291592a7ad38bc34a7cd1459737
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112530-unflawed-limes-7ee6@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

