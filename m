Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B91472F73;
	Thu, 13 Aug 2026 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626621; cv=none; b=nb+iIDdNlzbDOmmnlYg4bZOgd3+jsIZWmmWx+upUtTALWqwJlY/FW8VkehX6xiVvUMEiQHhxoq4JJ2gJPmT7iTeyWclqUmy5up3wzG9cRIVLRyln9pjzZwWqBASFvOz3LC4F7zbsqHXiRUkrl97oDzDNb3+/TafzX5GfF5wKOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626621; c=relaxed/simple;
	bh=EAuqKDJO0fiosKHSjj1Bt7yAT7PKeaQ6hwcjlR8Bs9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9r/bUizz6z9ch7GbGGLwDKu/xWr8sGMFgrx2uVOH5rftwt0fzm80OIuzJ79NFy5ZrN2daCN4uehNwxKrLftV8DXDlsJAqrdsBRIMpypK2bZzP420s3vvO+dFn5xwjbLtlINNPIMw8OONuslNRbYmBUGClvtp6P9qq/x8aqtpHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXotiNnr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXotiNnr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7CF1F000E9;
	Thu, 13 Aug 2026 13:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786626619;
	bh=dw/YLbdmVxlibKcPRjBfsqF+6zRf21vIPW4FyAAyn5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NXotiNnrnQjnNMPKSgLvCw9WRna6KKAr8r7g+P77Re1VkRTeiVLO3o0wDdMOKXaT4
	 vXusTgJc6zaW7cGItixUL6zLQjH8Vk7LPywn57C8DAz1NvO6u2HQ2qw+7U0kXA1w8L
	 RBHKsSOEbBs7eBHD9DOlNr2+RNBC+oP3fm1YtQmokXFZMTEVNonW7/NpqWHYMlwUTO
	 NGHpAc/Q+VxNcQbC3qrxbkFuL3YYSMHNDxHvKtVNKXIxCvqIYZ0pNfs1MBQYaaX/5D
	 hoMbxGKMTdjofubN3gJn6PvRA4rlVvf8iVuIdWnqZiuWjvjq217EqXe7rsE/1Sb/Ip
	 kwRVUXMbDxwaw==
Date: Thu, 13 Aug 2026 14:10:15 +0100
From: Simon Horman <horms@kernel.org>
To: fy15309206903@gmail.com
Cc: Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3 0/2] net: thunderbolt: two fixes for the failed
 bring-up path
Message-ID: <20260813131015.GA265046@horms.kernel.org>
References: <20260811-b4-tbnet-hopid-v3-0-9e75d1b51331@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811-b4-tbnet-hopid-v3-0-9e75d1b51331@gmail.com>

On Tue, Aug 11, 2026 at 01:20:48PM +0000, Fan Ye via B4 Relay wrote:
> Two separate defects reached through the same branch in
> tbnet_connected_work(), found on an ASMedia ASM4242 host-to-host link
> when the peer drops out while a connection is being brought up.
> 
>   1 releases the HopID the allocator handed out when it is not the one
>     that was asked for.  Today it stays allocated for the rest of the
>     XDomain connection.
> 
>   2 marks the connection down on the failure paths, so the next
>     tbnet_tear_down() does not run a second teardown over work that was
>     already undone: stopping rings that are already stopped, which is
>     fatal under panic_on_warn, and handing back a HopID this connection
>     never owned.
> 
> Patch 2 edits the lines patch 1 adds, so it has to come second.
> 
> Changes in v3:
> - Cut both commit messages down after review; the code is unchanged
>   apart from the comment on the new helper in patch 2, now one line.
> - Link to v2: https://lore.kernel.org/netdev/20260810-b4-tbnet-hopid-v2-0-0eee557e75df@gmail.com/

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

