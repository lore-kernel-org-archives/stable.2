Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032626;
	b=czSOrhvaWAq5dNxqdvWzPDSPKo/+cON7qn6/iCg4V93pbBFX6kgQTX0h0Wb2I3sGu5bh
	 86rZHekW1VkY+k9yy32x3ALH5Nm9XXAMb53pdcmqyCBPR5wuiI59C4TAEy4iYOzCeNmRY
	 ACE9HykpX7dNzibGfhOZnmaj3Th+7Ndkh3MqfTjXDTuK9odrPCDmdWAyaO0Ygk771lQX+
	 4/HDRvTo6WWXXYkkk1ABLk1tMAZNPGgbNU7mev86/CcaCADMPc4rRgaeLtc91cqa8ajjE
	 CpnZrdJ7XG7h3G8whm2TCd7VlViA+wN0TjsXHhQpJ/i9VZ0tmY2sauV5hkSw+hkJSAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032626;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=M788Xk3PB4yK/5EzK9J0RWEJS4zUyVPbx3h+aJGAnIE=;
	b=3K/31YE+ihwcsgqfoBDTcS952xZJN2iNZRsJU8Ou9P7cC+eb10741eX7YWVjnbF4ioC7
	 +qnVWHnb36GT+lBmlUr1f1cDY3a35s8wWXd8PkxfG0jd4rtm0eYdZVRxpe+PYPL16myrX
	 q4DzTEGXQUodVBuntbE9qG0uv1rzj8TEhu1ZTONMvJL6mGi8+j2X0Ykag7L2ZLxNvWmLX
	 jJvRhsWHjKSO5sUWLWoya0D+oJbsVLvb4CVd/e5cvm02bchTW4F3WU1X1Xw2ND3V7dq2+
	 e3UW5VDImwAOTIgkUJ7gMr+bQi5ha4gWNJ1esY34m1kgnqrunAYLeCZUv+EXwWk3Ikg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=I7iVn24v;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pR36kdmG;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA61606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FA61606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=I7iVn24v;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pR36kdmG
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 855F613802AD
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:37:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 12:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793032624; x=
	1793039824; bh=M788Xk3PB4yK/5EzK9J0RWEJS4zUyVPbx3h+aJGAnIE=; b=I
	7iVn24vfD41AJXP0/BUpnXd1RvWqMCB3FN3N+xkeoOyTcWM8oXGZQcV4ZzOtbt5A
	gZMERr//QEIClHkEEpDk0Pg64ptxuKkMUVqDmMNkfOY/HTNsqRFlpzNtAF7Lv9AN
	kdb0x0yGuYutcx/Vn+YzFcCqrNH8y5M6XznsHneblgFSNwbupCCjmKQEgw08H6E1
	gpKtxTgOTxETLXIQqrbEDJE97FWt29gHIfWfqRmJ+YPlDGTgePqdTeiFpBANMaH+
	H2qCZQP9SyTVv+3mnuo/wa2yuS4Dp34BJGZNOZmjPxntK6moKt8P5swXI0h49nsw
	m3Q5MLYnBxUTnqLdENlfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793032624; x=1793039824; bh=M788Xk3PB4yK/5EzK9J0RWEJS4zUyVPbx3h
	+aJGAnIE=; b=pR36kdmGlxLIaC6DYbG+KyTIgggdBXwH6daDGu7VElTmmotgqbC
	8ogM0UYCjAD+ZstXpYuq8+yxKPYk5JQzyuB0hNvLMdl9ZSwwI1wPT4pBqpsePr7B
	OXIlziLLErhBjE+5qXwA0AtwbW9xJtjeVm+o3l3sfQYI4RgUIJ0+1gA+GksG58V0
	LV8TURjx1ItDcsmN9UjVw7HVAZOBHKLIPVe1sHACRb64jBNZnOf932CuhMybN0Vk
	2QlgU+Luu4iO+sBjwNbvxXzF5sj1AeeZaKBYzbpa6GmiXJNeEe7cYfWF6j5YCzCp
	f1cQdkU097cgIYje2AFWpk6XkAbgXJwb8Ow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793032624; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:pIPUrdhkfSCp9wJ+XztjSESAQW0OVkY6cc49RAfES7leTdT
	p2W4SUCoh2qZ/IbZc9/ntKx3A8dPg9BIXsmsUbwnUf1Hir2Mgmtk05KDB5eGzJJD
	t/AVH5AeL73m3w90qg+Sg86TzBmWsOCqQ1+8AfWs/Djaum3YZgKuwHCglpYCpq/W
	XptZgLtaMtoGMPyUzJgq+5tfiP1KG0576g2MZw6LxkMAMCFr+775vjpaRFnI+L9H
	NwLDSCM+u0k38qKjDMsJjAf+exIUjjvgUYElCc9Hnd0TcRPCYwxF3eCn7wrZORhF
	Z1aJR3d+D2BZvMM/ogBYRSjiWGznLQuuKVl4gQg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8u+ljPUjNWAURUdkRgzi4ZvInM4ZjrblckocDAlPWYs=:ogWzqwUh+YwSKRYnV6B3XtBbR1nMJ/BN+dvXfmC+6os=;
X-ME-Sender: <xms:rYHfanQGM7Mzhl34gLG4et5x43xQbH93vi1lSKzIqoV4zVMr1CohPw>
    <xme:rYHfavdH9l4s4BXJXSOIMdqdKdPjYcjzpTdUBCyw8prJVvZ0DpDN6_EyT1qeodBSL
    5Na6TCoFDJK0ASgwnqAV_xfv4y4pUSGwsDTFs0POBX6FUttMu6C0QA>
X-ME-Received: <xmr:rYHfanBcBL_kqsp1g79Jds2IGWxkQfu3HfcDa6UIv7QZQE0CYV5rzHNYRCM>
X-ME-Proxy-Cause: dmFkZTF85toFBxe00b6Lht/0YohMnaHZ+kOqQSwWlzVS3n6NaDaTp+3L55+ckhhLGOFqI/
    gROlgw7KartkRyVU/1mD5EUn7ZFgUh5++lX4Rxl7IqqhV/09tBN8FrMq0XcJNcfIXM/fcs
    jAN3rc34tCVSgiB8+XaigqTvbo0SI8kdb6oHLKuBaaC5tk1Hc04ITbUeokPS7u+7cdi2D8
    8UVAypEv3LhlCg+OpfyjybH+wj3IC6vQs1RMPTTrUTwx8MsPvH0qQzqCcCGcBOeLJ7pYW5
    z57AotUZstf5//pTxw0fi+3Mab6IqWyQVB4QmZR9HHsUERQ/jOfPhnTRd1nMTKX/WyXFZE
    OXulAZaWcFzCXx+U6qd1iF80o1UBPD6T8nnLTxxx1EtSp+URplR05o6ShthzUEiNykbNFQ
    OEgBGu8LFPSR8k0wiFDaXMo+rGCqQeLRyj9UpmcfV1/DtePTZ3rAPENl1QZsy9u+YZMCHB
    yGC+vn7MvXAWw3lGX8X3mGl6bIf7ga0bPO7BN52iaOodqOfajOmX3isATAt+Xtje/ZUDV7
    UWYj+S1udZApPfGvPyYauzCGzTabSWb/1SPUrYrD+YOry4Kti1y2QGCx2CB/7tHJ22olLk
    KDBtj+h15jxdS848WxIIPWMXHIcl+GSCel774lZjsjdGaU6R/ZeRAUoSnngw
X-ME-Proxy: <xmx:rYHfanoZLa6oRb6cRI6obhzerCoRdv_bYmeHbvMsO4WKGgndTFQq9Q>
    <xmx:roHfakT-aMoPYOh0yt5Uk-dAP1XSLv4GCYHVkDOx8Z10KU4D_IjiZg>
    <xmx:roHfaocsEWSHJDeQ_WQKhF0iEo-7Sxb_WLiOOG9vcFaStUfrR78Z_A>
    <xmx:roHfamSUcwl4ir6MPwBZcQlXpUgfDHbsh27wR2SyIo8Y3TDzNUsXmQ>
    <xmx:sIHfaqfPuip1Z6RnZ2x6Boa_jaULUh_WvfP5KJngoUZHr7tTOpKu5-ds>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 12:37:01 -0400 (EDT)
Date: Mon, 26 Oct 2026 16:36:59 +0000
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
Message-ID: <at-AmbZyqUnGAJkI@thinkstation>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-8-703206d5fa0c@kernel.org>
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
In-Reply-To: <20261026-fixes_shmem-v1-8-703206d5fa0c@kernel.org>

On Mon, Oct 26, 2026 at 10:40:41AM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A fault or collapse can insert a large folio crossing EOF after
> shmem_undo_range() has handled the boundary folios. If splitting that
> folio fails, truncate_inode_partial_folio() retains it when it is dirty.
> The final scan then repeatedly finds it because it restarts from an
> unchanged start.
> 
> Truncation keeps the inode lock and ignores fatal signals while looping.
> A concurrent unlink() can then block other directory operations while
> holding the directory lock and waiting for the file's lock.
> 
> Advance start past the retained folio, whose truncated part has already
> been zeroed. Do not move start backwards if the failed split has shrunk
> the folio.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 55ac8bbe358b ("mm/shmem: fix race in shmem_undo_range w/THP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: split fixes, simplify descriptions, adjust comments ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Any reason, this should not be in the same patch as 07/16?
It is the same failure mode in the same function.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
