Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126117;
	b=J0M1W3XyKlqpkeilgkhlZUPCPbxx/NM4mQ1uF6/i86t4SFNKFp8A+x2Euid0SwHpFp7i
	 vOS/QfudjVcGtXPBWqtG9wkEQuAQf08rDTNYURktqmWBG0eAyg680FHMkBgrvIlbjFSvE
	 wfWKS+33X++4F/G2KbcM2+7ZgJ2N+kNpiqLUjDKyXwYRfsH05tgakFsqm98QRFw/iVvOF
	 fS714Mk9YbB9hl/cuPkMcLbzt/iGE5cGHw5wwSfVUgiX3w85iiawWtiuZXltDL88/w2Ud
	 eSFxA99awCpAgHQ/Qdw3+/VMAkgi9XTe7ucMq8q5uxLJ7DxuL4DzH1TflzlgBa9xOnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=68JN5QHnKCq47WQPiHLxuMujC+xRd0JDDXBuUw27i9U=;
	b=t8imfLli269Tuo5VO7H7hQeH/BWexnUW2HSmi0ml0/ctXTbTQIe9rteZUon7pyE/Hh0C
	 PUzcvDMnzZQYWiW0EWY4eHWTgjgzHCHwbIpgrPXdxw0Jvqu7NegZZ4C946RXchGtULPY7
	 WJkZmbIqABLbAak71JhKXH2CY0DPA26h3+Z83NSghGjqDUwnt930TQ6uWt/knQlQrlGwk
	 V7pCIDGjMUxAMKlA1UkY5IVRouRGmt5rxfIdcEybN1ItBiT9nUl2iDlMTwQ/3/ysfxHtE
	 qt1SZhHQyFWrd9F/RsAJZzfbn0T78DFC0TZD7MJt6zo2V53tdw80A4Z7q5KgoI3pM7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XjXswNiB;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A3606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 18:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 812A3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XjXswNiB
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91c1f548f87so2938496d6.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793126116; x=1793730916; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=68JN5QHnKCq47WQPiHLxuMujC+xRd0JDDXBuUw27i9U=;
        b=XjXswNiBaIyM5J+Wi10iG9bo3DMCBqtsjjRzQ3+VJAHwHozZCeZhZVKP5aLVdWbr++
         wD4OQDUrriX98EzsAlx1DKUCa2e6QsCm32wWkRAdkw2wHc1UexYGdJx2loAbTJXpp1Ch
         cU3NzJvsFzkLA2LuRlStfTDLf6HInHnV75Yu5btykVHVTmL1pFoh2nZCV6HIPtWd0ccl
         cNgYKAt+HXGs1k2xaop8NzFkI3zVJlbB4LGR0e4K2M1GHuR/01HGA5RF8Ovkvta7g01Z
         tJUEa1aEX8e/W/eXgzGfAEFeaY4ULnFvjLa8NZNRwtpE9DIagMGV/7lS65MrkiEDeH5E
         xcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793126116; x=1793730916;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68JN5QHnKCq47WQPiHLxuMujC+xRd0JDDXBuUw27i9U=;
        b=sWx6dvCxAW/9jN81/RI7xvfzQgYJtuUbIEbm65Mi+KZN9NBaIxZu7Yme07x6cCBCOn
         uh4wIBAotkQdlw/8fJjMpeTiEJrEyiejZIwYY9FeQJzgcZUAQkSXma87F3m44+hMXxvC
         MEysHnbT+S++0Qb+gjTlQAkgwgSVaioSnfdvlEEcPldihjHuBITbvWAW3AMJAkZux1i6
         jmXs9EHCjdsJ6Mlxh0pyETxGqD5WrKIcR55BIh99DeHELygGk0WOJ/+Mp6pMlgkH+mu4
         wMyqMLpO9dl4PSR+hgGK+OzEpmgL8NsrJLiCzYkNHxRJB147juioGqSsRHEZl4OB6qDR
         g1/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzeJ6mi191z01d+HbLaFgZY2oL1JZV0RLvYU/i+tk2WjSStE2OSSXq5Yt5/tT4MYnvvIuaZMbk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIg4Btb+lGIuqJWQ++fb1NxWEBqOhgLsBSLejSOunSNaVc1aEJV
	OPVSectAb7lFtcVpMVXfQSXu15DwhSe/V4+QTF9ZngxF3uoe/lZhflL1MuJaN6NTXkTtftv45Xy
	4xWoe5vQ=
X-Gm-Gg: AYBFou0LrwlI6s1uQ7lNdGmrQYz2UCWmu1K0I+9RS/LUBjLZonWPSwI7GKrDOVy3j/f
	lejxqZ23ds3rRiz352sygWgblIsBIU8mVcPwc77wKtIdK4R9JvktFA2ai6OT/vh66bCrLTC5y5u
	qFkeTAQo/mte4RjRnAgbgZm9D0qV8dvSKvI+dJGS2znlyrW8BHOTQxraanwfCLggqdywVyaS9fI
	56eT+9xtC9W51Dk9fq25oS6D1T9ddBlSC6zhQI7J5Aiz3WRckMkoGFvbsmwa4iJdgjRY8DqGIKG
	vJGsoxMpj5MsBVbXz6vL08TjxCINZ1XldNaHnRkwp6UHTr+iKz/OTOf/KGcMMpw0VDm5HPHLJez
	Vf2xu4kznJo6+U8X5wC3OZiQxO+lCj7EAxQ5D2ZnLU3khEHYS48LTGqS51KwITR+OQtNU+gl8ia
	iCtCdOf0Vh9RMKfW/bFkQ01KMXHoVXQqVQdetHL+wsf/5KwWQtfuQWXvmtaMTBSY+shilDpegL6
	pnlUCNmLHY68zgDXHOG0MdSRH4+j6K82dUVzBuS9Cg8iqP8NogalA/mJfl+39AiH0IEnlapg801
	8YzmNH49VSwe/T+zn4M0j8OxaAaY8SmFsrHCy4CrSRMlyE0B
X-Received: by 2002:a05:6214:4792:b0:91c:6d83:60ed with SMTP id 6a1803df08f44-91c6d836156mr52476076d6.55.1793126116366;
        Tue, 27 Oct 2026 11:35:16 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c0ffd4sm110412956d6.16.2026.10.27.11.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:35:15 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/9] mm, page_alloc: pass zone pointer to
 trace_reclaim_retry_zone
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-pgalloc-ai-hotfixes-v1-5-9c7d1aca801e@kernel.org>
References: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
 <20261027-pgalloc-ai-hotfixes-v1-5-9c7d1aca801e@kernel.org>
Date: Tue, 27 Oct 2026 14:35:14 -0400
Message-Id: <179312611485.3837667.16073234237109614963.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 16:46 +0100, Vlastimil Babka (SUSE) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> should_reclaim_retry() walks a zonelist and passes the zoneref pointer
> to the reclaim_retry_zone tracepoint, which loads the zone from the
> entry again to find the node.
> 
> Memory hotplug rebuilds the zonelists in place while allocations are
> under way. When a zone in front of the zoneref entry has become empty,
> the entries move up, and this one can be the end marker by the time the
> tracepoint looks at it. zonelist_node_idx() then dereferences a NULL
> zone. Short of that, the event can name another zone than the one its
> numbers belong to.
> 
> Pass the zone pointer instead of the zoneref pointer.
> 
> Fixes: d379f01de095 ("oom, trace: add oom detection tracepoints")
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Similarly found separately and tested the fix.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

