Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814695;
	b=w3M8Y2fa1aqUzkMAA6NGWDcvO93RB7YnSl7wBsClZ30f4xzGy8Nx9xYS3277RmuoQoXt
	 a1sxD1hsOGs9VQM0IB2HcvYcqnshdvipaLh/PktsGQiqtjDljZPPAbXdmnkHcU2Sk8sGK
	 Av2tOvQLK37kv9uR3qDtmpFg8RwlM8rkf8CK3FW36BOT1eNZszXJQykYAuU2YdTCUyKnN
	 sAYWoj66afoIVIEzxgCxAA0yiwTcXeV/iUChZGCim/51K8XHd7P5Aw6Ck0z8KfDsbDTXM
	 bZTZbW4IY75ql8Z5oCFr+8hmczcESzPAdXNp+OL2E2jDdAeLEz9JKTwZsHT3hN5kXWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814695;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DPSzrUcGlQpBIa6pOMBZZMZOrJPV7dTuSI6XkuzIjJ4=;
	b=nbfhw7UvlgjU9nP284IMq9a1fulDHgrNS6M+eKhMFqAY8aAp/KeRgh3KRcQTXYGCV2tW
	 Zjr7WLKzm4+LympmwldMaaow71L+o2CfwjSdNJxCSOIIzs1A0CQaDSo0siwuyjIjmhIeS
	 rElC4sff+reiOr8Md1sFJPA2FL3yX4YcNMcoHxroTNo+Mo5XctTzIQTVTPwrtBMqTNESM
	 Nxw8nhzj2vsLgAnT+L10Yc/kBFZjMHItRFxA2Ac3HB70UciqN2RuLOs9js//FvNrsOGHs
	 efDJ1XwJO9QRoInW0L7mIKORBPH8magW+tTVRs9iKLPTygFrsDLBXTSXadwByQw4ifQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=J18Xm1OC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7C7606D825
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=J18Xm1OC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53801F000C1;
	Wed,  4 Nov 2026 17:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814695;
	bh=DPSzrUcGlQpBIa6pOMBZZMZOrJPV7dTuSI6XkuzIjJ4=;
	h=Subject:To:Cc:From:Date;
	b=J18Xm1OCMw+MJrsZnaxT9Mxnhd+I+x5dxwfvvUsA1TCBIGvoC0T+Hp3WjdUHUY4xz
	 C4X90tqwkrWMOopZTPAqNNMEl9M6FxS4DFHL+Qzy3xhKz/VK0bIcNfjhS7YPydXVEu
	 4uc+MsWTBBmdVgIwCx60xs/V+E2ZdHN+Gk6//+As=
Subject: FAILED: patch "[PATCH] xfs: check for buffer overruns when examining local/remote" failed to apply to 6.1-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:51:28 -0500
Message-ID: <2026110428-depose-unlatch-68ce@gregkh>
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
git cherry-pick -x 91c41f9524906a8ebd2ae68c98a07b4bd5255ddb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110428-depose-unlatch-68ce@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 91c41f9524906a8ebd2ae68c98a07b4bd5255ddb Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Oct 2026 08:23:12 -0700
Subject: [PATCH] xfs: check for buffer overruns when examining local/remote
 xattr entries

LOLLM noticed that the xattr scrub and repair code can walk off the end
of the buffer if the xattr entry record starts so close to the end of
the buffer that there's not even space for the entry structure itself.
Strengthen the bounds checking here.

Cc: stable@vger.kernel.org # v4.15
Fixes: 13791d3b833428 ("xfs: scrub extended attribute leaf space")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index f7c00ea1af5d..f909e2b25158 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -306,6 +306,12 @@ xchk_xattr_local_entry(
 	char				*name_end;
 	unsigned int			namesize;
 
+	name_end = (char *)lentry + offsetof(typeof(*lentry), nameval[0]);
+	if (name_end > buf_end) {
+		xchk_da_set_corrupt(ds, level);
+		return 0;
+	}
+
 	namesize = xfs_attr_leaf_entsize_local(lentry->namelen,
 			be16_to_cpu(lentry->valuelen));
 	name_end = (char *)lentry + namesize;
@@ -335,6 +341,12 @@ xchk_xattr_remote_entry(
 	char				*name_end;
 	unsigned int			namesize;
 
+	name_end = (char *)rentry + offsetof(typeof(*rentry), name[0]);
+	if (name_end > buf_end) {
+		xchk_da_set_corrupt(ds, level);
+		return 0;
+	}
+
 	namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
 	name_end = (char *)rentry + namesize;
 	if (rentry->namelen == 0) {
diff --git a/fs/xfs/scrub/attr_repair.c b/fs/xfs/scrub/attr_repair.c
index f2868fb4d27a..720090895c20 100644
--- a/fs/xfs/scrub/attr_repair.c
+++ b/fs/xfs/scrub/attr_repair.c
@@ -285,6 +285,7 @@ xrep_xattr_salvage_local_attr(
 	struct xfs_attr_leaf_name_local	*lentry)
 {
 	struct xchk_xattr_buf		*ab = rx->sc->buf;
+	char				*name_end;
 	unsigned char			*value;
 	unsigned int			valuelen;
 	unsigned int			namesize;
@@ -293,10 +294,14 @@ xrep_xattr_salvage_local_attr(
 	 * Decode the leaf local entry format.  If something seems wrong, we
 	 * junk the attribute.
 	 */
+	name_end = (char *)lentry + offsetof(typeof(*lentry), nameval[0]);
+	if (name_end > buf_end)
+		return 0;
 	value = &lentry->nameval[lentry->namelen];
 	valuelen = be16_to_cpu(lentry->valuelen);
 	namesize = xfs_attr_leaf_entsize_local(lentry->namelen, valuelen);
-	if ((char *)lentry + namesize > buf_end)
+	name_end = (char *)lentry + namesize;
+	if (name_end > buf_end)
 		return 0;
 	if (!xrep_xattr_want_salvage(rx, ent->flags, lentry->nameval,
 			lentry->namelen, value, valuelen))
@@ -333,8 +338,8 @@ xrep_xattr_salvage_remote_attr(
 		.attr_filter		= ent->flags & XFS_ATTR_NSP_ONDISK_MASK,
 		.namelen		= rentry->namelen,
 		.name			= rentry->name,
-		.valuelen		= be32_to_cpu(rentry->valuelen),
 	};
+	char				*name_end;
 	unsigned int			namesize;
 	int				error;
 
@@ -343,9 +348,14 @@ xrep_xattr_salvage_remote_attr(
 	 * junk the attribute.  Note that we should never find a zero-length
 	 * remote attribute value.
 	 */
-	namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
-	if ((char *)rentry + namesize > buf_end)
+	name_end = (char *)rentry + offsetof(typeof(*rentry), name[0]);
+	if (name_end > buf_end)
 		return 0;
+	namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
+	name_end = (char *)rentry + namesize;
+	if (name_end > buf_end)
+		return 0;
+	args.valuelen = be32_to_cpu(rentry->valuelen);
 	if (args.valuelen == 0 ||
 	    !xrep_xattr_want_salvage(rx, ent->flags, rentry->name,
 			rentry->namelen, NULL, args.valuelen))

