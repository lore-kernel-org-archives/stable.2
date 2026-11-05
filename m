Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793849937;
	b=NU2vyqGhkcg5wE8/ApfuHtGZXCC3kuSigHwBH0BE6NlQ9Enea6cUqNWx4NLxDp+PJSNI
	 kKFgsFMIk+RyvE+3pEAIX9Py37IvJrMnjttRQiXdeO9iOQhqQE/mTfus3ie65yQt41yCy
	 8Um57cTANtyxkC43Kz9hrZm3nHzvDzKxjFBXqvNxS3wkKyUHZT33F1VXGzz51ErxumX7t
	 NU3XxHKJObZINdGDWDmbp3hl+MywBqGseiG0tuhMOM1esXWIVKT8LxhLzABgv2HtxWPG2
	 uFKzK/sh6Ko01MTOXAI4EAJjUuTyYIxZSV91whoXjQyDAFF0L5ZL66rKD37av0ovFPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849937;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=0bmoyUkzdtIPwctA0XmmG4w/kO0aW9Vg8ocvhD7GQlc=;
	b=uGr+wr2UE2QsdQ9byApDsoqXl7zAvV4mOKC+eZl5gyjy9B1eHwvw1bdfKwai3uyfbrsL
	 rA45AHNZM59GgPTm1VTpxvJi/N0kh0D4W7sLIpRBi7z/DXgRuEsIo/EjirEI6i9Pd5b7e
	 EnWlxSYdYQjRg0lStvG75DykrPI3eIDgfdU9SQ63+zD40j1ZrRu/Y64Nn3aUaDs7SjM5m
	 uMxWVzX5JzqvEymgPOHKnwCddRLnfinxqPY04wgRcVQcyIHSrJQSrT/PF3Wf1lMf6rFD5
	 tpnnREvm32b2zYknPPcxdzVvvCr7BsdboKD6aEhsKyrDUnYoF9DJq7fypMyEMrTR8Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1Jcw5Wpz;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A566606A31B;
	Thu,  5 Nov 2026 03:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A566606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1Jcw5Wpz
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0bmoyUkzdtIPwctA0XmmG4w/kO0aW9Vg8ocvhD7GQlc=;
	b=1Jcw5Wpz9oyiDJnwHAnO6nFeSGMqx7+lZec58dnCFBOwO03z6VN/b/BceRX9zohVd3zL43jty
	lKXNUK5pvOr56UghyjTTBUYe3a6frRI6L9LD5rzdCJGRZ+9ue6Q3NdmNiwBL7k8Z1agGDhpAimm
	JmlA+VLVSRDPJ63aF/9v5Wg=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jKp246SDSznTVh;
	Thu,  5 Nov 2026 11:38:52 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D13540578;
	Thu,  5 Nov 2026 11:38:51 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 5 Nov 2026 11:38:50 +0800
Subject: Re: [PATCH] ubifs: account for short copies in ubifs_write_end
To: Hungyu Lin <dennylin0707@gmail.com>, <richard@nod.at>
CC: <lin.nan@h3c.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261104191132.89515-1-dennylin0707@gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <fb5c1cc4-d974-73ae-3b61-c0dc1363305a@huawei.com>
Date: Thu, 5 Nov 2026 11:38:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261104191132.89515-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemo200011.china.huawei.com (7.152.185.179)

ÔÚ 2026/11/5 3:11, Hungyu Lin Ð´µÀ:
> ubifs_write_end() updates i_size and ui_size to pos + len even when
> fewer bytes were copied. A one-byte write at EOF from an unreadable
> buffer can fail with EFAULT while extending the file by one byte.
> Partial writes can also extend the file past the last byte copied.
> 
> Use pos + copied for size updates and cancel the budget when no data
> was copied. Keep the appending decision based on the requested length
> to match the inode budgeting and ui_mutex locking in ubifs_write_begin().
> If a short copy ends within the old size, release any unused inode budget
> without reducing the size, and still unlock ui_mutex.
> 
> Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
> Link: https://lore.kernel.org/linux-mtd/20261027061226.3506517-1-lin.nan@h3c.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>   fs/ubifs/file.c | 29 +++++++++++++++++++----------
>   1 file changed, 19 insertions(+), 10 deletions(-)
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index 99dd52715ee..8ebd3f4cddf 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -523,8 +523,8 @@ static int ubifs_write_end(const struct kiocb *iocb,
>   	struct inode *inode = mapping->host;
>   	struct ubifs_inode *ui = ubifs_inode(inode);
>   	struct ubifs_info *c = inode->i_sb->s_fs_info;
> -	loff_t end_pos = pos + len;
> -	int appending = !!(end_pos > inode->i_size);
> +	loff_t end_pos = pos + copied;
> +	int appending = !!(pos + len > inode->i_size);
>   
>   	dbg_gen("ino %llu, pos %llu, pg %lu, len %u, copied %d, i_size %lld",
>   		inode->i_ino, pos, folio->index, len, copied, inode->i_size);
> @@ -552,6 +552,11 @@ static int ubifs_write_end(const struct kiocb *iocb,
>   		goto out;
>   	}
>   
> +	if (unlikely(!copied)) {
> +		cancel_budget(c, folio, ui, appending);
> +		goto out;
> +	}
> +
>   	if (len == folio_size(folio))
>   		folio_mark_uptodate(folio);
>   
> @@ -562,14 +567,18 @@ static int ubifs_write_end(const struct kiocb *iocb,
>   	}
>   
>   	if (appending) {
> -		i_size_write(inode, end_pos);
> -		ui->ui_size = end_pos;
> -		/*
> -		 * We do not set @I_DIRTY_PAGES (which means that
> -		 * the inode has dirty pages), this was done in
> -		 * filemap_dirty_folio().
> -		 */
> -		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
> +		if (end_pos > inode->i_size) {
> +			i_size_write(inode, end_pos);
> +			ui->ui_size = end_pos;
> +			/*
> +			 * We do not set @I_DIRTY_PAGES (which means that
> +			 * the inode has dirty pages), this was done in
> +			 * filemap_dirty_folio().
> +			 */
> +			__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
> +		} else if (!ui->dirty) {
> +			ubifs_release_dirty_inode_budget(c, ui);
> +		}
>   		ubifs_assert(c, mutex_is_locked(&ui->ui_mutex));
>   		mutex_unlock(&ui->ui_mutex);
>   	}
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> 

