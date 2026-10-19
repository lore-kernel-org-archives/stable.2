Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC412701B8;
	Mon, 19 Oct 2026 07:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393850; cv=none; b=VUoZ0TXCxfsgvj/Jri1pPk2dqgGhvwbmYm8LRHY1hU0silhqMz5bM5Y1r/qhwrCX4rNOj3D9hmt2FOxqH/HmBQnEQpfZ51vCPhhbqvrHEpPj3lyNRUG0o5dZDfjqX+fGave3oRdzHR50rcuAvagObV5NeYvn9dhPNYWdcB+/PNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393850; c=relaxed/simple;
	bh=w91k1QsKRkrtOeUpf3w7FWHdc9ZLG8doEONCwCERito=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuuhGYpRjfiW/oa9mkkoA7YUJtYF2afDTU/DhzgBzp35sOiYc3d0b0w2Ju7Lq84ZE8XlkMV6kpmw1Y71e3crtFc4hrshBSvoG4+LbYoB2iAYW7Ilu+mwlyiwzBafpExuPdpbU5LPohJq1cM+lqHSfdiNBxhij3VFMnK82JHUddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXTb5rrh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXTb5rrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FE61F000C4;
	Mon, 19 Oct 2026 07:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792393849;
	bh=iwXXc6E0ACOnd4/DDvcelYvl1dfFyQdOSpned7ICjQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nXTb5rrhH+KebbOEeF3fmeeH4VjyxBY0J6wmXjvlCrhcheIkVj/2Q+8ICwLRulY3Y
	 RbcW90N+zAxElmoHLwgK8shnmrXvUJxRnFMJpZQvfYer6pdOD43I3PPn8RD+QOsCj0
	 b1auBFGCu/20rPTfNt+zsBrME67H7ko9aXZOiXsgZfR9BYb6OLtVUSZb71ZgwatXY7
	 uGNrBYe2OShivP+2usfUJm1LD54JIKYErqlfUJDKm3ogV+IjlSDwOZjSDd23fNfGWK
	 7nySOn+7v5W0q2DwlV3qxB2rKVaoZtWQBwyGikO6iTX1RBi7wiJIil2dB9psUi4Grc
	 QmB2CH/ugYDnQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xIhWB-00000008Fcu-0oLD;
	Mon, 19 Oct 2026 09:10:47 +0200
Date: Mon, 19 Oct 2026 09:10:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+a2e50fb40695811c2dab@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] greybus: operation: arm the timeout timer before
 sending the request
Message-ID: <atXCd0ywMCTDi_5J@hovoldconsulting.com>
References: <20261018151340.62626-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018151340.62626-1-ngocthang2710.1999@gmail.com>

On Sun, Oct 18, 2026 at 10:13:40PM +0700, Nguyen Ngoc Thang wrote:
> gb_operation_request_send() sends the request message and only then arms
> the operation timer. The host driver can complete the operation before
> add_timer() runs, e.g. when the transfer fails right away. The completion
> work then calls timer_delete_sync() on a timer that is not armed yet,
> the synchronous caller wakes up and drops the last reference, and
> the operation is freed while the timer is still pending:
> 
>   ODEBUG: free active (active state 0) object type: timer_list
>           hint: gb_operation_timeout+0x0/0xc0
>   WARNING: lib/debugobjects.c:629 at debug_print_object+0x198/0x2b0
>    kmem_cache_free+0xfd/0x6d0
>    gb_operation_sync_timeout+0x1c7/0x270
>    gb_svc_process_deferred_request+0x5f3/0x1150
> 
> Arm the timer before the message is sent. If sending fails, delete the
> timer again. If it has already fired, its work is queued and drops the
> active and operation references itself, so the error path must not drop
> them a second time.

Fixing this is going to be a bit more involved, for example, as you now
have to deal with the request message potentially being cancelled before
it has been submitted.

Sashiko also flagged this, and some other implications:

	https://sashiko.dev/#/patchset/20261017171743.24612-1-ngocthang2710.1999%40gmail.com

Johan
