Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792659998;
	b=CZOf8mEEz41JT47Rl5FfbmDKAWxOyJA1ZIfhk50VGgXhcEiVWuoAcFEY/HHhLaRFhVD2
	 uxEq8KiuLUU5r/ooPvW0ih+7BnCrW1cOZa5meaU3bO47EiRS7Rojo6G+Me6yS2iK9K/Bf
	 KHHWTDK3+rgNZffSpXihvtOjPMjgLFS8PAhRkjfv0ot7/N7wDER6SJo9ccrd6ZiUMMphb
	 oqcDcN08qbJtYWo+B0LMWUO3GQQgpoZBxHMejCQAfYKH6Va+hg83jbfLJ3LkhkvkxLUn9
	 ASiwnDSxRmOcqZYCp8tPGwIlad7TB+G7F8BpTrtiBDO0eCul1wscDseKVtxffigcnqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UyTUiRbbZdV2Y+E25wMhrOuOBCwv5kPE3Qb6sCbOz4U=;
	b=cVJejhMwEIHBg1TuyQouBfpdgVpQRjET7dncZcY6l6zk7rK3haFNRNDyg077UJDgBHLL
	 8OGVxI4nZnQBczG+PDEpDLaHMeppY9pn2h0zaA0ffa6+Usa2ljuhKp1VBr8323S89OCbO
	 y8P8On+HtAwW5O1MYUwyCcO/erg0MCt6m/JmiCZgIOoUZ5rQOKP0MlE3Xcs1tq59PSPvk
	 GVNHxEcB9pYAGtqlQqLAnlQmTt7qiJwNbLnDhvEr9PKa51eMfbyw3aOjNHMRNIHwa/rAU
	 eX7hRyKp2Sm2ZoW8FB7ZCsd7IlUHHrkRm5TpHSAqWv1Y9kTgRJB07S6hC6lY2m5Z4rQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZgqbS578;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72392606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72392606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZgqbS578
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8ab43af5e97so7459037b3.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792659997; cv=none;
        d=google.com; s=arc-20260327;
        b=W6rKw2isLvg+/2Q32ztiY414O6TXU/dP8DWfv/PCtphlGhfcNGptbpyhDGRR575Ilm
         uQ/fOrddEHlvO9/3B0Dy6Kt9OoOGp1zvv8ps8DtLiMfHDPTDGeyTdq0eKMFgRdlXNbZX
         BBbUEvi/XjTsOp0DqI0h5OSVpcWmjMVeJl6rg5hWjdUNl2ksPIAenT7kADAj0rIbrbK4
         JbsNzfMCrpPSyaq+tAYRUd8P+z3S86naSnWeQJYQSfX+v8JQLF4c++kTZCR22J6bBtgP
         t5h1GHoFbsYtSGRkv5oQgmL54RjasdCYGPYPIak/ddr0evHg9auaNm6As0NBpp9d1OZr
         R4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UyTUiRbbZdV2Y+E25wMhrOuOBCwv5kPE3Qb6sCbOz4U=;
        fh=Dp3X6Ux2sm7jQO6cxQxhG3YUwxYe6xUvbG3X/ia3VTQ=;
        b=iZ4Q+ueSXN+4OxxZFh5c10cFfBrJ+34sWfYJ1hJAkq2cgghcKGHybMTFUp91qPApww
         x5tP6zWgRcWevDNdj/gro/Qu/NpMSFIFHZQObq8OQo0Y56E3wL+m3qZZ6IF1Cz+zl6UB
         Yb/lHRebrRJWkwlOjNutkoDAftLf53MofO7ejb5P1cA7Y2oZJBCs0gSltRRu1eudabkZ
         b79jnzgwffPARsUxHuA9sC61qfSnWPaiqILmYBRpLi06uC6OUzYf7tEJZJpNUkHrXooN
         GQ2GVl0JL+I2ifPIXwM6wbUS4joiUtzp7YaD6Hym+HilJ77FnZYILGmfHdlgdsvk58Rm
         l24Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792659997; x=1793264797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UyTUiRbbZdV2Y+E25wMhrOuOBCwv5kPE3Qb6sCbOz4U=;
        b=ZgqbS578/pc8e0eVEtIBlY4iI0uHRHMY7sqdMPuAFnhnad53C7K+/FfjUZPjnsPcE4
         eZAp25oJoGp6/l8rW31TWmbQCb13bdm6LAWTjX3qqpEWiJfs63VmZtVNFxysQntKbnaz
         a0qNT+4K2PdoaHjMEKlTk9iiYGXpGpT9gfjhpartXG7Va7V8ewXF0AMiIkdRy0tHFK82
         nmZx/axt65oeeycgVFI4KnLkjZ/1IcFqjMj5mGE7b+6gca15HzOo5Ez2rwym7rr5onSe
         tt5wTiFwjQtbXXoFq3bz9KqsH/bq6aQWy3Oup+6QNwmY5li8AzZd7EUYGUn5G6LwOETj
         zpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659997; x=1793264797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UyTUiRbbZdV2Y+E25wMhrOuOBCwv5kPE3Qb6sCbOz4U=;
        b=E/dN8YILdJHeAw+1PT6Rc1zq7fy1MGh6ZTcKzunfhpB7hXSLWhKGyKFmpHpNAW7evC
         Lc1res/iFIMXOSxI4Kopxh7Zs+GyO6VMMNDI1ADKwBWXQDTothDuM/RuYtOdStLyzsUk
         g0RHxqpagJJWPTlAaNeiGmmgqCHXNwvd6B5tigjA6xkjg5xE2M+ZaQKkvqJwMjjaEjOo
         wJpRL5mfvdzzHCiyisRJ6HQwCsJjnZwemE1jISpQyD+vedM2UesmNcPmU1f3Hpbk7E1t
         ovvPSXYtYdwBgBrH/bclQrTr7lwt7bdXBH62z+Y4roTuOkTK5mflSk1pqd3YlV3RWyvN
         lIXg==
X-Forwarded-Encrypted: i=1; AKwUvByd//oKeROViK6Byv5DQapoX6Fx6CKIQxxTCNO9pGBehVUe94yaNosBJD827AF0TDsFykDgG6M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPsV4jC0BFTYHb2hKr38M8dFxcb45fBbGon/96DcB+KJcjPfYq
	T19gueucpe0dQyd4GJCLpGON/807mQ7BmeZd0S+Bxrk3cHixb9xZl9aipjQLuB3WTB+rWyz6S5v
	DRjR0/bEV1bpaAwzWZVK5i3uR5OqRXjg=
X-Gm-Gg: AYBFou2cG+VrGjW2dnMQ+zlQ0DClkCixrwnzRSskzQhPRamkpOkxoO+1Z4gTQKGeW9l
	Xx0lOMV8WQ4S+3qE8FqntITl4VXLmREJffUDNQ+zkHFdLWFcQv8GVAow0MuCEWt+XJCEmHdKuZN
	BTNNJHYAsG/EOYImalZ0ZEho29fDRLpOaQr64PgU9IxH6Amllab8Z7lWnwSNHrPg0AJQPEaNA30
	TK7oSnkL4AK+ghNgqq/zfYEKmkQTkt0y0UX+1/yju/hn+Y8ygG7hv4qs0d1lu7zT4e520YeWRGY
	xW9No8HsNxW+453om6iKxba8/nLODG/a7LgjosW0GEHOYFaKFKlOnsEddoR8J2/ZhwleCkwdnVP
	J2gIFIUmIHbdgO71ZYnxbuhDJRPQu2XUYjdUEGJM=
X-Received: by 2002:a05:690c:39c:b0:87e:645c:182b with SMTP id
 00721157ae682-8b14566215bmr12678527b3.26.1792659997417; Thu, 22 Oct 2026
 02:06:37 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-ocfs2-objects-candidate-0076-v5-dd198d8a9358ad81f70e@gmail.com>
 <71dabc63-7e67-4c25-87eb-17fcdf2ddd3a@linux.alibaba.com>
In-Reply-To: <71dabc63-7e67-4c25-87eb-17fcdf2ddd3a@linux.alibaba.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Thu, 22 Oct 2026 17:06:25 +0800
X-Gm-Features: AclHuK8qr8lGZVzy8X9c2s5HmaHwSWxAw5vzbUjDMFtGTi0PMRSmysIaKNfkgTU
Message-ID: <CAFRLqsWR_ud2TH9wFnErxvayZODG=SN13c1H-AS4XVL=gytwnQ@mail.gmail.com>
Subject: Re: [PATCH] ocfs2/dlm: drain join handlers before releasing module text
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, heming.zhao@suse.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joseph,

Joseph Qi <joseph.qi@linux.alibaba.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=B8=89 21:02=E5=86=99=E9=81=93=EF=BC=9A
>
> dlm_unregister_net_handlers() is also reached from the dlm_init() error
> label on failures that happen before any handler was ever registered.
> So in case of an empty dlm_join_handlers, o2net_unregister_handler_list()
> walks nothing, but o2net_flush_wq() still takes o2net_wq_mutex and drains
> the entire o2net workqueue.
>
> Thanks,
> Joseph
>

Thanks for pointing this out. I've added a nonempty-list guard in
dlm_unregister_net_handlers() before calling
o2net_unregister_and_flush_handler_list().

Early init failures now skip the global flush. Partial registration
failure still unregisters and drains the published handlers; the
subsequent cleanup from dlm_init() sees the empty list and skips the
redundant flush.

The list is private to the serialized module init/exit paths.
Nonempty lists retain the full unregister-and-flush operation, and
the generic o2net helper is unchanged.

This change is included in v2.

Best regards,
Cen Zhang
