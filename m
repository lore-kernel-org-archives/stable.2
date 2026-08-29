Received: from mta1.migadu.com (out-225.mta1.migadu.com [95.215.58.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720F2BE05E
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787983394; cv=none; b=ZgWZtmrsybJJ7FlQklYqPm8FSOleG1bFjNRKzZq1hscZQBMR+C226szGFXQex/+MZgsQUHfCTN2IxRjbZilMx4OxMwvRRLGfb1k0XvMu4xHB3FQZkn4MtpUsoAObw6S5/FY7Lr3xsHr1uaRhxxBMNS9JhgKB4C6Pz/KvOFboDYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787983394; c=relaxed/simple;
	bh=TzTNMbh9vjF8g7nb8drIq5LNaabOjqGsc0jttZOZZ50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TegxD2V3NmMo93WrQZv+W7PLQwANMEoo/OUDl6um3cmMW7TCppX12fem5oQmveYvwtO2cGEQ5iROjfx5ASEQds4dl9R3TNk+kcWGzP4THlN1J3CBlaLzrrjA5haUyC5OpT+Tff5o1scLRvwqCNyejXwmDOy73mZr+cdlKM56qTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aLUZrHCU; arc=none smtp.client-ip=95.215.58.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aLUZrHCU"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TzTNMbh9vjF8g7nb8drIq5LNaabOjqGsc0jttZOZZ50=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787983390; v=1; x=1788588190;
 b=aLUZrHCUcClmRiKCC15GA4UXblh0K4Oc3AUW25W8ggb96S17qQgaUUpywKkK2rOGR//wL4Ul
 pNEpjkIgsudnkJoi9BsSj6Knz0oqqYqat6E39wI/afBui3SEiCy9kL/TNzfoimImX1SvmFV489K
 CmukqBtc00jfSSDMuSIoIb3g=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4a4045ff180f087c;
	Sat, 29 Aug 2026 06:03:09 +0000
X-Mizu-Trace-ID: 4a4045ff180f087c
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: jthoughton@google.com
Cc: kas@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	usama.arif@linux.dev,
	shy828301@gmail.com,
	zokeefe@google.com,
	hughd@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] mm/khugepaged: Don't collapse uffd-minor-registered VMAs
Date: Sat, 29 Aug 2026 14:03:04 +0800
Message-Id: <20260829060304.51549-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260829041523.43008-1-lance.yang@linux.dev>
References: <20260829041523.43008-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Aug 29, 2026 at 12:15:23PM +0800, Lance Yang wrote:
>
>On Fri, Aug 28, 2026 at 02:07:07PM +0100, Kiryl Shutsemau wrote:
>>On Fri, Aug 28, 2026 at 05:47:03PM +0800, Lance Yang wrote:
>>> 
>>> On Fri, Aug 28, 2026 at 12:50:04AM +0000, James Houghton wrote:
>>> >Userfaultfd minor faults provides userspace with the ability to manually
>>> >install PTEs with UFFDIO_CONTINUE. Right now, khugepaged collapse can
>>> >map holes in the VMA when a naturally-aligned THP is present without
>>> >explicit action from userspace.
>>> >
>>> >This is a problem, as it bypasses userfaultfd minor faults that
>>> >userspace is expecting to handle.
>>> 
>>> One basic question first. Should MADV_COLLAPSE refuse to collapse a
>>> UFFD-minor-registered VMA, regardless of whether all PTEs are present?
>>
>>I think the line is not between MADV_COLLAPSE vs khugepaged, it is if
>>vma->vm_mm is current->mm or not.
>>
>>In other words, we might want to allow collapse if workload itself asks
>>for it, but not for khugepaged or *external* process_madvise(MADV_COLLAPSE).
>>is_khugepaged is not the right proxy.
>
>Right, IIUC, we have two options so far:
>
>A) Conservatively reject collapse for any UFFD-minor-registered VMA, as
>   this patch does.
>
>B) Allow collapse when the workload itself asks for it, but reject
>   khugepaged and external process_madvise(MADV_COLLAPSE).

One more correction to option B above. Background khugepaged already
passes install_pmd=false and cannot trigger the problem, so the
distinction is only between the workload's own madvise(MADV_COLLAPSE)
and external process_madvise(MADV_COLLAPSE) :)

Actually:

A) Reject MADV_COLLAPSE for any UFFD-minor-registered VMA.

B) Allow MADV_COLLAPSE when the workload itself asks for it, but reject
   external process_madvise(MADV_COLLAPSE).

>
>Maybe there is a third option as well. Would be good to hear more thoughts
>on the expected semantics, especially from the maintainers, before
>deciding what the check should look like.
>
>@James, thanks for spinning v2 so quickly :) Please don't send another
>revision until we settle the expected semantics here. Hope you don't mind
>giving us a little time to sort this out :D
>
>Cheers, Lance
>
