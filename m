Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C064A2E2C;
	Tue,  8 Sep 2026 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857498; cv=none; b=Vj+aPYhB9pPTh+pkSl/d5803eoi6OKg8UgEKwbSYxmbcHjqRkCweLZZfwl2H/7lHyf2A2hV/9ADib7pJ1t9QRQs4QtHpb8PN/tSfw+m4JZ7bB1cqpHSWCAbNnIJwDq3/COn6S20WnDzVxLy0FjzceyUxjYT4YoaxbGqAVDHOhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857498; c=relaxed/simple;
	bh=FGkbPfeqBuJ1abOW7LuPzwzHswI+OuuNg6EXxtR2IQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwwhsFDyKLxxfVffqjmYiOnqL0HvqPv31W6oreHfEgTvwH9khOTCDwSmYNlCwbeuUBgCAMno4yHJQc8XYXwBH4nYZyNXXSq+mRQGItChmrNx+8QjcAngecIXxsRWd9VS+J8+GyeCr29YBM7MNAdBlCJvXTHP2tHxWVFnK0xbmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idUAMvd8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idUAMvd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FE11F00A3D;
	Tue,  8 Sep 2026 08:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857486;
	bh=KfPaIPahewnBwqtvLvlCu9Typu06K/8SYfI2YkZMUtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=idUAMvd8E9QG+zfmh8NQEAf8ZfuKZId0rjRwh5Xg2A/UDhAK35lYbpzPYymE7fBg5
	 C4YbFvFGvdnq/lgkfqVYHZMJr5JCAqZrg4farYykP/TMnc+eQtokcGJjoWOVmbcsLf
	 JDX2xkQPBgT0FSaY6HEg2dnRqjI8Iho2Hx7AB8zoeARztbqBukJYc5Tmfq5ccif8HT
	 DqijL+ake23F5nhW5MiRAJOc9tw5PTgZiC/rwwR9JllL1tt2ADsFsrn+DfDctf6ygS
	 xiuxXWdP7iHDQpZ/rvGEbtljCc4RCTza97Yx6Ah4ogTVYn1yii92IiyX3pnHzOpf3G
	 CbG20l37sqtRg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [STABLE v5.15.y 2/8] eventpoll: use hlist_is_singular_node() in __ep_remove()
Date: Tue,  8 Sep 2026 09:50:58 +0100
Message-ID: <20260908085113.3960814-2-lee@kernel.org>
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
index 8762d0908637..5945390e352c 100644
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
2.55.0.979.g7e5102b832-goog

