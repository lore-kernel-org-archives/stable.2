Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323653;
	b=jno1c/COQTx0m8h28OBFoS7UvFyyXsX9k/NEashdzBVTu29mhGljrYmPhua3XnfmZttT
	 iTMwDtCHLjMkdQ5db+GzJgRASgnv6DqbDuaNTTJTuq+A+bgpUZ/YFBxy3REf3HE8jjQNm
	 il/uA6I+88vyNd3JO3XUssrSv5Fkvip8ctc/V8GmhLPEmFiAtRiVAEFMeTm0jqOerTD/y
	 5v3X7mlrNSiTNUzgQ9Qthb/CvIQO3QV3NYrMGckvLPA21EMIphchfa/dU6Cid20a3KD6b
	 hbl0GnA/tRrKv8xkrv21JxsTEURRi8cv4e4gGrXLsNsgeXidGEQb8IsAZHvfXvuCERQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bcKBtRZaFb+mZfYAGiwpdRY8hHzgqYhO1XHVeJRGJgE=;
	b=HEBunpFvGw8aEbXNV76RJd2nY0ffSG+wi/sMcsCw7BSJNl2jRhOqbbWPxFx4GOhM8YGK
	 oK6Kad6hDCMR0RiRoFE1Cb/xC7jo6dOvDMQoKVzZ0N767XOOf+1u3UV5OGbECRXAEloPW
	 plesSGg0rf/Z58qkMtOk8lnyEQIegvO7T5zaGFIoPUKxPlm1cuzI5AaGB4Ap9keANRkci
	 wktSMhFToW39WVxsC7O+QVgnBPXTHuImyvQkqzYoAaVeg7B5D6riW9xTzhGgGsSTNBl3G
	 M324zmAY9PgfASKUqsJoNl+aQ8bZRTESecMFVNgQ6LjjWq6RZVV6lguORRQf2KnLZLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oR6cMwq6;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91C260A260D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C91C260A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oR6cMwq6
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso29681407b3.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323652; x=1794928452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcKBtRZaFb+mZfYAGiwpdRY8hHzgqYhO1XHVeJRGJgE=;
        b=oR6cMwq6lxh/Ii7xNi2aaSWRcP6NXX1MsgAn/+sd3oXpAmgAgClUrW9ZXOew/9q6Mn
         XdiOy2cS7Wb+oDXUsz9FuZ39PWSVhGV/pZoQBunW9LG8w5oLjawb6DalitUso75qeacA
         bSnwLovpdZusV3D1/LJug71TBKjz8uyRNjp5Lhl84RkklYyGnyz9SEDITlxiW8lRllNZ
         gj3NEJqSJWgIOcthpUHoXzGg+iMkot4w8Y150XN5UPLwZKpnOUHcBd1l345Lkq86eeI0
         xrIhX9IAk75wOZdz8bKeJFq4CiBOWwooSOhkPAYHE1wo2oCfJ0CpfpTN7A7gI2IYPs+c
         dwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323652; x=1794928452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bcKBtRZaFb+mZfYAGiwpdRY8hHzgqYhO1XHVeJRGJgE=;
        b=fGr2qQzRwsO7YtWR3SgnSnyGTVhR+lcTFVGIXl6k8KFhR0MXbNzuDorGRU5a13ZGSH
         CknE/ndoml9niQr88QPLD8vuC8YDTfj5bNBuIomgFCGeMbXWOkK9TupzSaYgsrtWVUll
         n2eoFQvHo/Z4Wbtumiyz3h7tWS3mu42nHtbfCncuyukDnTOuW8c0bitl1FUe4nz/k3z7
         E03H5GW43xoYQa8sKKf9orRPigxkAy19GMFTqfQeFLHKY6Jg4Li6dItyHf7MbKSzkKFL
         jCQemtvGrle3O3EUwv2wdAv/VOSESsymtzX7NYbhG+huuPaMzoVSt1jVdDqQ4Yl/qvug
         JJBw==
X-Forwarded-Encrypted: i=1; AL+hErFiEtR97nViXUEV688InhgEz2rSCCK8nczUNq8Z9Hj3iS4LbSRV6bc6ky7x+c/BkuW47Pzl720=@vger.kernel.org
X-Gm-Message-State: APuU4Z+99HHOEN4NkORWRrqSDDjQoVWnzwLxDpXHF/96pjxCh4JZ7eT8
	yg0mu+YIGgH4RHpea5klcDrrzkjZsAhKQBXIw7wMjcGXBpuF1ehzwCdA
X-Gm-Gg: AYBFou3ss2jYw1An8gIM7gw7A5Rm0WjR9tZWi9wVqxUZJmq6Hzd1e4vwQudHB182BGj
	0PWoWwrB7REOaTM+yOj+kfRPcO6tGxM2x7i712iikrOzS09eBXlQEPgEz+B1CUx3wMJEvfqARPN
	VkIUYrvLaRYjrw38o+SZ+TjreAN94LMW0BQv7+2X2WHUjVUF9BW47i/sZ3xfOF2XG1oAFiZ7hjE
	ngf2JGEhV/yjs/RzEnBdZRhrP629RWx/QjFYvrNRBxZPiVBqrH+KIg+B/ssuCs5AHhlq5Cbw6d8
	wpHTs0kKGSKRft7gca3LIsXcZGIxsmG5qs7xur+CcRpSYmCa1mghesTVFIDqedDR3aFZZWgVnmN
	+eap4l+IIr9a7fBfMRN11UJ3kgBMweEAOZYjQVdAkaRNNjnUgOe197mrIaSyDX20o86FkgPW6l9
	Da2dUDfRWD0MjPI78K17eoXa2q/VXvehMOFFaiS65Zv+YTToSf1Xrdtim1bK6KSzM+ma2anK1WK
	GMsaENDE+T7L6e4Eob1/rO4p8STiOwNYRnN1Pina7TZhUTKmqPRw0LO7PtGlT0rsNzAqeLtF892
	NzjNppyl5wY5/wP6dkNTWLRkVJ8zmBrvO36anqqH4PXqBoUk3oMVfhelFpXxwuLTUUAwtt1A8ei
	yhXSmA1Qby9qiVWlhgi6P8xNM/ZX9CD0JlIXxnw==
X-Received: by 2002:a05:690c:660a:b0:8b0:e7a0:ac5b with SMTP id 00721157ae682-8b39288d821mr18964047b3.1.1794323651688;
        Tue, 10 Nov 2026 07:14:11 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b39343d4a6sm21481757b3.37.2026.11.10.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:14:10 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	david@kernel.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	willy@infradead.org,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	ryncsn@gmail.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] mm: vmscan: allow writeout of swapcache folios without anon mappings
Date: Tue, 10 Nov 2026 07:14:05 -0800
Message-ID: <20261110151407.789960-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110151407.789960-1-nphamcs@gmail.com>
References: <20261110151407.789960-1-nphamcs@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unfaulted zswap readahead folios can be dirty and in swapcache without
an anonymous mapping. pageout() rejects them before swap_writeout(),
so reclaim cannot write them out while their swap entries remain
referenced.

Allow swapcache folios through the filesystem folio check. They already
have swap entries and can use the existing swap writeout path. Anonymous
folios outside swapcache have no mapping and already return PAGE_KEEP.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/sashiko-outbox-181078@kernel.org/
Fixes: 84798514db50 ("mm: Remove swap_writepage() and shmem_writepage()")
Cc: stable@vger.kernel.org
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 061fbd168d98..96201eae0ceb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -607,7 +607,8 @@ static pageout_t pageout(struct swap_io_ctx *ctx, struct address_space *mapping,
 	 */
 	if (folio_ref_count(folio) != 1 + folio_nr_pages(folio) || !mapping)
 		return PAGE_KEEP;
-	if (!shmem_mapping(mapping) && !folio_test_anon(folio))
+	/* Anonymous folios outside swapcache returned PAGE_KEEP above. */
+	if (!shmem_mapping(mapping) && !folio_test_swapcache(folio))
 		return PAGE_ACTIVATE;
 	if (!folio_clear_dirty_for_io(folio))
 		return PAGE_CLEAN;
-- 
2.53.0-Meta

