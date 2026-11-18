Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005478;
	b=paTqgXJx5YrTd3MVgfrfR8Mg1mK5H4ahMswQua1dr43oD22ygtQRu2zurcQJexzTPm/7
	 bjQi+lWFscLhkrj/qVJZoJ50sBKu5HzMde2VeZbI23u03KgelJ39XOm0HopUTUwPx70LK
	 jRycL+JEeeVfj39rgWh9PO96cBKc94O+3PMPOGy1iOb/6k/LTzhIYitKsL/yjZ5Vu9mQn
	 18iwJxB2NH6RlDvhIZdW+FQMMn4FZzp4w0XH8JoeBsv7qkPMLan0XQZFT7kO74Ajok5e8
	 R9sXP5M2XzLx+B9dzWs0+2XB2csNAY3fTfneGQ4TFSctvTACZXfIPjtbaS9uwdmvynQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005478;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7QOeBdmv6Xwg/EN2J9zY875mkqRWcXEr4cDGZS3VmpQ=;
	b=27kouMByoL6uImaKZOWpGZeWd7UO5JXLb3L6Ey9sqiFvUeClIVXDdNP12lvrcGlTMOrG
	 zrP+iQUcAWb+SVXsvzoK9ryL6cKdF5N9p++59WAZPqPlkjbW1i4FcwT53oHdKBnlgyItP
	 zeaLNtWHRKkszI9uHq3zOFUeBwALZkOa0PMScUIef0J+3IbydgiYqA69zb7PUieYMnGx6
	 Q/FRJZ/PTT1a1siH3R7ZO5dD1G/2RHhYkL/QL5AbR3IH89i6MXvVBFgk6szc+k7eaZjqI
	 eEzCKA77FCXDflxkxStKu9brEU9uJFqXxXRXhESa+/EQcJeSv/SILsdsM2Vwud04SjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkyuPRrr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079F7606A320;
	Wed, 18 Nov 2026 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkyuPRrr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EE31F000C5;
	Wed, 18 Nov 2026 12:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005477;
	bh=7QOeBdmv6Xwg/EN2J9zY875mkqRWcXEr4cDGZS3VmpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OkyuPRrr3DwYPID2w/OkQQrFT7KO/BR7E7voWzmkQbGeroV2JNxaZpdcEoRdylf6w
	 xfuDIA4H5bTO4jHIs+FqzuGbC7wjWTHoOoTZBISz2BF8oh8IqhSfWJ+aZLkb8HyQHd
	 nYv8+1rXmqEOr3RghWQA7MMOjay+tHRTnwVVC4Fme7YZ7hXIg3kwipVqOpf7JY8tcp
	 U6VSQpuDrtH8VSeqleC8nA+3kPXimy/XSHRHnplnkrrjMVMgSpzTwGN75u/PS4aUS/
	 U3iYNsjIjHOz/BMVqhCHK4SEP/99EbM7GenZwGOmFM48xTLDkG9GQ6JB7EZLfDyXkT
	 CMAc3aj8whV1A==
Date: Wed, 18 Nov 2026 13:37:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net 0/2] net: fix a pidfd leak with a short SO_PEERPIDFD
 optlen
Message-ID: <20261118-sessel-wegziehen-randalieren-6567fbf10f82@brauner>
References: <20261117-work-net-peerpidfd_short_optlen-v1-0-a93f56288501@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117-work-net-peerpidfd_short_optlen-v1-0-a93f56288501@kernel.org>

On Tue, Nov 17, 2026 at 04:25:29PM +0100, Christian Brauner wrote:
> SO_PEERPIDFD caps optlen at sizeof(int) but never rejects a shorter one.
> With an optlen of 0 to 3 getsockopt() still installs a pidfd and copies
> only part of the fd number to userspace, or none of it. The caller can't
> close an fd it doesn't know about, so the pidfd sticks around until the
> process exits.
> 
> That's been the case since SO_PEERPIDFD went in for v6.5. When I moved
> the code into a helper for SO_PEERPIDFD_THREAD in v7.4-rc1 I kept the
> bug, so the new option has it too.
> 
> So just fail with EINVAL before we prepare the pidfd. SCM_PIDFD already
> does the equivalent and sets MSG_CTRUNC before it allocates anything.
> The second patch adds a selftest.
> 
> Note that before v7.4 the code still lives inline in sk_getsockopt(). So
> the fix won't apply to the stable trees as is but the change there is
> the same.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---

Are you taking this, Jakub, or should I throw this into the vfs.fixes pile?
