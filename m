Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C074BA3D;
	Fri, 17 Jul 2026 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292677; cv=none; b=Rrzz0uRzYIMq1dAzrx/BgmVDPtd6IrScNekjdMCkk8BfmYGet1Zmr5SF4v2EXj0krrgQSqT3iVbdrDEQeEuG/1cSA2qq6hj5V67QXfny57zl0QJerrVBupMjuAfYcKfOTkWGOjRpXgqEjPMTH7L7fHcBMNg3BITvvWYGbOeemDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292677; c=relaxed/simple;
	bh=eGQRxNI+KNNciX477AOht1dHdsy0OpRB+rdQDlJWb5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGD6WFP38Zzn4qcOqhmSsX4mUjlK7nNJ202X9fLi7RdGO4U/QD5Fq4//CHFMuzp9irMKA/3k58DQqaKNSo1jdSXuhsOV0VFp7N/BrwT2i7U3/b1SmhPlb1ec+tk5gQNG0q5BcNL+I2Vedz88I19YQlWPQsO3ohjxvju2VW1qY+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HB+WJFdV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HB+WJFdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8974D1F000E9;
	Fri, 17 Jul 2026 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784292676;
	bh=DRfYpCvVmT5hE8A5YMHVOSNiB3z391Y/uI7p7PzkiL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HB+WJFdVflxlHRlticHfAXWuW8KYjxXH3j0AtajbHBlacrkJU+zOqHoJLKGsyxEWn
	 nY5hkFMtlVy4Xxyk/4BNAAu/zvpBXrTm/Fu7RrdxSxBFYiroJb04GIhXX2a7H2jDh3
	 ujTENxNbJEGM4j/1nzH7TlhdgtGo9vJ1OoYKZbHI=
Date: Fri, 17 Jul 2026 14:51:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rui Qi <qirui.001@bytedance.com>
Cc: Corey Minyard <minyard@acm.org>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ipmi: Fix rcu_read_unlock to srcu_read_unlock in
 handle_read_event_rsp
Message-ID: <2026071758-eastcoast-subfloor-d1ee@gregkh>
References: <20260525063235.990101-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525063235.990101-1-qirui.001@bytedance.com>

On Mon, May 25, 2026 at 02:32:35PM +0800, Rui Qi wrote:
> From: "Rui Qi" <qirui.001@bytedance.com>
> 
> Fix a bug where rcu_read_unlock() was used instead of srcu_read_unlock()
> in handle_read_event_rsp() when ipmi_alloc_recv_msg() fails.
> 
> This mismatch leads to an SRCU read-side critical section imbalance: the
> entry uses srcu_read_lock(&intf->users_srcu) but the error path
> incorrectly calls rcu_read_unlock(), which is a no-op for SRCU and
> leaves the SRCU lock held.
> 
> The offending code was restructured in mainline by commit 3be997d5a64a
> ("ipmi:msghandler: Remove srcu from the ipmi user structure"), which
> replaced the SRCU locking with a mutex in this function, effectively
> eliminating the mismatch. However, that commit is part of a larger
> SRCU removal series that is not suitable for stable backport. This
> minimal fix addresses the SRCU imbalance for 6.12 and earlier stable
> branches that still carry the original locking scheme.
> 
> Fixes: e86ee2d44b44 ("ipmi: Rework locking and shutdown for hot remove")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 188722ec0337..41ae4dac4eeb 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -4395,7 +4395,7 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
> 
>  		recv_msg = ipmi_alloc_recv_msg(user);
>  		if (IS_ERR(recv_msg)) {
> -			rcu_read_unlock();
> +			srcu_read_unlock(&intf->users_srcu, index);
>  			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
>  						 link) {
>  				list_del(&recv_msg->link);
> --
> 2.20.1
> 

Does not apply to the tree, please rebase and resend.

thanks,

greg k-h
