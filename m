Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818216;
	b=zQl3z778q3ivNS9T3PgVn62cKo2QCaAyMJh6mJcj9hqvOd8Hks+lqKjHuFjkCbpDEmes
	 RDqKpr9/yxCkKoPcNeb0h92ahPFheumroeE7OiukLyTkQeZ3NhVXSFuKcljz/YEEpr0on
	 yrZkTOf0dEGTg+v3eiKiJjGUSaDIHbNoV6MACLnblQriloNPIr0KAUuqsAgA5Rv/NX7A6
	 GJP2u3kizAPjltChWN08RyCRyZyy5fFFaQank62yPobq2myeZNQR5MsjYostAUH6x5PMe
	 BH7nvG86OsQnBsLAO8TxvW2Dk2mK2GjHbmPDDZbWZ1ElrIfBmyrJ5sIeQQJrvhg9Ivg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818216;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UsV0dN01Vg5fC9X7byxzespgVu/8/WAXqQ8aGoifyOQ=;
	b=BNgnzZe8dhrzky6MVJZoz22eD+gtLbB3qbMUo0SMo0aOhStU2QGhUJAU9OGdo6/dJvID
	 kV2vaVsHfYl2RXWM7k5TU0wPi2DFYvOpCjhghDfyzlwSpzrqWVlVsyCVXrEilGqZUOfqS
	 syXXZ0/zfKRGValAQzY8+Bz6d9uz8vw/ZPOsczBsYtLrYasqslAtIURrJyDTIvJnHQeMg
	 xFO9nbW4d4DuAKFfmyvyQgF56Tv5qwsPv8m3xU1Kz+YD930ofRh7rZqvNIfjawRx7nToj
	 euIqFX6FT/PnifSLOHhh/cHMnC+iaS3C/8W7049p2MURQS02BVrE0YMmgOwufIV40Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2mj3yk3f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87994606EEAC
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2mj3yk3f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECA91F0093A;
	Wed,  4 Nov 2026 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818216;
	bh=UsV0dN01Vg5fC9X7byxzespgVu/8/WAXqQ8aGoifyOQ=;
	h=Subject:To:Cc:From:Date;
	b=2mj3yk3fLAanuQBoMz3C/K4Y36GnRuAWGWtANTt4+8KWzIRLnp9BYR1JdHPxTiX52
	 oP0cZqMzRhKi1fEvtzbIV4T662+uPPDQ8oMpOM5ylHqn/jpSXeef1KuBl8cgTcNDCe
	 ltroQX2d/6AYhKuTQWvmnRtYJc2N5OTvFeXTnFh8=
Subject: FAILED: patch "[PATCH] nfsd: don't offer flexfiles layouts when NFSv3 isn't being" failed to apply to 6.1-stable tree
To: jlayton@kernel.org,cel@kernel.org,itsme@benjiwiebe.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:50:11 -0500
Message-ID: <2026110411-frequency-agency-61c8@gregkh>
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
git cherry-pick -x 5d28b2c920d9d9d3c45b41769342ad785eb372a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110411-frequency-agency-61c8@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

