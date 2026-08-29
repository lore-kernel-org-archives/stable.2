Received: from mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E949330317
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 04:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787978342; cv=none; b=gjr6dTOXdfRVZ6p4o/AGfgG1hTiTnD/4iAlWqh/5wp/WKqzeRR5oPdUgx7fb+yg+ZsLa3CI4k8EXg9h+5MZJv9lUlWlBv2VHV7iCVEqPXFUFh525HGH/bufd5Cczs0u5YAZgb+yy2H7oj4hThopoXZZggYaL/tZ5qNoqPRsYmSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787978342; c=relaxed/simple;
	bh=ccYXNPj/B/0WdxnMrSq4t7JSxTjFKYCzydgIEuIk/aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phRmgn2ZJnvRBTVffChRPtnoAcbBfxA6RJOxY/VhqfGzsgOdfKg08vmwcriCTVBQCwH7js8iFHirki//C2MpoYmHt68fjaMDZDN6PukSLMLaysjUDA48n8DQFDOyaNsRLI2jKJcIRYmwCzrRGN4AgSwu02BlHH0pIEShZ8dAM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oExgWmUj; arc=none smtp.client-ip=91.218.175.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oExgWmUj"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ccYXNPj/B/0WdxnMrSq4t7JSxTjFKYCzydgIEuIk/aQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787978338; v=1; x=1788583138;
 b=oExgWmUjRSSmnRINn9VjzwxnVWKeoM5KUn2C1ZuSyeYE5HdQw9jXec5ZKjBXUk7nugSsk5Fn
 wOgFsPo3Q5bERVMB+C+cuAO8yFtPlVljxzMjKMs4cHX0n5VP4sO7QhpP5B4eUWd4mQQkr5tpi/5
 29z2rk8fnUKR01YRn7SHdS+k=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fa5da2c804325558;
	Sat, 29 Aug 2026 04:38:57 +0000
X-Mizu-Trace-ID: fa5da2c804325558
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: jthoughton@google.com,
	akpm@linux-foundation.org
Cc: lance.yang@linux.dev,
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
	kas@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/khugepaged: Don't install PMDs in uffd-minor-registered VMAs
Date: Sat, 29 Aug 2026 12:38:52 +0800
Message-Id: <20260829043852.45486-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CADrL8HVzfEXgE9OQfULhe6wh1kMMOALsYuCNOUkgBqtzk_LUVg@mail.gmail.com>
References: <CADrL8HVzfEXgE9OQfULhe6wh1kMMOALsYuCNOUkgBqtzk_LUVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Fri, Aug 28, 2026 at 06:09:39PM -0700, James Houghton wrote:
>On Fri, Aug 28, 2026 at 5:33 PM Andrew Morton <akpm@linux-foundation.org> wrote:
[...]
>> Wondering what Lance tested.  Was he able to reproduce the bug?

Yes!

>I assume he just re-ran my repro, but yeah I'm not sure, heh. Lance,
>what did you test?

In general, I prefer to write my own reproducer from scratch, using
whatever approach works. That's what I did here.

On the parent, MADV_COLLAPSE installed a PMD, and a later
UFFDIO_CONTINUE failed with EEXIST. With v1 applied, MADV_COLLAPSE was
rejected and UFFDIO_CONTINUE succeeded when registration completed
before collapse.

I then extended the reproducer to register the VMA during the mmap lock
drop/reacquire window in collapse. With v1, a PMD was still installed,
and the later UFFDIO_CONTINUE again failed with EEXIST. Adding a
userfaultfd_minor() recheck after reacquiring the lock closed that race.

Before reviewing v2, let's go back to v1 [1] and settle the expected
semantics there first. The check depends on which policy we choose, so
I'd hold off on reviewing v2 until that is resolved :)

[1] https://lore.kernel.org/lkml/20260829041523.43008-1-lance.yang@linux.dev/

>> Sashiko might have found another race in there:
>>
>>         https://sashiko.dev/#/patchset/20260828222640.1638457-1-jthoughton@google.com
>
>Let me get back to you on this. Best case, I'll send another
>(separate) patch. :)

@James please don't send another revision or a separate patch for now.

Cheers, Lance
