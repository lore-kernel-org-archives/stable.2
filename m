Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF430E821
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563805; cv=none; b=NhqkB2aGhC+DVqeGbd3byhY/6dqq2wONeuXzasTxk2MqKmaqkx4amR7VZz5SyxkZU1oX3SlB/EBbgCB7LdlN/00MefcXFgUTm7UQMH3hVNquhPlU4W6wZoGTr7XjZiIUKFMPRiUTUVFDK46OvjKQanZi0DULHI1papq+b51JVSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563805; c=relaxed/simple;
	bh=B3PrhrTJv6So4f7GRIVWNL1Mx+SV1o4fVI1hxjaQD1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+H/VnAtNAWKHqYMYctK9JsM/2UdqXNmplmIqGVk4qWyb9wIGvVipWDw72YHDS7oqi1v4IFuiv0gDu/JThegkqFf86sBcxtQcwLSPQtgis5xoZucleB1Ii92XDnr3K5j+2f7Xnyg6zziDGFJswRlpfGtzVXjxuviP/1FZg+rb4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCxHA3hi; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCxHA3hi"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca7c1176317so2712779a12.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787563803; x=1788168603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DGZ9Z1DPfEdVHcTUddQdNEyq05aFRAjwLdFGsMJBr5c=;
        b=pCxHA3hiwA/c+rwennz4/pXnULowwmaDIPjhwIMdxdwOTlhbm/tWYuaHSUL3xp6aZN
         xmiY/PX1/72mZaOoRsBulhpNBvr21bV0UsaIBNH6YM0zFwFIFp2pudVOhj28mUE7Rys0
         XJbqhHtcZ1zsopsm96/EvhwdTBLHYUdO0LQbZ8aUEMUnllhS3MUTRo1f6LTk8d+Yxq5e
         em59F8BlL17odWKsba2ux2LFuJS2mArm2Km336QFormaON43Xj8qxl5QDVcUkcIAhj80
         EqcEjbNFXHJ2w1KnkD16VtvlEj14XK9YSY07T/mtMC4O6Jm2dgE0QCXk4fT0ftBDhk2A
         9vGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563803; x=1788168603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DGZ9Z1DPfEdVHcTUddQdNEyq05aFRAjwLdFGsMJBr5c=;
        b=KMbXOryqJ9enMkM1i3XE6xk4n9DIKpHlVJm2PaHuHwkjHhKOFohlgwYilqInv1UQBT
         eP2bWF7LUpos7o5EbcGhEJb0XhtHZxooQJ8efdwAczKLsnMaALQONBj3jYwkDT0GNkY1
         jEQa51eo4XoJBZzCOdylWe4vjFdSxDpbFOAV8YCaYTF89/SmYa6XJuoRWUK4pxJuOjF8
         iS1vFV3AG6bjxc7h0UIa8S6zFmcY6K9JijJRSTwBH5IkSyqqT7nLQvzNQYjwPkAm8TiB
         HfVcnrXLjnwrnpThAUzyGlKYkT1oJ2rhj0EfHDo8eH0PLLT5i8lq2Guy42ICsQcZNZVI
         xApQ==
X-Forwarded-Encrypted: i=1; AHgh+RrfoO/6sJvL7Pf/bVCHhaLuH+Gjm9AlkvIBVFhW09PwSjZelwBulDJxQ2dgihMoybsMMzQLA9Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lQiBmm31x1J87CdopSeSZtGR6yphvRbXDZJONkZ/AAo06cu/Hg
	ZyJDmkpMX2gZsNyIWf1UjKCcufjQJDeZessNcynAdC6L5RT3eVxX8qjO
X-Gm-Gg: AR+sD13/+TsKt18yppd4138sbFjeFQe2OAbQZx4bGvWZXXm1q6/CvKcQyzddVElXIRL
	CjcQ/PBravyHJQLXTfFaZt8Nn/ejjJoskOCYErrUoIG60jZgaaAuSjHHryO8C1yI+HWrqvqFCVq
	/Kis6EU2h+lJk68+ckkFpReWfdRpeAEzOy4TPg96b7oybhrpxlqI7BKozGtC121uCzCaJuIrpZ0
	EZ5I2lgJj1lNeM6P5NC6EiJ+zqFIKTk8SHvECAzlr9gQpi5/qV+AWwJ98sgW8mCsWisuVdV9aO/
	WgnFV3s9TVB4kqOFurASKA7SOcu5orACKVsY/ZA2LbFsoOf7n5ZZZgWoQoH6dbZyV6kHdwC1mn+
	EDUNPTYxax8yj5r4KWQ4y3v9LyEW/Tc2DzTNxJybPTU1dWJ8kFjgCMY36CiaUT4HU1LNhQyBJog
	7JTG6dw9JNonM/iHcY9XrARYnGDhImpkqfEazYLDBqMMdGx4i9lOtr9wt90mSfNmzeRYRZ1owKb
	MI=
X-Received: by 2002:a05:6a21:d89:b0:3cc:f008:8125 with SMTP id adf61e73a8af0-3cd4b9a9fabmr34624401637.1.1787563802568;
        Mon, 24 Aug 2026 02:30:02 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e60035sm845226a12.22.2026.08.24.02.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 02:30:02 -0700 (PDT)
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
Subject: [PATCH v3 0/3] mm: khugepaged: fix tracepoint UAF
Date: Mon, 24 Aug 2026 17:29:32 +0800
Message-ID: <20260824092935.73892-1-vernon2gm@gmail.com>
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

This series is based on mm-new.

V2 -> V3:
- Place folio_pfn() inside the xas_for_each() loop in PATCH#1.
- Already defaulted the pfn value to -1, to simple it in PATCH#2.

V1 -> V2:
- Instead of passing the folio, just pass the pfn directly.
- Using the folio_pfn() before dropping the reference or the page table
  lock.

V2 : https://lore.kernel.org/linux-mm/20260815051924.194810-1-vernon2gm@gmail.com/
V1 : https://lore.kernel.org/linux-mm/20260811133655.267739-1-vernon2gm@gmail.com/

Vernon Yang (3):
  mm: khugepaged: fix swap entry value to folio_pfn()
  mm: khugepaged: fix folio is used after pte_unmap_unlock()
  mm: khugepaged: fix folio is used after folio_put/unlock()

 include/trace/events/huge_memory.h | 18 +++++++++---------
 mm/khugepaged.c                    | 15 ++++++++++++---
 2 files changed, 21 insertions(+), 12 deletions(-)


base-commit: a032d41a86cb82a747bc14d9c82b3e153a9a9ab7
--
2.53.0

