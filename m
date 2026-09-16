Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9744AA03E
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551714; cv=pass; b=ReUXt8zeQ7fJt3SO0K7x3kBXg5lJGSP4gt15BXfVSBP5lLsgx6+iGnXBs7vEWnAVEKA2NtnllOK1Aub2E+WS5uUPriT/sByDSFI1XWOu5Mpko/HBP4Dr1B3c1TzNCAaF7MmY+egCZrP63fuzznCFqWzg/wAMhRveHUWlrr2jLuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551714; c=relaxed/simple;
	bh=dd0XjmXLbr6av17ldrfsndZXMA3/+aCy2CJ+JrZ60SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fS4Ch4c9pMA15QMWjozqq5qCMT+UW0TYBGTYhXlUhGOzmPte/KBki43fpIuFmGQRsHTTxvPDHOZsbNdwT5FVzMi+VW65igX/SPfqUNxN1kJH2zN+XUF+N7OzoPm00d4SHkDsal+BIqOgzpsXAsL315vpW5Iq/A/GoD+cRU/AgpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qQck2Eax; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQck2Eax"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939656ff6d9so70396485a.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 02:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789551701; cv=none;
        d=google.com; s=arc-20260327;
        b=hRK/FUVf/v+MKd6xe6miR0Wh+CPh7o3g69bTaQ8rQKcCOEBrU3KsUKv7wH3y5AmYR/
         YFbrPWdi+HH6yOmUuFZr3ASKgl64u5u4JmIgwre+GWRpYxa3r53mesJOJk0W9KLiWyoZ
         7Yu/8KhTpwbowjOWL6evkZdUy9+kGMxgTxiV9gB3XJWrPp6jc8ySciUNFw+KiLYjabMP
         o9x234HDKcHsV5jtfP0t1jqxtKPcDq21YOiYxXl8H83Y37HSiO5FoqM+3UgyHgQF2890
         t6/UaLfMPvCYVwJoNda9BUKvR4IkC2zYjxTG4hlXaOBL3UP0+NsXTO8tr5vBpOnQorzs
         MIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dd0XjmXLbr6av17ldrfsndZXMA3/+aCy2CJ+JrZ60SY=;
        fh=WWteTVWQDubxld1jGtcx6+dm64KqUkFc1mlUCc35VpQ=;
        b=P6fkZY6VXwwbjHM9jzYtTkEUzFkAppmHoU0B1sBOviH3unDu9Yl6Y6kbfcalWY13rw
         FdyjieLiQGv6V5P/Sb/Jxk9Xt5odLrMHHpjwH5r4F532PLY06NLsrSNnCBhN1Eqp1ZME
         rn7n7Zv4oJdepWG+45VJF7bRLL33QFjK4IQ0VNIsUHnhLk0TxQvp64mZyPKBsljvJEH6
         EDZSl5vHiuh9wHJUz1irw8jRfhCJTsrd4OxleouEnuTRly4apdodDyiI9nT9Cdkcd13+
         SMAJkC9nSvltC6kELLySePuXXc8gXAJo2SJGxHJQq3SFrBildsvmzGeEb54ERnHO9eGe
         jUUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789551701; x=1790156501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dd0XjmXLbr6av17ldrfsndZXMA3/+aCy2CJ+JrZ60SY=;
        b=qQck2EaxCKi4Uv0sJjK3manqk1cVY7UTs+3b6Rg7JosOC0NAhCZTy3X2x9wUG0VV7Q
         WcNv/i/HyuUlGMTnc2y4LJEMccBKJsEiITHqf1vysluHNcpxRYbmligHei4FYY4IJIV/
         QAr5Af0qjKwl1UtvyZaLvQCUEcZ6CpiU0WxdoAXkDzkP9lS3eQXamwqkwX88tacqgAID
         7XoO/Fb5o4U/p7+Xna7qIIL9Pn3KoSnMxvsv5/ekXojPfgns+1kJxR6QNqKQX3PD8Kft
         9O9F5sxZF3abTKexlCbyDCQy0usdH+BmLkdq2dp+QZv8pbE6/+wIulSeb4BaD05Dwh6d
         oBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789551701; x=1790156501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dd0XjmXLbr6av17ldrfsndZXMA3/+aCy2CJ+JrZ60SY=;
        b=Vx8ryEJA7cDHdBlRxeDPjURNMjTjyD6LAMoVqBoX+FDN4vYABC6G3pH5amxF7Bu5xT
         NXOr6eSMYNzQSaW/CmmhrLOfUKCYf5BGMN7RqMyQt+6qLW5gOPBGRsh+/30QgpQgoM+W
         AqcVQT5wMhg5f/1UHvrw+nUGDxyCwVUBG3PSWrpe1dPDl3oYpz2I1Exdt/DCJQC/03iC
         GSwzbn0IzRvVX4ppIPteedPfDiElsIx8yXAXYC/0pAmCKx2yy3Y1plPQLv1cktt3mKf2
         NKS5gOcOyD1heNJ9kOlX6T9xmkbMaYnnSTltZytnhJ9pvozLyYY5fpRL8uyKM3Yw102T
         MYNA==
X-Forwarded-Encrypted: i=1; AKwUvBzitgBhHF7HhoPsmgKaFGAGAwn+TKjQ8EjlgZzGlpFkuzOLiKPQuvr7kmUK+0u5mdwKf8wotyo=@vger.kernel.org
X-Gm-Message-State: AFuF++lIom0WhAwAEnQwA4NAKoyJnxJDOpUbUIz5Axt3edCPRlDk10HY
	ccZnQlmE3PbQmhN2hfUxJC06N8BjSCZWauTNlvOx6eGR8gwj8qPdX8x5jIy1TIT4zFA70o608cM
	abDm+qOQotkQacW3l7eXfq68llr1UxsUISwdb3637
X-Gm-Gg: AYBFou3zeZ32S3K9PE0PhAZwv4GcjiRc8xdzQxB04eMdcRYWOxF9qXG6fk/7mU38jsI
	hKmLDNEEdmvvM3hwLP5/5YHsG2B+v2fKPbYi7rf7rWM+casskELDZ2Qfw1njne+xAAyaxTWNL9h
	a7zWERoKRJoKjOdYzpgF2HVoSo2dHnScThxlPxFSUUAP9mxq8ewn2uMgBS04sRdurquoS7u86Eb
	hT/n7z/ZsnZQHO+pLVaWWwhg5REBxNKoCGRL0zXzr2SEE8pEd3875gmTJNrDzSx7Mocc3qaEGUU
	oTurz0uqZIp9dQBPDcfW7v1NNcgh3nS8c1tyDi/6FeGIVE2XEs6D69cSOK8qVmDcBk0aM2PNbWi
	j9SJKqpocKJ89l1nmbDTNoWZBz0pR6CMBKevVfPG67qGlW3F38LddKWlNZsCUna7Hv14=
X-Received: by 2002:a05:620a:72d2:20b0:93b:c22a:e98a with SMTP id
 af79cd13be357-93bc22af796mr17857385a.2.1789551700440; Wed, 16 Sep 2026
 02:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916041102.1914333-1-xmei5@asu.edu> <CAPpSM+SpeOa5uo5rffXejDa4g9VGphp1GvirJgUWze-O+cQyzA@mail.gmail.com>
In-Reply-To: <CAPpSM+SpeOa5uo5rffXejDa4g9VGphp1GvirJgUWze-O+cQyzA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 16 Sep 2026 02:41:29 -0700
X-Gm-Features: AcwNN1UxUZyShrWWdOdzZP5TvGhMt62DuqGu9sAhw7uSD_TZmpKiYAfpJ3xalwE
Message-ID: <CANn89iJtyY_ooHfbqPw4=GVwXQeEc0k6RxS9dJGnA8TZgu8rSw@mail.gmail.com>
Subject: Re: [PATCH net] bpf: lwt: clear stale IP control block after pushing
 an encap header
To: Xiang Mei <xmei5@asu.edu>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+ff13a35f73bb7891@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:32=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:

>
> I just found Weiming post a patch solving same problem:
>
> https://lore.kernel.org/bpf/20260915170147.3943392-2-bestswngs@gmail.com/
>
> and that patch covers the cases I didn't consider so please ignore this p=
atch.

pw-bot: cr

Thanks.
