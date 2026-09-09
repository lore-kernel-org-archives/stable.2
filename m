Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEBE18872A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 02:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922711; cv=none; b=oIaD0F1dfYkg2tX/VWjyc8SLVG0uRXXQZPjumBYsB5fJU1eo7nQjuayifj+yX6/KkX80FeUZd+FMrAPNaBsUrr5nw+TBQphWa57m+qtpqnZFgkFUxEyzz7ZxFY2O/ngPDcsX7z204RNeIi/qjGqku8bOOO8nukqstIRuthREzkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922711; c=relaxed/simple;
	bh=/yp9+cIos9koMvxwxLGdm08i9KRBbhwCZbpxjbWIwKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLKbmyRc06SVWrIlB6tRU1OmerDpG06nkPr5UzgqrdhEyzdngZNa8eOMUcIs+D+z1WAm2TS8kNz92LlRGPygYoXDtZfWMXd4uDUUkrzdHWqMZZIJZnuVfllURAKER2YaUeZLuySBjjINztEJj9vIGZZ9BDVhlA0WokMgWt1zksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R88goYEB; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R88goYEB"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb750so539549a91.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 19:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788922710; x=1789527510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gc/4LmELTKxt6hwR9Cs57QnS0HmHAvtDF3Qbdi4WaKk=;
        b=R88goYEBOzq9uBcVnFHZSFyRP32+83KfNLrXi+zCc8t1fJhpB95F3FwHbD0Ho23uHC
         teBq+rB24KA1BmNvzd+5krxYSB8nrYJ3Vp0cSYIaZ0QJkKYOgplyvOlQqPJnBiTaIMVK
         +s7DBude3PP9TdQ9xKuHgLxyK7SVmkoMuuJqrwAMGinZMxX7Uz6stD93AU7oE84CbXzQ
         wYUF+fJHtfe6XBRrufOEN2lxhfcj1xMS1tsurL6vfyQocDuObO8ePWdVZY9i0XfObMzU
         jT+IaopXPo3vD+mLdjrP162ylkHxvaRCxzb+YBHRXhzDWkFQH/quZvcVniyBM0Fda/hk
         Dtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788922710; x=1789527510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gc/4LmELTKxt6hwR9Cs57QnS0HmHAvtDF3Qbdi4WaKk=;
        b=qufQ65KandeKQ3ZVmCeOtAkvv/lJwp3PcM5Uvx73whYt3o8XPwNh9MdzdkvoxNWLD7
         /q2MfH7Ce1IMZoXgi4l6Ls8/kEPu6mGUG0fA8mcv8v8BoUvHS2HnRFLP5jhXtWwLg5w7
         DRcoFIIeL0qCwb76mbI1c7T6inoZ/FjaCg1/JPYY7qo4mo+xm9fVepU1HkOBeFU60EZ4
         hSg48xryqIE5/aamr/Zp3HRjyZLJEW5ohe8AH3LINxLlRte2wKA+2fO7Uw6bj/NB5zlj
         e/uxWpx2KUFdP1KT3A4dFd0IGyfRB/R6LdH1d/HiD3LrkpBpCeQt7b6SlSDKcVn8ecZZ
         ev9Q==
X-Forwarded-Encrypted: i=1; AKwUvByyRcPFPkcnxEDgjXuzL45UG1XBE00Mwb9V8F/vGXe+TkB/B5+jOPSAQ4ZQfReBVUSa2VXZeZQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n4WgHz6/4tJgVt3qDxUnOwRaUNn6fy1AyqLaZ+KrgJdch/DTgB
	ZZ7TjJV4Z9YLMxSQ6MkiXiem4JVMLttXk/CkNiEZleTig8f3YtlgI0g+
X-Gm-Gg: AYBFou1VYf1jRI2bDcGTJwZRK+Xq+OJmXu2+r0sD1Cksgq5T/TgEB92n08LZj0Z571V
	GGdfDfAit5EudscUbbN8XCQZmcQGwc8lfLEnPOwtKVE0iBLiZzGC5BvEh6gdjhTDHOAT28sam0D
	MZrPNAvxIQBKSxst3rpSgWquTz6wDFJ+nv81ZfuTgOvk9B/0AaFSV5a1OVcUr2AdaIUhYv4rx/6
	fNRjdOMKeMm3fgW3um1HYk2z7UmWqg7x2F0VmfO0dhsgWh73B9YJSuD/ECPhJhNbsOSDhjjWoe7
	/7M8kALnlZlz23TvFC8jEFVIH5h8EaQcZ+T6XrFOAFmPux3W0gAkKXwMkUfEYP344Tq/S6+gLBa
	kjhKRTKS3VAxxio2z1/cIaWmPEH8b49nkI5/fg5h9lq23mCDjcVrR9Z9rLjMFj25fqIIR2999jp
	sF/iERCWrCZQbmRnwa3itgFf1b4rHKroVwcVcGo7CQR17av6r0ZWUnqNez+4ipE/X5Ri+ag7E/P
	+BBwcyCCAC+iw==
X-Received: by 2002:a17:90b:5485:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-39bac34a3cemr4635597a91.12.1788922709582;
        Tue, 08 Sep 2026 19:58:29 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c39451sm35077172a91.7.2026.09.08.19.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 19:58:28 -0700 (PDT)
From: Vernon Yang <vernon2gm@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org
Cc: nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	zokeefe@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: [PATCH v5 0/3] mm: khugepaged: fix tracepoint UAF
Date: Wed,  9 Sep 2026 10:58:00 +0800
Message-ID: <20260909025804.3233645-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

The khugepaged tracepoints take a folio pointer and call folio_pfn(),
but by then the folio may no longer be valid: freed after folio_put(),
folio_unlock() or pte_unmap_unlock(), or not a folio at all but an
xarray-encoded swap entry. On classic SPARSEMEM, dereferencing it oopses
khugepaged as soon as the trace event is enabled; on other memory models
it merely prints a bogus pfn.

Pass the pfn to the tracepoints directly, captured while the folio is
still pinned, closing the use-after-free windows in
mm_khugepaged_scan_file(), mm_khugepaged_scan_pmd() and
mm_khugepaged_collapse_file().

This series is based on mm-new + revert v4.

V4 -> V5:
- Use a single trace statement.
- Collect Acked-by.

V3 -> V4:
- Only trace the PFN if it really was problematic.
- Calling the respective trace_xxx() functions separately on success and
  failure.
- Set new_pfn once after successful alloc_charge_folio().

V2 -> V3:
- Place folio_pfn() inside the xas_for_each() loop in PATCH#1.
- Already defaulted the pfn value to -1, to simple it in PATCH#2.

V1 -> V2:
- Instead of passing the folio, just pass the pfn directly.
- Using the folio_pfn() before dropping the reference or the page table
  lock.

V4 : https://lore.kernel.org/linux-mm/20260828055926.346744-1-vernon2gm@gmail.com/
V3 : https://lore.kernel.org/linux-mm/20260824092935.73892-1-vernon2gm@gmail.com/
V2 : https://lore.kernel.org/linux-mm/20260815051924.194810-1-vernon2gm@gmail.com/
V1 : https://lore.kernel.org/linux-mm/20260811133655.267739-1-vernon2gm@gmail.com/

Vernon Yang (3):
  mm: khugepaged: fix swap entry value to folio_pfn()
  mm: khugepaged: fix folio is used after pte_unmap_unlock()
  mm: khugepaged: fix folio is used after folio_put/unlock()

 include/trace/events/huge_memory.h | 18 +++++++++---------
 mm/khugepaged.c                    | 21 ++++++++++++++++++---
 2 files changed, 27 insertions(+), 12 deletions(-)

--
2.53.0

