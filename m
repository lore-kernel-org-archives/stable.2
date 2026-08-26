Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784A13B71B1;
	Wed, 26 Aug 2026 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733346; cv=none; b=fCU2vC+cnYJoFa83+7b2ozXB+xwfgQwFixQCr9cfBYd+le/RcSDea9gvlxxW1OpqgHlWr7guk2hIi4v78XefznLOz45I4XHGspJ6y5e2ao5y8c94tLKkJrGTzMXOR7bB1FZ3wCabE80Kj6zshULlapMz6B0SkZIcN5JghCHLoTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733346; c=relaxed/simple;
	bh=cw7LqV+adp2XCODNi8wM6MdEtKrnj+T7YnwS4FEPhLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNlQGHA9Q6QypUSsXwpuv9C5NTF1PVpRf8iXHc7aEwjq5W6ojZxHSqlheFSGmouok4Qs2wC3XZ/V3IKnkLYvuStu4+rmRV0or/IBOPOu+3yNFM4upJ3wNHdOmIl0HbtC/47NxGbGeIlaLxugtr4vMl0bPHpxBpnjdN31jABSeFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIMIbuVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIMIbuVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9274F1F000E9;
	Wed, 26 Aug 2026 08:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787733345;
	bh=77HcB1kud9ZQLGTOBXm8D/IPatt20bqt7WcnuYLsxnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UIMIbuVicIoSiAAGWpoipJ+A4fWtYWgCwo1Ax/57fBrKhMb/kTfwyKH/nvzE+dDm5
	 22svvHl7hnd7BnokCEJrA4QsJjQ1TfoN9LY/lTmC07NROJeFbQelbqXkmjJIDLb/fK
	 YB6hcym6o463vUIu2Dbri4qeJ6KVfRlrIhbpfGcZ6hcJa1CkNKPBJD4OCmzvWMWVtv
	 my1sGLHZNNK2a6shTrF3tQG4FL1vqOQ89D4WgyOMxXrjYJnSD/xEf00C2VLLIhqVGX
	 CUS0xhzW6shZ1SWWyGjz2TjtSLChnhTAOhwu5NuYXMJxTdOzpM5cMVlS5f5WDwyvdD
	 oL0YKWmxACJ3w==
Date: Wed, 26 Aug 2026 09:35:38 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Vernon Yang <vernon2gm@gmail.com>, akpm@linux-foundation.org, 
	nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, usama.arif@linux.dev, zokeefe@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v3 1/3] mm: khugepaged: fix swap entry value to
 folio_pfn()
Message-ID: <ao6jVbVHLUmuY2UA@gremlin>
References: <20260824092935.73892-1-vernon2gm@gmail.com>
 <20260824092935.73892-2-vernon2gm@gmail.com>
 <edd7ed8d-0f2c-4de3-89e5-f2b23c2dd1e5@kernel.org>
 <6a9c2369-5589-4f2a-bcfe-c6e3b46a1ccd@gmail.com>
 <c8e3bb54-e4f1-45d3-8059-3ee1910a920a@kernel.org>
 <ao6c6Oe_KV0O1LJn@gremlin>
 <b6fbf952-c619-4fc7-8a8e-62a0ae64ff0d@kernel.org>
 <ao6fSHW_nX8YC9QK@gremlin>
 <42695df0-3962-4126-9afb-9a1905d096a0@kernel.org>
 <49aa013f-f613-42be-bc58-35956ef189de@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49aa013f-f613-42be-bc58-35956ef189de@kernel.org>

On Wed, Aug 26, 2026 at 10:24:56AM +0200, David Hildenbrand (Arm) wrote:
> On 8/26/26 10:16, David Hildenbrand (Arm) wrote:
> > On 8/26/26 10:11, Lorenzo Stoakes (ARM) wrote:
> >> On Wed, Aug 26, 2026 at 10:08:58AM +0200, David Hildenbrand (Arm) wrote:
> >>>
> >>> Elaborate.
> >>
> >> It's overly long, I read it and am confused as to what is 'problematic' or not,
> >> it reads weirdly in English and pfn_xxx is the usual convention for naming of
> >> pfn's anyway.
> >
> > Excuse me, what? Are you now just making up arguments?
> To clarify, we have various users of "xxx_pfn" in the tree and I fail to see how
> "this is a problematic pfn" -> "problematic_pfn" is odd and why
> "pfn_problematic" would be any clearer.
>
> I do agree with the "problematic" aspect. "failed" might indeed be nicer.

Right yeah. Mostly the push back is on the word being a bit confusing. Fair
enough on the pfn thing, failed_pfn is actually the nicest name suggested so far
:)

I still think:

       	if (result == SCAN_SUCCEED) {
               	...
               	trace_mm_khugepaged_scan_file(mm, -1, file, present, swap, result);
       	} else {
               	trace_mm_khugepaged_scan_file(mm, failed_pfn, file, present,
					      swap, result);
       	}

Is a little neater as then it's only on the failure path that we trace the
failed pfn, and otherwise we explicitly -1.

But it's not exactly a show stopper this :)

Very rough edit of your patch - if you're happy then let's go with this, if not
then edit it + post so Vernon has a clear direction. I'm not feeling super
strongly on this so don't want to block anything:

----8<----
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 75639298efc27..371ee0b16d10c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2683,6 +2683,7 @@ static enum scan_result collapse_scan_file(struct
mm_struct *mm,
       	int present, swap;
       	int node = NUMA_NO_NODE;
       	enum scan_result result = SCAN_SUCCEED;
+       unsigned long failed_pfn = -1;

       	present = 0;
       	swap = 0;
@@ -2714,6 +2715,7 @@ static enum scan_result collapse_scan_file(struct
mm_struct *mm,
               	}

               	if (is_pmd_order(folio_order(folio))) {
+                       failed_pfn = folio_pfn(folio);
                       	result = SCAN_PTE_MAPPED_HUGEPAGE;
                       	/*
                         * PMD-sized THP implies that we can only try
@@ -2725,6 +2727,7 @@ static enum scan_result collapse_scan_file(struct
mm_struct *mm,

               	node = folio_nid(folio);
               	if (collapse_scan_abort(node, cc)) {
+                       failed_pfn = folio_pfn(folio);
                       	result = SCAN_SCAN_ABORT;
                       	folio_put(folio);
                       	break;
@@ -2732,12 +2735,14 @@ static enum scan_result collapse_scan_file(struct
mm_struct *mm,
               	cc->node_load[node]++;

               	if (!folio_test_lru(folio)) {
+                       failed_pfn = folio_pfn(folio);
                       	result = SCAN_PAGE_LRU;
                       	folio_put(folio);
                       	break;
               	}

                if (folio_expected_ref_count(folio) + 1 != folio_ref_count(folio)) {
+                       failed_pfn = folio_pfn(folio);
                        result = SCAN_PAGE_COUNT;
                        folio_put(folio);
                        break;
@@ -2773,7 +2778,7 @@ static enum scan_result collapse_scan_file(struct
mm_struct *mm,
               	}
-      	}
-       trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
+       	trace_mm_khugepaged_scan_file(mm, -1, file, present, swap,
+				SCAN_SUCCEED);
+	} else {
+	       trace_mm_khugepaged_scan_file(mm, failed_pfn, file, present,
+				swap, result);
+	}
+
        return result;
 }

--
Cheers, Lorenzo
