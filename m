Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793337109;
	b=HGVCQ5104zsk/FIXYsutl6PYo3ThXUEloabJGr+TN/3tISR0/tP94AjWKuHxOH1PMrCR
	 gX525INYLuBFHhR0wXnf0V4pdRqiKuNowuwRfyexdoB2vyVbBsNj8jMjlSRll2ZPVEA0N
	 cZNm0HP7THec0VDfSCKdE2OqK9uNOFmAzHSU5jBk1x+A/bjo0OuXWJ9WAUajX10HQNPky
	 x4vOYg37bs0ikztsAD7Ko+kLe/GOpks1ydQTT+iB02XVw6UeRthVuQwz4JYQgoAEK/CdL
	 CxB7GjJvjB6JBZ7iTU9bj73pIH/Q6bn+m1YojXvjtj+aVyeV8rU+BSEwDDQrKJWteeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793337109;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=FQn8AMTtavP6P181h0fXU4D+4WY7Po1HblFZ/HaZCWU=;
	b=B2tRLQC1G7NyXkYvLWIYw4gqxocLfj/V1LoaMG74NH9CZlm6vsbMUdSJL5u2TwfhKU5U
	 ltKI5+zqq0Sl7ozmqnTP7Q/XcySE7Mx9zJFc6F5fqDm3lDHSdz+OyhEZ81SF2duTFJ+vJ
	 668h9hxN9OjktsmP9c0WxZhZzItjGh2GTVFBMlAIbKeSAtSgAiARpqxqSPhhdh8hyYDdt
	 kU8yvzvcCc/J/SFUZxdd18+ve/KIqDIVWTBZtMATIvlYi1Pxq6FloY568p/TXioowbemI
	 VNAPUHMuJLu4VPgQcx/7uPbxzX4JN7BwuAfZfZc0l35jNi/c3dYhcs8FRz8aHvIxIBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XW8WCvWg;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="bd/UzTjD";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66936606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 05:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66936606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XW8WCvWg;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bd/UzTjD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793337107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQn8AMTtavP6P181h0fXU4D+4WY7Po1HblFZ/HaZCWU=;
	b=XW8WCvWgJGCrtcAiWgfwcMqLGT72FVAcK/GzlDsd6fHEmEbd6l6zZFb3uH/wrtcJ0HheHO
	vnqnD92aikMqBn4DJIU/Ip7/zTrT/bDhA206ONZV8gdRH649FRiiA83ES31JDaHRyozVSr
	BVXxzf3sGvPaaGd4aBDRPZwRsyZbgKo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-YquGawv6O1Kvj6ci3-ehIw-1; Fri, 30 Oct 2026 01:11:45 -0400
X-MC-Unique: YquGawv6O1Kvj6ci3-ehIw-1
X-Mimecast-MFC-AGG-ID: YquGawv6O1Kvj6ci3-ehIw_1793337105
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3adad90c894so415166a91.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793337105; x=1793941905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQn8AMTtavP6P181h0fXU4D+4WY7Po1HblFZ/HaZCWU=;
        b=bd/UzTjD4ClTsAddZbCLcewvZlGvpbw68jhujs6M2SJeDJyv64KhXmDibMuR4mxFyj
         hspLJnSTBR4PqQE/Q4yoVUpdkbSsp+t1EzyhRNxhAkIG2byrhPZNlya1UFVHgvJ7hHNl
         VsyV0uyiuhvaJYMdIXttT/vMfWAYc4ynba9DeqZRe4KdSAtxO5v5BHFrrvA4tnbvSkQt
         3ytkfciUQx0VhS4jjqgZQiz5MJ1qRcfmVXU1uyYX8/aoUradrL0Qrja7EWQTSKlDZH3y
         3e9agj17/WTEU1T+DvMf32bTM+9GN9Q5CezutUqWZHosJNZeVapIFesjIaDOgMlI4R8I
         FF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793337105; x=1793941905;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FQn8AMTtavP6P181h0fXU4D+4WY7Po1HblFZ/HaZCWU=;
        b=FigvnpXzyACg1Pj8BfWqcsqdbpEdnVtTxB2FOuGknQqW+sNpB6rFvnKhIw2XF7UIRC
         X2n/3nwa3cVYQmRf4OXoFAVG0xrFgoBMQUmhuYDOmxpDqOTrs0XcpCuTNPqUc2XcSEbi
         r94Hxv4SJmTdYBPu9V6KEEYFZ0PF4mUL/ij13OKvhdt93n/heYLYmI5gZIxmvqqfB0Lu
         JNKZCysT6jt8tKgoZZXgyB2PDfFIyh82GV66egtbftHAKFadfPg/PGXhGOuABeKzQcHE
         Ye54ecgVjhqVGa2zwNgeD6MrWWLmElRCuB+FCiBQex0yvhC4QEmlWZMmshG8NKTmSsWi
         D2LA==
X-Forwarded-Encrypted: i=1; AKwUvByCiOHILlILs15nLJSVeCxM55OiTN6v/mVQFD7mEWVoncvQVCwrkl/T6m8HavBhkiJAplkoSnw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLckbz413U5cbbT5BdT2GTtT4F931O7U4IcDxYeBRK/tWx38NEg
	gR9GHDztBzBOg3vNiCVawW1kI/e/FFPPt47XDEPHL+T79wKw2y87Z5dmeLnza2k4EsHwIMfpJUX
	McbDI3Uz9GyVqTsoF7jwJ+nDYHf97ChgrAySrXCb6sZjFMzwgdn+xANj8Ag==
X-Gm-Gg: AYBFou0AWTyOyad4p2kuhMqsnWkNR1U+ysIqLf/PFASZfVeRHW2SZbLGX/C4I0zTN0e
	MyTa4UJ7baz+RfriaDROqPOpppEiSUrOsN8j+UhfaYuFV+Rhvug4mDYwJQKB1VNhY2lfOk2huNh
	gA3eCrXRn+AXyXYUUms2Qn4FEl57w2b+lSQayddz66t10XNVUlP/RCtMskGiAspES7bflGP3wOq
	lOdug7GDDtChnOMvdb5X99hzf8U4X7yl01ajYuFhxwd/MooGTA/bxGSQyWylmixJ6n/agPwUqe3
	RCLR36y3zk2yQg3UtlQA+3lxQxaqcHTxAcMsxlFKWmgkSvapytH6mtreWsPsBqqLi2u+i/qhocy
	jLHAvAP9eicr3LD/sDMjDGzGGnU8CA4LE8xCXvfM4Jn+jB3e6pVo/3Ps2SBGjcVe2Ad1BrJoI27
	gY/j17StRBKkqyYfg=
X-Received: by 2002:a17:90b:55c5:b0:3a4:ad5c:d48a with SMTP id 98e67ed59e1d1-3ae8987e75dmr994567a91.67.1793337104518;
        Thu, 29 Oct 2026 22:11:44 -0700 (PDT)
X-Received: by 2002:a17:90b:55c5:b0:3a4:ad5c:d48a with SMTP id 98e67ed59e1d1-3ae8987e75dmr994554a91.67.1793337104101;
        Thu, 29 Oct 2026 22:11:44 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm6728517a91.15.2026.10.29.22.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 22:11:43 -0700 (PDT)
Message-ID: <6c683dbf-45e7-4a19-968e-5acab3290090@redhat.com>
Date: Fri, 30 Oct 2026 15:11:35 +1000
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
Subject: Re: [PATCH v2 1/2] KVM: arm64: Fix dirty logging detection in
 ring-only mode
To: Wei-Lin Chang <weilin.chang@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 Steffen Eiden <seiden@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Leonardo Bras <leo.bras@arm.com>, stable@vger.kernel.org
References: <20261029175238.3214788-1-weilin.chang@arm.com>
 <20261029175238.3214788-2-weilin.chang@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261029175238.3214788-2-weilin.chang@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 3:52 AM, Wei-Lin Chang wrote:
> When checking whether a memslot has dirty logging enabled, the
> KVM_MEM_LOG_DIRTY_PAGES flag is the source of truth. Previously in
> memslot_is_logging() we were testing the dirty bitmap only and did not
> consider dirty ring.
> 
> With the ring and no bitmap, a logged memslot can still get block
> mappings, so guest writes to most of a block are never logged and a
> migration can copy stale memory.
> 
> Fix this by using kvm_slot_dirty_track_enabled() instead which checks
> KVM_MEM_LOG_DIRTY_PAGES, within memslot_is_logging().
> 
> Fixes: 9cb1096f8590 ("KVM: arm64: Enable ring-based dirty memory tracking")
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
> Signed-off-by: Wei-Lin Chang <weilin.chang@arm.com>
> Cc: stable@vger.kernel.org
> ---
>   arch/arm64/kvm/mmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

