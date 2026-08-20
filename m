Received: from mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E9E47D93B
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244836; cv=none; b=tL84HmODqeepHPw0YmpWMsbcDg3s0KS/obWsMis3OF+hoFdof8w3ENGTWu3VzFINyMuEet3i03xj2LDoPUAFg51wkTl8zfaHNYcUjoVG+2utqvAp0uKCmAg0FAfpisq3R9sVEeRtJKnZoDi/X4rS5k0vqBi+0I/YPZe4Cl+bL2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244836; c=relaxed/simple;
	bh=S7ONTvPc0AWI+FMhf0XWlwa4LGzte/bD1qitLf+XJMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSNMXh+j5m28V0yH5XxSqI+CoDfni2SCnVEVlEhmOOMNjgs5kVlIIWXUIKN1TbVTZA+lHtsGfuYR7WJcsbqPYEyCnyL8wA6BtE47OVXOSBA3FD7CK1xv4KtKG44OTIEUqmWPhbyoHK94EI2/aGBzbAnIWpEDfopSf6TBgANlsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CiQXfyz1; arc=none smtp.client-ip=95.215.58.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CiQXfyz1"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=S7ONTvPc0AWI+FMhf0XWlwa4LGzte/bD1qitLf+XJMM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787244832; v=1; x=1787849632;
 b=CiQXfyz1MeO0xhtEbS/v2P2F7gEEtMu4pyCMo2sEvWauuiAX0wkJ8zw2dOpy/PPlaAVKTmFA
 OF8IWfCfQ92hbkEmof1D8gASJY/u/iCiZ/BOiEuY8XMJqOYnWL0YEnYV8cuNUjIcyvWxEzWKk5Y
 Wh3O8wypWt89N+/tlo7uDQl4=
X-Envelope-To: stable@vger.kernel.org
Received: from localhost (2602:fce1:44f:115e::)
	by smtp.migadu.com with ESMTPS id ca54f914b327986e;
	Thu, 20 Aug 2026 16:53:52 +0000
X-Mizu-Trace-ID: ca54f914b327986e
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: pfalcato@suse.de
Cc: kas@kernel.org,
	usama.arif@linux.dev,
	hughd@google.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	dev.jain@arm.com,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	nphamcs@gmail.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	stable@vger.kernel.org,
	willy@infradead.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio on zap
Date: Fri, 21 Aug 2026 00:53:34 +0800
Message-Id: <20260820165334.36401-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <aocFPRgqieScf_yo@pedro-suse.lan>
References: <aocFPRgqieScf_yo@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


>For some context: we were discussing (off-list) the recent report that
>systemd-journald had horrible write amplification, worsed quite a bit
>by large folios. At the moment, there is quite a lot of write amplification,
>but _only_ on mmap writes (if you look at the write(2) paths, you'll see
>write_begin and write_end which tactically only dirty what you actually wrote
>to, block-wise in the BHs or iomap IFS). This doesn't need to be true.
>
>What we conjured up was the following: since WP faults always happen on PTEs,
>you can simply dirty the block(s) corresponding to that particular PTE (which
>naturally points to a page inside the folio, whether it is large or not, doesn't
>matter). That way, you can avoid fully dirtying the folio's blocks. This is
>something that ATM isn't done by any filesystem, but it really should.
>
>Obviously this whole idea is thwarted if we keep writable shared file folios
>PMD-mapped - you can't get meaningful write notifications apart from "someone
>wrote to this folio", which isn't particularly useful once folios get 2M+ large.
>So PMD-mapping on a shared-write fault is antithetical to getting useful,
>granular write notifications to filesystems.

Just checking I got it right ... for a PMD-order file folio:

read-only mapping  -> PMD-mapped
writable mapping   -> PTE-mapped

Then ->page_mkwrite() could dirty only blocks corresponding to faulting
PTE, avoiding whole-folio write amplification.

Is that what you have in mind?

Cheers, Lance
