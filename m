Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795107320;
	b=HMYF7JzJYKjwuHnTeuiNw5HWulxkkEQhjy9UU/5NXzvl/HDO9cQKT037cjNkdZTwUzeJ
	 tk/QD3MpAwmjpzCwPCZBMSafDmwZHRIbEiIgUkgnvHI5mIbP+ZOB1XTJlHKI6wUsfqly1
	 UsO0ne51fNGywWslCfigtjhVJIFisFkDbNDDPV3viX4M2K6wdOPHo7WmrbaWP0bnRJe9k
	 4i2pun+medEfES+XHS6lEc9Vht1QUe+Zy4qo0yeyfyxgfracz+diA0bumf9K3/hi+pUb/
	 WCIcw8b+MpAbyPsqKULjfOoCOm6MLg+1Po76dTTm2G3jubKKOyLlP0y1VkqD+4yXFLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=iriD5MXJPRwsKgyB4ypuM5BIJR6iatqq6n6kcm3cbqM=;
	b=Wf27SqjgwKB5d62+HO045b7EnE0SsXqr7oc7FNm7je3Wb1DyeqHiZia0K1lGQxJN7mdj
	 kZCpJ0ur5mgHx7XdRHgZTLJ1gFIK1EH0uebJUtYdo4A3G+G2XWhAxnzyUQR1Vy+BMaL+K
	 qNgYkATjTbZ7vifDizssz3NA7ps6pdr4xJKbK+8nURvTQrHGo1eBumWX2wnrLawUu5mYU
	 6l1TWuOZzPw2WP/WyfWtVsr68EUq7w2tX6q+i9TRweYaRV/WWHHqe1wmThsa9bkROyZP/
	 0pdLSMJqprdXVRiPWi1y2ntUukuL9aqufI5JGIhTEPO8X1bd5pHb8zu0lGpsKiON0kQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dj6Q02wh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ED7606A331
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29ED7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dj6Q02wh
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-55ade1de0b4so25737341cf.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:55:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795107319; cv=none;
        d=google.com; s=arc-20260327;
        b=FHKpSM+DBAE4tCwNDUAtONHJsp8YKBuvllCEgGGJ3FPxZiyyGHGwSa1UQuOiqibDA5
         yLcEeC8LnZezHzNfDCaEU9LBpribahUTdmKfpCY21Cw0xab84YmWWI/w12oeAGyhgkEH
         oTB4G6FcSaUlcBY+qxOgnHfeOlB63GA9CZ6tU30uJTaIsSGdn11k4rPfco4HsVnWgqIL
         BSg+hd2BShJkp/pt46zmf0MjRrWAHxTEisIgfi1wcltfzeZAN5dQsp5UygqAudPZ8dYK
         EwBYTvW0waey6csNrTs87xBtW/ZqQFmZG7QtOUnHzm5YVDjFxcQbSpuGdd1Coe3+XOrD
         nzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iriD5MXJPRwsKgyB4ypuM5BIJR6iatqq6n6kcm3cbqM=;
        fh=4Z8kUo7ZQAE52QDzrWjAPPpNicBFhQXYM+Ho8XX93z0=;
        b=sJjo4vi6Tt1FMK2NmJk5T/dUaVqsCV7g3iWP7Rkp3RISgjnPiBO35tTLKT7Ij5XY03
         90kRJHcq9g0eRTiUiwDjqJq42YGLlvgOpNmHdxuphBZsm5nKtqbF2K+FXXm4uOJv2KMb
         W08TGrARSrs5MB56Lwel+yLRAKhskFuzgS7QcxG0zqz3nTNCXU6qFfQiTirmLfVE3lLx
         30EiLLmLL1GHd9AG0moQfCszZwOXavwpXszoILwezESv34emE//XV4VMS6AcObyMnIRn
         Nt1l+LM0OkPkpSICA3RFi0/nQbIT9Orrnb/Fx42Q3+A2rHtW1kG58HlnPjVGX1euw8qW
         RPRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795107319; x=1795712119; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iriD5MXJPRwsKgyB4ypuM5BIJR6iatqq6n6kcm3cbqM=;
        b=Dj6Q02whB6jrBbzwMSXDdZSXLTQx9U55nvIhh8VsfEtTdU0iyT/o5kPY7DNq+u0nYX
         LOZg0I3QLlaCJIkJvIrIbQb13qmp5ktE+mmgtpE0tt01WzUdeODyogZmCTJRrgMPVl2X
         M0D+NQ77UpNz2/SGH5KO/NylJPHiCmrW58WvbKq5CkN3aNYjSuFLd0AOvebek1seWTHg
         CCnbeIcuwLnxBUbtekh2wL9uZ4l8/89Rf1OjkSxNpQOAkm7rE8Lp9QDgOQuNqrIgklGp
         pUt1yNUQRVirdiTXvErC+NL51Am8phRLGCrwvoT5xjkoQhc6UAcJeywZPocdIxTSv1/R
         GD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107319; x=1795712119;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iriD5MXJPRwsKgyB4ypuM5BIJR6iatqq6n6kcm3cbqM=;
        b=DjdItmPY7AmG0qNZ4q87U5RFCtX9+rFw9r65iB6MVAUIUKUICOSZFMlHfEe0maRDsr
         iU5+cuB4rGuhRjBUeSXcuBInqnuaYsMYGt8mUxNS6Q1FN+73xyiheYwC2akg0mT+iZ5A
         NqNyNmp8JhWlJzaF08qRzIsbrB+xq2NdZ0a077jEPjffhF9Sf1UoVHRaq+JmrbA39sSi
         hjxgFMboxPZS5gwVnxt+oDGG9TWhwKdExGJ3dfdkm095ep118dKBaXk8Fj7R1e9tCQKU
         pL6IRq0pHvBLouTTyQUt44wnEqFNtQ4x+QbQNsN2u0eM/6a7aUd9gdkFZk3IyIAoyIwl
         oFzw==
X-Gm-Message-State: APuU4Z8QR1LrYTN0OeiNq8c5hZ0OdaaCb99wdn5d0Bb7Amm3s8QqY3lS
	u57mu6JJYOLhrZ+E2qqbk6TcxTJickS/nIu9MsnTBaIjLMq7IbS5KNHl9iXgMfNBHiMhn0OhvYx
	ETSyA2lS9/r7xy/ki4kBDLziI9xhVoSlnqlUVH6EBSh5b
X-Gm-Gg: AYBFou3AVweBYlIF4uxugMpnGaiV532Cjbhp2jjmvccvXRsSMlGGyHy3UCtaotIJNb0
	X7ius5AwsTg2TL6jE6gfjYc47ht22mPpRp8xLPZELcEdwIxL8joVf2/R6i5pzQ/9/XCQUacLabv
	BHyZX/5xz+S65edIPYavpo36tQhDGrP2UlDQtx5s0qUgWlKXmrosQzkFsy1rL4t3/VZ2Y8N5rRu
	HFfPxJORzaM0svIC6Ki5hmCq+GvRPoX3ntjifAnzMRmjCKs7xeNMcmaAUqMkcKcxN+GSbm0jsoN
	6Upz1pPOjVTucT1+2MD9mN+M3QjunGOlCHhARMfWF5u1M2N0j/m3/DRClq+JikpRCBXj0hEEVv3
	AGUB/o7zl7UAR0xzZ0H9/FYJ6nMcplFHSaj8u/6oNWyxpIG28fS0by6kdASqns6nkPjH3lqLs9L
	iHbRU4zJI94uqsEao/6A==
X-Received: by 2002:a05:622a:2586:b0:536:5696:165e with SMTP id
 d75a77b69052e-55d7698ee3emr8706221cf.2.1795107319050; Thu, 19 Nov 2026
 08:55:19 -0800 (PST)
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
Date: Thu, 19 Nov 2026 11:55:07 -0500
X-Gm-Features: Aa3M54o80hka7iVgEuzkvF5iRLkH-0ir8Ksq0bm_-gLkDHL4y7vTsKz_LHD8a-E
Message-ID: <CAMcAce97zgo7c2f5Th9FguAHEL5gL87NrJ9MJkJghMm6M44g6Q@mail.gmail.com>
Subject: [PATCH 6.12.y v2] bpf: Reject NULL data/sig in bpf_verify_pkcs7_signature
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
v1 -> v2:
  - Fix diff formatting and line wrapping in patch body.

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
