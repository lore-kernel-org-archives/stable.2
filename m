Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C93B46AA88
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592817; cv=none; b=geT/SPUphnKIby3NlS3i/747K1LRpAaNhhrQjNTysBV7XifZ85KPnJnrV3jFZN6uDkuzrxB34VI4cL9MVXiGgQ4CpKl7O+u9Zr0r1IfGfSglLKCW+V3yFalUkhSHS2FUvLaKrOZ3FNSORrUcdErMVwbjq46HudBU1Sb8NpW6+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592817; c=relaxed/simple;
	bh=qkT9OCgkqr2UDi/9gAsgUINV/x1Hovd7tkcNjOTA37g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WIZ03XggE625mj+G6NhgGSkZUKUizC/0GfSs25P6WycLdlmk3O4ZC6fZy8xUh24uLxprPNZ/j5QXPJOSsuEJqoo8w0C5Ir6h6DhGTdAP2kpWpny3EXd9oIDrvtsZBzFQfxY32C20fusUmyau43npFfDut+gA4/zNrcpBpqh4K6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+uRVMMw; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+uRVMMw"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8ede3ab7aso482021e87.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790592814; x=1791197614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3R0NzwRxoc+Dqyc5P5ehqvEdn0d2HKNjoedIzM2Hkbo=;
        b=l+uRVMMwoZK5ViEMJzEbSwA0WeIi0H4c79/jX7mSAMJ/e7y632SQogFEpf/+kh6cdA
         PFKFibcA4Zws5+AT4eYoEG3LK00v/P+qrJIO9Pbl6FkYO4LlI+Mio2Hpw/hTI2lq4SxT
         czhb5XcxGo8cTgxgfOC+OQZg4+pdIO2rGnDbUrYTnMNjO+tEv1S9PBjOUx9Hquc3IYZY
         NZnakVg5u1O+sI6cZ+fgx9SlDUgfG5yTavoeyA+QruVgAMqk35NxdLD4Tpc3mKTbCcv4
         JvP9laNfk6vEoWfJtabMvmXzqUYsA5Do4S3uPYs7oyBUEs0qYABx/q95DUkFAaHKSZJb
         hBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790592814; x=1791197614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3R0NzwRxoc+Dqyc5P5ehqvEdn0d2HKNjoedIzM2Hkbo=;
        b=2fCxUEsTYFftkjuYM0ABfQQF/W6Ji6oJz41gjEWjbpYRs8Aj6zk37eCK5+EVkiPfJ1
         NznavGJXHjkpUUnq9+ShtXKbA8UR03ZkD/8hKwrxHwcvmBAai+rzrCxDStqCxKdc9z75
         AdOy7KN/dOL5RQar8+k5hfE9dfhffLufIjYeogIG2FntqRKsdcHpEFSuWZaNQBuDyE1F
         zszcPOcOpFzKC8OGTnbBVMc5l9LjJU+DBirAHJeqoMpTzWYL2x8SnoK+3KzKOPnh2Gbu
         ITAWR6sE9cHg/Tr9/mEJrhi9W7+CTYIeOhoV5Kx1TJYtlLf6Anyzg96u1aUlL2iXgJQW
         wHiw==
X-Forwarded-Encrypted: i=1; AKwUvBxfsoigCAJ9jUhon1QUh+CQMkqckqA5aNt5kSS0qP+GbIxLEvc2IFGKWewB2ITmyT2Ha12pXGg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIx6NdDEZB5m648QCic/JlpihACPOCBICVOjuTqJ7Di7rTvmfWE
	f3BMydFs29z/K5pYAVlzZn+obBWpm+JWq2WOfUD1LEj9gVjO7iOylRUr
X-Gm-Gg: AYBFou2UMosh2wx1ZKYK+bYyNhzbcb3eoyooH8yxxpfnPu/OxJbEAH7UldyS8t4lgnB
	T3GiilVRwpgoYYwY45ZhtZHqLFGsBcc+zBDPs43Lu/SIsnCOOICvpafTKWrLzcLDlUhu2FVpCWS
	FQ6eH1qtM68RTn3/M01AflLjtq4WN+p2miLyzYs5UB99KSuKjerlHFJ8onv6MdJ4oS3tHfNSSAU
	NBifG5JQa2wqDJ1KarOwDo2PZTJKRepRCmJD/YM/ujvob60vRDjfDySsPeSisJVu2gf9WJ7VNqE
	Y6e52U+FdNTET9o3gU7ANclfju/6N11kQzm83zqUq2AsIjZVutMyjkVCfrgaqrhQ0L6GL2oNQQa
	tSoK7vnBRk2wtP83juyo1cTOV3TdD9Ek1juCMel9MONfuVdFmSKj2LKoZSSLiuldMpVymC0jHGS
	yy5eajN+98irtNtLTj9tfu4lByb115thHcD4U0RwAFQ01pQGxOTSlaUZnhKaBqH5eNEjEUjw6il
	1DwelsQCmna9KVZSzTLUsY7VcEptXW0S1TM+L1FcOrREJRb
X-Received: by 2002:a05:6512:3c94:b0:5b4:97db:b740 with SMTP id 2adb3069b0e04-5b8df0db4e5mr4566165e87.20.1790592813333;
        Mon, 28 Sep 2026 03:53:33 -0700 (PDT)
Received: from sc-mac-012.corp.sbercloud.ru ([188.191.29.26])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b9debb04f5sm402819e87.35.2026.09.28.03.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:53:32 -0700 (PDT)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] kbuild: Makefile.lib: fix offsets generation with debug info
Date: Mon, 28 Sep 2026 13:53:29 +0300
Message-ID: <20260928105330.25427-1-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When debug information is enabled (e.g. -ggdb3), the assembler
output file (e.g. kernel/sched/rq-offsets.s) contains additional
directives such as .ascii with offset info and debug metadata.

For example:

    .ascii "->RQ_nr_pinned $3048 offsetof(struct rq, nr_pinned)"  #
    ...
    .ascii "->func); __data = (it_func_ptr)->data; ((void(*)(void *, pro"

The current sed-offsets macro uses [^ ]* to match constant names,
which is too permissive and can match unexpected characters when
debug directives are present. Additionally, the fallback command
's:->::; p;' strips '->' from any unmatched line and prints it,
which causes debug metadata to leak into the generated header
file (include/generated/rq-offsets.h), breaking the build.

Replace [^ ]* with [[:alnum:]_]* to match only valid C identifiers,
and remove the fallback 's:->::' command so that only successfully
transformed lines are emitted into the generated header.

Fixes: 7dd47b95b0f5 ("kbuild: consolidate redundant sed script ASM offset generation")
Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
---
 scripts/Makefile.lib | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 0a4fdd8bd975..32251eb6ca33 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -493,9 +493,8 @@ quiet_cmd_zstd22_with_size = ZSTD22  $@
 # the .ascii directive whereas GCC keeps the <space> as-is.
 define sed-offsets
 	's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; \
-	/^->/{s:->#\(.*\):/* \1 */:; \
-	s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; \
-	s:->::; p;}'
+	/^->/{s:->#\(.*\):/* \1 */:p; \
+	s:^->\([[:alnum:]_]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:p;}'
 endef
 
 # Use filechk to avoid rebuilds when a header changes, but the resulting file
-- 
2.54.0

