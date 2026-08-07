Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB91A38552C;
	Fri,  7 Aug 2026 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140796; cv=none; b=mck2Lta4r8qxMCpO7K4aZTgmiePPJ6NGDNhbugm+BKaz/JWwR4siU3bELEdMJB9l0HAb/Gd+Vtaz7t+TDkrkBiGYqOOxa+/puMKp8D1pbHlpqjtciw2jxwzsz7re+rKh2MzM4QVaL8elZ3vv6ztjAyvcnW0j3EpHL2qjNwaQLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140796; c=relaxed/simple;
	bh=+oSrYbPbKyMdUdetv9DS9qXZGQ0mtGst6ZKwGxFCwtU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Pk+g1HSko+4ztgkIEEwrVrZXgfORMbS+d3gy3aLSsPzF0fwEG/7s8AmtiJx0YbJzNE0P5G5JrHGt68PJxdLaojgv20tNOygK/ECQk6U6KvqScDYu91vC0JMnIdUD2QPwjzxJksw5DY3Cf8YMMeAGdDr4A8sY6unENRWlDWD0gfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0LWkvR8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0LWkvR8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E681F000E9;
	Fri,  7 Aug 2026 22:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786140794;
	bh=XXLEQ0xzIolCM04SBA4M1mLB6GwOWoMbRzDt/sZu7so=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T0LWkvR8f88uCqxlSOraRQip5DLUqtcJNwW+4EfAHz1HIoRKMzFLw/pi9w8u9nQ3x
	 frn5gutpVc1G3esAJ9+VlC16ruNIAIHQZG/FQGdt08tAHGvMdszRsN/ieTE1I54VwN
	 C4zI7zJyNTgQMuj1k9u6XSIv8CpuC08VcSgjlcC5tY4pIJsO4lfOVyU/js8w8NRAbQ
	 s1pKYGkFGSldz/0rqkkFEwz4XXPK2GLhhh6EuB7v6AuJpb4footAEnjzLMmq4jR5wl
	 Ujr0SRbGHMTN+LNLtoaB8N33U4Rn+g+v4OFHVbzHiqeH3TWBeGIgB7f03ipqukB1GM
	 rAyFfZ0l91gFQ==
Date: Sat, 8 Aug 2026 07:13:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] eventfs: Fix use-after-free in eventfs_remove_rec()
Message-Id: <20260808071311.c069dd27dc49e5cb68eed731@kernel.org>
In-Reply-To: <20260806022719.375354-1-shuangpeng.kernel@gmail.com>
References: <20260806022719.375354-1-shuangpeng.kernel@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 22:27:19 -0400
Shuangpeng Bai <shuangpeng.kernel@gmail.com> wrote:

> eventfs_remove_rec() recursively removes the child at the current loop
> position. After the recursive call returns, list_for_each_entry() advances
> by reading list.next from the removed child.
> 
> If free_ei() drops the final reference, release_ei() reuses the list/rcu
> union to queue an SRCU callback. The child may be freed before that read.
> The eventfs_mutex serializes list updates, but it does not keep the removed
> child alive or prevent the SRCU callback from running.
> 
> Use list_for_each_entry_safe() to save the next sibling before recursively
> removing the current child.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Fixes: 43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> ---
>  fs/tracefs/event_inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 39c7a34531e8..93bc4f83b73e 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -822,7 +822,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>   */
>  static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
>  {
> -	struct eventfs_inode *ei_child;
> +	struct eventfs_inode *ei_child, *tmp;
>  
>  	/*
>  	 * Check recursion depth. It should never be greater than 3:
> @@ -835,7 +835,7 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
>  		return;
>  
>  	/* search for nested folders or files */
> -	list_for_each_entry(ei_child, &ei->children, list)
> +	list_for_each_entry_safe(ei_child, tmp, &ei->children, list)
>  		eventfs_remove_rec(ei_child, level + 1);
>  
>  	list_del_rcu(&ei->list);
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
