Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D523112BC
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586507; cv=none; b=W8xxIHnt0fpfMbRdkQa9h5xH/K3gVACoupPldyb6itHoKrlgFjPD+ZW24M5A4eKjibx/dP3zIDtd0YtzzKCFnZrdcTE45m1pGgV1lxBKfILtcWBoVR40TE2dyRmf9aGP57IaOG8NpBjz9xFU8rJM0UybZHPExDfsfhGH/XtZ07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586507; c=relaxed/simple;
	bh=aOZX+QFamvnY+Frb6Q0jmYzs679Vqgk82cKkdMo3AbY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LCYpSfkzmqFmuAdgCl4Nn4umcpY/+NXtqnX0BIXTx1LsdGYnQQuqE/yv24NSznwgQqg6xDFvX5lXNSVRV8A3Af7A9ThBWRtk9sh+UVzOyIbbHrHpf1TOBnVdmp/iXZX0kfK1RVU+mPw0TF1NTnpaz2R9/pWP95MKTtB49uFATkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUJqzeg6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUJqzeg6"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so702012f8f.2
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780586504; x=1781191304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LfIemd9P8F0K810nDdqrmnwRzhWzEDP+Ov9sYoYEEMk=;
        b=pUJqzeg68+7HfKYR8E5rzkNlyWJl84QrYBm/0oxG5lRq/U1zXFoRCwCMftJk5Na2iR
         f42NLbFMSDlqUtr0XqBFjtOOS/9rloKQKLuO9CrM9EVDPUX/SfZ5SpUCJCPzgPOyJ9li
         7kQmeeAxD1QMkbJZ28VkPVUvnjx7MzKvo5WmngOI8+sV4loBQqJsDYqbG2MrPoYx7/+P
         EEYx1QpWgd/BA2DIFLi1yEhNqIRIe8nUmhb65GCJwNr+zIihOecyuhdnJQFhg2rtRPOw
         Lt7hbEstXbY7AYJ2nXiXybHhrMydGiekkUao7ZH7yGF/iCI+orLT5xvo7I8RVDJf4jxr
         2dZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780586504; x=1781191304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfIemd9P8F0K810nDdqrmnwRzhWzEDP+Ov9sYoYEEMk=;
        b=gCHhtAXmaJUIJf77qtCwbb8WndM1vwC5BwwkUjXhOZGTbYWKCFHhtg7uLImoq1saFp
         7u1C0HygY48iZJ5mST+AY8GWw3cQrjIvz3J/YBbbFlMGWM9uUy00Kyp/FzVZBX553KIr
         Uuo5c1VoSlunizD93QXQl/D1jcIsKqHcqybuPPpiZfThiJ2lkghNJtQwwjvG63n3Lary
         +VEow3i2hqeennIqrr9+akqG9x6DkQBWKFmEHldgxX/z60ScNmG0RSf7Yd6omxF7vTrv
         yDgvZgLDg0x++fur9+sFtJSymjEDxjLRR2Nh2I4rfxd+jHJv5DP/E4MWsZOztvw8bQgs
         K4SA==
X-Gm-Message-State: AOJu0YzZUKabKbbgiEVE82AUO4PljPthcVtiS3fsmtdlwsEb2ALz5ngi
	4cGiorP+UEV5RgQubgJo6oFK3Ev/NxJxfLrgiC9NwNF6Q+XoYdXnDU+BB1JJfA==
X-Gm-Gg: Acq92OH+pxV3x74EaDvlRznaSO0H+1Gz4XAcfuFtxacek6kD077vErWQJqDj8oB00nD
	QhpWm/eZ7cAR+rXj7tXUFFV6JT/xl2sliYBqlEF1O+8lYWhtuZyVgqex9ngkc3sLtd2Aa1zM7Es
	qvLZ/sbg40UveR4WreugejmNgu9jjMx91hIKMug6UQdYO5M+SkIuDEVErKfPq75e1FR6BoeX8O6
	zF6HGI3NHg8ro9QwKy5/iDEwXl6V76dZcT4Jyu4SdeNzTkcPeJPbY2+1Nty6LWAfoh885HO01Qo
	VIC6J6LY5BNfWLegZtXsLFWkrkvDkrNmRDITUCB9GQdXhv1npzPIrtNc7ZPIa6BGz664o+fzBgt
	TZn0fD03dnH4mw7XAXfBQNRWHPjIX+5VtID7Ta9Bxa0zKdHOVuKtBl/RtDEJ1y5sAST50KENRtH
	dfFxbMhAAiZLeurv2lKdgOQuztf82tDMlJKqeXW6WFQp6AytMRXXfnZ0XdazWf6KWFXdNqvqrfU
	4Td2+G62nygkuvN9TwHlcdbGaeZtA+u77KNHa1Y
X-Received: by 2002:a05:6000:2210:b0:45e:f684:7347 with SMTP id ffacd0b85a97d-460218e7e63mr13165346f8f.12.1780586504359;
        Thu, 04 Jun 2026 08:21:44 -0700 (PDT)
Received: from localhost.localdomain ([192.129.190.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f34413csm16732650f8f.21.2026.06.04.08.21.42
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:21:44 -0700 (PDT)
From: Shaomin Chen <eeesssooo020@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y] xfrm: iptfs: reset runtime state when cloning SAs
Date: Thu,  4 Jun 2026 23:21:19 +0800
Message-ID: <20260604152119.1694883-1-eeesssooo020@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 7f83d174073234839aea176f265e517e0d50a1d2 upstream.

iptfs_clone_state() clones the IPTFS mode data with kmemdup(). This
copies runtime objects which must not be shared with the original SA,
including the embedded sk_buff_head, hrtimers, spinlock, and in-flight
reassembly/reorder state.

If xfrm_state_migrate() fails after clone_state() but before the later
init_state() call has reinitialized those fields, the cloned state can be
destroyed by xfrm_state_gc_task() with list and timer state copied from the
original SA. With queued packets this lets the clone splice and free skbs
owned by the original IPTFS queue, leading to use-after-free and
double-free reports in iptfs_destroy_state() and skb release paths.

Reinitialize the clone runtime state before publishing it through
x->mode_data. Because clone_state() now publishes a destroyable mode_data
object before init_state(), take the mode callback module reference there.
Avoid taking it again from __iptfs_init_state() for the same object.

The 6.18.y backport keeps the existing kcalloc() allocation and adjusts
the context for d849a2f7309f ("xfrm: iptfs: only publish mode_data after
clone setup").

Fixes: 0e4fbf013fa5 ("xfrm: iptfs: add user packet (tunnel ingress) handling")
Cc: stable@vger.kernel.org
Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>
---
 net/xfrm/xfrm_iptfs.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 7cd97c1dcd11..e11e4f7411fd 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2650,7 +2650,8 @@ static void __iptfs_init_state(struct xfrm_state *x,
 	x->props.enc_hdr_len = sizeof(struct ip_iptfs_hdr);
 
 	/* Always keep a module reference when x->mode_data is set */
-	__module_get(x->mode_cbs->owner);
+	if (x->mode_data != xtfs)
+		__module_get(x->mode_cbs->owner);
 
 	x->mode_data = xtfs;
 	xtfs->x = x;
@@ -2658,22 +2659,40 @@ static void __iptfs_init_state(struct xfrm_state *x,
 
 static int iptfs_clone_state(struct xfrm_state *x, struct xfrm_state *orig)
 {
+	struct skb_wseq *w_saved = NULL;
 	struct xfrm_iptfs_data *xtfs;
 
 	xtfs = kmemdup(orig->mode_data, sizeof(*xtfs), GFP_KERNEL);
 	if (!xtfs)
 		return -ENOMEM;
 
-	xtfs->ra_newskb = NULL;
 	if (xtfs->cfg.reorder_win_size) {
-		xtfs->w_saved = kcalloc(xtfs->cfg.reorder_win_size,
-					sizeof(*xtfs->w_saved), GFP_KERNEL);
-		if (!xtfs->w_saved) {
+		w_saved = kcalloc(xtfs->cfg.reorder_win_size,
+				  sizeof(*w_saved), GFP_KERNEL);
+		if (!w_saved) {
 			kfree_sensitive(xtfs);
 			return -ENOMEM;
 		}
 	}
+	xtfs->w_saved = w_saved;
+
+	__skb_queue_head_init(&xtfs->queue);
+	xtfs->queue_size = 0;
+	hrtimer_setup(&xtfs->iptfs_timer, iptfs_delay_timer, CLOCK_MONOTONIC,
+		      IPTFS_HRTIMER_MODE);
+
+	spin_lock_init(&xtfs->drop_lock);
+	hrtimer_setup(&xtfs->drop_timer, iptfs_drop_timer, CLOCK_MONOTONIC,
+		      IPTFS_HRTIMER_MODE);
 
+	xtfs->w_seq_set = false;
+	xtfs->w_wantseq = 0;
+	xtfs->w_savedlen = 0;
+	xtfs->ra_newskb = NULL;
+	xtfs->ra_wantseq = 0;
+	xtfs->ra_runtlen = 0;
+
+	__module_get(x->mode_cbs->owner);
 	x->mode_data = xtfs;
 	xtfs->x = x;
 
-- 
2.47.3

