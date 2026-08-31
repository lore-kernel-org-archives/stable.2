Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B830639D6CA
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178976; cv=none; b=kaods67pbsE/MQIu1AEpV8HeOzK1Uw7kNNKdxeAc/QrQALYcItGlqHXfKmtrw0PmS8dCX5G8yks/eJSZeDIsKaAZapfxc4ZFS1DM0WPhFP+lr0jr+7CxDnCjBpJ+fSZCCq5dAp3FUZV4ltYFmOKsSP0VM01D5JOEhUrpX+stRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178976; c=relaxed/simple;
	bh=oUQMulW3fHDwkVB30ShBQ8lzjEWLIR+PunKo2aQH/qU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M99l0uOboEqCCBMUfeJHtVB2xR02g7LZ3qFtrbbkkZ/1zWwJt0Mx7W54MOBTGo5GjpWQAJ2bxv5qwuIpjrGx863mqTHsB6ox1N8Oqv+4h4a4x5yGL35LsdmX4TAwnpBdtCRsIIsRPcX9oRQrK6h2FqKBLIvZuar6YcjF95qvxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xzqnL0wI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xzqnL0wI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A381F000E9;
	Mon, 31 Aug 2026 12:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788178975;
	bh=eMUpJwhEwZ3nkAicLBhXjU3yFRZI9M86qwIhlMpD7Eo=;
	h=Subject:To:Cc:From:Date;
	b=xzqnL0wIv/8UEwr0rnD4D0HyI/XUptWWBUs8uf+br/mtIrBSEG/42rCVpiNMuErSE
	 +AhdrTl3oqf61u6EkxJGWMHq9MbLccdF6IirtU4WLm6ch5qIaZlaIlW2MaAJkOQnPA
	 4kBWuAKQ5X3pwhq2v5w3GlqvvfjgCYOx3HITli5c=
Subject: FAILED: patch "[PATCH] fuse: fix missing barrier when checking io-uring readiness" failed to apply to 7.1-stable tree
To: joannelkoong@gmail.com,bernd@bsbernd.com,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:22:42 +0200
Message-ID: <2026083142-mossy-turtle-dc44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x edb310bc27f0ad83e7fd558a3caf1a94ca511654
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083142-mossy-turtle-dc44@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From edb310bc27f0ad83e7fd558a3caf1a94ca511654 Mon Sep 17 00:00:00 2001
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Jul 2026 11:31:42 -0700
Subject: [PATCH] fuse: fix missing barrier when checking io-uring readiness

fuse_block_alloc() reads fch->initialized and then fch->io_uring.
fch->io_uring is set before fch->initialized, ordered by the smp_wmb()
in fuse_chan_set_intialized(), but fuse_block_alloc() has no matching
read barrier between the two loads.

This may lead a CPU to observe fch->initialized=1 but fch->io_uring=0,
and skip the check that blocks request allocation until the io-uring
queues are ready. This can reintroduce the lock-order inversion deadlock
that commit 3393ff964e0f prevents.

Add an smp_rmb() barrier to pair with the smp_wmb() in
fuse_chan_set_initialized() to prevent this.

Fixes: 3393ff964e0f ("fuse: block request allocation until io-uring init is complete")
Cc: stable@vger.kernel.org
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7e81dea4f1c7..a27ea64d763a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -85,7 +85,13 @@ void fuse_chan_set_initialized(struct fuse_chan *fch, struct fuse_chan_param *pa
 
 static bool fuse_block_alloc(struct fuse_chan *fch, bool for_background)
 {
-	return !fch->initialized || (for_background && fch->blocked) ||
+	if (!fch->initialized)
+		return true;
+
+	/* Pairs with smp_wmb() in fuse_chan_set_initialized() */
+	smp_rmb();
+
+	return (for_background && fch->blocked) ||
 	       (fch->io_uring && fch->connected && !fuse_uring_ready(fch));
 }
 
@@ -120,9 +126,6 @@ static struct fuse_req *fuse_get_req(struct fuse_chan *fch, bool for_background)
 			goto out;
 	}
 
-	/* Matches smp_wmb() in fuse_chan_set_initialized() */
-	smp_rmb();
-
 	err = -ENOTCONN;
 	if (!fch->connected)
 		goto out;

