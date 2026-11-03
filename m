Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709485;
	b=3pKgnxYFqy59eDpb0NdH/aTLKXutSk3xrQSbhMpxveB2gCXHr7JRY5wWSfRTYo0GaeOO
	 d6bZkQrnjaQQVFtiDiYiHmwQwgeeYOeNqmmn6YuFErQBbmd5TNoQE46erUD6KtGDwCfBR
	 M59SIuUCuvjxe+ptA2+erOnu92IsLZS5jJNA7ZIRKKNqlOgTi8Lmlq/Akx3MzA/Hz732D
	 4x8vP0MRx1i/r1nDhI1zvy5C3IkOr3VKhWB1/R166IHFp9gMG95y1cF6limqxObMYxI/A
	 sKifmHzkGe3nm6bXdTJIyG0WXjZPlU+27655BExhTTHzPIzNk/QrkPOtmoqFGc4XVbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709485;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fLjRQQ9bHr8STpGUMtskncOY7jO2t/jS5jX3vPUz7tU=;
	b=Fj1kBUJCg4XoDndk4jfP3PzZaUUChpP4gvPphTUtrGhVX3Grl7T+v4E3+nqEFvy4u2p2
	 dGIPY3khJJ0J0fw1gUovuaRMnjDQVeGtZo5OM+72iLcGchAyt6G6QAKhxP+S/uowvIbLK
	 fs/6nkDzvcwsbu/y12bIqkQ4/Kb4lVO6bMjKHoalo9MZd6Gg+JkntrG16ayP2UU3YqSDm
	 smA03Y5F4o1M8Ua71npKsl+AcgMCaWXQrG/CcdTLfDwFujhwik1A05A0T4VB2TjQqHRG0
	 Za7y4/YXq9NRNYP7gVs6iEKZXHbN0JXCvGabPS18bwRXFCDzE0P3+q7/YFRX3XTk6HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=UnOyYMJJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81B6082BC7
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=UnOyYMJJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BD81F00919;
	Tue,  3 Nov 2026 12:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793709484;
	bh=fLjRQQ9bHr8STpGUMtskncOY7jO2t/jS5jX3vPUz7tU=;
	h=Subject:To:Cc:From:Date;
	b=UnOyYMJJ5wsaeBuxXL11UVjJErBeDmus2SOywELjpVrGEwuP/qPMcLIXeWy1ZNSJN
	 B7o6dgZFQC4aNi+RPu69KhiLe2yKshrI2igUopm5CoWAl+hxznsNXAv2m+XD6nFT0O
	 mtP8YwWJ7RXdzS9bYZrBurdsHL04pPRJQ/7Y2tNo=
Subject: FAILED: patch "[PATCH] inet: fix potential deadlock in reqsk_queue_unlink()" failed to apply to 5.10-stable tree
To: edumazet@kernel.org,davem@davemloft.net,edumazet@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 13:31:23 +0100
Message-ID: <2026110323-eleven-playlist-9820@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 83fccfc3940c4a2db90fd7e7079f5b465cd8c6af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110323-eleven-playlist-9820@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83fccfc3940c4a2db90fd7e7079f5b465cd8c6af Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 13 Aug 2015 15:44:51 -0700
Subject: [PATCH] inet: fix potential deadlock in reqsk_queue_unlink()

When replacing del_timer() with del_timer_sync(), I introduced
a deadlock condition :

reqsk_queue_unlink() is called from inet_csk_reqsk_queue_drop()

inet_csk_reqsk_queue_drop() can be called from many contexts,
one being the timer handler itself (reqsk_timer_handler()).

In this case, del_timer_sync() loops forever.

Simple fix is to test if timer is pending.

Fixes: 2235f2ac75fd ("inet: fix races with reqsk timers")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 05e3145f7dc3..134957159c27 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -593,7 +593,7 @@ static bool reqsk_queue_unlink(struct request_sock_queue *queue,
 	}
 
 	spin_unlock(&queue->syn_wait_lock);
-	if (del_timer_sync(&req->rsk_timer))
+	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
 		reqsk_put(req);
 	return found;
 }

