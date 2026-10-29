Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297227;
	b=rGBU5PW+uNZKrFsAqjMCr0JCBmXNoK4HiX6iWVomxyh2BRmQCo3xZ6NrylX7hfSFCRNR
	 6f2kDXRoyczsBlNH7WaEjXPe8eT2AQrIxHPUjtSy5FPLFAikIWVYKZ7JDG+7Sky9ILcwS
	 wglvX+1NoP6nEqOdfQlWUtYCuSJk8S2BI0jHf1oiZLWyAgm1bZ66aUKp/xZwIlca5OrXe
	 YiemlF8+MJcCKkUTYC+uNB4iZW3SrJLuNFqswiBieTIRz/867cLTNMLiCYa/4WgRfVs+n
	 emQkRgdq4VOEf+feBmsSq/PQiJ4GNQHC/6K/1S303rI1uDrc3iqah8M6WujrIz4MCrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Content-Type:MIME-Version:Content-Transfer-Encoding:From:
	 To:Cc:Subject:In-Reply-To:References:Date;
	bh=mdl2q7bYgyRiGGu1Nd8Y8m4pgXUNb+bUSGq/DaAvAic=;
	b=D6nnnIsmpvJ6xJAjBJiIzHHyYBIAM0SfaCcusUZUxuG46yKAgCuHoUldWHEMeBlMBkrb
	 7zXPPceeoNGjve15fFcqFNAW74P5/BPS5kqnvmWZ7ZT2YPQHEZ9SSxoLnsbnDhu8RlTbl
	 daxvRl/8ICcIiDkNceShOhg8xmwdwll4nIQP/EnQND1tdVKcS8fpmQZ7c7og+BWuEbN59
	 M4pVyH6ss6t5ySeWl/hcaQMfL5nuXuUDLRJh2cBos6CcTRJZvtFprDbLGfmy4LAXmAk6S
	 8oHd2P/ko8aC2/Xjcfa3aE0qxrNc7D5cHuC/zkWRrTm3Kh0VLPo9rnQOepiFVIYz3sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=goV3UiRS;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97352606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97352606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=goV3UiRS
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e10a70540so1613809f8f.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793297226; x=1793902026; darn=vger.kernel.org;
        h=date:references:in-reply-to:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:message-id:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mdl2q7bYgyRiGGu1Nd8Y8m4pgXUNb+bUSGq/DaAvAic=;
        b=goV3UiRS4/JqtjAof3nv5tvVThur+kPBovzAtGEKMeGx1UEQSTtN0qN2OFEUBwLjyN
         HWRXveU5R5DCDMVyK7w41sS1cnoVY5eG6ICY6dEGpeDNEgYaqsjNqBPk+deaWF3sP+BP
         ZIfjLXk+UCsSGxdEREF6LfVh96e2uOCYXYQNzBpZOLX8XfNdE2XnmrrT0g/tnm5SKxum
         Xmc5gDP0byL2hDY4INLLwNBTTyCVuYka3io7mCGu4xSVj/LHAsVCN6TR+w0UD16GqNfu
         JWbmEYmGh8fkvFH/OJlKDZs/lmPwZ4nJwcSyu1mfH57vb7hB8AspF9Dv0z/C8wLvRR06
         LQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297226; x=1793902026;
        h=date:references:in-reply-to:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mdl2q7bYgyRiGGu1Nd8Y8m4pgXUNb+bUSGq/DaAvAic=;
        b=bhvuM22/tcjFRXZVsJsikrh9RPzPal7TyOSTY1p2TLV3/HQBItPon8cBWXCZ5ENv/m
         OmV3ZPFYNwIguflY6y1jOmNn2cVP8UFEltG+wioEmrIPkTx4n84Qaul7jPU6gfBiQlZ8
         kjyBBwqasZwNmh89lTKwEVVoplt5qHIctK1ZO6zVHFyDI1KNbKBw5m3AjMebIJoKuBCI
         15n3iggn9r4ZvXGqePyxBLzteQTTdtpi0jfQdvLoKfJQ++oiFV89ECtPQCKUfAptYZHw
         Zsj9gPvG6AQn51jnxDqj9qzI5K/xkEh0F2Xk0mX8mkx0B8tgzgZ5IpoFuzbb/qahPaHz
         1FJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxm++8icgu0SuBfBcBlmlmy0PZ8S9RqrKhd/yFwf+Y46PVaZD1QNgvi7W25rcwICvu/P8sSKTU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVaq0Z843w5M7QKK2kpb1fZwE3em8IszOaCviNg0y8/D0NYBTE
	ErkMWrjAKr1VVOvui6WwDYlGrixS1TFWcvwPE/smHK7vBog6GoS+5lU=
X-Gm-Gg: AYBFou07P+ZHdMJrN9FIckswQbjjuv+3Akuazxpqjqmy9RdOlE6fScljH4Rhg6yDKWx
	IFQZpHMrPJvuxX1AV6022Q2xk1LB/hSqV0qLhHaGQd2mvI2JJ2ISFFuynNHVzKDJOBmPqT48MMj
	BcE7TQlcy0ARppLMg/S46+D9ItQo8nxKBGExkw5RxL66POnD+EeCtBNw2YaGmT7pXyfqYio/P9z
	AeFYuncLV11HhhQK1EiMaUhaiwrtYubN3ICLc7noQA8sRWY/SsWyNha3GzU6oLZQUHc93nOm/+k
	TYtyKn/sU1jNeJHt0LxHwUTojmhUsYaQ+wvm2x4NLrEM68DdO2O4IRGbZJR/uJUjnMGH33Uu0gJ
	xm8KEWJC7ut/MKyQiDqppfz5OxWU4iABY2MBFCGSRI6L7yLAyRZ279k0Frj1Mz1EVm9XcRrLQGt
	wDWn46PIeYEjucKrQhsgpOrI9QFO9lTt/WGptG53T7JnbppjWO6Gx9sIZivmHoyH+wKUjIBzYaY
	46RvceEUMZdodB+QdBZ09aJ/pbOQhtCC4nUtcwCn85ER8XNtIrQviHBA8RkLi8tW6MbuDVQuCLf
	oA==
X-Received: by 2002:a05:6000:26c8:b0:48b:677:f80d with SMTP id ffacd0b85a97d-48e6e2ff7demr405585f8f.26.1793297225850;
        Thu, 29 Oct 2026 11:07:05 -0700 (PDT)
Received: from [127.0.1.1] ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb8bc12sm9433f8f.34.2026.10.29.11.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:07:04 -0700 (PDT)
Message-ID: <6ae38b48.a6a2e554.2bec60.2370@mx.google.com>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Tristan Madani <tristmd@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: David Heidelberg <david@ixit.cz>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 John W. Linville <linville@tuxdriver.com>,
 Samuel Ortiz <sameo@linux.intel.com>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v2 net] nfc: llcp: use disable_work_sync and
 timer_shutdown_sync in local_cleanup
In-Reply-To: <179329133392.3327.1911358623600296609@kernel.org>
References: <179329133392.3327.1911358623600296609@kernel.org>
Date: Thu, 29 Oct 2026 18:07:03 +0000

VGhlIGlzc3VlIHdhcyBmb3VuZCBieSBtYW51YWwgY29kZSBpbnNwZWN0aW9uIG9mIHRoZSBORkMg
TExDUCB0ZWFyZG93bgpwYXRoIGluIGxvY2FsX2NsZWFudXAoKS4gY2FuY2VsX3dvcmtfc3luYygp
IGRvZXMgbm90IHByZXZlbnQgdGhlIHdvcmsKZnJvbSBiZWluZyByZS1xdWV1ZWQsIGFuZCB0aW1l
cl9kZWxldGVfc3luYygpIGRvZXMgbm90IHByZXZlbnQgdGhlIHRpbWVyCmZyb20gYmVpbmcgcmUt
YXJtZWQgLS0gYm90aCBjYW4gcmFjZSB3aXRoIGFuIGluY29taW5nIExMQ1AgZnJhbWUgdGhhdApz
Y2hlZHVsZXMgdGhlbSBhZ2FpbiBhZnRlciBjYW5jZWxsYXRpb24uCgpUaGUgaXNzdWUgaXMgdGhl
b3JldGljYWwgKGZvdW5kIGJ5IGNvZGUgcmV2aWV3LCBub3QgdHJpZ2dlcmVkKSwgYnV0IHRoZQpy
YWNlIHdpbmRvdyBpcyByZWFsOiBhbnkgTExDUCBmcmFtZSBhcnJpdmluZyBiZXR3ZWVuIHRoZSBj
YW5jZWwvZGVsZXRlCmNhbGxzIGFuZCBrZnJlZShsb2NhbCkgY2FuIHJlLXF1ZXVlIHRoZSB3b3Jr
IG9yIHJlLWFybSB0aGUgdGltZXIsCmxlYWRpbmcgdG8gdGhlIGNhbGxiYWNrIHJ1bm5pbmcgYWZ0
ZXIgdGhlIGxvY2FsIHN0cnVjdHVyZSBpcyBmcmVlZC4K
