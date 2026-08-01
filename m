Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D9395AD1
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785596259; cv=pass; b=bSDfmeR54a2j2qDTP/FAUYi0eE+MfCFfRoTI7kyg6RNuJEzFKyKMAsW/0zBTgknFI3SMmJPfzam7vgoBkE27Im7YHAIribGgzchq1DtBMb7PR9lz7USRYd5VCXtNKQ9rcahELt2B44CrPKv/ETlKVN7IQhdlDIS4ce220XmPJ8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785596259; c=relaxed/simple;
	bh=9jcsL2kmnS3mUEK7x24EyKaJQ0164vGOexLT+3HPn88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQw18Mr3q/PD2nSGgN6T7EVIY5Lev+eHpxTksZSoNCVC8MiV0q7Mn8UcWbgfrdB6M43pgaNa4Amb3imbg/NlXW3gG0IrmeEeW2/TVKDtm4yKh3w0UekS+xEH4l1mGTbEt3vfR2xp4UPn/k08TM5FSFhczc9RYRzJFPgy1FwotBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWnCP5AR; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWnCP5AR"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69edc72e513so409931a12.3
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 07:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785596257; cv=none;
        d=google.com; s=arc-20260327;
        b=X7qUoXR1/e2s0XG6c61ta/Xu137PId88txedva2eiAsUqHXvIJ0XmKZeI3wH6VIvpc
         +PMntf3fj1V0s+rZLZLlDSFiGckXnHVfC4XE/763RXKprEyGMaScx4XDFbmVy45UPq6i
         kHIB4WBpD0bAJD8OBm3W7sfr6e+porq/83q6y2iQ4IOKTGG0ta6M2NU1xngEQyqPQQRF
         6K/zGaX2h2T10nd/phOkpO4v+jVplvi1cQg/IT/NEwKoelTnLUXS+lw/ObH0cKLgAthf
         3n34ncNhZlCZI8XhpMkDVLjnE9eyxmQoLyoufS2YGkP8yWiDzt8HBPaG1ULNXkozDusD
         nsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9jcsL2kmnS3mUEK7x24EyKaJQ0164vGOexLT+3HPn88=;
        fh=233pDpYWLGzUsxHenNKkzNsKF7MtV2YhpOsChdvMeeE=;
        b=BANAtgFalOPqOURIIdEbCe/bU7I/C2afO2aJ1oA47VrCIgXqYnV4z1w6qywQ0F9+gf
         M1s3JSdaBCmwfVKalYbFWfMMQ3mxisYJ12scQR0oNItvm26C/EroRnGzqj/2Wr1LtVwS
         Zu4IdxzCZREG9Hf/Log143lDgg2iOSwT20HeiIraXPypUpTRUUDHGnjyLZg30OyRTzbx
         jhy5ns4p0GS9P8t7idkjqXktxl0Lpxm4N7Qa/bxoWjFmgAW7Y+XbdOabyyDuLmZo+hcg
         LC3JJbuYggm5+40pjBYfTJU+21ow7wldRTQk69H1aVns4OgEkwYsi0xNAMRzqQeIhoJt
         IB5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785596257; x=1786201057; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jcsL2kmnS3mUEK7x24EyKaJQ0164vGOexLT+3HPn88=;
        b=KWnCP5ARPnMsgDr33mo/I9VgFf14yKwpb/GC7V+2TYOa/A95T2DITeQ6pCKvls4exE
         mqtLMlLHDX81EFCdcf8VNcXuGiSaxjwziKaOKDXu254+IrqVioWOxV1oOraDM1iejewO
         rpTikBCdSv98BzF3hNCmvjdw2LX9OWLxCM2myod8RpQsedfaUIDIjPmJtIt++yaUXmWy
         ZoKJizl60eGwfGbkUEy+b8jzX9xBNapUsenrVLJAWxlut8ijmr8Aq6TBSsltB+aBvJMI
         ubCSSC0Y5shhcZkGzuam8R6LkoXzZHTdVOhGVLYcp0AUZvKHznIQg1KkknG/cz52xzag
         eOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785596257; x=1786201057;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9jcsL2kmnS3mUEK7x24EyKaJQ0164vGOexLT+3HPn88=;
        b=WH6UDHjY6zK5rz6kfMwiFcVQ0AOoTOBWyEGTI0uJq2/WazAS3w5oAPGtZArZqEGamj
         DjIIXonscLc5GMY+hEK8z9/qdpw8AYh7CtlTcQstXObeCzzjAkwucZwzhrCYS44a8sKj
         xkGFY4vje74/N1cZEuBV6BBghP6wySZXClmSjDxPees+bcKhG9+sxlyysUmy0YsZafEt
         o9Kqsmq/Xw3U0eu+K4Gp+nZun64vLiI5uMCe+mtM9Qt8LY5ygl5pIopPEbMNWKhgTV6G
         0TStpmK/W0Ji/yfgv2Q48/Vv3C4iX7A8dG9r8f3z3I17i44aHezIlf8feASbGhbQdR1B
         c89A==
X-Forwarded-Encrypted: i=1; AHgh+Rp4KWZeGwXuzLJdF53smMT2hfSQlv9lpbowqi4RNLGkBY4s2+/VrR+3LbM42Hveu1rTpN5KUL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8vZQfY5z6vdgkdh4YRLt9pwWd/QOwvNI0hO76trUH0lQXCOeZ
	WRuDH/Dwf9HSbdAKVW1diCPo3jcP7EexZScM9atRhvvn5VjbnTqgdm7GpMsnn8UvYueYs387q5Q
	MOjm49mRyzdLyKmnYI51hlgf30YFIR6IY3xPo
X-Gm-Gg: AR+sD111D7GzvNVDGe+MdWhcd0CHSkqOdtjO/iRqjVDXXolJR5M6i7xaTKyKlftVL7v
	RyvgCbIFhnlrKAHaioB+e8Q8aZnsByT8mfNlPGXgbba4o1ZKcXFB5K67xUtppL6GtO020e3I0nM
	SQRjQdS/wlMVd7Pew017wx9Qzsj/tPnUwLKTqdF+BZIY2S+L/CHR/CyzhcBJ/Ve9n7d4grCH+7i
	Z+tY1RwOXttD0KL6lziG9nQXm49iYz6v/O60W99SkCKXji8itCF23ZC8AcgOCjsFHQhWZzln269
	U9FBh/PO9KfxAtMqafiJ4vkgzFEUSlBydxH7lrjf8GknCvJb1jhlr5+i8Gjb3B2h3N6a2angQ5L
	6Fnc2rktB
X-Received: by 2002:a05:6402:2111:b0:699:6415:751e with SMTP id
 4fb4d7f45d1cf-6a0a7d096f8mr1938361a12.4.1785596256583; Sat, 01 Aug 2026
 07:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730104103.2080325-1-nicoyip.dev@gmail.com>
 <CABBYNZJx46usjp0_snfRQ7pvWrxPE8NZqSyqyM0rMEsoHgZnow@mail.gmail.com> <CAAo+4rV0ncEcMGZVH+VHScJozqs5L4C3S-mW77s5GyRKeQ78Zg@mail.gmail.com>
In-Reply-To: <CAAo+4rV0ncEcMGZVH+VHScJozqs5L4C3S-mW77s5GyRKeQ78Zg@mail.gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sat, 1 Aug 2026 22:57:24 +0800
X-Gm-Features: AUfX_mzHehqygWlg73i6eROY9af5HU3Udu-hd0Qa5VaoIeegBmsS60wFcCaDnSg
Message-ID: <CAAo+4rVTXCjhbcNxSMBefTm8C9YWN03CMY2dXGK3izgbb4g+rw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: hold conn for LE timeout work
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The v2 patch is [PATCH v2] Bluetooth: hci_sync: wait for directed
advertising completion.

Best regards,
Chengfeng
