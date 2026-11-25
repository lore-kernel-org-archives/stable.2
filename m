Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645093;
	b=EUIrzlILzz2a8cNtq2mPfc1wZCEt9fdMS32QfTTop9RNZckSqi9Bemm2KqSgax+K0EFA
	 8RO2yZ4ukqLn1pfDOWMzHS6lA8CPUTzuLGKZhar+78bgfUgJZL1wdWB3VdnaxgWnHFNzi
	 OmNYKnilykpAPJB925p7K+4xEFMvrsyqnpWKwSZeHYLNfBVxt/bOC4NWttwjLyUozwI8L
	 Maf1SVuOa1fy+nMhme9C90lMz4nGBK77ndyomwuE7aYNGuEnmfEO/zlMn44SyixGqhOyA
	 m5e9MkT7asP5TpVm9usR+ODPmc4wdwVFRd3xCjVHzWM0Dti9+pp/UOvCFRaicwLYhsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=VgqpPNqaZ4O4eWgZqdi1XZF/bmVHxvm7Tf4gaCeB8hw=;
	b=c2ekGQvol8hgDTeY5W7x1YEmJgHxLXNcw1oFPtwk5HM8DYitaNSwm+swAJvXBayglzjE
	 ekyWpdoCp6EI1835+bG5aG5kxJjHRf+nUrg9F8XAylEssoExkwdGOlWP3+5nx3rmevHwg
	 AL7gXbF8bHWhHZx/OySLIdUUPJbw+zuXRKbhZG56o1QFjwF4EZuc3U83ucoBGxapthi7I
	 i7GrodXVZc4Wrgrok5jfbASSxEiUpiRdZ+ZNY4IdS1emL0xOkTVmhEunrISMNmQAsiLL8
	 nLGVFuQxj8N4nX1hMd/4QceCjDgnhRr/Z88FCfncWzMwtevBm+jlNJHKyqzx0JXxawg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oGhIEnSf;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68860606A336
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68860606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oGhIEnSf
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso8018842eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645092; x=1796249892; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VgqpPNqaZ4O4eWgZqdi1XZF/bmVHxvm7Tf4gaCeB8hw=;
        b=oGhIEnSfRdUhna5Rt0B+Fdm6BO2h3EPb1uwUGLbkiPPBw0q6eptp6iVTD6TkeTdI99
         DNkhzcKlzaW8bMREFSeLqEsNSUpISjMJKwD54jzHYNqH+jbOiQb7ZPftgIBDVP5KO1Dm
         ggGzeLqtxMkuNaEkH0KaHPcYBjqzLFD/cWvO4EN7hy6cLUeyttUhefGZfr6BehOkxzmF
         RdbvpFAdpQiIJMA8CAxjEwt6yHXHUGvJttFfgYfono5XX2YBO5Fe3ehJVdxjM0mSg/5i
         1pDNxwnKattau1GPhJjJlS+fi1M3KbuuVwoOc0vN86+C/nOCulFMCyfRWYVo1y8SwIMy
         5mcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645092; x=1796249892;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VgqpPNqaZ4O4eWgZqdi1XZF/bmVHxvm7Tf4gaCeB8hw=;
        b=DLdmrF2SbQqU24sybIkrvsdnnHD4WzF+k3kZ2fVmnzr4aNMTF8E6vgDSIFgJY6q7jU
         G8+8DVwbGlz1pF2dKPaTyjlrF7PBzKB8dEt/WcKbPKct+r7WSMvH9ncmEEN/4boExD9z
         9EVHui3lZ/j+vhDrJNdDM8juT/Gw5diOStmSIm1JdwWX24Bt8BADHiCE5CBgvNsLFG4A
         3kdPLLmcxTZfakMFXsQIH6bcoU2CbbT7lMEN+1QrNX64/WhvL5Ywu0gZoX48LMwssv5N
         GVv7jHtYzyJN0TJvfIC9eN1Zqjwy1FZ/sLPd1zx2whb9BmtqnaAo6rxsUepoIoxlQBw+
         L39Q==
X-Forwarded-Encrypted: i=1; AL+hErGTKz2VYT0QGapTJnLGGEviNJbWOTnaQJsIjqDtfIX8GeriTlt2VZsAK7gR6OLJoIa1Tl8vpHg=@vger.kernel.org
X-Gm-Message-State: APuU4Z91qAcSiTETc1yUfrOugzEmlyDVeCH6xQRaV925iJPgh3y9evbz
	8547hgZRQu98xgeFJZYbUIh4mz57Wxs5DycGA+bzkxmk07xbNoUVN50Vuw562bacA5/czjk7j2z
	EyQ==
X-Received: from dyah11-n2.prod.google.com ([2002:a05:693c:83cb:20b0:386:458d:ba4c])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8642:20b0:386:9e22:ca4c
 with SMTP id 5a478bee46e88-3869e22cc7emr17859030eec.35.1795645092222; Wed, 25
 Nov 2026 14:18:12 -0800 (PST)
Date: Wed, 25 Nov 2026 22:17:30 +0000
In-Reply-To: <20261125221730.1421806-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125221730.1421806-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125221730.1421806-3-elkin@google.com>
Subject: [PATCH 2/2] afs: Use bitops for fileserver address bitmasks
From: Elkin Cruz <elkin@google.com>
To: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In afs_select_fileserver(), es->failed_set and set are unsigned long
bitmasks sized for AFS_MAX_ADDRESSES (BITS_PER_LONG). Testing bits via
32-bit signed shifts (1 << j and 1 << i) sign-extends at bit 31 and
invokes undefined behavior for bit positions >= 32 on 64-bit kernels.
Similarly, initializing s->untried_addrs via (1UL << nr_addrs) - 1
invokes shift undefined behavior when nr_addrs equals AFS_MAX_ADDRESSES.

Use test_bit() to inspect address bitmasks and GENMASK() to initialize
s->untried_addrs safely across all valid address counts.

Fixes: da0e01cc7079 ("afs: Fix fileserver rotation getting stuck")
Fixes: 495f2ae9e355 ("afs: Fix fileserver rotation")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 fs/afs/rotate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 490b433e4395..a0d293ed2aa4 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -64,7 +64,8 @@ static bool afs_start_fs_iteration(struct afs_operation *op,
 		s->endpoint_state = afs_get_endpoint_state(estate,
 							   afs_estate_trace_get_server_state);
 		s->probe_seq = estate->probe_seq;
-		s->untried_addrs = (1UL << estate->addresses->nr_addrs) - 1;
+		s->untried_addrs = estate->addresses->nr_addrs ?
+			GENMASK(estate->addresses->nr_addrs - 1, 0) : 0;
 		init_waitqueue_entry(&s->probe_waiter, current);
 		afs_get_address_preferences(op->net, estate->addresses);
 	}
@@ -556,7 +557,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 		afs_get_address_preferences_rcu(op->net, sal);
 		for (j = 0; j < sal->nr_addrs; j++) {
-			if (es->failed_set & (1 << j))
+			if (test_bit(j, &es->failed_set))
 				continue;
 			if (!sal->addrs[j].peer)
 				continue;
@@ -617,7 +618,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	best_prio = -1;
 	addr_index = 0;
 	for (i = 0; i < alist->nr_addrs; i++) {
-		if (!(set & (1 << i)))
+		if (!test_bit(i, &set))
 			continue;
 		if (alist->addrs[i].prio > best_prio) {
 			addr_index = i;
-- 
2.56.1.839.g22a8290db9-goog

