Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C2377A97;
	Sun, 13 Sep 2026 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789293478; cv=none; b=eZL5zPgNCgM8Y1npIYt/lsvNfC+qp9ydenUUQFdR/rOMA/PlZipqS+8qDGHyD97D5xELd3pbfdrvfaYitl9ZM6w/Nz7loIJQoYuHWdXJhbcvRExxF2pzuKg4TtvXIDe/8Mb8jYRDitFiYtIYK7LjLTXEJgFmE6aY2YbRCNHjv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789293478; c=relaxed/simple;
	bh=unQ/0uzY3D7cYZwKkeOa1X7gfYdcMIvLK16kqdbWZzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVES2HUAasH19ySshWiABbg9jYC7JYFQTEX6AEw8wdy4i+rlH+Z/SRTd2lpJsw4dh8dVSzAJA8PjQV4Hl53Rap7v9NbcqDBYqmIqyW2E3O/TClnz+wjRVih35IEFNGGu9x4CNJTvt7kzHCwdK/5lXmiPTL8xTMa7d3oRSYdgohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=I8x3cEXO; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="I8x3cEXO"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3885A14C2D6;
	Sun, 13 Sep 2026 11:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789293471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojc3Gf8XdcHrzIe5027BZcw/ZHmTep5+/EMX7/cpuQs=;
	b=I8x3cEXOrG0+DRO4ErfU7WXllrlpn1ZY9SxOSJnGpp4NmSMqs/nI1zmAid5c87Tk04wOVz
	9e72wxFXuw7ra/qr3Yk6tk0A0XCriYPhZORmodOQbLN5UPTMjId1z9W1oIcIZ5dM42R+vZ
	Lu0BknfzS8Y4enR2uURKgMjLEE3jZw5uxjCrBG82XKlATKAHlZNEu9uaqsayQ4EnI3RXjI
	ASaMCoEXB1Sn6HAXM+/C1emdjJCf5LSSxEA2dmyurrghSrLZKvFsYE7Q5Bx/DfZERSG7EX
	ThFL/ALnEhkiqknZ57nFQWYzX/LguD+SZDvmP2WThznjfmMW/RDRBw/Sr7K4vQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 7a5da7f6;
	Sun, 13 Sep 2026 09:57:46 +0000 (UTC)
Date: Sun, 13 Sep 2026 18:57:31 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Yifei Gao <gyf161023@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] 9p/xen: fix refcount leak in p9_xen_response() on
 wrong tag
Message-ID: <aqZziy3RqeiJeHKW@codewreck.org>
References: <20260804213550.3409638-1-gyf161023@gmail.com>
 <20260806144255.4167019-1-gyf161023@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806144255.4167019-1-gyf161023@gmail.com>

Yifei Gao wrote on Thu, Aug 06, 2026 at 02:42:54PM +0000:
> p9_xen_response() looks up the request for an incoming reply with
> p9_tag_lookup(), which takes a reference on the returned p9_req_t. When
> the tag does not resolve to a request in REQ_STATUS_SENT, the function
> warns and continues the loop without dropping that reference, permanently
> leaking the p9_req_t and its msize buffers. The reply header, including
> the tag, is supplied by the backend, so a malicious or buggy 9P backend
> can leak kernel memory on every crafted response.
> 
> Drop the reference before continuing.
> 
> Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Yifei Gao <gyf161023@gmail.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

Thanks, I've picked this up for 7.4

If someone is interested in the 9pfs xen backend security then sashiko
had a lot of "pre-existing issues" to talk about[1]... I tend to agree
with Stefano's point of view that the 9p backend is mostly trusted
though, so I'll take patches if someone wants to spend the effort, but
won't actively be able to contribute much more.

[1] https://sashiko.dev/#/patchset/20260806144255.4167019-1-gyf161023@gmail.com

-- 
Dominique
