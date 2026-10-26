Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037584;
	b=Dt7EAMzNv+jh3fgxK/gSIW3ubVOzaPSxVDYHWbgCCj0VvcRJq3N2LMe68FsVH/HG6Vkb
	 M/pdlw3hQFs0mUmud/3sik19gMBERYWdG5wrNmNN0Qs6xt41aDKP/2tOsL5k/B7/CNWgs
	 qSEOaiXBtA51PaaNRucCWdS+OPm0ZXpDvIn/G40q7amU02VM9r18pPMAxVaAiBHbj+pJl
	 mJUKwfGnsQjC06rA5bP1rNTHmIgATaMxZnueowhQMXOl4ZEVOrsJeSuIaq6eU2L7c7QRr
	 56M3zcdX2op2KOqhyYAfC9+MN+Un67INkt1hrnd24I6quri7v7kwmYudSsWnjSMq5lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037584;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=oOYzlYgPliGkanrzYocQaBwBSFhy+a09Z2xViy9Z+c0=;
	b=bri9Ca9bJHx4Zq9XUGTznla6OVbI4/2JmLgJ2p/ft4trsnY+dW5eQzfb9uojndtJ3kBs
	 QRj4icLRQKcqxpvYo1TPSETEEPU/Sn71mhrhOYwfXPzDIZAtrLSVFYZH7SnWMFMZpNBy1
	 Y17Lb9qy+x00EZvZx3wcMc8/RH5bVf5Ofb28fX1q8tcprwV3UF0ZUWzkC/b7SRtKbJ1vU
	 xw3XG637+tv1A5iT9N5HW6PeQ7VZHkTWMfjrmt7WpgdWHN+oUs13Yt09LolnNHOsEqifg
	 UTv/puhgtDZqs2fMI2sWAAq86zMEidEY0zITHCsq6EW1OLoQbEddyuVX75ltUCWEnXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=UoOJok6X;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="eURMU/YK";
	arc=none smtp.remote-ip=103.168.172.136
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD8606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 17:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86DD8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=UoOJok6X;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=eURMU/YK
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 9BBE51380303
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:59:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 13:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793037582; x=
	1793044782; bh=oOYzlYgPliGkanrzYocQaBwBSFhy+a09Z2xViy9Z+c0=; b=U
	oOJok6X+OIinjewBKwhYYwOxH+PZDJZGMSPwjaGJ6X06l3eFrU9YF4zpKT0ZAWky
	nA8ZV1skgzjGHlHl1L1BmOeH8T42X/fFTZK4K2esGTRHvenXkmEd0Jwusx14tQOs
	TJ9cxTf5XOaT8SFhyTZvzVEgxB+fBHL2WR4LNGxirAiwgCSjeVHa4vdiBxNskZMq
	TSAeVMg1/0zZXZyyWFBzcAJtBP6WbUs9+ytZy5rakO2VqM+rhMegC3edWOphRs5l
	2dUTepFRzOEc2m8Lf1HyEuowFN8oHJXMl6Hn3VlgnWlNRMUyFYO+QrZWlW4ubCrb
	yyREpw220eOLNVJ1htcyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793037582; x=1793044782; bh=oOYzlYgPliGkanrzYocQaBwBSFhy+a09Z2x
	Viy9Z+c0=; b=eURMU/YKDjSZQVR4C6vNt3B8v1oil6L+SXYpKcDU0e4FaCW+fqq
	gmiDaaps0zI1U6S6vwAcO312JVPYb7hdrYZfXQsR/GCzTdH9D+g6eXCg/ELt7NDD
	gJ9qDIDm30mM1jQV5dK+75V9gYayp/Bd6zUdbzSDYLxw6iSSh60j+Vx3952ABm6T
	Z7EENyIA3iX51pozn+UeOLyXTRorQKKUmbIqPQZdJz+jNCWIakOk5BcxJqFvj28k
	sLCIGoLne581maJUaf/yJXPWSKm/Z9gRxso33HxSfpWiqHS7XUkYBwDL+vMuA02F
	Ql73aX5JhHXpdRNdStonBzYH9UeCBVeGPvQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793037582; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:YrvDz5fGFLpZsNnikXRFO+vg55yNffbCKxshAfU7OK8fGGW
	rf6+CDzPAeykmvjp2T1P28/6fJDiEYbc4N35el8X1pcfO58L1HMiQieRHJPngKIY
	FhK/MLPXQIng3+9pK9pbjn4ETLkSumzy9ONeGRQZKzwLlMMr3lMso9r92tl4a1zL
	9cyHSbwsvya9SS0JMED0eM2HO/h5UKng6yQUS6Xv8F72E/wB+iCNF5FEqdE9x3/f
	8GtcPxtEIbJUCBHGdZ/j3NCJ8kIxbepp0rL9s6hJzpgu8H9cOUUVhQE4qVr+bv12
	6II4dGesVYMUNMubq7EMgCCdWCxAW9/H9xxQSRw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:gdz0OR2pSb070YT1VXXewMkWi4OHqKYlSy7mq3nTxw0=:xvg2+PKiolvt97hjUN1pagpPFL75bqeploLKqu3QsnU=;
X-ME-Sender: <xms:DJXfaj6fwcX0ZPAdTR3_f3oEj_vAewN7PlEoD3NZMD6NmLQwbfYlfQ>
    <xme:DJXfavnRKmmObRDl9VqgO_F1z-2AEhqIYkLWM_KfYMG8m1StqqDFzFSY3XPuE4uMP
    oYsz6xjJGmUEUWtE5hRPVpQp_DP9Rg_Kdea5WdbUcQGexvgNO9fKQeY>
X-ME-Received: <xmr:DJXfakrrOEFUYHz0RyjOjRGT_jZDZp7cLBZj5usNadk7-RXTxUiHpjC5q_k>
X-ME-Proxy-Cause: dmFkZTFCJC346uT6BkgpqQYR4FNPAi1RA63Z+5L1PPhx5EiCpW4UTmnFOpzGWG2lAFxYWG
    ow1NfL/UTp/Pd4DBanvkvVjQX4/GJ9QHoxX2Gnm+9O7gKo81tMOLCB6mgJceKwlnlE/6R0
    V2YJ39AyV14l8ouat82SghyoTr/S0qOn4UjCWDfZBVfbZ8H6KBl+RFmwuyJgsMdh+ieuFV
    d3YZBJi/v/7a8u8UDV+6GBpxXisMoQE/lBwP/kVhG7Ecprx03wwiSqHTSA8W8XkMGFowSD
    sBsXoX6pbh6kmOG7yuRNSEET/XSSH+CeKPAuXjog7+s9n69YFxLZ6RvMAi2C1P2qu/rzC5
    xbTppKgEW5DqVCnkns29EM82AVgv+vAVO/P7HKFZ6UL0osfJ6AJYjRnMwpW1TPX9BeetfB
    dc6qhmwH8Xi1dQs6oE1LR62OT4AJmKrTlyqpxF4iiktYda3iqD+0MCE3TCNGOxXSs3wsZD
    foWjYya+jJPndrlUXX80JGJ2I6lCY9AK6SG4fFw7uvOXYsG5bLswkhY6a5bczIJM3s7PLJ
    SYKLyw9v7y+OrzOXgf5/c42Iyg3svUHoiwPaMKLxZ9V+4nKMubFDZ4CLzkH4L1G8r5+Lv7
    rDqIcyTKMcz4ul/5bLWLl7YgOTtWK4GhApbUsuBHbBrj4tO30MPLAugN1lXQ
X-ME-Proxy: <xmx:DJXfakzI3ROPAIRF3b0nfYO13OEVCw4FsxyzKavvaXvJGmZ4PwfM-A>
    <xmx:DJXfaq4ZTBk2GA67S3wXuU3nEDe0dCjvge2ERUkxS9U58ABq-IGRog>
    <xmx:DJXfaqkUHTdbu04yL1Wlt1QzbiAF-t0P2gNd1oe43PGpk9SfM7zLhw>
    <xmx:DJXfat72axNJc-yU0k8fSlJLmSeAYGZr27y7o2Zc7U_7leWrrlZPhQ>
    <xmx:DpXfahmllRgZZFxfHQq0fVy_vAh8-l8eogDyjPm3ajYF7TcOsEE_ublE>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:59:39 -0400 (EDT)
Date: Mon, 26 Oct 2026 17:59:38 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vladimir Davydov <vdavydov.dev@gmail.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lukas Czerner <lczerner@redhat.com>, 
	Carlos Maiolino <cmaiolino@redhat.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Stevens <stevensd@chromium.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, William Kucharski <william.kucharski@oracle.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 08/16] mm/shmem: stop retrying folios that cannot be split
Message-ID: <at-U8JkqnTC9GZyK@thinkstation>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-8-703206d5fa0c@kernel.org>
 <at-AmbZyqUnGAJkI@thinkstation>
 <f7d36a47-6879-40bf-8c24-dfc89d937647@kernel.org>
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
In-Reply-To: <f7d36a47-6879-40bf-8c24-dfc89d937647@kernel.org>

On Mon, Oct 26, 2026 at 06:08:15PM +0100, David Hildenbrand (Arm) wrote:
> On 10/26/26 17:36, Kiryl Shutsemau wrote:
> > On Mon, Oct 26, 2026 at 10:40:41AM +0100, David Hildenbrand (Arm) wrote:
> >> From: Chris Mason <mason@kernel.org>
> >>
> >> A fault or collapse can insert a large folio crossing EOF after
> >> shmem_undo_range() has handled the boundary folios. If splitting that
> >> folio fails, truncate_inode_partial_folio() retains it when it is dirty.
> >> The final scan then repeatedly finds it because it restarts from an
> >> unchanged start.
> >>
> >> Truncation keeps the inode lock and ignores fatal signals while looping.
> >> A concurrent unlink() can then block other directory operations while
> >> holding the directory lock and waiting for the file's lock.
> >>
> >> Advance start past the retained folio, whose truncated part has already
> >> been zeroed. Do not move start backwards if the failed split has shrunk
> >> the folio.
> >>
> >> Fix generated by an LLM and sent by Chris Mason in private.
> >>
> >> Fixes: 55ac8bbe358b ("mm/shmem: fix race in shmem_undo_range w/THP")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Chris Mason <mason@kernel.org>
> >> [ david: split fixes, simplify descriptions, adjust comments ]
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > 
> > Any reason, this should not be in the same patch as 07/16?
> > It is the same failure mode in the same function.
> 
> I decided to split because it's a slightly different error mode (failing to
> discard vs. endless loop) and tackles two different commits.

Fair enough.

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
