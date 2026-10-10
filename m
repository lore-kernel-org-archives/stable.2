Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E746D381E83;
	Sat, 10 Oct 2026 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672566; cv=none; b=Yq7IwRGICB7GppeGZQp3uOKIR4z4nFbSHdFAUS96FZ2C0pCinEMbiplKwWTGE9k90CT3IZfOYlVDKMt66CBZMCcxFPDrmiI2LzUMmcUJKlkMsiQikwgPK4MiN0aQ5Im/5vs8VY36i2lPasuH2V/qqI0rn5JEI4eihZYNIeh5png=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672566; c=relaxed/simple;
	bh=Zno9twYYkmllXWUxQoASKGLVvnavhS2ImjCRLLsL9vM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Grbw6X6m5kGxxy3+9IH/02qx1wthaT4rg3e774CL0Mzk+11DoMagLUCs1LmbRAW8xKMrSrxmO2A9eXkuWFTKfp8URjZjPG9zZTt5fA6aHazihbecEekGF7tf5+5kHee9E7+yC12oUwH2oZquvF/Cch2yW4yA3PWZWCCQz+j1yD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cCKvVcGN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cCKvVcGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95A61F000FF;
	Sat, 10 Oct 2026 22:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791672564;
	bh=jPS6JmRVMqShWeHdFYFwBFA3RIGj7GQ7jqcXY+ZDXOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cCKvVcGNc+90nm8E9Z2ocQr0PJEM0cEkTWElHOJVfgP86fmSKvHvwMdlskZpEeeP1
	 KFoRYy18Ef80YtLtvaVFC3LlmUEIh0wTzMMm43s9NpjOL+NTXwpt8D3PGv8KoiDATy
	 w+caLivHqYdlKmqVfBfFhIoxu95yqs+f9h6x/t7w=
Date: Sat, 10 Oct 2026 15:49:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Harry Yoo
 <harry@kernel.org>, Usama Arif <usama.arif@linux.dev>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-Id: <20261010154923.998e04e42093ffe6c7c205ee@linux-foundation.org>
In-Reply-To: <20261009125503.126202-1-kas@kernel.org>
References: <20261009125503.126202-1-kas@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Oct 2026 13:55:02 +0100 "Kiryl Shutsemau (Meta)" <kas@kernel.org> wrote:

> Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim
> storm in defrag_mode"), direct reclaim and compaction for non-movable
> requests under defrag_mode run at pageblock_order, to produce the whole
> blocks that ALLOC_NOFRAGMENT needs. The retry decisions that follow
> still use the request order. An order-0 request can therefore retry
> indefinitely without ever reaching the ALLOC_NOFRAGMENT fallback:
> 
> ...
> 
> When a promoted request takes the fallback, reset the retry counters,
> so that the fallback attempt gets a full retry budget before the OOM
> killer is considered. A request whose reclaim was not promoted spent
> its budget on the request itself and keeps its counters, as Usama Arif
> pointed out.

Thanks, I updated mm-unstable to this version.

> v3:
>  - reset the retry counters at the fallback only for requests whose
>    reclaim was promoted; a movable request already spent its budget on
>    itself (Usama Arif)

hannes's concerns/questions at
https://lore.kernel.org/20261006081050.GA234057@cmpxchg.org weren't
fully addressed?  I'll add a note and await followup.

Here's how v3 altered mm.git:

 mm/page_alloc.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/mm/page_alloc.c~mm-page_alloc-make-defrag_mode-retries-follow-the-promoted-order-v3
+++ a/mm/page_alloc.c
@@ -5030,14 +5030,17 @@ retry:
 		goto retry;
 
 	/*
-	 * Reclaim/compaction failed to prevent the fallback. The retry
-	 * budget was spent on making blocks, not on the request itself;
-	 * give the fallback a fresh one before considering OOM.
+	 * Reclaim/compaction failed to prevent the fallback. A promoted
+	 * request spent its retry budget on making blocks, not on the
+	 * request itself; give its fallback a fresh one before
+	 * considering OOM.
 	 */
 	if (defrag_mode && (alloc_flags & ALLOC_NOFRAGMENT)) {
 		alloc_flags &= ~ALLOC_NOFRAGMENT;
-		no_progress_loops = 0;
-		compaction_retries = 0;
+		if (reclaim_order != order) {
+			no_progress_loops = 0;
+			compaction_retries = 0;
+		}
 		goto retry;
 	}
 
_

