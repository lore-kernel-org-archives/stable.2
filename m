Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E46946AA9B
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546090; cv=pass; b=e8cf7F04Z/5BGmBsh0MioGIfl6XOG2a/NREqwUbI2TLPloMmeWHJX9w/8r8QGoOKDW1J4dzgdxpcdqrmVJl9JOMaU7uQYlFTLsc9sMyxGNGgUSQxYKLR4sFyrhtJExagJ6E9RZCVq/mQkGGDNe/NQMs9uQ6BHLnlpiEIsH8fTSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546090; c=relaxed/simple;
	bh=KyRouPkzlT8rYZU1MroXIcZmKsT6ZyhKSTMgIpK8nEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aarj4xg7ZxWnWEBNuWjzFI/0spdfdtRAshQRsv15WJLKO2SHj6CW0KOmwgwexNK2IXFFGWYe+/7jxaiiqwDluPpJV9k+KXnz5xuT7HH90Gm3hBmmoZ+eGGA29TYSVkqbnNGLHIMqOROjeVwYsrB5/m+Cvrnl2ZcNVHX7QBd3PCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tOokjULn; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOokjULn"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1111224b3a.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 07:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786546080; cv=none;
        d=google.com; s=arc-20260327;
        b=qZ4/27oLZMGt6JIs7iFYEZkO77DbaURVb49L1q17NvXItUGy4xYHqDZS99LnkrvYY3
         OMBdfWiyKFFlHpqtDPtSWv+Tzip5+t9sFyVBXFdjZtOUs5jFtm+F8pPWn7HWAEFEpICR
         lmfVRAf936sJjOUNwIRVJdyKz7e+1WY7q+dlInJYaNPAdJPpPI9RJgK759mRc2oCzlAz
         GjCJ4ghZ6Q6lSPzsjC7sIXFfTpTjYlySdj5vzU5zZrJgd50g2BNxf93xZ7S2v9oDdgLr
         Pa+ZB0ih4RpGfHncrn5H+aV4kSp/kOLcrLgT0MCY/JW8/4W9u2mqHZVt6fup52usSsEm
         Svew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ly+eS6auCcsMiu+Z/Trwar5yfkD4ejbCJRhO7pUpTkI=;
        fh=iACC9asQbg/zf5H02igSMmn9jDvQlaN4R0/K23i5fPc=;
        b=NTLVAT0Viy9rPtEmYZg9Fp+3kxxFNGYpLW5FkrI3OloVbaXxHDXU6/0u8IXY/mncDK
         YOawVfdo/wMCpGSsRR2ZY+tJ5L9WiEmU7lK5t9Sx/7pkJZmBn8LtUICxla0oVVx1eRVY
         meHsg7zrO91qT5f0196IAJsCRNdYLDNsryZRNPPq1OZxynuY9T8mIRP1uVEbYKEhEVyt
         2hr9gwz+EIXT0w/f7TdG0bEWJ6Q0JEAcFgqU/uR10XSC3M95vPGYRefHrFOgHdv1LgQW
         VOxQ/se+pLjSsEtg1KGTPcMAygsdpZVp5TfEtCXEOPlhZxhaoGFe0jGWodICuQCUNBu6
         SM2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786546080; x=1787150880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ly+eS6auCcsMiu+Z/Trwar5yfkD4ejbCJRhO7pUpTkI=;
        b=tOokjULnNcr4Ed9FT4AqazHaCobmqCpKd5jb+/xlhQf68+42WfQ8SK+knYK7S3TKer
         ZLLLI6e7uqaU5fJm8SXwZ8j0xToyb2H/lajOXV5xZ1kmrW8NjLDQ9EgCQsabyGA1KIwG
         Chs0jT43SwCUKpcN3Soooq2gkFWMBWEh7uc5RuXtH+6ueTY1ngB3KFKWgCsj23SE17A3
         /otOLJeoAIIRoHKa2XYECBkHRnnTIGwiopQmnmCFq1OSd+eXlnFziZmDXGR6sFVp7/xz
         f+nA5ZF/Jadkd/BYFDzbaUSM+ta6GoLT3x41B9w7Dqso3ogDM6U8dK3kOjSCLOU9gpHJ
         4rBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546080; x=1787150880;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ly+eS6auCcsMiu+Z/Trwar5yfkD4ejbCJRhO7pUpTkI=;
        b=phy2SuD6ri2eQ+FGB1Swj62TJo2Orqdv1Qc7D+ITlDlft1fCXhmOQ9uo1nWrIdaM1y
         KoptmDwXW0naH9h4UWPBe50MnWIsgkD7bYGMOWZA+1RxJCxO+aRiwoC+LUg7pPjka4jG
         H3HG53RgrdJcLreIFwnSffk4TGta8ZmsizaYLwGtldxsHZ4ZiZNbzjNIinVqhqb/fjUQ
         pIdLv3nkNfG08G74Pv85LdBfz7jzqvmil6roWpdlbKCUAMCzekbQErWP8upqHqAkwo5m
         ybVtmVSL+CIYeLJo0L/ZrpWaptV6BLU/r98b4t81PAXXmw5IDBIXmR/xAwl7vnkaloPg
         wtDA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5JcuhiQgT0rW+Bk65Q7iKeqMQq+g3Hy9P5REBOpwu4bPgNQS+gWxbbRKWPWaHyzbTo+pwBZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoCUPrJYWLt6yOjiDH/VX/yzFsizGXJwN3sVuKMXccQfDG3r4E
	d1QZosbLvcDCcb3TJSHcWSFQGeiOAPic1tYOSIZa8R59DTNZqizpSKQ408k+q16piHRmSVW8KzC
	22y+SPd4BnKJCpaaG0dz7mNCxs/xRTlk=
X-Gm-Gg: AR+sD10h8ULqkkwpk7IB5idi7qaTpLqGBm5+HoKs9rB/LFIp4Y7oI2F98xtCxJgLz1b
	B5BDSbLjhP4N2qduFhj1w13BUqlCZezzOY+6N/bVhhEtH6hIbghHDfTPauF6jUU4OojJYzMU/I6
	aZdjEd1oqwavEkHEK45DzuiyUTACwppWCQAGc96iQG1doVeBzl3ltgIY+QpxJVUC2QCK+ORZlH9
	9Z0HIFK4icOPLUDf7VTJIJW7Jec44Q5V80ZBnneIaXTeCxhpickwz6X2l/6AMSGBIi55ny9F+Ld
	t892G2881Z0MbClwHnMskn8L+6RI2d5j499eJDhAjNIYta5FqSAot1AH6DVdFwSEqsRBa78CUU9
	mmB8aqK4ITjYwgwiQq0jBXsQbhjpsgAJnXzss8cVCjD1V7xR3umsHOsouZiwTf9roz787p6/bkl
	9B
X-Received: by 2002:a05:6a00:ad8e:b0:837:f111:b70 with SMTP id
 d2e1a72fcca58-84faf9b9105mr10063380b3a.4.1786546080284; Wed, 12 Aug 2026
 07:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811152803.5629-1-a0yami@mailbox.org>
In-Reply-To: <20260811152803.5629-1-a0yami@mailbox.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 12 Aug 2026 10:47:48 -0400
X-Gm-Features: AUfX_mxOks_9sP1fncoI_F9OdQEsQZPYw2j_n0LrkRuaytrYSKObi2_mPZBuwv4
Message-ID: <CADvbK_cop11Jju3TBE58-tG5OhY4AsZMvCEFC8Neh=rjF-rTsw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: clear new_transport when removing a peer
To: Qing Ming <a0yami@mailbox.org>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Michio Honda <micchie@sfc.wide.ad.jp>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 11:28=E2=80=AFAM Qing Ming <a0yami@mailbox.org> wro=
te:
>
> sctp_process_asconf_param() stores a newly added peer transport in
> asoc->new_transport. After all parameters in the ASCONF chunk have been
> processed, sctp_sf_do_asconf() uses this pointer to send a HEARTBEAT to t=
he
> new transport.
>
> An authenticated ASCONF from a remote SCTP peer can add a transport and
> remove it again with a wildcard DEL-IP parameter in the same chunk. The
> wildcard deletion preserves the transport on which the ASCONF arrived, bu=
t
> removes the newly added transport through
> sctp_assoc_del_nonprimary_peers(). The removal does not clear
> asoc->new_transport, leaving it pointing to the removed transport.
>
> sctp_sf_do_asconf() then creates a HEARTBEAT whose chunk->transport point=
s
> to the removed transport without holding a transport reference. During
> local address replacement, src_out_of_asoc_ok keeps this HEARTBEAT on
> control_chunk_list. After the transport is freed by RCU, a successful
> ASCONF_ACK for the replacement address releases the queued HEARTBEAT and
> sctp_outq_select_transport() reads the freed transport's state.
>
> The issue was found during a static audit of SCTP objects. With an
> authenticated peer, the reproducer triggered the same KASAN report in 2
> of 2 unpatched runs on a KASAN-enabled netdev/main kernel:
>
>   BUG: KASAN: slab-use-after-free in sctp_outq_select_transport
>   Read of size 4 at addr ffff88800b9bd95c by task python3/197
>
>   Call Trace:
>    sctp_outq_select_transport+0x549/0x8b0 [sctp]
>    sctp_outq_flush+0x306/0x2c60 [sctp]
>    sctp_transport_immediate_rtx+0xaf/0x260 [sctp]
>    sctp_process_asconf_ack+0xa48/0xf70 [sctp]
>
>   Allocated by task 197:
>    sctp_transport_new+0x68/0x650 [sctp]
>    sctp_assoc_add_peer+0x258/0x12a0 [sctp]
>    sctp_process_asconf+0x5e9/0x1090 [sctp]
>
>   Last potentially related work creation:
>    __call_rcu_common.constprop.0+0x77/0xb70
>    sctp_assoc_del_nonprimary_peers+0x7c/0xd0 [sctp]
>    sctp_process_asconf+0xd9c/0x1090 [sctp]
>
> The first invalid access was a four-byte read of transport->state at
> net/sctp/outqueue.c:833. The same reproducer completed the full
> authenticated ASCONF and local-address replacement sequence with this
> change without a KASAN report or oops.
>
> Clear new_transport when its peer is removed, before it can be used to
> create the HEARTBEAT.
>
> Fixes: 6af29ccc223b ("sctp: Bundle HEAERTBEAT into ASCONF_ACK")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Qing Ming <a0yami@mailbox.org>

Acked-by: Xin Long <lucien.xin@gmail.com>
