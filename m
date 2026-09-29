Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CF33B774F;
	Tue, 29 Sep 2026 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672944; cv=none; b=TRRimzuk3zx1sEwSs5a+5Gu7aKHUkdoPUsDZpppFXfzrxsNJeYSXdYHk6zYWpSY0JbopAbK2/v6AyDQ3iB14yz7XG4aaLvPEq+UM8GmWyZ9l9cfLoRY6VM91t9NFoDtYUHxrMuSK5eKZMTJHSCRTZzbtMW2cm8mIjiHSMN1Rwg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672944; c=relaxed/simple;
	bh=OwOTPh3hANp++nk2LZ1Vx+l0Uq61xAzY3starhYQTCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rm+tVTiE/kmfhTxHEEKvm0Sb4I3tXL1TBHzJLMOFvCkctTzRATXnSe0q1363NCeynfmzR58MCwOJAKjP5+2+pngtQ/0XrBrUVHZoXfHo41EmLLw1J9pUxovIh7Jg/ekhXzDD9bwUuVAZ14sN16HC+t8nNWBp9Oz4azC07xacnbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YawGZiWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YawGZiWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C681F000FF;
	Tue, 29 Sep 2026 09:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790672927;
	bh=g0i6ICubraxdZpeoCJJ9/JBLrtCyzoMtB5IfednapMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YawGZiWeykVRUT+F4zaOwrJImWs9JeWfwiTf/gPhtl42mk/2lytn/Bncdn4/nC6Vr
	 ks/ZfRu20CGgNlVyaEL0Xxb0z+IAO3cKkyHB5jzpMmuav60skRvlUIhq1oFxt1oSU3
	 KKQ0i6Hdm9xshg5FEJOZaPj3lQvGgpHs6iguuVMd8Bnde0INNFibt2/kYkNRTWrxOY
	 Ekj9bTxnfMwIXQD3a/qWSmuDjgVX2I6uvpuZ2mNTGKlbqv8rfMDIdEibCjCC1GfieI
	 pWxRbLfsRT+v1n23zcz0S1UfK0YSOK8bV/Ay6mQ8SXELNv3/Xl86UidFxqaOvEp1SE
	 D4PSKPzuh9lIA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [STABLE v5.15.y v2 7/9] eventpoll: rename ep_remove_safe() back to ep_remove()
Date: Tue, 29 Sep 2026 09:07:14 +0000
Message-ID: <20260929090724.1461557-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260929090724.1461557-1-lee@kernel.org>
References: <20260929090724.1461557-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0bade234723e40e4937be912e105785d6a51464e ]

The current name is just confusing and doesn't clarify anything.

Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-4-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 136e5900ea830dee549e3485c8931ec1c8f6c1b1)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 fs/eventpoll.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e666eccbde82..3c5151e08f63 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -764,7 +764,7 @@ static bool ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
 /*
  * ep_remove variant for callers owing an additional reference to the ep
  */
-static void ep_remove_safe(struct eventpoll *ep, struct epitem *epi)
+static void ep_remove(struct eventpoll *ep, struct epitem *epi)
 {
 	struct file *file = epi->ffd.file;
 
@@ -811,7 +811,7 @@ static void ep_clear_and_put(struct eventpoll *ep)
 
 	/*
 	 * Walks through the whole tree and try to free each "struct epitem".
-	 * Note that ep_remove_safe() will not remove the epitem in case of a
+	 * Note that ep_remove() will not remove the epitem in case of a
 	 * racing eventpoll_release_file(); the latter will do the removal.
 	 * At this point we are sure no poll callbacks will be lingering around.
 	 * Since we still own a reference to the eventpoll struct, the loop can't
@@ -820,7 +820,7 @@ static void ep_clear_and_put(struct eventpoll *ep)
 	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = next) {
 		next = rb_next(rbp);
 		epi = rb_entry(rbp, struct epitem, rbn);
-		ep_remove_safe(ep, epi);
+		ep_remove(ep, epi);
 		cond_resched();
 	}
 
@@ -1585,21 +1585,21 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
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
@@ -1623,7 +1623,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	 * high memory pressure.
 	 */
 	if (unlikely(!epq.epi)) {
-		ep_remove_safe(ep, epi);
+		ep_remove(ep, epi);
 		return -ENOMEM;
 	}
 
@@ -2302,7 +2302,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 			 * The eventpoll itself is still alive: the refcount
 			 * can't go to zero here.
 			 */
-			ep_remove_safe(ep, epi);
+			ep_remove(ep, epi);
 			error = 0;
 		} else {
 			error = -ENOENT;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

