Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF8E436BE1
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362324; cv=pass; b=LbhXemX31tMefXbuxywS+OS9PI/gCDGGS91QKwsQAYN6dG55wXsNw9f2CHLMHx92YlCwQPTbCkzbSjcH/U9pFVM+0C0qvg7Pt4kcTIOMBVclzm9ZpB7vA0CPCXkXDnvBRouPeRpgF2OP2pjyJvl1AC++seg/+dSP6WqoapczPCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362324; c=relaxed/simple;
	bh=Cn4wawG4GsG/KOE07esR3I5RCnLM2n9QtBSsL+V5LS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttu6rhTTkWGZyTEazVQ5cVBLYygDy3c00tTCTCrowpDpLxjdFNGwcyTsvaUKaBo9P2y+ohEZ9zse0zXwxSmgEKZj1nTD06VvnTvKf0PP6g5RxT9MkqWDxtDCEa7owqxG4/oZAamUgeFCIR9ym/AAvbXFk9aBBFhh6svuV/MhQjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRr2jEl0; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRr2jEl0"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so2929a12.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 11:25:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783362321; cv=none;
        d=google.com; s=arc-20260327;
        b=O3IVGyXyUZUIwFAtfNjkeHvF6WBsxSuMSuV7e+B+NGHZ3EulcAZqUkH1M+J8NSeqTV
         w4rU6siVWitXQ6346Rxebfg9Wo4aU/KeRSv3tS1fffcD/1VfBWVD+NcP5ck34tHXY+rq
         GPokILaCvt1ztFAIj8mRFQHJEoZ/agaOzpl8KsgFAMciztZjBykNyamqV09Ws2JdCRl4
         +Ne1US9VpwZh+U7eM9RdzvZYGPhgE3Vh+Lj4pqEvHc6YNcLlE647nm0E1N/nZ18cyQmy
         cAHe7o8vpTUI1Zw/qzSg6M5Ne9QfhGBhPqYJN9GGv30Y5N9HEbssJuE07KKUuyimmnQ1
         vqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cn4wawG4GsG/KOE07esR3I5RCnLM2n9QtBSsL+V5LS8=;
        fh=G9G7LwqI7m9Pf21SSwwdtpNl1qyqVZCzc19RXwEqim4=;
        b=dzZMPVXJVAwmIw2fwIFfK+18KcnYJlAgBCcNuH0REc2VrnklFdOtnJI8jfvCzwuJ/8
         pR7tK/wApNO0cAsly14xS8rQ6KA4VftJmLttPnssdJ4/jdym0O84Q4BPWABBLr/d9+18
         li+36XlsodltTlXqqEEsaXwEubId7/78eCAuR9Q0KHz6dNZulua0UHN95mA1oYrjXbz6
         RXFHCGu8L/+qSDsP73BxPVgiJfjoT9Gu1LxPi5j1iKFQhx9rtA7cqgQTv48bafRTvY8b
         xUXlm0JypWxKArkgRAtBLCpbe/XotBsh6dmZaVfmtFxoQeNoH8BiuOS+HdDk6Dilu578
         x6xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783362321; x=1783967121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cn4wawG4GsG/KOE07esR3I5RCnLM2n9QtBSsL+V5LS8=;
        b=GRr2jEl0pyxbSDaABEaBUjrvHEIlX31dP+uk5xzUpnlIHy0BT4pfwRVsG4zriQS5cI
         BIWj24hXsNx3zYo3iIHTLZleT8bCGes2itDEx+woUAVvk1tWgIYIriM4W2zqoAk1EPfk
         9zsbrRMMGCbo4FKVRdcK4UJrJ+dnyptShG0uyizQbBiNdPEY688TfbIxkw042II37otF
         qgmeEl6URheJQufvCB20ahEb4Lk8jw0DDiyhGRYTBjw6W+RFie3rvProKOSbB2r4o4f6
         z1dMgn+HnliZHod1//r/9/xMtls4hmsqpcbAacCXfPBVfjVUOntRXy07R4EvjT1dCg8l
         xTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362321; x=1783967121;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cn4wawG4GsG/KOE07esR3I5RCnLM2n9QtBSsL+V5LS8=;
        b=sHd4O68N9R7aSSyP9PqcGXtKYRJMko6YbBHsfgQrnDwxaKIv27yitqkfMrNVPREU34
         7+QxakS1avpX7fyEdmrg4tzFDoRE6KPcK0vKHlmk37a37iXyvYfoM6WJQlfZSfki3XBd
         V9lyaVDnWh7wOfqJye55QYhhyUM3Is/LosJNayp9H7eeGOAkeQ6fZvuTKt2algAQqRwo
         k1baYnOW1BiKWD+emmp5gcmLqhvXDCP4q+Hj8ciDm6+irSNjE8VHlEWgEZ2wWSvafkRg
         KzVirucz5F+CD+YRvDiaTHYSRM2o7ixZWJPt/RMB/dPDaUPtqPrCGFo6fECNlXNwT5CU
         Tc6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpfFiN/YGN8Wj2I2szGXyxiyNkWwq2kAhZ/QfSFJUXSdbJuDtimH+FMh1VLLePC43PLeduUT2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy00iCof40T7mkC74jj6U7Eyj9b5ZfE0eIqmhyhj6Tt0kAfEdfm
	KwCmplYofYweiP8EpGUbrwBpSsl/pRvR4dBYMe9kNc5VF0ut/v3jcY5keGtqsaU+vWBwebkZ+ii
	hKouMWzV6XCnVVhnaJVrNao/AHuF92RggDa39c3Qo
X-Gm-Gg: AfdE7cmhDOGXdlqSW95j62AX1llAziyQum3WsB2ybjQCsMDOaM4UL4tdaEaVoekIdeL
	jQiY4WI9OCbfA4Ap7m+7BGWtiXTn9wrBWi5gnxdmpiTFCesPZywgcWFBIHIPQCtHQaDaRk88x3l
	TBHpDeR9VmMg8BJ0BJiMnGiu+kmgkWQVPB8lJInkxr4Ufw4FzOm5ePCqwqi/ChtAO1dKQJHwbs4
	n/qJTUwxboGQBWTJQsqf5GPcJqboUPXBhNX7bUXd/uCDqldeFgddRW9+mKXffkcnfQ5kzHfVZag
	Q1+8MAVl0bm7MQXVLm8teAfRiFBl7Onqx95/Y2bCexMG6/XHrPbtyJo44A==
X-Received: by 2002:a05:6402:3045:10b0:695:4751:c044 with SMTP id
 4fb4d7f45d1cf-69a8d5af200mr12049a12.8.1783362321335; Mon, 06 Jul 2026
 11:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
 <20260706170735.2941493-1-linmag7@gmail.com> <CAG48ez0ebrMy8QGKLuz0Qwao_Eiav6e5pAJ5f6GrUPJLRkwNnw@mail.gmail.com>
 <CA+=Fv5R=mUW_p_AFFr-588F_b1hB=7RhMbtODya-gby=_fjBgg@mail.gmail.com>
In-Reply-To: <CA+=Fv5R=mUW_p_AFFr-588F_b1hB=7RhMbtODya-gby=_fjBgg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 6 Jul 2026 20:24:45 +0200
X-Gm-Features: AVVi8Cc7kCan3qAeIhO9q8vMrkV7_74C6sIMx7nz-yuT58X80UFcpE6GMOhG30E
Message-ID: <CAG48ez094Bu70b6CjfV4jGK+T5ihnprFY2wtBYa4AZf8iHJsow@mail.gmail.com>
Subject: Re: [PATCH] proc: protect ptrace_may_access() with exec_update_lock
 (part 1)
To: Magnus Lindholm <linmag7@gmail.com>
Cc: arjan@linux.intel.com, brauner@kernel.org, ebiederm@xmission.com, 
	jack@suse.cz, jake@lwn.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:00=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com> =
wrote:
> I'll retest the strace pidns-translation tests once your fix is available=
.

I've posted the fix now,
https://lore.kernel.org/r/20260706-procfs-ns-eacces-fix-v1-1-a69ab14c02e6@g=
oogle.com
.
Thanks for reporting this!
