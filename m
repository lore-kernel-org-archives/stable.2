Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF53152BE59;
	Thu, 15 Oct 2026 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071247; cv=none; b=fA/i/hhEiUIHFB0Mi3YBQql/3Izx9qGoHVDyusjzikpX0MpFWRo7iGu1VIHtxrmgaXk6EHp5kyec7qhLTXAxswwdBlJeD3fasHWV+ufO0nS2rXFQc7llGwc+qT34lRjfS3fijxhWbvEbLUY3J92/mCcDrC5ga68c1x9gKilmfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071247; c=relaxed/simple;
	bh=NzjgoKSqPSjbYwgEQR0ht6nUFl9E/8V5nNxLCRxQd00=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=X7wMk3u5CqMkeQ1RYGwcLnz1taymsw0ypR9EnBihUGealrm2QhYaSUZTRs1WIULo1cFhvvua08ylO1vo14hCYKah3nsllHmo7+9Xea+p4cgU09qaYLDYXTc1+xb7QqN3f3sgdc+j5hGZXajeuv4bYagVT55n0R1TrFqnNmPb0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdWcrNOS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdWcrNOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EDC1F000C7;
	Thu, 15 Oct 2026 13:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792071245;
	bh=ohxQMm4+6T4AWLsYoE6Ve+xI6U19JmMjTGTIn0TAFO8=;
	h=Date:From:To:Cc:Subject:References;
	b=BdWcrNOSHi10EM+ZDfEpAF/liaYBkCSW8DM3oTBUM8Pvjt1Y5LBlZ/u9c227soT9w
	 Bzd6RoeuNzNNu05W/ZvzlI6RWRmdMLVLAUI1SXW6AeMWsukiq/8DJgLtpPov8wjPoU
	 PeThTfJ68I6qKPTbyvg6eeeUB2WSBlE2Uq3rboCZgxtof51owJqZwx0+iwRG6MQZrd
	 v60CZPAMc0XB/fEMWiih1dWmO1CQqXsd6p4wpn8AUwGk0RZorhnn+Vp6c4TSoFEbOX
	 gHyunyvJRMzUP2sAmU8r1OmXK88C4m/KG/SZc934yZ8E6XpSgi/zklCNE6fMz02QPc
	 v5khSunVh54jQ==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHLau-00000000Mgg-34HL;
	Thu, 15 Oct 2026 09:34:04 -0400
Message-ID: <20261015133404.546835597@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 15 Oct 2026 09:33:23 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 "Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: [for-linus][PATCH 13/16] eventfs: Free the eventfs_inode after an rcu grace period too
References: <20261015133310.731003448@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Christian Brauner <brauner@kernel.org>

tracefs_d_revalidate() reads ->is_freed of the eventfs_inode that
dentry->d_fsdata points to, and ->d_revalidate() is called in rcu
pathwalk mode with nothing but rcu_read_lock() held. The dentry itself
stays around for such a walker, but tracefs_d_release() drops its
reference to the eventfs_inode when the dentry is killed, and
release_ei() then frees it after a grace period of eventfs_srcu. An
SRCU grace period doesn't wait for rcu_read_lock() sections, so the
walker can read an eventfs_inode that is already gone.

With a pathwalk held up in tracefs_d_revalidate() while the dentry goes
away:

  BUG: KASAN: slab-use-after-free in tracefs_d_revalidate+0x76/0x90
  Read of size 1 at addr ff1100010152d8d0 by task walker/97
  Call Trace:
   <TASK>
   tracefs_d_revalidate+0x76/0x90
   lookup_fast+0x320/0x640
   path_lookupat+0x160/0xb00
   filename_lookup+0x1f1/0x5b0
   vfs_statx+0xd7/0x3b0
   vfs_fstatat+0x4d/0x90
   __do_sys_newfstatat+0xa0/0x100
   do_syscall_64+0x10e/0x5e0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  [...]
  Allocated by task 1:
   __kmalloc_cache_noprof+0x249/0x560
   eventfs_create_dir+0x7a/0x590
   event_create_dir+0x2fb/0xcf0
   trace_add_event_call+0xbf/0x150
  [...]
  Freed by task 11:
   kfree+0x1db/0x5b0
   srcu_invoke_callbacks+0x3a3/0x620
   process_one_work+0x937/0x1810
   worker_thread+0x4f1/0xd60

Before commit 8e556432477e ("eventfs: Use SRCU for freeing
eventfs_inodes") release_ei() used call_rcu(), which covered the walker,
while eventfs_iterate() needs the SRCU grace period. Wait for both and
chain call_rcu() from the SRCU callback.

Cc: stable@vger.kernel.org
Fixes: 8e556432477e ("eventfs: Use SRCU for freeing eventfs_inodes")
Link: https://patch.msgid.link/20261009-work-fixes-rcu-v1-4-7446d2d335e6@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 6e3513b13cfa..090aca946717 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -91,6 +91,14 @@ static void free_ei_rcu(struct rcu_head *rcu)
 	}
 }
 
+/* read under eventfs_srcu and, by tracefs_d_revalidate(), in rcu pathwalk */
+static void free_ei_srcu(struct rcu_head *rcu)
+{
+	struct eventfs_inode *ei = container_of(rcu, struct eventfs_inode, rcu);
+
+	call_rcu(&ei->rcu, free_ei_rcu);
+}
+
 /*
  * eventfs_inode reference count management.
  *
@@ -112,7 +120,7 @@ static void release_ei(struct kref *ref)
 			entry->release(entry->name, ei->data);
 	}
 
-	call_srcu(&eventfs_srcu, &ei->rcu, free_ei_rcu);
+	call_srcu(&eventfs_srcu, &ei->rcu, free_ei_srcu);
 }
 
 static inline void put_ei(struct eventfs_inode *ei)
-- 
2.53.0
