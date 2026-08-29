Received: from mta1.migadu.com (out-204.mta1.migadu.com [95.215.58.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713221C84AB
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787976948; cv=none; b=Fr729Ot3jTtQdefVYcCy5r5xvgvL8gZrmiUXQGFemv9KOpyqg92OqK36zc3cpyJFkvrYuZpnZUHypo9hUARUBVPf/sQu1fvYzfzmUG60ZK/jcBIlkH8eIPbujECU1X9qC2wNsNN1mCJBp2IkofmXE1rUWos254QITJ0Ce9Ccbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787976948; c=relaxed/simple;
	bh=crIh8UEj7UTYgK4YPrj5yXsDBpaEjutnGpyw2Nwfjms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXU7d47A9RkKfOxLBvV3uUXAmuJ49ovU+QITxvXNwx1D2J4Of/3LHIKoFyEnWK0pNr1wzFsRFVIpSa4mrPSgBhAEv9nofyRtwYHa+fVGyljLmEPtnahtCM0z349EqHLm5ZxjwFNuiwHVuxMWSx5nhEh870eikgeoKGgxNHnUi8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GKoI+sHb; arc=none smtp.client-ip=95.215.58.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GKoI+sHb"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=crIh8UEj7UTYgK4YPrj5yXsDBpaEjutnGpyw2Nwfjms=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787976942; v=1; x=1788581742;
 b=GKoI+sHbB6L1d3xkzA9kgBl33Bw9biVuN1R8OjyBeFa+Cr0+Jml+bx2I/aFvEZbr4e1KY7tU
 YmMwQ5S/SFnEIsz2TP4AUPgilGaYzh0vT5A7H8kRYPYw5qOpbDM53HyvuYH30NRa3PZvD0h4PzE
 BtTK/bugy7Ejr/5Q/gRkbCaU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b8a438c168cc2223;
	Sat, 29 Aug 2026 04:15:32 +0000
X-Mizu-Trace-ID: b8a438c168cc2223
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: kas@kernel.org,
	jthoughton@google.com
Cc: lance.yang@linux.dev,
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
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: Don't collapse uffd-minor-registered VMAs
Date: Sat, 29 Aug 2026 12:15:23 +0800
Message-Id: <20260829041523.43008-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <apGHG9LJtDpe2kdG@thinkstation>
References: <apGHG9LJtDpe2kdG@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Fri, Aug 28, 2026 at 02:07:07PM +0100, Kiryl Shutsemau wrote:
>On Fri, Aug 28, 2026 at 05:47:03PM +0800, Lance Yang wrote:
>> 
>> On Fri, Aug 28, 2026 at 12:50:04AM +0000, James Houghton wrote:
>> >Userfaultfd minor faults provides userspace with the ability to manually
>> >install PTEs with UFFDIO_CONTINUE. Right now, khugepaged collapse can
>> >map holes in the VMA when a naturally-aligned THP is present without
>> >explicit action from userspace.
>> >
>> >This is a problem, as it bypasses userfaultfd minor faults that
>> >userspace is expecting to handle.
>> 
>> One basic question first. Should MADV_COLLAPSE refuse to collapse a
>> UFFD-minor-registered VMA, regardless of whether all PTEs are present?
>
>I think the line is not between MADV_COLLAPSE vs khugepaged, it is if
>vma->vm_mm is current->mm or not.
>
>In other words, we might want to allow collapse if workload itself asks
>for it, but not for khugepaged or *external* process_madvise(MADV_COLLAPSE).
>is_khugepaged is not the right proxy.

Right, IIUC, we have two options so far:

A) Conservatively reject collapse for any UFFD-minor-registered VMA, as
   this patch does.

B) Allow collapse when the workload itself asks for it, but reject
   khugepaged and external process_madvise(MADV_COLLAPSE).

Maybe there is a third option as well. Would be good to hear more thoughts
on the expected semantics, especially from the maintainers, before
deciding what the check should look like.

@James, thanks for spinning v2 so quickly :) Please don't send another
revision until we settle the expected semantics here. Hope you don't mind
giving us a little time to sort this out :D

Cheers, Lance
