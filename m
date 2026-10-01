Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA853515C1;
	Thu,  1 Oct 2026 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856489; cv=none; b=Jw0iRst+4iYVSnCLBFA9gHp8G3YKc6O/fNiAxSvO2/MqNT7Tt8ZBwWV4KoLIaH0LyjN5gKTKna+OL4z7NKUjrqTpoWq00nU0/E656NrpIPDzh6EYoJD4HIf88uXPYokUglZM3fLqIZccB7/EnkmZH1NqS2kXWCCpdIM9PRPkC+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856489; c=relaxed/simple;
	bh=OC2pTZJV00ZZLBENO3cEWOuMqUXoVlO9VSckIp3A57U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzwEK1LqswkcRR3GbqemkbblyUXD+pJe63Dec5uQ3Sh5v+Lx1IXJKncSy9ExP806JaJIM0vO24pZVXaVUkO25zdxeGcO1EO7sdSBQiCIsVlXen1nYz6UhHEvGthA/RE/rGK1tcGz9Q+2i6EbHrlVj6V2SohosLM8Q5/SdgCOUoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JXHm7D7J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JXHm7D7J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D1E1F00899;
	Thu,  1 Oct 2026 12:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790856480;
	bh=iexcZ3JLicKr3cLJH8fO81bUsfTE0h8Z4dJ0qTQ+x/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JXHm7D7J+bX6QUo9MoIV1xkACgBE2+lXwvUCQeVThI/p5NcIBBPbX4BZX8yEBnZFf
	 k0cW2Z96OOub7blW/zx0ERUseUvrjM9dsD8wKawTEJLDT9ehCke5uatE40r/x49FA8
	 0xl8lHN36Ffm1SsV5KhrjZJ9cZL+1/mCH6nhV+Go=
Date: Thu, 1 Oct 2026 13:51:41 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: nirbhayykumarr@proton.me
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v5] misc: mei: fix queue cleanup and list handling during
 client teardown
Message-ID: <2026100125-phoniness-platinum-1fe7@gregkh>
References: <YJsGZtBSVaHTkfjq2Unkm1i_gI8tfiGw1vWFkjzVDMVg1MiryXVpD8JWHs3v0me811S5NfpS-OO97DKMFZDProekqAbz-LIsiiYi546FJ9o=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJsGZtBSVaHTkfjq2Unkm1i_gI8tfiGw1vWFkjzVDMVg1MiryXVpD8JWHs3v0me811S5NfpS-OO97DKMFZDProekqAbz-LIsiiYi546FJ9o=@proton.me>

On Mon, Aug 31, 2026 at 11:08:10AM +0000, nirbhayykumarr@proton.me wrote:
> This issue was discovered using a multi threaded C fuzzer designed to
> stress test HECI client lifecycles over /dev/mei0. When closing a client
> while concurrent asynchronous requests are in flight, mei_cl_unlink()
> triggers an invariant warning:
> 
>   WARNING: CPU: 2 PID: 5056 at drivers/misc/mei/client.c:698 mei_cl_unlink+0xaa/0x140 [mei]
>   WARN_ON(!list_empty(&cl->rd_completed) ||
>           !list_empty(&cl->rd_pending) ||
>           !list_empty(&cl->link));
> 
> This occurs due to two issues in queue cleanup:
> 1. mei_cl_free_pending() uses list_first_entry_or_null(), freeing at
>    most one callback from cl->rd_pending rather than purging all pending
>    callbacks. When multiple pending reads are queued, subsequent entries
>    remain in cl->rd_pending.
> 2. In mei_cl_flush_queues(cl, fp), when closing an individual vtag file
>    descriptor (fp != NULL), pending and control queues (ctrl_wr_list,
>    ctrl_rd_list, rd_pending) are skipped entirely, leaving dangling
>    callbacks referencing the closed file object.
> 
> Fix this by:
> - Updating mei_cl_free_pending() to iterate with list_for_each_entry_safe()
>   and accept fp to filter callbacks matching the closing file descriptor,
>   or free all callbacks when fp is NULL.
> - Updating mei_io_list_flush_cl() to support fp filtering.
> - Updating mei_cl_flush_queues() to clean control and pending read queues
>   for both per-file closures and final client teardown.
> 
> Fixes: f35fe5f47ed0 ("mei: add a vtag map for each client")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nirbhay Kumar <nirbhayykumarr@proton.me>
> ---
> v5:
>  - Addressed maintainer review: fixed root causes in queue cleanup
>    rather than moving call sites.
>  - Updated mei_cl_free_pending() to iterate with list_for_each_entry_safe()
>    to purge all pending callbacks.
>  - Updated mei_io_list_flush_cl() and mei_cl_flush_queues() to support
>    per-file (fp) queue flushing.
> v4:
>  - Added the fuzzer methodology to the commit message per maintainer request.
>  - Manually wrapped commit message lines to 72 characters.
> v3:
>  - Removed non-standard Helped-by tags.
> v2:
>  - Removed redundant Reported-by tag.
>  - Added Fixes tag pointing to commit f35fe5f47ed0.
> 
>  drivers/misc/mei/client.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
> index 26d2b2742d5..5f648481024 100644
> --- a/drivers/misc/mei/client.c
> +++ b/drivers/misc/mei/client.c
> @@ -390,14 +390,16 @@ static struct mei_cl_cb *mei_io_cb_init(struct mei_cl *cl,
>   *
>   * @head:  an instance of our list structure
>   * @cl:    host client
> + * @fp:    file pointer (matching cb file object), may be NULL
>   */
>  static void mei_io_list_flush_cl(struct list_head *head,
> -				 const struct mei_cl *cl)
> +				 const struct mei_cl *cl,
> +				 const struct file *fp)

This is now a rough api, as you need to look up and figure out why NULL
is in some calls and others they are not.  Why is the fp not part of the
other structures here already if it is relevant for them?

thanks,

greg k-h
