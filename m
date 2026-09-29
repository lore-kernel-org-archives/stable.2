Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A044C10ED;
	Tue, 29 Sep 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672942; cv=none; b=kBinTUMotw9G5DVgNRdQNMNgfWIf6X6BV+oMi2Gcxk2NHgoY02MXl1iGDthynE6PHLxQH478ZL93vRKqhDLcNUQVRFA1QdCfsDXf6E9UY4zxnX1RA4RvIgWukkQYh86alf4f54bbJ2w2RaRf4T3V26I4Hm6UdNq/mZLEJNM8vDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672942; c=relaxed/simple;
	bh=B7WUxTPxYRhqv/9PX7I5Kblo6ZmbQ3M1s08kGwGRPCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsWiqO9d0hvS410ifR1hyVwa8p62lkzWg0TvpF5vEimUVlZXCZ9noHviXZDzK4SSLq2QPgm/3Hp+BtO3Zt7B/LX+7S3LjIStgPAziibKw8bQce9H4ye3m0jsYsMjXWhK+VrzOu+zowdrARMD6kEydT49bvu5cbwrOEBvcfSWcLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aonc5EYj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aonc5EYj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4622E1F0089A;
	Tue, 29 Sep 2026 09:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790672923;
	bh=q2X4bkxODE5bL9UFrYWe/JpRBf2pcudGkKEKhnJ0Csw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Aonc5EYjRYNeoKw+9s3bBQf0dgv7Px+SPAthVHr8K4zjoy6duJtv976q1l4U7mypd
	 m9YG2pmV7lHQnDdtQqRwTTWwXYcH6os/NlDaNcbmd3XxW5oWgrQzaRwtDXm+T2WeMT
	 oxdwgqxE2zSrQStDBpyiYJHOcbWxozubBXKtd4Gglm+MxnlgMbG3e2HDhl4TtfLqWt
	 f74jTaDdnSKX3yNui6IkaQdPV83Fm86DNG8H8MbrMwDlqP27qnvuZlDkq4NAgWzfkS
	 YYYuD2J8yuJVgXD0sSTSJMwyK8DAvGvewCa8tMddjs3tGDz6IkQNN71VvYp7vjXU/f
	 3tAvXmiolrh0Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [STABLE v5.15.y v2 6/9] eventpoll: drop vestigial __ prefix from ep_remove_{file,epi}()
Date: Tue, 29 Sep 2026 09:07:13 +0000
Message-ID: <20260929090724.1461557-6-lee@kernel.org>
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

[ Upstream commit 0feaf644f7180c4a91b6b405a881afbfd958f1cf ]

With __ep_remove() gone, the double-underscore on __ep_remove_file()
and __ep_remove_epi() no longer contrasts with a __-less parent and
just reads as noise. Rename both to ep_remove_file() and
ep_remove_epi(). No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit e40f6d02a75baa0f145e0394a2d9b31b969da247)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 fs/eventpoll.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 365d833bae20..e666eccbde82 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -712,7 +712,7 @@ static void ep_free(struct eventpoll *ep)
  * Called with &file->f_lock held,
  * returns with it released
  */
-static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi,
+static void ep_remove_file(struct eventpoll *ep, struct epitem *epi,
 			     struct file *file)
 {
 	struct epitems_head *to_free = NULL;
@@ -736,7 +736,7 @@ static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi,
 	free_ephead(to_free);
 }
 
-static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
+static bool ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
 {
 	lockdep_assert_held(&ep->mtx);
 
@@ -782,9 +782,9 @@ static void ep_remove_safe(struct eventpoll *ep, struct epitem *epi)
 		spin_unlock(&file->f_lock);
 		return;
 	}
-	__ep_remove_file(ep, epi, file);
+	ep_remove_file(ep, epi, file);
 
-	if (__ep_remove_epi(ep, epi))
+	if (ep_remove_epi(ep, epi))
 		WARN_ON_ONCE(ep_refcount_dec_and_test(ep));
 }
 
@@ -1006,8 +1006,8 @@ void eventpoll_release_file(struct file *file)
 		ep_unregister_pollwait(ep, epi);
 
 		spin_lock(&file->f_lock);
-		__ep_remove_file(ep, epi, file);
-		dispose = __ep_remove_epi(ep, epi);
+		ep_remove_file(ep, epi, file);
+		dispose = ep_remove_epi(ep, epi);
 
 		mutex_unlock(&ep->mtx);
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

