Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437053;
	b=TgCGmxu++X7pdlwltB/DiU9RLf+p4UA4d8uQOLhSiKZkWgIvC0NOSQGZsQfLzfvEIRpF
	 5eN9bM6nExXRzeO9QMdUWJYtpoHAj0AXm5txnLulDORoaxtsDtoconIMSUt1g6qW599Rz
	 XHroB29SEjzcUDiR4uiMXHnCJoTf5RSirlBLgrhz0ASELdlU94mKdiHmL6dwcKdLCaEiP
	 HH+yQcHakgmXH8camUFVAxfKkFtNxH+tK8DFhaEi5ZIJ9EhBUlL+8vXPeCb3HUIbTvg5p
	 ZTroDRUOEmQtHQNff+Nk+5zxTBpStTauu35eCCgbc9W1F4J5/lCW+QDF7sNCrKOIJWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=sJxESkmKTsLQ7pnSvDLN4hJFLb0j+Zil8xbu1xibV5w=;
	b=AVji8LhNmv30r09Iqh63VDO++1k0SSU2c2MHIwHNV65aFVrKAewOxnKzMSfgf5ii9N6O
	 2yoYpjd09CDbxApsod9AV4/XLd8OUqe0YmXSG3bT89Ps10uzn6aPg6Snhm+6tWdhavgbx
	 WM4twNaRQIwZzPoFPuRK3mlC4gNXKqAeT5h7rDbJi2LYtRIvfxU2u52sTVzAVFXALXbfW
	 /U8PQUCJU+Yb1o7GSWPM6qLqVLCbvS4xJFhzP46MJHxvp9O6avN6sLF7GTYkIOfVsXiSo
	 PjhGFF8GVBh3zFvzNDHM8JC6O9N8o3cSh7IHxs05BPJWofiCV8cBMpUhwAgNCbEIyEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=ldeLHpfJ;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A49C606A31D
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 19:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A49C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=ldeLHpfJ
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so18771145e9.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792437052; x=1793041852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJxESkmKTsLQ7pnSvDLN4hJFLb0j+Zil8xbu1xibV5w=;
        b=ldeLHpfJGodTfp+uG8f1t9UORb8i3CxKdHT6ZyCntkGt8eFRPj3qFA0D0Pz1t6xmnO
         Y/Soakl2WPqrReiZjdyGMMg1QCMqolx5JCGujXUf3jZ9CKCxDgrkXmssOhytnsg/bRGn
         CAONf0OoT03gMuGW7eaxVhHm4LEysswugQBfHPCaOke/74njLOjlGt3P6tzdqIGpaHTy
         XTrLjbE1nOH8lBhaiV1qA1jJ/sg90BYby0fAm0szKjyUhUQjgr9SieXt8tfZ09LCxOAu
         yNPWJGXVALRhk/zDDNFrXiocId2pWthkbFV4+9WLcB3qFnSFB7rebw+fLUUnwgSf5DtI
         o5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437052; x=1793041852;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sJxESkmKTsLQ7pnSvDLN4hJFLb0j+Zil8xbu1xibV5w=;
        b=pFConh0dUiLHvlnG8QZc/RpgliEWKplgEp9MRSxYUysyz18ZPU0to6zYzj49R3Zk0y
         /jcqmoVku8iIVJH1GqcO8Neu2wagDeTexmiFO+Xy7e7ns5MkiS9RRkvvw/DcVoYQ6+S0
         ScGsNe4IrbUG7NMkbl1XOs+8aCrAu4X6sxYgT/Z/1Vgo9v0eYGTMH4yuiMJw9398bA7j
         6F+W71leGp0v4i0+hq4oTwbVrV51qg9qvLayY5OUqalSOMCa2VHyPqe+/dVa40PpOwd3
         JwFKWgS+Okq1d5751k+gUZm91iUmlabvqEU52TeajhCacDyxTSD7lDIkIodrdHRRdrnW
         G2Iw==
X-Forwarded-Encrypted: i=1; AKwUvBzV1BudbD7E4lBsA+RYbbpnIdNzg4ny77IeA/OOl7sSYAnuPMtqAnzhg7swb7SrUUK4VGCPalQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuaBn+aFhgcEzJvz+mcEXD3Q3sxhTIgM+aNkHCwiEnzhrtpDPB
	F+uJu3FM6Gm+6Te9uNTPK1Y03A/BIH8wbWNNJsk5OYTbcORzNMOeNJM=
X-Gm-Gg: AYBFou0ZRofXLSdnEgEwT14/MP1N0XZxwF54f9ufTJbp1W3CWsSbmmT0ctScVGTEYpp
	/H+q89dOZ3MusJEWeoTt28SNjUsTKUoTLSgy9Lem8BL6uYHP3oeGlCSqbDWCTinTGcSJIncc4ow
	BQ7gsrFGURpcMwTA7DvNo+VbW1EO+YukjmahoLOtj323BoAdYeTv7Yj1xvD/+g7f481GwRdYaJL
	/fgNt86qcXWsdrlOjIli4Ft/PmRjupI7IBXY7SdvkTAsIeedbZOqDqKaUYqBVmdl0cf+j4LKSF2
	n8X1iKajOuNGZVIz9p3QmANAOXuTJMr5zhZUtEALM02c2ZrNto5gK/FCH/WfTPtzuOAWwEy4pzD
	4WMzsIKspcOSmtqRPraczg9avK59wzGm7bNzsK5CEUMmQKlVxxtlXbtLQ+QFagQtU4/cnqQVtR/
	olqqrAvhe83Bwm7tjyVUZNlL7i2EmqpO0XwL9Z2DWpgM3LTGClAPjggB2KYsAu2bmaSNn7N1rb3
	RwtRzPGTby/c23PPmGRmV0+7vd8y4REWKDCSV8F5h9vvgVhIg==
X-Received: by 2002:a05:600c:8709:b0:4a1:ac85:9696 with SMTP id 5b1f17b1804b1-4a1d75f926cmr159050985e9.17.1792437051530;
        Mon, 19 Oct 2026 12:10:51 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac02b.dip0.t-ipconnect.de. [91.42.192.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ce2b8bsm13688775e9.15.2026.10.19.12.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 12:10:51 -0700 (PDT)
Message-ID: <892078c7-7fa1-4e32-a00f-1ac907c0ebcc@googlemail.com>
Date: Mon, 19 Oct 2026 21:10:50 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 0000/1674] 6.6.160-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261017160431.119607952@linuxfoundation.org>
 <827e9f8d-5654-4964-a999-5ce94bd98fd4@googlemail.com>
 <7201018c-20e8-4187-832a-aeb0e5db98ca@googlemail.com>
 <rc-reply-0001-6f27dc9abcab@kernel.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <rc-reply-0001-6f27dc9abcab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.10.2026 um 18:54 schrieb Sasha Levin:
> On Mon, Oct 19, 2026 at 06:02:37AM +0200, Peter Schneider wrote:
>> # first bad commit: [7c1e132b0967210526de05e7af6f1c26ad0c1516] sysfs: Introduce a mechanism to hide static attribute_groups
> 
> Thanks for bisecting this.
> 
>> I think the problem is, that if you take this patch for stable, you need to also take the patch which is upstream [
>> cd69fedf58f8ab1ab511f7c6ac1969cebf1c935f] sysfs: Fix crash on empty group attributes array. It addresses the exact crash
>> that I've run into.
> 
> Rather than adding cd69fedf58f8, I dropped d87c295f599c ("sysfs: Introduce a
> mechanism to hide static attribute_groups") and its dependent c7fbb8218b4a
> ("sysfs: check visibility before changing group attribute ownership") from the
> 6.6 and 6.1 queues.
> 

Yeah, that seems to be the cleaner approach. I just tested this, and this works fine, too.

Will there be an -rc2?

Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
