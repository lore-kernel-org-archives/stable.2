Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011963;
	b=MvzxXubEmOMcXYDZdew6yG5MEJklZ1Kdst8uGPi1Nd5CCX/VCAVVOOTWFoinDoARs/Nv
	 8W/Q8TC1NlnqSxHhFivyvSfsFh8CFcLAuhUxoID07ExO8zW4jsq08x1ICgA7VVFvRJtwK
	 CoqXRNtYUw78uWV0Xu8pMD7wTN6Mj9+yY4xOizW3yP6FT4DznCJqr7VBh2QGcNDBD/8WT
	 ESEbUlB4lQsAVS4ovVQOE7JQQmAJ3q5Z5+BzF9S5X2eWd/gVZQz8OLWJTo8tTXikoucw0
	 3q52kOrdf4MSqt++Jfb0HGyNaG6Q+Nk4odA+RKku9TC+FPhmI1cOqd9oGKIy+kRnT9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3Em7THwSHsQndbMmwUsL9yOCeRU0YR5E1djj6NAjXMU=;
	b=xhWIv71i8heQ6bXl4fDnpCpNRZ24vQ2r4qu8CFotGgv7RWORYdAKFZHQHkQv2xlBcrRm
	 fa0k1h6Q0xr7T7YBr5mHGcZKhoMwR4UkK0fszBMPjJGy5aKQAYTCO/ilHbgMPgux7eCkl
	 8iTAdszMjyq2lTPiwIVIQzDUCHyCzDmUonuPDD3w2Bxk5QXpaW6RPdc+WRe37YB0XJmL/
	 rG/T5cf5+RpwGR+fngKSbdrWrUJZXTHC9bBDYVc7E7HHMQpRSiRakcYawnag8cZsNSpkq
	 MWqVmavN+3pEQqQHQegrBQoj4ujyRD2ksnP0wlmVgPKbcFKdkGDPyH1X39nD6M/1HNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RLJySYeS;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1996606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1996606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RLJySYeS
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35943f55c06so3904017eec.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793011962; x=1793616762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Em7THwSHsQndbMmwUsL9yOCeRU0YR5E1djj6NAjXMU=;
        b=RLJySYeS0BQzTg9o9qO1xD/c5MAamNT+UD+2xN9Z+O05l/Av3gsWFchNwa7tQatxX+
         c7BuZqBIeWfC4XCHIypjcL12Rf9wShN/qjN8EHf5Sifu5uU5Gu65k5fhjLfDId6s2j6q
         1Bty0VjzgEDUe1SqrhnScGnTOB9bFQ6Wq2OeBeh84Bqe0r6HuhWR0aybhUZb3DrcP95w
         8ieeeWrrrXr/3oQqHJbTuy0aDB2I+E8wrDeXRbT2KsvcC5xbFpS31ds8tNlKwtVf7MFF
         Y9Inrm03hhOEaPsSo7I63KeSFeSCHw91s4Lh8A4k/KT2vApbN3rAruLE9fWZ2OttXAUK
         51sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011962; x=1793616762;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Em7THwSHsQndbMmwUsL9yOCeRU0YR5E1djj6NAjXMU=;
        b=0wn8a1IR++hY66iYtZcw7q6d9e8dTrH1L28tJ4udfP28PPnp0xprTqDb1ex0qmwoP2
         kxGvWsihKbvHHCFOM9k8zFtxCipgTafWfViaATa1V6bGc9pwOHxAXqGjGFQqSWhyp93/
         t9xJefwNdPR8SFhha7lFClDTVhsd82aaMHvMw0dmX96HLylzvwNbb/BMUc16lD83CZuR
         szRWKFJQT8Zz8++hY7ZXcAayE/2Xj5aKEr0zr292sh1K7M3RhGfXhM9HAvjwF21rt44I
         WoxRmhgqU0Sd1R9cSfZ5KfIu3X706C/ud1Ds7BPuUojDU386RBctXUg8YropUxZM30LS
         AbfA==
X-Forwarded-Encrypted: i=1; AKwUvBwsRKqQWU53b1zuDxi7nFIAPfuaOUnVB7GwDgg3S+ysqcMAZgw+sM/fYnpeNF9TQ1/p+FjEvmo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuVofihAa38x+01vGkHCRSZq1PxawjZ9BnJk9fHkhVsBXNYjnQ
	H/A0cm06lon7qm7O0BX0Q2oJflP3IYC03Bjow4eowhadRO/qTotctb79
X-Gm-Gg: AYBFou2I/J3Rt+U77taQTZAqFkZsyCmaf5vKDxg82SQBn+bWXRzUZ4hcIugcndRDvM1
	udager+ygYoU+0Hq6kN/1a5Pq8CKrQx58m8SZ39HsRRpMvG3vdC6iEu2s6NfJcqTDx6dzA2NIe4
	hI0RwyHEXRZCkU2/zlm7P5C9w2LUptukKSclLmIrxs/mYMcNRFcrHXQqHITWtLwB606h9qlZYuq
	Ayvv/Dl47FgX4F6eBCU7ciE97u0I1LTSTfxWvHNUr5BBEh/EMuzRDwxqHLt2OOU6m5u1pETmuoT
	SD1ZchT1+jw93t8bFhOQ95Qj39FfFKOTJpF/MMY6Y2LCBVVexQPiD/Jpicz2AXW6wNM5CbhHRAM
	44pFVfS3FQtqMfbEhq5m2n8ML28R9mjYgq7QJ4ZzFcbNLLmt0T5To+YvF9ljz4PqyOv6HnMBQSU
	CCVL0YLNFJIrxzS07orsefq/glGEZBT11JqgVJmRqs836Z3HsAZnlzwZz3xhFnr0RirZ8hYyTRS
	owBagkbN46ouwaxh84Yk/b5wW9pHHGEEh3+EPQR1VgF2sPchuQd4CmdcB/i4n06ceY4jr6VmfQU
	ZApJ6gplMu1CtVRpX7hEusZ9qTzMIyNnxszk4tEf
X-Received: by 2002:a05:693c:69c3:b0:35f:ab1:4792 with SMTP id 5a478bee46e88-369e8484992mr8381446eec.6.1793011961611;
        Mon, 26 Oct 2026 03:52:41 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7b23sm33875226eec.19.2026.10.26.03.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:52:40 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] NFS: defer access-cache entry and group_info free past RCU
Date: Mon, 26 Oct 2026 03:52:30 -0700
Message-Id: <20261026105230.1150218-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

nfs_access_free_entry() drops the group_info reference synchronously
while the nfs_access_entry itself is only freed after an RCU grace
period.  The lockless lookup path (nfs_access_get_cached_rcu() ->
access_cmp()) can still be walking group_info->ngroups/gid[] after the
entry was replaced and unlinked, so put_group_info() can reach
groups_free() -> kvfree() under a reader and free the array it is
reading: a slab-use-after-free read.

put_group_info() may end in kvfree(), so it cannot run from a plain RCU
callback.  Defer both the group_info reference drop and the entry free
to process context after a grace period with queue_rcu_work() on
nfsiod_workqueue.  The entry accounting (nfs_access_nr_entries) and all
call-site locking are unchanged; the work only drops the reference and
frees the entry.

On a 7.3 KASAN kernel, the following workload triggers the report: a
userspace NFSv3 server plus eight readers doing faccessat() with 2048
supplementary gids, and serialized credential replacements that detach
the previous killer's group_info reference.

 BUG: KASAN: use-after-free in nfs_access_get_cached+0xb8f/0xf80
 Read of size 4 at addr ... by task poc/9552
 Call Trace:
  nfs_access_get_cached
  nfs_do_access
  nfs_permission
  inode_permission
  do_faccessat
 Page last allocated by task ...:
  __kvmalloc_node_noprof
  __se_sys_setgroups
 Page last freed by task ...:
  nfs_access_free_entry
  nfs_access_add_cache
  nfs_do_access

The trigger needs CAP_SETGID in the guest for the setgroups-based
credential churn; the faulty read path is the ordinary access(2) /
faccessat(2) path used by any NFS user.

Link: https://lore.kernel.org/all/20261025180329.349613-1-teel4res@gmail.com/
Fixes: 6238aec83f3f ("NFS: don't store 'struct cred *' in struct nfs_access_entry")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
v2: add Link, Fixes and stable tags, and remove local validation details from the
commit message.

 fs/nfs/dir.c           | 21 +++++++++++++++++----
 include/linux/nfs_fs.h |  3 ++-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2898,10 +2898,25 @@
 module_param(nfs_access_max_cachesize, ulong, 0644);
 MODULE_PARM_DESC(nfs_access_max_cachesize, "NFS access maximum total cache length");

-static void nfs_access_free_entry(struct nfs_access_entry *entry)
+static void nfs_access_free_entry_work(struct work_struct *work)
 {
+	struct nfs_access_entry *entry =
+		container_of(to_rcu_work(work), struct nfs_access_entry, rcu_work);
+
 	put_group_info(entry->group_info);
-	kfree_rcu(entry, rcu_head);
+	kfree(entry);
+}
+
+static void nfs_access_free_entry(struct nfs_access_entry *entry)
+{
+	/*
+	 * The entry can still be reached by RCU readers that dereference
+	 * its group_info in access_cmp().  Drop the group_info reference
+	 * only after a grace period, in process context because
+	 * put_group_info() may end in kvfree().
+	 */
+	INIT_RCU_WORK(&entry->rcu_work, nfs_access_free_entry_work);
+	queue_rcu_work(nfsiod_workqueue, &entry->rcu_work);
 	smp_mb__before_atomic();
 	atomic_long_dec(&nfs_access_nr_entries);
 	smp_mb__after_atomic();
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -26,6 +26,7 @@
 #include <linux/refcount.h>
 #include <linux/rwsem.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>

 #include <linux/sunrpc/debug.h>
 #include <linux/sunrpc/auth.h>
@@ -65,7 +66,7 @@
 	struct group_info	*group_info;
 	u64			timestamp;
 	__u32			mask;
-	struct rcu_head		rcu_head;
+	struct rcu_work		rcu_work;
 };

 struct nfs_lock_context {
