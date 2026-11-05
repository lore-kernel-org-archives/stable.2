Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840053;
	b=NAhnH1KdNSVoslJwgHGt8zy5ep77XnPuXCNeRTWiB4HecaE66NlouEpA1xSmY7Vjj7qE
	 GqzxJaRzs/miWB+KehyoOEgO0zOpc5ASki2rRaoT+NS1F0YQbZomFHpQlUtEF2/ZjmUhZ
	 Q78LsW4ihKxuCwiT/BCWMRN+wrWZ9ofBk+/dqi6cxXKZLwxy9zy+OCOHlkHjJ2LS6SSkp
	 eOmYcfsMLvfl1goeDUFdf37mnUpYEQReJxuhNUOU9jG5lglQe2P4beH01NqGMXjFx2kXp
	 XBNNljI/6Q5pt4ej2iNVwoBAjN0KJrJ13s5TTvkBdRsiQ/p6DdmyNghIB3JFu1mTDJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=y5sVsQZg6x6fuQ3KiH1M90quO8KQEoUWt5Z7/cr2Pg0=;
	b=ldy8G46QQj0Fh0yf/FQfn5unt9CWHvxMpT75U7lWh77EP311mwCX+PXEycUmyY8zA7XV
	 ZPRI0JcdyOjMhQoXy/g91hkj+ca5ei7LUQ/6M3nPpm7qCsDxHVpeNmMwDDqYriYnzfoCY
	 7phTgEegcFdH8ZCYpfJIlrknb8Yx0+uru/2vM8gLrvwHT0set0I290Sf9lrxQ8Iu0fK0c
	 KL2ew9cC03OtLoaB2LEP0jWhG8ZE2m5OHkXzrk5nQczz/3etzzRfqL9fxwbml7c/Or4l8
	 5J6JzVkWBEtiFyV26OMNUhiJVWA7wFsRdJmtPGKAv4BnSbhzktF4BSNoAHRxJKrTsNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hzk7hJvq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D2660A3810
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hzk7hJvq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD961F00919;
	Thu,  5 Nov 2026 00:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793840052;
	bh=y5sVsQZg6x6fuQ3KiH1M90quO8KQEoUWt5Z7/cr2Pg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hzk7hJvqwWvgQ/ZuWZXoyr4p8p2qciA4tWsIIGKwtOiAJHQVo4zy0jqLTjn6RIM1Q
	 v0ea7SIo5AtN/4JGhrg0ozUGDPsbfwF/3bgmwBi3O5/e91SXio369NYJ/Iet8ChCf3
	 tivX9zzNUDFqRUEqKFejfZikWJoczLfyS9QTrcrrCrnT+bJg5jBoz/XxyCt4jCslTm
	 sUKqz2Ht7Q+vtqidXvVpu0rfY4OWMzBIM+E4KZ9MGfTxqy13mScxtYGvo7lQSXfXj7
	 uEFYszfrsHBD7YGqEU8iRomuwxEh76hZWEW0XasdJ5C22q1xYxgKity10Icftw5lsY
	 hHi7KRwEXtfYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuchao Zhang <ndaugoing@gmail.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xen-blkfront: unbind irq before tearing down ring and shadow requests
Date: Wed,  4 Nov 2026 19:54:10 -0500
Message-ID: <20261105005356.984834-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110403-viper-verify-b61d@gregkh>
References: <2026110403-viper-verify-b61d@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yuchao Zhang <ndaugoing@gmail.com>

[ Upstream commit f3e27b7955727a4d7c0e9264a2a209fbba788bdc ]

In blkif_free_ring(), the driver tears down the ring's persistent grants,
shadow request arrays, and shared ring structure (xenbus_teardown_ring),
and only calls unbind_from_irqhandler() at the very end.

While blkif_free_ring() is freeing persistent grants and clearing the
shadow array, the event channel interrupt (blkif_interrupt) is still
registered and active.  If an interrupt arrives from the backend during
this teardown window, blkif_interrupt() reads rinfo->ring.sring and,
via blkif_completion(), accesses rinfo->shadow[id].grants_used and
rinfo->shadow[id].sg.  blkif_free_ring() tears these structures down
without holding rinfo->ring_lock, and the handler only checks
info->connected at entry, so this is a real race resulting in a
use-after-free or NULL pointer dereference.

Fix this by moving unbind_from_irqhandler() to the beginning of
blkif_free_ring().  Calling unbind_from_irqhandler() first frees the
IRQ and synchronizes with any in-flight interrupt handlers on other CPUs
before ring memory and shadow request structures are deallocated,
matching the teardown order in drivers/net/xen-netfront.c.

Fixes: 11659569f720 ("xen/blkfront: split per device io_lock")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
Acked-by: Roger Pau Monné <roger@xenproject.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20260922072155.34625-1-ndaugoing@gmail.com>
[ sashal: adjusted context for ring cleanup using free_pages_exact() instead of xenbus_teardown_ring() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/xen-blkfront.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 19ddbf977d28f..44c82088a611c 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1276,6 +1276,14 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	struct blkfront_info *info = rinfo->dev_info;
 	int i, j, segs;
 
+	/*
+	 * Interrupt teardown must be done ahead of freeing queue-related
+	 * data, otherwise the interrupt handler can race with the cleanup.
+	 */
+	if (rinfo->irq)
+		unbind_from_irqhandler(rinfo->irq, rinfo);
+	rinfo->evtchn = rinfo->irq = 0;
+
 	/*
 	 * Remove indirect pages, this only happens when using indirect
 	 * descriptors but not persistent grants
@@ -1365,10 +1373,6 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	free_pages_exact(rinfo->ring.sring,
 			 info->nr_ring_pages * XEN_PAGE_SIZE);
 	rinfo->ring.sring = NULL;
-
-	if (rinfo->irq)
-		unbind_from_irqhandler(rinfo->irq, rinfo);
-	rinfo->evtchn = rinfo->irq = 0;
 }
 
 static void blkif_free(struct blkfront_info *info, int suspend)
-- 
2.53.0

