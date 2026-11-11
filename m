Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355572;
	b=AFBeIu0HiCskl4rUw9VwvtTb4yJQklzArS4kAfF2jADtktWjaeWre3S2J6kvQZLEF9rY
	 NAJrIe3InGxTujJ8rGfTk1pNYUxfoiQ9Jzi942Mod6VgGDyNwUpCEs86yvU4wYkBd0z9E
	 ZSlgSL+IMeJRkbZnIqd9kGkMJbvkDV9JuwsdEuvR4BRSukqL3wHTanTPTRlzmxEQUeEOi
	 0oDMXjxfaH37wDRsBFzSqMn7rbhGRXIujL1GpeNgsUEs4gUjDWcJKP9rP1luWL+suPYiz
	 i0zbKqpsymOniIkF5VByHWf4iqtL8y0nCrT+34kvCjObxuhlYhAWYeOKQiQ6xCufp6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=zkMc016KFQss26hsUBYH81yigcP2cnZcPssEd1OEOKs=;
	b=Uytrnor/kD+a36zqBkmYGZO+Cl9E8R61O0fBpd7ZHyNiU9vrLmgsi+V4qXayeR7x94hA
	 29VrSsdmbvhmH2ke4dYQN0qOomibnURWR4H/Aparl6HyCBiyzR/664kv+qn3XcwCkp6PE
	 bkQnoRaYkeBTq+Mj7+rvsJAwFHyb5t51NiyNMA2tgKwph2EO5DyU0iIOE+CLhoC897FV+
	 E9nmTqPL5xceyoGqExQIU2SEV8TmfpHSOoLcMpFkoigO3tCnTVcY0gW0pA44akCR3yXcd
	 rJgn/OTTV7I1wkExEvLaaV/yPINR/ZBa6Uq23RhFNlH8y2xRYhjHouLBWo8yyI5qfJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S2PKaARg;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88F60A3809
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF88F60A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S2PKaARg
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4ab8b4887d4so1797960b6e.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794355571; x=1794960371; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zkMc016KFQss26hsUBYH81yigcP2cnZcPssEd1OEOKs=;
        b=S2PKaARgOGszLEnvw8zzJIncod5XIkAvj5N7PjYf1lqmcaZ+M+4UCKHT3cvQWtfFp5
         kWymndHjl84p9DpY9DxyF88P/ZIGLOibknPzKtXwOtfTDS/kC8zziU8LTLAMJOOv5tJw
         MqS2hMhAJbFLjQwBbnWyzj7igksn80j1tGATpDFGc16oCFiX0/+du0vjYDnXy/Wtegof
         ocqb4UzoiqVwtf9oZBUqD7AqxJOKfTIYLbnrMzPC27rW6abQKxrXqeXBO2vF2d7Msf5U
         /dh/divI0fmNSVDzQPnt0b2UBcfAqxbflj0iTx6cX+vzt16KnKIUbIlUQIe7L49ozXsA
         J1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355571; x=1794960371;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkMc016KFQss26hsUBYH81yigcP2cnZcPssEd1OEOKs=;
        b=B2EHgog9nDmC1vASEUuJ4rKvbcaAx8AaPLejZZebHbA4dMonARSH+ILEHzaqHXKfwe
         D4jPz/oSevHieFwQIRKpRx/B/GXPtDM8/uf/EWJxr0ccd/IlfWrtH5D74vZld6/N1Tf0
         tIr6ObTryKurWhl5bOyQ4fEn5ghr+8XWEFwYwijoGMOlqTENJGKmiGFBS9MMLQ6L1a12
         0u6/7nXToJreCJBbglVTDBhDO8zjcfTKn1XDnaUGE/Km+gN81k42SNcgei2ulNyDcPYI
         ThldNLc1XNtSuI68bS1VETy3jKvtW75tRpZPXTbYPwpUM8+aoaLmY3yLHbM3bXzEQcyy
         bjgA==
X-Gm-Message-State: APuU4Z96FVt0/oDSsxOmymrFr+xtp7Y5cMYOzbmD3ZIyTMyKKfeB3ZF2
	rCgKOYn/VBUexnvlQAvXmwp+CM/aEHkoJj/x4Tfq6azSWx3TQZY5OpnCSipr4BkRAYWS2jLkynm
	7T6x00IUeeGNtu3GFJ6VizZEwgHWUkykgqQ9C4Kw3qCfMQ10CF2LRs+lpbPtjw7wEj6ALrzxkgZ
	cpO+YsDTDhcYFhoA+GFSMgyEiBiZUg9cC+TV9tk5S8FMZh2GM=
X-Received: from jabiz8.prod.google.com ([2002:a05:6638:8808:b0:61c:c9e4:2a76])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6412:b0:567:f627:67eb with SMTP id 5614622812f47-56b967bda7bmr614678b6e.25.1794355570371;
 Tue, 10 Nov 2026 16:06:10 -0800 (PST)
Date: Wed, 11 Nov 2026 00:06:04 +0000
In-Reply-To: <20261111000605.3227011-1-skhawaja@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109200936-failed-6.12-71555ae8c757@kernel.org> <20261111000605.3227011-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111000605.3227011-2-skhawaja@google.com>
Subject: [PATCH 6.12.y 1/2] mm/gup: fix clearing folios in memfd_pin_folios()
From: Samiullah Khawaja <skhawaja@google.com>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, "Pratyush Yadav (Google)" <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"

From: Chris Mason <mason@kernel.org>

memfd_pin_folios() pins folios obtained directly from the page cache
without checking whether they are uptodate. However, shmem fallocate()
can leave newly allocated folios uncleared and not uptodate. Callers
such as udmabuf can then expose uninitialized memory to userspace.

Clear non-uptodate folios and mark them uptodate under the folio lock
before returning them to the caller.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify description and comment ]
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-20-d6437171ecc3@kernel.org
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
(cherry picked from commit c83ee2fa5a94edb2e04102b9dd4f1ee0eeb2b932)
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 mm/gup.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 810a4c32ee87..b4746ab82dd1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3774,6 +3774,20 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 					goto err;
 				}
 
+				/*
+				 * fallocate() can leave folios in the
+				 * page cache that were never cleared.
+				 */
+				if (!folio_test_uptodate(folio)) {
+					folio_lock(folio);
+					if (!folio_test_uptodate(folio)) {
+						folio_zero_range(folio, 0, folio_size(folio));
+						flush_dcache_folio(folio);
+						folio_mark_uptodate(folio);
+					}
+					folio_unlock(folio);
+				}
+
 				if (nr_folios == 0)
 					*offset = offset_in_folio(folio, start);
 
-- 
2.56.0.542.g3ef89b7020-goog

