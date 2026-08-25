Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935CF3B5843
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787685728; cv=pass; b=PDomb+JBSCh7q9y7oWWnpOARrCEH5Lw9r/mqKSdDVgOU4Uro3xR2eSoPT6UZB7W7UFO+/QPTt+xfTTeXkPvJmsqYkpQwwuLoaLtK2ZyrkmQJ3K2AVNPT392D9OBj/EhiVZ1qzL43o8cmlA4+apWdpodRz1swcvyGdP3SVI6A2QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787685728; c=relaxed/simple;
	bh=L1X9kmnPKW88APV8KwDoTtyqLFwd84rxEU52MmNhWVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIu5VvERraxzm9y8ZezyxG45k0fxjBRwqrn5RGCrdL+5Rcjgng3law8w42PYRvw/uNcRS5yob461NsCjpT8kIPRSUoAj2iHDaORuCku6Ms7VFAwkpgLBo+ZbpsZpg5tQdTkoZ+qAcnyoR4zL7M/4mv5S9LhBH5LzTCDfAaWdKIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAJ/FazR; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAJ/FazR"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66d03ff78abso236499d50.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787685726; cv=none;
        d=google.com; s=arc-20260327;
        b=YKsGyWjfmfT0Ojgz4wswnEfp5zzRDwKKb4R3j2xbuwZnrI7IsC4ec16blIZhQ52UF4
         MdHU5IfXnn/NQktbZhDf/vZQqZKdpG/xyHXtBAZArMscp7Gyjxvd7dSjEPKVtU62FirL
         QePgz0OC7+nAjYdnnJQvjiXk2lxSeEuNecyHqpklGvbBb4hidgDUncF/FHH6jl609NJu
         4NlbDDHq5RXyFgHSwE2VXGRFsy94AGl4w1CCIZ4980gbDDibpIe/QUymr0UQugvE0+0O
         2+HhIv+cuONlHN45dwHjWp1/F7fAJ+ChqX9ldZgayj9q/+XYfIstDf0ty+7FyYjLmD8L
         Pxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L1X9kmnPKW88APV8KwDoTtyqLFwd84rxEU52MmNhWVI=;
        fh=Kuwx5vptHtqgrsjAYpDDTROnZhWbwWflQerdI+SDm5A=;
        b=AqLYjtvuj2JIkx6nkIj2ox8zTOnTELu6StvclX1jafCo8GFALa/r+liYS7hr19FW/K
         812Rw7fZhmH9PWcfp09n/15hD7MtsmjPZ63HfepXr0eYW2YUEsTtT54Zsy+8DtD2Obj2
         1uUqKeZLOJ2GkNhm2W+5dWLxru7XZS+e0qupfMbTkwAe1g7voOBSz+96PScTs3C/QX1W
         5x1YGIwwHbLGy8X4NrSYGtZcwbozNjDFNhqyPZuCGEIWE8IbYf6DSha/R8AcqIxCH2Dz
         q2FE8h9xN0b/+e7s00WObScH1jIbhNHceDkYLxfhAcwD40ywziDFyBQsoz6SG/NBs1wh
         oKyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787685726; x=1788290526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L1X9kmnPKW88APV8KwDoTtyqLFwd84rxEU52MmNhWVI=;
        b=VAJ/FazR//Xknmuy/MjkyfEZ5iKuiKlhEapMtqSWi+O3s/VWL3Ugstp+zNB6xMx7QR
         fFY0ZzeN9Uxcg+3KcySepPcPB8W78KYC1CzpIvUdKa3cQVFg9XzTA2qy+PGHa0ydUL/o
         0DHRIsIH9K21UiVAKyl6+otjlTOq9LvcaTBcNy0RMIdsKsJGTd5qQkpiaLRZoONtQH7g
         qKqjpJ6L+A1jDgXXsZDvVFKpFoI9L2Z4qaUwICLV/DgR1Cj2Sd9YSrL+hhhvildAnUFN
         8NIkimSYexlzG76HQjpy4CixbO1VhoK2t6KcKPoxDuOsQ5BqUTe00uamwHu5ExiHChuv
         tiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787685726; x=1788290526;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1X9kmnPKW88APV8KwDoTtyqLFwd84rxEU52MmNhWVI=;
        b=bMy54ARo/B2HQUTjx0l84WSIdpAZBxRrXBnGx9WW4ARQtgpjqKmAzyB7E6y617vFRo
         8kvLdkQrI4ZnT0USwQqDbTSoqHt/ipFXp2BNriANRH0srDEYLdkljk84q54gu9RimNtI
         s+H7fvULbZnQN/U4DoJlzlS1TqsNhpfSMb4tkyR8y1jO/KlIaubIVAVQZsDgmInaD29o
         A5YsBythNfbVX6E5uDH+bvvgwY4QdakfpPof9dm6iJubEDsqj1gm5CIi17tI9++SXpDq
         x8YAGIA0bSpQq7y9FiV2WFiGAF6+1Wfy6z0FLg+W4mLFrqeTyMm8uVekpPepvm1uj+Og
         0sbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqLrTKe5G211bBN5ZzViUJvaab0ndZOMOjtU/rYj/LJV8NdUkAO8FyHZgzMPQ49tcNG7nB3Jv4=@vger.kernel.org
X-Gm-Message-State: AFuF++mgMBWmZ2Y/nbfmCDbf3EEhWPU85pXdcC1CfzSVKBS/g18agvCg
	8bBKcYbQtzUkpc+8hGg4NkRr70TUAmYW5XPo0GagMEeE9rhbT/e6Ua1cXlZrMqfCW0rKoljk6hZ
	f68hebRT6YIiAQkE6q+loFfxZe132Sf/ytbwd4K0=
X-Gm-Gg: AR+sD12inHxk/965V/6U7eqhDLXxhWwqmiMI6XotbD6Bwhp4x34noct8vJeYZmqIbnd
	JczP3JonRzuaM2rFjTnurEzfov83E6yX8y7ybaCgAYnIBaKX4TuwhtPBW5zvpMMRQo7gnQgN7jQ
	O1IORT1VSw4IGWXY8y6s294ceOKHAf2KMV7HtIYS3UnJKMpH7Ozx761VBbIcPfFhbH8/dlSghlt
	VJkvT3TVqhXuVrCiR8zNFptHuA46jCYXB/Qmn2muwoSRsMfzMRk16ONq2lyyidbTzVdYqwt4Zxx
	OMBJLNoOKEyVUgBTWtj6mzb4531Xf9G1YN3XtarQu5PYYMbA+Ky4aK2u3FaY8BkRZHx68krQ5SJ
	KwYApdNzhRVzrIny3iBplWtZ0Uix/QqA=
X-Received: by 2002:a53:d80a:0:b0:66d:c8b:7a3f with SMTP id
 956f58d0204a3-66d256574ddmr273824d50.10.1787685726474; Tue, 25 Aug 2026
 12:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822164341.3750491-1-nicoyip.dev@gmail.com>
 <178759021163.3014491.6954824460297136867.git-patchwork-notify@kernel.org>
 <5e76a95e934e451e7006db28827c2d64af5a88be.camel@iki.fi> <CABBYNZJotKc4k55jEEweD6aP6XEhYyKAgk4BamV5vfp8HHi0Tw@mail.gmail.com>
 <CAAo+4rXEQ7DbjtB4ZTUAm5Yg3-jKRzmWbH+gTfUF510PU5caYQ@mail.gmail.com>
In-Reply-To: <CAAo+4rXEQ7DbjtB4ZTUAm5Yg3-jKRzmWbH+gTfUF510PU5caYQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Aug 2026 15:21:55 -0400
X-Gm-Features: AcwNN1VM6jIc3YqbEmkUSp3YYTDAtgD7Zhgklb7Wnpwu0qVDhFV-hx-0ptxdH3c
Message-ID: <CABBYNZ+0cbKR9ZAxLWK-8saOBR5u6cFEH8ohxP7hXGL2475rKQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: serialize security confirmation handling
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, patchwork-bot+bluetooth@kernel.org, marcel@holtmann.org, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chengfeng,

On Tue, Aug 25, 2026 at 2:46=E2=80=AFPM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> Hi Luiz,
>
> On Tue, Aug 25, 2026 at 4:24=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Interesting, I though the kernel_connect would actually behave as a
> > syscall and use it own thread so it wouldn't result into
> > l2cap_chan_connect, in that case it is probably useless to use it in
> > place of l2cap_chan_connect directly, so we may take the opportunity
> > and clean this up.
>
> Sorry for the negligence of the possible deadlock cycle. Could we
> avoid the locking cycle by directly moving the session lookup and DLC
> walk onto krfcommd so rfcomm_security_cfm() no longer takes
> rfcomm_mutex from hci_rx_work? If we need a fix like this, should I
> send a follow-up patch or send a v2?

It is a possible solution, that said couldn't we do the walk using
rcu_read_lock/list_for_each_entry_rcu/rcu_read_unlock?

> Best regards,
> Chengfeng



--=20
Luiz Augusto von Dentz
