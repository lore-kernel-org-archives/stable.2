Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81733F383
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845801; cv=none; b=n4CmxpK9vO82+yh5I7FOta32ga/ahvO12Y7ioD5JoynVtAJvqeNHaelKPixtt8kaCCZZ07UIY2FdPckCnR3NJ63/I/rCn90GOV5VgBfMQC95NkR/8Hvk3f8z1Wf860LCF6z56hcw5KcR/MkuqDQqyEAhSHX9OmCppXfXnZqCvcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845801; c=relaxed/simple;
	bh=bklSOIvEO6ydtChVkoQV9BjzbbdWhS+ESNcqx1MZvzE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FUv26EzXzhnhxIxY0LSaDPwtYoeZk2soCxE0xOOJ82bpn3x/TECQXM7jm3WBAzZnNj2SD1qfaZ3ybphV0WlICbhyofn7UCRid8DS2HA+/+Lou9a4SRYKsTuJ2+6mFhga6aT5JO7qWmXwbvDalQcPBDDtd2LknX9cFkbkMTn67xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0PaeMVz; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0PaeMVz"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8114a4542b2so66427957b3.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 05:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785845797; x=1786450597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3WZH5i3Rn0Miw5AIdlaT1MFKoD8HfWrkPOLXr3/e2mM=;
        b=Z0PaeMVzfUSvVYc4ajX07y9SzmpB+myLqRO1cMY7zr7oQQG2NQIrXNshLSTqyyJEXf
         Q6ciaDxsc0rZrdhBeTeGrrH9mF2WZqidjcQvhnWUjIBFql/vY752Ej2aDarvRTXFgs9Y
         uwNAtDG4vlcJeJzHJDXbio1lky2b0YLb/4oC6hamjonXbkuQxR3WX1TOiTJy9O+8avgm
         R+WAnXO7r4vcR93Br4Em6bxJhJIqUJwMH5oE7DZ+Nk6t3C4L3BPrmua7njAg1U304d5E
         ehlGIv/4cys+Cv+N4XYT6LbkneSm04Ek61+WFkL94j6xiHl+9Racv2/yQfGQ9GLDL3uH
         yobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785845797; x=1786450597;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WZH5i3Rn0Miw5AIdlaT1MFKoD8HfWrkPOLXr3/e2mM=;
        b=Cjv2Y7J91egnOOdhSEBuR80qeF9xj+kOgCHz+mNEAQEUVH6wRQ8XHhx5azJr9Jeub7
         vgKeZanaHZRXykuojPylFbZdT2P95HcBsf9IriqhuTUtybi6XIULFdaD9UtVjoBKW7Qn
         C6GsTQb36P0InRdFsHAIsgNrXoajECcUntz1U4/jeDkhlsHblyH44xS0bLdLgnFhphjs
         qnQLmOemiCTPAewK5vlGLeg6kYErYd8ebID+3hXI0oc1i/7x+RciWWi/8m8fcylpHQOP
         DdEy0iXSG1OFg7RZAzPPnDRmpr+BR5rmNojcyZ9mdB7tDGm3UgxzgwBt9+KG+6k3IKUo
         z6IQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq51jGs4BmRrFbwoirKxELd9KmFA5jCMCMieVU8vR0vZBWIrdJbJ4AztGnxJ0hIFXQjAFnOxHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm+GGNxMRvnbbi7QguJEttKhjMApfd4beJOpVTufd0/doP02F2
	GHYdlZlcuiJ6A8uG+KUB6zEj2y37Y7G4bB45e0wOm5O1JTnxOSDPNpdy
X-Gm-Gg: AR+sD10G6uFmb1VIioUV0TiT+gk+jkp829DLczLnpFN/v5wPtxIJ8FdBL/GQ//6axa9
	uCIdFeK/TnEi7c1MdUzOa0fBOhcCv5pvygiI/IQRhKGOoGcKPhtILbiHhb5QZ93fCneoIBwzQO4
	3pKQnVXE/DcoRaB5Jbx07ooeUUAN6oLihgWexj3n7H6uCZFQgR73uUcvjQz73y2MSS3DLjmjEyU
	bLu2JqZswJOdK654ed20pX9YZzM/cstZan9tBC7nLTndiBOSDtuuMtZuFKfty65rktF003f+0GR
	M3Ty0btsEfaFr1hrhCtIHS6h2Ta4yVzM9vf0DOrNQzs6kaK4TK/19bq3JRzs6cO1sEYHFDNasCZ
	bIPjMASD03AKEbsaW9UWSdr8JmzvczeizZ13ihPel4n0JpnLHkJHbm6FMYw0osYoTWXwtWJAkC8
	jq0N2ZVkhyLKd0UwECrji1525SsRV1v9PKQrRjMSwy9rpPgoPQ0FQ41YZdvDD7FvGQ9ZiK6TzHj
	vjUNBi5lk1WFiTdFz1mSP1FavPE8+SHKsYo
X-Received: by 2002:a05:690c:6b05:b0:80f:9998:e614 with SMTP id 00721157ae682-81fd4bc110emr162889387b3.28.1785845797150;
        Tue, 04 Aug 2026 05:16:37 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820134d8ed2sm3812087b3.45.2026.08.04.05.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:16:36 -0700 (PDT)
Date: Tue, 04 Aug 2026 08:16:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 daniel.zahka@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 stable@vger.kernel.org, 
 Qihang Tang <q.h.hack.winter@gmail.com>
Message-ID: <willemdebruijn.kernel.1d1da452d95b8@gmail.com>
In-Reply-To: <20260804090016.33353-2-q.h.hack.winter@gmail.com>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
 <20260804090016.33353-1-q.h.hack.winter@gmail.com>
 <20260804090016.33353-2-q.h.hack.winter@gmail.com>
Subject: Re: [PATCH net v6 1/3] net: remove CAP_SYS_RAWIO zero-padding in
 dev_validate_header
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Qihang wrote:
> From: Qihang Tang <q.h.hack.winter@gmail.com>
> 
> dev_validate_header() reads dev->hard_header_len directly when
> zero-padding short link layer headers for CAP_SYS_RAWIO holders:
> 
>     if (capable(CAP_SYS_RAWIO)) {
>         memset(ll_header + len, 0, dev->hard_header_len - len);
>         return true;
>     }
> 
> Packet send paths call dev_validate_header() on skbs whose headroom was
> allocated from an earlier hard_header_len read. If the device is
> reconfigured so that dev->hard_header_len increases before validation,
> the memset writes past the reserved buffer, an out-of-bounds write.
> 
> This out-of-bounds write is masked in some SOCK_RAW paths today because
> the same concurrent increase can first make skb_push() exceed the
> reserved headroom and trigger skb_under_panic(). Remove the zero-padding
> branch before making those hard_header_len reads consistent, so the
> snapshot fixes do not turn a loud panic into a silent overwrite.
> 
> This path is only reached for variable length L2 protocols, where
> len < hard_header_len but len >= min_header_len. No remaining in-tree
> variable length L2 protocol implements header_ops->validate, and the
> CAP_SYS_RAWIO bypass that zero-pads and accepts short headers has no
> real value beyond allowing testing of intentionally malformed input.
> 
> Drop the CAP_SYS_RAWIO branch. The remaining reads of
> dev->hard_header_len in dev_validate_header() are comparisons only and
> have no memory safety impact.
> 
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Fixes: 2793a23aacbd ("net: validate variable length ll headers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

For future patches: don't send new revisions as replies to existing threads.
