Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497920;
	b=e4UojtnesfGYPlQNobF2jLmRpdvCGdY5JezZCiPNhy+mhwLKZxENMZkaZixfqmVG+Yfo
	 ouCvph2I6PBWDWS+PKKQEZ2XeIdBPsWXjgHWDVebfUy3uUhcw1Qirpeu6eLUMMG8zEwg4
	 BRZFqAFZoJYXdSq09lENpvJbBLUOkuqBhgkVKG217xQFfv5w5ERmujuSE31p/kTSlZITA
	 8uOmbVmr2Oyxza5ZgRmqy+sV4++s97qoq4AKnGZ2vBRz+RTG1/+pdFA7vnz3iy3r0/U+k
	 pibfP3zjGbtS7wL9hnOkja83lnWlLTe1yjVqVTDT7RWg/F3AyunFLqzFB9QxVad+4Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497920;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=037It5JgAOu4z9VMKcMbYkeaMZRVptrSOJrPIu7UqgY=;
	b=B2r1VdN7n4oUjFpske6Hz+puIJhXhNg5Tnw5BF1nrDI4+D/HWqlrK/6QAuX6jE2hFULT
	 y4ulB5sE3bDtO84nnWIF+XYZTS1EH40ZIhaRuBZUfVRHsMp8lZN2LY5L2LdqdIMVA38iI
	 chro82c0QH6fr+TY7a3nSDedazVxs/OwL0FBLzzqwJfnofcVrn3uiN4V/PrXhpH3uTp5t
	 0GQJO+clH7QIrwYLjFxbSxA84fj/v53zBNEOfZlbSF+MSa8esqR+N/w9cqsBA3+ShYRwe
	 pr4JwuxO3zChGjuohYcF0oKfEctxwiSrpZ1ppCaX2uc3Tl8OD2b0QbZl6IGf/skbc2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NApZQGOH;
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC500606A31E;
	Tue, 20 Oct 2026 12:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC500606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NApZQGOH
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792497916; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=037It5JgAOu4z9VMKcMbYkeaMZRVptrSOJrPIu7UqgY=;
	b=NApZQGOHBBTy9cGr4Nsiq6EF2M0qrLExdlkDTU0Pz/32rncqOj1cXGH88zGdTPN1jNgnbz0AXanQUoQaRdyfeym79X3Q8qwo1gIwGUSyKOAo4+SvmcNT13BfsaW1IDSP5zOOU5/9FUkDgx5q0S3+Vw4DliZ5RIboI6Vjrr8Wbe0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDDJQnq_1792497915;
Received: from 30.221.145.25(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XDDJQnq_1792497915 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 20:05:15 +0800
Message-ID: <018d8feb-2e63-4a73-ba36-10a5f94f3341@linux.alibaba.com>
Date: Tue, 20 Oct 2026 20:05:14 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: Cache the mount context for dentry lock
 callbacks
To: Cen Zhang <zzzccc427@gmail.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, heming.zhao@suse.com,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
References: <pm-ocfs2-objects-candidate-0012-v6-17b58652a3505eeecb0c@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <pm-ocfs2-objects-candidate-0012-v6-17b58652a3505eeecb0c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/19/26 9:49 PM, Cen Zhang wrote:
> ocfs2_drop_dentry_lock() drops the inode reference before releasing the
> DENTRY lock. This lets inode eviction release the local inode and open
> locks before a remote unlink can proceed past the DENTRY lock.
> 
> A DLM callback can still arrive before the DENTRY lock has been dropped.
> ocfs2_get_dentry_osb() obtains the mount context through dl_inode->i_sb,
> which can access a freed inode when the downconvert thread drops the
> last inode reference in its post-unlock callback:
> 
>   Downconvert thread                     DLM callback thread
>   ------------------                     -------------------
>   ocfs2_process_blocked_lock()
>     ocfs2_dentry_post_unlock()
>       ocfs2_dentry_lock_put()
>         ocfs2_drop_dentry_lock()
>           iput(dl->dl_inode)
>           [inode reclaimed after RCU]
>                                          ocfs2_blocking_ast()
>                                            ocfs2_get_dentry_osb()
>                                              dl->dl_inode->i_sb
>           ocfs2_simple_drop_lockres()
> 
> Store the mount context in the DENTRY lock resource's l_priv field and
> use the default mount-context lookup. Recover the containing dentry
> lock with container_of(), as already done for refcount locks, and remove
> ocfs2_get_dentry_osb(). ocfs2_dismount_volume() shuts down the DLM before
> freeing the mount context, so callbacks can use it without accessing the
> inode. Preserve the existing iput-before-unlock order to avoid delaying
> local inode and open lock release until after the DENTRY lock is released.
> 

ocfs2_dentry_convert_worker() still reaches the inode via
OCFS2_I(dl->dl_inode) and writes oi->ip_flags |= OCFS2_INODE_MAYBE_ORPHANED
before its OCFS2_LOCK_FREEING/dl_count guard, and ocfs2_unblock_lock()
invokes the worker without testing OCFS2_LOCK_FREEING.

Thanks,
Joseph
