Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793858636;
	b=zCdT5FLLBtIdW0w5Iw2S8ISS+cCgAbqRBlR1xO/ifMt0qeaYUIy2HGRx5GVcyegAkS9e
	 1xW/GvKSyhcGUbPdr7FO1Kh4Z35BqeMkgLHU4HWLouh58SfBgCo4gZ8S6nVhp+tXfTYHW
	 KMFr5VumCEJ74f0mXCGiwk9220n7AhxnSJv6tDkhZssXYL0J6IqhjAFMMjqZpyJrcPk1r
	 0CF4R011pRnkPtQ3Rs2YoMS6wJ4AwR6bzE3iFb+lBv+FLtys5O3N2bHGNICbMBjOfyCGx
	 xlvF5lZhZWFfSM1x8AjL2l8OACieqHFrsMivUD/Ss9WTz3UEI9IQRWgUehQ1cWUGkCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fl+RqVSy++c8t4D9ZLDA6qx49eqFU8GFdwgJMfJOyN4=;
	b=nyfpwjsIkLDPlc2gOqL8eXBGkHX04bmlUJ4psBukFpLPSmN4Omfc43zT4WdZV2VVz9Ax
	 VVuk4m9kVFi5dpQRg3VbGI+utmrRRkO4HeGoEs1OunNFGcva1thihSCGXW1+Tq8oyN4+x
	 9zwU4DAQPYvXAa8XfuU00mxUEioYgaFPBN19K8jSGHH/Gt/vvhAZYXIk8d0jSqOuPad0A
	 as/kT16nsRgM9LN86H04+NqtNQxVwhlChKaX7L/rKjs2JQj9yvyOAJsFtqD3Zf56VZGs+
	 hDBLodaKjFLPokqD0WO5J9+ZnzZP2+YqZOZQ9AmkQy/+Tvr5MCb39O1KfkwOkAt9EZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sITsORkr;
	arc=none smtp.remote-ip=74.125.231.202
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5949606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 06:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5949606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sITsORkr
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4c3bb46aaf0so715119b6e.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 22:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793858634; x=1794463434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fl+RqVSy++c8t4D9ZLDA6qx49eqFU8GFdwgJMfJOyN4=;
        b=sITsORkr/kUi1tLLm2LhV4O4MeBBZD5P42Mn7DMsbqXc1l0My7lI4VmgtVtnfCNRPm
         F2K5ABd1e0VHSJ8v2yESdYDjTq4i63tkKEsmDkfU94JGf8/kaTIlpLIWCue9vT5bF1Nu
         nuFchHwAR7Ftsz3TEZCXr+WCGl9OD/waFlfO7CL1Jilo/txk7zlc2begOhUWVb0h/j/R
         TGbTC/6DEKgD1gf7luCdWPsrmDKhVsiH4PA2kU5S6CZ068gtUu1ny0pcnBfzdI1R8zjJ
         BNwajppvpcVWWXsA70Yz5DddZP4BTQKmTeGOmnqBOD5ep97jZ1ZC4JL9FAWfb5NB8wJq
         qSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793858634; x=1794463434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fl+RqVSy++c8t4D9ZLDA6qx49eqFU8GFdwgJMfJOyN4=;
        b=ADdnvfoR0pIHuT/szeySy9ER9cBjbGrzTywTZvC0EH2hOZUEUTjWR2gHhI1dIpQVYg
         1IunefhK0XDtXFAc9ltDDnM8byVXy4UM/zizeFu2WJbV4e+GZnes1y4i9uRrRxzPNtM5
         +X+vfCbAwnHhOQbZ6rIBQQfUQa/1HbKQzneLfFB4yLBfqIIp+BcK6ZEC0sNg2VtNRICt
         XzIKwMDitZgqoFxT7jPFu8ZlVLh0YXGw+fhKTQsUgh7cvtJ43oHD9etggxu06HPx92N9
         CVIdVgix4fTHw/nYv778mAKOhApoTMrqxxRQ8ztFQ2e3NnST5GfAPu6IyCSvo66qjNp2
         nMYA==
X-Forwarded-Encrypted: i=1; AKwUvBzPjAKT3/Yqy9QN4THIOJyjE55WLMLiuPHCf7BMI3TwktAwUtoh1xtSB7L1bWevXYKG11gFOD0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VJTvbiC1ZZNePjNkroZDnNaibn5FeCTrBGtrPNEi5cUzrnR/a
	+Qjnu2SrvhKHGBUa4AzwaNiGoR5ObH6TuSNMNXk6X5xwD4YARayE/hCT
X-Gm-Gg: AYBFou2qRAJupRVF2EHF6JA0yZfSYrxisjWC/4EKwKT+w0YQ8b8RVLkhjvTG3f3U5po
	jXslqVisKwvvkhBcCJM7aNvyZ3Vw71hcl1EIX2k0WpIhkSjZ56K2Wpz/3AcjOKyqkNjT8iU8aWc
	D0lkbgR3XrY/K+Gvp2bIMuGr/tLfGpaAK1Q7kBA9eM1GdDfay4yKcYwSj4nL1SekCjAQEbTSZdT
	2MkU4wRB8kDp2IprPlhivfjGy657YhHsLHhXynCjZc7FuvLNIXg0Qq2httXwy/r5VeJm2YBerkK
	+lq+P0iZ+rOpWFf/122h0Ryj0xgqXBEHOTejQcyJAnPLj0c7lv8czGJv0tULXFabLfPGk0I4FWA
	6EN30jCrVUXRrtYFvOJ2ukEYCBItOf6UxsCAfMV5KYxLelqP+PYuHiKRRCNqXutC0KkvSC/e84f
	jplcRk8ss9cLQgHIZD0TDRTj5FditIiPxheH3HV1Ps/guVx14Eyt+muQhZG4bpPmhIbK2LDUY3P
	hvHTd/1Vnc4oOyFavFeQ5EoZABG4Ep1VOF08bu0KwIMKtIgZAxOzRIEKi6MhkiSqbb3pT7sLGdV
	6JUBB0oK0aXER/PvcLCCGyEcrOYFjTEIp9XM1IEPqVLHVU/OU0JlofmwHgkjW2gvPOw=
X-Received: by 2002:a05:6808:14d2:b0:532:963f:3118 with SMTP id 5614622812f47-5640d97353cmr12997705b6e.3.1793858634408;
        Wed, 04 Nov 2026 22:03:54 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f41424sm3493476b6e.9.2026.11.04.22.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 22:03:53 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] bpf: fix verifier model mismatch on __sk_buff.remote_port narrow read
Date: Thu,  5 Nov 2026 14:03:31 +0800
Message-ID: <20261105060331.1912252-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

On little endian, the ctx access conversion for __sk_buff.remote_port
loads the 16-bit skc_dport and shifts it left by 16, producing a
4-byte value of up to 0xffff0000.  It reports its width through
bpf_target_off() as 2, the member size.

A 2-byte read is a narrower load of this 4-byte ctx field, but the
fixup pass only masks the result when the access size is smaller
than the reported width, so the masking is skipped.  The verifier
models the register as [0, 0xffff] while the runtime value is
[0, 0xffff0000].  Arithmetic the verifier folds to a constant can
therefore take any 16-bit port value at runtime, enabling
out-of-bounds reads and writes relative to map values.

Report the real produced width (4) so the fixup pass applies the
usual RSH/AND masking to narrow reads.  Full 4-byte reads are
unaffected.

This issue was discovered by Tencent CodeBuddy Security.

Reported-by: zeroday zhao <zerodayzhao@tencent.com>
Fixes: 8a31db5615667 ("bpf: add access to sock fields and pkt data from sk_skb programs")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/core/filter.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009d9f1eb..6eb4751441f39 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10455,13 +10455,19 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 	case offsetof(struct __sk_buff, remote_port):
 		BUILD_BUG_ON(sizeof_field(struct sock_common, skc_dport) != 2);
 
+		/*
+		 * The converted value is 4 bytes wide, not 2: on little
+		 * endian the 16-bit port is shifted into the high half.
+		 * Don't use bpf_target_off() here, it would report the
+		 * member size and the narrow-load masking in the fixup
+		 * pass would be skipped.
+		 */
+		*target_size = 4;
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct sk_buff, sk),
 				      si->dst_reg, si->src_reg,
 				      offsetof(struct sk_buff, sk));
 		*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->dst_reg,
-				      bpf_target_off(struct sock_common,
-						     skc_dport,
-						     2, target_size));
+				      offsetof(struct sock_common, skc_dport));
 #ifndef __BIG_ENDIAN_BITFIELD
 		*insn++ = BPF_ALU32_IMM(BPF_LSH, si->dst_reg, 16);
 #endif
-- 
2.43.7

