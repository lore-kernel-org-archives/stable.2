Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C86C3FBB68
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534469; cv=none; b=SYuwH8u+5z1VL3knu6uvR4HCpyBurdaWayOc3r+3XYbhnz53wO4TdTW8O87jusgxw5wJZ1am5ifIX+Yazl5cBRd6IS5YhD67P86WmcXUgQ7JrHVgyN6UQGYXDRcnUB71G0YTO7ItjyRXFZyZChwz6T1lCe2Pn8Y4dVdnPoKMox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534469; c=relaxed/simple;
	bh=1Jyoof7cwevPQTCq+8zMLfhrFarwh9H3IBMF9KywRks=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=gPPPoNwuRkQ7Uvc9y6k3JyvhUj+lZPkOVQqBjvN3wZki792K0TGgRq2Cs9FBOV6p1Mf2SmO1t2Aop+unMN6iXgSluAV4D+TrTAwGhEk1N7iMmz3+HloSeq6miyFwamb5wdJrZPz+OL0b3I0yazxG1LzdEYPq4GdjwgM8tfm12XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=U9yLBN97; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="U9yLBN97"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-486621f0adbso2393169b6e.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781534463; x=1782139263; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M34PM7J5/QisKAribADDUGDGsFm9QHPoAac8qcXdI8=;
        b=U9yLBN979vZ3QvgN+LwfrSRgzZ3C6NXStTvk7JwoC36ijfucD8ZkCoGkzzN83oB2PZ
         u94ZdNuL6ifIxIXz7k7NC9OcIqgxjaLO8ISH6dlzSy3dCvKjggA/dXnZ2fnNYuR3lCnR
         SLh4FYxD/pf7HKJZWoPitomxNzOSWjlbs9naGIHuRJK5oU76p3EKN/PaZBuFBfOelQcD
         wb0VIocyRJ/XcZh4CF3wJPwEQtTuhqZ3Mqb66B35rclA3+CPVSnBs+6C++kOJYnm1fs1
         YaQKwwONczizPCjb4O9B7/p8CMmeuDzOXVVWfOl2b0Ip0zgvYLekSx2Gs/Pu8jL+qL86
         XODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781534463; x=1782139263;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+M34PM7J5/QisKAribADDUGDGsFm9QHPoAac8qcXdI8=;
        b=iZQUFQqjk+IkwT5PpGjxH7bc1p3FutLfoetweG5eFD1Tq2zwgPWAFCSSfseR333dsb
         KLnCx7cYHPyrcpgne7tYBYt6yCkdToCVheY4kdZ3oxEsvFHsT/g2Nk/GT7XT+euBG/Cd
         MDH11gzUCw7rCY2n+B1x7us9ongBWtjqSH8NWy3S4hMtkJuH6Wk8Fq1OSpQbEGi4NMCT
         Sgy4g2BVkYSBuvrAhi/Vdxd4zT4AJi/rA+J29oGgi+fjh0D40x9uX3zi6iLQAadgVFx/
         s8RZc4W9/wEHgkRVPHhn5a3oSGe9QrZyX2bKc2f7vfA4SkbADckyILRlfUPR5HVMEyPZ
         3ULg==
X-Gm-Message-State: AOJu0Ywf09LbLWIzSe6jpjrEG/RGL7cLoSIkN/4oAG2KDV9U4ew22UGM
	7mDNMN0l1ytz+U1k/i14tpCwfRy2JclVhA35Ww4ndOOZ3BK/3rGnrtxpsoBlR9NXjTc=
X-Gm-Gg: Acq92OGTomqpTb5stKS+ODCNBEsA1zuWeI1eR97Ps4WlYfTqSzhd3S2/4xVBN67LbaE
	WHbkwL/wZDtxIvBugOD1Dk+dUD7h+kWqueorp01Q+41iC+X/pVZ4JyL4fo/JzjgZmNpvbiIdfdd
	86HojDI0bR157JpGkSIh8CPATOa10jioBWeAXHQ9MNPMmGaABJ45003/R5RwnGDoSMkUUK7+5aT
	8n5+9DFUtipcYeDp6NjNTHx5QUFTVhRQceNFcbM1Ikti8y0wjsIB3Fcpr1LIiHcuRqhZGKfJurv
	rvx7BbgNyVYhhzQNogN1215yO9/SGvLu1wZqNQ7av/jpaLDIPTUHDneEPsK+eiNfDS+ffIG+tSs
	yYBJrN2mPmfqosqyLQTPkV1HGvsctsx/iWZPKyxP6+d1YUHrXmW4yGpcSlyYxKSkopE1vY6NmUP
	xhSBGMHX4c2jSNecgmEUABADcq7R5s5zO+S6SoVvxfDDNrbQ7+/vDve9PoZVTi/QsRterjR1IHx
	ht2TxP5W0gngGV4nCg=
X-Received: by 2002:a05:6808:508e:b0:46a:869c:b576 with SMTP id 5614622812f47-4874195f4e5mr9547496b6e.2.1781534462874;
        Mon, 15 Jun 2026 07:41:02 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dfadd66sm2829956b6e.14.2026.06.15.07.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 07:41:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------VNTuSsWUqwOw1cHl2SlOPxX5"
Message-ID: <9af1115f-6920-4531-a3a2-ed848540892b@kernel.dk>
Date: Mon, 15 Jun 2026 08:41:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/wait: fix min_timeout behavior"
 failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, lk@c--e.de, tip@tenbrinkmeijs.com
Cc: stable@vger.kernel.org
References: <2026061511-underhand-neuron-492c@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026061511-underhand-neuron-492c@gregkh>

This is a multi-part message in MIME format.
--------------VNTuSsWUqwOw1cHl2SlOPxX5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/26 8:18 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's one for 6.12-stable.

-- 
Jens Axboe

--------------VNTuSsWUqwOw1cHl2SlOPxX5
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-wait-fix-min_timeout-behavior.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-wait-fix-min_timeout-behavior.patch"
Content-Transfer-Encoding: base64

RnJvbSBlNjhiM2UwNmI0MTBhNzk0MzIyYzY1NDQ5ZTQzNTc4ODlhNWUzZTRmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiAiQ2hyaXN0aWFuIEEuIEVocmhhcmR0IiA8bGtAYy0t
ZS5kZT4KRGF0ZTogU2F0LCA2IEp1biAyMDI2IDIyOjExOjIwICswMjAwClN1YmplY3Q6IFtQ
QVRDSCAxLzJdIGlvX3VyaW5nL3dhaXQ6IGZpeCBtaW5fdGltZW91dCBiZWhhdmlvcgoKQ29t
bWl0IDI5ZmUxYmQwMWI5OTcxNGYzMTM2ZjkyMjIzMGE2NDNjMjc0MmNkYTkgdXBzdHJlYW0u
CgpUaGUgd2FrZXVwIGNvbmRpdGlvbiBpZiBhIG1pbiB0aW1lb3V0IGlzIHByZXNlbnQgYW5k
IGhhcyBleHBpcmVkIGlzIHRoYXQKYXQgbGVhc3QgX29uZV8gQ1FFIHdhcyBwb3N0ZWQuIFRo
dXMgc2V0IHRoZSBjcV90YWlsIHRhcmdldCB0bwotPmNxX21pbl90YWlsICsgMS4gV2l0aG91
dCB0aGlzIGNvbW1pdCBhIHNwdXJpb3VzIHdha2V1cCBjYW4gcmVzdWx0IGluIGEKcHJlbWF0
dXJlIHdha2V1cCBiZWNhdXNlIGlvX3Nob3VsZF93YWtlKCkgd2lsbCByZXR1cm4gdHJ1ZSBl
dmVuIGlmIF9ub18KQ1FFIHdhcyBwb3N0ZWQgYXQgYWxsLgoKQ2M6IFRpcCB0ZW4gQnJpbmsg
PHRpcEB0ZW5icmlua21laWpzLmNvbT4KRml4ZXM6IGUxNWNiMjIwMGI5MyAoImlvX3VyaW5n
OiBmaXggbWluX3dhaXQgd2FrZXVwcyBmb3IgU1FQT0xMIikKQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEEuIEVocmhhcmR0IDxsa0BjLS1l
LmRlPgpMaW5rOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjA2MDYyMDExMjAuMTQ0
MTQ0Ny0xLWxrQGMtLWUuZGUKU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2Vy
bmVsLmRrPgotLS0KIGlvX3VyaW5nL2lvX3VyaW5nLmMgfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pb191cmlu
Zy9pb191cmluZy5jIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwppbmRleCBlNTE1YWVhZmE4Nzgu
LjAzYzZhYjUwNWQ3NCAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9p
b191cmluZy9pb191cmluZy5jCkBAIC0yNDE0LDcgKzI0MTQsNyBAQCBzdGF0aWMgZW51bSBo
cnRpbWVyX3Jlc3RhcnQgaW9fY3FyaW5nX21pbl90aW1lcl93YWtldXAoc3RydWN0IGhydGlt
ZXIgKnRpbWVyKQogCX0KIAogCS8qIGFueSBnZW5lcmF0ZWQgQ1FFIHBvc3RlZCBwYXN0IHRo
aXMgdGltZSBzaG91bGQgd2FrZSB1cyB1cCAqLwotCWlvd3EtPmNxX3RhaWwgPSBpb3dxLT5j
cV9taW5fdGFpbDsKKwlpb3dxLT5jcV90YWlsID0gaW93cS0+Y3FfbWluX3RhaWwgKyAxOwog
CiAJaW93cS0+dC5mdW5jdGlvbiA9IGlvX2NxcmluZ190aW1lcl93YWtldXA7CiAJaHJ0aW1l
cl9zZXRfZXhwaXJlcyh0aW1lciwgaW93cS0+dGltZW91dCk7Ci0tIAoyLjUzLjAKCg==

--------------VNTuSsWUqwOw1cHl2SlOPxX5--
