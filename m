Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E18B3B42E5
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881165; cv=none; b=MCFodZtsfkXN6NuJkslL7/55My5tiSzlBM9eTlCxpeiEJPA3AjVy2ypvzvSkmUOcGKsh2zdY+HDxuDvSJy83kdXmxX5U1BLxFt6+UIllAYGxWr/Vg32P0u0wtHNCL3m4riF/qzZpliO121l/7jYpjob98wcAsloDwe35xND2kJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881165; c=relaxed/simple;
	bh=UwUuz3/kOwgmuxXI3SZArsjbJN9AET9lJdqq5RC/Tb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hDNrwBu9HZNShSJLDuozvivr6/IgWaEsrj1Yu2RDirHWuRaoLrs4xqo7752hb79yz3VJZL+yQSVsy7r2i0pahFL904hbXnJ+BpfaQB/KPBZCZupypfuXqZ8RA5ukynrBFMRx5TR0hmkXfz87cad/XTZsT7BimFzd7Y+qo7wqEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=dEEl9XlU; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b="dEEl9XlU"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ghgjK0fTVz9NK;
	Fri, 19 Jun 2026 16:59:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1781881156;
	bh=ePGboFYMGxkgrskz0Rz6VnLUJOXdPZaKGsV/y52k+4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dEEl9XlUvvPVAEV7qel8H9XhTMHvm4WAJYpBgcVhJNk53YdIpC2pBi0ILmfZokirR
	 WUYdLuJ9LBT7btTvjOb1kxUai/b6peOQj2oZX1OFIelhd2KGgOmFYFLPedR+PWO8Oz
	 fbKP3PD4hrU3yAbNrUVhAHKylHEyS/51Yo+9czi30wd1+kt4XR3oP2GE8vUrVT+/5p
	 SzL1ZbDoEqjKltz4LwM6L8U33hyBL19DoprxJUG8JO9UKgIDeiMFPTrUr9YeVZwAp6
	 223tJuF6s4kCsMHmBPyg4oD/U3dH5pZUtPTq/s5ToqahcbwdIAKCkDzPenXqQDHhj3
	 /eL2bhgo9A2Vw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ghgjJ0MHVzvcW;
	Fri, 19 Jun 2026 16:59:16 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 19 Jun 2026 16:58:45 +0200
Subject: [PATCH 6.12.y 5/7] eventpoll: rename ep_remove_safe() back to
 ep_remove()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-6-12-cve-2026-46242-v1-5-e15a6de43c11@cherry.de>
References: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
In-Reply-To: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Soheil Hassas Yeganeh <soheil@google.com>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0bade234723e40e4937be912e105785d6a51464e ]

The current name is just confusing and doesn't clarify anything.

Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-4-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 fs/eventpoll.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index dc747f382dd95..27280ba4f3d5b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -853,7 +853,7 @@ static bool ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
 /*
  * ep_remove variant for callers owing an additional reference to the ep
  */
-static void ep_remove_safe(struct eventpoll *ep, struct epitem *epi)
+static void ep_remove(struct eventpoll *ep, struct epitem *epi)
 {
 	struct file *file = epi->ffd.file;
 
@@ -900,7 +900,7 @@ static void ep_clear_and_put(struct eventpoll *ep)
 
 	/*
 	 * Walks through the whole tree and try to free each "struct epitem".
-	 * Note that ep_remove_safe() will not remove the epitem in case of a
+	 * Note that ep_remove() will not remove the epitem in case of a
 	 * racing eventpoll_release_file(); the latter will do the removal.
 	 * At this point we are sure no poll callbacks will be lingering around.
 	 * Since we still own a reference to the eventpoll struct, the loop can't
@@ -909,7 +909,7 @@ static void ep_clear_and_put(struct eventpoll *ep)
 	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = next) {
 		next = rb_next(rbp);
 		epi = rb_entry(rbp, struct epitem, rbn);
-		ep_remove_safe(ep, epi);
+		ep_remove(ep, epi);
 		cond_resched();
 	}
 
@@ -1602,21 +1602,21 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 		mutex_unlock(&tep->mtx);
 
 	/*
-	 * ep_remove_safe() calls in the later error paths can't lead to
+	 * ep_remove() calls in the later error paths can't lead to
 	 * ep_free() as the ep file itself still holds an ep reference.
 	 */
 	ep_get(ep);
 
 	/* now check if we've created too many backpaths */
 	if (unlikely(full_check && reverse_path_check())) {
-		ep_remove_safe(ep, epi);
+		ep_remove(ep, epi);
 		return -EINVAL;
 	}
 
 	if (epi->event.events & EPOLLWAKEUP) {
 		error = ep_create_wakeup_source(epi);
 		if (error) {
-			ep_remove_safe(ep, epi);
+			ep_remove(ep, epi);
 			return error;
 		}
 	}
@@ -1640,7 +1640,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	 * high memory pressure.
 	 */
 	if (unlikely(!epq.epi)) {
-		ep_remove_safe(ep, epi);
+		ep_remove(ep, epi);
 		return -ENOMEM;
 	}
 
@@ -2329,7 +2329,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 			 * The eventpoll itself is still alive: the refcount
 			 * can't go to zero here.
 			 */
-			ep_remove_safe(ep, epi);
+			ep_remove(ep, epi);
 			error = 0;
 		} else {
 			error = -ENOENT;

-- 
2.54.0

