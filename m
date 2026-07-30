Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20D2F616A
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373315; cv=none; b=ic56gKMW5micpEcupNzGy0oFJW/j7eOZx21q+ppe68h4XQysBEezAK/wMaRIzl07C23T+DrkIo/Cs0W90g9wBO4c5/vQTlTsdeT8SpyorxRxXfnAa8G77FUivIEswmD0/IEjbfLH8w8AB30Rrq4bU5RSb/SWZQ0NHlp0c3IX/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373315; c=relaxed/simple;
	bh=pE7sHkeeyb7jRQ882T4OzvGEXfUAsyqxZUebr8zGr7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajVUrrGdksjkfNDsc9LTIdhgPQwhsdFYWM9X+04VKObjEFBH/o4hRcnPWmK+2qb0KT1ABoOwP2PgCRWrgOxq3A2gOvBJBAP1KmG5kvb7ZE+Lx2ZDYcu82b+m5+9qYpujbSaRMibBMCrWEXWhw+hQO0OBFvP/imV81SpzdyH1I0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miRApMnn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miRApMnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E9D1F00A3A;
	Thu, 30 Jul 2026 01:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373309;
	bh=i3InzQ2Sw+S8LotVcejzDC4f4t8SHv2trFOTaoObHsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=miRApMnnDRq0lTO6UFXJKub0fKKytmVdcwFrtxd9EW3ixRUu4w2ReQRd3UBvrxUVw
	 XmR3M6dfM+DY3jaqI2xX++Wn4uhM7sOQNZQYFq5itCuh7pn5NygrUmnWZ5iAn4yejp
	 vk+Btflo6yJ1LFFF8GHlWpAIFVowtNQC8C4yPzf4Gn62bnU6+Z4RZYmIkh0tXSTpfo
	 3+dz0phSHnykxJ0r5e54czEn3EZs6N2d/tYabGPkRDO7BvwY3QRRGASz/rEDI9+Qkv
	 Uj+GOaK1AtBABgxzeVRTdbtFnQUZyYoScK0ZuIF04IHaJUSUA5d3tX71GiiK0a40/q
	 3DHmyfA4Jq87g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 8/9] afs: Fix lack of locking around modifications of net->cells_dyn_ino
Date: Wed, 29 Jul 2026 21:01:39 -0400
Message-ID: <20260730010140.1700208-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730010140.1700208-1-sashal@kernel.org>
References: <2026072127-dress-overplay-421f@gregkh>
 <20260730010140.1700208-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 55e841836c6f4646490f7b0347192b7a92d431ba ]

Fix the lack of locking around modifications of net->cells_dyn_ino by
taking net->cells_lock exclusively.  This also requires to cell to be
removed from net->cells_dyn_ino in afs_destroy_cell_work() rather than in
afs_cell_destroy() as the latter runs in RCU cleanup context and sleeping
locks cannot be taken there.

Fixes: 1d0b929fc070 ("afs: Change dynroot to create contents on demand")
Closes: https://sashiko.dev/#/patchset/20260618074903.2374756-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/20260622090856.2746629-19-dhowells@redhat.com
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: 26f17ce6fa3f ("afs: Fix premature cell exposure through /afs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/cell.c    | 8 +++++++-
 fs/afs/dynroot.c | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 41f7e11c139711..cd5708f78ad614 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -198,8 +198,10 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	cell->dns_source = vllist->source;
 	cell->dns_status = vllist->status;
 	smp_store_release(&cell->dns_lookup_count, 1); /* vs source/status */
+	down_write(&net->cells_lock);
 	ret = idr_alloc_cyclic(&net->cells_dyn_ino, cell,
 			       2, INT_MAX / 2, GFP_KERNEL);
+	up_write(&net->cells_lock);
 	if (ret < 0)
 		goto error;
 	atomic_inc(&net->cells_outstanding);
@@ -521,7 +523,6 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 	afs_put_vlserverlist(net, rcu_access_pointer(cell->vl_servers));
 	afs_unuse_cell(cell->alias_of, afs_cell_trace_unuse_alias);
 	key_put(cell->anonymous_key);
-	idr_remove(&net->cells_dyn_ino, cell->dynroot_ino);
 	kfree(cell->name - 1);
 	kfree(cell);
 
@@ -536,6 +537,11 @@ static void afs_destroy_cell_work(struct work_struct *work)
 	afs_see_cell(cell, afs_cell_trace_destroy);
 	timer_delete_sync(&cell->management_timer);
 	cancel_work_sync(&cell->manager);
+
+	down_write(&cell->net->cells_lock);
+	idr_remove(&cell->net->cells_dyn_ino, cell->dynroot_ino);
+	up_write(&cell->net->cells_lock);
+
 	call_rcu(&cell->rcu, afs_cell_destroy);
 }
 
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 8c6130789fde3a..5cd5874ab96fbf 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -277,7 +277,7 @@ static struct dentry *afs_lookup_atcell(struct inode *dir, struct dentry *dentry
 }
 
 /*
- * Transcribe the cell database into readdir content under the RCU read lock.
+ * Transcribe the cell database into readdir content under net->cells_lock.
  * Each cell produces two entries, one prefixed with a dot and one not.
  */
 static int afs_dynroot_readdir_cells(struct afs_net *net, struct dir_context *ctx)
-- 
2.53.0

