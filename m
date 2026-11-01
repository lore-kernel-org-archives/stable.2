Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521068;
	b=Hv8/jbtkK5XPME5LyGbpZciR/Be1hYFDZpu3sFTc6ypb16vq3Jf26154RPZC0zH31n+u
	 o6mvRRhsCzmx95yfh+ehw3YyIVySww41dJaXtd55vxXf/F49XIpM6Ib6WBNFHI7wiRmTG
	 8sHaAvJTITZPVSxMeQjNA1yumtDNCR/m3FarAURJgcLuyTHV2X27Fk7G83Gygc3b2bQZ3
	 GOK49FucTh32lga+4OKhSJhnCaJhdjkAQtDKjq8KsOuf2AL9yLvOz4Wz++U4rXo4P4QHu
	 qr6uv3/iT5kmqAUtZv5z1vKI5AtoqkLxwrwq434BDBTgKAUkQh3Bl2YhUPim6nvf4kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PquNKABWi0C6tGTol3B3b6YxtKfoZjVRBFpfFj8hv80=;
	b=UK90VQdJUNYeTc8uJjbqF8GRrd70ncX3V4d6A8fQDASC5ePY4PWtXcvadbTVw8o8tF1+
	 EFebw+UlpFj/oauwCiI+lUlPaDmSUxqTtAR0oX1E6xPZEzTykriH8NVOtv1QAZPjY0jZa
	 5z1XSCrCfOlcAcXVrWySD13Vt7cmsjUYJpHp+wEHvuDJwzMv0+gRVqrchEF8RjQ8FhQQG
	 ibJIW5SFonrbXW/ET1L+4Iv1grO5i3CYdujhcca/g2tURWrPU7iqCnDO2sXUAni6vn7cD
	 su/70BCInoYmq7XtDq1hS8kgMbJm4e7aht44BDLoR/AOBNGYAYQtjDFQMqi8M2D2PPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guLijxjT;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D4606A326
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 08:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C3D4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guLijxjT
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so1136436a91.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521067; x=1794125867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PquNKABWi0C6tGTol3B3b6YxtKfoZjVRBFpfFj8hv80=;
        b=guLijxjTMJ66lfe8n6JMhPGpbFDCjjgWc1gp+wR2hHlNR2BFETzJHyZvtojeB4V0ap
         Qgwr4Nvp8zeubBiwsErHaPxQ1dx7Kc7iHSxjfoPrKEWUZsMzEYzwxmPsEtixyD/TD4du
         bbF6dCwa5HSE96wTUvihfcqYutieQhyyGuWmo3VZLWpubLCrtbKsz0pk19k16Avhp6fN
         GIhlUnytDFwfQZ9K/HjeNscYCWHrrUx9rXrg/28tR/2dZ14Vc0ohkzEocbO5MD5IQvQ2
         9w2oIAkyHdT4HMU1jnxuj+bLqxrxjRCVVkkNINuzWr877xU+8FfrXRogVQuqZYziny95
         /+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521067; x=1794125867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PquNKABWi0C6tGTol3B3b6YxtKfoZjVRBFpfFj8hv80=;
        b=c/K+5MYRcJk2rXpMRgqI9GPfI+WwKJtSql7IbfWHFGE1cXgNISj+ebzswJ0EmhndrV
         1bmrJrFzD22g8IYB0TtyC04wGTO1OHQxDJFZ5HCjeuFG/ZCBXnCN38nJfJ3mfuWtjDyc
         Dni6yPn9xDzyDMR0wZamrk19DQ+/WSA65ObpfhvsujmOvv4wZzoWoI8gJIo90UTm3C0s
         taZ4iHN98y/ph2nyBPfqc3JSoxIVPn2vFSgd/1AGbeP+1e2INfrNuDx/Wfh42WtZILjS
         e5FZ9gxOMxkHlrPzzVZLkkX9AtRoFr0nX7bDPsE65sfU9PGWAAfscDymBQFIKQPH6W1O
         UqAQ==
X-Forwarded-Encrypted: i=1; AKwUvByOeECcbx0/7Liqs8pLdjE9diIEUADG6NC4vfPq7miPpKRvDQzvqaMOWtn/hLqpIRIX+ct+i1U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jObqTfQsTX41jZDSsQB2jtS7+TcNsRV/XDjHpLUWVSClv1A7Z
	CG7grB6eSBJI5hLwq/YuRg2HZwIgKuOsO6LDCRMO/EVQvu4shek+QH6s
X-Gm-Gg: AYBFou3LC9sayBZgf65aM40/OZ0LtfhaUxyiUr3FCvCmvcSLhd6FHaDmAzCODxQtCxL
	/yx4cp9Km+ngPiM+IDl3OJJTpACbIvaf5BlPJztzm/sOXyGJktYGiLxKKFIIsjwLg1y4183SKh1
	fdX1wMxGjctz8FOp32k5/A6l8X3C7ldA4DUj+EoZge/vXaDwxYhI3b+q210gtEkJIuLffOBGQEI
	bcdyDsBLVLLRXagT6h5a8K0ZYFcpbxEZ4NeH1KRxbA6X/gELg02nPgXqcaJ7tng/FGQug0ZleSV
	kTB5joDWoV9ie4ZDCOMNlTy8iZjy5OYkRC5JbGkzox8rrn8iEqOlpoR88HwOogcr1f050tJATN0
	/2mifKw4PAcLRTZ420aU8Vz4eAiIERdLG+rcdR1//lZ2/va+ZJRdkV0Fn8cxllRY+DXbPthBQ04
	EO+IhdGvRIAv5ZpPPBV5FkRQ1li2KFOfx7+POUVSpgQZKjdI7/0dest5Rh9notxrqgI/cALIUT0
	rI+vfR9DKWQLa2tFDjvpz+fC8idzENe1bWnHp+zWoMnQjTPgcuRvFtEGoOoyoDFBXyFz1amIdOL
	XxplExNSreGgyX8qp+dL7Ve/RBdsVpdb43IaNJMdu7cl2uBYWx348EV6Ra3YbqjV5JLpHpf3Ay6
	b4CNUKHiDydC8BppDR/ExCGm/
X-Received: by 2002:a17:90b:53c7:b0:3aa:412f:b0a7 with SMTP id 98e67ed59e1d1-3ae89559e5emr3615666a91.5.1793521066862;
        Sun, 01 Nov 2026 01:17:46 -0700 (PDT)
Received: from LDYT9Q2G2M ([2a09:bac5:cad2:3228::4ff:28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84596e3bsm10011455a91.9.2026.11.01.01.17.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 01:17:46 -0700 (PDT)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Finke Lennart <lfinke@student.ethz.ch>,
	netfilter-devel@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] lib/ts_fsm: preserve token types when exporting patterns
Date: Sun,  1 Nov 2026 16:17:35 +0800
Message-ID: <20261101081736.51803-2-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261101081736.51803-1-zhiqizhangg@gmail.com>
References: <20261101081736.51803-1-zhiqizhangg@gmail.com>
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

Dumping and restoring a tc filter with an FSM text ematch can silently
change which packets it matches, or fail to restore it with EINVAL. This
happens when userspace reuses the pattern returned by RTM_GETTFILTER to
configure another filter. Dumping alone does not change the live filter.

fsm_init() replaces each public token type with an internal character-class
mask, and fsm_get_pattern() returns that converted array. For example,
TS_FSM_DIGIT (2) becomes the _D mask (4). Restoring the exported pattern
interprets 4 as TS_FSM_PRINT. With a DIGIT/MULTI pattern, a rule that
matched the UDP payload "7777" but rejected "AAAA" starts matching both
after restoration. Other exported masks exceed TS_FSM_TYPE_MAX and are
rejected with EINVAL.

Keep the public token types in the configuration and look up their masks
in match_token(). This preserves the exported representation without
adding another pattern allocation. Initialization still validates every
type before it can be used to index token_map. The extra lookup during
character-class matching avoids storing a second copy of the pattern.

I identified this issue. OpenAI Codex helped confirm it and drafted the
fix and changelog. I reviewed the fix, built it and verified that the
tests passed.

Fixes: 6408f79cce40 ("[LIB]: Naive finite state machine based textsearch")
Cc: stable@vger.kernel.org
Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
---
Changes in v2: describe the tc impact, split out the KUnit tests and add
stable. The production code change is unchanged from v1.

Validation: updated KUnit tests change from 2/15 to 15/15 passing on ARM64
GCC; ARM32 GCC and ARM64 Clang also pass. An isolated QEMU rtnetlink/UDP
test demonstrates altered packet matching and EINVAL restoration before
the fix, with both corrected afterwards. See the cover letter for details.

An ARM64 userspace microbenchmark of the extracted matcher measured median
paired slowdowns of about 1-5% for tested long character-class scans and
13% for a one-byte rejection case with appreciable variability. This is
not a measurement of in-kernel or packet throughput.

 lib/ts_fsm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/ts_fsm.c b/lib/ts_fsm.c
index 053615f4f..8725ea6f0 100644
--- a/lib/ts_fsm.c
+++ b/lib/ts_fsm.c
@@ -126,7 +126,7 @@ _W|_L,         _W|_L,        _W|_L,        _W|_L};		/* 252-255 */
 static inline int match_token(struct ts_fsm_token *t, u8 d)
 {
 	if (t->type)
-		return (token_lookup_tbl[d] & t->type) != 0;
+		return (token_lookup_tbl[d] & token_map[t->type]) != 0;
 	else
 		return t->value == d;
 }
@@ -288,11 +288,6 @@ static struct ts_config *fsm_init(const void *pattern, unsigned int len,
 	fsm->ntokens = ntokens;
 	memcpy(fsm->tokens, pattern, len);
 
-	for (i = 0; i < fsm->ntokens; i++) {
-		struct ts_fsm_token *t = &fsm->tokens[i];
-		t->type = token_map[t->type];
-	}
-
 	return conf;
 
 errout:
-- 
2.54.0 (Apple Git-157)

