Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAEF313E17
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881507; cv=none; b=C+vzPw0iqM5/znlojobVmXGAa7t8HAztMzptRNUJ8Sg9kKR505RvIDXn9XIQF+GqzLcC519QGyElWsRDWrFv184uCer9bRMMDWDiENja31GehAESN/QdjdQ2+dOz3ds6nO+xGvNDH1E2praPte1+PjM+NMASP01wc5iYtaDF7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881507; c=relaxed/simple;
	bh=Nd7aoGI2jIJg0XJ97WeErtzBQ/wpsd2N/ztLqDcliLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NNGeROTsJhF5KWNEUCsqCEAkRiOFivwDzJI86+1cZYtHUXe67TDM6NI7VGgcyxIXh3/q82HVDv5D4Az457n1PT3REdRZcU/oV1HViPj10GobeCFSjD+RK8MU4aYyJMYoJm5VddW6+nNsrxe4keopYjvJ842GgJkIKAnSjNpIqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=PJUnuDx+; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b="PJUnuDx+"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ghgjG5rhhzLYP;
	Fri, 19 Jun 2026 16:59:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1781881154;
	bh=U/IXRrLPUtA+9Gxy6cPTSupEJOAX/u+UMvxce3+F2c4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PJUnuDx+RYL2iPVwuvOdC5BfcBOVaC+EKyxSRGHOLNZvhByaHpv3iH3mkWesfKEok
	 0Ta3FIvQdXIc1z9/R+tdi2LZ8PR9OFQDpJ4QddyKVxk2cp65kC8/eK0WoGv5kVpJns
	 hzec+QNAM7W0bKh9yJ1PbDiaVDD3BKCkRwvWntB9c025tKu7y842RyKBekc+rTgvBZ
	 oeo4nDF3rAG6KH4U0PvGalRYYTMR2pdEAoC1u6VE3YWGAsHyoyCxMtxZUkW6gz4eJP
	 IaqtTdiAT2w1V7ZA3PJfHK5jl7VToLxxFnCNlIGpzlfjY0hsQ/6dn/n5E1oBWKVQeU
	 m3bsksnhzighw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ghgjF5C36zrfH;
	Fri, 19 Jun 2026 16:59:13 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 19 Jun 2026 16:58:42 +0200
Subject: [PATCH 6.12.y 2/7] eventpoll: split __ep_remove()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-6-12-cve-2026-46242-v1-2-e15a6de43c11@cherry.de>
References: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
In-Reply-To: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Soheil Hassas Yeganeh <soheil@google.com>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0f7bdfd413000985de09fc39eb9efa1e091a3ce0 ]

Split __ep_remove() to delineate file removal from epoll item removal.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-2-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 fs/eventpoll.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8f9dc2f4891ff..1cba4ae4a076b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -797,6 +797,9 @@ static void ep_free(struct eventpoll *ep)
 	kfree_rcu(ep, rcu);
 }
 
+static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file);
+static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi);
+
 /*
  * Removes a "struct epitem" from the eventpoll RB tree and deallocates
  * all the associated resources. Must be called with "mtx" held.
@@ -808,8 +811,6 @@ static void ep_free(struct eventpoll *ep)
 static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 {
 	struct file *file = epi->ffd.file;
-	struct epitems_head *to_free;
-	struct hlist_head *head;
 
 	lockdep_assert_irqs_enabled();
 
@@ -825,8 +826,21 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
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
@@ -840,6 +854,11 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
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
2.54.0

