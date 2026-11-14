Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794680259;
	b=RJdhrP4LJ/Tnpk2SjIQtDP6vvkGglIobuG75AaKRWUuWyCLPQ15UPkS9FMtpxcmFuabV
	 pKoZmguDyBHZzzy7EippV3s3zSyXvkN61Wg7UeLCYPLiExxxbIkoUEXzGHkM9xupPXH42
	 Uu/amga8Pl0KYSSu09r+Ri9woBoRP82e0ddSWS6Zbbye1VykQWehNK544kLkDcjwFys3y
	 s9zNs/5qNAzldvY8qT5YW5FiGK9Dy9O/jevYrjtHj3hY9u/FeZoiiRL6Ga2jBL5IfMY1B
	 Ue/ygmWZxxYx9iBm3cFr7SHpTFPB/2Tmma7evNm2DGg/O1n+0RTYnZL9T1EHteP6uMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794680259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Akw4w+Mm9p0/w7vgjEImHk5sQ6l3ya6ZIdLy8E2yDA8=;
	b=htq26lQTaunmRFFa7e5+SU12DHO7rgEaz1FIopVxV0l7/ZXrusgb4y/WjsTUvpETdAQM
	 Aj6h2SFoEIhaqKOOYEJf6xE4AZtqyPjwJrQTd0piEz63IHRSg5S+UfVUIU0+IB9Dt9hvl
	 D4YE/RlPtdboF5uRUDIxeXL5u3yJvcalg5YpwuCZLQ+voGEGWuc//hKxfwy2LNTtQTPEp
	 w/UzPNG8M9NS3upyOMrAtkmuf3SfvPcaPvJFtoLYomyMn4f2JNh9QqL5FChPVL1Hf2lkz
	 PG55bXB5X+w3wYnGpB9GaxZmSExY8TOAxOyIdFHcjh3iA0WptafNEorgm8K+uk1jFQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mXVOsOUK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C5606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 18:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A15C5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mXVOsOUK
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-99e0b1ee864so14843241.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 10:17:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794680257; cv=none;
        d=google.com; s=arc-20260327;
        b=Qpuf0rcOg6vdhvsDQ2hbPT2v+BVC6pVyKLwRW/hPINFQSNEEXe5kOc/rEolj3zmDlj
         7bAtfu1XEJE5FuXtbzwzgGnJ6r88F6NBUNLwFkFRKKqUv2WzkHq1YWd7C/oSKmQbtyCV
         bAl3+sQ3a4HbudhhSPdIr/lPnj0JoFD0gzVSI37cDY5b5EzkkNw3QSJUv9Pt6Y1ERSnl
         lBaOMT3TRyR/Swso2qHR7L5w/zwdwqYLLrpYKTs5sgDI/3ah3lc5MhH8dVyOt8tdHEtX
         y3C3BYvUKcdExxtdoCI7OKIvD/ETk9fpjv8ONI4q7u9plk9gxaS/uYNHF5GRZZ1lOcYa
         n39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Akw4w+Mm9p0/w7vgjEImHk5sQ6l3ya6ZIdLy8E2yDA8=;
        fh=zBzYye3YfRv5Qq+GAR1N6belNqm/6OrWvWFz+bibexI=;
        b=qBV5UyUopTYLo6oGjIYzUCXIjWsPhCSGh5x7KH7nrNl6L2UJyxKat/xzLNsnz+CKOA
         1aYVLa+nnQSqwUNZL1fatmoqPdtRYdekLJyevxGzEVGm2/CtaDS+6PcwQVbDP7GRmond
         oBWltM1opZEBdCp6+Dci5os5R75VYCWFqUYrxpffX/8AFL0hdozUAyCSbzchySMRP7iT
         OR5izbKfH+3WyUH2LbITE6nWaEssd6zQS2t/tQOsEK1dvVoU27K5Hq51XawlmGNcNeH4
         CHeJeStDg92yg4nUeExWfGrKULTbsS2hOrz0wV2Ab9SrjaKxCPuzm45Q6y+HMUgaWamK
         Ra4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794680257; x=1795285057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Akw4w+Mm9p0/w7vgjEImHk5sQ6l3ya6ZIdLy8E2yDA8=;
        b=mXVOsOUKNAJeo3ZO3fzDWnh6gj9KJzfdTLuB9IRjHlWh4Nit9zPTAnajqt84e8RVPv
         L472Pihle4AR+2PogxGgWNAO36LIkZJQgpwzFM2MMFEsHdRsRmNsAE+8x8RGcaI5ZSmi
         Yt1hgOdSKtLekx90VVujp+zofGT8mX4KiOxKkZNkG0b535JM72hw6vmkLm6ZkW3MCwJr
         R5pVv87wfXrbumPvOB7BpKaCiDCsIp9tFbXuP96qQIjFULf+dBKE12kOkg5M44uewczb
         ZpgsDH9LCETVRBlm/QsWsMq75Smd2gyhaHhRH1Rcc38tx9BC5snLs4YFr+1vwJJWQ1Ki
         Ci6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794680257; x=1795285057;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Akw4w+Mm9p0/w7vgjEImHk5sQ6l3ya6ZIdLy8E2yDA8=;
        b=pWFhizFKHzZaLBWxlIYKms354DCyx66iAnX6xgjWKDIT6//9DYLVdKs5tSQn1cx6vy
         bcmnQ6HGPQ4hoRVtxKaFx8mMOUN4ARJKhFN0DFftBNcdI8S9Icd7FubnR7ELstiGjrOz
         9ESAnJSqA2vVlwttFoiN0Sj/+t7OA0uYwzusMsmUAycEqPxXs350jk9pFJPXwyYME7wQ
         aGejXYIWhimSiTRW39Q3vsfDvfpyLlAoZcSLx5sRqR2znRr1PxWE7X7/FSmH54Y21CtY
         Kaa9LnwCPpltkveu+WGll6RkXPSmTki7NjAzzAn6hVkusEsCj4jCWlY3/DSt3wq7Jipx
         qisQ==
X-Forwarded-Encrypted: i=1; AL+hErGqO9YSQeTeS3KfPBYy4LoIOnejwXKgs2ZPgVxuxdqjgIfSS94KuUn1ItO+7pfBnaGjWlW2RP0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bRXEeCwgIcpPZyr7vwcDMcQcy1/MryfLIKlIGgYYyZbpHCrr2
	gS7YzHtN17HD3HEmtP4kQpJGWpkGSRUB4yR8JpP/srEEREeatVafYvrgFmAX1yZfD6RmhMWcp5/
	Aoe94Gwawq8SQ+C57WGqhsvGjJpqIxAs=
X-Gm-Gg: AYBFou1ZfHJF7mUzplNk8fpIOBrEMO+38AFj+GOHUm5sGPtAkkpJ4DINP/A+DZD6j4R
	ifb/6v4IsLarsqRmHof64vzN2TjQk/sKiF7woAtK7mwpMOI9HvgjMmjT8gyRXJg6d15uDfhlbMj
	3f6PbUHCuR3j8/SxEyPfnnbIYNTE2JmhRZ+7vtU9xJR8zsaCsfl7gFmrxBoAgsjBmxUinSvHgg/
	ggno/5c3zLK/zOkiEUUm6ibwj+wdXhSw6r7xJSFe9cZSuBN4nkYpX2Fm0e+t+qlwXDEV7Vrxsj1
	W2iJLTnsD8C40+HiGWaHHCm4kTIY+VAH/7xlOJgyhoOJy3ZtQPjq9g4xURIudImZLzNjXK6VRmw
	n7ktTgZONkHSQqqxzqynQXQYMST9JgLNj43Ph1koUJM6h/v+CDIZQgTYYmavl5BQGKt+X2pH0XO
	V2q11xbsqrCqJHz4Vzmo8kMYtFFkmk3/iYfF34l2YkyqPo7149wETjIuX21Hwy7b/Sg6x/U9rk6
	LpZYrG4CA==
X-Received: by 2002:a05:6102:94d:b0:7cc:2cef:b330 with SMTP id
 ada2fe7eead31-7d64d6ea31fmr2531841137.12.1794680257398; Sat, 14 Nov 2026
 10:17:37 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261010095211.12831-1-krishgulati7@gmail.com>
In-Reply-To: <20261010095211.12831-1-krishgulati7@gmail.com>
From: Krish Gulati <krishgulati7@gmail.com>
Date: Sat, 14 Nov 2026 23:47:26 +0530
X-Gm-Features: AclHuK8z0QCSIrVMOeF9oHB31OfX_1Kym3M-aXR-skyGrdiQWegAViV-btSEV5Y
Message-ID: <CAOzTEaUWqAh14GFL2ZfrLS8q6EU2VsY1TyG8Tw2C53+6d5R6HA@mail.gmail.com>
Subject: Re: [PATCH] HID: core: serialize report_descriptor_read() against
 probe and remove
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: syzbot+bc537ca7a0efe33988eb@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Gentle ping on this patch.

Please let me know if you=E2=80=99d like any changes.

Thanks,
Krish Gulati
