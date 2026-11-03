Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720391;
	b=Bdtop3nKsHN94p/PTgVn1vOy0YeZLi5LBtAN0rCad6iWp1trhP8LwgVDNFJyg455KMwA
	 RALZuvvh76k97hrukPbA/otEMnfHos2KwlNiuolH3lMzrYS0KTWrJBr52eTXwFMLQfFga
	 VZJ94WAX0wEpMEfb4S8l32Al5P3/eSLJuD/sF8u/ZcwTfW6ywzN8gFDgCHoHCcSQCPMll
	 tt8LJ697phwOmLLGG14/ZRKdV8DmmsiwSPgtkT9Lp3J3bL3DTjDuZ5qlY3XTtXqCRswBW
	 kQ+uH/qcsFMydazyjlzGrQjgh0rcX5WONt7qYzT34dLF2HwI0zv4XqQugucF0y07oag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j3f7/TUv5Xo7Nj2qDzexywJb0Xg99uvLe5xi0xEDiRo=;
	b=wYQ1wH4r1P2jbX36+GBjJx7LBKisfVvhst4S3lYDjPfHdO7dTrDml4tIouCd9Ns3e8aD
	 F7tSj6gHphYPg070vYwFPmTZDLUtAYqfn14+LTwtn9cTg4dwSIJAak2yut4oren5AiWL2
	 liajdZmPM1XZs/NZ3IK2m0+n8wmWNU8mQ5vLe4rkLo4FnHCIvMqFGPhw4O1UAK4Ev3/ju
	 gXHTgRcY2UmLcitO21SfLPjmbpsGRyHWKssjGY+jlKjD3rt/ppXMesgRSpP404jYtbgbH
	 9MhpxH3PThmKwbB+WBifRxfCz1rCDV9kBZLUh5s2Lkl9R2GtqUr4r2qo8vCSnbrKgNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q6bxeBuj;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687BD606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 687BD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q6bxeBuj
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3282db206d3so7291971eec.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 07:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793720389; x=1794325189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j3f7/TUv5Xo7Nj2qDzexywJb0Xg99uvLe5xi0xEDiRo=;
        b=q6bxeBujD1wo21D45eGUJ3CvlKBqxUu5ZblXDlqy6I8C1Km8J1bkRWz+5bQaLizYwP
         0gPAMg6EEB1vErHRYcefgtoPlus8JsJZly85cfpTJKOGsDIfCQa/4mVpeTcHd9BnY9u2
         rOP2ZUVXr4BkJfnwzaOvpS6mFrITLsvXjqAIM8XhKVI8xtMSlGlbmYt3Jl0rChyZCf/9
         qkmPtmdx3kRaoHjmhqjagE2J1SFsVE9/oQ7p5beguL5i0REIhcc7baNYgaK2raobqp3b
         /gXu8TqncD6LvDCbcwZnfaM6LMPlxHr11s6c4LqOVT5SCjOndgeRQJV6G8bT0QeIGim2
         SNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793720389; x=1794325189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j3f7/TUv5Xo7Nj2qDzexywJb0Xg99uvLe5xi0xEDiRo=;
        b=J4V0w9RbS5EeNTpze2U0snfwFccwvZ+PyWMNh9POUqUfWiXVDN4hWb3EBpa3a+BfwS
         wd/VLhObT1bFDMKFvBr4887NHBqXYFHoE/77OB6waYeWrpNCvRXTxjEGtW2WZbn0z4rA
         XG2xEA6mJJd1yBawKH2Rbl7QN6577SPU0SHASUCD+dwaaxI/yog7zjszUqFTc8fksiva
         aVhye0FVlmhqRwQg4REmZgdAjNtiPuaLI8a6+Oj48bUvGuQM9keOi5AXJgPOAU3u+lw5
         CAyXEjJsab7+hu1UU/sSZHBMueHi1udVDN8XylEvt847GZShVUegW3zCsONk12z/Z7fE
         OBOw==
X-Forwarded-Encrypted: i=1; AKwUvBxKm8vWIgRznivt/brOJ/opTvda4kKLOlmHloDAHtSuAdyvz0Ic2gOwKmNGRvtWCl7t6TFgdLU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yUPp5LB6L2ZFtfJlGAI2Wk9pg8FRfi/V/1k9N5+0CgFQ9twYB
	jignKsyfvzX/OCIgS4aic085WkJsHX+uRrBlbJvaTzkj54YUVEMisXFe
X-Gm-Gg: AYBFou0OtV1NpUzZxOZxBiv/Ff1OoUYP0EwlhI5IFK+I2cfSbhr0IWLMS4rLltu8D6k
	AtTMK0KoZz3KasqSYEt2mqLdqNFLgol7cWgQnt/kKZEaGeK08FydMcD1e3/2+3bgY41rpN6FGrR
	KR0uw225HumIFUxHlfMVDSSKWRIzyvkxyrU85RpWagnZ7/2LC49alTP63lK7XMIRp7HFZsY54ds
	BDmdXN+oG6H0NIbuGWd/Crkz4v3k7X4nnlVb+Eyv6sUtonWqFV4aJIlYnmE/rnNfK/HCa0U1XLt
	+q2HgEB1F9cPlkUue/HeMYLDBH2iqxf1Nfbtk/Th7kRfX2ZHVPjunmBYkpoOoxQL1Kw7hNyBaw7
	7Q9Mv9Wv6hnxvmzwOzlZtyYgEgoSMoL0YnHMbcqEnOCCzJXWYkUFkyK+ZFwVBdycnxDur2B9g3f
	zpHuB3e3w2UADs7X68CNVDFpBbAW3pKiUGeRueimIvFdUk1ZNssYAw/nna7dpT9kt9vgyPjSQBs
	W7BnO/Jqou2NRwbIbIPbWJiMaoJ1IFOzOv+H+Ec8Uq20LgifZwbRjC9DmBSJ76XPOGkWLu1XLVO
	/Kbwdg42oO/fvZ72O//iVPLEyKM1qtdEHgL11OjXb4GzpSOFSaabPcXi
X-Received: by 2002:a05:693c:4084:b0:36c:9c64:c547 with SMTP id 5a478bee46e88-36c9c64d2ffmr1854274eec.26.1793720389408;
        Tue, 03 Nov 2026 07:39:49 -0800 (PST)
Received: from bridge.. (deps54-26.deps.ufsc.br. [150.162.54.26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428aed76sm50492703eec.9.2026.11.03.07.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:39:48 -0800 (PST)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] liveupdate: check for duplicate session before growing block set
Date: Tue,  3 Nov 2026 12:39:28 -0300
Message-ID: <20261103153928.716753-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
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

luo_session_insert() grows the outgoing block set before checking for a
duplicate session name. On -EEXIST the new block stays in the set.

If the session count is an exact multiple of the per-block capacity (51
with 4K pages), that block stays empty. It is serialized with count 0,
which kho_block_set_restore() rejects in the next kernel:

  luo: Block contains invalid entry count: 0
  Kernel panic - not syncing: The incoming tree failed to initialize properly [-EINVAL], disabling live update

Check for the duplicate before growing the block set, as
luo_preserve_file() does with the token.

Fixes: 2a441a14c2c0 ("liveupdate: Remove limit on the number of sessions")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---

Notes:
    Tested in QEMU: create N sessions, retry "sess-0" to get -EEXIST, then
    kexec and retrieve them. Unpatched, the second kernel panics for N=51
    and N=102; patched, N=1, 51, 52, 102 and 153 all come back.

    Based on v7.4-rc1.

 kernel/liveupdate/luo_session.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f48e9a4185f9..74bc66929f4b 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -176,16 +176,6 @@ static int luo_session_insert(struct luo_session_header *sh,
 
 	guard(rwsem_write)(&sh->rwsem);
 
-	/*
-	 * For outgoing we should make sure there is room in serialization array
-	 * for new session.
-	 */
-	if (sh == &luo_session_global.outgoing) {
-		err = kho_block_set_grow(&sh->block_set, sh->count + 1);
-		if (err)
-			return err;
-	}
-
 	/*
 	 * For small number of sessions this loop won't hurt performance
 	 * but if we ever start using a lot of sessions, this might
@@ -196,6 +186,17 @@ static int luo_session_insert(struct luo_session_header *sh,
 		if (!strncmp(it->name, session->name, sizeof(it->name)))
 			return -EEXIST;
 	}
+
+	/*
+	 * For outgoing we should make sure there is room in serialization array
+	 * for new session.
+	 */
+	if (sh == &luo_session_global.outgoing) {
+		err = kho_block_set_grow(&sh->block_set, sh->count + 1);
+		if (err)
+			return err;
+	}
+
 	list_add_tail(&session->list, &sh->list);
 	sh->count++;
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

