Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7837417B;
	Mon, 24 Aug 2026 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564431; cv=none; b=Jq5mCwKP6b2pIi4dhRrfIUgvbZmgF2XhXuwkZk+EOluOcinyN2wriaDWCNXDN7Lpo/75EnhqnvCzNuVbI+xD5k65t7YmGWJmb7lNe0CDeiSt2pYvTNgYm/JI95ZAWzwvhtRV03PNekzro1GrouYXvlNlJtCDUi0UbonapAzX1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564431; c=relaxed/simple;
	bh=ef+XfqTnfVOMJOLAOsDvT2Rvau3U8LGdVNFNsNjOUaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzODsnXDSxJDO+vnNi/a5Cs9+czWFju/Po/doVh8Tj0e3j2LALeUPXJl2GaYUamNaNdUeikmL5MN/7oUg/+oU168+gcG9tZlfDvMG8F+B0Wl08P0O+ijJ2avzqsDUYNMKRsryCm/vVvhJBd3v49gKUQLaqc0ZPqJLIXuKYFo+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QY3ZTAVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QY3ZTAVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884271F000E9;
	Mon, 24 Aug 2026 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787564428;
	bh=QxXhV9WGvUGricYkzxSmq3AiYOIHwd1iZqf9zIDK3CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QY3ZTAVlckd+vfgfLQjjtGsAZHGjv+jeDC0O2mVymHRskeDdXBWyUlTQj7nn/g5kw
	 1fnoiWBek+STc3kEpDwEhYoC2dXIiOIEa0hlOZ92YjsnYjcWkHV1pPxedpJTwIgkTl
	 oHSAgoeTYp3w8Sw7e6Hefor6P3MClNCThthEYmUw=
Date: Mon, 24 Aug 2026 11:40:24 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: nirbhayykumarr@proton.me
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	"alexander.usyskin@intel.com" <alexander.usyskin@intel.com>,
	"w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] misc: mei: fix race condition between client teardown
 and read completion
Message-ID: <2026082401-spoken-nag-acf7@gregkh>
References: <2oKLyY1tm4g6xwyvmh7loQ1t1EBr1rNjMzfiXN-b0q8BbO_4vjW0xcxR_aTEielTWx5ma4f1NCO4Y5LG98PRKseN6WLUbnXR9zGtcQVR9zY=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2oKLyY1tm4g6xwyvmh7loQ1t1EBr1rNjMzfiXN-b0q8BbO_4vjW0xcxR_aTEielTWx5ma4f1NCO4Y5LG98PRKseN6WLUbnXR9zGtcQVR9zY=@proton.me>

On Mon, Aug 24, 2026 at 09:32:27AM +0000, nirbhayykumarr@proton.me wrote:
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
> Fixes: f35fe5f47ed0 ("mei: add a vtag map for each client")
> Signed-off-by: Nirbhay Kumar <nirbhayykumarr@proton.me>
> Cc: stable@vger.kernel.org
> ---
> v3:
>  - Removed non-standard Helped-by tags.
>  - Omitted Assisted-by: No AI or co-authors were used. The "we" in my original report referred to a colleague who merely verified and confirmed the bug.

Just to confirm, the original bug report, and test program, and this
hugely long changelog were not generated by any sort of LLM at all?

So how was this issue found?  What tool was used to poke around on the
mei codebase?

thanks,

greg k-h
