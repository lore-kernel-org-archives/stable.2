Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.91
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502824;
	b=vxsVr6xxzSjOtnn1Lms9cT7TwDqc3At0LNTppBJ6RIAKZzyc6uj1hZmRP9aaDmcSGMA5
	 wzCE0AYFcyzC8elFcc6Gf/RZMYzhAAEw3BUycHsbAvM/WCx9AmhQn+nLvwHuXjlS05Lob
	 POWEeahNjQwQ/XptinnxbO76HkmIDyCXxVM8dhymShXzyxU0aAiopuA5EF+OtiEGiQO/U
	 bkeuDBuVZxQDinWozW2SmuTjDb/lb9zIalyznWlUhS0ND008KfXCZk9LTsonNR+icRPEy
	 b8+a3YdoyFY6laD59CTBqNqzi66VsorGSa9dEfZlR7h/Q/CwMWOmS1hyu/KqTwOBdAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502824;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=G2Sq0gLLsHldeSIR+epke8YlRr21X/+4SzZkJoBo7gY=;
	b=nyQDDCj2bFfEBHWQ76IV108KnK+mJZRMSgLl+W+QgYk8IKCerobcTaXPZpK48jm8UQyJ
	 ro/1Z/eY0KpVQ75TYC8MmUbnb2jfDpn8n853Thnkt60HdgZwbxULkx+++G2dfWv6+JgP1
	 8oqBS18T4imVzZ4I+7WyNTCBXhpHX3/Nc5usZta7gUs1f26dFVzCaatZ4sZLJCx6ylM7a
	 UbWwct+hMPpXQLfE0AvL1zHkQdEWk+EJFiT8piAcQHZxlZyt0fr6gdbdxUwbo/t5zu1I/
	 tmtDzcn3DYd0Hx670UB/RWZj9KqC/cGHfTyjgQq1e7SKcJUzILYn/eR0EZ1fBLDCtnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="b6R/J3oD";
	arc=none smtp.remote-ip=95.215.58.91
Received: from mta1.migadu.com (out-91.mta1.migadu.com [95.215.58.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B19606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 03:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7B19606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=b6R/J3oD
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9EHwrI8bkAWMARTdLxi0cB28WQ9c8LLtlAJzoaChO84=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793502820; v=1; x=1794107620;
 b=b6R/J3oD9Mt3LlXnLwajFd7+WOQcAce4m3j5KWvdNrmex1E9nerZkVONXfReFMeOrmqWIbQg
 A95yHdAEN0hc45oeIJiicazdWnGLlXXXymdhpsjdI0Ik3/Q48hH/mnCxYMG3Im21SCIrtyQ0CxO
 4ic5vh+KRpfcmwO0mpL0fMX8=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id a030bda49eede247;
	Sun, 01 Nov 2026 03:13:40 +0000
X-Mizu-Trace-ID: a030bda49eede247
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH] hugetlbfs: emit hugetlbfs_free_inode from
 ->destroy_inode()
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261031-b4-hugetlbfs-trace-v1-1-4ec8d02a30cc@gmail.com>
Date: Sun, 1 Nov 2026 11:13:18 +0800
Cc: Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Hongbo Li <lihongbo22@huawei.com>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+91e1fc35f51774c479b2@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ADB13A93-9C2E-4136-B639-742069AF74D6@linux.dev>
References: <20261031-b4-hugetlbfs-trace-v1-1-4ec8d02a30cc@gmail.com>
To: joasantonio108@gmail.com
X-Mailer: Apple Mail (2.3901.100.1.1.12)

This is the V2 version. you should specify it in your subject line =
prefix.

> On Nov 1, 2026, at 00:06, Joas Antonio dos Santos via B4 Relay =
<devnull+joasantonio108.gmail.com@kernel.org> wrote:
>=20
> From: Joas Antonio dos Santos <joasantonio108@gmail.com>
>=20
> hugetlbfs_free_inode() calls trace_hugetlbfs_free_inode(), and the
> hugetlbfs__inode event class records inode->i_sb->s_dev.  =
->free_inode()
> runs from an RCU callback (destroy_inode() queues i_callback() with
> call_rcu()), and Documentation/filesystems/porting.rst says that this
> callback "is *NOT* ordered wrt superblock destruction; as the matter =
of
> fact, the superblock and all associated structures might be already
> gone".  put_super() frees the superblock with call_rcu() followed by a
> workqueue item (destroy_super_rcu() -> destroy_super_work()).  syzbot
> hit this with the event enabled:
>=20
>  BUG: KASAN: slab-use-after-free in =
trace_event_raw_event_hugetlbfs__inode+0x45b/0x4c0 =
include/trace/events/hugetlbfs.h:36
>  Read of size 4 at addr ffff888038850010 by task syz-executor952/6134
>   hugetlbfs_free_inode+0x15e/0x1f0 fs/hugetlbfs/inode.c:1182
>   i_callback+0x46/0x80 fs/inode.c:317
>   rcu_do_batch kernel/rcu/tree.c:2650 [inline]
>   rcu_core+0x5f0/0x1220 kernel/rcu/tree.c:2919
>  Allocated by task 6134:
>   alloc_super fs/super.c:326 [inline]
>   sget_fc+0x1ba/0x1f60 fs/super.c:874
>   hugetlbfs_get_tree+0x1e7/0x2b0 fs/hugetlbfs/inode.c:1431
>  Freed by task 855:
>   kfree+0x22b/0x6d0 mm/slub.c:6923
>   process_one_work+0xac7/0x1b10 kernel/workqueue.c:3495
>=20
> Emit the event from hugetlbfs_destroy_inode() instead.  =
destroy_inode()
> calls ->destroy_inode() synchronously, before it queues the RCU
> callback, while the superblock is still alive; =
hugetlbfs_destroy_inode()
> already dereferences inode->i_sb there.  ->free_inode() is left with
> only the kmem_cache_free().
>=20
> Fixes: 014ad7c42a69 ("hugetlbfs: use tracepoints in hugetlbfs =
functions.")
> Reported-by: syzbot+91e1fc35f51774c479b2@syzkaller.appspotmail.com
> Closes: =
https://lore.kernel.org/all/6ae27525.5451848c.f7707.0001.GAE@google.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> ---
> Resend: my mail provider blocked the original submission to the lists
> on 2026-10-29, so only the direct recipients got it. No change to the
> patch, except dropping a deprecated Assisted-by trailer.
>=20
> David asked whether the tracepoint should be renamed now that it no
> longer fires from ->free_inode(). I'd keep this patch as is, since it
> is tagged for stable and the event name is visible in tracefs
> (events/hugetlbfs/hugetlbfs_free_inode); renaming it in stable kernels
> would break existing tracing setups just to fix the use-after-free. I
> can send a follow-up for mm-unstable that renames it to
> hugetlbfs_destroy_inode, next to hugetlbfs_evict_inode, or fold the
> rename into a v2 if preferred.

At least for me, I think we should rename it, and it belongs to the fix
itself. Otherwise, we will introduce another behavior change, someone
thinks the tracepoint is fired through free_inode callback, but it's
not, it's weird.

Thanks,
Muchun

>=20
> Tested with the syzbot C reproducer on a KASAN kernel with the event
> enabled: the use-after-free reproduced in 3 of 3 boots without the
> patch and in none of 12 runs with it, and the event is still emitted.
>=20
> Tool-use note: the analysis and testing were done with help from an
> LLM-based assistant; I reviewed the change and ran the tests myself.
> ---
> fs/hugetlbfs/inode.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 01c4d6f44..5bd348288 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1179,12 +1179,16 @@ static struct inode =
*hugetlbfs_alloc_inode(struct super_block *sb)
>=20
> static void hugetlbfs_free_inode(struct inode *inode)
> {
> -	trace_hugetlbfs_free_inode(inode);
> 	kmem_cache_free(hugetlbfs_inode_cachep, HUGETLBFS_I(inode));
> }
>=20
> static void hugetlbfs_destroy_inode(struct inode *inode)
> {
> +	/*
> +	 * Not in ->free_inode(): that runs from an RCU callback, when =
the
> +	 * superblock the event reads may already be freed.
> +	 */
> +	trace_hugetlbfs_free_inode(inode);
> 	hugetlbfs_inc_free_inodes(HUGETLBFS_SB(inode->i_sb));
> }
>=20
>=20
> ---
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> change-id: 20261031-b4-hugetlbfs-trace-341b338ab57b
>=20
> Best regards,
> --=20
> Joas Antonio dos Santos <joasantonio108@gmail.com>
>=20
>=20

