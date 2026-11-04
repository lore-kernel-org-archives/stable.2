Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805392;
	b=BybZ4rtTB6VS32WPapgIGNnpHsvgJclyN9Sywtar9op4h4vntpSMh5ckBykewa/d6kSq
	 a6yn9zS7D1FeprvSQ+e4ZcNwPaagS4MpMVSqBhTDJchistQQcBGw1jH0VN+4t9uEUv6Tu
	 O1eAKDuxmVm//zKv4vZHFDI9OKeTuwSNNDzam6iQgSFNYL2jVGPRj14ZPKF/2XPVmGiz9
	 Gz+Kitf2mNEN7IPYGMq0gqfuse2dbLQBCJYrg6sB4zuh0vGB6pDSwg7FSeLrQuX7mDCM4
	 QVGyi5KzIAnbzUT847yfLUSAyqeMwC2FVbIC5ku0z4JGhSk/kIiBLimwQ0OH7T0L19A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805392;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RBHyQyuHOxcn/x1MzJGVzkm+LkBak5YTl22wll0DaYc=;
	b=Djd54PiCA53+sueKAhgbHc+TqvGzLwh4FtTZXlCuZSNYKJOiqgHcjemPWXAjs1YePHlv
	 8TS84ojpBMGrffxFi0SNndW3FxjulERQGffd4S5AeVj8RrHgpxAKdlZtFvJs9MYe5o9WR
	 su5XPM4L064Y+oEGMH3QYfuP8YPlMUmW2YnvV3ol636NRUjvf4DI6I68OWsA1VcF+PjQz
	 biUhLIYiHL/PlOvslvKT+cSyt+pRlalI5MfGpokSnz9QVIctoNEdKZ+S9TsYnCHX97rem
	 bVHOBo9Wq+WaesaYqPr3ZllAjnPHrHlONoom9A5Ori6bj8Y19LE0SIO4oCq+vhc8lqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="tE/RTp0a";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D45E60A5BEA
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tE/RTp0a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045A91F00A1C;
	Wed,  4 Nov 2026 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793805392;
	bh=RBHyQyuHOxcn/x1MzJGVzkm+LkBak5YTl22wll0DaYc=;
	h=Subject:To:Cc:From:Date;
	b=tE/RTp0aHPeuf3vodHJs2aJ/w8rl2oonSY0XkIPSXTTR2IMf8mv9dHZo90LdoF8TO
	 dYNP3Jn0ttJUEnBiBZlh7nHrJMbIxChA01kbgq/kWtnMC+DUF2uJwzLBbiy3rzkcpc
	 20QKHTR6ILWMKGm84chOVbUme3PnGbEQNJhmANwE=
Subject: FAILED: patch "[PATCH] xfs: jump out of xchk_bmap_check_rmap if fatal signals" failed to apply to 5.10-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:16:31 +0100
Message-ID: <2026110430-implant-perch-2ec4@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 49d300a51442bd64b627645b7b0b1cd66e492905
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110430-implant-perch-2ec4@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49d300a51442bd64b627645b7b0b1cd66e492905 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Thu, 24 Sep 2026 21:13:06 -0700
Subject: [PATCH] xfs: jump out of xchk_bmap_check_rmap if fatal signals

LOLLM observes that we never check for fatal signals inside the loop
that checks file fork mappings against the rmapbt.  This can lead to
lengthy delays in responding to a ^C, so add some bailout checks.

Cc: stable@vger.kernel.org # v4.17
Fixes: 5e777b62b0bcb6 ("xfs: bmap scrubber should do rmap xref with bmap for sparse files")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/bmap.c b/fs/xfs/scrub/bmap.c
index c190590bc562..4dff40dd426a 100644
--- a/fs/xfs/scrub/bmap.c
+++ b/fs/xfs/scrub/bmap.c
@@ -625,6 +625,10 @@ xchk_bmap_check_rmap(
 	struct xfs_ifork		*ifp;
 	struct xfs_scrub		*sc = sbcri->sc;
 	bool				have_map;
+	int				error = 0;
+
+	if (xchk_should_terminate(sc, &error))
+		return error;
 
 	/* Is this even the right fork? */
 	if (rec->rm_owner != I_INO(sc->ip))
@@ -656,6 +660,9 @@ xchk_bmap_check_rmap(
 	 */
 	check_rec = *rec;
 	while (have_map) {
+		if (xchk_should_terminate(sc, &error))
+			return error;
+
 		if (irec.br_startoff != check_rec.rm_offset)
 			xchk_fblock_set_corrupt(sc, sbcri->whichfork,
 					check_rec.rm_offset);

