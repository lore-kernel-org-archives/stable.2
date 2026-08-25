Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821293D5222
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643871; cv=pass; b=r43UQxlKSQJ09LGTBNbkxEu3LpW9ZUaWgbV7ttCQTpAKKU7C96FwUxGdFNgZ1Zg1fPBJqZCOqtm6Ndy/1O1bezu8T1zbKEcwzG5KvD8HfNzy0VNfJPb75a5Ykz0v+54cK/p5jedV4F+7cs/SbvDhJiOjtSsQiuM+sqnqq26ID+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643871; c=relaxed/simple;
	bh=X04DIHMZxw6/5xtn5gumEmBjGtO0g/1ZdeYvU0NA1jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVHtcfnqb2YFcHZMcAJEM2K4tOZDqckiNHEuIeso46CrxF1FtqivnDUhKlJhkgasXSR27mlVImcBtuMkGSjDDnSVG75KSHIC43R5e6hrsVM2IRCbuMuX4ARWYyPLIOC1pHhXtHrwZdxs0EFbdUlknp+VGef1DV+0TUA1140f+nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOopyrHO; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOopyrHO"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c928bf172so32716131cf.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 00:44:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787643869; cv=none;
        d=google.com; s=arc-20260327;
        b=hTE0qSQKpN4SZ9vB+7I280ynHB4VSQDVw9ke7uMll4D78sdk4WHCk2JffBhRgOr+a7
         BcjciKOSGVXITx0TaW8OzwNJMiC1F34avA5atnkzF0xRDiGHxmme7GO4ZLnHQuCF2RiS
         HNDSKf00pMtACPb7VVgBL2Z/Hr51prsFEeRmvYoM8fvgRWxnzs3SXddM3kktGQI2Ldmd
         DPhZqlg8NXWztqRTcvkclUYdf28czs9xQN2EAcBavIn/DNMuTjX96e9qdvutXxxEZbD5
         PwTFoSsJ35nEJXYd4C1Qlp/qIMiEsHz+DQC/QyjnFCFnJ3gbdGl79JR7f71UaiaIWy3a
         +oUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=icSIZLjmkJhUkdPFsKLS4ShrJUnEK0Co35qci0jNz2c=;
        fh=SdMFuzpFNWi21EsOPdFY6g2FZkrJq+2AUbGa0XZKFEU=;
        b=cIlRCdA7ciM0OcwrONwXtSUFnHG6o8OwrY/eQZKoAcEKWoHZol7e4GRoeD7SBldq7h
         l0sieHBi8CcWy6KImrAZFZfUE3yGyO3SgudITXenTKphZ05W+Cy2jzwXuabTE9ahySlU
         wbXGnJTqtj3SyGuhWU9jjEjy64JiR0RCC1hmXGYV5HRUmeuQwwwLmv7nMRb4n2ka4s/X
         JGDpfZD/f9M+aiTwT3dKPt9gbW15Xo2YvhwaNqiLV/4SIBxaIc5cOuduyN2y1fOzZXiC
         qRlWJSc4XvcC6t61XeluK4ewowDGsuzwaEXZdkFE1gxub60zBkeF50CojvJVkRoIJAAJ
         ECaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787643869; x=1788248669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=icSIZLjmkJhUkdPFsKLS4ShrJUnEK0Co35qci0jNz2c=;
        b=sOopyrHOyJkRuIaWuQZ9hlyT5xTiuPC8iFLvpriJUBJnzvueHngMFl4SY4VK8sjCye
         uBxPlOuT8MQv6Z8Q5RuMkMHvwJ9jYWr2j2GAtX++k2vVtXh7LOHLHN3tE8iDrsdMJk84
         bq+jJZZRK+hVsQrv94RNXx7jSLtmPWsEsuX56EtGAqjr5qLmKtC8WVZ6FsVQJq6ASuEZ
         M2IF1JZhN8glAc4yCTJHmWvQ0h+ICAWDE4A3JwnezEdO7SQ7cvmuHf8RLSVyy+8WJEnu
         NTtyOQIFDClq3iRSqWojMydy2LfGdl4rJ/k23RjDQ3Bi9av9q4cBooyGUvZrmZqDrYT9
         mAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787643869; x=1788248669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=icSIZLjmkJhUkdPFsKLS4ShrJUnEK0Co35qci0jNz2c=;
        b=U+xwTXm/bVXShwuWAdR4rfWDZ+0cMzqweQG58V4hu6lNVq4T4Gq9vZN3CwfvHlxsaS
         cyvduQZEKIdpBkiBvQHI3wXoTC+y1dGY29vcUpBAV7fq69cZKD+YJ+42KjzIqSFvaI3E
         7FBXnqwUda2H69a4hJoIzkCMldFW5Eh2T/6KlDYVtN+NGmbLyHngePZsXOpDTldLYe3/
         MFb4ndCRn7sUI41CNM30lG44c9Dwds6AfmSzouuzsUuCpduaI2JHfcm00u0/Zbp5Nc4x
         54Z9hLU0u97ab5vaI4jkvvVN5x3nW1p6757T/RsoOCUHFixqg67gILpZa8SrH2gfoKZQ
         U86Q==
X-Forwarded-Encrypted: i=1; AHgh+RqYQr2uP1+hZGH6OjfCEfh/THmykgt+3HuncdGXFn4xKx9D8qW2PIGQsOaJr8RgSDlNvmX5VPw=@vger.kernel.org
X-Gm-Message-State: AFuF++kf+r1il7V6fY57MG4EDNTY6n/jlSaiXwK66ayO3Ja4/qGonfDq
	TDdKYf6s+yZk4B+Tyj3Mk0tab311awxXDf5Alem1g/OX9j6no6lYPQzbxNil/MDseA1K8Xdjj+l
	zys9qUvsXJA1kcU0Wk2g0415hWO7UtB84vv+fBGo2
X-Gm-Gg: AR+sD13KdEcrt678nbJF+NVSpA9Ar2k2kGLL4lb04K3fHk1cMdUBqUQXQzSOeAR2Fym
	Qb66EpnB2op2/XRF46mEsUgaRXDKFBTH/f/Vnhzj9cbSYurFoqPesfJy2iXOvYnlUzM8sVrhuLQ
	xmck/CaTSNgcWfcsuZKETNHj8FHa2ik7L2tHMQtwiHW35tnipDcsNDRn74tZ/K8+so8UlExHU2i
	epCySnlh7d1nrOHtcZ5YuJSAFLYtxf6c5kF7Nl3KXdQt9501pBUGICaf807zfcZ3TjKFIHL0G8r
	S9h6sS6dhJXLvWhpWocMynLo8h7m6ln/MLOahh7Od+XXpJ7lLbFA4rpDqe8WxGIeKb/we4pQBQO
	FFbpXe5ctpudt45dH/IWSJ+eLrf1Xacl/HB4owhSXEXiHAki1FXz9cQOr
X-Received: by 2002:a05:622a:4d03:b0:515:189c:e0f8 with SMTP id
 d75a77b69052e-52df573a231mr353332591cf.17.1787643868848; Tue, 25 Aug 2026
 00:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825072033.6921-1-a0yami@mailbox.org>
In-Reply-To: <20260825072033.6921-1-a0yami@mailbox.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Aug 2026 09:44:16 +0200
X-Gm-Features: AcwNN1V08EdLmukE1q3m4sOYEto-IGNkL2x9GXUdsJBRGl4YLU1wMSpMA79x4oo
Message-ID: <CANn89iJMhLgnMjhRp6RKBZxhAQrtWqJB9s7wNcshjJ3derCOdQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: fix AO info use-after-free in tcp_ao_connect_init()
To: Qing Ming <a0yami@mailbox.org>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 9:21=E2=80=AFAM Qing Ming <a0yami@mailbox.org> wrot=
e:
>
> tcp_v4_connect() adds a SYN-SENT socket to the ehash before calling
> tcp_connect().  If TCP-AO is configured, tcp_connect() first verifies tha=
t
> a key matches the peer and the bound device's current L3 master.
> tcp_ao_connect_init() later resolves the L3 master again and removes keys
> which do not match it.

...

> Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Qing Ming <a0yami@mailbox.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!
