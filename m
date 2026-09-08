Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3AF4ADD8E;
	Tue,  8 Sep 2026 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857516; cv=none; b=pTXuR4TabV+c2OusZ4WaWNJY4Sn7T6Lor2tOwGa5ZMIcx+B+TVAF4XnRb8yQAJbBeQ8sBmqYHk8qKmb/hmEfX8xyrIm7DNSv+V11yWRTSF7XRiEn3cDuC9L4jzZrCt5p4FZr8BDke7OGor6eyR6Mg4fZdeHaMj4Lg1Pc5tWmfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857516; c=relaxed/simple;
	bh=1wwztWrHCDdTn0zqjWf8RWESBVknQdNrww4+ZAxoILE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTnenE25F0fjMlTGcD3+O/mQkisbthb17JUN9d/g/XdRNHqq/QyR/VSEFhaP+q0Uak+yYeyJ8F3iYcORVgn3n2aH+c3ZX+BXiA/c6dIHuiHmWdHilEV/ebTet590zZyuflL6m2sHITU5NR//GbdVnxj86qVCGen4X9frjFEJ6dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyPIt7cX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyPIt7cX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CE91F00AC4;
	Tue,  8 Sep 2026 08:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857499;
	bh=nYyvkbJOt1DyAcQQIFqOpdju5MjiCckBzhkllXgoRak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eyPIt7cXrLJBgg6c2kkD8Y8QfrhFfsqYJVjfD6a65KWBJ18oSh160wjtLhN9C5R0F
	 NgYmToqyi89WoNsI0druUJwIdYDcdh/ZcmXUr2SZ+0I7bbYpnFvijs4jdDhUIkf81x
	 cwuiWAk/PXsAhf7GED81yuSL0ZVd5khrLbIPKPUHzA2lfH78D7dRAvcQgnhWSa21t/
	 H02ad9H8qB3E2gbJoI2CZzBxAUo8w2V9VgB/6kB2s5K+SHqJH8tDH07Ig8NFCy8e4C
	 NHERqct0ksse6xds7fo6bGFQUj/NOp4SYmwA9CoNjT2mvoDA8+WFfzcELKbbwhbZYL
	 0GiWgAFbWmKew==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [STABLE v5.15.y 5/8] eventpoll: drop vestigial __ prefix from ep_remove_{file,epi}()
Date: Tue,  8 Sep 2026 09:51:01 +0100
Message-ID: <20260908085113.3960814-5-lee@kernel.org>
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
index 3d0cad2592a1..cf00714afb4a 100644
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
 
@@ -1009,8 +1009,8 @@ void eventpoll_release_file(struct file *file)
 		ep_unregister_pollwait(ep, epi);
 
 		spin_lock(&file->f_lock);
-		__ep_remove_file(ep, epi, file);
-		dispose = __ep_remove_epi(ep, epi);
+		ep_remove_file(ep, epi, file);
+		dispose = ep_remove_epi(ep, epi);
 
 		mutex_unlock(&ep->mtx);
 
-- 
2.55.0.979.g7e5102b832-goog

