Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3513C4BF953
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471565; cv=none; b=GOrMmnwcDJh7kxvRaiZqNF6lCgn7t1LoimJ23oRSBs+nRBhZpVPtCR+Vmrz33AWsFDe0yyQ0R3RgdRUVKIRnPy7T4qrSTy+jOaQ6wn6uHERf8HeW9c0XiK5Go/Rp1QNDcs3oYMh6A43WDtmyJclHJLM24gKj7E1wUM2C6n86GoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471565; c=relaxed/simple;
	bh=WAibr4NCG5DfebtNnfyiUpxS/iVF0y9KGGf3TXWumes=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=Em93MCvBPrKlkQcswEgqTgf9d7s2OO56msPsXiUXCOMKKqu/t9CwySj/2WNHbK153io01KwSnaiHyyoukcwhHCtow860zDS+1mMtfi6m+vsojqHrZYtPih/cH8gi+eQ0fIYJaubwf3L2v/mro69v6MZLxJcShiqyhtL9v2e5lKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxKVp3wQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxKVp3wQ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-872024e2b4eso1589683b3a.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791471557; x=1792076357; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WAibr4NCG5DfebtNnfyiUpxS/iVF0y9KGGf3TXWumes=;
        b=QxKVp3wQ5DM6vDT9Hadg1W9qKtA8QTeOwZG4SYoskEJJy7bIo5gekCn/Da3AFDQCHk
         xOPnoG96xyDWebR8IO4cxq0X5ueSLowv1HUm4n3fAFZrF9E303rMR+IEgaYSsTjQ/dJl
         vEe6ApK8mrzOBuLrmiJqdh3OAEjMnOshAtzf1qk+x8P32drnCXBOVhjdxPPYMeCa71S1
         6YCOE0KqVzAoeHTGxkLx2usvJkFlPISPqDw59THEidNEQ742BVEHexVAvcpZmnrtC09d
         B0hmLv5D84+bHwtaoy+9KsgwSjPjeBKXbPtn7Q+iqB7sKnHmQOV6NquIEk1B6QnD4wlc
         KcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791471557; x=1792076357;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WAibr4NCG5DfebtNnfyiUpxS/iVF0y9KGGf3TXWumes=;
        b=OAW+wpTLyTVkvLcmOxXRhxBVpOMnBXsV7oZ5zkxcolbdF8vHMNEa1j14U24IWssvhL
         mWPxgiUOla2MxUQfWlMeUpkPwnkIN79lDCgSo34Mf43HLqKvHFaOr3jfcArbjcvtrHbI
         IzVcN/Zk4AGwQeDm96u1sxKqdkXgj03PgVwK54cV0wBX3P/hCxmGFxQB3dlRQqil+Ge9
         ow7BBAkq805gNDKmpO29w/MoVA3b+ygx9NXTrS9Q5r6M5lsA2MiA6rh3y9bsYSyeIMkK
         GROTHmdD5jtlrXXAtzcCWwaWHVOkPqWRJp5I7/p0NQU+qCbEzxnC6/nBp51yRT+NxuXs
         tU/g==
X-Forwarded-Encrypted: i=1; AKwUvBwfWFms8QYZQNY2tkhsL9bid+JjBia28iqVdT9SXBqn8c46WMEiP1vNKORLcKZM+XzjCiHFxjU=@vger.kernel.org
X-Gm-Message-State: AFuF++nNL66dJhGWsCNNhUtcVkX5jjixTpPV20TXzNQSbvse4fDPdEir
	z44rocOp4KGVwQbxk1lG19KkYLvO8W4buRs8yNtBWIabT+LYq8xUApmL
X-Gm-Gg: AYBFou1GpniIJlns01zH8X4RO4sISr0qzQFxYge7WDByP8KyARL2a74m3XQ3FplmwxK
	UWwdlBI2Onqg9lxUqd5Y1OAUOeFfNH0PAyj3XXJn97RjUrGClDtIUHYBVicbdnEqg3aHUFIKx4U
	iVUCe6KknzW5fG9Ogrc8R1Gxlh5Durxf/JqpBre2wbiT99WosoHMMtPkRWLamCvoktZIxcDH4iu
	UtoVCOkgA3fOBkShrzH0FC35Oepa0pSVYRb7avHhGih3ABRCSyAMQcF1yrD0/HzMOnFkhfDowX9
	aS0WzouY+zibdBfS/ZPf6TTW+/67cJYevacfbZkwF7mOVfE8M6FEjT+uzI2AEJhiZJ0kWnyQRt4
	HAaw007FnzjiMIaSoe1YWFOgtwcwacBA+G8gl9COPSZ0wl9UcTzdi9KkqEcrlO6hKb0YaoKLgwC
	UatsrFw17f+M0qOBtrbwvV+ppmTqCw70TqHsgrQYWhWyp+D/VIfFDpD/2CxbnRsUwTa6vFwA==
X-Received: by 2002:a05:6a00:1803:b0:874:705d:f643 with SMTP id d2e1a72fcca58-891b4fd6de1mr4873519b3a.37.1791471557386;
        Thu, 08 Oct 2026 07:59:17 -0700 (PDT)
Received: from [127.0.0.1] ([58.186.69.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-895ecb535dfsm11487b3a.22.2026.10.08.07.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:59:16 -0700 (PDT)
Message-ID: <6ac7afc4.cf15ae49.1a8a2a.2a55@mx.google.com>
Date: Thu, 08 Oct 2026 07:59:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Bui Viet Dung <dungvn2345@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Willem de Bruijn <willemb@google.com>, lollipopkit <a@lolli.tech>, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] io_uring/cmd_net: prevent infinite retry loop on unextractable timestamp skb
In-Reply-To: <20b406ac-94ec-4b0f-a307-08082092ae08@gmail.com>
References: <20b406ac-94ec-4b0f-a307-08082092ae08@gmail.com>

T24gVGh1LCBPY3QgOCwgMjAyNiBhdCAzOjQzIFBNIFBhdmVsIEJlZ3Vua292IDxhc21sLnNpbGVu
Y2VAZ21haWwuY29tPiB3cm90ZToKPiBTb3VuZHMgZmluZSBzaW5jZSB0aGVyZSBhcmUgb25seSB0
aW1lc3RhbXAgc2ticyBpbiB0aGlzIGxpc3QsIGRvCj4geW91IGhhdmUgYSB0ZXN0IGNhc2U/CgpI
aSBQYXZlbCwKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KClRoZSBpc3N1ZSB3YXMgc3BvdHRlZCBk
dXJpbmcgY29kZSBpbnNwZWN0aW9uIG9mIHRoZSBlcnJvciBoYW5kbGluZyBwYXRoCmluIGlvX3Vy
aW5nX2NtZF90aW1lc3RhbXAoKTogc3BlY2lmaWNhbGx5IHdoZW4gc2tiX2dldF90eF90aW1lc3Rh
bXAoKSByZXR1cm5zCmEgbmVnYXRpdmUgZXJyb3IgKGUuZy4gLUVOT0VOVCBkdWUgdG8gbWlzc2lu
ZyBQSEMgYmluZGluZ3Mgd2l0aApTT0ZfVElNRVNUQU1QSU5HX0JJTkRfUEhDIG9yIHVuYXZhaWxh
YmxlIHRpbWVzdGFtcCBkYXRhKS4gU2luY2UgdGhlCm11bHRpc2hvdCBhcG9sbCByZW1haW5zIGFy
bWVkIG9uIEVQT0xMRVJSIGFuZCB0aGUgdW5oYW5kbGVkIHNrYiBpcyBzcGxpY2VkCmJhY2sgb250
byB0aGUgaGVhZCBvZiBza19lcnJvcl9xdWV1ZSwgaXQgaW1tZWRpYXRlbHkgcmUtdHJpZ2dlcnMg
dGhlIGNvbW1hbmQKaW4gYSB0aWdodCBidXN5LWxvb3AuCgpCZWxvdyBpcyBhIHN0YW5kYWxvbmUg
dGVzdCBwcm9ncmFtIGRlbW9uc3RyYXRpbmcgdGhlIFRYX1RJTUVTVEFNUCBjb21tYW5kCnNldHVw
IGFuZCBleGVjdXRpb24gd2l0aCBDUUUzMjoKCi0tLSB0ZXN0X3RzX2NtZC5jIC0tLQojZGVmaW5l
IF9HTlVfU09VUkNFCiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNs
dWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3lzL3NvY2tldC5o
PgojaW5jbHVkZSA8bmV0aW5ldC9pbi5oPgojaW5jbHVkZSA8YXJwYS9pbmV0Lmg+CiNpbmNsdWRl
IDxsaW51eC9uZXRfdHN0YW1wLmg+CiNpbmNsdWRlIDxsaW51eC9pb191cmluZy5oPgojaW5jbHVk
ZSA8c3lzL3N5c2NhbGwuaD4KI2luY2x1ZGUgPHN5cy9tbWFuLmg+CgojZGVmaW5lIElPUklOR19P
UF9VUklOR19DTUQgNDYKI2RlZmluZSBTT0NLRVRfVVJJTkdfT1BfVFhfVElNRVNUQU1QIDQKI2Rl
ZmluZSBJT1JJTkdfU0VUVVBfQ1FFMzIgKDFVIDw8IDExKQojZGVmaW5lIFNPRl9USU1FU1RBTVBJ
TkdfT1BUX1RTT05MWSAoMSA8PCAxMSkKCmludCBtYWluKHZvaWQpCnsKCWludCBzLCByX3NvY2ss
IHJpbmdfZmQsIHZhbDsKCXN0cnVjdCBzb2NrYWRkcl9pbiByX3NpbjsKCXNvY2tsZW5fdCByX2xl
biA9IHNpemVvZihyX3Npbik7CglzdHJ1Y3QgaW9fdXJpbmdfcGFyYW1zIHA7Cgl2b2lkICpzcV9w
dHIsICpjcV9wdHI7CglzdHJ1Y3QgaW9fdXJpbmdfc3FlICpzcWVzOwoJc3RydWN0IGlvX3VyaW5n
X2NxZSAqY3FlczsKCXVuc2lnbmVkICpzcV90YWlsLCAqc3FfYXJyYXksICpjcV9oZWFkLCAqY3Ff
dGFpbDsKCWNoYXIgZHVtbXkgPSAnQSc7CgoJLyogUmVjZWl2ZXIgc29ja2V0ICovCglyX3NvY2sg
PSBzb2NrZXQoQUZfSU5FVCwgU09DS19ER1JBTSwgMCk7CgltZW1zZXQoJnJfc2luLCAwLCBzaXpl
b2Yocl9zaW4pKTsKCXJfc2luLnNpbl9mYW1pbHkgPSBBRl9JTkVUOwoJcl9zaW4uc2luX2FkZHIu
c19hZGRyID0gaHRvbmwoSU5BRERSX0xPT1BCQUNLKTsKCWJpbmQocl9zb2NrLCAoc3RydWN0IHNv
Y2thZGRyICopJnJfc2luLCBzaXplb2Yocl9zaW4pKTsKCWdldHNvY2tuYW1lKHJfc29jaywgKHN0
cnVjdCBzb2NrYWRkciAqKSZyX3NpbiwgJnJfbGVuKTsKCgkvKiBTZW5kZXIgc29ja2V0IHdpdGgg
VFggc29mdHdhcmUgdGltZXN0YW1wICovCglzID0gc29ja2V0KEFGX0lORVQsIFNPQ0tfREdSQU0s
IDApOwoJdmFsID0gU09GX1RJTUVTVEFNUElOR19TT0ZUV0FSRSB8IFNPRl9USU1FU1RBTVBJTkdf
VFhfU09GVFdBUkUgfAoJICAgICAgU09GX1RJTUVTVEFNUElOR19PUFRfSUQgfCBTT0ZfVElNRVNU
QU1QSU5HX09QVF9UU09OTFk7CglzZXRzb2Nrb3B0KHMsIFNPTF9TT0NLRVQsIFNPX1RJTUVTVEFN
UElORywgJnZhbCwgc2l6ZW9mKHZhbCkpOwoKCS8qIFNlbmQgcGFja2V0IHRvIHF1ZXVlIHRpbWVz
dGFtcCBza2IgaW50byBza19lcnJvcl9xdWV1ZSAqLwoJc2VuZHRvKHMsICZkdW1teSwgc2l6ZW9m
KGR1bW15KSwgMCwgKHN0cnVjdCBzb2NrYWRkciAqKSZyX3Npbiwgc2l6ZW9mKHJfc2luKSk7Cgl1
c2xlZXAoMTAwMDApOwoKCS8qIEluaXRpYWxpemUgaW9fdXJpbmcgd2l0aCBDUUUzMiAqLwoJbWVt
c2V0KCZwLCAwLCBzaXplb2YocCkpOwoJcC5mbGFncyA9IElPUklOR19TRVRVUF9DUUUzMjsKCXJp
bmdfZmQgPSBzeXNjYWxsKF9fTlJfaW9fdXJpbmdfc2V0dXAsIDQsICZwKTsKCWlmIChyaW5nX2Zk
IDwgMCkKCQlyZXR1cm4gMTsKCglzcV9wdHIgPSBtbWFwKE5VTEwsIHAuc3Ffb2ZmLmFycmF5ICsg
cC5zcV9lbnRyaWVzICogc2l6ZW9mKHVuc2lnbmVkKSwKCQkgICAgICBQUk9UX1JFQUQgfCBQUk9U
X1dSSVRFLCBNQVBfU0hBUkVEIHwgTUFQX1BPUFVMQVRFLAoJCSAgICAgIHJpbmdfZmQsIElPUklO
R19PRkZfU1FfUklORyk7CglzcWVzID0gbW1hcChOVUxMLCBwLnNxX2VudHJpZXMgKiBzaXplb2Yo
c3RydWN0IGlvX3VyaW5nX3NxZSksCgkJICAgIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsIE1BUF9T
SEFSRUQgfCBNQVBfUE9QVUxBVEUsCgkJICAgIHJpbmdfZmQsIElPUklOR19PRkZfU1FFUyk7Cglj
cV9wdHIgPSBtbWFwKE5VTEwsIHAuY3Ffb2ZmLmNxZXMgKyBwLmNxX2VudHJpZXMgKiAyICogc2l6
ZW9mKHN0cnVjdCBpb191cmluZ19jcWUpLAoJCSAgICAgIFBST1RfUkVBRCB8IFBST1RfV1JJVEUs
IE1BUF9TSEFSRUQgfCBNQVBfUE9QVUxBVEUsCgkJICAgICAgcmluZ19mZCwgSU9SSU5HX09GRl9D
UV9SSU5HKTsKCglzcV90YWlsID0gKHVuc2lnbmVkICopKHNxX3B0ciArIHAuc3Ffb2ZmLnRhaWwp
OwoJc3FfYXJyYXkgPSAodW5zaWduZWQgKikoc3FfcHRyICsgcC5zcV9vZmYuYXJyYXkpOwoJY3Ff
aGVhZCA9ICh1bnNpZ25lZCAqKShjcV9wdHIgKyBwLmNxX29mZi5oZWFkKTsKCWNxX3RhaWwgPSAo
dW5zaWduZWQgKikoY3FfcHRyICsgcC5jcV9vZmYudGFpbCk7CgoJbWVtc2V0KCZzcWVzWzBdLCAw
LCBzaXplb2Yoc3RydWN0IGlvX3VyaW5nX3NxZSkpOwoJc3Flc1swXS5vcGNvZGUgPSBJT1JJTkdf
T1BfVVJJTkdfQ01EOwoJc3Flc1swXS5mZCA9IHM7CglzcWVzWzBdLmNtZF9vcCA9IFNPQ0tFVF9V
UklOR19PUF9UWF9USU1FU1RBTVA7CgoJc3FfYXJyYXlbMF0gPSAwOwoJKnNxX3RhaWwgPSAxOwoK
CS8qIFN1Ym1pdCBjb21tYW5kIGFuZCB3YWl0IGZvciBDUUUgKi8KCXN5c2NhbGwoX19OUl9pb191
cmluZ19lbnRlciwgcmluZ19mZCwgMSwgMSwgMSwgTlVMTCwgMCk7CgoJY2xvc2UocmluZ19mZCk7
CgljbG9zZShzKTsKCWNsb3NlKHJfc29jayk7CglyZXR1cm4gMDsKfQotLS0KCklmIGRlc2lyZWQs
IEkgY2FuIGZvcm1hdCB0aGlzIGludG8gYSB0ZXN0IGNhc2UgZm9yIGxpYnVyaW5nIHVuZGVyCnRl
c3QvdGltZXN0YW1wLmMuCgpUaGFua3MsCkJ1aSBWaWV0IER1bmcK
