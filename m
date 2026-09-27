Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C522641C2FB;
	Sun, 27 Sep 2026 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790527065; cv=none; b=jFkmoYOHX+THMjg3tHi/JYgRWMLR5lEIApt3Rl9w6XE3vwla/HEjQ7jANiNPtrEiCqqhwXT0jZfGWd43n3Inb9q70f512y2DdQqc53soTw+M9QvVQB26Gb6DYSk9E1ClR5ybonlhOIy00H2tciv1VFWmqJNZJOTDWC+XsfHAf8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790527065; c=relaxed/simple;
	bh=M/NFzj8OEFrNGPQuuo4fGjDtu5l7gJnd8bMxL+lqVeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2J02jfaNCu6NXwPDqv+BrTqD4tEy3JgvF9MdPTLOJHqZwVuuffrubiU4ymc9aA4lwAhOXVMUdZsOZ2vCFDJjl2mWpAen2bo8B2/HnkbkANhqXidKs/jFuSRmrn5sasxefVvfZiOjvp3WCW0+ru1/hq6fCoHXLPS2Pq79yZ5foY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tGe7M+PN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tGe7M+PN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1862A1F000FF;
	Sun, 27 Sep 2026 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790527062;
	bh=1AWgvTM+pZyE6W5mmvnna6CoVJIc9soTBPvNd+0KX7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tGe7M+PNSOwmicDEoEp1ZZdlvKdW9wWXG9qUznp7c/T82LcMw7F04m04YMJSwQMMr
	 qufm2LElMfz3UnVxa7ivTB3ilxXRUV6UmJelwts93Fy7/dFeLZ4QTYhN/0ZjB7eeSl
	 KpGHhZaqlG60mgJxQoIGWV9nkEH5+P6N1bl578Mk=
Date: Sun, 27 Sep 2026 18:37:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: rafael@kernel.org, dakr@kernel.org, johan@kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, "sashiko . dev" <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 1/2] debugfs: fix use-after-free in
 debugfs_read_file_str()
Message-ID: <2026092720-sandblast-heroism-30c8@gregkh>
References: <DLPDB44JJRGJ.3K6JNS746M71C@kernel.org>
 <20260926195844.1296333-1-qwe.aldo@gmail.com>
 <20260926195844.1296333-2-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926195844.1296333-2-qwe.aldo@gmail.com>

On Sat, Sep 26, 2026 at 04:58:43PM -0300, Aldo Ariel Panzardo wrote:
> debugfs_write_file_str() publishes a new string pointer via
> rcu_assign_pointer(), waits for a grace period with synchronize_rcu(),
> then frees the old string.
> 
> debugfs_read_file_str() dereferences file->private_data without holding
> an RCU read-side critical section: it loads the pointer, calls strlen()
> on it, and then copies the string.  If a concurrent writer completes
> synchronize_rcu() and kfree()s the old string between the load and the
> use, the reader accesses freed memory.
> 
> Fix by measuring the string length under rcu_read_lock(), allocating
> with GFP_KERNEL outside the critical section, and then copying with
> strscpy() under a second rcu_read_lock().  If the current string no
> longer fits the allocated buffer, retry with a PAGE_SIZE allocation
> which is the upper bound enforced by the write path.

Please don't use a LLM to write a changelog text without crediting it :(

> 
> Cc: stable@vger.kernel.org
> Assisted-by: sashiko.dev <sashiko-bot@kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
>  fs/debugfs/file.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 08de6652a..f9a1f7739 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -1018,7 +1018,7 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
>  			      size_t count, loff_t *ppos)
>  {
>  	struct dentry *dentry = F_DENTRY(file);
> -	char *str, *copy = NULL;
> +	char *str, *copy;
>  	int copy_len, len;
>  	ssize_t ret;
>  
> @@ -1026,26 +1026,37 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
>  	if (unlikely(ret))
>  		return ret;
>  
> -	str = *(char **)file->private_data;
> -	len = strlen(str) + 1;
> -	copy = kmalloc(len, GFP_KERNEL);
> -	if (!copy) {
> -		debugfs_file_put(dentry);
> -		return -ENOMEM;
> -	}
> +	len = 0;
> +	for (;;) {

This is probably not right, don't do loops like this.  Either fail or
succeed, don't loop.

Again, let's see the real use case here, what is hitting this in
userspace today and what debugfs kernel files are causing it?

thanks,

greg k-h
