Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795105595;
	b=eziryfMjVsVipLY68zkonhm6MfuheGmBCJv6dXVSgv9vlxsRxVjJ6RdPwUCSCealZIco
	 dyufPHJq/i9o6Ib1DAyBBPj/EwRQL4hcXG3CgQuZzCLvdzJA4aWInddrq04dP1H7rdJYl
	 V+Z10dRP8qSqZAQ9opjfFp+hs71qL8eYHcc4WMJgW7Vhzz9kc0y5cnN7i/Oxq/uN3TzqN
	 pSyeusLLDfvIKC/3PdFWYGB4rzK878s5HOIplchex63sV96fcRQaE3eu7nD1ZbiqLu3L4
	 Hu93A3Qt8ofoDLdixq6JD4ET1rgTvWi6q+pKx4xzHunBWCD/0/qUZfuLFI2/OH/FlTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=+MSfWkaCvsypi1LjUwVegIyh39nXJG5xylP4jvGm2YU=;
	b=mXUn5PkjzliPMjgJuLTELMyMTrOV+kN+niUSg7GbCDhI6s538DEYoNDkOr6D5gZuxIZH
	 8aP9MgM/hSNBnjgnZtKXCtbmmVBlQHu3NkvRkohBlW6E26J9jE2UU8jj9fXeIRNLJznx7
	 4SZQHaZFZyNNY77zphc6esBPplj/AnxegxxjSuTo7KDMs7qQbnQeegOiBNA9lYz9TsJMp
	 flNcopLDWVww0yQ9lY9KNI7FPXRnotmfIV4Gz/X4KXtaNCYCMt+DW24MdqX5xV7yKbcjI
	 9pmnT+XPQYq10UieY3UsuvZ+bqVxNBDJ3iPQU1pTvB651OwHHphTjWkGSOBM9dOnNIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3XcvJyP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C15606A33B
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C15606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3XcvJyP
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d2e14babc8so1470088137.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:26:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795105594; cv=none;
        d=google.com; s=arc-20260327;
        b=Lyo3d5P8v7+G2Bf92Gg9gCnR/NrLpNuU9RGqJiKFPO015HCUf7GuZ1Y//kcLQXVRDb
         Rl/sijp9GlWS3caaateWxK8cpYjpZR0myRooncHjVxiWIcXR3Wg0Hhr/thePIeKSZAR1
         omYEGm3jaksJFuiB1vhDQdeMWmkBhEh3P0JdlbWX0B6usdfykrD1aAD7wOmzH/AOe81R
         cqmfUIMKwdLqvJbW6Y3fbOeCnBTYBzpIuEUfGtLUUnNUFFPmJho2Yv5wgd5hdT6yZW/x
         3B5f4XxlKIcGCCJlcH9N/o/svwvlCR2UpdKjRuZeJ/NQ1oG2dKVchnVo3rxK60tXFHzl
         3qdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+MSfWkaCvsypi1LjUwVegIyh39nXJG5xylP4jvGm2YU=;
        fh=4Z8kUo7ZQAE52QDzrWjAPPpNicBFhQXYM+Ho8XX93z0=;
        b=Te5gXCep2YtG4EMhvM5TJbx+/fwXYqCWgcrR0IP2QOAyumfH7soL27EcfLaPYTylzl
         dmi4afrl0UvX5f3gZTXYWeO7XoXPbRe/wtTdDV6Mr+Fng/o7lFDoNiXTA5DTBEVGJdrM
         BZW2LqCzvT+PFmRChCBRS12vtM5BfSLW3bcDTU6SmdZ53O2IEFO6E3SmbWd/8Ov5oT+h
         CG3YiyMkjGsyxgtWqeCUK77u70gzw3kexsAB0orY5T4jALCwjk8Jb8pSf47LjBOgUZ7q
         x1qtrefajVykrOBsbAoLKVql4IK6uvA3aSAax0CESjeRPnip3K3ZgIiDtBs8bn7+7QTG
         k3hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795105594; x=1795710394; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+MSfWkaCvsypi1LjUwVegIyh39nXJG5xylP4jvGm2YU=;
        b=o3XcvJyPDMVgo+Y9ljM+UiiOmEX1i6mzTbS9AvOr5Wlrxm5UrmqSnJx63v1kqO+tgq
         CJMCj2RP556/QMgxXBGQIZe95L3na8iuvojp21Yee8N24VgYVQjFYyjJUS8Mc0FFY1Yj
         B1jCQ1a6AmZaJlSWIa4b+NJPb8URGzwycauK7ADiRDkwTufnCah3cD5ybG9EMxRY63P4
         yVXRwO161+a/Fk4PjRSE6QE7SkeRCWE39PzN15zbnHk1Y5ts+Dab5csAEwCfN6KnVWzr
         oYWseARcx4Ev4FWcWgufOdCFyv7wYLyTCWafwl7epxGrkky2l6y40EaUAFOu5qvN831L
         TOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795105594; x=1795710394;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+MSfWkaCvsypi1LjUwVegIyh39nXJG5xylP4jvGm2YU=;
        b=hOZ9TtZX2oz39Bse4H7FuiN4nY+aA9QZKezeNl+nHrPkrXCjIyTK4770c9T6xdZY/N
         9njTAgeZgPJab94w5lDK6KqbN4g5EMv9ZLNxiD7N6MeXNYx1FrJEHxlQ8Jovb0ihw5yu
         bkzQX9FHw8jC3JbCAm7jvl7+srVFx2HM4l9Zr34B2YfLJDDIr7cL6y3JVOsyVzS+C6U1
         pVoxXXqVXOQkFvNjigB5tJeySqKxz2x+5S5FtbAsUzkk8dBNGv5PZeQjz7ilud00B6+/
         npArKxGX6ajKDmvDeV87Xw6s4SNAMFpoowHoV5DdJag/DsbUJs4kKZDRowHpY/Qu3xrQ
         6ceA==
X-Gm-Message-State: APuU4Z9Wv6vcDQLaDX+moND39a8fLvqRbVmLOEyZd0a76v04AoONVQ/X
	RkmfK3hmzdd7kCMXs2mFVM/bd0VKWPM2AA2fNyax/zwCcTaqrt1sOISxQB8kR6+56iQRGCl/mKZ
	9TRAaxOIhwGNZXWBlKiCws/NLRI888n8EQwsvxYyYSDS8
X-Gm-Gg: AYBFou1aUaOtjCDAGuA9Lexxf+qqS7MZyt3oDlF8z7RAFlSnxzt/xJ5MtHB6wGeI+wR
	p9SgP5/FEV7PqPC3qWDwqnhz64FK/DsM6PNzZ0MGEONqkbLW1JtcYL9GEAuLbvPtzeqkuZ+pf37
	emILYHNeuexIcU7dQHYhvZWb1T+cE+hjWc94essbOhdIoSxo3DL0/49Gqx0Th3onmli/awajp+3
	lUssQKv2bnvlgdliTG6eHtXKaqxfnLVHPtIapLsCm3a4X9ni9UmDFkGQyjZYaciJQ8IaHJSRcmf
	OP4eLRGsS3MYaLI0a9rVAtIw9v6DJnop19qeXbGU3OTGjF5iJdvoV+0rUrDDKIaso0hZM+WPYrd
	R9plzWg7Ty6iiz1evBwNydcyO9RDpcX+x8UqB9Q0YVI20VlyzodI+qzLbsRmpUThaJMv5xqI+2V
	HHbZ1VG7Ms1iSps5nYLg==
X-Received: by 2002:a05:6102:5695:b0:7d0:b125:79b2 with SMTP id
 ada2fe7eead31-7d6ba174dddmr3393998137.1.1795105594292; Thu, 19 Nov 2026
 08:26:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 11:26:23 -0500
X-Gm-Features: Aa3M54rjo5bOdQvVn1fygWT_1nsGpBZbzMngceuQWUpmls_oZpOA_sI6n3diqnM
Message-ID: <CAMcAce8Fc3erawRn=4SvfuZjb7rovZFN7tQZB5Zg6mLvtDKgdQ@mail.gmail.com>
Subject: [PATCH 6.12.y] bpf: Reject NULL data/sig in bpf_verify_pkcs7_signature
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, kpsingh@kernel.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 49b18315be4e590fae0fc39c87d46c87e9ec903c ]

bpf_verify_pkcs7_signature() passes the return values of
__bpf_dynptr_data(data_ptr, data_len) and __bpf_dynptr_data(sig_ptr, sig_len)
directly to verify_pkcs7_signature() without checking for NULL. If an
empty/null dynptr or non-linear skb/xdp dynptr is passed, __bpf_dynptr_data()
returns NULL, leading to a NULL pointer dereference in verify_pkcs7_signature().

Check for NULL and return -EINVAL.

[ In 6.12.y, bpf_verify_pkcs7_signature() is located in
  kernel/trace/bpf_trace.c instead of kernel/bpf/helpers.c. Adapt upstream
  commit 49b18315be4e to kernel/trace/bpf_trace.c. ]

Fixes: 9b2d3e911295 ("bpf: Add bpf_verify_pkcs7_signature kfunc")
Signed-off-by: KP Singh <kpsingh@kernel.org>
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
 kernel/trace/bpf_trace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bac2db7..41e237d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1384,8 +1384,13 @@ __bpf_kfunc int
bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,

  data_len = __bpf_dynptr_size(data_ptr);
  data = __bpf_dynptr_data(data_ptr, data_len);
+ if (!data)
+ return -EINVAL;
+
  sig_len = __bpf_dynptr_size(sig_ptr);
  sig = __bpf_dynptr_data(sig_ptr, sig_len);
+ if (!sig)
+ return -EINVAL;

  return verify_pkcs7_signature(data, data_len, sig, sig_len,
       trusted_keyring->key,
-- 
2.56.1
