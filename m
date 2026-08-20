Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39F13D905F
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225815; cv=none; b=OWZykE2kElrDIWM0xeTzLaQzT20rkiAuCTw77D32zz61mmw2mFAvWVRhVWkOqbYhzVndRClIdA8Bz2lrX7K7I61IE7CHs/PW6l89BYftyAOWhJBaPy/Ti2Cb7A7iZvWnjkQ+QcH4hkJ2odQ+ApOAcmDKivvxksVZbB7zW/oBowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225815; c=relaxed/simple;
	bh=k1ECcuwGnKjZ2DevUz2g/1l0C8Wa4kry9s9vYtnzNf4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oMEXLA5XohFrFqeNMel72bNB00Jx+SAGqpgsHWtPn8ZbujelQ6kmj1swuzPXH0gFiMgtsMQPsLlln15ZxTjwjXoSPR5eNAb4+6yLBnTUZ+J2XxsZSh4dhVAFPq76Wjix+AQJJbLFDBryz6pFslTLDspFiT0ZLt+w/xObNPWs+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0DHCC0wr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0DHCC0wr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3711F000E9;
	Thu, 20 Aug 2026 11:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787225813;
	bh=kYoxskEbxm5Z2ZYBx4FRYfkRUPE1PFav+sLlEbQ5heA=;
	h=Subject:To:Cc:From:Date;
	b=0DHCC0wrk5B6rf0lVr5VEajcYr3BAAVkCsw/kODo7Kf2NtqGr2HUThGajWa5zoBhy
	 hnoJKEOFGtxIxvgfHpIZGTg3znTIn6s0ehyvLS2OCl7SgIlfa5AJalKuJFr5rDRa/Z
	 7rJYuFzHj0hX8LjBVNDwCUAmq3qmulJymGzPrghA=
Subject: FAILED: patch "[PATCH] s390/vfio_ccw: Limit the number of channel program segments" failed to apply to 6.1-stable tree
To: farman@linux.ibm.com,borntraeger@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:22:13 +0200
Message-ID: <2026082013-overreach-viability-e9b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 5405c90d6a47b3014e74ee0618a162449abbbc93
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082013-overreach-viability-e9b2@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5405c90d6a47b3014e74ee0618a162449abbbc93 Mon Sep 17 00:00:00 2001
From: Eric Farman <farman@linux.ibm.com>
Date: Tue, 28 Jul 2026 05:30:14 +0200
Subject: [PATCH] s390/vfio_ccw: Limit the number of channel program segments

The processing of channel programs, and the CCWs within them, is done
recursively. As such, there is an arbitrary (but not architectural)
limit to the number of CCWs that can exist in a single channel program.

The vfio-ccw logic breaks these channel programs into segments whenever
it encounters a Transfer-In-Channel (TIC) CCW, and the combined number
of segments count towards the global limit. Impose an equivalent limit
to the number of segments until such logic can be made non-recursive.

Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 086d1b54bdb0..1c2890d139c6 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -332,6 +332,7 @@ static struct ccwchain *ccwchain_alloc(struct channel_program *cp, int len)
 		goto out_err;
 
 	list_add_tail(&chain->next, &cp->ccwchain_list);
+	cp->ccwchain_count++;
 
 	return chain;
 
@@ -441,6 +442,10 @@ static int ccwchain_handle_ccw(dma32_t cda, struct channel_program *cp)
 	if (len < 0)
 		return len;
 
+	/* Limit number of chains in a single channel program */
+	if (cp->ccwchain_count >= CCWCHAIN_COUNT_MAX)
+		return -EINVAL;
+
 	/* Need alloc a new chain for this one. */
 	chain = ccwchain_alloc(cp, len);
 	if (!chain)
@@ -745,6 +750,7 @@ int cp_init(struct channel_program *cp, union orb *orb)
 			vdev->dev,
 			"Prefetching channel program even though prefetch not specified in ORB");
 
+	cp->ccwchain_count = 0;
 	INIT_LIST_HEAD(&cp->ccwchain_list);
 	memcpy(&cp->orb, orb, sizeof(*orb));
 
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
index fc31eb699807..a9b1d8dbc6f6 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -23,11 +23,18 @@
  */
 #define CCWCHAIN_LEN_MAX	256
 
+/*
+ * Maximum number of chains
+ */
+#define CCWCHAIN_COUNT_MAX	16
+
 /**
  * struct channel_program - manage information for channel program
  * @ccwchain_list: list head of ccwchains
  * @orb: orb for the currently processed ssch request
  * @initialized: whether this instance is actually initialized
+ * @guest_cp: copy of guest channel program
+ * @ccwchain_count: number of channel program segments (linked by TIC)
  *
  * @ccwchain_list is the head of a ccwchain list, that contents the
  * translated result of the guest channel program that pointed out by
@@ -38,6 +45,7 @@ struct channel_program {
 	union orb orb;
 	bool initialized;
 	struct ccw1 *guest_cp;
+	unsigned int ccwchain_count;
 };
 
 int cp_init(struct channel_program *cp, union orb *orb);

