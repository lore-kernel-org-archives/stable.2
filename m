Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795307378;
	b=PwDbdzz82/nEDVCX+AhwHCpku5F67L/MoK80omQJFlyqO73U0MnqlmMvgUE0vQD3yWk5
	 rgih5dHIcJUR3EnZOQDVb5/zUeW2MzrRTwkm640MfLexQHTJK4qhHGw7FS9fdVZ3lKvap
	 9zt78tQmvemiqBIzCQYjUmm11aYhax1LetjTe108/dmNOJkmqmX27WoDw1RJsji/w8mqi
	 IY1ZwoHecmhLLQnKbPn7NPz23rGwOqMMhK4a56Wfu/k8HNeBfwCslQkrf3JzHPTPm6Fm1
	 re7b53eKLuj59UIt1MVgG6SXEkRwg4Umje37cdtLu266UP6MxpoktGpN8Kdl418IEDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795307378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/d2B1uiOt5351Wc+V4rdkTylekRqoHBMFthy3xK3VRY=;
	b=VHjzRxGzJQQAM5eGHZO/JGpWxZgZGfdojNTvLSbNyu4ql3eXsT5ANqpogjhp/93ww1qa
	 QOPL1GYcBHgnYSM5E5A8Sb6GBhuEKU9YUhccuv37um/S4Qgm65vy5GZ0M5VwCg7+cDu6B
	 EFlEEQwBOpVWoiHnF1+NZdelnUjnDLC44j3HK4LdCtNFwNNQlp7dcLjEBUFn9tznZ6FWK
	 l2kKrUGK+slnAZ1GQHseskMxmZaeJ1MHSfe1ItOZlbKVwTsp2T30rmqQuUPXly9J6zP5c
	 d1KQpbXzQ/uHSXqK2A55A94GsDxlQqWpSLPN2i3WxeGGMUHrTJdarwNKMky80XkfZjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OmEgXWuH;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7F5606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 00:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E7F5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OmEgXWuH
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-921318b2eb8so29208386d6.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 16:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795307376; x=1795912176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/d2B1uiOt5351Wc+V4rdkTylekRqoHBMFthy3xK3VRY=;
        b=OmEgXWuHrMyeid3mva7NFPaeaTZ0o41DPIZ5dYToRYbdF4PNMVlQF1ZclvQQH35jyG
         ex6PluORcKD7AlEDWofD6cvwuaEfMg0Xi6JEIGBNt2MZ5LmIHdScKFNSDXCJ1IxXqL5k
         EBkc9oVa6UZrp7odi+uskQMDRSBOsx0Z6rmSMeI+fGIICYJ/Z29cqQHbFZyWz5UUVtTC
         +6quiSyEhv8lFwLBvIDMF/PlrYn+3Kj7ZfacxRM0MMAYgEUwySAZvAFCx1yjYcz0ONu6
         NJnHrOAkxW+UokdJv6KphXYETWerAowSpG0YZLBFOOQB3tYmGhui86IoxDjOX0Dz8ciP
         8pFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795307376; x=1795912176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/d2B1uiOt5351Wc+V4rdkTylekRqoHBMFthy3xK3VRY=;
        b=REUqkeq2HsaHyDoy2XbscthkmNbZc+RkcM6VJHd9uaC4QPbSuHDfTf9tuMdqLWCixP
         84+E6ENI4+ufwAOCTSjNwBq9Yj69Pxu68sopZ7I4CYeRGRJl3uZR90jSMjoEtjvZq93w
         6+z0tSNaLjRXsXQqG10iuvIP/ljANVmLDDgHcOazpibpQh8lP5CBiiAnzqn3SRUoAGmn
         ilMOWXWG8hJzXPFLSU7e60CmIBN5RROWwC4E+v2U1FrmL7+HrtZeDE6gUTLWPz5GaU5z
         a1BCJS+tTsOMVrUAsUm1mp8FwzY1SCgDKq3K6P6c3vtofbphNTgJyq0dZ1FRTCvgkc/L
         LzCg==
X-Forwarded-Encrypted: i=1; AL+hErFPBVZw6YYD0X02tqoCzHCqd7so18zosWt/kdH33zoECkmI8eHffu1JQ58cCKvBzypziV4t5ps=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hvhR0d27ulrwXRfd8PR6/zZP0yzmcfOjCwkceq10vk2eG9C/Z
	CUB8LlacpPKg4/OYcdcn6ni5dGNwPXCJfuiH6/wpA8gFdmx756Z5H7PW
X-Gm-Gg: AZFdTZe9k/8kStHKfI6Dvh9CVHntLikGjlfTkflcdXbqsaensgibT5XQYLHfYjuegAY
	RIfmfU/UuzkM+NOUQMk8N19eWRvc7gD3dimn5yPkI2+whLwO3/Juj1adeibj7nFlDodvfIRXxoZ
	l+SpTj3IohrCcu4S1GhzfljvHzniUlDfNtOQAOk0o5igq1MOgy2F/U8hodNQR5+zKLoGIVzb1rZ
	am/GodTH1PvW7qMS9nUw/XyDUuwk2s59ym7s72kg41TP2xsM5E/XZQ3HzQs/hbzwmQ3Er65VuyM
	f2tMk8bs5DS2LCUs1kBT7IhpnCmYw4kBtVjUBEwUQpmi9eXuZG1xdBIydbws7l+D7QLFHUAA1q9
	oCoBD0ysQrEhZOWVOTbrfOhm0TQRQYcurvByOyGSVT6P+iXd0Je0bAPmTWukec4T7OGZWkK/b5k
	RJ0yfHQZdC6HRKyuZ0KBVb0vjjdHDI+leMa+HjSS4lZ9P2swiCso5WUy+YpK/pwyXfY/WT6dfWc
	LXUtsE3xZPCMRZXMKj+eOlsq+hh1IPzzG7CDLm6OKEQllQdl1kpUmNc03/rzxkE19tAZlRacYkR
	Epj09q0pAvXbOgkGiyO8yf2kr3r6o4JJqMzpDzHKEATFALsVBpxfBAsOlK2iO8RutkTDjMnec73
	GREiFOBRKNRkybICcxj6a5Im4gKHy
X-Received: by 2002:a05:6214:411c:b0:91e:97a9:cf02 with SMTP id 6a1803df08f44-92134a38ed6mr129326736d6.11.1795307375814;
        Sat, 21 Nov 2026 16:29:35 -0800 (PST)
Received: from localhost.localdomain ([71.18.96.10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a0a454sm64752766d6.35.2026.11.21.16.29.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 16:29:35 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yifan Feng <evanfengff@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: do not overwrite wmarks.activated in damos_commit()
Date: Sat, 21 Nov 2026 16:29:30 -0800
Message-Id: <20261122002930.98401-1-evanfengff@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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

damos_commit() copies the whole wmarks struct from the source scheme,
including the private 'activated' field.  The source scheme is a new
one, so the field is always true there.

As a result, a commit turns on a scheme that the watermarks turned off.
If the metric is between mid and high at that time, the scheme keeps
running, though it should stay off until the metric goes below mid.
DAMON_RECLAIM and DAMON_LRU_SORT use the same path for commit_inputs.

Save 'activated' before the copy and restore it after.  Do not restore
it for DAMOS_WMARK_NONE, because nothing sets it again in that case and
the scheme would stay off.

Fixes: 9cb3d0b9dfce ("mm/damon/core: implement DAMON context commit function")
Cc: <stable@vger.kernel.org> # 6.11.x
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
---
Tested in QEMU: without the fix a commit turns the scheme on, with the fix it stays off. kunit and selftests results do not change (13 pass, 2 need drgn).
Found and written with the help of an AI coding assistant.

 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b8678a53b0a9..9ae77e4d6e57 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1567,6 +1567,7 @@ static struct damos *damon_nth_scheme(int n, struct damon_ctx *ctx)
 
 static int damos_commit(struct damos *dst, struct damos *src)
 {
+	bool activated = dst->wmarks.activated;
 	int err;
 
 	dst->pattern = src->pattern;
@@ -1578,6 +1579,8 @@ static int damos_commit(struct damos *dst, struct damos *src)
 		return err;
 
 	dst->wmarks = src->wmarks;
+	if (dst->wmarks.metric != DAMOS_WMARK_NONE)
+		dst->wmarks.activated = activated;
 	dst->target_nid = src->target_nid;
 
 	err = damos_commit_dests(&dst->migrate_dests, &src->migrate_dests);

base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.39.3 (Apple Git-146)

