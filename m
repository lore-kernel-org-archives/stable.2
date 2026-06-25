Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868C3C2BA4
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382049; cv=none; b=Un8JCFAsQrQwWMLt7QCi2HxtiRwK5Z/3xR7FnV5rRD2HgPNuWhj6KOJPQQE4fc8bCqj95AaXwEwTSS4W5xEFxmmLeQyq9t1JBcu8rU1uE5tdGYWmYxId0BNYimLhEfG4r53/dXDJemR/sFAqAlDdqfPeDmcqaLQ1/w9CZAbnb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382049; c=relaxed/simple;
	bh=JRKcCwku1VbtJJEhFhz+Kf1u5xuWM/axT/2vwJWLaos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvDKRu8ESkpfR8UL3dn9bT+MIrHWmOTDdv7fWSfZSnro0p9S5ao7QAwmS0LFxnl1hZ9abemAssoxXY9HxfQwyAeFCSO3tPBKqRt8PhB/nulI864MuHfY9NG+wfrTv/d6Bvl/SCyt3iYD6amgQeg8ixf+zcvj8xQyvxakhQLqk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2x/0XO1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2x/0XO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AF91F01561
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782382048;
	bh=JRKcCwku1VbtJJEhFhz+Kf1u5xuWM/axT/2vwJWLaos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=o2x/0XO1xrRvf319YAiLAVMBX4BXD1ncJXyBMYgfFq4a0w4pQnpJ5bgMTXs3J27/n
	 FTtTRqrTi4lTZNpt8p4+X4HLj0iVvwKzZ7JXa92i2mNgbMoRWQU5TBpmB+35IdeNSY
	 lI+GaaarnUhFjjUdr2eIIjb1qsDlEvSkR5Xt+0wvIp7LeZRKxZiuZc9MOyLnOmd7we
	 HaETwwRJkf9H2RrWj4ZrbIW7soSd2dKY+96Vsz1+Na97Z3YOTVRFY7iG9R3ojDkjWi
	 rftx81cOqv4cUO8si2SBFX02bEbR5ZYU1r2FZ4devdrmhZPxX2UpkTmA4uGTwyOmk+
	 8X8oxlBL5t8mg==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91562bf6c12so197184185a.2
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 03:07:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ88nEG9nPm7ZbPBSXo3He4PlfNFou7qq2DpnbKCRz9WN95hsCT3WS54SIX5T1N0+QStKRH0f7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw76KY9Mn93QjiZBCm/md/6duNXgUxA9to47iT5k7MbSeJItu1w
	DXm2se2fiECPotP6/lR6vCK/W8uzNb8UOUB0utonHQ6ncjbQ33l68BcgA/nVKQQ3at9hEJY2wh4
	+MdD2TSWg3YfpjiUnpAkCrwkIX6m94ug=
X-Received: by 2002:a05:620a:1720:b0:920:56af:cef2 with SMTP id
 af79cd13be357-9293af9a8e7mr225785685a.25.1782382047433; Thu, 25 Jun 2026
 03:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623024237.45990-1-qi.zheng@linux.dev> <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
 <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev> <8a76aefd-629c-41f3-b365-aefd4cc1411e@kernel.org>
 <7946da94-dc1d-4cf2-986e-466c378665b6@linux.dev> <dfe5d773-2992-448b-a6cb-ef633714a08f@kernel.org>
 <1d638906-6d64-4e57-a181-4b77683652b5@linux.dev> <b5c85cea-5daa-4690-ac41-a6f5aebd1555@kernel.org>
 <f18bf1b1-ccf7-4d77-9389-07311d2d1613@linux.dev>
In-Reply-To: <f18bf1b1-ccf7-4d77-9389-07311d2d1613@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Thu, 25 Jun 2026 18:07:15 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zwyaOtNkk8Xgqc3rNNE23XbU-kCB8oULqdGhpMERPsug@mail.gmail.com>
X-Gm-Features: AVVi8Cds3hyjYY1EEWV4vTH8VzylNNkIBPvgwWgSkKxNrZ0vwSNhmCzbjB5L9p8
Message-ID: <CAGsJ_4zwyaOtNkk8Xgqc3rNNE23XbU-kCB8oULqdGhpMERPsug@mail.gmail.com>
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg reparenting
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Harry Yoo <harry@kernel.org>, akpm@linux-foundation.org, david@kernel.org, 
	kasong@tencent.com, shakeel.butt@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org, 
	muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, 
	roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 2:11=E2=80=AFPM Qi Zheng <qi.zheng@linux.dev> wrote=
:

[...]
> >>
> >> Does this make sense?
> >
> > Yes, looks good to me!
>
> OK, this sync method makes more sense as it doesn't require adding a
> new lrugen->reparente. I'll go with this method and update v3.
>
> Hi Barry and Baolin, what do you think? Since the sync method has been
> changed, I will temporarily drop your previous Reviewed-by tags in v3. ;)

Feel free to proceed with the new version and drop my tag :-)

Best Regards
Barry
