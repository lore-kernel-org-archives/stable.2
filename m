Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A1379988
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790992285; cv=none; b=Ph6Zr1fjeGMWKNhH7BVduAJqwvIxfiBvqBEt/Q1vBvuMZfqw2QnJI4K5cKwrfkazalsFqaR+0E1QcPdeVuuGUnwddlEyOxo2nvTGH609n7+PpKWLjLfmhbiED+89ILQLHuI1jQ9n9YdSTWYtX/Z/hAEIXqXjSxV6CSXWreIM/oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790992285; c=relaxed/simple;
	bh=hdIKu0pVLTP4zHOm96lsov41aNo8DEqwaKB7W3TKITM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rT6gRy/ycPUbfRqCwmbJ3HIBM3sy4hyAVKvGUDsIEiWpOy8noGwPBpuz00MyYuLAXeHkHiPzZpJwzRBge78cMd+Pvokn63FneJZrePZKee9J9An3q1zJW/r8mkCwMm+6vHvWtpl8VQmSRvVW+z4+oPOYbN5kKoXzhvwZ91SzA7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K18UAXIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K18UAXIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CBE1F000FF;
	Sat,  3 Oct 2026 01:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790992283;
	bh=VLU1Pge6FRF0rwWixvb2zr/9XXa5fKvV9e5a4a7myTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K18UAXIoR3ZzE6Zf5oE9/60/BNkeuva5YNQr8UrEJSxBqegFLyiLvCAYFm5T+0cX9
	 XmFNd2chH9SM02uYxi0AFcJepGhRVdti4Aks5bkNPbvMWJF+btiJ08uTGLZpUHOlrG
	 UuX9Kj1XZiB4n/Ctw6peJZ1xdsopHD+N5WaDIdJ73QLQcWI1tuwyxYVOscypJCmEtD
	 RANthxr5nUCVyIiKEUeZqdsG7aE0VHuez49OKhnrCNHQHWWd3khHrspOC4cEo1LE2b
	 wITUc1hnZ+TBHqrAT+g33rnxw93yzlSO9EzvPsu3A4StaXcj6LpMh9rUJFn+2MeaHA
	 urEU+kEYi0k1w==
From: Allison Henderson <achender@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	harshit.m.mogalapalli@oracle.com,
	maoyixie.tju@gmail.com,
	Simon Horman <horms@kernel.org>,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>,
	Allison Henderson <achender@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18.y] rds_tcp: close NULL deref window in rds_tcp_set_callbacks
Date: Fri,  2 Oct 2026 18:50:55 -0700
Message-Id: <20261003015055.1241731-1-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <051245f8-42ee-4046-bff9-5fd2dbeaf807@oracle.com>
References: <051245f8-42ee-4046-bff9-5fd2dbeaf807@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maoyi Xie <maoyixie.tju@gmail.com>

commit d2bfdbb69cf87676981b1043010b6224d84c6d3a upstream.

rds_tcp_set_callbacks() links a new rds_tcp_connection onto
rds_tcp_tc_list under rds_tcp_tc_list_lock. It releases the
lock, then assigns tc->t_sock = sock outside the lock.

rds_tcp_tc_info() and rds6_tcp_tc_info() walk rds_tcp_tc_list
under the same lock. Both dereference tc->t_sock->sk without
a NULL check.

A reader can acquire rds_tcp_tc_list_lock between the writer's
spin_unlock and the t_sock store. It then sees a list entry
whose t_sock is NULL. The dereference of tc->t_sock->sk is a
NULL access.

Move tc->t_sock = sock inside rds_tcp_tc_list_lock, before
list_add_tail. A reader holding the lock then observes the
linkage and the t_sock store together.

The restore path is safe. rds_tcp_restore_callbacks() does
list_del_init inside the lock. The matching tc->t_sock = NULL
after unlink is harmless to readers holding the lock.

Fixes: 70041088e3b9 ("RDS: Add TCP transport to RDS")
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Reviewed-by: Allison Henderson <achender@kernel.org>
Link: https://patch.msgid.link/20260512142807.1855619-1-maoyi.xie@ntu.edu.sg
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ achender: resolved context conflict; tc->t_rtn initialization is not
  present in this tree ]
Signed-off-by: Allison Henderson <achender@kernel.org>

---
Also applies to 6.12.y, and to 6.6.y, 6.1.y, 5.15.y and
5.10.y on top of the queued backport of c96a5209dda6 ("rds: filter
RDS_INFO_* getsockopt by caller's netns").

 net/rds/tcp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index f6d243c4e52c..eab960d10ab0 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -232,16 +232,19 @@ void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp)
 	rdsdebug("setting sock %p callbacks to tc %p\n", sock, tc);
 	write_lock_bh(&sock->sk->sk_callback_lock);
 
-	/* done under the callback_lock to serialize with write_space */
+	/* done under the callback_lock to serialize with write_space.
+	 * Set t_sock inside rds_tcp_tc_list_lock so readers walking
+	 * rds_tcp_tc_list under the same lock cannot observe an
+	 * entry whose t_sock is NULL.
+	 */
 	spin_lock(&rds_tcp_tc_list_lock);
+	tc->t_sock = sock;
 	list_add_tail(&tc->t_list_item, &rds_tcp_tc_list);
 	spin_unlock(&rds_tcp_tc_list_lock);
 
 	/* accepted sockets need our listen data ready undone */
 	if (sock->sk->sk_data_ready == rds_tcp_listen_data_ready)
 		sock->sk->sk_data_ready = sock->sk->sk_user_data;
-
-	tc->t_sock = sock;
 	tc->t_cpath = cp;
 	tc->t_orig_data_ready = sock->sk->sk_data_ready;
 	tc->t_orig_write_space = sock->sk->sk_write_space;
-- 
2.25.1

