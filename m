Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5856C263F5D
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786504600; cv=pass; b=s9jYKh2R7YsEWqM7my7C1sapX40/EoMJavutpbkS9CFeC0uQ7H3fGEZx1Lly8Bpj/nRk4gwr5ve+kENe1QaZb1oQAEXV8H28Cdz6Bb3f3c4Fa3TR0M+PI2KSyp8lBvWhH0eWN/tEKuJfBJ0QPo7l1MgvKzzxESrmKzOE5ctTguw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786504600; c=relaxed/simple;
	bh=fxEQP1cB9k4Ugjie22mCjyQ9R2ddMIZJCRPxa8h2Vt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2qRPxRGOI4tSwvjunBTfuhAZj9iUA3867W6H3/lMUfC00GQAQfmNGRUQXYEMgEdQF6JzpqboaXubRFrAFwEQnA+aPD7w8wVV9V5pnLAaZnQVPvq61Kx6Yt0z5DWrjGM5eAfDSV4hUSAYC2+2pxYdIuyvoxIST14+o/D4p15/Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h87mnhxV; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h87mnhxV"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8485ef63b68so569355b3a.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 20:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786504599; cv=none;
        d=google.com; s=arc-20260327;
        b=bRB4MtR7OPxcVF6g5uLwyfZ8sAKrwfnAX0VcmhJ0TgCbX+vDo7CZMuWg8l1I9SsJP+
         Y+UhWSsF4ee2AqopCaqb9ilTCvcA6DBEAcUrwpau631mO2lAG006oKVedbbVkC7QJ3/Y
         8Q9WkgCMGk4Iw1iFSZxkCUQ8SyNS6180yUsW/9hqf6Dm6llC7c9Pw9NoV8TLfdh6iYzx
         feCdX92yauyIeBy0FwIumWLonesowiqUJNz63CcHKizsi3ABWM9Zi5q7gxh4dWJ1ZexE
         JyoPavLbvJKY8HCFOIwUg2d0TtiJYshGCcrxvRB4K2lysD7fvHRFk9vqbmkhfBGCTV1c
         jvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KoroZKDxIj4XxhgtnU5mE8RN0Po3//NZA/PtxjJGOqg=;
        fh=LqYRiVvWH0OAxcC19Bh5o25cd5pV1vOQBXXTCknzNTc=;
        b=mR/6YHKA4jZSOpJwvKkBrohVGQ2puBtZj6xwVxLAgcWk9oP+EI98G0Gp/CYsiT3FgW
         JigPHno5QNQ6W+Xd+LnEXrFI5E3VoTYezNFhMo8KkzEClVCVcOEMwTyK5OrdCgm1Nq0c
         /5KMT/CplfldBqQ9fBN0DFrp3eIB6lqM4JTOUf0k8NOGNAOufrqRbT+F0s1U+kSeVWCR
         Z5sut0xPEETcpQ79ZwQ6+KnX+C0bYiqdD977sWRh3fA0szYKydrBeKbc85+UYdX0/H+h
         nupx5g9CpkoqvPe7CDrz1o94prBVw0U19YDnnn4qObwYMv8c8b46KYXqmOiPRG0w22ax
         NlKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786504599; x=1787109399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KoroZKDxIj4XxhgtnU5mE8RN0Po3//NZA/PtxjJGOqg=;
        b=h87mnhxV0AvIijHhPyoFcXOwv5e3AqR9km0oPK4V+73ULTrF/QQVHHoJzSrHBkj4RH
         OSliRyBbubFD38PkfUSezefC0ja7MR7Vhhku60Cg5fAPnRdNtTUaG4V2irQlyj73rQQs
         i1c5BhtqXsEu6YpXejfwV2UQqe/16lwTFD9uJYme52qqWhvORtMRHtpYmjIC2Os9kLuX
         fkHJwkyf1Ds6Z3jdRP+XiyB64+8TwOo7ByZ4D2+CQCf3XyYvNelcmhWBYmISc9rGgdd5
         9o+a+uvq1RB4Qa7x/+ArudUAS9WoUyLNE5o/Ve170N2VKuOXW7XY9qGxqJe7f9QrWsxO
         D15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786504599; x=1787109399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoroZKDxIj4XxhgtnU5mE8RN0Po3//NZA/PtxjJGOqg=;
        b=F8ce1xS8ynASF/jZ4cnvDmLITkiOdlizthdiMqboPbPaXZdNSaxgCXveDYq3SK4XUD
         /SxBv+f/vgOUuQwHbg5+dxS7TM4tfMAzJfi/hE3LUEJzuO9/nBatniSKZ+m3aIMGmYYV
         01IbWQsmiLEwb9TZbX0q4/0T4I+xH3pTSm5DWIDx9zMZZlbPv9TbtIuy/OVdTtOU4HTR
         13kAcwr7d8QSlKYnqBsH3l0jW25eQs3ym4+rZH+SOmSMR2rURpd2E8Scsb2qACdNxOCA
         E6357p50UqemIgFQlz72MJfBGwB3E7QYmc+FPncApR/Jsn1GthNCtHPV1fXpBgB16R+w
         mJYA==
X-Forwarded-Encrypted: i=1; AHgh+RoFPW1FC8tUmR4HuEyWCPlk2DoxovG/CYYr40pFFPKDCjkV03ifHWHqS2gOP3pqQBUY7iUM5X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyObzK5/6F1n4cWqXGWmKS2fehCIbTU8qqTt3p9cOMjMHSmkJym
	rnUjqNjGMBUZypwX8ZsK+jINvJVOm/WKbVuFn1pd5ogVgguEpauxr6pjQ9Xadr1WCnX7z9KPmZn
	JHOQ00ld07OuS/vhqMQlO69De/Q44dXrEyE+E4SPg
X-Gm-Gg: AR+sD11PwHRSXNZ1/9QJYOuNDaRGBuOMUak56lIHS9hwinsWwjIbAj51iBaoQU0GvE6
	SHyTyT+SCY79URAGU2Z2/vx9sSgvgB2y3QCjN5f9XdWFNzgZsJ3z+O/gtE+yKCt1XmUMQvf0o1w
	u/cPYMj36JfqnDOOdMHd1ezfUiCWtnU29yNaVFxbyj1Cf36BBjByiwl/FY6bjRmZpxiaJGDIhTJ
	EKOgy+AdRzGaf2cPFUeBJkMFYwbzmJ6L8ZswDo42qAMKY2NFbYD/55PV8GhhZ1nEF2DZmX/YOAJ
	JZG9dTPxP9NbKp6rX/dNeFpNmpvTkaLnPcdevtZBzH+1NdrcGV60kbBmIY+v3GQOratlkgg07jk
	KXBjysDrp4Lf7WMWnJQ/uPzOZymNe1fynYdmrctWbeF0t07zE/2r+8GHILWg=
X-Received: by 2002:a05:6a21:a8f:b0:3bc:5284:4859 with SMTP id
 adf61e73a8af0-3cc3f5ebd53mr1827573637.13.1786504598065; Tue, 11 Aug 2026
 20:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811210925.1751466-1-ast@fiberby.net>
In-Reply-To: <20260811210925.1751466-1-ast@fiberby.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 11 Aug 2026 20:16:23 -0700
X-Gm-Features: AUfX_mzMg8OAlOzFZdoR67KtYST5Z3cNuYZyh3B59IA1f09HK50nGhqMl4SokMg
Message-ID: <CAAVpQUA6XWef=ra526WaBo4ft2=Q6Ovdwa_i_5C63TDKbh0bYQ@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: reset late connection after listening socket close
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kristian Nielsen <knielsen@knielsen-hq.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 2:10=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
>
> When __inet_inherit_port() returns -ENOENT, the new connection is
> dropped silently.
>
> In that case the client sees the connection as ESTABLISHED, however in
> tcp_v{4,6}_syn_recv_sock() the call to __inet_inherit_port() returns
> -ENOENT, and the new connection is dropped by put_and_exit.
>
> A client may therefore hang indefinitely on a blocking read() if the
> used data communication protocol is initiated by the server, like SMTP
> and the reporter[1]'s MariaDB protocol both are.
>
> Had the new connection been processed before the listening socket was
> closed, it would either have been added to the accept queue, or
> inet_csk_reqsk_queue_add() should have sent RST.
>
> The call to __inet_inherit_port() returns -ENOENT because
> inet_csk(sk)->icsk_bind_hash is NULL, after inet_put_port() has been
> called by tcp_set_state(sk, TCP_CLOSE).
>
> This patch adds -ENOENT handling to both __inet_inherit_port() call
> sites, and ensures that RST is sent before the connection is dropped.
>
> Reproducer:
>   https://files.fiberby.net/ast/2026/kernel/socket_teardown_test.c
>
> Reported-by: Kristian Nielsen <knielsen@knielsen-hq.org>
> Link: https://lore.kernel.org/87sf0ldk41.fsf@urd.knielsen-hq.org # [1]
> Fixes: c2f34a65a61c ("tcp/dccp: fix potential NULL deref in __inet_inheri=
t_port()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !
