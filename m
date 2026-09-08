Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8E44A9D67;
	Tue,  8 Sep 2026 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857507; cv=none; b=fmmIjr2nL8R3K8vu+W3ku4VkN7GXEqzhWtv4niylXSsUnJDbZvnYO0UBLySMhlbL/YJqO4QxPIQYlur2OoyDiOSU3g3l9edgCnIPaFgdm3XBt+FLg5ZsXEAwrPaJkuqev0K4fv9vDgMIYht8Lr9M37Z1FraoaVopQMdt3dK+q0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857507; c=relaxed/simple;
	bh=rdXzSh9t83Qe9DDq79xaCdCPN4KPAd67RFZHUjKBP1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUeuC8rl9RECHyluGkAKdkkyTj1U7h6B45OkXGYd5tFtxVESjmA2lfX79vyi5EQ0nHBPoIUjL6b4veJURsnK58NpGz07RfUtV7Wg67EntAxmWryVRJ3rzCRlOnFtlcsgkLR9MAKCZkfYAjhHSqn9NPgfAzOBIWJpZU6eBkG+spk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpRhqCFk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpRhqCFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465BE1F00A3E;
	Tue,  8 Sep 2026 08:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857490;
	bh=wmWITTLdAzpcAO5i3ct42eKphu6BG4utlnDawxp8sC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BpRhqCFkxSKaXskPzDUoO4n1x3j7yzNbWWWZt19VVr33Uv/EQudPIhaQ25gsmql2K
	 LhHBXSTd84ges5UWCS//y6yZ25Ko1KQw/2c23u23NuDBeywJI8BxQH+0XAIDLsGa2l
	 6O1T1uTyoFSz52r0QvcudKoTYGxst2U76BetCfA9OjwDKH1bkzPTtC8B7VXqYXqhCH
	 Ckt6NulYN4gEpurBPTbiVNFpakD5hvYOmD3KsoJbBvY1S6E0mnviLMIpeYI1FqUhbk
	 rSjMmeAiY06HYBb0SfNSTeo/8+B4AgWz04yLU8Vi/cBABhSMORx87elJsVAPVYBGVZ
	 AfrYXita+nfIg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [STABLE v5.15.y 3/8] eventpoll: split __ep_remove()
Date: Tue,  8 Sep 2026 09:50:59 +0100
Message-ID: <20260908085113.3960814-3-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260908085113.3960814-1-lee@kernel.org>
References: <20260908085113.3960814-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0f7bdfd413000985de09fc39eb9efa1e091a3ce0 ]

Split __ep_remove() to delineate file removal from epoll item removal.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-2-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 66bc7c8a33df3618e43ce0d0d4a985595ce57861)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 fs/eventpoll.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 5945390e352c..693ad9826e32 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -708,6 +708,9 @@ static void ep_free(struct eventpoll *ep)
 	kfree_rcu(ep, rcu);
 }
 
+static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file);
+static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi);
+
 /*
  * Removes a "struct epitem" from the eventpoll RB tree and deallocates
  * all the associated resources. Must be called with "mtx" held.
@@ -719,8 +722,6 @@ static void ep_free(struct eventpoll *ep)
 static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 {
 	struct file *file = epi->ffd.file;
-	struct epitems_head *to_free;
-	struct hlist_head *head;
 
 	lockdep_assert_irqs_enabled();
 
@@ -736,8 +737,21 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 		return false;
 	}
 
-	to_free = NULL;
-	head = file->f_ep;
+	__ep_remove_file(ep, epi, file);
+	return __ep_remove_epi(ep, epi);
+}
+
+/*
+ * Called with &file->f_lock held,
+ * returns with it released
+ */
+static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file)
+{
+	struct epitems_head *to_free = NULL;
+	struct hlist_head *head = file->f_ep;
+
+	lockdep_assert_held(&ep->mtx);
+
 	if (hlist_is_singular_node(&epi->fllink, head)) {
 		/* See eventpoll_release() for details. */
 		WRITE_ONCE(file->f_ep, NULL);
@@ -751,6 +765,11 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 	hlist_del_rcu(&epi->fllink);
 	spin_unlock(&file->f_lock);
 	free_ephead(to_free);
+}
+
+static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
+{
+	lockdep_assert_held(&ep->mtx);
 
 	rb_erase_cached(&epi->rbn, &ep->rbr);
 
-- 
2.55.0.979.g7e5102b832-goog

