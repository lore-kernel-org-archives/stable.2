Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067738;
	b=liARUrJdWJnwXXfpitZVXaeoXslBqneVlamwfB61UofKP2DmsNHfde4oVhbkcGEFryKN
	 emU8O1GJNfCEem0bQKCKwcY5G1+Pyf2k0sUBh0zQjXuYMDcnm6JgjMvbXySqC/5T9QrmR
	 NmEgp1ttslLTNWzDlsGeZDwFUI3fVB5GaMELmcFQt4TKkPwFubPKVtfouR5evYdbJTglB
	 jYV8Mt76qexEt6PUxy273bADwuARDPC7fljDUnZGoOn0Koh+WzvPhYWVYrFx26/35a6fX
	 79xmUl8aqgN05urHRKfvR/uaUUudc3GkJQcZaOPS5NvbtWaTqFqGC5Fx9dU4PCXYrpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=DjEQLmEJOM/wymBBE+U6O32DcFNbSABmNjSjqPA8HkI=;
	b=b9dmFXYH0w0Bb7C5vD4/KPAs+2O9ig2EwZiuS+c93vuB1dH2pDwmR0ygPVcj3Hx80hSa
	 vUV8qWaB2jpXWBgBXDrGQo7kEAZ5k/vFfNpjZVMbxZIcWnlSiSfHTqRx7n2OzDtjDeTgX
	 Cw6YIjtIjKrmUqjwZGfPsKWHATVNhsh7oDTejdA2PaRM1KSJS3f9gi4zaNEhlTLCY7my9
	 sh1qtyykmBvua/S+6txMm6Jc8fxEbZ9Wxuh8/SB/yJ4XU1i2yk0JvN8lAqgriBXqsbcfM
	 qevfB9udhGOMCOIGyNAzjQkJZm9v9e7S4GvT2L6EHx1J0tIE8z0d8LwzHd3xiu5AUqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbuOgokn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF04606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DF04606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbuOgokn
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5430f70c827so26689251cf.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:55:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067737; cv=none;
        d=google.com; s=arc-20260327;
        b=maUGBK8USSJTJ3sRmjUzLf9yPFQw1zmd8zZL5Dx1CaJ29L2ryWThpBs89RO+eJL9uW
         bUsSDeQd6gNKkiXIipENzB9lDkhpfrsXM+qJZkL9qwkWYEVC4UCqROSUnUmPK0+sfqQ6
         f705Xn/c4Ke8aFH/ON8YqmULKts6ukr/jA+j44w8sOMAmNnrPqDXMmflaiRfOZsW2/EU
         hqGPxzAYGYDORS+cD3VspdmsTn4Pjz+K2j+nI81sL9KILpSeWzIp9pL/X7nOy17q5PBm
         zmM+cotWr77oQyrBhKUcnCNVJsRjAphE2tIXELIx7pNVjka8gqJQEqIUYO5PFAmLUlSo
         wOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DjEQLmEJOM/wymBBE+U6O32DcFNbSABmNjSjqPA8HkI=;
        fh=hh64WXw32xDCPRIwo8kqdpPDKtEO7rcNvFi6kTS088k=;
        b=ZlzmQlAv/fciOSF9Nku9oVYpVbuVznsRIhqZgJTXM+6f+qy32bo8ZD4Sb2O733hd9Q
         82PYFEUXnSVtclQKQjFFiy7tAw6sOcIAcQezE/yN6z3a6kDwdx/9PmTGqT9dLYBMMMAv
         LETCUjAH1TEf3EqrECjscaaOICFivim6LBj4N7X4kmF9x3EzVlJEK/pEjVbS7/wP2xvi
         YnYmJQF+XJVoXtNpHRK0nS23bixVjpFtv32JsNqitQWwLlFh7qAsknrTNDAgzJuYsszX
         ZuOgb+ZQQcR6Wvo661RUZrGWexTY5hlUQbIvhlzDP0rTJ8dENWmyyYV/ESj00JflzRIy
         4cSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067737; x=1795672537; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DjEQLmEJOM/wymBBE+U6O32DcFNbSABmNjSjqPA8HkI=;
        b=YbuOgoknImPI74dkeDko9dpj5c4Cb5rCJh+DtFAF1+VA5OoZsNx6xZ7ahto3GzLFj3
         Nfgd+11PhrZRn3OBt1TZZ3QunJv8ZhlbyZt6uqgH8AswyRUREOyfCUyM3j8vXKuXWGCf
         56dR3A91S0TTcCwV8dl4vTvXxLoloTAfyu9WzQOgiY1HFqE1BDdpRiRqHzJEOpY5yFP2
         YPDmXK2360I0/kUVaA6oy6fyTy/Y0eBGty845OASH/pKckqUPkO0KxaYsZV9IN5Dd2xV
         rA8CmzOYY4LEINVPttDRQ4OHja7FMva1I0+IkIOgMThd6nrb7EvnYvEgXhQF8lF+kumc
         c2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067737; x=1795672537;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DjEQLmEJOM/wymBBE+U6O32DcFNbSABmNjSjqPA8HkI=;
        b=ZCp1RWFMfU4aF+6u754MfEwjA3PQ6AwnVrPzrx1nF5B2qyUgiUDEtjNydShwd08xf5
         Z0onm/9pzuZtQeXgEUsZPBvNqFnHII/ymdiB4tKzB6MTe8YXFW4/yDBT+i1cHkf22hbp
         FfaWn+QASIEVbaHXjA9SYLNhShdEP3Rx7qp5ZvvSqn94Fjn5aBKFTFkiskUCbNPuIDvd
         eHYBUXsDiBUPtEy09zw+WfkuDMxZDt1cD5wqlUUaUsOJFGpnABDMSd/G5NKavRpGXfiU
         bgbMDmoPY8j15+2DiFyq0A9ZRrvnXghp1fXi/OeQx/Q4WxsTKgrPs0MQQGeBv6cOQYnj
         ThxA==
X-Gm-Message-State: APuU4Z8w0uB555WxJOXIcUJS+mRH79lc3D4o4NehxA0rxxWUBB050ESq
	H5M/1shr+nu3ZKAsNcL9gbtfNaBy8958DA92koWxnYrgx5vuQewCOJugTSxoDYpMeUpP8C5A3Wc
	KGq3nczGDka+3wB0sUq9jxHdv/Ib1WL/DmaMjt0aYxKb1
X-Gm-Gg: AYBFou2USHwJS/woSAIBczIGEIKHiLm7sxrVZlzjIhdRHwKRIU+8d2L+8iCziU/+oNx
	RO5F+ru5PCu7kaPqBFV/uZklZOb1yQVu5l1AUxFjnuzo4+/QyiPqnoUvhCGTDiZsHZ0Lro/5MbT
	dIRugRnAafixXEwiHVhB5led2awSUKBgWhoqbxStu3GDsjFl9cytAJcVmnVxKFojhSo+27pqv+U
	zvS9Di7i8hc0AcQ3n17ZFazpPS+0pbjjLnOX78CBYEZtlSe3FvlR9NEx6LcfGBm1gcSF/XfGIry
	GUt4UcbrNrbtFxYaMyfI08exICaOm9n8b88wdku82n98ExAIZU2XZ/6kldU5xpRnjDA1/Dqo/CD
	fJmwbYovmJmdGcQA7Qgasch4ObAYwQ4qrUWTXxJq6LLrvxncYQy9OzQwyjnXDdLxTbhPt3uQM4g
	ucT+5QEukhN+Mjq4D4XA==
X-Received: by 2002:a05:622a:1a90:b0:536:352d:65f6 with SMTP id
 d75a77b69052e-55d5a62eb65mr76732251cf.64.1795067737385; Wed, 18 Nov 2026
 21:55:37 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 00:55:26 -0500
X-Gm-Features: Aa3M54pnSDUBBRf3lpLwcke7tzjfHBwFC7TFUZGPR-wTAHAk3o_xI9NvaAJLh0g
Message-ID: <CAMcAce8eFDXx_BqjMPd-94uX5Hk4KNxkjPtRXW7wOvy_hWjAHA@mail.gmail.com>
Subject: [PATCH 6.12.y] Backport request: 49b18315be4e ("bpf: Add NULL check
 for dynptr in bpf_verify_pkcs7_signature")
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stable Maintainers,

Please consider backporting upstream commit:

  49b18315be4e590fae0fc39c87d46c87e9ec903c ("bpf: Add NULL check for
dynptr in bpf_verify_pkcs7_signature")

to linux-6.12.y.

In v6.12.118, bpf_verify_pkcs7_signature() dereferences data_ptr->data
without checking whether the dynptr is empty/null, which allows an attached
eBPF program to trigger a NULL pointer dereference in kernel space.

Upstream commit 49b18315be4e applies to kernel/bpf/helpers.c, whereas in
v6.12.118 this function resides in kernel/trace/bpf_trace.c:1403. The patch
logic is identical.

Verified on x86_64 QEMU v6.12.118: passing an uninitialized/empty dynptr to
bpf_verify_pkcs7_signature() loads cleanly under lsm.s/file_open pre-patch;
with this check backported, the verifier/helper rejects it safely.

Fixes: e917c6999a09 ("bpf: Add bpf_verify_pkcs7_signature() kfunc")
Signed-off-by: BoBppy <inkxiao12@gmail.com>
---
 kernel/trace/bpf_trace.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1384,8 +1384,12 @@ __bpf_kfunc int
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
