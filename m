Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA463CF21B
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687681; cv=none; b=ku22b5utfmU4v64IP2NLi8taK/BSwQ0yyGLWBPMsc1a8vb5resVPzjD07VjlJrVO+gBUgUj6aPIGNpHTh3s75dSZaPMtk4Dil4IAZbCGeiwtjAt6e8RqPGvAYRBnmqrFVUwLZBRjTBd5KCHHf67lUal46Wu+DImo3FzIyzqM+eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687681; c=relaxed/simple;
	bh=31Z3y7y0ksK1jBF5obj4/irW0nRTbUrrucEu0RLb6Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIjBJe4Pe5SLEtbKAZ6cqPktOFAkmJLHnXSu5czr2E+6+XwoXNMMvFNwPY2saCmazjBPYc6Lbkh+ChtfAwQ3FBULXRspCR1jsA33ZNehUP8pi9PTON1Ff6Dj5eEdKv5iv+wNIBGAXc13CB0nDl3o/p2iOa8Y3dTfq/+lq6ciLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqhJdVlR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqhJdVlR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf77d4a4e2so19861105ad.1
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780687677; x=1781292477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f71aXW94wH9CfeGDBNkWa7n5fbV3KWrQbSfdeEu5BEQ=;
        b=XqhJdVlRbBS2izLVJyur1tnCHhac2dq7h2TyBISpmbqccI8jNddAbDhMVYJOFDHjd5
         h9bzhgRVxLN3k6WFRh64Q9CTR6xi5hWtGbkDNOciJHf2EZjqDs0Zjg4cZyCUelqGIf66
         oqcYbtIGanWTrq0i0fzxjHujNFfIDLYZWZLv7TlUrGMG0VsfCHr62mYiFZ+GHwLh82s9
         5ElJUlAop4w8MfOw2UijzGO8UFts0KpQ9B/r2UltXIR3PC9XkmVttBkGBCbNHz977k57
         m2Xgr53NZpRVJPgwUIO4uJuFuuxddXpPHhZ/8yIpkMQoQ6u/MiTeq6+pOqubZJNpvlDM
         rd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780687677; x=1781292477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f71aXW94wH9CfeGDBNkWa7n5fbV3KWrQbSfdeEu5BEQ=;
        b=E5at4N2EGbIAUtELwf+bpU3NWDHE1YG5HpeFtDcD8Bt2bzY2yJl43/SilcmTz/634J
         bIip9vZqLdDqDFjZyKZ5IOGa6BjEI332v/Ip/ltxvEUF+CsIsbbOriFyGu9FEuEDMrPq
         c80pcgHZ7b1VR00V5JRZw65PHNnMl2ZnC/Zro9iY96tKP5+V0qL77xWbNijl+fBFRDzg
         4inKcXl8luXAuyARmOtbubwjMSB3cw9uLCfMQFJKbEcTuhIF/PAvyeKG63P2Afr7ugBr
         yKHyOsZKbTIUCMUAoMTJYc7ukPeib7SSpJwD8iqRV4B9hbLJH6vHoq0J3m29QBwvx9dS
         mvng==
X-Forwarded-Encrypted: i=1; AFNElJ9vACAjg0yDcrUoAyqR5u9oJxaueA8UeMb33pQAWHK8iLe57Z/Fuc4C3KeRRMBA/0iPg9WZ8hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDPmFd+mG4LciEE8lGC6qz5Cy2MaJTpvIrktWBb8/8drCxJ7bp
	FLbmkH01K0vXNHsC5I8c98g9d8bxxvkJYp2Ncu6MaT5NDcThgBlGKSC5
X-Gm-Gg: Acq92OGEQZQYTb9qeOZFzlOnn0FqcPdzfgpbJR7V0HKYFC1n27VVlKs3Zsd4nPXPyre
	09cGrl9EN9u4mPQEX6MCELW9ShNFkIyeh7+/9zDDtjUTnugJmtHRCQ3K/9Bag1FTgAatqQcGQuQ
	tseL6a1PhpsgFa4r8mv4nklQHOh71xfQwJgc4IUMRth8kRmSKcF+Uf9aJ4Iw5B8ihozZ4pbJxRc
	+G+9sWNM9RtvoIN81mb7l6EUl79GAKTYNuFBCCLpMVuR0pZFj2kg6lWsAvfTEL/WEXBU6KlkUYg
	6I03Ro8KIY6H4f/DhuOIBQuimSY6cucsb6EbozK+PSTFDKOontVi8/W4TaX5yDemHg/dG7HsNzP
	uRtX5aMS61IV5RPrr1B/lXisYFynudkpCkwZlZr7sXZROnIeL9IoPzi8FEMXyxVdVuqvIJL5rB3
	m0R6ILzvTybm6UTQot4HIskh4/8QQ=
X-Received: by 2002:a17:903:2385:b0:2c0:dc5c:9069 with SMTP id d9443c01a7336-2c1ec54cc43mr41203005ad.2.1780687676741;
        Fri, 05 Jun 2026 12:27:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c166391d53sm133125475ad.65.2026.06.05.12.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 12:27:56 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	fuse-devel@lists.linux.dev,
	Chris Mason <clm@meta.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] fuse: fix data races on ring->ready
Date: Fri,  5 Jun 2026 12:27:07 -0700
Message-ID: <20260605192708.141921-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605192708.141921-1-joannelkoong@gmail.com>
References: <20260605192708.141921-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <clm@meta.com>

On weakly-ordered architectures, the store to fiq->ops can be
reordered past the store to ring->ready, allowing a CPU that sees
ring->ready == true via fuse_uring_ready() to dispatch requests
through a stale fiq->ops pointer. Upgrade the store to
smp_store_release() and the load in fuse_uring_ready() to
smp_load_acquire() so that the preceding WRITE_ONCE(fiq->ops, ...)
is visible to any CPU that observes ring->ready == true.

Additionally, fuse_uring_do_register() publishes ring->ready with
WRITE_ONCE() but the fast-path check reads it with a plain load.
This is a marked-vs-unmarked access that KCSAN will flag. Wrap it in
READ_ONCE() to mark it without adding unnecessary ordering.

Also wrap the fc->ring load in fuse_uring_ready() in READ_ONCE() to
prevent the compiler from reloading it between the NULL check and the
dereference.

Fixes: c2c9af9a0b13 ("fuse: Allow to queue fg requests through io-uring")
Cc: stable@vger.kernel.org
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/fuse/dev_uring.c   | 4 ++--
 fs/fuse/dev_uring_i.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index e33847436693..7cd50990b097 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -986,12 +986,12 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 	fuse_uring_ent_avail(ent, queue);
 	spin_unlock(&queue->lock);
 
-	if (!ring->ready) {
+	if (!READ_ONCE(ring->ready)) {
 		bool ready = is_ring_ready(ring, queue->qid);
 
 		if (ready) {
 			WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
-			WRITE_ONCE(ring->ready, true);
+			smp_store_release(&ring->ready, true);
 			wake_up_all(&fch->blocked_waitq);
 		}
 	}
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 368f4d0790eb..6af604e17b2d 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -167,7 +167,9 @@ static inline void fuse_uring_wait_stopped_queues(struct fuse_chan *fch)
 
 static inline bool fuse_uring_ready(struct fuse_chan *fch)
 {
-	return fch->ring && fch->ring->ready;
+	struct fuse_ring *ring = READ_ONCE(fch->ring);
+
+	return ring && smp_load_acquire(&ring->ready);
 }
 
 #else /* CONFIG_FUSE_IO_URING */
-- 
2.52.0

