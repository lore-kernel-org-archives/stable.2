Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452FB422540;
	Tue, 11 Aug 2026 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438980; cv=none; b=olMuO6FctlyXDuG2N4ODVXmlZePIA7Jgeef8hIKwgFdOpk0TzIx9x6jgwi5MpWJfdGfPkDvleOSHz0ej12z9wmh7Qig1acs7H06FUuzd7DW/J2H4stxjk4LQ0Y7aqf143t1tUvME5Ht5YTYhfTxCDxrpcu5On2RTP5kLwi27FFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438980; c=relaxed/simple;
	bh=9q09MV/KODgWE90m8yXzfpxsB33zQa7pRMOkf9pmexI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDlCZ7Gn+d5PBvzU1B9hXTvLhc80eGfJbgvneji0GIkeJ9MzFSHDdVYc/31R6T+vtWyOvqo3GqrNIy4DL4QRxrxTALt6f6jBSkRPx/z7fNxINWHv0XzEWa5k1ghx0hLhU9BDDUyq3u4pdWqGFBl3cHNKwzgZn82itTmROkH+qZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bnip6W0h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bnip6W0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA45D1F00A3A;
	Tue, 11 Aug 2026 09:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786438978;
	bh=Q0LC4sYD3Sa68x6pNQWYRFPFL126Tdulwoxpswl1t/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bnip6W0hL774bgBntpYJCILk9olv+XLld9ulo3Lawy0556VshZ4sXDHREaalmfG5t
	 fy8OAjfTF39W5fC6XcoXIgO82x26PpVbouglDq190QMahEmcxjm9B6iH+mFfbDBlsP
	 0Zp3fvdJxDM4908LTadyr/qUk4Kvufi6oCYxEAf6zq6vbbHiwiYeRDCL+9ZXG1Db3v
	 C7KNdjCbAIoJOE1ycormg2FF/1y20OqvqMGq79gnhQIcEZoIoNIJZHaK/XWlXlGhBj
	 uAY+Btf77YeAhmE1HkQCNtgWeTfYVl1qywuKX1Yl8NKq2UiOdvbtkkbdJ/FjxZZCvF
	 61ItHQ5A99Wjg==
Date: Tue, 11 Aug 2026 10:02:54 +0100
From: Simon Horman <horms@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] l2tp: send netlink notifications in the tunnel's net
 namespace
Message-ID: <20260811090254.GZ51943@horms.kernel.org>
References: <20260809094252.2107242-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809094252.2107242-1-maoyixie.tju@gmail.com>

On Sun, Aug 09, 2026 at 05:42:52PM +0800, Maoyi Xie wrote:
> l2tp_tunnel_notify() and l2tp_session_notify() use
> genlmsg_multicast_allns(), which delivers to listeners in every network
> namespace. l2tp is per-namespace, and a tunnel records the namespace it
> belongs to in tunnel->l2tp_net. Each event concerns one namespace, yet
> every namespace is told about it. A tunnel event carries the tunnel and
> peer tunnel ids, plus the socket's addresses with both ports for a UDP
> tunnel. A session event carries the session and peer session ids, the
> interface name, plus the L2TP cookies where those are set. A listener
> needs no privilege for any of this, because l2tp_multicast_group[]
> carries no flags and genl_bind() asks for no capability.
> 
> The fix is to send to the tunnel's namespace with
> genlmsg_multicast_netns(). Commit 134e63756d5f ("genetlink: make netns
> aware") added both helpers and drew the line between them. The netns
> variant is for an object that lives in a namespace.
> 
> I found this by auditing the tree's six genlmsg_multicast_allns() call
> sites for objects that live in a network namespace. Only the two l2tp
> ones do.
> 
> I reproduced it on net at dd057113ac7b, in a virtual machine, with no
> real hardware involved. A process in the initial namespace, running as
> an ordinary user with an empty capability set, receives the create and
> delete events of a tunnel. The tunnel was set up inside an unprivileged
> user and network namespace. tools/testing/selftests/net/l2tp.sh passes
> before and after.
> 
> On a container host, any local user and every other tenant can read a
> tenant's tunnel parameters.
> 
> Fixes: 33f72e6f0c67 ("l2tp : multicast notification to the registered listeners")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, I don't think the issues flagged by Sashiko [1] should
block progress of this patch. But you may want to look into
them in the context of possible follow-up.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809094252.2107242-1-maoyixie.tju%40gmail.com
