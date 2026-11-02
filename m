Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586299;
	b=ubd2dW+7MNAisbzFvEcIgLAyLYF7uailmTY5Qp4a4j6TNejCnZwyi/mP22a91Yvkj6u8
	 TfZicIVKFbecGKwgbQRbFj8qW9VkLSF/84UT7DkXPHFbAjuR0dB8QHE3BTSknMsKiaiar
	 7nTXRZ5GUBnmISDpanPQH02KGRl7/Xb0yv9YLWtLqfTuzLOq7y/1kLijkawPP8EdkZcoi
	 6teCxJj+28bRKVlULCorWcm/qy5rUOmSU4kIAFf+Q7pc2kB3NA5A+826WYpimPSnsoEzA
	 FrI7qv+JI/aKHWQKvfM2FYioeYkRzuNyrhBTcpKWPyGZWOaARcp/985e/ahIn5JIBCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586299;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=2mnsyMY9o09dxT12b5diRUF6Cicg8w6KasRAQlIeI/I=;
	b=pz9Ou7uRC8KUtBbZ9DqUVAzrQsPUVSMm7bkY3qshAEkdkG78/W6KHQtsu1kf0giE5sIe
	 W13GLclYzOxm+A9BV498Bt56WzCUzPupxHsGDZ3H+LgPdSgOvTATuWF3RgcH6fJFFr90r
	 7iS8ZUHK3fz39gFW3byBuZpqS6HIdcT+/FXpeWvQN8SmABwBom6TIos27fJf3j6/Ew9Uc
	 bIq8A3MEbxct6KjZliLWXklLaQiHiuF5qdpk2dl6A+6w9XOzh2T/BnXb3tneT157Iz6xl
	 swK2+OYvaZfh/YQOxCf/DQZyo+l5xwGTCm+B8PczaNE9YYj69AaRKo7bkA9LkKzSeZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RddVEMc0;
	arc=none smtp.remote-ip=91.218.175.87
Received: from mta0.migadu.com (out-87.mta0.migadu.com [91.218.175.87])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744F606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 02:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E744F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RddVEMc0
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9MWJaTq44xn+tvTxU7mQ3vu6AIJLcPaBU+1NzYl4ghk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793586296; v=1; x=1794191096;
 b=RddVEMc0Nc6NAvlP05NTHE/hYX6XO7jCA5N64VxWF8G/+V12NHaXseYCOduZ0SctWX3A7uDu
 L+u9fua1pQ5u2i6+Vm7RredncvQPNGs4PAdTii9cVvi5XHeCVlBVbfXRwIe4gik+HI9JdH4yyKr
 KjWpVYrcR93TY51p6/OHadUw=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 112a86c3f0c26040;
	Mon, 02 Nov 2026 02:24:56 +0000
X-Mizu-Trace-ID: 112a86c3f0c26040
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v3] hugetlbfs: move hugetlbfs_free_inode tracepoint to
 ->destroy_inode()
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261101-b4-hugetlbfs-trace-v3-1-051b716f490f@gmail.com>
Date: Mon, 2 Nov 2026 10:24:38 +0800
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
Message-Id: <6FC96012-76AA-483B-BDA4-8E1C1ABB5FFE@linux.dev>
References: <20261101-b4-hugetlbfs-trace-v3-1-051b716f490f@gmail.com>
To: joasantonio108@gmail.com
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 1, 2026, at 21:48, Joas Antonio dos Santos via B4 Relay =
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
> Since the event no longer fires from ->free_inode(), rename it to
> hugetlbfs_destroy_inode so that its name matches where it is emitted,
> as suggested by David and Muchun.
>=20
> Found by syzbot; analysed and tested with the syzbot C reproducer on =
an
> arm64 KASAN kernel.
>=20
> Fixes: 014ad7c42a69 ("hugetlbfs: use tracepoints in hugetlbfs =
functions.")
> Reported-by: syzbot+91e1fc35f51774c479b2@syzkaller.appspotmail.com
> Closes: =
https://lore.kernel.org/all/6ae27525.5451848c.f7707.0001.GAE@google.com/
> Suggested-by: David Hildenbrand <david@kernel.org>
> Suggested-by: Muchun Song <muchun.song@linux.dev>
> Cc: stable@vger.kernel.org
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> ---
> Andrew, this replaces
> hugetlbfs-emit-hugetlbfs_free_inode-from-destroy_inode.patch in
> mm-hotfixes-unstable.
>=20
> Tested with the syzbot C reproducer (adjusted for the new event name)
> on an arm64 KASAN kernel: no splat in 3 of 3 boots, and
> hugetlbfs_destroy_inode events are recorded.
>=20
> Tool-use note: the analysis and testing were done with help from an
> LLM-based assistant; I reviewed the change and ran the tests myself.
> ---
> Changes in v3:
> - Rename the tracepoint to hugetlbfs_destroy_inode in the same patch,
>  so its name matches where it now fires (David, Muchun).
> - v2 was the resend with the Assisted-by trailer dropped; it should
>  have been marked v2 in the subject, sorry about that.
> - Link to v2: =
https://lore.kernel.org/r/20261031-b4-hugetlbfs-trace-v1-1-4ec8d02a30cc@gm=
ail.com
> ---
> fs/hugetlbfs/inode.c             | 6 +++++-
> include/trace/events/hugetlbfs.h | 2 +-
> 2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 01c4d6f44e..095b7fceee 100644
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

Since the trace point name has already been changed, the comment here
doesn't seem to serve much purpose anymore, as there isn't any =
ambiguity.

With the comment removed:

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.

> +	trace_hugetlbfs_destroy_inode(inode);
> 	hugetlbfs_inc_free_inodes(HUGETLBFS_SB(inode->i_sb));
> }
>=20
> diff --git a/include/trace/events/hugetlbfs.h =
b/include/trace/events/hugetlbfs.h
> index 8ba72c1d4f..a7932e0db0 100644
> --- a/include/trace/events/hugetlbfs.h
> +++ b/include/trace/events/hugetlbfs.h
> @@ -72,7 +72,7 @@ DEFINE_EVENT(hugetlbfs__inode, =
hugetlbfs_evict_inode,
> 	TP_ARGS(inode)
> );
>=20
> -DEFINE_EVENT(hugetlbfs__inode, hugetlbfs_free_inode,
> +DEFINE_EVENT(hugetlbfs__inode, hugetlbfs_destroy_inode,
>=20
> 	TP_PROTO(struct inode *inode),
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

