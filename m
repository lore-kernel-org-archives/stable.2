Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784997;
	b=qghYT4EPGlFlrYWh2kB5o0s99VUdJt7ZziAf84jWP+vEfWQu/f9eL7Uv/6xJPdB7OJy2
	 zEt59gb3GkZ2uz5lH/+GQMR93+zil7pKtzmu/e+VdMZw3xzXzC7OXLm5UqsEUfzp+J/3q
	 3PWjHqfUkps3ZtK93B8UMosea7QqF2vHyN8Xt0A0FvqFcXhkEzSHUAt8CmDKnBWZzjdHH
	 w0czu9iswvQWZ3G2tCbLGURckQZCwpumnJJsXLaR9HDYeyzqHpqR61uQAHktzgFDAxHtn
	 waqkJFgKK7cArI0X6uxVvL7M9RDfKVx3RDPJsMNYnFGuoLXCm56INWcDBJKrbz8XSVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JsLxVuR1g1JSvibC9g9YzUf7PO6/MZgJEB3OXBOD4y4=;
	b=k1yEBv/yJ+xCVGWDScNOjQMwDYM38XoZORe379gr0Z5jeXkrkkswJdJv0Pky7h1h4SNn
	 E5OxXoEGdYYsPLg9vG9Q+Sa3U8s7MglUwlEwAjSFyL+40391TJrTqBpEYvgrIYFK/MJze
	 lSd+0UaOebQrGy8Ha1+5qdAUjnwualtCVEwf4EqYzoXkKwbGqHDjJ+1cqoDcifUfCKx+/
	 tFw3k9+btfTHrd0z3TQT51mAlsuOB4YLvOQyWZBR7HoP3hVpM09LbiuQxxfj7ueyVsyyG
	 Zlaa2DOhNPwBlItKTwnEpxoSp+TAhy4eTui6egjIFbeorVphVFIM3DBLi5FJR+n5z+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stuoRtoR;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470B6606A333
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 09:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 470B6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stuoRtoR
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso383874a91.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 01:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793784996; x=1794389796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JsLxVuR1g1JSvibC9g9YzUf7PO6/MZgJEB3OXBOD4y4=;
        b=stuoRtoRidGUEY/NHOH/VkhsNHY7nu3HMo3pbT7UcNI9Ohmpgu9UEEOR5dYfwWVoIK
         asJQn+ju/y/hp6GKiUnWsd4jDFlyNfyJJ1xhQrXMEkut1r+G0VUJjCdKHQrXBQVdUQTm
         RCGuOjVlPXySS3wYhL/aIud3d6oOivlTqYlQ20AgFej+g4nfpOilVKbCNk10LdCeb268
         hp4AZ2QhkH2UAlddVkjD2T+bHQcFASyZkIHqvfRLEqgurtzx/o8GYhmfEA3DCcDPxzxS
         /cjPToH18Y3bg5j0QILen2C3d8KRDl9Y2nkRRwKcDKrN+LrBd4W3h6fIHa1Qj1bdeF03
         MyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793784996; x=1794389796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JsLxVuR1g1JSvibC9g9YzUf7PO6/MZgJEB3OXBOD4y4=;
        b=y66zWPY8QVMPCcip7RTJAOYCbUXQlTd0XQQKusrBiLrdB1BkjwAZHmEJH7w5ycujcQ
         pQs6M/BU5GnKXfytV7rJl3xwA1VRbuqZOtnY1ZdGbM+Pv+QX1Xh4773dsXwvBV7f4UB6
         sP8K2e/6qL2CO7CCu8tZbaBa3nx/A7Oc5z7X/gqC1437+jLuH3qhdqXAQZYaAAP6buRs
         pj6uba/T0dK4yXp5bG6+Yjf15c8a03HiaSmluz7Mm67IH4uULbOyn7trAvq46M85nam2
         BegkB6TpoUTlRHt1vVnumIYwJvzsir4KKNL/6Yr5JKyG6GMCdR0XD/bTkc5DUQMIc2sK
         MMmg==
X-Forwarded-Encrypted: i=1; AKwUvBxx3leRHp8kXYTZJNQ2HsA10F3jscIls5FSgc3g9G5Q9BPOFaxzjSDOgka3eZLvXq4jc0KSq9Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8ElsNJ64qRtQJnOX20IBrwZetr/ZUzX9jRLptGL/69UW81Rt8
	+SWXOjkW0v8IEhUdKy8pjfSDOZCiQ+PAfEFCs8uBmgT+kneEJwGeRwJK
X-Gm-Gg: AYBFou1HgxSF8Xtkh5NhQq3H/bYzMYzfojOkHw+J2yqlhi+eGYfKOcmHmbBYW4AZlFG
	TXNM7sWmcTLLjj2I0BudKCgBmW1dmUDCRy2srS1fwSgfvWpftzWG1P5WJIeq2hQPs5CTKKFM5XL
	RQyCTWPe3OAGP+7D6uBv+D7Yg1cI8SoQragC644v5o+y7xnGKbR/fMnh94wyxig0Py0MaYk072T
	RnBp2M/8HSf+pMup1qWU1JwCKTPBpxBESpba1PgiIuNIN9Pn2PiUOvZ3Z64QQe5X1FyYdqpAygz
	Y6aOa+dGdERxNxnEuyWBpla6hQhvWKKhqKUstb3enqfg2foWgvOQN7w851aR5qvMffkEXyDeFOo
	OSjJBbhdSLGqmgzXUehjjZqZnldOARVniJyFo7mFcaKY1B1upO/IYSwfSvbOlJ7h1aNOuUxXMZx
	SCS+gmSKIr9nilwSTtjeY/yIiVvI3B83bkvE2zx+2EKKZ3BKTtQ8bDYYTVxlVl/h98iuAsKF3tA
	krCVTycn35q0jo8VmzKBrmKZDJmUOwQDTccsYe9eGcsd0vjzXXbi04cGrLwa0RgMz2OfiUysLPX
	rIBkLUMtfCdvGIAspnfR6XHcqJi88RukTzKJlfL8/SV/EA6Jf7PQsXbqoyjS2iLpa0423Ov0Ng=
	=
X-Received: by 2002:a17:90b:4f8a:b0:3a4:ca46:840f with SMTP id 98e67ed59e1d1-3ae896f8655mr12708132a91.8.1793784996534;
        Wed, 04 Nov 2026 01:36:36 -0800 (PST)
Received: from umang-Inspiron-3501 ([2401:4900:1c60:e7b2:951d:848a:7f25:3900])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7e087csm8569454a91.4.2026.11.04.01.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:36:36 -0800 (PST)
From: Umang Pokhriyal <umangpokhriyall@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Umang Pokhriyal <umangpokhriyall@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] userfaultfd: validate the whole range before changing write protection
Date: Wed,  4 Nov 2026 15:04:57 +0530
Message-ID: <20261104093457.152245-1-umangpokhriyall@gmail.com>
X-Mailer: git-send-email 2.53.0
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

mwriteprotect_range() checks each VMA as it walks the range.  When a later
VMA is not registered for write protection, or is a hugetlb VMA the range
is not aligned to, the call fails after the earlier VMAs were already
changed.  When unprotecting, userfaultfd_writeprotect() then skips
wake_userfault(), so threads blocked on those pages are not woken although
the pages are writable again.

An unprivileged process can trigger this with a range that spans an
unregistered VMA.  It hasn't been seen in practice; it was found while
reviewing the userfaultfd range ioctls with an LLM.

Validate the whole range first, as mrwprotect_range() already does.

Fixes: a1b92a3f1498 ("mm/userfaultfd: support WP on multiple VMAs")
Cc: stable@vger.kernel.org
Signed-off-by: Umang Pokhriyal <umangpokhriyall@gmail.com>
---
v2:
- drop the redundant error assignments in the validation loop (Mike)
- drop the selftest (Mike)

v1: https://lore.kernel.org/all/20261102103621.156928-1-umangpokhriyall@gmail.com/

 mm/userfaultfd.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 87da92526..1b7320d0a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1105,21 +1105,26 @@ static int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
 	if (atomic_read(&ctx->mmap_changing))
 		goto out_unlock;
 
+	/*
+	 * Validate every spanned VMA before changing any of them, so an
+	 * invalid range is rejected without changing part of it.
+	 */
 	err = -ENOENT;
 	for_each_vma_range(vmi, dst_vma, end) {
-
-		if (!userfaultfd_wp(dst_vma)) {
-			err = -ENOENT;
-			break;
-		}
+		if (!userfaultfd_wp(dst_vma))
+			goto out_unlock;
 
 		if (vma_is_hugetlb(dst_vma)) {
-			err = -EINVAL;
 			page_mask = vma_kernel_pagesize(dst_vma) - 1;
-			if ((start & page_mask) || (len & page_mask))
-				break;
+			if ((start & page_mask) || (len & page_mask)) {
+				err = -EINVAL;
+				goto out_unlock;
+			}
 		}
+	}
 
+	vma_iter_set(&vmi, start);
+	for_each_vma_range(vmi, dst_vma, end) {
 		_start = max(dst_vma->vm_start, start);
 		_end = min(dst_vma->vm_end, end);
 

base-commit: 74d73ffcffe03804f97e9fb82301dadf75671282
-- 
2.53.0

