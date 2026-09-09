Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F63B6344;
	Wed,  9 Sep 2026 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937118; cv=none; b=MPU8A55stkq55rZP1ZNtvTGNe4x2lMDfNewpPetMcFyPEpTdu4ZjV5F25pXHBARxqdLhwD+8m4EEniaqz0Ve1Y6F1+Xkv/nsyF/XF0YFQf0gop2iDngHE+DGvUEh48CUnuE6ut1wo0PansoLojo/9RmcX8mrpR20kp3zLKkcnNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937118; c=relaxed/simple;
	bh=ZwcTGjsFBisObYo5p4yOAzzGAGhYTsp5VgaxYDbNmZ8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sN6P7YV7aTZKe5qZchLeFQ1UWyFLOGN3BRQ62klClVkbgx+i71orkEpUlrt3o16bpE2AFxaYo1quCoWEYrj/3KsgMf+juma2sX09TMCW+Mc3rVooy4lxrZBl8+UUNG4CVrn6bYTmrpynCK/6IOeJdyUmkKuWHj7LExNGe9tC5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fMrkjVgp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fMrkjVgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B080D1F00A3D;
	Wed,  9 Sep 2026 06:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788937117;
	bh=IqVLTnDYn66bK2YcqZfK0YLZ2dluSsDrOdyDou0m65A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fMrkjVgpFiPSguDCjRN3DHCdAH3a2In70srjXbI+JAYwfUX62P8hsZPd2kVEkeyMT
	 ppciAQQLOoiEMj1nm71D9UG3Pj92Z+lOzUrGGp26ZH2SFpWv4pnRHQ7n2v+3vTRY4C
	 mthRPk1QEDzNhBckcjx4e9AIERtNFGcQSHxfZr88=
Date: Tue, 8 Sep 2026 23:58:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: david@kernel.org, ljs@kernel.org, nico.pache@linux.dev,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, usama.arif@linux.dev, zokeefe@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v5 0/3] mm: khugepaged: fix tracepoint UAF
Message-Id: <20260908235836.43865421771074b81eadd127@linux-foundation.org>
In-Reply-To: <20260909025804.3233645-1-vernon2gm@gmail.com>
References: <20260909025804.3233645-1-vernon2gm@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 10:58:00 +0800 Vernon Yang <vernon2gm@gmail.com> wrote:

> From: Vernon Yang <yanglincheng@kylinos.cn>
> 
> The khugepaged tracepoints take a folio pointer and call folio_pfn(),
> but by then the folio may no longer be valid: freed after folio_put(),
> folio_unlock() or pte_unmap_unlock(), or not a folio at all but an
> xarray-encoded swap entry. On classic SPARSEMEM, dereferencing it oopses
> khugepaged as soon as the trace event is enabled; on other memory models
> it merely prints a bogus pfn.
> 
> Pass the pfn to the tracepoints directly, captured while the folio is
> still pinned, closing the use-after-free windows in
> mm_khugepaged_scan_file(), mm_khugepaged_scan_pmd() and
> mm_khugepaged_collapse_file().

Thanks, I've updated mm.git to this version.

> V4 -> V5:
> - Use a single trace statement.
> - Collect Acked-by.

Here's how v5 altered mm.git:


 mm/khugepaged.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

--- a/mm/khugepaged.c~b
+++ a/mm/khugepaged.c
@@ -1790,13 +1790,10 @@ out_unmap:
 				       unmapped, cc, enabled_orders);
 		/* mmap_lock was released above, set lock_dropped */
 		*lock_dropped = true;
-		trace_mm_khugepaged_scan_pmd(mm, -1, referenced, none_or_zero,
-					     SCAN_SUCCEED, unmapped);
-	} else {
-out:
-		trace_mm_khugepaged_scan_pmd(mm, failed_pfn, referenced,
-					     none_or_zero, result, unmapped);
 	}
+out:
+	trace_mm_khugepaged_scan_pmd(mm, failed_pfn, referenced,
+				     none_or_zero, result, unmapped);
 	return result;
 }
 
@@ -2789,13 +2786,9 @@ static enum scan_result collapse_scan_fi
 		} else {
 			result = collapse_file(mm, addr, file, start, cc);
 		}
-		trace_mm_khugepaged_scan_file(mm, -1, file, present, swap,
-					      SCAN_SUCCEED);
-	} else {
-		trace_mm_khugepaged_scan_file(mm, failed_pfn, file, present,
-					      swap, result);
 	}
 
+	trace_mm_khugepaged_scan_file(mm, failed_pfn, file, present, swap, result);
 	return result;
 }
 
_

