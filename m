Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584582;
	b=pCY35wt6jxbf2HUKrRw/WMYJ5Ecu3TZHLCB0svQpfh+0i1J6xcgOJttYgNmai0p6lX/7
	 oilOYUmlENX/+mB33ZR0gpM50Fp3Sd0bFw6nEOUTM8XYTRLgBRsdht/eqYMk17oH+TdC+
	 ++GQs0ZDe83BGON6J4FgdyIgSBsH6vjXrVXHCN+V2a9tlfsaWNDy90G82Mg93Jn4NCeeP
	 kVYO4uGweY8NojQzVzgV3fPIQbBTjsnpU/IItYCKW0r9vhb+6ThOqM8tEbLxDgN/C7cou
	 sV//xw9nWqW+hMgMdzb5SNxQMH49pVpRGbHQrvWXDaQTByU7kb4iXLkHKTzwDHT7CRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584582;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=fpaUbVWzvsD3+MWcfURM1zpWhPpY+ZQz7TbJGajFjyI=;
	b=qU3453ULFIeRzl2jY6bkAdU4s9ipFcMwCCjXVO3U5NAt0Z6ysD56OYdvQ0BroSQ7K/Gy
	 S7L2rJMa5Y4qnUyQ3BCjv35xlE66EtooYqXKgEFyKs44hUIV2cPkI8xEJ3C62T3oIuqIb
	 sP87qbByOyjF6W4jAbQjSBhGIWZ+5Dr4ske0uoSTeLBXJ/NOgy2R4LZm8bD1Li0VbsZEG
	 8ZbfeWn5Goa+XBI52yljl9uwbCb07aUJ11gDAOhhGRflFdxfpgiSX4M7SwGHq35gW7QQW
	 qROiVKdf6Z0M+NQnDK1p0XBlKcZj3nFmKoW1FZr+2vPeYssAz2wvJOSJvjLFPuQ75JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="luGa/ZH7";
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B6606A31B;
	Wed, 21 Oct 2026 12:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 235B6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=luGa/ZH7
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792584577; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fpaUbVWzvsD3+MWcfURM1zpWhPpY+ZQz7TbJGajFjyI=;
	b=luGa/ZH7NcpnDMX7GLKHyk+PxEKlIm+yj0leyl1lt5Ud+5YCkDaZGi5SsycqySXM3CwYSTs3c5Uf1eHYE8uwI3hGwdmP2Jjtao66B0pp88vU8inUvfZPIXxzt0pdaD8knyQKPxQcBnAszrcjF04dIq1hkd+Njmh+fQGHkmz1JVM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDGHcjg_1792584576;
Received: from 30.221.149.139(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XDGHcjg_1792584576 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 Oct 2026 20:09:36 +0800
Message-ID: <253fa66a-c29b-48b8-943d-600853a712e2@linux.alibaba.com>
Date: Wed, 21 Oct 2026 20:09:36 +0800
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
Subject: Re: [PATCH v3 2/2] ocfs2: snapshot the dentry name while tracing file
 release
To: Cen Zhang <zzzccc427@gmail.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, heming.zhao@suse.com,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
References: <pm-ocfs2-objects-candidate-0088-v6-d3056754af7e660155d9-0@gmail.com>
 <pm-ocfs2-objects-candidate-0088-v6-d3056754af7e660155d9-2@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <pm-ocfs2-objects-candidate-0088-v6-d3056754af7e660155d9-2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/20/26 11:43 AM, Cen Zhang wrote:
> ocfs2_file_release() passes the live dentry name and length to a
> trace event while holding oi->ip_lock. That lock protects the open
> count, but it does not serialize dentry name changes during rename.
> The ocfs2__file_ops event sizes and copies its __string separately,
> so a concurrently rewritten inline name need not remain consistent

This call site can reach the external name case too, which is the same
UAF the PATCH 1 of the series describes.

Thanks,
Joseph

> between those operations. The separately loaded length may also
> describe a different name.
> 
>   Release trace                        Renamer
>   -------------                        -------
>   hold oi->ip_lock
>   size the inline name
>                                        rewrite the inline name
>                                        under dentry->d_lock
>   copy the changed name
> 
> Take a name snapshot before acquiring oi->ip_lock and release it
> after dropping the lock. Keep the trace call and open-count argument
> inside the original critical section. Cache the event-enabled check
> so the snapshot is paired even if tracing is toggled meanwhile.
> The snapshot keeps the trace name stable without extending the
> inode lock over snapshot acquisition.
> 
> Fixes: 468eedde23d6 ("ocfs2: Remove mlog(0) from fs/ocfs2/file.c")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  fs/ocfs2/file.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index 3c4637b32c09..8da73d0707ce 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -141,18 +141,26 @@ static int ocfs2_file_open(struct inode *inode, struct file *file)
>  static int ocfs2_file_release(struct inode *inode, struct file *file)
>  {
>  	struct ocfs2_inode_info *oi = OCFS2_I(inode);
> +	struct dentry *dentry = file->f_path.dentry;
> +	struct name_snapshot name;
> +	bool trace_enabled = trace_ocfs2_file_release_enabled();
> +
> +	if (trace_enabled)
> +		take_dentry_name_snapshot(&name, dentry);
>  
>  	spin_lock(&oi->ip_lock);
>  	if (!--oi->ip_open_count)
>  		oi->ip_flags &= ~OCFS2_INODE_OPEN_DIRECT;
>  
> -	trace_ocfs2_file_release(inode, file, file->f_path.dentry,
> -				 oi->ip_blkno,
> -				 file->f_path.dentry->d_name.len,
> -				 file->f_path.dentry->d_name.name,
> -				 oi->ip_open_count);
> +	if (trace_enabled)
> +		trace_ocfs2_file_release(inode, file, dentry,
> +					 oi->ip_blkno, name.name.len,
> +					 name.name.name, oi->ip_open_count);
>  	spin_unlock(&oi->ip_lock);
>  
> +	if (trace_enabled)
> +		release_dentry_name_snapshot(&name);
> +
>  	ocfs2_free_file_private(inode, file);
>  
>  	return 0;

