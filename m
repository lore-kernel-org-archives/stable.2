Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.223.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783599;
	b=AVtieK+O0b13pwgLNKrI/bxO+GMGDpnmSrtlUA8wnukyemIUw/B9VQMp8H/vLoqmyRDZ
	 hrK7xVjiR6saRYs/v6h+4Jbg/F/W2gsbdiYWJ+ObnHdK1wB/MG0ve3ucr9AeQAAIUbUMf
	 7Pj9T6cgxeiHSTU5v7G7WoXrJ/uHj4OMrspXrhGYOMIzpz56RSGm1AiW3RAhiSqtcbcRg
	 BPZ+FpyxjYh+sEAd9pEg3B+hDpkKGRcuDKndDFiNp5FCb7LokOXsrk3Ri6tOmVkZN2zJE
	 47mBnNvgm5I7djsd3fdaWjvVTwwCriW4i2UMzVxtImwE9uftrqZcj4kpgHDcrYfJ8QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783599;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Print-Harmony:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent;
	bh=0nfMQHsA9FdKA8Y/f3fNR+GnrM1jMaIDHAb/EY3SqX4=;
	b=M3+ygtYuIGgz5EoKOehxjl/xANFdaL6VATnRBl6qi7+KaTeyKhXPPYXEuxDncaT2ftH1
	 X2d06HLOcwoShanMLcdOPU7Mq6BYUQkP/LRs00KOJrYgOJcS64y7xlpVFuArTopnlE0Vq
	 VYk/7IzNWxXIKDpAOGBXVf1FC9bR+4vuz6riKkL2OMjz3JX9stKHwiwarEcUpxjA6wFEk
	 HNTqLbjL0KrSvGwWSHKLqPpLM5o7+YuuCOaO247ciAY91HkeNi9vv375WMP9PL+Kjr8cC
	 wk+neJ5Bs8gI/HUlCYxEsjMFMMaaQyST5hSR8mFfhP5vMuitCfyJ0YCxrGdMvhf1McA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=XosBg3rY;
	arc=none smtp.remote-ip=23.83.223.168
Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E9606A31B;
	Fri, 23 Oct 2026 19:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 529E9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=XosBg3rY
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AD9773861D5;
	Fri, 23 Oct 2026 19:26:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a203.dreamhost.com (100-96-7-166.trex-nlb.outbound.svc.cluster.local [100.96.7.166])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 515F6386065;
	Fri, 23 Oct 2026 19:26:31 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Print-Harmony: 033eb3f044415263_1792783591484_1067607383
X-MC-Loop-Signature: 1792783591484:1481457281
X-MC-Ingress-Time: 1792783591483
Received: from pdx1-sub0-mail-a203.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.7.166 (trex/8.0.2);
	Fri, 23 Oct 2026 19:26:31 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a203.dreamhost.com (Postfix) with ESMTPSA id 4jBCgV2X4ZzVg;
	Fri, 23 Oct 2026 12:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1792783591;
	bh=0nfMQHsA9FdKA8Y/f3fNR+GnrM1jMaIDHAb/EY3SqX4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=XosBg3rYGiyqQ56baoxZS6EN9KifLnZHr220PUrYtMgFLUtnJDW73pu8xYnmafcRW
	 IopT9it/YFmIzLUMeYvFZ2G7U2x7knQ6frnTdtLwiA0VYIu5+jI0HcGlJzbBucs/IK
	 iJXmJxz4CHL6V0qiG0geb3B20SqP8kfp1KJueur7Wq1TiLnNvN2dFkEgqnPmdhdlxx
	 /uurKGpvj7OMucvS0aq3hJBM+jc3bjpGYI9ck4VrCnZO8fe1lzQ0gKNbxNVajyCILL
	 IykWEWmW7pWOB5Hr0ulhjUyyXXXsUVfU2Vt2yqZ5IBELVfJImoyKF3eDBldk5NbunV
	 OZstxLWLTcn4g==
Date: Fri, 23 Oct 2026 12:26:27 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, SJ Park <sj@kernel.org>,
	Kees Cook <kees@kernel.org>, Colin Cross <ccross@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/vma: write lock source VMA before duplicating it
 in __split_vma()
Message-ID: <20261023192627.yj5ltdj4fjzydblp@offworld>
Mail-Followup-To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, SJ Park <sj@kernel.org>,
	Kees Cook <kees@kernel.org>, Colin Cross <ccross@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
 <20261023-fix-vma-atomic-v1-2-8ff4fae1fc85@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261023-fix-vma-atomic-v1-2-8ff4fae1fc85@kernel.org>
User-Agent: NeoMutt/20220429

On Fri, 23 Oct 2026, Lorenzo Stoakes (ARM) wrote:

>From: "David Hildenbrand (Arm)" <david@kernel.org>
>
>__split_vma() duplicates the source VMA before taking its VMA write lock,
>and until the VMA is write-locked, a concurrent thread might set
>VMA_MAYBE_GUARD_BIT, resulting in the duplication missing the flag.
>
>If this happens, then fork may fail to duplicate guard markers and, if a
>file-backed mapping, THP collapse may also discard the markers.
>
>Resolve this by taking the VMA write lock before vm_area_dup() and, since
>all callers of vm_area_dup() now hold the VMA write lock, assert that this
>is the case there, and add a comment to explain why it's needed.
>
>Fixes: 2ab7f1bbafc9 ("mm/madvise: allow guard page install/remove under VMA lock")
>Cc: <stable@vger.kernel.org>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>[ ljs - add VMA write assert in vm_area_dup(), commit message touchup ]
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

... with one nit below.

>---
> mm/vma.c      | 2 +-
> mm/vma_init.c | 3 +++
> 2 files changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/mm/vma.c b/mm/vma.c
>index 1be613044b4a..aa59005e2f42 100644
>--- a/mm/vma.c
>+++ b/mm/vma.c
>@@ -538,6 +538,7 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> 			return err;
> 	}
>
>+	vma_start_write(vma);
> 	new = vm_area_dup(vma);
> 	if (!new)
> 		return -ENOMEM;
>@@ -568,7 +569,6 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> 	if (new->vm_ops && new->vm_ops->open)
> 		new->vm_ops->open(new);
>
>-	vma_start_write(vma);
> 	vma_start_write(new);
>
> 	init_vma_prep(&vp, vma);
>diff --git a/mm/vma_init.c b/mm/vma_init.c
>index baa7e82f47e3..d661f229a734 100644
>--- a/mm/vma_init.c
>+++ b/mm/vma_init.c
>@@ -127,6 +127,9 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> {
> 	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
>
>+	/* Must hold a write lock to stabilise atomic VMA flags. */

should just say "stabilize atomic VMA flags".

>+	vma_assert_write_locked(orig);
>+
> 	if (!new)
> 		return NULL;
>
>
>-- 
>2.56.0
>
