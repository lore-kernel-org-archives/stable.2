Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5C23395B
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780847358; cv=pass; b=n/lN9M285ED9qGNHbMomSghm+5DtDqrJg8dAavZPtNeWhD1L06JP2PbS4GY2UJ2Lk2jHEWYmDpbzhX0JN4D1KBPNAnAuzCs/eQhHV7rNqfzcq0HHDaN2ohF356dtGi5OC9az+mHw6qOHvTJYAXwNH5qZPCuWPZjJGcHn57t5Ipg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780847358; c=relaxed/simple;
	bh=D1n7Uh0RRkUlE6NRiIjR1ZGk/n2yO8IMKee0qspWMv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMpG7KukkI3Mze96rpD9m7hq2OXlJ5YZAOMW/7oenUD8RVHg9Ve9uOW+MLSk5VMx6WvNo4WEXD7z4NZKgcyKiEAwjuTsjnivZvLDdrS9eMDyEHKN1hMKZIGdmlB4mlbVZ6toAHZXCdUOXJZoqCJwVjHJyvfLBmPXdDcO38vOIFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b=H0PySVIK; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b="H0PySVIK"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bec3f69d343so505772566b.0
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 08:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780847355; cv=none;
        d=google.com; s=arc-20240605;
        b=J/vR5cB+xYokaR1x197jHwezKOOCIznf2P4ZREKG+uofFRrhSITnafLVr1fi5qx7Bu
         cl7QsObcBGF4p17zrfqPzGsOyI6EdSF1n71PnumM0Y/Y7MtvHel03Mokni3l7Zf0bkyL
         ejcw4ax2HeiSBRf6ETBwtZOEsrDBJW+2TVFUeMZgaPuW7Aehm3NsTQcr9QO1rJhf9Wzf
         qr/zZ39wFyLODBTwWmAM7mqQ95ziKQFzX1hE5E5EFRLT6uxghG3Pyk9Do6NEgCb0U42k
         qxwyqScKDPFdXHtuMSj89dJdeyGdv67wvktRS44HF7p+o9N65Ly5IY2cxhFkYrKcvQQx
         tP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xILyxddjfjQZmYMtoGm3pp7Hh4z+748HBnbedYkhxSw=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=chtdwhILFIsyto9IiW+lyU8O1+jEhYLHW1+TJigw5AGflVrS7QotnPkPBEpKFmr3xV
         K0mIexdnNECo2fJ/7njw9Fj8q4da1Stx4V/u1EsexBBzJ9ZMGsoMuZWXqfoAE7s8E2N3
         62/kcaxeWJ038OsH1CpqnS5cPTDtcfXKOPXlV8QYh9KKU0/yCQNELOqLUeGhqpU2R+/I
         IJNQ5G3udFUepPu+0uhv0RAKn8zo0cOczeL3PceEemiNd7TpDHpz5R+gPo/5ZnB9B6zi
         UyHFQUixOMMCHBS+SdJ1O2vDUp1jxxp5Xh/kanAX8cWhrZiN761onNYAZIuQDXvY9hIZ
         PvMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20251104.gappssmtp.com; s=20251104; t=1780847355; x=1781452155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xILyxddjfjQZmYMtoGm3pp7Hh4z+748HBnbedYkhxSw=;
        b=H0PySVIKtBRVESlxa5OWF1ZzdJHWdGDyGE29LprWPwPZSu/HQIK4vr6OCn5QqSMpG6
         bTzKCwcAhFLfuIL0muJibTixPR982+Atks3a1IQDGypOMJGVsTG7NE8Sq2NpVwzyLEw0
         DMj14pyGKfn1XoMqO7M2UGgU4A4/tA70zWH8TlYzKc9eY8pLIyJegGRbTxLNjq83QDnv
         vJfSqE0wuG/rNCCp3nXcikQERcRX4iHc/sIiZ1WCQOKP8WXvJho0RXpXA+1bELURAfAY
         9qh1ubvJbK8fNSFz4ozgw+Ai4ADBjKZsVh3Fi5Df/dMwsiGOcYLvqtczaczUCoXrOQ+7
         fHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780847355; x=1781452155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xILyxddjfjQZmYMtoGm3pp7Hh4z+748HBnbedYkhxSw=;
        b=SGnd9Sn0SWHMAYTBAjVbCNzQKmTmEIif8yhF1WsNqFBby6uHyPY30HJn2ClvqEAb2D
         s5+LoLE5qOA9NJZe6GSQTN4gUJLFY6goeg4NXdzZTs+ORvjzfSNcqZdL489LdVcYQotm
         6s1jOt3LUuMvz87PKfzvYmNtlePkQB1pxYCgmZymzQejpZAnm1PQCtsIlRGHi73+05hv
         szX525za0zAfR7nk7+1kGIZHpvt16I67+44hy3fDUwQ6Sy6MkhSxRDVltI2SCBm7qGgI
         z5bCi7KfMizwRPoXg3odTTMAxcbE3sRUn+5OQGDvLVBcyy/0ID5IX1EsJdPBLvLIcdQf
         z9qw==
X-Gm-Message-State: AOJu0Ywczy90jtaD8Gj58+8rj/M3wE9ickVjGLoRAD1lXhuQERJxTqXF
	nyqATUU0uKD6ifxxtGTqtd2XywM6506BC2u4rlydZzWqVSOIzZkzUEjQBOY1UVmF49gIXFfnFNX
	DpjBU9AEdLthPm8hupOuPV+e02H0D1MYUXLsGDO19uA==
X-Gm-Gg: Acq92OHL6WL/h/F8errndeWjg4PJlkKNwGvIO90oFwiumsgASn9dWRyWpcLWJ6xEpWq
	pC/fsGf1j9GNlFyvOvhusu0wiprCJpdrLXyOaqTkhGk1UsNaQQ143XhafVf/2ZbKuCMll3uWeT5
	0/wRPbXr9nBb3myODIPAkHkmqvcV5X6ODXxzS79Wz8ySs8qE71n5aQhkSPW0CHMpj8tB9f41nA2
	+SxxQskDt+fy71drypd0oZDk4NFCSSpqY54J6W9JDEH2ANNonu07JG9yfubXxvGYjIK4yaXbw2i
	cytwmayCEHQqH3iDNa9aOU9EbYeD3FkVB3y64wcpTw+pQcOMRTCd1HY0uqaR9L2EpFIf684WbT+
	lrybB
X-Received: by 2002:a17:907:6d05:b0:bed:afd7:185 with SMTP id
 a640c23a62f3a-bf3737ed359mr555128866b.43.1780847355515; Sun, 07 Jun 2026
 08:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607095728.031258202@linuxfoundation.org>
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sun, 7 Jun 2026 21:18:39 +0530
X-Gm-Features: AVVi8CeYeLBHlhJ2tTYI6qDwpS_oBJoIdqCJETvngCdnlJrh6WvqcUlyLmSxt3k
Message-ID: <CAG=yYwn9Jwk4VfM_fiEs==xpic0heBDS8X-H6jCqU1cUZUCP0w@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/332] 7.0.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

 hello,

 Compiled and booted  7.0.12-rc1+
No new typical dmesg regressions
.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology
