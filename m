Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836E436353
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565959; cv=pass; b=L//fVgIrE5RODVKSO7TxnMCKCKB4/xkdwf+fWwFMG33kH21eX0ibVpnyHPlKDjKDEpr8TmpOZqo1FKDP6C/hHOGjAhB6IBa7soS4Wx5quf5uXYELG43WXf843hn058hNxMw5GEhyzdcYiHG/C+2U5oDmdvWAmtXpRFLLY3ZFthM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565959; c=relaxed/simple;
	bh=cLC8ot5pIh8dTgfPfSXv0InXlRDbr7JPQ3f53NKUd7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJpVieufe2mXNJQuDQwk9Tds7324D5mgyFnCRjGJ3zI7SkzB5ruHesmivtXQFa5yfhXokbmdZHB/EIhEc3/qwWwFHe+tAEPipVPCK8crhtSytwuMEhJyMIN0hoORIzSe/SnRqaAgDOdcwH/5h656pvuA0gIJdSIBW2Yv+scpbjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ef3RavDi; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ef3RavDi"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso100128336d6.3
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784565954; cv=none;
        d=google.com; s=arc-20260327;
        b=DHeF1BPBcxJdkHXFoRF3pTKdaECSpUQX0zzDbc88qUiYkmXHpnAaxFZKC4sCAHkMet
         zOJnLm89088bWCVldYHlZWJe8Y10Y59z1ujZjb3+ynczGvWHcivuhtL0eRPRdMZg4eYt
         zrt/FXTEgQuF4w/ZZMCdXQzRScGnzWwCMfsA6SztXolqDGbasfTO1o0APmtOiA27VIOm
         bxRjqHEj3Au5vIhzZjwWGWNA6ZtGNYXROPvVQh2S0tBCySY7BHzlobYdaQdRfFJ/vEf1
         0rcXf1a/+mF75amIr7XaHK5N950p/v7ixe2Esp9ow5twiTnViLKunlk6a4ThXSQ5N4yr
         XkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GdwLLcl2D8Tg+THUNONwAYfn4D48wOZssB4/wTdyRPc=;
        fh=zCz3GS23phOEBa9QymNvBBr+D5iIyiqb9Cfbhk5lvsg=;
        b=XnqGwEFB4SfNsw2XWV95eG/3z1hNrGbH5/uJUqVW1thrG/QeXKcHQGWsn1vQjhW+YF
         h2SjvY7pHpk71hpj62bip7lu3E39UsQTzEyBs2R8oiCAyCFnihVc1f60G9tcHDfBX0HC
         Ucaesc/q+SgK4ykqbJYh9bbAW1IgLk7skS2NQyoiKS6kpc/ZEdRhcsimnQGR4zhZbl5m
         uQV+4kLajOTxyGbc4sLkIKboFLUYRgarzNiwyMTRku3BEYMpF2+/vOkaIIlZafdYqNHZ
         ID62VP/M1ckFaZt9MDAYEECVBoiJqS0hfo3s65puwcASA56/nuis2IpuNP3m8L1BzRu6
         CIng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784565954; x=1785170754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GdwLLcl2D8Tg+THUNONwAYfn4D48wOZssB4/wTdyRPc=;
        b=ef3RavDi6HFd+z+zH3QM6jISvan9h8Cr2f6izcVbqNYfbAnOetyu0v5IroONtZSkFb
         6Dm1YbNLisFXUgR2i3tq6YdUpZE/oAUJUqApejLJD4uwHlEhbXSvaEJs6GXqSgYxhnsp
         PeKUQv/SVRwLZ1IKFIyRz6O8YMTtF70CjWZvEfo9nNC2dbNw4Mnpn72zXcc8XvL4ZyYM
         R5Mbmt34oYBt5MhCiH2uRbIzP8jE4DqtoPnNZJAnlW72gs/9SoceHOZsSa3YmWTx6oV0
         uxhxZk3q34YEK8JdrcVF9E8RIhGdD1uZ8GH4CDYFRuLy6DrW6FK/Uu23NZ2vSzDAx2TA
         114g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784565954; x=1785170754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GdwLLcl2D8Tg+THUNONwAYfn4D48wOZssB4/wTdyRPc=;
        b=GI1JRY7Wnvrv/tFZxWDC77V8RtEawJG2YcDsawk0M7roo2q7H/N+trQEkFTGQAO7Wr
         Cr8nBWalMUq5RUaNrm5s5Qbsx+ZB0cD9yhJbBZyNO6///Ybk5baHj+hl4lpHk7TqH+UE
         OZcB1cCZ6Qc0cbs4PDpqHJFsSXWA8QEbZRM3o72mNY2iY7+HmzJ+/72WVpJxPrh473Ub
         27fkLNCaJUnoHm5ydtOXQ5HgUHwtFvnYcWC4GLdkuHiRg2S0v36X3k9Ijl/LpgadDz71
         HG/8BGGeke2eFOLeiPOVnRNsUB5zfB8IHdHEx03xQScAG7DbdifZspWChXqmvqoGMWgG
         K4eA==
X-Forwarded-Encrypted: i=1; AHgh+RoNkqccXDtO3gJYfJbhwktTwtnEAuZZiczPkfpoQj8qfE6uenPiSpVCDmZifMC5n4G6uRFpPlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXurlBQQ4X87Dx3ByFyZU3ga9XUwQk2OOOkl3SFH5mlY73qYyD
	OpagaPFF9OgG/RHYTDFmFZmMrF6XtDYCuoPKd0qz6rQlhQ9/r4uQ8nlXEciidYvKkFS15F8sfBQ
	U1PGTKmRhYAg/MeFhf/cBM4ZSBDQtX5coL/2HUJdR
X-Gm-Gg: AfdE7cnQ3c6One6Alfefvjm88gjr7YY05QgBZv9FjKO8rJbugT6Fs0o3F4yofytionT
	V1ks5keHJ0HivoYn/F4/U6ZAGu+MusUBWHiDgDMM2vFNE4e5CgtKD2syiD/75QYJGfGHCdWAose
	ZHvrrHH7BuYm8+sC6SSlyGZlhOSnca2IRDsmZWRYpu0q3e+ZPHcHZKH1hjXK2ieapbwM7tgIR0S
	NHVo5GvrMhsTKqQEy8WkLPv2KFCHQL1FqI1ewPt9wwlfWB1ztbiIaXleqwp17As799jh3qV2UPQ
	0RVjBL+RxQBEHs9wYkz3BiWeYqGoafJSfZLNzcrzcHo5NnEUWuafqr1o0vIFG7Hjzunw9LlPIA=
	=
X-Received: by 2002:a05:620a:1a01:b0:92e:fe10:3ef4 with SMTP id
 af79cd13be357-930b416cd6cmr1462059285a.45.1784565953237; Mon, 20 Jul 2026
 09:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717081443.809393-1-yangyx22@mails.tsinghua.edu.cn> <20260717081443.809393-2-yangyx22@mails.tsinghua.edu.cn>
In-Reply-To: <20260717081443.809393-2-yangyx22@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Jul 2026 18:45:41 +0200
X-Gm-Features: AUfX_mx_QTBHnNcHo-EzNtIineQrXil4DzAF5RnVr3HpqgIh9UQ6m863CpRTp-A
Message-ID: <CANn89i+TBXezN9MMoUZbig3F8DK+J+-MN+P3F74V=v04CXMMMA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: challenge ACK for non-exact RST in SYN-RECEIVED
To: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org, yyxroy22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 10:15=E2=80=AFAM Yuxiang Yang
<yangyx22@mails.tsinghua.edu.cn> wrote:
>
> The SYN-RECEIVED request-socket path in tcp_check_req() accepts an
> in-window RST without requiring SEG.SEQ to exactly match RCV.NXT.  A
> non-exact RST therefore removes the request instead of eliciting a
> challenge ACK.
>
> RFC 9293 section 3.10.7.4 applies the RFC 5961 reset check in
> SYN-RECEIVED: an exact RST resets the connection, while a non-exact
> in-window RST must trigger a challenge ACK and be dropped.
>
> Apply that check before the ACK-field validation, following the RFC
> sequence-number, RST, then ACK processing order.  Factor the per-netns
> challenge ACK quota out of tcp_send_challenge_ack() so request sockets
> can share it.  Use the request socket's send_ack() callback and its own
> out-of-window ACK timestamp to send and rate-limit the response.
>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Fixes: 282f23c6ee34 ("tcp: implement RFC 5961 3.2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>

Note : Please do not add a Reported-by: Yuxiang Yang
<yangyx22@mails.tsinghua.edu.cn> if you are the patch author.

The amount of noise in this patch footer is quite annoying.

Reviewed-by: Eric Dumazet <edumazet@google.com>
