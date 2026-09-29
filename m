Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBB13CC7CC;
	Tue, 29 Sep 2026 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672925; cv=none; b=MJVGI/O/17juH020hSAmK3URhT2NMRGtzfyoZMv6ZGzwLyCf34r5Lmk/Uvzczupa8SkX4IBH0RNBRE6Zymeb7eRwVaM7FxT8xxSexH1NJsakzlJ8N05y7jB8i3lhVak6DVci+31MlGStLZ0jaQ60YRjPNPJ6nqJjbI73JO8hYDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672925; c=relaxed/simple;
	bh=eEtRv/2uHSLvUQwgzDzPqeBjWWuua1qb3PTEn5xCOEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQhnfPNcojMewq0mbSVXy1pAyz6HCSp+X/ibNgSJ23zju3sYUjebjjfN+m8Y2p0TcEP0RENDd9F8q96log0pF7bA5K8sfdJsm6re9M8um1To2xpoHisw2tI4XrCsfVtWd2NGo9r5afBUgkx4NNUNZQ22RA35FqHNFne0hGatzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJf2FHMB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJf2FHMB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12A41F00898;
	Tue, 29 Sep 2026 09:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790672911;
	bh=DskPakrblykgd1IR4QWGnMrjJqt+wQp+Dsf8QUYxap8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HJf2FHMBbg35sc3bxHaD5ZYbpT0VElBggLPsiql0lbyS3XQTnmiNqwpijnkSABSwb
	 XXGSaiECMI9QmpWi8smCfIlZpwFANaKUx2H28XffJ1GeZoe9/EE6rk0YuNBGX+HPUB
	 Yo3IKttqYhZDgaoaX9HJxJRpVis7nqciqBXharjs8X6jDcBIhQsv6kUqXYMg+gLWNv
	 hEvpKPyA56hXyDb6p7nkwWZJWDodYn6acZnfR1BKLFTm+P4vb/xaVdwwUUz4HAEgVV
	 eQ4shxisXIue5FuNPMCKOyV0/bRnVOrJjGqDZuHNOUKdigKc0McaVlA4HZ2R2KF1g7
	 fhIWiRntanCGQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [STABLE v5.15.y v2 3/9] eventpoll: use hlist_is_singular_node() in __ep_remove()
Date: Tue, 29 Sep 2026 09:07:10 +0000
Message-ID: <20260929090724.1461557-3-lee@kernel.org>
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

[ Upstream commit 3d9fd0abc94d8cd430cc7cd7d37ce5e5aae2cd2b ]

Replace the open-coded "epi is the only entry in file->f_ep" check
with hlist_is_singular_node(). Same semantics, and the helper avoids
the head-cacheline access in the common false case.

Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-1-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 605963b245b2c436803cbbefddf5ee5cb326ceaa)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 fs/eventpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 9e63923196fc..4a39ed132c3d 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -738,7 +738,7 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 
 	to_free = NULL;
 	head = file->f_ep;
-	if (head->first == &epi->fllink && !epi->fllink.next) {
+	if (hlist_is_singular_node(&epi->fllink, head)) {
 		/* See eventpoll_release() for details. */
 		WRITE_ONCE(file->f_ep, NULL);
 		if (!is_file_epoll(file)) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

