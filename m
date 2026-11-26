Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702663;
	b=ukUvEvyyIPnHKmqQ42GrAa0XEtYyFFSckjvrTvZJ/1J+mIMoTX33Tf9MJeNFpcoscwU2
	 24odHbSn9+uAU5rROTXZZ+1wVZ7Qd2PRPS5+zXTl1LcFP9wWR4XwKXXvZSLT1q/aN7IEY
	 QgpU+lFzlvjlrXa9rEMQZ73BqvSrnF2+bhijyWnGMnhOxZsvTrAh8VulW0dYiVzktBY+r
	 6mNtzcEMMrdLXEfVHDndqOsjYQ3OCvlUPdSIKgnvgwFjCIGlY4tzgTHrHJoRYeK9v7QTX
	 WGbDMrVrgqdynr0Vj4laTqubhaI9Naw9RJPLwzRRb4Dvcjz64zXE1V68odcqm70FQvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702663;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3gzsNMI7istfaUEKuYPkwQCHQUHjoKWhwRQJ8tLhBus=;
	b=EYNXX3LjZkdtLgVTnaHGMfji//CA+EbJH31MJdRSxi4EFF0Dn6EodSk4nDB+BC0Lf07e
	 v+O5Oo8oceuxj/0tlnx7GGYpoEoGMclT7GwFbSH7k5qOWMAek46XLKe3KsDn62wP14kNk
	 1NB2Knh23An6k7zztbStE3oGVoSYBDx2QTntFTOq3IdM3myeyi186UFfr3nwGScc64m1a
	 Xm2GY2zIC2QtWRRMMeRCDdJG0neFpi7rydUx9IIxTNpNEpj7rdK1Jsz+mg8nXT5NZiK7s
	 lQ2JRb6uLy+nEPqRhPQ5Jxx8NaZrQCjsWSqIrgAyzP0XCqhioncJVzdrBIJhsmQQOcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=EpProqTG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=e6yzFnKI;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2360606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2360606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=EpProqTG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=e6yzFnKI
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CEB211D003BE
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:17:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 26 Nov 2026 09:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795702661; x=1795789061; bh=3gzsNMI7is
	tfaUEKuYPkwQCHQUHjoKWhwRQJ8tLhBus=; b=EpProqTGW3JhR1DzTbJCVg368r
	3Vt+RbRWchzYpUpKNfEIyGDVSLnhnYQ7eQjseaUONVVNC28bBu+2qmEqAsgmoqNV
	Ybluee74gABael4JVIQZyYGfAWrSy3b1kepFZqiqL3LcIHimkgOyWvUMIWmA3Mr0
	DBOK9B8/TS+fke2KVW8N0zLB9IMPzd32ENTx0JIWW4S0g6Tj1HxO0g2OMXNSUEr/
	FhdUtYhI8aB8rt+vMtdcZXazuaCwYULwk8ur4MJPBBnnaZ6rXjtXEz6xRxngxt6A
	XmrzquhaEaQ8x47x2DMhzCqp1ZWq4RNZI8R5vMb9JsqMde92KaynyWtSjRTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795702661; x=1795789061; bh=3gzsNMI7istfaUEKuYPkwQCHQUHjoKWhwRQ
	J8tLhBus=; b=e6yzFnKIsQO7k/5z5G3LiK81slg6HpBh7GLf2vs1+Lv/mzO4VdB
	xDMxkZ+pi03WSa39hzBkcGg9K3IUJ8oCqMdKPX8DGDyKJjaIRwB+3wXmqxShtEOp
	IZejxRRq+xamvvUhoP0RNX6kvoauHLdIXiORoPDbzcFWtcDL91ekA2zlY4g/Zi9x
	S7VA6QsPf/PTlqaqV+jyEyORjrmkjPI4QSvAW4ZXrqYiHn3BNOUbbMliVKeKNzw9
	nIff2RmpEGU8HkbCRofSuup8mpJrAbrbhftfviYIKZ7htwV71cA8eCWZL/CiEUk6
	7osd8G5enwlEZ60G7Tx7/tzxDI8gpMNVGfA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795702661; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:iT0FgvouyUs8J8paZ3Buw71nh6rDkSO4lymX3KkKU6GmW3S
	v8Muegy/OzpqcwDYFlCxBiDGdWc5ul8+PqUbTdx5ZLljLudp0wtT+dXwGfhRRrP1
	1fniKEJWIoY5p1RXoGh+GNMDjVB4grD8mC1SsOFsc5ptKG+yFhlgYiD09/mpPN8t
	uk2F09oB1L/iw+543OPucZl4A5RWWxg4zWdToz2JpImNrgSV74KoRacxJdzZYlZT
	cxH616m+NYD/N1KgQEdFzm94rwTSAQdZ1ZwBhUBU31iu9/XnzOPffpytCI/ESuD0
	qxVSZRwrv99/z37RP+J3jIup/1hlAQydiYmOc+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xHdgtVbMEYv999wIWRPYEL/yvpVRgdxoxrTyF2qcKBs=:IjOa7CqaWJ1c+ImnT8tVrQZ7vUEKuQhF+mbzdbBJqdo=;
X-ME-Sender: <xms:hD8Iazff0Znbh5l13F6vi8xbd3paoH_JW2jW2yrOo55bTBHbKhVEAA>
    <xme:hD8Ia4qYAqFAwLJv--Oew2NYw834qjILn7JvQEJ8GzqnRUWjj1dfXXSkslno1rKHz
    jNomDH7sWmpL4dVums-wAlUjX-omGrQhaA2FyRMLdoYE3Dc5N4>
X-ME-Received: <xmr:hD8Ia9nzicIdca2T6p2jbLri5-gvUDY7Au3AM9pjPXOtlq8EtG55nrLHYtnZ0OpaUCTw585oXBz0mU7WEZmwMc61-tACTbQ>
X-ME-Proxy-Cause: dmFkZTFGYA7TwUPtd5OM71TWRnqi+ptKWddIrDDRblfV/Ko58vp94MxHyaLrVdzVSMzFql
    Lm43LqaGNA3W4Kjw7iEBYIDHbxA6aihLVMWxq82lq359i4+D3MnkMsThk4jRI9DlODh2wo
    m9RG8abRbE/jz7zFmvQRJEM7rlOVIgNDrJxdfgscY5cc5oWCLSNxu8ilOhNp6MhWQpZhgY
    65r/TVIBzhBy7GcZ/xH5FByZdoXPVhdEpp4jmnVsiNHht8QUdHUTYlQY6bFfPp9aEEpoJA
    5LjXO91/7vC/EVqDPfHFudG+IcwGNVhY8Ga2cI80PCUXJVB0O0H4Sr65Lsvo99T77VLpSg
    jDX7X6kDbLiiqMYPQoaKmdk/W7aZIfsTxg3Hs5DPMlyHS/G+V3ISSEOw2O6y2PKX7yvF8l
    V8zKXAGy4bCOP0r25KrGq6KNwTP8duLUWU8pwPRga+G8Fi8GdXt2JC2a6mGqeV40SudXwV
    XAt0Jx/aJTqFMOmLZ2h9VMufxmTKqRDpXEw8VYQrbyHzEVgkJUhTn5CTgK3RqcFmujW0HA
    qwGXqzIpAA3ty86+VWKY77NsCKozQjhQMi6U5/PHEHXDSFqQntKpYN00sCX/j13Y3KNMUU
    nBJiu6hnJmwM1B0VEREwj6fsvHfMy6bMRd6sQ5SpozDhJlmLHIWJ2We4jzQg
X-ME-Proxy: <xmx:hT8Ia5Q8iPORI0vR2TGQLBgmnbM8vRtgk-igaSSDicR_Kgr7O7GCeQ>
    <xmx:hT8IazYzwqjuoUDM_GKtkhKVydqajeivDVH-yhZ406pa2FHJrDBrAw>
    <xmx:hT8Ia58hDLXXt-gulmgPRu9BYidlU-WYhuoimIk0rASPj6ZUMhLF5g>
    <xmx:hT8Ia1k1nvd6gf6r-kn0O8Wpu3Grw9yt1PHUDlugtQNXFjKtkvcHzA>
    <xmx:hT8Ia1s_sYxWJSdwNmkklOt7OKcXWLfy8b7p9zxVyfqZWiVxnY7r_5xj>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 09:17:40 -0500 (EST)
Date: Thu, 26 Nov 2026 15:18:01 +0100
From: Greg KH <greg@kroah.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: stable@vger.kernel.org,
	syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
	Pedro Falcato <pfalcato@suse.de>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 5.15.y] khugepaged: fix readahead lock inversion in
 collapse_file()
Message-ID: <2026112652-marine-boxer-46e9@gregkh>
References: <20261109202404-failed-5.15-eadce52a9ef6@kernel.org>
 <20261111132424.88744-1-lance.yang@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111132424.88744-1-lance.yang@linux.dev>

On Wed, Nov 11, 2026 at 09:24:24PM +0800, Lance Yang wrote:
> collapse_file() can call page_cache_sync_readahead() while still holding
> source folios locked. If truncate holds mapping->invalidate_lock
> exclusively and waits for one of those folios, readahead waits for
> invalidate_lock and neither side can make progress.
> 
> We need to release those folio locks before starting readahead. On a page
> cache miss, roll back first, populate the collapse range, and retry once.
> Doing readahead after rollback avoids an extra pass when all folios are
> already present. If another miss occurs on retry, give up rather than keep
> retrying while truncate or reclaim removes folios.
> 
> Keep page_cache_sync_readahead() and wait for read I/O with
> filemap_lock_folio(), releasing each folio before moving to the next. The
> existing uptodate check during collapse still handles read errors.
> 
> Shmem uses shmem_get_folio() for swapin and fallocated folios without
> taking mapping->invalidate_lock, so it is unaffected.
> 
> Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=16bf7cd0ebeb1de93aa5
> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Link: https://patch.msgid.link/20261026152013.10511-1-lance.yang@linux.dev
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> (cherry picked from commit eadce52a9ef657d561b3e76c9b5f178bd99735f5)
> ---
> Backport to 5.15:
> - Use find_lock_page(), unlock_page() and put_page() for the existing
>   page-based collapse code.

Does not apply :(
