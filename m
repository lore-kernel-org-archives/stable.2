Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE615448CE3
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582828; cv=none; b=FBnPPVWRtdAy/l1goKhDSt/VTspyycrm0mCVETodJ+tPV+OTjWTzVItkzck/s4IB6VtodmR8bwpjoJdMpdsAfhJPTU13ejNukrTpakP2HJufqwWJJYmDCgqHVr+qhnti6qDxRKpX0AGyDgeD8B7TDyBA8DmNr/Je3SzoCougI7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582828; c=relaxed/simple;
	bh=NXG7bE790VEEAyF28aLFVFci8yXbRztC6StC9DoElGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JQRER1sLbt0581HDbnMueG96P6woxaiAxoQh0tWWLPS3m8SAeNGHsJucCZTjy7/5bPlA4FVWHsHis2MVQeu77h51CLM5y16b8B1mFIEFDdxcgtIY88/rxtRjc6Uqr+oLxd5vHdBILg/kS/FTzGLXVcRCWc1hws4edhTaV5DG9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KawySjtM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KawySjtM"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso3987288a91.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787582825; x=1788187625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HbTvMJOA5pAnK3dUzCcI4B1WpzStHPSu12W55oNjXVo=;
        b=KawySjtMyaKjpiaTzAegy+9sFaXa9f+QcH53evqIh6Eai+w+efb+S4fJ5WTZY851vR
         qwSITmHO6w/HydKbTUTRKeR3G+2fdegdqJPEy9OQNJcuq2JPqqco4/clcTQ7rn4LbgDP
         TOdX1wN3re/qmKUJUwYFR2KmgJEdtik/Fvu3RblSbujkY/G9SJaVCBehNwnqHE4h5P9J
         V/PMqa5t5KahtDp4/yLsSQGicbt2SgVVqBrrtgSgrncxA0QdFwp7lre4KL9TCnOW4wzY
         i6WcLo7T9PipZX7GplPH+TP5s/wBdyxwmZRpxWXgNfdgPxeYEBw0A641CfSf17PbNkZW
         sK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582825; x=1788187625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HbTvMJOA5pAnK3dUzCcI4B1WpzStHPSu12W55oNjXVo=;
        b=XKc26ugmhihhtDvq09eoUMzAd+KE2F2SbCBMdg8uPLXUz0ZaQhNKwIkMQiTD33zUfi
         wyEO1UpzzXaulELZ5VVM4/mVKeYhfj/BcjO6pP8WBAkTv95NGgbOq5440qEKcyG4fr+F
         C+QyD8DNu5y9zIdIA6QGnV3niwRtVESBywonymzHLalZHTB3zNFD47Rd+2msfd91WCVt
         15d1fOhl0MXN6AOn+HkdFk4urbwF9OmdiUExaTGDfdF93YaGQWFPAeUkrrZ3lPccvdrs
         htmJwE6XskP3uFbruA8+ZzQ2h6WV6Gv9ih7I8HLPmtYVcbfs4yJQy29wyJ7ySZIdJE9W
         EPZA==
X-Forwarded-Encrypted: i=1; AHgh+RqHKUsyBuGpU0EbMvTo14pE4JJclw5UspM5oXezGAftFVdl94ZzkRBbuiFbMMuaH+FsxR5SDf4=@vger.kernel.org
X-Gm-Message-State: AFuF++nPTciSgxwxJCN2uq5mTl5GjQ7o6eu6+bhwHr9HCqyrYos86a1Q
	WCkxVADck/62adRlgcag2nvwyAhvxpSlq23JZ+Ks1flysAMlrMczKhVj
X-Gm-Gg: AR+sD11KXtg4zu74AqG8+OGVw49zxB/Ryx8jJuuSFD+NYlipNmKv1cbmnOsyU3szW89
	DQ++UtYfSh6osbheVBLmgOT7DfESA5oSazj41LJRFgmZ4A/74rvawZwo9z2TmifxJz23RkSwtJp
	Ty7u1jjZ0FwEQjBh8qBMJ7Ke3s7N+bSbQY48kttVp6W2jzUIkdZp3IiAmoDXPBW0M2Tg8N26+Xe
	LWS9axjBmfeLkymODAwTnXdB8Y+UZ/roS7pY/WU5YLEgrcve+yXvlcgNzyp6OTHj7rT7ORU6OYd
	MCo2FDbhStNgoCTQRibyqykg4PG8umOcko0C/tyErdL03o+dRlxE094nDCDvrhvu3dDAALtJ140
	8BjW3vw5ur0glYr0dE77H60F99OGqBpq5aQ6JhhAyItMXjb3VrGRHZmFuE9CMokpUqJzSaO0gFs
	WFkeUZ63abp+38tcPQ9waQ1tsPIrKxGd96uUO8bOSYVLaW523boSwLB4KAHq+Oq3zDq6iZH/a7q
	yH0Nmh9Y1MO7bi0atzvXGE=
X-Received: by 2002:a17:90a:100f:b0:396:40e6:f631 with SMTP id 98e67ed59e1d1-39640e6f6d9mr1017779a91.3.1787582824587;
        Mon, 24 Aug 2026 07:47:04 -0700 (PDT)
Received: from deepanshu.. ([2405:201:682f:383f:4cf4:9e7a:69d:2900])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141861732f8sm25774770c88.10.2026.08.24.07.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:47:01 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] eventfs: Initialize ei->children and ei->list in init_ei()
Date: Mon, 24 Aug 2026 20:16:53 +0530
Message-Id: <20260824144653.54044-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eventfs_create_events_dir() allocates the eventfs_inode via
alloc_root_ei(), but only calls INIT_LIST_HEAD() on ei->children
and ei->list after the tracefs_get_inode() check. If that check
fails, the code jumps to the fail label and calls cleanup_ei(),
which calls free_ei():

	WARN_ON_ONCE(!list_empty(&ei->children));

Since ei was allocated with kzalloc(), ei->children.next is NULL
at this point, not a self-referencing pointer. list_empty() checks
head->next == head, so it returns false on an uninitialized list
head, triggering a false-positive WARN_ON_ONCE() even though the
list was never used.

eventfs_create_dir() has the same latent issue: alloc_ei() is
called before INIT_LIST_HEAD(), leaving a window where an early
failure path could hit cleanup_ei() on an uninitialized list head.

Move the INIT_LIST_HEAD() calls into init_ei(), which is called
by both alloc_ei() and alloc_root_ei() immediately after
allocation. This guarantees every eventfs_inode has a valid,
self-linked, empty children/list the moment it is allocated,
regardless of which failure path runs afterward.

Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ef80b4ed02226d04a06
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/tracefs/event_inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 604ba3e841d2..6e3513b13cfa 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -438,6 +438,8 @@ static inline struct eventfs_inode *init_ei(struct eventfs_inode *ei, const char
 	if (!ei->name)
 		return NULL;
 	kref_init(&ei->kref);
+	INIT_LIST_HEAD(&ei->children);
+	INIT_LIST_HEAD(&ei->list);
 	return ei;
 }
 
@@ -729,8 +731,6 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	ei->entries = entries;
 	ei->nr_entries = size;
 	ei->data = data;
-	INIT_LIST_HEAD(&ei->children);
-	INIT_LIST_HEAD(&ei->list);
 
 	scoped_guard(mutex, &eventfs_mutex) {
 		if (!parent->is_freed)
@@ -802,9 +802,6 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	ei->attr.uid = uid;
 	ei->attr.gid = gid;
 
-	INIT_LIST_HEAD(&ei->children);
-	INIT_LIST_HEAD(&ei->list);
-
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
 	ti->private = ei;
-- 
2.34.1

