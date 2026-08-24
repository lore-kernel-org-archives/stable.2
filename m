Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF843D4FD;
	Mon, 24 Aug 2026 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583843; cv=none; b=H5fl5hEOh5yDHQAeKDKUCCx/nwpAVpY2aybLgmcE3AbDJqIvLlyUGWymvJBzYgedKL079L/iKlRHMQr0sw5oXyCL1xQ5QYJQqua2wyOLAb8Q0b3/dlpparxEu8FOn7ckqmkOM1/aU5x4oOWOGZBuo+XBBkq3C4pMFXsDbhy4VVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583843; c=relaxed/simple;
	bh=3kDfp4QRIWaZVlLhRqrca4VNvcEtddHyUL9aMfPUzts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nx51v7aqf60VxB0fJE6RbA+jhK8doVQE0C92AVTCyV/WL2m4y3ZHadnXqSXqX3oMg/mV9GeXOU6dh4f4qnVJWLjeWSbtyHi5yzPvp9tOYfZoeyzHoxzX3go8b9LzostP/EBD4m6aJy8ludffVLJrr0JXXWN+j3E3CQd+I5Ez88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Mq/fR1Z6; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Mq/fR1Z6"
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 838C512017A;
	Mon, 24 Aug 2026 15:03:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 5C44F2000E;
	Mon, 24 Aug 2026 15:03:47 +0000 (UTC)
Date: Mon, 24 Aug 2026 11:03:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] eventfs: Initialize ei->children and ei->list in
 init_ei()
Message-ID: <20260824110345.22c1cfa1@fedora>
In-Reply-To: <20260824144653.54044-1-kartikey406@gmail.com>
References: <20260824144653.54044-1-kartikey406@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5C44F2000E
X-Stat-Signature: pfkamjb1ca6m7648ddkcb93r1aargk79
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19noBFiXGuJ8r+gHbDs44EKL76xg+eEasE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Pix3je5n0eSam59T6j1O1iBmCSDrhK1scCKfUIa8upA=; b=Mq/fR1Z685uK8A5I+7Dvcus+LkgGSKoFeO1cj3aW4EhOtxjR5t+ED20Q50iaxILBePlsuKGA5owWXuOZ1SLVkeLPSqpNExDrSBs8rUypcSYCsVmdukIu9iX/DgDpTHcl3JJ+qWBM89HuzKzetxlFRS/Ao+ZGccsFnP+S0R9T2QA=
X-HE-Tag: 1787583827-522272
X-HE-Meta: U2FsdGVkX19XOevH3L+XpTp3qDrnv29ojfi9CziKLOOjz4cOVyX8+ytvg+Y1W1jT+aieTF6nSOczcv4hCp8JdCeOjnq0KUyKuCzYOObbgKj/87Nzuf6flS2y0NFUem/UgcuVY31DrNpFk3xNAXNfLnMojKjxFqdEU8gFjKAAzTXh1tD/1WRKEA3XmQHvMN12tsVBME3bMOCNA9MuEZmQ5KwBUGMy4Fr5rE8oNW5v548YvpnSRgzCxXcvKVZmRiQCssUDZjnJx6xf9hdJFyHkjKH4HuOIQtcvkw70YzMr4sduoILvValHMVqOb2HZ5W81dqqvAsIDPBT6xZFclKsTomK75Wr3MmXoicruImzNbZdD0u6N1thApYJLQR8okhFDg/ZMUVao42sBpDuCfyxZe3sKcM/OZzfDMOS7kOB4WGIZaLF1OBrE/ft4fZo3JzYH8aVEkwI3QDISyFELvHERU2tPdoSm2VIR9hf8M0yEh1c=

On Mon, 24 Aug 2026 20:16:53 +0530
Deepanshu Kartikey <kartikey406@gmail.com> wrote:

Yeah, I saw the syzbot report and came up immediately with this fix as
well. But the change log is way too verbose for such a simple fix. Did
you use AI for this patch? If so, you must divulge that information,
usually with a tag.

> eventfs_create_events_dir() allocates the eventfs_inode via
> alloc_root_ei(), but only calls INIT_LIST_HEAD() on ei->children
> and ei->list after the tracefs_get_inode() check. If that check
> fails, the code jumps to the fail label and calls cleanup_ei(),
> which calls free_ei():
> 
> 	WARN_ON_ONCE(!list_empty(&ei->children));
> 
> Since ei was allocated with kzalloc(), ei->children.next is NULL
> at this point, not a self-referencing pointer. list_empty() checks
> head->next == head, so it returns false on an uninitialized list
> head, triggering a false-positive WARN_ON_ONCE() even though the
> list was never used.
> 
> eventfs_create_dir() has the same latent issue: alloc_ei() is
> called before INIT_LIST_HEAD(), leaving a window where an early
> failure path could hit cleanup_ei() on an uninitialized list head.
> 
> Move the INIT_LIST_HEAD() calls into init_ei(), which is called
> by both alloc_ei() and alloc_root_ei() immediately after
> allocation. This guarantees every eventfs_inode has a valid,
> self-linked, empty children/list the moment it is allocated,
> regardless of which failure path runs afterward.

The change log only needs to say:

  eventfs_create_dir() allocates the eventfs_inode and initializes it
  with init_ei(). But this does not initialize the eventfs_inode
  list_heads. If the eventfs_create_dir() fails due to memory pressure,
  it will call free_ei() which checks to make sure the eventfs_inode
  has no children. But because the list wasn't initialized, it will
  give a false warning.

  Fix it by moving the list initialization into init_ei().

See, much better. Right to the point without all the AI slop.

I'll take your patch, but I'm replacing the commit log with the above.

-- Steve


> 
> Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
> Reported-by: syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3ef80b4ed02226d04a06
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/tracefs/event_inode.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 604ba3e841d2..6e3513b13cfa 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -438,6 +438,8 @@ static inline struct eventfs_inode *init_ei(struct eventfs_inode *ei, const char
>  	if (!ei->name)
>  		return NULL;
>  	kref_init(&ei->kref);
> +	INIT_LIST_HEAD(&ei->children);
> +	INIT_LIST_HEAD(&ei->list);
>  	return ei;
>  }
>  
> @@ -729,8 +731,6 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
>  	ei->entries = entries;
>  	ei->nr_entries = size;
>  	ei->data = data;
> -	INIT_LIST_HEAD(&ei->children);
> -	INIT_LIST_HEAD(&ei->list);
>  
>  	scoped_guard(mutex, &eventfs_mutex) {
>  		if (!parent->is_freed)
> @@ -802,9 +802,6 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>  	ei->attr.uid = uid;
>  	ei->attr.gid = gid;
>  
> -	INIT_LIST_HEAD(&ei->children);
> -	INIT_LIST_HEAD(&ei->list);
> -
>  	ti = get_tracefs(inode);
>  	ti->flags |= TRACEFS_EVENT_INODE;
>  	ti->private = ei;

