Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658020;
	b=Mg2fbpkhajYF6wbp6QX2J1+wquA4tJU4pkPb7PDkueuX6KQSfSPE9HsW6KfFoV+sPqOk
	 CgEhhU1jQTjaerwnHnfuM+Pt3gfqIkqlhd66nmDcpgeki5nlHe//zDYHo7zUUpF1NY8LJ
	 lazLIB/kVbzn18lFQtaSL8fe1uIr1Epik8ymnDFuI7u3nm+NDYpmv9g7C91PT0btbFX2u
	 QwWHnkwx+tPCWddf2VOc+zbSSLHrLWkQ0UngsGkPUh4BEgGnyZLQ4n5BHYdt1XeQIOw23
	 Rihvm5/IpE9NxekZPovU6oBO16X/M2aE9kebRAZtV4/SnwVYPrJeB4spcZQ9D/va3tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Po10xs3c1tBUXr0/TED4BRLkJvTxT4ILiaYjl5lFoSg=;
	b=TJ5ZYM4QtqWKKhVpcbChusc6Zued2VU8eKa3l+tuVHhxEQLOTa408+AngBwICDIuV9mF
	 Teb2WyLOaxysOzGeaUbbDg+j7A/5zZ/rMve9ElCvCztiMxxA1HD/I7WzjnMl6OC63V3/I
	 KQimHokd4sGuyikVazjsCW9Un3YjDRtXdSpESs2Y+JPPcMCZL0gk0UJK0Ya0IHd2xmdeC
	 MFAIVO2ZNmb6vFkX1WQHssUiyphZKVWx03BVnyVc0MRp2+1fSiJ1Mz0diw8ovFXepMwMu
	 FL+Nrm+3RkWIzCWBseNvx0S8YhILbskOX7SzJaWkMBuEKjSA5cSFV3o6rbJ3btAXHiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=readmodwrite.com;
	spf=none smtp.mailfrom=readmodwrite.com;
	dkim=pass header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=QE2JDqYa;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB3606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 08:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6BB3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=QE2JDqYa
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso1547944f8f.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1792658013; x=1793262813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Po10xs3c1tBUXr0/TED4BRLkJvTxT4ILiaYjl5lFoSg=;
        b=QE2JDqYaeZ9AE/4y4mPeS+JG1LgvcHpDNB3jEMflyLtEqz07OnmA7FDZdqe2aeLx6z
         eCqS2ANQ1LqmbazgV+Twirnnd6pkvaQnP8HB9EQkIxGjKp2CeJRZUHHjLpwZ2gaPa4kD
         e4+nIhUX6nMMnmiIjgZqQwJkztE0nCXSNYZEEIUWAv3Bm0q+EwTu0xx9ypcuzr2dXCNm
         D+znffkaCN9UtUiycQ3V8MWjQTFnrIbIz2Cg59Gax4Vd1z0CyCNS9Q3fij3bFYe2zguz
         SnPgLeKmOHJ8YrMBOQc/xVKlUhrqxEYHUzi5Pkqz/rEX8Kwk9O8M5wsHqq8GNSUYI1pu
         MAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792658013; x=1793262813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Po10xs3c1tBUXr0/TED4BRLkJvTxT4ILiaYjl5lFoSg=;
        b=S2UgMbaYwrX67B8CVufAwDEteuDHK7zdA2jhGKYpsu4dKI/ToD3YHaA9sMeWgwPCN1
         vIb5kc07mQGgDjn99uWm4nXtmz8FpEw+mPd29yjOzkzL7D8OYpTdQGg5zulNO+cToPga
         CUCaMfkCIHcPg8dKMdypyG/jUv6o6eEMp3UoS3J8CuUIE7yWxYwXGNFRmPgSunp7Znbe
         ehXR5Ybc5XJFHW8O1laePGlCFPf70vN0gJxpbh+IoKh9Dqme6J3RQilM7bJWRwkgZ8QT
         8FU0wU6Xi2+5k326MAbGS7QR03oZkqwF2NPPFmSpwrjkW7V6AhmSg8ogCDTeaMyFDbDl
         Ta2w==
X-Forwarded-Encrypted: i=1; AKwUvBy0uy/Ql+hNRhVAH3ExdmXvJ85csm2AfRY1rUnf8CHHIyEacbTgbJHmjXmVKTK2i6EMRtqf/48=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrILWrHGdnNKjeZ4ZD0pLCZ5zPE6HLcCh+4BGUtmTPR80NnOxZ
	DH8aDSEPGFC7p0L+PLjZ9MK1zixZRW3ONmNiYmxvuuUt7JamEVCL/cne8ZgLF7Q2PKk=
X-Gm-Gg: AYBFou3+bpjkG0xC6pxloDTgn7nxcDFkObTwz8cobV6Qi6wyO6GzqdQhNu89ip/g9u1
	MpsyBZyfDZbmJ2fiemsB7UoLQNYQDMMJwc0hxNjMuXgwj9niBdf1scylpkpqdJGioVMJgGfERqL
	1FV2v0BgmID7msz/hJQgon4FlxuLyBKRo0/jaMHgJY9Gc750rwQXtEaXoaqC3RBU1wMvF0Xq9MC
	LvceyAqWVctZaBkdXLRIYq2XFGgtGZv/1+P47ZRuiNBxH4N95mz2/VzeTqSi7LFRXT3CvIe9gqc
	QQz6LYveGdfAUdj7nHJo/6JDgzpJLWQGPSYA+OMUkQ7xS2rV94lkDelFVX3+vxL3eXOZhd7KfJ9
	SfsxW9V1UloMEDX9Ce3IXUdsg+SzbbWIrlRQLp1ZPQA/yDHgcS60+5ZSEuzuxZTlVCj4MtedE82
	DYOS3LHSi4YH3TvU3xQEI9HuvTXbbZedPG3/NlMQliwKEcv5TdrA8l5h/u3TyDVRZ5F2NadX8gN
	ScEY9r2jnLG6L9oWdG5g4X9xypxBmbAl5Np2yNVod68saIT6mh0JGHaVw==
X-Received: by 2002:a05:6000:2201:b0:48e:21d:7265 with SMTP id ffacd0b85a97d-48e264c48abmr10924136f8f.34.1792658012958;
        Thu, 22 Oct 2026 01:33:32 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:294b::41d:9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581fa7fsm10280598f8f.17.2026.10.22.01.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:33:32 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Caleb Kan <calebkan1106@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: [PATCH] stackdepot: stop preallocating after the final pool
Date: Thu, 22 Oct 2026 09:33:30 +0100
Message-ID: <20261022083330.3159793-1-matt@readmodwrite.com>
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

From: Caleb Kan <ckan@cloudflare.com>

depot_init_pool() decides whether another pool is needed before it
increments pools_num. When it registers the last allowed pool, pools_num
is still one below stack_max_pools, so the existing comparison clears
new_pool.

With new_pool cleared, stack_depot_save_flags() can allocate another
order-2 pool after a lookup miss. depot_keep_new_pool() retains its pointer
in the global new_pool, so the allocation is not lost. However, pools_num
has already reached stack_max_pools, and depot_init_pool() rejects every
attempt to register the pool. It remains allocated and unusable until
reboot. The non-NULL pointer prevents later saves from allocating more
spare pools.

Account for the pool being registered in the limit check so registering
the final pool installs STACK_DEPOT_POISON and prevents the extra
allocation.

Fixes: 31639fd6cebd ("stackdepot: use variable size records for non-evictable entries")
Cc: <stable@vger.kernel.org>
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Caleb Kan <ckan@cloudflare.com>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
Previously posted as patch 1/11 of the stackdepot RFC v2 series:
https://lore.kernel.org/r/20260908-stackdepot-trie-v2-1-1996d5cef732@cloudflare.com

 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index dd2717ff94bf..90c52f2e0d3f 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -323,7 +323,7 @@ static bool depot_init_pool(void **prealloc)
 	 * NULL; do not reset to NULL if we have reached the maximum number of
 	 * pools.
 	 */
-	if (pools_num < stack_max_pools)
+	if (pools_num + 1 < stack_max_pools)
 		WRITE_ONCE(new_pool, NULL);
 	else
 		WRITE_ONCE(new_pool, STACK_DEPOT_POISON);
