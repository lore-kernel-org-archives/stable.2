Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7550D287246
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195383; cv=none; b=cRajRc860/l3UMVBXAPW+gMBXrHoh9eQc8ntmlz/QrbDKHaLxO4L2TaE+HrggQVUj2Pq1r+yqTKuItua2Jl9ze56yGoPvQ0nkWComc9Cfvtmsnmb5e2eb2uLGzjs7hfdJ+z5fjcIh2VsqxKllcCO1TEbFbRnWJ1N+Ywic+7UqjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195383; c=relaxed/simple;
	bh=Gdfi2lxzXTLZaG4qzsRPChTGItXUr4zkN+ThOIloZ9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFMmGBkVgtiq70f98eqNdaOFtW9QYZnrCGA4DLkbGel5fIZTEimZ+/Ob9rxJFis80oNQHZy+Fp+ctZjK5BYJOg/8n1n5OmBW7mksXEuF1K29Ar9W/Gs9gRzVOQChewjjXNXwDwj1EUGFwjuJb/0UdKYmKbAQeiF9mSmlN+FEGkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=issJDfYZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="issJDfYZ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef82204c6so10263f8f.3
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781195380; x=1781800180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxuDYeL/eex2Sgr3cJEvBlUMLkiGy8jQksgyCb/3eMc=;
        b=issJDfYZyQLbPUEelmzn96/OX8TKmLtJ48dg/ndX+PLX18DH0wcGdTO5tX4yY5RoWV
         /mV7WUUjYajExySJhcW2otzYGEdXO6UprOH+86dIHt3uvQXZNWnTQite3+DQcsaei6Sm
         l6d19aRwqAi5fb/BugjoGCqMMuVgTaRMl6kCAadiec7AWRYxm7ml/HiiFrK4yezFPCqO
         n3kd5vhtQIOtQVwWUw4RkVxhrQ6B0+Gf1gdTAkYxkys97+K0S5KaI7gNDyvko1SE2gK8
         Xo6l+bTyIZ2SIduwH10bv50GE63oS/Xkz5djlqd2YmpzK/5Rkp7q/UbA6UCJ48ijYtYF
         4Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195380; x=1781800180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GxuDYeL/eex2Sgr3cJEvBlUMLkiGy8jQksgyCb/3eMc=;
        b=R4392N8krKWRKZLfTuoXIvsAZagBb2ItAXCd2xDkfLgwpbwAhovKmiFIVtOyvxq91N
         UEUoN2MhC9iIgEjT55Xt+vYLD7/n820aFgu6dZkgn9PNWkY2B5S9MCYSFfCYc68e6bof
         xCbhcTCB4HBsukT3yBHiGqUymR3NnEt+fe+9zH0C9C7MaHcfvMscfvlyxfYIxMphpt0J
         bDuY+aUTHKlJytmJvcZhsQvPLfENAt56LEvR1L/mJZEsB6fEd2ZAqxOIps5kbEteP0y8
         pnIhQE+iyiEf8WtBkyS0FtEkIhmLqFbNlkPYcmXT9H9CdB0QveETToUI9g1or8om7j4F
         VecQ==
X-Gm-Message-State: AOJu0Yy4L1jFXnjET88+5GAopgkwGgrxD4ruRYbVx60mjvikAg0L8kR+
	CyG5qEMLhqZ/fx+EiOLgEniGkSkwslI2QXan9IQhGWSthwnLg+0mpsnW
X-Gm-Gg: Acq92OHEdulk2yplCzZfuSoHLyqQMTuhfsb/ttGPjDrcGc3tC1JRJudTeCWqAyBynwq
	1dUJk6PK8V5B97X23elT3hODGKmDmAGC+UUZzychjAIYGSVcDDFKVDquQa+qGauNkx5lPbbmGF7
	zc1bdKOxIIBevwcUhSXOrBiarM3P5tdQg5KVtPcvo9mPud8oMEnszPumZMOhFqluyTUtm4bDkIl
	DLY7+2KV0H6V7vm3ItOvw4afTHZrT2JdHHP+pZ8Ghx0iSmJT3Ipk5HCVFqKpLkf6k9lG7O2gWtN
	qit6hICA82Pnrk80m5TcnhspFT+xmD5voeaRWXPkeugubpziwjj1Ml952J68wlNzQAPcJM5znuh
	eplHxMjEqHa+/jAs3c4NLi0Psc/o0vao0bHft3oSqPLOhLQ8x0QkNy8nM9pcoo81AVw5jnIhxdB
	zfBAZX4PFvNLScCwpcs0SzUNDBMGoGUirdTA4GjcUG11Ww+kENc9Q1uejhziBo/e3oZGvIJA==
X-Received: by 2002:a05:6000:1ac9:b0:460:5949:960a with SMTP id ffacd0b85a97d-46067469d2fmr5524431f8f.8.1781195379641;
        Thu, 11 Jun 2026 09:29:39 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606c0f51e4sm3602f8f.23.2026.06.11.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 09:29:38 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 91060BE2EE7; Thu, 11 Jun 2026 18:29:37 +0200 (CEST)
Date: Thu, 11 Jun 2026 18:29:37 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Minh Nguyen <minhnguyen.080505@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Please apply 98d0912e9f84 ("net: skbuff: fix missing zerocopy
 reference in pskb_carve helpers") down to 6.1.y
Message-ID: <airicdmj6A7ZRGxs@eldamar.lan>
References: <aioyuCnSKlch1wdv@eldamar.lan>
 <20260611-stable-reply-0105@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-stable-reply-0105@kernel.org>

Hi Sasha,

On Thu, Jun 11, 2026 at 11:26:23AM -0400, Sasha Levin wrote:
> On Thu, Jun 11, 2026 at 05:59:52AM +0200, Salvatore Bonaccorso wrote:
> > I tested down to 6.1.y; the 6.6.y commit needs to be slightly
> > different. I have not tested 5.15/5.10 (no net_zcopy_get() in 5.10.y,
> > so more work there). Should I send an explicit 6.6.y patch, or will
> > you pick the change for 6.6.y and 6.1.y yourself?
> 
> Your 6.1.y patch applies cleanly and looks correct. But I can't queue it
> on its own: 98d0912e9f84 isn't in 6.6.y yet, and I don't add a fix to an
> older tree while a newer one is missing it. So I'm holding the 6.1.y
> change until 6.6.y is sorted.

Yes this is right, and is my bad that I did not spot the slight
context change in the 6.6.y version. I'm very well awaere of the
policy of the top down applying the patches and fully aknowledge that
the 6.1.y one should only be applied if the 6.6.y one is applied as
well. 

> Rather than have me hand-adapt the other trees, please send explicit
> per-branch backports: your 6.1 patch doesn't apply cleanly to 6.6.y

Here is the backport for the 6.6.y series as well.

As mentioned in the other mail, I could not have looked explicitly for
the 5.15.y and 5.10.y. In particular for the later I think more work
is required.

Thanks for your work!

Regards,
Salvatore

From e1829fcaea02ca81a047c1583a9767b325e1470b Mon Sep 17 00:00:00 2001
From: Minh Nguyen <minhnguyen.080505@gmail.com>
Date: Tue, 26 May 2026 11:12:39 +0700
Subject: [PATCH] net: skbuff: fix missing zerocopy reference in pskb_carve
 helpers

commit 98d0912e9f841e5529a5b89a972805f34cb1c69d upstream.

pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
the old skb_shared_info header into a new buffer via memcpy(), which
includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
Neither function calls net_zcopy_get() for the new shinfo, creating an
unaccounted holder: every skb_shared_info with destructor_arg set will
call skb_zcopy_clear() once when freed, but the corresponding
net_zcopy_get() was never called for the new copy. Repeated calls
drive uarg->refcnt to zero prematurely, freeing ubuf_info_msgzc while
TX skbs still hold live destructor_arg pointers.

KASAN reports use-after-free on a freed ubuf_info_msgzc:

  BUG: KASAN: slab-use-after-free in skb_release_data+0x77b/0x810
  Read of size 8 at addr ffff88801574d3e8 by task poc/220

  Call Trace:
   skb_release_data+0x77b/0x810
   kfree_skb_list_reason+0x13e/0x610
   skb_release_data+0x4cd/0x810
   sk_skb_reason_drop+0xf3/0x340
   skb_queue_purge_reason+0x282/0x440
   rds_tcp_inc_free+0x1e/0x30
   rds_recvmsg+0x354/0x1780
   __sys_recvmsg+0xdf/0x180

  Allocated by task 219:
   msg_zerocopy_realloc+0x157/0x7b0
   tcp_sendmsg_locked+0x2892/0x3ba0

  Freed by task 219:
   ip_recv_error+0x74a/0xb10
   tcp_recvmsg+0x475/0x530

The skb consuming the late access still referenced the same uarg via
shinfo->destructor_arg copied by pskb_carve_inside_nonlinear() without
a refcount bump. This has been verified to be reliably exploitable: a
working proof-of-concept achieves full root privilege escalation from
an unprivileged local user on a default kernel configuration.

The fix follows the pattern of pskb_expand_head() which has the same
memcpy/cloned structure. For pskb_carve_inside_header(), net_zcopy_get()
is placed after skb_orphan_frags() succeeds, so the orphan error path
needs no cleanup. For pskb_carve_inside_nonlinear(), net_zcopy_get() is
placed after all failure points and just before skb_release_data(), so
no error path needs cleanup at all -- matching pskb_expand_head() more
closely and avoiding the need for a balancing net_zcopy_put().

Fixes: 6fa01ccd8830 ("skbuff: Add pskb_extract() helper function")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260526041240.329462-1-minhnguyen.080505@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[Salvatore Bonaccorso: Adjust for context changes in v6.6.y]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8b05866e93b1..b901e6ff461e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6407,6 +6407,8 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 			skb_kfree_head(data, size);
 			return -ENOMEM;
 		}
+		if (skb_zcopy(skb))
+			net_zcopy_get(skb_zcopy(skb));
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 		if (skb_has_frag_list(skb))
@@ -6551,6 +6553,8 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		skb_kfree_head(data, size);
 		return -ENOMEM;
 	}
+	if (skb_zcopy(skb))
+		net_zcopy_get(skb_zcopy(skb));
 	skb_release_data(skb, SKB_CONSUMED, false);
 
 	skb->head = data;
-- 
2.53.0

