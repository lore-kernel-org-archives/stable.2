Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB894386575
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169399; cv=pass; b=lqcdrBohYK8Zzzdribq5GCnUiHkwcCpXuX19Nb8/NrggWKKGUx1GQimhtsqaemJ1Ot2kj58Cu1rzoEbsABSbzki40NVNKaFB+bqEVcZrqgt9fnE4VjovQH8V0tGwdV18YZMZ2ZwH8qQKXlnetXqjjdIfveeKnBbmWwpnJGJ8EoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169399; c=relaxed/simple;
	bh=yYRASoVkj8hdVAqGUL+43B00+jgnCtRcBZHHxUOgYoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnOG/AKhPmX0Cd245BcG2sXIIdUe5U20LjnNirHvGNcKqaAX2lRns5R2A409ZdYquBVwWYtP5UFk79V84Evjl4eETu9lx2hGv30dlee4oHv+8Yv0W7vNH548cqeSpZWvmOywqmTEYH4uv5p08uwS2MUAmYRxzm9iaMcXz9CRMZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvHAtR5I; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvHAtR5I"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c2808dbc3so20732591cf.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 09:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169396; cv=none;
        d=google.com; s=arc-20260327;
        b=dueGA6XjQbhfhVhB4Gp9dELgIafitCHJMGIcAQOo4mTVqu76/22/I/MHmS3JDDOQkV
         m5Six6l9NjxN4lX/2TpLQ845VC+KfQ6pbA2KkCS5iCHVlxC68vJglPae67OB4uTtA6Lf
         HpjCaX6hxepGADhkDioepnEwgsDu0KnO1xTrJ6FpXYM0TSOJjbuan/n3deF2VjDs6lo8
         pRltEK9XxIJCAnd70D9D0oycyM0i+6PMVFamRluDG1n+sOmzzfhqcFPVDpRx8JhNlXrl
         4fk8gAJZWYN0+eHlqfE0sfOQKZ6+QCPGUxqL4xW46/xdhJZykK6HoTANw/DyqVg/lSvj
         f17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n+6qpEF7FerlNezj1zDE8a3yg+4UnysbIHm+GwH3GYs=;
        fh=/S40xmmhbUNPoCok8MdlyyzoeTHc0ugCQLoGK4AMLzw=;
        b=jvRxLV3vuX2NZuPJC0PZ0FKVOinaCzh9kS7Cph57NgeBkcCoaoBUkiF12ncel9uqb0
         qw2rBNNCD6zH8Z3+8lNoQfWTTCI8Y+3veB8fWWh6GAiwZmMFOCb+5X3HVilRLZo1dUdk
         FbR3UsKtV1CZ+1i2/3/tgybF3IAAkUgpkP+dcsF3krDb/Evx3+GBAWPNCcyVf0FTT6Hr
         KXAEiudUPRHClyB+hggsK7WBP2a7lKuyUeY2nl7w9EHlDsmrbzObEnHw6U6TvZEOFt5d
         7LehTY2DShjyMacDMxTYLsIkURwK9CYUfkLx7wHiuxxfidNyHNR/NRow6lWMe9VIWPTi
         rTsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785169396; x=1785774196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n+6qpEF7FerlNezj1zDE8a3yg+4UnysbIHm+GwH3GYs=;
        b=TvHAtR5IIAhyFI1x7YJCPToCpKGvtKpyMm2ug8hXTC8LlwK0TTV1jNXWc4FV80yE4O
         jnLGh/rhL6IlCx3yYBdMv4C79nnAaqSL5+OWl6iPnQuzcsAlqRPPdwM60hmh9icRPX0c
         Ueyx4JSA4HVTHnyE2CojeGuL1gnut70ukzmNZLmkdyVPDbFLVTrgC1jLlkPMKSMpchNK
         BDqTV5UpNqNEYRzM4dwgeCN+JUML+oMBt7aXt+qoJW5zGk5cicYLz7wjdP3RXZDCKXvo
         zBfex+ETOebi/9+XdBe5hAfDIBVe0A4Zz/TLor+R5dYLEOGplBn/ygaOI75HX2gfBmDf
         YdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169396; x=1785774196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n+6qpEF7FerlNezj1zDE8a3yg+4UnysbIHm+GwH3GYs=;
        b=MvK1RjbbZlendwOGavHd0KISwAseuSs7eqhQyLoNrqbNdGvGzRhTQraLbw8a5nlzDH
         Pc9OSRpHaTlmzF0BYC0r6h0yYUmJutG+ULUOahVZmfxffiMeRqyUjXs87PLfDnjr6rxN
         OrnGGHr6QbmkFXXP6rWPzM1gAFuksLuFFaneS/mOiRJbhTJqAtm9wlys6ZXlp9xpFu8J
         gxmFTo4sYjx128W3TG5l6DT5G0e3V4HfgWMqv8TTNGN9lvixxD5uU1omWgZXkoQpvqn8
         PP8+MxXO6B2DZLGS4DN26TBz0UuGIt9PI+9kZfixAQ3SEomCX/ETbPt5DdewnUhqM8P+
         hwQA==
X-Forwarded-Encrypted: i=1; AHgh+RqJkjgJvxpS95hud8eRbKZAgC2r32EgiV81QF/vPLo9Oex5+8GuV8kt/GdUeZpTd6/zI5cNSL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Yvf8wAEzuxGrKx407njwFI84Mrzh5WuLK3CjIyL0YKDMUJgO
	JGcJiuVaNoeHoOFgXo6zcBfZ0+StyKub86Cu6Uy/6enfKyhJcXekNX9VI53jKFF+u0r2cb4LOYl
	v7ptP4z7zFA39wGTXA+F/6B6Uamndhfu9ZDlIqPp/
X-Gm-Gg: AR+sD12MnkRHCaz1jRAJQOM0IkkH2h5udGdOfSyMJ2mEoCJU1grdWSa4AUYuAhdoeuB
	D9Na51k1O2hl9SZNpJTvfTKT41i1wKJ331mvrNb17+OeDSCswnrfCeb576n32L2CL0whNfLugi3
	VOjO1DLlzoihvGtZPVGKTxWEyO+m2zhnep+6Rt1mWb8TsBdSAXhZx9bjMWBnR6W4727eB0NmM2y
	gi5ySVFX5mNZ5p1GBnEQfJa0auYzpm3uDcD+exGvvLP8QQZWsqf7mdH7gEcD8UJD/YAidfQd4At
	kXrlHChBMgk8ABIHO1LKkPdBBQ/yy/9uuweLci/QprgLCcsoVlNNPGk87IBtQSRJQM9Snsbh
X-Received: by 2002:a05:622a:6094:b0:51c:c6c:9d65 with SMTP id
 d75a77b69052e-529d17183a2mr2551161cf.1.1785169395691; Mon, 27 Jul 2026
 09:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727153936.28944-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260727153936.28944-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Jul 2026 18:23:04 +0200
X-Gm-Features: AUfX_myp0M31i5POJqgwIBmicFeDvDah0ZwNODRaGRtohglf96SONtod1CL6a4Q
Message-ID: <CANn89i+g1sjqLFCK=Ro3_rGobUAVnzc37JG8_UCLjoW4EOS=cw@mail.gmail.com>
Subject: Re: [PATCH net] inet_diag: make bytecode audit O(n) to prevent CPU DoS
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, 
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:39=E2=80=AFPM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> inet_diag: make bytecode audit O(n) to prevent CPU DoS
>
> inet_diag_bc_audit() validates the user-supplied INET_DIAG_REQ_BYTECODE
> filter of a SOCK_DIAG dump request.  It runs synchronously in the sender'=
s
> sendmsg() at dump start, before any socket is iterated.
>
> The audit's outer loop walks one opcode per iteration following the
> yes-chain, and for every non-NOP opcode whose 'no' branch stays inside th=
e
> buffer it calls valid_cc(bytecode, bytecode_len, len - op->no).  valid_cc=
()
> re-walks the bytecode from offset 0 following yes-jumps until it reaches
> the target offset.  This is O(n) per opcode, nested inside the O(n) outer
> loop, making the whole audit O(n^2) in the bytecode length.
>
> NETLINK_SOCK_DIAG is reachable by unprivileged users (diag_nlsk is create=
d
> with NL_CFG_F_NONROOT_RECV, the SOCK_DIAG_BY_FAMILY dump path has no
> capability gate, and netlink_sendmsg skips the NL_CFG_F_NONROOT_SEND chec=
k
> when dst_portid =3D=3D 0 && dst_group =3D=3D 0).  The bytecode length is =
bounded
> only by the u16 nla_len cap (~64 KB), so a local unprivileged attacker ca=
n
> submit a ~64 KB bytecode of JMP ops {yes=3D4, no=3D4} that passes every
> validation check, is accepted, and forces ~n^2/2 (~1.3e8) inner iteration=
s
> per request, pinning a CPU for hundreds of milliseconds; concurrent
> requests pin all CPUs.  The burn happens at dump start, so it occurs even
> when zero sockets match.
>
> Replace the repeated from-start re-walk with a single-pass bitmap
> reachability check that preserves the exact semantics of valid_cc().
> Allocate one bit per 4-byte slot: when an opcode's 'no' branch targets an
> offset strictly inside the buffer (op->no < len), set the bit for that
> target; when the yes-chain later arrives at an offset, clear its bit
> (proving it is a reachable opcode boundary).  After the walk, any bit sti=
ll
> set marks a 'no' target the yes-chain never lands on -- i.e. it points
> mid-opcode or at an unreachable op -- which is exactly the condition
> valid_cc() rejected, so the audit returns -EINVAL.  Each opcode now does
> O(1) bitmap work, making the audit O(n).

Say no to kernel bloat.

If a use wants to eat cpu cycles, I see no reason to be nice.

We have generic ways to deal with this nowadays.

grep PREEMPT .config
