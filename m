Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616805;
	b=3nQ4FyO04AqRpYaTG0KPo2Kz9UwRsMj14nUCu2a1YB+APhVnX5ZGSHthbU7D/H/Lk27S
	 zu89Wbi0P4ODi2Az9NWrUR5K4iFHj59Mu5IoQUwf6fl9v61fz9fnIVt7eEGS7uJ0N0/kr
	 XcRYdvMuL0bIgaULFMAdxJw1+YzUdmcik0G5tZFC/rFBs3AuUCiRDM3NyEJ+BNT09IIRj
	 txDIABOpHkOlk8MX/r2svQmAShrf7JZOTd351gogzrFA4PA+mR362uc7+Y4O2JErfziQ3
	 tiLYwgoLPSyyUvkwqcI50Owfn7zc0LK60oqASQ4fpEagokhi8nmohBBcNumymycf1cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=rciz4+NfV/n7GNfIPMbnR7FGjDwc67n4vXgzhcNqgXQ=;
	b=yR4tGgwVswYCGWf/cJFzDsXNOPh39+MH0UXhut0/qmVVmu3BTUZdL3C6WhW5N7YACFz4
	 eAFFFDeUEX3qmMYBy8ODG0yNn70jW/H0mmlkXZdF/xF0Tvba349gm9B11CqN7hDtuPwP0
	 JhvWq8EKHqTyVSUNxjjNFFfLP98E/fkYfj6dWMALFrAyhQaz/HPpBgAlZIIINPdNHF5R7
	 +2PV7ETH55W0QiatzCEMok7chtHmN1nKzXinYKDgW0IzJqBWOG5qSs9oFF99L6DmyR2MA
	 J2h6XTb3C2a3cg7RNFP45+Z49aGwm8ZDN7i09ZC3KrRg3B98xWrirJ9P3p6X7EQMRgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b="ZqkG/jvY";
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A50606A32E
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4A50606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ZqkG/jvY
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-89f85edd210so1002788b3a.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 02:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793616804; x=1794221604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rciz4+NfV/n7GNfIPMbnR7FGjDwc67n4vXgzhcNqgXQ=;
        b=ZqkG/jvYw4DlBUH+7ZDQOLUwPb8HDLvyrVsSNpqO513hIK35/s4g1SiiXeCT/Eo6N6
         5bTlT48RVI8P2a69YJHt9bk++jbBabuvYsG5XxaCl3V1UXoEm3wH1gRms1hPYZG75UpM
         tqZ7+fEXiPBwbj3XUl2Y2eKq5SFCCOsbNN+6TT53mA5Nk20bSNEAUygORUyILR+KAFxy
         tAUv63uOzUwNerT3dy8wrHx42SiWckF2L5B2yn6OUWKpQDo0+iymYqIYo4YAlxrhebO3
         2YmDCgQbOa7JAmQnAxNINLvdkK3C6rVGEOrTds9YBjYPbmXiTL3IUUyVvrwyxGgswDb1
         95qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793616804; x=1794221604;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rciz4+NfV/n7GNfIPMbnR7FGjDwc67n4vXgzhcNqgXQ=;
        b=L++mGpPndefpK/ERKchvmVhPV4R3EzMJ2etLSvBR4TfmZ8GVmPGEEELAnRfXA3tzli
         ygXpuuPeRtLipNftwgs65XOmO2bHDZwZj2Wyu01w600T0RPgEnSiD4D9AIl707Hxe0bV
         fV3QZUjeoDTJhCSjqayBIqU9hfa+igSWF+UVVS+IJcnWFy5VpCpKufAw352ueZ/og5Up
         HxCMNJfwSTJkLEc/n0OXE2JBF65cXAKi7OSY3g+kNozQwjcK3HWUWXpde6YMDtaFoj/i
         5GBzFHwiXPtuwexg0+KumXihnN3nGOp6s7tPPhXpWzqsi2G8u26E1mFZXguGv7Usl+wo
         /Okw==
X-Forwarded-Encrypted: i=1; AKwUvBwFYfgNdV6DgwTbpUXh/yzYEoguTH7nv4CTejuDgWWhKwCk8MLd4/d+RPno1Y/xcMbAsqTdUyA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIV7Xn+m6Ch0TKVHeLkr2sfShGn0FNe66KBe8mAUlcn3IBEjDLA
	ZFSZ8AGhynldjvZonklSB/rI/u8y8VahEMFbv00kooo7VKg87sCv3VfVYjIsfeYPXymlnDfDH0I
	eA9y1Fd0=
X-Gm-Gg: AYBFou3SvEOyN2R5hx73C3H2ScdAH76WwsDT7WZViWk2SX22dKhGdj0ZvbE2PWEi+lu
	jYVlAvUuYUhzWc0uFsdBMxlZ0dORDybOCYMEDhGjOMXX9x6yQARfsWrd+rNpdGeTYcz+/4J4dGI
	M83hlfbD03Y/0Uq2uI7y2M4OJL556334KvLTlVqF2hG3Cwqo4T71JUkwIKiihm9+utXssCXdoqi
	hdgd9MPIx2Wyv6n6fkzmIfsYirIsnMTixbGg0rbuaVK2F1NUDpzdKea5zErEiAtbe7fIdJ6e4Cy
	314nS2DegKyEVs60vSty4Gsg/FUyDz7RpPtrSYQWL5J4Uki7W4cPc/xQ3R93olgaSVjFS5oBNAE
	EnItQdri4c/FgrUhdMOwJbDDGmVlikm6ItkcSgN/vuxRoVa22pnDSiuSWe/3/yiCUMa5a0xqpA0
	0OgdEmPc/8N8R67sIPtMH3Qv3vBFckgf6FEikEr7nLe8AA3tPLgMYcDgyv4labLvolG8mcMK+dg
	Gd4dKSTed8pxoYrWRyAS2diUDKIErMPFfTxpqF8kOjC5rDqvJ8MxAB1ncOLKp+OLAnDff64iLi+
	EsvKWYbeYY2t8xl9KUqeFAaENHZRasnmpSed2bHVtZlHBBr49oAVSd7Du+zdDC6rQ6aCLMRn
X-Received: by 2002:a05:6a20:430a:b0:3e1:78c5:dfde with SMTP id adf61e73a8af0-3e92903d6a4mr8950975637.87.1793616804031;
        Mon, 02 Nov 2026 02:53:24 -0800 (PST)
Received: from [100.81.10.186] ([61.213.176.58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb0981bbc8sm2864285a12.26.2026.11.02.02.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 02:53:23 -0800 (PST)
Message-ID: <5283a93e-8373-4e2a-af31-88e50522260e@bytedance.com>
Date: Mon, 2 Nov 2026 18:53:18 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] ext4: put folio on partial writeback validation
 failure
To: guolingxing <guolingxing@tju.edu.cn>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 libaokun@linux.alibaba.com, jack@suse.cz, ojaswin@linux.ibm.com,
 ritesh.list@gmail.com, riteshh@linux.ibm.com, yi.zhang@huawei.com,
 stable@vger.kernel.org
References: <20261023061851.45579-5-sunjunchao@bytedance.com>
 <20261102083649.3798099-1-guolingxing@tju.edu.cn>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <20261102083649.3798099-1-guolingxing@tju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 4:36 PM, guolingxing wrote:
> Hi,
> 
> Thanks for agreeing to drop patch 5/6.
> 
> I also noticed that patch 4/6 duplicates an earlier patch I posted on
> October 16:
> 
> https://lore.kernel.org/linux-ext4/20261016142524.655789-1-guolingxing@tju.edu.cn/
> 
> The earlier patch has already received a Reviewed-by from Zhang Yi:
> 
> https://lore.kernel.org/linux-ext4/743d1d96-40f9-4dac-839f-5d5269364b50@gmail.com/
> 
> Could patch 4/6 also be dropped from the next version of the series?
> 
> Thanks,
> Guolingxing

Sure.

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>
