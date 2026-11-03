Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704657;
	b=E2WPZQvSwwuPOxOkC2+rrhcV1yfahJ6gZVACxlH97nrVpTeDpmjCT7PjvjkCa3rkbFw/
	 KasA/JCZtm8URJ/38WVQRcrWF5CKWt5ZHjb8q0L0Ut6g9iWMghSSLnmkldeRv4h+JNWMx
	 oQdE/N+FXDhW74J+F2+MMkb4YCavr1go4Q1rySOIqoNAtYiTVZzG2tsHjslXbDH6m1Ylg
	 qxvKtEziYZfg6wZkPDJXeamF9F3fOi6yCSH8yCozQVVMW6rewwCOQdd9Cik/zi8ox5622
	 XS5SS8tnPAvu55bimY0RWojeIv3qD7Y+mz3tOtUheI+5Vl1ANksZCu7el52K6ULh11w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rO8PyIeQTJjW9jZC3eDavQXhSeNQrxCH5KHGWPFOq/g=;
	b=Y9S1CbxA/rBXlrcemANeMjx20gXtfeCPhqfWAhBq56GR/RWzbp24g0yDXBlnmr05Z3F+
	 +CyZu9P3ba8qTMkFV8Tt/Wi0MDGRGwVYRYvrfsBhwSAvQujdtv3tkCIIGsMM4n34i9Jov
	 2xGTSCfmhIZozerVSJLC8P/yfs1WAS0ZWwU3quYWTcfNqXm3eueLIeLiCCq9CXELVCrj2
	 DsMthPOPwxJPI3MkRcEaEbXw33YwzKKt0qNYk5pT8BuyuhSltP9qGqft4A3DzB1Rz+ysz
	 Tsx+0QzJ2w4Qnalr3sadSclCL36BE2AAD7zMBiSjruCjWcDFtL8amL5gc3kZA13RYCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pC00q7jq;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE9606C5AB
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CFE9606C5AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pC00q7jq
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so794023a12.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793704657; x=1794309457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rO8PyIeQTJjW9jZC3eDavQXhSeNQrxCH5KHGWPFOq/g=;
        b=pC00q7jqqQBbxlVHA5rOT/XIHx7ltpNjFk+cCBir1T0pdSFH28M7qzyByjbn3UDjkD
         QYtroc+dE6qSS+TgIQx1KpBMUpQ8N2fBm5I3HF17p+Mau2KDVYRlfXI81lMFGUXYu59Z
         Xn5ASiRkjyc09137mQy1qDtuKMMK1CeufA7R8yVeWObx5WJy57dyIyABIg1PIbX4VXG7
         jawfmjK8SEx5iKYjoRg3Kv1ydaRnyXNg0XrFoMkxeoNw7+frDKMvg3EYax9tzjAwVsC/
         UNfZZFzf9SCSbjqY+loz1zg09jWsD2VRXpgfAMwuOPyXc8CeULVPtOpRQcuHseANL7/v
         t+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793704657; x=1794309457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rO8PyIeQTJjW9jZC3eDavQXhSeNQrxCH5KHGWPFOq/g=;
        b=eFp6RbJNBBWJSPKR4jihb4QE20q47D608OqHpDrMyqDPRzgMR0od4sbMlbuZoIh2L2
         Fh9lXUYetpk80K+cCYEXqRlaHRi+kiO22HFTzhUWYgQMI0WgJU7SgoN7/X7asPPgk46V
         as3CxDAL8QmI+gZfRP2RPnAOUw34dkxrPxn2bqS6FFUfz6bG6cj1fGDwEa2CQdBP9uqj
         qW+hiItmCRKDHEO+ITigLU1WlWaM0yOWzQe+Yd0sYaLtH7c7gjPRfUgxlUFePzT9SLLf
         bT+Zslpiwoq7jtthZQyVDsZuo4M56eRJ2DUmYzPMtWmrR4nTYPjciom2DqJ46aI5mvCF
         R8tA==
X-Forwarded-Encrypted: i=1; AKwUvByQSqvSmAmTY88LiIvyt/YT9jDBMos1iagX6Iw6k/fsh/ARZ+sFUO+urhjHBMYum3vTUhtve8c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tDBTEVPxiG9kR2g7PJXbx4A2RXUAHH6AzIqxYoCG0rrT2lhff
	hXo1M3jYBJWCwhwaoeLQjLPgLc7SGbl/myp+UiiO0rQweuieKWq29vDW
X-Gm-Gg: AYBFou3p+6AUi0vJIRgvKL8gC3Q8hi5eJ5mVPb+pawtsPs9Zu/tcyVEae0Q0p+TJ+l5
	uegrsSCAydbg/vP499tmuS9BYJYzn+ATov/knnXIMVxO4gqjQJ7A4S2+KQB0UDMpw0P/X2N4M3q
	aBIgA8XCXBYXFk8tX6M6yb0qzjEhmdeP77UvkqFZ0vdsYhyEtZq9nqwPH0mXumymP6c/F9wNr8f
	Uv/queo9wRZ4iDTECMl1wOhV6Xj7xsXB5tq0K1keCnumo7ZjvuNP2jzY/Zj4eILaUjabW2lAvXe
	HxTbOjxDG8lRrEU/wEObrSXnlUyQ9T5rXWY6tsfOQX0C4599mJCclrsOCMz+XHYJ2xE8wXjiJXl
	hYTtBd+77rNYL4+GAJHnppXLfdFFLJqzN6t1fjVLM4QSMjeYbXW5A7jLnd3aq/6NwRtAVKbdZi4
	uMbknBaWVftSQSYPNDYVMfdJN/+hLE9SAoy/+T1HWLUlZwxg3oK40hqWhi+SfgpdKGskaX6VQn7
	/9OFXZb23JtFDG7o4bCj8j6bZSpSGGh9QdtlN3emTBjfjUdfhUgb5bO7CCRiCdWt0I3spKQACWz
	psFyXT/dW2X40Th5ySRU3/SgRSANViOcRie2Z3ZCn9dt41K3xUx5SRLUx2NHbDd5CSeP
X-Received: by 2002:a05:6a21:3216:b0:3e2:ad49:b24f with SMTP id adf61e73a8af0-3e928e47524mr11186434637.68.1793704656472;
        Tue, 03 Nov 2026 03:17:36 -0800 (PST)
Received: from xiaolei-VMware-Virtual-Platform ([219.142.21.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aadaf82a66sm3065147b3a.56.2026.11.03.03.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:17:36 -0800 (PST)
From: "Xiaolei Wang (Kaihong)" <xiaoleiwangxiaolei@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	error27@gmail.com,
	xiaoleiwangxiaolei@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Liam R. Howlett" <liam@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: [PATCH] mm/damon/core: reject empty access pattern intervals on scheme commit
Date: Tue,  3 Nov 2026 18:54:18 +0800
Message-ID: <20261103105418.362459-1-xiaoleiwangxiaolei@gmail.com>
X-Mailer: git-send-email 2.53.0
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

DAMOS schemes accept access pattern bounds with min > max (e.g.
min_sz_region > max_sz_region).  No input path validates the bounds:
damon_new_scheme() stores the pattern as is, and the sysfs ul_range
stores are plain kstrtoul().

At runtime __damos_valid_target() evaluates "min <= x <= max" for each
of the three pattern dimensions.  A reversed interval is an empty set,
so every region fails the check and the scheme silently never matches
anything: nr_tried stays zero forever while the kdamond keeps running
normally.

With such a reversed interval, damo starts normally (rc=0, kdamond
state=on), but nr_tried and nr_applied stay zero forever and the target
RSS does not drop.

The same holds for the watermarks thresholds, which must be monotonic
(low <= mid <= high).

Validate the access pattern and watermarks at the beginning of
damos_commit(), through which both new schemes (damo start) and online
updates (damo tune) pass.

Fixes: 1f366e421c8f ("mm/damon/core: implement DAMON-based Operation Schemes (DAMOS)")
Cc: stable@vger.kernel.org
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Signed-off-by: Xiaolei Wang (Kaihong) <xiaoleiwangxiaolei@gmail.com>
---
 mm/damon/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index eb1fcdabc007..865627bda240 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1566,10 +1566,29 @@ static struct damos *damon_nth_scheme(int n, struct damon_ctx *ctx)
 	return NULL;
 }
 
+static int damos_validate_scheme(struct damos *s)
+{
+	struct damos_access_pattern *p = &s->pattern;
+	struct damos_watermarks *wmarks = &s->wmarks;
+
+	if (p->min_sz_region > p->max_sz_region ||
+	    p->min_nr_accesses > p->max_nr_accesses ||
+	    p->min_age_region > p->max_age_region)
+		return -EINVAL;
+	if (wmarks->metric != DAMOS_WMARK_NONE &&
+	    (wmarks->low > wmarks->mid || wmarks->mid > wmarks->high))
+		return -EINVAL;
+	return 0;
+}
+
 static int damos_commit(struct damos *dst, struct damos *src)
 {
 	int err;
 
+	err = damos_validate_scheme(src);
+	if (err)
+		return err;
+
 	dst->pattern = src->pattern;
 	dst->action = src->action;
 	dst->apply_interval_us = src->apply_interval_us;
-- 
2.53.0

