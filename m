Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795135830;
	b=xrLQus0JRg7y9tgjORb4ZR3mt6PO5msoiu8Ri19Vzb+pY0L0myviXFRvwPAIUuXsaW8m
	 lyHyx/pxCvrxC7pBTLLjGyNqXughi0ZCjffwxP9gkuQcir6CPswCmdSqOtW9kATX+2QmC
	 pJ0ESW2sCqUS2r51V0ZDmW3kKjpqtaY1702xnGBPniNyiyr2vxOucZQl4YclqsjvghhBL
	 vcBYWkCX3e8a3zPSNEL/pWnZshz777fatEapJdX60yoaXMLi4NMGDjx1LRQ/TnVgkvqqu
	 bmystCynsHy/iTdqMgtniW1zyQwm4tK1LJDkKoKPnIZ6A+7wp73iEYPgkWkwS5nMrFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795135830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=4pQ/jBdCGos9KDlJt1J2TDwopdBtnvMOQDgM0Dw4Uoc=;
	b=g9tns4Q9SjWNFpDP+FINzY6K7bn55XRWQfy21VSab43NCAKMTLupyd6TNlDOHg7J7WQK
	 oZMd24kyydxdDkYXiXH+8ihY1WxzfIVjS5pSuDsGo1woZJyrjytdRByPO3jW5MSJ/l/pJ
	 fz5zSshfxo4PErWQBVlI+Msr37JQO+mrOhFECjgwJtR4wf6YYmMAQLEwZ+xSP63hqX4tV
	 t+c5vOKlvD9hyjWXcmFGrYuga2njasNpV8C7/lG4p4j/F3hnqJMzy0pCsRgLwIj6/pna/
	 pohaBFNfynKZVhwHQelAMG/DQRgXu9RAem9bi7bq6/7z6E8s90welasUy2Tl34Jgjlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AtGdGmCq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE467606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE467606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AtGdGmCq
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7d2d18f1bf5so262493137.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:50:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795135829; cv=none;
        d=google.com; s=arc-20260327;
        b=l6v93Mgd4E0zeU8pp2FoOKgDMmuHN1zGCKN/Aok9QIEWnP+vTYH5AfhNRgrdKHzWLm
         KCm++387SZBzIRrRKj4VbPlPazXu0wmthe2OVPGysvQj/qv/W1qT4hfyiPVyuI6s12tb
         ijAmGo0N4cvAo1wN3MuIG+ogmhTXjEcCWMU5UcwNZbBcsgu3384kKKERyy/tQukZDWmJ
         NwRMjAoa6R6bktLsto0TzQ+2XjBCYs/0GHcDZJWYdGvhBdllOKoDYIGvJ6Vhm2A/K1Rs
         2fvv+dsVPglLSopgqZEemS+5d+Kj6vBcULOpIk0x08OC89QyLMEcL6X9eTLHaK9xAKRl
         L+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4pQ/jBdCGos9KDlJt1J2TDwopdBtnvMOQDgM0Dw4Uoc=;
        fh=desM6ezWFqXx1Rh0Tq7G+4AH3fTzXbzS274tcGaQX6A=;
        b=eF262gd8lWj1EMw8DQdHyayhmLz2ZNVXPwx0zjiLYgEcOWyaTZUUrdW9Xso/ow4AnC
         NZ5Iyk5XtKkesCjHGdLTtLa4omLJQEYx65gcKMrM53jihKZSKR5RgAUIwkKNLDTiGGp8
         MPQwIQrOG5oeMCjBKkD1+6d38tBU6w32kVNBjXXyjSBajK1C5+ncan4g/x3kG0AiW1Da
         wHNKK8AuTpAfywdN9B2SDM0Cq1hZtJPDHp3uzNpgJj7p60NIzm3tAgbLbOxSLirrEIJq
         rF6gb/zw2JGxIh0Z72LLUFtU8GalCzYA0b6/oJ0UjZYyQmemEJD0k8I7F57g/J5puIcp
         ss/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795135829; x=1795740629; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4pQ/jBdCGos9KDlJt1J2TDwopdBtnvMOQDgM0Dw4Uoc=;
        b=AtGdGmCqYWoBagnroC2kHC0RNlIUQFcdGwFSfIhmpAOpSH7S9OzAMR0o0dof16ztpp
         XdEGWoEjYwLoudW4mOupNda2yO2gEZ3dC1vzTXaIBC9Ve/A9Wqo4Gm211szeC/e4fJwz
         xa+H67uKRR+3CvqeVV7bX/ZMWcU2pei4vqImjg5FQJ0VmhYJo1ICNX/BU0AeVCPlYlJO
         hLTboBdfqd5nAnzWH/gwtY6OM/kQXnhwrttMbfXUlor4OKXg4BHgB+9TdJB47/JiiQFm
         LcugDJtKsfoJE6dieQvhm4pB6dPV0dc06673o4joi1IGbyHOycbQkiF4aEQO4hF9HFr9
         +/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795135829; x=1795740629;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4pQ/jBdCGos9KDlJt1J2TDwopdBtnvMOQDgM0Dw4Uoc=;
        b=trzMBh/Kr/np9NIf9clkAtGzzgtID1Lm/Pn5Z7bpMYcVYXYuL+SnYDKTp63HnO3B1R
         DAdE5bZoPkswdheJ8KE8HLVAHK91K8wbdQpSbpTJI1+eLi+y/Y9BwY+z3RWoipS0H+NJ
         wcrm9bx2Jst585h7M7I4rZ2tEEKBUPY25gBywx8NtW7kI2sJnGR6aFkVG60WReTYxyn4
         xG73428gdElCWbIuRzGCtSOwZ26Mg/0+WSdplv+e0Qa4h3RDZK9d9caCwRbFAQav693p
         G8C132eukmiYKxSWW6q+mrNt2XZOGkOu0TkA4bVrYe4mk/+QzVtjpBi9Ehzhn9dDvPOz
         o9JQ==
X-Forwarded-Encrypted: i=1; AL+hErFktrWMNzsBJvKo3xgzRrha3DGQ0qsXkYM2kLsOQKbGxyk8kTM9BUqgIpnSxNcgd5OUN8CCOIo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0ZY+AxnFYYoYWlTmTqP6AphdHs/THjkJ+8gv3WDR6bFS2jnNh
	ZbLyLJCRLSR7kMM+wPw40zqEUWc6YDhHlpcax0iuebfOjAO4lVviXznBOVaRCnZtLAssYZcvZa/
	sgBLM44LmSmpQt85J0fC0QIujUuvnqeE=
X-Gm-Gg: AYBFou1byEZkijqcqixd75hzceqMysxkN9R/IltOiupKTNafxc/6Fp5NqvkQWTrk73o
	W9ZEi/xewdykM30rajeaQxLCgJaGwEeXJtXth9Cdon7IF29WqIWKv1jeLuU14wQAzAOfPhZtG6t
	N+xNchwsAnjJDmE92LCFHbKN+iYEgzc7K+dlnjVtvVFJWH3ZDAwvEoULiIoV8oSifo8OmfSyis/
	YRQqOc5U1Hs4NFAo2qD2EmZdWUoAgCPoKag2w2tKMj+VLSBAUCL/0phu2uyRXEua3PJGu+yy4xl
	qjkBTvS99ZRnDvy3HkFMcnExtVtPFkA9yzkBd/XOaHlOEQAWWKnqINpcr4wGbOFmxPF6+Fsaoif
	P7GJpfyhmiJHGITLEQG9Cs9wUQNSknI1Ac8/tWBCHIEu/GMWaI8IPOxjo0bXbbvbLtmYJqKfTLl
	W22HTKbzGBnLSd555huSJwjoHEpsxnzzdjVRlTdayNBuDmgHk5HjrCXgEqXs2AbJtcoT6biWQJ8
	5u2sA1bHZuzbdR0SRy8rJbWQeZC0GVB/qQTdfduhA==
X-Received: by 2002:a05:6102:441a:b0:7c3:f36:c7b with SMTP id
 ada2fe7eead31-7d739460f73mr627739137.14.1795135828903; Thu, 19 Nov 2026
 16:50:28 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930-b4-elan2514-irq-route-v1-1-44671bf01d05@gmail.com> <75148n0r-r943-9304-n194-r66rnnq660s5@xreary.bet>
In-Reply-To: <75148n0r-r943-9304-n194-r66rnnq660s5@xreary.bet>
From: Waqar Gulzar <iamwaqargulzar@gmail.com>
Date: Fri, 20 Nov 2026 05:50:17 +0500
X-Gm-Features: Aa3M54rs1VLWPrHj2w7hmXHghKJVCZNUY4vPO1mwF8EQIcxkzA7-LKDhDSyrkzY
Message-ID: <CADeB2Yom5E_0MwW=9i6RATAEFBmO+Q+ygR9efN84S1mtKVcE6w@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid-acpi: restore touchscreen IRQ routing on HP
 OmniBook X Flip 16
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Nov 2026 at 01:45, Jiri Kosina <jikos@kernel.org> wrote:
> Applied to hid.git#for-7.4/upstream-fixes, sorry for the delay.

Thanks, Jiri!

Waqar
