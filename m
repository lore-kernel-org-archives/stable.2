Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF44483BA
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040141; cv=pass; b=jbsN5NMczaSMiR2qdXbYQr0g0HEMIMuPOSj2MemOC3+PDhqSGai4gvaZUj7aAZxlU6IxAaAxQCOCGyrUnxfoEgv0lTu3fy1nP19ZadSvLGEJSKW2dUp5fAcEaeseC8QbbI57FIOLQh2bF1Jt19g9Sxw4XNeiQHGEfMmLSL7z6rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040141; c=relaxed/simple;
	bh=NFSQEjRfqKbXkPb4nB3kEZURW+eoyyvix548p6ehh2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbs0z7xnLKzZMHnu2bsZe0H1Tmc4QGWD7CQgQUaPri5fKV8OZmgh4LOqZt8+HsTuo1KIOfbi95d6E76JV6xG/oQ1hMqfWWcdEkHN6QubviS80FWld6fclshHNrYtpWETLCmzUTjvfkQrP1oGn18Bu+OfgfGAHuOw5JVJ5GpDIg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuuWw87i; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuuWw87i"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81eb41c1f1aso20146937b3.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 07:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784040118; cv=none;
        d=google.com; s=arc-20260327;
        b=S9MjwhsyH8K1cQHoVy74CZ9GlC4OLIJiQp8lyybTaizac5Frz6NdJUy9BcBAmIZzzh
         UfODaDyTkYqV/dg+TaZP3vxBO0VtVZrB1rhyxkQ46cgqTQnRy3RuPEeaYX0XmvfxU9Bi
         HfnuMRNHqPBTLAdvWaGiYNMdAkQb9jESELAZ+7MPMrgusRHJPN2K8MiVGoRufaDSWGT0
         4oO8QD+dcLnr57dnD/o5qb7iDb/PLCP896dp/ahFSJsWsge1UNEeARyHF8Fsnl5KMSgu
         CXcfK/hffXlUmOlgUGHKxYKxvr1NfBMa650UnQO+W7FD88MtTvqJ6c814dvmevnc56Vv
         CAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qq/kNmsuLCZCSGzdUKXz4Xa8/VTue/DnTKj7u4V980g=;
        fh=WiUYEMdHNWtZCAFBpEXOQ3h8Fimj1lJSwgQGs/d1UUw=;
        b=XML4L2DrnYFpWWm8N0eAcj+ftCTRDSbGYX6sbD8oJQx0Qnxglrhm/1UUehR7hKSsDz
         pOwkM8J8EwlUlCivS+iyhlbGqKxsXjOmYaKCD9wk/SaGTbchjjwK3zNaJTCLSN6ksw5x
         MTgHFtKIHhO1mYb+nAcBsXOHgwH7HKA2FAsPbZm61sSUPBtEh3kQk++MaHbh85qzZKca
         TUXq6xYFXI13syYj8Wk59zAoZBIEmrxAmYLXBso7lTSRKKFYs0GMRVMeoHTF6fmrZO29
         FlnTpArkzgkrVHhv64dWOuN4hi30zr9aqRbTuokpDE0Sh+bE3WIksnDsCkSqKTM3kEUi
         zEVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784040118; x=1784644918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qq/kNmsuLCZCSGzdUKXz4Xa8/VTue/DnTKj7u4V980g=;
        b=OuuWw87irVFFpgAMSsZ+/ns8AlxDwSXTVuD6nUpC0DQEyf7ICiMzwkeMX+yQgUhfI9
         PCP/UJHxUSuXAw7Jc41oJMzY8YB5y6uNHiM4vyn0TvRX9R5yrcou7pNPDUO29eX/QTJA
         QwG4ipIHatSoZguaaRXHyFaTKbOKWKUgu3Ec7+PEqBmkrxW/yaSl4K8cysK/XKtGN2VN
         bLRM28sGiVykaIDbpuFpRfiLltJqX2beOi7ejeFu9ZefWaCbjaLz70Qpqmglm5y9o89k
         fZyZj6AXYJoTc0u1Wx+n2gvOROLv3uI2YUZ78EWFPlpduJgOvWfcls1oOrAkOpaqX3Dz
         Degw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784040118; x=1784644918;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qq/kNmsuLCZCSGzdUKXz4Xa8/VTue/DnTKj7u4V980g=;
        b=XgAJHp1OVH2F6W8aCqFMFseYefJHcCTIEOj8pjmvuJz6le0uMZve01wD0q6k2qQfyr
         AkNcxsfM6F8mOo9FE34jFeW41BXK9JjqQRvknCLxhuq2LhWbcnePwxJnyfZ+2iO98lCU
         ymj337uS1WW48+6jtqyv+2c6TR/TVn718I9xbywJhEs1m15beFgOHmMraNMwIGoRc6py
         3k9nbx2lrgn/DhmcX3xPoYiFsl4cMdOvBC83Rs0AdjQShLVCDm3Vw5xf1jvT9cDNLGjw
         HYEpY2jc0hWAFxilrGlU8za9Wg1ZVsZMi0GuBW1BYakh9M97hU8SisPDqALaUwkkR9W7
         lo2w==
X-Forwarded-Encrypted: i=1; AHgh+RpB79EGv6JF92c0CWaeBRVbyexmJjPavczJ+LSjyS0XVEthw77KwnIh/icQvVoMycy3rTDoDWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHhGj/aax5IlAnAN9idXkBM33W3se9yvmZQdPV0XQg11fSw/wJ
	yoIykJM+FDUM7ZHv90MV/sQWUb5hpE944c2OciQQ/QedxpTp09qDmNwKKB3IY7mbVVzAh7YAPV9
	ipE/e00NVarzw7rifLropQ5WRk0qv5Jk=
X-Gm-Gg: AfdE7cnC9ftXEd6+w4QSjIXK7OuCIEG/6odUNxRy+Ikrd8d9a+4OBN9P9Fd8xZRl0xe
	hZqXs2097vmWtPp1/Oba9TC8a+sqsTlyM5FtFuiPM5QqylvURWmTs0uEG0seqeSC9MtXyoGUJfY
	fkKv+4eGT7yXXiwEqRpDYVsk3u8Qg+pfef19MsZwpxBovaTrIxwfvP+56jSpEUwz4D30f3tTz4q
	71iZRm5rgTrlF9BK/yh9dzGYv/xprtuarKbmz17hfH0oABkjnXIm9HR+NErqvYxDd+eyJtn0rRf
	G7XUbfGZ/OB1EeH3MFnYuHDUAw==
X-Received: by 2002:a05:690c:3684:b0:81e:9ba9:d360 with SMTP id
 00721157ae682-81ec006be24mr19369767b3.56.1784040118275; Tue, 14 Jul 2026
 07:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711150547.2912006-1-michael.bommarito@gmail.com> <f5705b41fd63260c5b84343531f139fa72dfa57c.camel@kernel.org>
In-Reply-To: <f5705b41fd63260c5b84343531f139fa72dfa57c.camel@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 14 Jul 2026 10:41:46 -0400
X-Gm-Features: AUfX_mzui7Zkk0me-yGwbKgTVlmEwvY3150nIAIpO-V5UYQW3iLashHaXK3zI7g
Message-ID: <CAJJ9bXx0HXLRZoDRBhMytZmifwG+V9fi3LL9Sj49DYoeh7-Ajw@mail.gmail.com>
Subject: Re: [PATCH] pnfs/blocklayout: reject zero chunk_size and
 volumes_count in GETDEVICEINFO
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 10:37=E2=80=AFAM Trond Myklebust <trondmy@kernel.or=
g> wrote:
> NACK to this, and all further patches with the words "malicious server"
> as their justification. It's time to stop this incessant flood of
> worthless AI slop...

Sure, I hear you.  I'll make a note to skip your subsystem going forward.

FWIW though, these are often exacty the networks where ARP spoofing
still works and malicious server can be read to mean "anyone who can
pretend to be a server/peer" for the relevant packet/session.

Thanks,
Mike
