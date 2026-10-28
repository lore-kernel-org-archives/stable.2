Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217111;
	b=cWsQPbaR/iAGitOjxfXiPay68sJ11RNn9YvIsXKAyNAe7KtGW5VOjr1FeELrIEs6HnCI
	 5nRN0de96c17DynpH3NN0RYR+DDWLy+gMI3oqPaTD7ui8JWnLC3AqusU9RKo9JhpoN7Yq
	 ntcL9V8KsW4R+TCTdq2CGpcbFV+AFAkSp4YLSopLBWzjj9JyVXgH1JjdAXx+/8PmHGa6T
	 DCaJTrsJ+PSxGQDhQX7AUHBJ/NXh0YNvm1PHiKwriHmu4wN49z8qvWy4V8yAgY6PwkBN0
	 4i9+TbsQaJPQCgCyRQe5XzaydlSw0l/1nv1kQAxPtyg8kzLZ0JiEmMjT6vqWjFLAdRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Nvrn4WRxmRYyXZvqlPwtDdIMr3RH/GbiGM7fkNtVFmY=;
	b=e0H/fs4ggjMpl2fyST5iOlW3jpWhdxmpButn4kWZOraj9XRitzYCFpYEqWCB8ZuOEhQv
	 X5dLT7xESY2zrKYjVxsE2an/S1SfEvErBPh0AseQGBo1ws8W9sV7DijEmZk1JpFp3oavn
	 UkvVbbGQAQHB3ghhE2ma8xdrusGZFCZuP2qAvCKxjHYSPxelDX7PWcXoQ01XrJBw4OCSL
	 KlG5VC6xeGlZynMck1bRDadIrl2zhbTw6bpxPxVXLy6FIzNVaBwQjJOmA+/7KNV0/152/
	 FRET0BvVwpFsu9Eawc6WFQBScxlaj5d4T9wtbt6D8+tzpKcFy7ybEPjtymw2ym9lkyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wdi9apkS;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66F606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF66F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wdi9apkS
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-3537f63c9e6so416875eec.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793217110; x=1793821910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nvrn4WRxmRYyXZvqlPwtDdIMr3RH/GbiGM7fkNtVFmY=;
        b=wdi9apkSCNG+WQgHHVCA4gASRfPqBR9MTVe5qJGMyZ/AQVSrF/+6IyE6JTTMYREoU5
         dh5hKPiIf3d9eihVt6bFn/5qBCWy3fQ0Y0c1dQET5FZd4Hx/n2u/rGunZ8DJdy77wfrC
         pylW7aaWBmHles8P7pDCGhBgXvs2yzBcwChqiEhig98DyfPrDBmsW5OLmJ4kh0bv0v7v
         oHaxe4oKD3m6Qa6aP6I44Q5MCbSTrg07nfXV5jxdhcG+/4EeWJuMu+BQyjkt672S+Q0m
         iqwbyRP0jyqgyX7gXhhLtLhSCZfgfvD6skxxJKH158WN1xTnGgXPpKf28gaFsJl+ov7H
         HGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793217110; x=1793821910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nvrn4WRxmRYyXZvqlPwtDdIMr3RH/GbiGM7fkNtVFmY=;
        b=YguAoFHDn/hmd86wSTX9tiVegpTlae+XEa+YXyBeLMc80uDjzagZMYegg6C9G7ifgH
         1RsgmHU9TI3dCfQ+9P6gYcMeF5P2yOyH4gBlfGcFqIzeGB6ocwYaDgOXve0plGIaYYt9
         tqhfMV4YOtSXerUQWAqeeAue5OW7g/XzGg8DBDc4S/ysXYAN7Fq5nzz8QSwkIVKPyHhD
         ZxekSPq1seQTlaBggwINKOfLXve6x+urSYTOnZfUjVbWP2s8MoLzaNUQYCB7f7v67zGk
         vPbt6hQGGtRCr3x3mQalUHSVtAfFDwt4wjY7sIjV5IlEWR5H9a3uXE/QxPfIdbm/Oq+W
         DHlw==
X-Forwarded-Encrypted: i=1; AKwUvBz9RxDFsMG/SbqYs7W1GUHosW/v41lOLSrPRoJhhlLDUrKe+o4dTZwo1mYPJo0ZXqrwp6QqVyk=@vger.kernel.org
X-Gm-Message-State: AFq9FYISxOzHpl5n6DdnhyzvKZ4HTLke72VP1a5u0bu2jvIkxY6qYrrS
	nMivUDYQTo8ExBx1heyTbx3xgixac4ggSIX0SjOWRqx9G0gFoZhcmeV5
X-Gm-Gg: AYBFou0/kpbheKPJXqlr7GYkABiqyAh3iqIhLH57cdrPH0y4W2TeiWvpub/BXxXAquN
	YYWi0xPI36nF3W4nuJdID/o7kiD/ZS4qt91BcNK30YfP+5QbttTrLET2kcWxFSG+XMrQ2is/6iP
	RM4Z1icdXfjNMmundlNhlpTw5lFoQ/1PIDf69WmTl27SLKGWIRI1GCg4SKkJF5xa79OrfOSYi7n
	vvQb5tn13G96QJbaX1mfpsDxMf5kxUHEbzeaTOzxKcZhuZohuuFoDAZox3aJm0cUwjAWuMU9gL1
	tTmw2RWwSseZSLjxG0KqazIeWtPLFzNZxb8w7TwWUn2peMb5JlaMZs+DiJ1F6FvLgZMgwq6IC2E
	c9Jhkl9X4sz4Y7lw1WYud7CLIJgV8/9Anw2ao6I7HcAMx0siamZnAR61CkNaC1lHfSA9XZ1Eai7
	C4dMGDJhNxgINhHCIHMcY+cgh5Uoh+Sf+23VsiKg62PXYDtuVOeh+QqRrmq8CYfZZcLPP6ltTJG
	Jaxf6WQnDMvXmKPg3V+esFS3XDxz7a/1MyO/UWMi50F1wLKpVZM/azcwWQ3S+tE0rl9Tvmo5kSj
	m21DJwJx/9eDsynBatALIzpbMIXZ0SK3VtROkJosPd8t8huYfBZmvLbc
X-Received: by 2002:a05:7301:1622:b0:36a:1807:75a4 with SMTP id 5a478bee46e88-36a20075471mr4923982eec.20.1793217109527;
        Wed, 28 Oct 2026 12:51:49 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2398fa4csm10895569eec.24.2026.10.28.12.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:51:48 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	andrealmeid@igalia.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] ovl: reserve space for the casefolded name terminator
Date: Wed, 28 Oct 2026 19:51:33 +0000
Message-ID: <20261028195133.86636-1-dennylin0707@gmail.com>
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

ovl_casefold() allocates NAME_MAX bytes and passes that capacity to
utf8_casefold(), which also needs room for a terminating NUL. A valid
name whose folded form is exactly NAME_MAX bytes therefore fails to
fold, and ovl_fill_merge() falls back to comparing the original bytes.

For example, when two casefolded layers contain directories named with
255 uppercase and lowercase ASCII letters respectively, readdir lists
both names even though lookup treats them as the same directory. The
same names merge correctly at 254 bytes.

Reserve one additional byte in both the allocation and the folding
capacity so that NAME_MAX-byte folded names use the canonical merge key.

Fixes: ee95c5fc86dd ("ovl: Create ovl_casefold() to support casefolded strncmp()")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/overlayfs/readdir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 7d6f7f6022eb..6113d690f8ad 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -81,13 +81,13 @@ static int ovl_casefold(struct ovl_readdir_data *rdd, const char *str, int len,
 	    name_is_dot_dotdot(str, len))
 		return 0;
 
-	cf_name = kmalloc(NAME_MAX, GFP_KERNEL);
+	cf_name = kmalloc(NAME_MAX + 1, GFP_KERNEL);
 	if (!cf_name) {
 		rdd->err = -ENOMEM;
 		return -ENOMEM;
 	}
 
-	cf_len = utf8_casefold(rdd->map, &qstr, cf_name, NAME_MAX);
+	cf_len = utf8_casefold(rdd->map, &qstr, cf_name, NAME_MAX + 1);
 	if (cf_len > 0)
 		*dst = cf_name;
 	else
-- 
2.43.0

