Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703FB24A06A;
	Mon,  1 Jun 2026 03:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283478; cv=none; b=R7GsGNvdRMo9sgtBofZJg2kQS0vmvCRNPxDpjll2T61dAYFJOqpqOoI6uL9YJlBn7oC1h9HBrINfuxdYuMkQt0Hy9JtR8EaUsZyt7MoAaPSoXPBy9qu6Y2b7o2NOSsNoC+9IpgU1dHtJUEdm0vPMWlk7lhF6OmFBxV0sYOxEW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283478; c=relaxed/simple;
	bh=GLfWQd2TsQbqct9PeWcRmweoXhBgKsmkaFdxXHjiZJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XOMdelDC7O+Dgq73nbYADPXYzfX5TLrCHYDr3ahOyl6dtB6GgH3zARJtLb4Da/f8WkdkwWSt2bwNmMLd0DMvtXbyEy05rzTly1fDluiC8jPo+0oHCXFzTY98XLl7H6Dm1ea79JXjeY6bmpki2orjy1o/mZ2gETxDH+LHwAXJWMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6ynj0Uh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6ynj0Uh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5EB1F00898;
	Mon,  1 Jun 2026 03:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780283477;
	bh=Ff1yPSPiJtJfD68kpyDRuircorhinc0kjjCW+BQhjP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G6ynj0UhTzgdKfDqIdpjebGQo69vfYElzlnMIVBgveFtMDBcwZoIiG8NMgFBziFnP
	 WGbpHOf+XRljtHEO7g/xufQ73WvWqt/rodAUtmB2lqk88Q+z0aHUfm5N4pblmDlvbO
	 KVxeeu6thkQPfAoTUFgong+Bx5GjUOwhILmr/++PYE9UqyNI9i+j4ho8IKDNvNShHy
	 kk5E8D4fkqvP5CPC5C7ZgCFNIRYqfA4biVEZiOkrr9nXkAEKBFSbGFn0mTyzsaccCy
	 ayavaQmC8ZMiYXf4m46jjcG9dCT8kByrLNG4oQtiBXhl7qM4HkM/dCvKVSFy28aSV0
	 8veYJogawRcsA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 13:10:05 +1000
Subject: [PATCH net 09/10] mptcp: pm: avoid sleeping while holding
 rcu_read_lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-9-a5ae7791754b@kernel.org>
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
In-Reply-To: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Hannes Reinecke <hare@kernel.org>, linux-rt-devel@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2332; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=GLfWQd2TsQbqct9PeWcRmweoXhBgKsmkaFdxXHjiZJ4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHPgf8MYNWxvDl7gSug1wQ7Kaz3jmOSNsfBYXe
 ALCqAN7N4mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahz4HwAKCRD2t4JPQmmg
 c2/7D/47YihB1wam2Kedc6BDJ8zDyMcet3jUTJr6jlS90sLBM1g23lR/IF83v2EJQ8iYxXP4sbU
 yjnhxnaIB5SEdYtQXpdw5pjs5iZojPm+N28iSQRXwadEfaalsfaLlfqScS7r/4//sASQ7EEbZoE
 jE/EpD4KFjDo8+LHLjxyxG+Dhs7UXIa4ksX/jLdCfyvG/tH43agdcdW77acfl/oAsQ7hQCJnc9c
 HX9tzlp2RkjA51JBA7zwgitLA4MAtrAMJpZ4o4dAFDCr9unF0mvs+utACO7cDF7hMM1EAI0CSe4
 UDhGzmMmzvF3eGUbS6iKQJPDBV3LwcEb+Zgf7aj5IN3Zw3njG6PcpMjvADd6V3NSz0I5LwC1RM7
 E0GUgwDijq7z+cKumhUuxH8kxgYvg4sjDJ4Yx2upkgxdi/QsVdWyKgCVk14LkLAJrXL7zsmogm3
 gO7mUbfGFhmVtfujHnduH4J5urV8ceYuEtJn7+gcT4mjz955e0QolJq9+Sx3zY1F4F0mbfe30xi
 RfP2LoPyk72PtmIz9Cnzs7tDRyb1+TyrFzC+tKsndTFVDLPfL3OGQs0m9gTVLKFUqB7uYJuoBwO
 s+mJ486T1a6b3sYHXcTYzAkQOe0cFRNiHlpB1y6em2YVxP5ikClKPHUuaL4nC2gy5TbYTYgDWo3
 RWKIWkJphaeUnbA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

sk_stop_timer_sync() calls del_timer_sync(), which spin-waits for the
timer callback to complete on non-RT kernels. But on PREEMPT_RT, it can
sleep. Sleeping inside an RCU read-side critical section might trigger a
lockdep splat.

Instead, keep a reference to the timer, under rcu_read_lock, and call
sk_stop_timer*() without the RCU lock.

While at it, apply the reversed Xmas order when declaring variables.

Fixes: 426358d9be7c ("mptcp: fix a race in mptcp_pm_del_add_timer()")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <clrkwllms@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: linux-rt-devel@lists.linux.dev
---
 net/mptcp/pm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3e770c7407e1..1e0866159972 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -401,9 +401,9 @@ struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id)
 {
-	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
-	bool stop_timer = false;
+	struct mptcp_pm_add_entry *entry;
+	struct timer_list *timer = NULL;
 
 	rcu_read_lock();
 
@@ -411,7 +411,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-		stop_timer = true;
+		timer = &entry->add_timer;
 	}
 	if (!check_id && entry)
 		list_del(&entry->list);
@@ -420,14 +420,14 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	/* Note: entry might have been removed by another thread.
 	 * We hold rcu_read_lock() to ensure it is not freed under us.
 	 */
-	if (stop_timer) {
-		if (check_id)
-			sk_stop_timer(sk, &entry->add_timer);
-		else
-			sk_stop_timer_sync(sk, &entry->add_timer);
-	}
+	if (timer && check_id)
+		sk_stop_timer(sk, timer);
 
 	rcu_read_unlock();
+
+	if (timer && !check_id)
+		sk_stop_timer_sync(sk, timer);
+
 	return entry;
 }
 

-- 
2.53.0

