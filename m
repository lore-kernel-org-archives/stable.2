Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818211;
	b=W9UijH+n0mKVeZrGn53gREr/MwuVujDHoJj7dSz5ei/P+tf+Vvn0uFnMF+VChWPLtW36
	 D/174bcH9nu+uV0XwcS6pJVvn0JwUPMtbxVM2JKQfzkqz9/vjlXzJkR5Fi1yEx4v857FI
	 nzjgvBYurK2cDI55Qvb8MmFbdw3lzRztqwhEyADhAQjFBcRMc0wq6QRKCRNOmfHjnQZ8a
	 tQ8lz5MVsxzFKSVyCPDUe1IYp2FSWvIU5+ZJr/4dYVURaJ+kyQONJZyQUEwaJu+lVWL7n
	 0m6PFpVfRd9gGJF1vwZpBU/qaJnoYqD9JSkrzJnurm/YOu+R2VT/WGkCYcXh7Sz5gXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818211;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Xhr2Ytn2X3PTQ2gBDq3CEfeOeSLnQwBzX4oAXwzQFvQ=;
	b=k4GVsD8qUSdAA15fVGuXnbu/oiwKZYauR4HkX/jWJHYX3IZR5CrDveHetI/Mnx2F+ZYf
	 MHS1kIMZ2WBZZjNIterybhWDRHoS4l8bkWcB1G8hVKcpcnb1/jbJVQtGS9BfdFjpcS3Ff
	 6wNgJ9u6RFfuUFqLBdfGuuZWuXQjAgD+YDt4lUUl+DJ2IBr7ogyELrrRacAaOeUp3cSO6
	 zxmP5tsRLcWra+m3jfwXbYx/LjqhW7lRSnUsCfZt+0bpqD5bFvUFvqTT72OnphfhKXf2E
	 UALIT6dWV2Ye1OVM508fUwBeUFs7CGuneTRAw790de3dEd0u89/IlbPFzbyuf13kq7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rDb24L7G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB75606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rDb24L7G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BA41F00919;
	Wed,  4 Nov 2026 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818211;
	bh=Xhr2Ytn2X3PTQ2gBDq3CEfeOeSLnQwBzX4oAXwzQFvQ=;
	h=Subject:To:Cc:From:Date;
	b=rDb24L7GEB2tOmgzNdJ9HXbzYHCHeUkZD9XOr7iFfMtEiBAPVW5emLS7dJzx+Fwh7
	 HlS1xWjhvi9ASd86gC6nu48aZP6yA55T6ttRasoLgEXu4p2Y4KIu9w7e6Id/NZlC3b
	 eLeZEbi3ItDbpTAP5Ow5+j5hAtK3yGJRK+HE+S08=
Subject: FAILED: patch "[PATCH] nfsd: don't offer flexfiles layouts when NFSv3 isn't being" failed to apply to 6.18-stable tree
To: jlayton@kernel.org,cel@kernel.org,itsme@benjiwiebe.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:50:09 -0500
Message-ID: <2026110409-glaucoma-strongman-8f52@gregkh>
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
git cherry-pick -x 5d28b2c920d9d9d3c45b41769342ad785eb372a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110409-glaucoma-strongman-8f52@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d28b2c920d9d9d3c45b41769342ad785eb372a7 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 4 Sep 2026 12:11:37 -0400
Subject: [PATCH] nfsd: don't offer flexfiles layouts when NFSv3 isn't being
 served

The flexfiles layout driver hands out a deviceinfo that names this server
as an NFSv3 DS (flexfilelayout.c hardcodes da->version = 3). With v3
disabled, the client can't talk to the DS: it loops on v3 NULL calls that
the server answers with PROG_MISMATCH, and I/O hangs in D state.

Skip LAYOUT_FLEX_FILES in nfsd4_setup_layout_type() unless v3 is enabled.

Reported-by: Benji Wiebe <itsme@benjiwiebe.com>
Closes: https://lore.kernel.org/linux-nfs/c734eeb8-8486-4491-bb4d-b9656cbaffbe@app.fastmail.com/
Fixes: 9b9960a0ca47 ("nfsd: Add a super simple flex file server")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260904-pnfs-ff-v1-1-5f502cf25401@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 4187202f9acc..12acb68cbc3b 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -128,10 +128,12 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 
 void nfsd4_setup_layout_type(struct svc_export *exp)
 {
+	struct nfsd_net *nn = net_generic(exp->cd->net, nfsd_net_id);
 	struct super_block *sb = exp->ex_path.mnt->mnt_sb;
 	expfs_block_layouts_t block_supported = exportfs_layouts_supported(sb);
 
-	if (IS_ENABLED(CONFIG_NFSD_FLEXFILELAYOUT))
+	if (IS_ENABLED(CONFIG_NFSD_FLEXFILELAYOUT) &&
+	    nfsd_vers(nn, 3, NFSD_TEST))
 		exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
 	if (IS_ENABLED(CONFIG_NFSD_BLOCKLAYOUT) &&
 	    (block_supported & EXPFS_BLOCK_IN_BAND_ID))

