Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D233D6FD;
	Sun, 23 Aug 2026 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505082; cv=none; b=sWqX87V0PrDv1A6NxUnXjH5EGwXLLbbIDrAHe4+EPI8QyxvWnfDIEmQqelfgOT1gg718HfiPqa66JkN7uO9m02qqYqnUP8qLaeQ1xVfI8YSD3JE85gFheUCcOwVhQbZpHWmYKhVs97vfG6/JqyjEG57dRCad2Jaa7VHe5U01b9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505082; c=relaxed/simple;
	bh=7mX9PizEn4BZBFTfMs11ZtWUExKS+vK30Dasv8dMVI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLQ8S9rnp79a/BAtlzs1v+z2DmvSkZ9tckFaD0cCzjsNkbQIMW+qc0D3Xf6CKkgvaS3zhkA5rwJI9XkK+mDr5C/8rdRAXIdhcUCFFBGMNBKrcJDsSOBID4lg9DqR6bjCdk/XpQM3u6ZJeOHI9AWMQOxpzp75rSlDtd6yWfBijA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jLFOPMAe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jLFOPMAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135A91F000E9;
	Sun, 23 Aug 2026 17:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787505074;
	bh=Psn+UspIbe63v0GM9aBlRSuGV80cPOLwd7BYXzOO3QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jLFOPMAeAmUaF+YbMOVS5KIhTkzD7zG3428o8nmOmF6e4PBbwlp/YQ/6x79QOT2Cm
	 veCBvfm6t0YGADDGU6nSTqUiXSBdBNalsBf3BmgCZNXiaKO7vKxwzr9Wk1Z+VWecAh
	 QTYjIAx4varUkVVicXZ0GPOZgLPq2Dbs5EuWJJ8U=
Date: Sun, 23 Aug 2026 19:09:34 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: nirbhayykumarr@proton.me
Cc: "alexander.usyskin@intel.com" <alexander.usyskin@intel.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] misc: mei: fix race condition between client teardown
 and read completion
Message-ID: <2026082330-saint-relearn-1244@gregkh>
References: <mFnbLgz6MmxRv7Vo5F8dRB1xDjHWEORPoX9BEIpeevk-ptyMfVaw-WDBSZq-4i4g8eR2HpVF9QNvtbxRcAxJE621Ji2caOLa-9xmEMmpIiw=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mFnbLgz6MmxRv7Vo5F8dRB1xDjHWEORPoX9BEIpeevk-ptyMfVaw-WDBSZq-4i4g8eR2HpVF9QNvtbxRcAxJE621Ji2caOLa-9xmEMmpIiw=@proton.me>

On Sun, Aug 23, 2026 at 01:26:09PM +0000, nirbhayykumarr@proton.me wrote:
> In mei_release(), a host client is torn down upon close(). During this
> teardown sequence, mei_cl_disconnect() is invoked, which releases
> dev->device_lock while waiting for the firmware response.
> 
> If an in-flight read request was previously submitted, an incoming
> completion interrupt processed concurrently by the MEI interrupt
> handler can add a completed callback into cl->rd_completed via
> mei_cl_add_rd_completed().
> 
> Because mei_cl_flush_queues(cl, NULL) was invoked before mei_cl_unlink(cl),
> an incoming completion callback can slip into cl->rd_completed after the
> flush has completed but before the client is unlinked from dev->file_list.
> When mei_cl_unlink() is subsequently called, the invariant check at
> drivers/misc/mei/client.c:698 triggers:
> 
>   WARN_ON(!list_empty(&cl->rd_completed) ||
>           !list_empty(&cl->rd_pending) ||
>           !list_empty(&cl->link));
> 
> Call trace:
>   WARNING: CPU: 2 PID: 5056 at drivers/misc/mei/client.c:698 mei_cl_unlink+0xaa/0x140 [mei]
>   RIP: 0010:mei_cl_unlink+0xaa/0x140 [mei]
>   Call Trace:
>    <TASK>
>    mei_release+0x202/0x270 [mei]
>    __fput+0x105/0x2e0
>    __x64_sys_close+0x90/0x140
>    do_syscall_64+0xaa/0x660
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
> 
> Immediately following mei_cl_unlink(), mei_release() calls kfree(cl).
> If any remaining or deferred callback references the freed client, a
> use-after-free occurs.
> 
> Fix this by flushing queues after unlinking the client from dev->file_list
> inside mei_cl_unlink(), preventing concurrent IRQ completions from
> populating the client's completed queue during teardown.
> 
> Reported-by: Nirbhay Kumar <nirbhayykumarr@proton.me>
> Signed-off-by: Nirbhay Kumar <nirbhayykumarr@proton.me>

No need for Reported-by as you authored and signed off on this.

And did you forget an Assisted-by: tag?

and what commit id does this fix?

Also, no need to attach this at all, just send it using git send-email
as-is.

thanks,

greg k-h
