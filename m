Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2EB37F010
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324406; cv=none; b=SMxfl6gkqwcJxGJnqiOvOgMwTRhFKqTFJ4yKDPUGYfvncxPSddYXrDSyZXtM28IvQ4oAGaquXkRwr0aFerPeWhqEn7toHRj4KVYedwzAl5+2E9CQB4Fq8f1p9GrEW0e7hppohEcDDNKL5bcWdAADW+OubQSwSOUIGBM29fMl6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324406; c=relaxed/simple;
	bh=S0hzy6+FdzanYQq8RA+km9ypXgv2p7Rwg6W8f/13eaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOX7tVYXvA8hjwAnZ9MM29IxO8bjZMDaMPUfw5rvdf2wqD2mkF1MCyb/tl4bkk5hdtfm/bCQ0hhk37uEpEIvULNTcCZIk8aHovkZFBS+ieQLCUSnBRjN2+y50VslwlNg0gFZI6PCKtnfTiOowQuDDh7P2y1SadhcVLWBriLL384=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=WwGVDmAp; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="WwGVDmAp"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-82374c2d7aeso1239852a34.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791324403; x=1791929203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nBf3erK4lQNAxshTTULuJxGlEdxTadfb57Bl++VwwQo=;
        b=WwGVDmApgz6LqmTXG7L2JSX0wxrdUDXUxTP0l+4FS/LQgJQX+HmVWDSxTIPpfg42DT
         0o5GYMcqYiet3na50sC03OfyXA5ZlbMgEPuKjcyU1rLZ2vATW6ZU0bLKXDNN9I6oKjaM
         z3+EgOy0vdXwt00aQX0UvBRek7KpvBJoqis68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324403; x=1791929203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nBf3erK4lQNAxshTTULuJxGlEdxTadfb57Bl++VwwQo=;
        b=UOHbFkh9R7nPcaVrHK7chd+pRu4NS/+plVK9wdIm8rRQN+GsjZIY+xIJr+ouAdssvV
         EPvlCNgaaBMDJISt+LTaiMVgHZ6urhRFm7cU9pl+blW0GOsfHjXacK64Dd571e68Runi
         nz5WGkFgAdh+b6b2jki45pl9IPzOm/Fdu4wTKgONXyp4qUCHw6PaYV5E2YS9d0aX/jro
         xZvpNVplgoc6PjvrCxgvCdxIWbwlHooAP4ByLgLcwA1RhwrzlmNOzry+VxHv0RjvKaMj
         qMtMjUwi1dfcFEz5Fx/AVxyPEKEcap/KpMoL0DG7gZYlM8auHJrUthr50jI/pXRIyYmo
         FxAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfTp7fneb3uqWaUHAcRF9eVP2OMn0NVGBmIzcdJ5l5IWo95zrOFa08kpJam6g68dcBFSIzdVU=@vger.kernel.org
X-Gm-Message-State: AFuF++kPo76uiPn9OE/w/BMP7VoQ+DiOxVyItWokrqyb1KzfDBBVgHiU
	n2LPgGq1quPgJAxb1HOeIHpWIO1dLwRR8wgTSd9+LrcQp8jSph3JCK2QpXzuB2jcMwk=
X-Gm-Gg: AYBFou0/2YseTxs6K1uwJnUPgIjAQXcM8Hvfh499r6QBa4y0wGJu4YJSd5pkG7uiw3a
	bgHMAb9e8QLv/Klyi+b5MmkXfNVLRJSok7wiexoq72Kat5PHKFK03VUNWlzOkxBP73MmuWgIGRO
	3mGNlbN/HwRbugsAwL/a2YBtPqABKlWI9+sNlUR4iGWltLPnufJiMuxVwAcUUF7uN+ecAP7VFu0
	MsIPkiSeK9LYkFqlFE2orkXfD9gnu1y3KqShoa+a2iPTOZPxaSmWZsS7iiKXBTPQ7dO3RBs3nG7
	Bj+WpY7P+TbV5bPWcC8inE0LMwY76r3+yuitTZ1YO2EL0TblEw7QTnXOpXWkIheC7QPG4vJV8+Z
	lVr08EDniiolNLnoiZQUIwLpkoFrllGv8QwEUZY/dvsvJdHnS0NmBcv7C5s2sGPkko7567K0Eex
	cw/6013Y51WBHG4TIE51KWxZ0ZbpfcBbL1YRVymQ3XTJATr5F6WdVQuWAoryfO4gyH8SbjxC4u5
	iyK+im5DoHr100CcWuRV6XF+OWS19Z7JGPe9PPhFccqBZFLuYjMVKIR26OcmafUYvUTsaN/G0M=
X-Received: by 2002:a05:6830:8548:20b0:814:ab94:7779 with SMTP id 46e09a7af769-82802951d62mr2576272a34.7.1791324403574;
        Tue, 06 Oct 2026 15:06:43 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adbded9afsm713790a34.7.2026.10.06.15.06.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:06:43 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] assoc_array: Preserve full words when splitting shortcuts
Date: Tue,  6 Oct 2026 15:06:38 -0700
Message-ID: <20261006220638.32195-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

assoc_array_insert_mid_shortcut() copies enough index-key words for the
new pre-shortcut, then masks off the unused bits in its last word.  If
diff is word-aligned, the shift is zero and the mask clears that entire
word, even though all of it belongs to the required prefix.  The new
shortcut no longer matches the objects behind it, so lookups can fail
for both the existing objects and the new one.

For example, inserting a user key with a different description length
into a keyring containing enough full-hash collisions can split a
shortcut at bit 64 and erase its hash word.  The resulting search
failure can also expose the pointer-dependent keyring hash as a KASLR
oracle.

Only trim the last word when diff ends inside it.  This mirrors
commit bb2ba2d75a2d ("assoc_array: Fix shortcut creation"), which fixed
the terminal-node case, and leaves non-word-aligned splits unchanged.

Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 lib/assoc_array.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index b6c9723e12ce..20ef69e03780 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -865,9 +865,11 @@ static bool assoc_array_insert_mid_shortcut(struct assoc_array_edit *edit,
 		memcpy(new_s0->index_key, shortcut->index_key,
 		       flex_array_size(new_s0, index_key, keylen));
 
-		blank = ULONG_MAX << (diff & ASSOC_ARRAY_KEY_CHUNK_MASK);
-		pr_devel("blank off [%zu] %d: %lx\n", keylen - 1, diff, blank);
-		new_s0->index_key[keylen - 1] &= ~blank;
+		if (diff & ASSOC_ARRAY_KEY_CHUNK_MASK) {
+			blank = ULONG_MAX << (diff & ASSOC_ARRAY_KEY_CHUNK_MASK);
+			pr_devel("blank off [%zu] %d: %lx\n", keylen - 1, diff, blank);
+			new_s0->index_key[keylen - 1] &= ~blank;
+		}
 	} else {
 		pr_devel("no pre-shortcut\n");
 		edit->set[0].to = assoc_array_node_to_ptr(new_n0);
-- 
2.53.0

