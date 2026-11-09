Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249311;
	b=5erCXpkEQ3Ef7ZhCSKJTX5oirIdP9yA3I5+0icHRidH+StAcjHEhPbcjofaFtPY5LjKj
	 3nnuZxSrtWVSkwAUZQUyF8bR4Ybt11dRZ+VoQ4DRbc71+Zfd+8MYSx/KpVwSaXuIWHLF3
	 5J3cxpexPyF0i0kaJj1wGqG29Qlfssa6xpAvwVwWUPw0a10j+uFloE4ul3b/O+5b5BzmT
	 wliNlZdlXbFqPj6T2QXXX96x/tqU7Hmm+vSLgT5kOxqssQzFQFsK3R3/snaSbvuf8egXH
	 XiF/jTuDEU+6P6C6rqHvF+uHE5atKkXFg1Xuu0DGGAi+IHYRjRCqEAwC/j4ek5IIKtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249311;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wdnN+sQlajVEoVpH0buQnH51ZS1/i7oAbyWmnuPlXis=;
	b=42zQh4VwWxS6klPeUToCVWWr6FNB9xl8sCmTz9Ockf+Z05rxNATCg4umrg/XI3gX+WT7
	 YqXvgUv8sLgfnfpr79OCD3dQsn7gOfGRo7C6811Iod6HMo1Sq8mmrmvcD59Xo9z3AgumZ
	 8xs2kjSGACXL00yJkPMfmvZA9hL9Gts5c/HSCCLR1IS1cqtBPMX73l3wQNvHWK/671q0k
	 WRCwjFZ73A+dwr8YzwhpNaM7tDzzQxQduDkwtb/qHgFTNbKf0OwtHNAcLyOcDpmJS3il0
	 6Lg6P6ISAsYeKO0+49ETyhjifaqp7XEPPlGJ1UQtlCg0WkQlEvO1YVJqOeD8dBesrkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=kPS1hr0K;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBBE606A5FF;
	Mon,  9 Nov 2026 18:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFBBE606A5FF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=kPS1hr0K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1794248809;
	bh=+0LAwJo4Ty0qoQXCDWuXw1iK2qfnJ5rJryT//pIRZ5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kPS1hr0KB7hypW6/VjW+i7uckX9o8qzWedcZRDAazdB1gW97iIMVu4KThAyLMOnYZ
	 AxsyVw055wzvPjK6hNbsVpZsen0MCGcg9fGxIlnoSdbFIOkkra0WMJ0qG3cIBzx/bu
	 N+obpZd/6hgycWlk8JQpejAGNsRgmPSRo7WyIM4M=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id F2785402BC;
	Mon, 09 Nov 2026 10:26:48 -0800 (PST)
From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Date: Mon, 09 Nov 2026 10:26:47 -0800
Subject: [PATCH v3 1/2] futex: Canonicalize arm64 tagged user addresses
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-futex-tagged-uaddr-v2-prep-v3-1-3f5f2ef83138@gentwo.org>
References: <20261109-futex-tagged-uaddr-v2-prep-v3-0-3f5f2ef83138@gentwo.org>
In-Reply-To: <20261109-futex-tagged-uaddr-v2-prep-v3-0-3f5f2ef83138@gentwo.org>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Shubhang Kaushik (Ampere)" <sh@gentwo.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794248808; l=1608;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=+0LAwJo4Ty0qoQXCDWuXw1iK2qfnJ5rJryT//pIRZ5A=;
 b=aTLJd4fkjvjQdkXIb2WUpDNI9H72Ui03ZsgFCJQV3iYAVMiGssjldH8eTmLCh2kXAoNoKDcv2
 OzSxDSBKGqnCaLI/IyIvKMhyTlcL2XLt7Q6DO3GX0hIxYt8B/q4tKJc
X-Developer-Key: i=sh@gentwo.org; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=

On arm64, a thread that enables the tagged address ABI can pass valid
top-byte-tagged user pointers to futex syscalls. Such a pointer must
have the same syscall behaviour as its untagged form.

get_futex_key() validates the user address with access_ok(), but uses
the raw address when constructing private and shared-anonymous futex
keys. A waiter using a tagged address and a waker using the untagged
form can therefore access the same futex word while hashing to distinct
keys, causing FUTEX_WAKE to miss the waiter.

Keep access_ok() on the original pointer so that arm64 retains its
per-thread tagged-address ABI enforcement. Canonicalize the address
afterwards, before it is used for futex key construction and shared
mapping lookup.

Fixes: 63f0c6037965 ("arm64: Introduce prctl() options to control the tagged user addresses ABI")
Cc: stable@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
---
 kernel/futex/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index a240638f69e5c65bd036434a15f3df680efb4638..dcc8ffca38595a5ea69f3672375ffb9f9c6766f9 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -539,6 +539,8 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 	if (unlikely(!access_ok(uaddr, size)))
 		return -EFAULT;
 
+	address = untagged_addr(address);
+
 	if (unlikely(should_fail_futex(fshared)))
 		return -EFAULT;
 

-- 
2.52.0

