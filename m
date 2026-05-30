Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752CF369D79;
	Sat, 30 May 2026 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780133931; cv=none; b=ZXb99pz97Elw9Vn1RlW+Sbu7Y0SThZCa8lbDFs6glBqN+xfhbeASAFVTekeU+UotggOlthX+F08F4SLG3w+ZoKAz4NcltKSsW8haMEPHNHxO/+HrBhI+5g9AovaDYE8dtSdxPbb5VgHtDoT9HexbO/pN/ozh6AxlH4AXNeqdmEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780133931; c=relaxed/simple;
	bh=QsQdsNIoFR1555oDa3GUNCVMgvmy34178PlWtLaq9pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdLNrSQQXirpaa9PRRTixQenlklBdc+hx6mPEOJYqA1I6YRr9cLWkYV4WQJi8cussXAeZ4q/Tb0uXMPNxCJFyGS0fOqTUBtad3XoI+w3s9PCK1LYKpwUhmqzTdiqZic1DcCbk1w2teoigH8OZbu1AiuVUSpa7/WzqhvSxjkZwgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1XIsxWrF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N7R4UQLI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1XIsxWrF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N7R4UQLI"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780133922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjRzonH4lrOcAeFBkSlTRxm4za4mUMOgtiS6VkGSjis=;
	b=1XIsxWrF+WtLg5mVwCnQKlhJdfcBHDdASMLxTsgtzJNQ99YdfMwUvPz8DFT77ibNKN7xEH
	XAHEbwiGTCF68/zfM4PDy/jhgsa/L+AO7P9huc6CP9s3h8W/lLks8sMRb9VuFZSBsK0eVs
	/WC0vtYZahkeRT/J6kr1gF+rjQ0pbZ5zjwFJMHNdzx2wBSUMQoOnU2AO0enz9Tly6EXYcz
	bNPKE1ho5/A7WfYBz6xBp3jcFQdXYG1o6F8NeOnr/82vDN8jZDFmbJ23LXp38xOVIOsH6K
	wJxI75w+OrbUXSlKaeCvtV0z7oo1pTCUxOnvfFexu9C+d/DmYVDnWheHVklmGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780133922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjRzonH4lrOcAeFBkSlTRxm4za4mUMOgtiS6VkGSjis=;
	b=N7R4UQLIG4QxtgycWs0IzvJPLvviqAvU0BSchKRh7KgSYuAnRVG/4ZaSiqBfYSgA7BlDAf
	+GBkas3UNoYp1bBQ==
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] eventpoll: Fix epoll_wait() report false negative
Date: Sat, 30 May 2026 11:37:32 +0200
Message-ID: <f773406fd0a6979e94921900d4428e8da1a71523.1780133499.git.namcao@linutronix.de>
In-Reply-To: <cover.1780133499.git.namcao@linutronix.de>
References: <cover.1780133499.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ep_events_available() checks for available events by looking at ep->rdllist
and ep->ovflist. However, this is done without a lock and can report false
negative if rdllist and ovflist are changed in ep_start_scan() or
ep_done_scan() by another task. For example:
___________________________________________________________________________=
_________
                                           |ep_start_scan()
                                           |  list_splice_init(&ep->rdllist=
, txlist)
ep_events_available()                      |
  !list_empty_careful(&ep->rdllist) ||     |
  READ_ONCE(ep->ovflist) !=3D EP_UNACTIVE_PTR|
	                                   |  WRITE_ONCE(ep->ovflist, NULL)
___________________________________________|_______________________________=
_________

Another example:
___________________________________________________________________________=
_________
ep_events_available()                      |
                                           |ep_start_scan()
                                           |  list_splice_init(&ep->rdllist=
, txlist);
	                                   |  WRITE_ONCE(ep->ovflist, NULL);
  !list_empty_careful(&ep->rdllist) ||     |
                                           |ep_done_scan()
                                           |  WRITE_ONCE(ep->ovflist, EP_UN=
ACTIVE_PTR);
                                           |  list_splice(txlist, &ep->rdll=
ist);
  READ_ONCE(ep->ovflist) !=3D EP_UNACTIVE_PTR|
___________________________________________|_______________________________=
_________

In the above examples, ep_events_available() sees no event from both
rdllist and ovflist despite event being available.

Introduce a sequence lock to resolve this issue.

Measuring the time consumption of 10 million loop iterations doing
epoll_wait(), the following performance drop is observed:

   timeout  #event  before    after    diff
     0ms      0     3727ms   3974ms   +6.6%
     0ms      1     8099ms   9134ms    +13%
     1ms      1    13525ms  13586ms  +0.45%

Considering the use case of epoll_wait() (wait for events, do something
with the events, repeat), it should only contribute to a small portion of
user's CPU consumption. Therefore this performance drop is not alarming.

Fixes: c5a282e9635e ("fs/epoll: reduce the scope of wq lock in epoll_wait()=
")
Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
 fs/eventpoll.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a3090b446af1..58248862e5ee 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -38,6 +38,7 @@
 #include <linux/compat.h>
 #include <linux/rculist.h>
 #include <linux/capability.h>
+#include <linux/seqlock.h>
 #include <net/busy_poll.h>
=20
 /*
@@ -190,6 +191,9 @@ struct eventpoll {
 	/* Lock which protects rdllist and ovflist */
 	spinlock_t lock;
=20
+	/* Protect switching between rdllist and ovflist */
+	seqcount_spinlock_t seq;
+
 	/* RB tree root used to store monitored fd structs */
 	struct rb_root_cached rbr;
=20
@@ -382,8 +386,11 @@ static inline struct epitem *ep_item_from_wait(wait_qu=
eue_entry_t *p)
  */
 static inline int ep_events_available(struct eventpoll *ep)
 {
+	unsigned int seq =3D read_seqcount_begin(&ep->seq);
+
 	return !list_empty_careful(&ep->rdllist) ||
-		READ_ONCE(ep->ovflist) !=3D EP_UNACTIVE_PTR;
+		READ_ONCE(ep->ovflist) !=3D EP_UNACTIVE_PTR ||
+		read_seqcount_retry(&ep->seq, seq);
 }
=20
 #ifdef CONFIG_NET_RX_BUSY_POLL
@@ -735,8 +742,12 @@ static void ep_start_scan(struct eventpoll *ep, struct=
 list_head *txlist)
 	 */
 	lockdep_assert_irqs_enabled();
 	spin_lock_irq(&ep->lock);
+	write_seqcount_begin(&ep->seq);
+
 	list_splice_init(&ep->rdllist, txlist);
 	WRITE_ONCE(ep->ovflist, NULL);
+
+	write_seqcount_end(&ep->seq);
 	spin_unlock_irq(&ep->lock);
 }
=20
@@ -768,6 +779,9 @@ static void ep_done_scan(struct eventpoll *ep,
 			ep_pm_stay_awake(epi);
 		}
 	}
+
+	write_seqcount_begin(&ep->seq);
+
 	/*
 	 * We need to set back ep->ovflist to EP_UNACTIVE_PTR, so that after
 	 * releasing the lock, events will be queued in the normal way inside
@@ -779,6 +793,9 @@ static void ep_done_scan(struct eventpoll *ep,
 	 * Quickly re-inject items left on "txlist".
 	 */
 	list_splice(txlist, &ep->rdllist);
+
+	write_seqcount_end(&ep->seq);
+
 	__pm_relax(ep->ws);
=20
 	if (!list_empty(&ep->rdllist)) {
@@ -1155,6 +1172,7 @@ static int ep_alloc(struct eventpoll **pep)
=20
 	mutex_init(&ep->mtx);
 	spin_lock_init(&ep->lock);
+	seqcount_spinlock_init(&ep->seq, &ep->lock);
 	init_waitqueue_head(&ep->wq);
 	init_waitqueue_head(&ep->poll_wait);
 	INIT_LIST_HEAD(&ep->rdllist);
--=20
2.47.3

