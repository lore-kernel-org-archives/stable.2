Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000859;
	b=K4lswv2KNG4dQrU4sPp3Czcanuy+US6D5dZ7OHKJokbB2lQ11+40ih+e49OwlHeR8WmJ
	 X25RqSyY5+AFq+bFIAC/E/9lw5cZAdVysp62cP3crY30d2LYkFiTpEq9+HarDEozXypsA
	 EoslTNBUAIhx+ttJR9FAJodt7BoeiBoI9nj++cwcDJGgfjc8F61MhCF52YK3EoAjOTxSl
	 dZnv1+BiXxMqJvB47XLUAWym6mYq7IMP0Ixn7lS1AZJWi6Cj6Ak8hxNjNAfT9ioOYZDXH
	 /xsIWHVFqz8XrAHMpUMr/J51N+3W+HOT93m6IUhJZhDMZamig/QZneZZ9XFPgpNz1LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1UuOcKX5/sC1jqJ5XhioCcbGcHx7M3qqzB+X648UiWE=;
	b=FtkUGrAOFsTqz15fn6InUmbyB+9CDzshcS2H2IghSEPOmh71PZTMa/HvAFZw0Pjfh8oa
	 GL7ZKm/h092vjSpjTGGR89TR/VTg6Q5XvqypW5wuuG/jdkb1O+b25OmogTDgqmnIbz42a
	 oicfLKX2eGNtASw5c/dVhdva9vI99siwqsVnKB7jMpkNGMM5QZ5a6+tfG8YOQSnJQqXW8
	 OaxiKZ+urfv3hce5hq8otTeAdgMTFwzYtzXK3+8XGetFqqI7dUSRm16P1/JDFV8Ki0vpa
	 QCYaymT0pHVM8U56hLSVXr+3V0bWMRjqeWPK67ebskqd6KUX5ZSLfe848jiTS7Ny+9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FtS1+Gm0;
	arc=none smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6A606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 07:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BA6A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FtS1+Gm0
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ac65e845a8so26187081fa.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793000856; x=1793605656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1UuOcKX5/sC1jqJ5XhioCcbGcHx7M3qqzB+X648UiWE=;
        b=FtS1+Gm0kC1H4kbEW1IubNEaMyaB3+vSvPRkxQcfQIvIYVzTmS2hI8PTfpI1pjgell
         6qVt2mmVG1i9XoT44Z3lG5Ag1riz4Z1dmRhdbBEg5HAEbo+2D6dhZ2vqw0g2MtGl+u89
         4F2DPmWtulDk6aoJHlO0Zz9iXd1hMOZzqXcifjFPcrbQbNl9o+7fWnmoUVNOrV+Dz1OV
         SbnY4sDScnKYHj+ZkmSeHRkSHwF98TmFASHF4pB3Ee9emDWTaKm5IE13hvOisqzCZ7GN
         gymjKvSA36puJtisAImmXGrIMEoUl+cAL6EpV6rPxw5BDKxufjEjTlIg4y6oFYt/5/HZ
         jWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793000856; x=1793605656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1UuOcKX5/sC1jqJ5XhioCcbGcHx7M3qqzB+X648UiWE=;
        b=E0aaXKmBOO53xtx7r7i1O7qnoNME4PFyDEMMEQWWtjAkfLl+KaxtakNfMZonS888G2
         WAMhaSKQAWmuL0KGXgXg8nxxpgR+tsu0kb1U9zEs0e4vEy1Z+b1zSsDs/7Vw53IVsQ6D
         6ePi98WMPV3HKuAy8tnaNPrHIBguEmJb8FhXHKbPj+XgmV1o20hLYOuNiqvyN+KI6bgM
         ZzQIjIjvFyYNJQh6w0eOPp7l5IOf8lgxNPz0TwrR61IcQpAIvm3fW5gW5EcHaoAuQQOA
         1GOrgOLJxtQfEmgah0FVscjFO4jowRkB0kN/voAfMw/ts3eAxYOwgKCMNIJsNoxXhv0J
         poDA==
X-Forwarded-Encrypted: i=1; AKwUvByqILzI/8fJFX6zouTRmGdcuHEMsPsojYFLbjZfpOyUkD/rAwITg5+erNR0nnCSeOiJGj6D1ks=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBQijHZyAJO3zfoaBcxf4tqEqHo0lDzliuzPf4BWdpFY0+BcKw
	1ha+ScJZA6EGpfv4IZhZi5NZvPJ+kjbk266lz7iazb7GAV2gEl7i1yVL
X-Gm-Gg: AYBFou1bL0MqB1B1+Zk3R5P3QX0AuCZ/3ODew4R8oxMbqZtVbR5AQzk88sgOUjlQMbJ
	MgD4zoX+bvaX3eZcFC1QhbPGEei0EVxKTgkUSAbvNvAn8HuZBw5DZHciQyI0dt7DdmDAwBZULGx
	3AXb0Gq4aaJM+pb0VwbmLS+88rl06rJsMsjXeuYITbqOiqNh7wl4P31vwaFCdpEZzQrvhK6GlZr
	hM6OEdnIHpCZ3+FokL4hVty2XLO46HmV0qJd0X0Nmxf/JmECDxtuSU/WYEZyNjd5kH+wHr1WZ4z
	JXa5ncr4vZiTJbblpDasDZKEERFc8qHSl9pJ75BFiZtwE+tZJsiyMi2/bAE3gDP553f+Co6Wfze
	9wsc7qnagoUQIxc6Yubyx/PtVdxQ4m6ctcb/6p9P5xzw02BxmZR5XB2OQxIcHy4+NtvoJQNvlcV
	/Mdf/IO2mX9YfT7jhw4yZkftncNH2XHMW05jw44tlTENZ5wLKPdKiWoQXRrobJBY3sUI6bEwI7Y
	ZAh616ha+m1rpbeJgNHxT0AsYwynkuL0mJM2kKgUrmvOrgoTbFnxtJfN24/gXVrQvGLSJKkINQl
	4t08BM8WrC+BSVqbyy5i/zx5R3ctsCMtxN8yCUU=
X-Received: by 2002:a05:651c:19a5:b0:3ab:3d02:d03e with SMTP id 38308e7fff4ca-3ac6ff34e59mr13548541fa.3.1793000856228;
        Mon, 26 Oct 2026 00:47:36 -0700 (PDT)
Received: from sc-mac-012.corp.sbercloud.ru ([188.191.29.26])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac70a463f5sm15727121fa.36.2026.10.26.00.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:47:35 -0700 (PDT)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] kbuild: Makefile.lib: fix offsets generation with debug info
Date: Mon, 26 Oct 2026 10:47:33 +0300
Message-ID: <20261026074733.11777-1-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928105330.25427-1-d.kandybka@gmail.com>
References: <20260928105330.25427-1-d.kandybka@gmail.com> <20261015210149.78470-1-d.kandybka@gmail.com>
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
v3:
- Check for ->BLANK() at the beginning of a line
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
index 0a4fdd8bd975..90422215046f 100644
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
+	s:^->BLANK()::p;}'
 endef
 
 # Use filechk to avoid rebuilds when a header changes, but the resulting file
-- 
2.54.0

