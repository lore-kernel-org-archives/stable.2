Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794754443;
	b=tstRVZzGdwOTOk6S58Z+qd4uABPwfX4GSH9rLP0fYAN7o7Rr+j6KEdA1QHYHxIBLHw67
	 hEzuGAOxIQIIi22Vh2Mj/hv0kVbDSsaGQLLCVk9RFsT9OmUK9uPdPWKenpzFW9hk+tD/W
	 YeMgEcbY00Xa9T9LqyIFAz1yj/cxO/QgYgyERuajDN/B1WxukUbKUZRhNTVwfW/AQKxeK
	 b3OYqyUnypjNfBOuQMMukN1PvSyP9jUt30mODKRKUIphQTlEaP32wTQXxgO1+oVUx/4is
	 clwi97SK1q1XgvrVlSZY8GKUR82SpYJpWg3z1a0iPf29NEVYG0BzEk15AiYBsfR4aZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754443;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/+Jso9I5c9riULwHU1kEXAc9fGEjvoAMCDTyw4f1fvY=;
	b=IHiyb2XZM/m0/Wq/IR7pw7kyMZHxau+uSUq6dbt2IwfVPmrhg3kyBLnHQkXDvjGeYl2C
	 FgroRbBzURSGF7hChAPC6VyntxyJmF+amm86DjqQ/QV9z6bh5f0oSilkc3PoyBfKjPY4a
	 t9/xjGOzdkHygc+G7ZD7Ct/bspivfA9p5z2KLyt5VIMgbyIciNcePRI5Lts2oTPG/B18r
	 OFWVLq+upZ3suT+sQ6tjo3eYzT8/CUarnNNwPtALdU1qNDtyENB7+h86KaGNWlYzDcVXy
	 tR+sL7uOVbaU+R+/OsOehAlsH0YFAxFWwGR2mhjrnxmLRDsz/WA3EbuDtSSFLBaSJ1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=wKOzZy9n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C40A606A31E;
	Sun, 15 Nov 2026 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=wKOzZy9n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87481F000C4;
	Sun, 15 Nov 2026 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794754443;
	bh=/+Jso9I5c9riULwHU1kEXAc9fGEjvoAMCDTyw4f1fvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=wKOzZy9nD3b98doT54vEvxjgW1PGSuPRLutSRd3EfjVq73n7zWs0PH2xxKCt2qIta
	 9om4DYaNXMEkQS+pjxBSAQnqIHvvd7CCOan2ToZ1+fNUiV6dVVKthVmR906ly6Bb47
	 3mgknZOikmkFKrWNUBmwK2bYA8TIyMaRALVF+/LY=
Date: Sun, 15 Nov 2026 06:54:02 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Noah Feldt <noah@feldt.systems>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner
 <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Qi Zheng
 <qi.zheng@linux.dev>, Kairui Song <kasong@tencent.com>, Barry Song
 <baohua@kernel.org>, Meta kernel team <kernel-team@meta.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: mglru: splice all generations when reparenting a
 memcg
Message-Id: <20261115065402.90457052d92ddf668f7e37d5@linux-foundation.org>
In-Reply-To: <20261115124954.7146-1-noah@feldt.systems>
References: <20261111000913.22943-1-shakeel.butt@linux.dev>
	<20261115124954.7146-1-noah@feldt.systems>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Nov 2026 12:50:02 +0000 Noah Feldt <noah@feldt.systems> wrote:

> On Wed, Nov 11, 2026, Shakeel Butt wrote:
> > Noah reported list_del corruption on single-node hosts running 7.2.11,
> > which already has commit bf4ade7dbd76 ("memcg: keep folio's objcg same
> > as its node"). The bad pointer is an MGLRU list head in a freed
> > mem_cgroup_per_node:
> 
> I have already rolled this patch out on our servers. Since then the
> panics and resulting restarts from my report have stopped, and we have
> not noticed any other unusual behaviour.
> 
> Tested-by: Noah Feldt <noah@feldt.systems>

Great, thanks, added to changelog.

This patch is in the mm-hotfixes queue for upstreaming during this -rc
cycle.  It has cc:stable.

