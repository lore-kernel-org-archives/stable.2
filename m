Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821159C965
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792098118; cv=none; b=e1TvLUxdPlBZuKZGVYx3xGgpCWbLw+5y/z6rcXHQerWJvGk378SOLg00naGxamjFeYuEFsdbYs3QAU5cNsedTlnqhEfqSQziG7GFpA+SZPK5cRqpntJQIJo76Wl9wieaRVjkvaR8+m31JgcSEOuzg6sY4loyhg4aOIbWqShTG38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792098118; c=relaxed/simple;
	bh=CrId/mzxO173Pii4jucd8wzO7SQYyYyWQ7bm2bVwkio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4ljSK/XtzxOYA7QZtT2ttGxinMUHeqWMafHRc0CQXMBe8sR2VgJIAjEK2+M7c9KDkMw4ul+tSIT3CJVW5gBVgqqXzsAlklzOVmB14eONUvRarzxGDNlx23vlIvYU7OIw6D7+dH13JRw83iuPs50ojVG020J12loVREaxAOCJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smQXQSlw; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smQXQSlw"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be3db57938so985603e87.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792098113; x=1792702913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ycEiSjweMphxeT+LmW+Ybd3KfInm2+XUCR6PcOqNVQI=;
        b=smQXQSlwtFI22NhLDDLPsYXq5WyqNBAY1dwFtXXZKKVitnTjDn8s52LaC2YayRQOfE
         sZezujv0DVwVAT7Nlhlkp0E6xRLsPqN817HYEnc/MkVMMSHAgh2DuafBtGSmTQiQifpW
         Yfq1EkygRejqYvpkx+BH5olOtK5Ey2RYFFFU7KRVYEkwnac1E5NXeA01cAH0VKeUQ2fU
         zabcXiihWbYMfDJN4rfJ48p/8Twj41pb4B7Tct5dWZS95LMaBMn2vG0IM3dPZX6t6hDD
         LLz06EOOWtGkYoO5iebh2G2hdM9hQTEWSDCoXHvcySQXK5U5GofW09SScQKTg5QcU10H
         ZMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792098113; x=1792702913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ycEiSjweMphxeT+LmW+Ybd3KfInm2+XUCR6PcOqNVQI=;
        b=uqHw6tLfVsS30LuA+uqSQs8LPL3eq7b+DaszYLB7xpqA+h5YtNgV6TBLlTB3R2ARXb
         QPneJE4mTgd2bPsuOl0swZ63zu5gH7HIr0uI7m7rJeu6ZNLbHS8TMWerHSoYNkAHmG3K
         iVdVOK8EZYd1k8neAWjWfcOGCiCR4kG2E7j1AqZI/JszJ6sfDUAK+enKo6xgBAJ6d+Bn
         DFGMSy8//q5mxjEMlo3xQbgnKqwncmA6w6+rDGz+WGa++0qArguXeM9BTyt7wrposOo5
         ZbBZyxmYMzPKH9tQOthQatY0wFIQq0Mro1o6LjtDmBrC2H8HJNs4HSrerjX47rvLwkVE
         FObA==
X-Forwarded-Encrypted: i=1; AKwUvBxvCanEcLdw6+kxv6dOAc8xNCoLnoLixMz4wv42+Pz1quftSAF//5K+FL7O58+BWEIJveMo7rk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUEpjTVhMZys8n0I14x43Mh+SJZa7FAYOIXv/aMCyxvtBJ2Yae
	Vsz6pwYvbYPo+X9dW3H7bTP7UMbQiLvZe0BtDOGMBTlAY63Dx9O82DRS
X-Gm-Gg: AYBFou3NClWz6ejbf0z6I3tWImx9aP5CWdeGsxSpWsfGRNUb6dPYtFES1MokWemn+XO
	wCZbAabEkvJgkJbCp9HvZTIIZ8SUBNv7QcIVNFqISZiSgb34Sx+dpvgqSS2/6aOOy7Bay4GlE7m
	FF9TLUWrefbezHzKD4lWWr3De4IG3mdhSiGY9gbZ75qjtT5ViYhV7qGxGZJZdKMHHApQJr+bllE
	DWd/45MdZxV1txyWCh+omkyUIv9AsM6S0rO9SwunQcDoZR4/edbsvwuXTgIajOvSgH1OYVIc0eO
	r9qugxSuKF2wqTmaKXDSNDuIpnBpgfyBPZVtS2kxDeHOoWgNtsOPkcV73Ml0JLNovmji+EYBJST
	U9c8ckOkR8aaXKSrCya3PtcbJErw6xs8QEebLcPqdEVkcP1JOUiSYpFQVOv7U0pQOIA3ljK4cO/
	/JpA7QUnprk9KMkMso6DMbxJOWgA0/koOVhKz5AnsfxeistYOcVjGqoTOzOqnr9wSVnICNIz6tD
	YfSLLZcao6ShhjmeowJ6ux52yHlDS8dXrzBCQ==
X-Received: by 2002:a05:6512:10c3:b0:5b6:183c:5c96 with SMTP id 2adb3069b0e04-5bcde6adb31mr7892347e87.52.1792098112887;
        Thu, 15 Oct 2026 14:01:52 -0700 (PDT)
Received: from sc-mac-012.corp.sbercloud.ru ([188.191.29.26])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a42ade9sm11127e87.14.2026.10.15.14.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:01:52 -0700 (PDT)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] kbuild: Makefile.lib: fix offsets generation with debug info
Date: Fri, 16 Oct 2026 00:01:47 +0300
Message-ID: <20261015210149.78470-1-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928105330.25427-1-d.kandybka@gmail.com>
References: <20260928105330.25427-1-d.kandybka@gmail.com>
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

v2:
- Add BLANK() macro for better readability of generated headers
(suggested by Nathan Chancellor).

Fixes: 7dd47b95b0f5 ("kbuild: consolidate redundant sed script ASM offset generation")
Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
---
 include/linux/kbuild.h | 2 +-
 scripts/Makefile.lib   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kbuild.h b/include/linux/kbuild.h
index e7be517aaaf6..118568971fdf 100644
--- a/include/linux/kbuild.h
+++ b/include/linux/kbuild.h
@@ -5,7 +5,7 @@
 #define DEFINE(sym, val) \
 	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
 
-#define BLANK() asm volatile("\n.ascii \"->\"" : : )
+#define BLANK() do { asm volatile ("\n.ascii \"->BLANK()\"" : : ); } while (0)
 
 #define OFFSET(sym, str, mem) \
 	DEFINE(sym, offsetof(struct str, mem))
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 0a4fdd8bd975..96c2ec50f06e 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -493,9 +493,9 @@ quiet_cmd_zstd22_with_size = ZSTD22  $@
 # the .ascii directive whereas GCC keeps the <space> as-is.
 define sed-offsets
 	's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; \
-	/^->/{s:->#\(.*\):/* \1 */:; \
-	s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; \
-	s:->::; p;}'
+	/^->/{s:->#\(.*\):/* \1 */:p; \
+	s:^->\([[:alnum:]_]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:p; \
+	s:->BLANK()::p;}'
 endef
 
 # Use filechk to avoid rebuilds when a header changes, but the resulting file
-- 
2.54.0

