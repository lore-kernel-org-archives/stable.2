Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792727619;
	b=lbfrB3ltbub1gqZwFVi2f+qn38IeIDXYPjoYYt5yE/P2E2qw6KR0LJ3VQWFRwgnW57LY
	 Ram/kukUIkX+DwP1kwB7fT7aNaDLJz/dIsMVe9ecsR4oW6NL5Fq/K8UICjIDnTTQRyRNT
	 2sx0evzanoUx5RIl11UnjUdxYkK6Fekvq+7rVizqSvFfrxqRGMWxvAg+Dr+6kBSDncyoC
	 2XQ+55Xochy38m3MIJ9pBGGae/I/H1WAhQ44Q7hl1Yk5lWV3j7VpEf62K7j59ygcoq3QP
	 cL2zrSSOmmp0hhltaOq9I7Q6fR1HfruaDlgoMFZtaEXlb4hBRfoLog/RFvioBs1nP+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792727619;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=00chgJ5vuSlYKjU0FZpFNh0WM82ZVpBLb1f1nlA8X3g=;
	b=J9qSsjCNr52F0Dij+6yiKFh6fE8JlySqWOU97wTywCMRBhfo/PFwWM6S3OJAY7wDX36w
	 vsQX4U0H1F6Nvoe6eFisLNafikTQyVHyXLEZ65M+kTTVwlngiqKV3g6Vp4OVExltHhqG4
	 H19qmp6c0GDNmzMdKXSr3Ht7HcPpX3Kn1wy+t1GcDEdOx9ESjxkZvvmXtdAjt8OoDlRd/
	 PPk0DaMS67NtvlTUhO66n/Y1RdEvIwy5erzQpJNL8+1AYSpKZ2T7TRDrET5V7Te3pYwaK
	 Av+tvJRt5DlQ+EKPz9t+FW3UAVusIvF0II+kxW9BOkGS3zOo/rnpfg/kOo0SrMZN4sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AHAonRpB;
	arc=none smtp.remote-ip=115.124.30.99
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF3606A319;
	Fri, 23 Oct 2026 03:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDFF3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AHAonRpB
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792727613; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=00chgJ5vuSlYKjU0FZpFNh0WM82ZVpBLb1f1nlA8X3g=;
	b=AHAonRpBk+785hakRAshlMEJkbWATgNaYiIIpS7X6eYgFtOSBzspYxEWagX8sw44H/imBbsUx8DpRAXoNfGaq1q5MTJA+81MiYftHiujC95O+P8LPwYy5P9o0lGsslKI2Iw7dsyaa6d9uEmyGBuqZ2hhqHTAULT60xQbv12O/JE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XDKtBj7_1792727611;
Received: from 30.221.129.69(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XDKtBj7_1792727611 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 11:53:32 +0800
Message-ID: <8b746b1c-4647-4f88-acc7-6f91eedb2f2d@linux.alibaba.com>
Date: Fri, 23 Oct 2026 11:53:31 +0800
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
Subject: Re: [PATCH v4 2/2] ocfs2: snapshot the dentry name while tracing file
 release
To: Cen Zhang <zzzccc427@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: mark@fasheh.com, jlbec@evilplan.org, heming.zhao@suse.com,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
References: <pm-ocfs2-objects-candidate-0088-v7-6324344256f0c3b1c3d8-0@gmail.com>
 <pm-ocfs2-objects-candidate-0088-v7-6324344256f0c3b1c3d8-2@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <pm-ocfs2-objects-candidate-0088-v7-6324344256f0c3b1c3d8-2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/26 5:08 PM, Cen Zhang wrote:
> ocfs2_file_release() passes the live dentry name and length to a trace
> event while holding oi->ip_lock. This lock protects the open count and
> delays RCU reclamation of external names, but it does not serialize name
> changes during rename. The dentry can switch between inline and external
> names, and a separately loaded length can describe a different name.
> 
> The ocfs2__file_ops event sizes and copies its __string separately.
> A concurrently rewritten inline name need not remain consistent between
> those operations. External names can also be selected at this call site;
> the existing spinlock critical section protects their allocation lifetime,
> while a snapshot additionally pairs a stable name with its length.
> 
> Take a name snapshot before acquiring oi->ip_lock and release it after
> dropping the lock. Keep the trace call and open-count argument inside
> the original critical section. Cache the event-enabled check so the
> snapshot stays paired even if tracing is toggled meanwhile.
> 
> Fixes: 468eedde23d6 ("ocfs2: Remove mlog(0) from fs/ocfs2/file.c")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/file.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index c6e7606ff9e1..b3a37b9d259a 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -141,18 +141,26 @@ leave:
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

