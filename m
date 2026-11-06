Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932752;
	b=mCLBLoyUo6vZ1BIn2R4y6IR8icClkGsaJxx8iqIQFS/wFYCfOfcjDQHDTT38Z+QcrmjV
	 /dJQZ7u1raNzP5dqaHq/6FhdSMaONjv67niQQPanKgCikMrB86hmx6+mREZbWVZZKCBru
	 K2tquQ+gmHW0a4wDKfPtg4PR9mG1i5tJEu6t2/lJaWbMcB1OW7VSk0+76Ocu7B0hrUdZJ
	 rCCCHyyJQ1LXWiFJMmsRCh72qrpeD1YE7AXCfNh0W+YzAHWR/KWrp6AJ5HhB0o984Zh98
	 0n9gVeiAHv/imyrSbIyQNV9nQzdQYsoiETQlInkPj/sioPydnF8vv3Ay6/4ATV0qoiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932752;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0m92HgnDhBMlisRGjomTpskCbN0xKi+jpiZYcxG8tKw=;
	b=XRSOc2LeHYsrHLTByNtZ9e3L/b1Od7V5aEr1HEqW3r+nNRPQsZ615MY/QhVLmRyt2mQn
	 LgtgTMDreSBPAHnj4CKXBhq7AXMLTysOpO4wOZP0hFthLbi8ZkJjKEP5tOZGluzqaONp+
	 qQXmEX6H0EC8Yg74bSPc/3wngR5jbDzvTgFtleQ9tvd/3ko2zwyDbXTkIpJpCuqSuOVrO
	 G8eoQlI9NqI9L3d30DHhRe36TxJvqHlAyn4sB2zpPX3vWCfzsatQdsO3GIYW2j4nfclVF
	 Ho+ya5xW7Mu4msKOMikU9q++4vMTIt0WFDO0nh+RYzaJTz8M9i6702ddINys3HX2Zdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RFhhZxqk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823C606A333
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RFhhZxqk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E3C1F008A3;
	Fri,  6 Nov 2026 02:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932752;
	bh=0m92HgnDhBMlisRGjomTpskCbN0xKi+jpiZYcxG8tKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RFhhZxqk2pu/2CCplwT2pDXw7q9lccDZZF+rK5a0mGbM4/b9x7PZSSV3uKl2+iNOj
	 vCl19F/F74rx6VtS8RkjFyaaaqPlX9WApmANNChnwl3qz0C1GWMK69GTbEDjzw9IkC
	 EMROUc6jVYa9GV+YW4PI4+zI8t3wwHrKYYWQPbHYXvdjfG14MHv/XOJkcr2appCjSp
	 vI23GF48zOQhZKf7n9n+gJwza31Z4Qcp8ea8gFqSLrq0sqAYC8mERkHEHGDJSlDq1y
	 +12mZhGyH5WX50FG97H71iCsh8fYNvRFqTA36nPKrnGAUlcYisq8uxtgxAxyXzRodo
	 Mqh8c9Ezm69jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] nfsd: eliminate cl_ra_cblist and NFSD4_CLIENT_CB_RECALL_ANY
Date: Thu,  5 Nov 2026 21:39:06 -0500
Message-ID: <20261106022849.3786687-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106022849.3786687-1-sashal@kernel.org>
References: <2026110416-cleat-grapple-d472@gregkh>
 <20261106022849.3786687-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 424dd3df1f991b14a70f044a68c8a595abbdf1ad ]

deleg_reaper() will walk the client_lru list and put any suitable
entries onto "cblist" using the cl_ra_cblist pointer. It then walks the
objects outside the spinlock and queues callbacks for them.

None of the operations that deleg_reaper() does outside the
nn->client_lock are blocking operations. Just queue their workqueue jobs
under the nn->client_lock instead.

Also, the NFSD4_CLIENT_CB_RECALL_ANY and NFSD4_CALLBACK_RUNNING flags
serve an identical purpose now. Drop the NFSD4_CLIENT_CB_RECALL_ANY flag
and just use the one in the callback.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 9af39c0773ef ("NFSD: Send a meaningful CB_RECALL_ANY keep count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 16 +++-------------
 fs/nfsd/state.h     |  2 --
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2188c15d3ec6c..b9d3e134dc1b4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3246,7 +3246,6 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
 
-	clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
 	drop_client(clp);
 }
 
@@ -7005,7 +7004,6 @@ deleg_reaper(struct nfsd_net *nn)
 {
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
-	LIST_HEAD(cblist);
 
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
@@ -7019,31 +7017,23 @@ deleg_reaper(struct nfsd_net *nn)
 			continue;
 		if (atomic_read(&clp->cl_delegs_in_recall))
 			continue;
-		if (test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags))
+		if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &clp->cl_ra->ra_cb.cb_flags))
 			continue;
 		if (ktime_get_boottime_seconds() - clp->cl_ra_time < 5)
 			continue;
 		if (clp->cl_cb_state != NFSD4_CB_UP)
 			continue;
-		list_add(&clp->cl_ra_cblist, &cblist);
 
 		/* release in nfsd4_cb_recall_any_release */
 		kref_get(&clp->cl_nfsdfs.cl_ref);
-		set_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
 		clp->cl_ra_time = ktime_get_boottime_seconds();
-	}
-	spin_unlock(&nn->client_lock);
-
-	while (!list_empty(&cblist)) {
-		clp = list_first_entry(&cblist, struct nfs4_client,
-					cl_ra_cblist);
-		list_del_init(&clp->cl_ra_cblist);
 		clp->cl_ra->ra_keep = 0;
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
 		trace_nfsd_cb_recall_any(clp->cl_ra);
-		nfsd4_try_run_cb(&clp->cl_ra->ra_cb);
+		nfsd4_run_cb(&clp->cl_ra->ra_cb);
 	}
+	spin_unlock(&nn->client_lock);
 }
 
 static void
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e4c3e5907db15..4e0e36b81b203 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -412,7 +412,6 @@ struct nfs4_client {
 #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
 #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
 					 1 << NFSD4_CLIENT_CB_KILL)
-#define NFSD4_CLIENT_CB_RECALL_ANY	(6)
 	unsigned long		cl_flags;
 
 	struct workqueue_struct *cl_callback_wq;
@@ -461,7 +460,6 @@ struct nfs4_client {
 
 	struct nfsd4_cb_recall_any	*cl_ra;
 	time64_t		cl_ra_time;
-	struct list_head	cl_ra_cblist;
 };
 
 /* struct nfs4_client_reset
-- 
2.53.0

