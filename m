Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1861B33BBC5
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788790629; cv=pass; b=YfqKoejoTDS3LcT51ZrudJLe92oj4tlrtAor9afrH4qt7U5E/I6tQ0vb4pBCoY2ClZh5JKFoO5g3yK22IOkt0O+rLOBC+oZxXe2yxnqgU8cVZwHBFHzQsYc84l4//ydWNMmnTfk42R2nzbmWz79FZM4gjQ3Y55xARZ0TYhrwZqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788790629; c=relaxed/simple;
	bh=r9qKwV0zAtN+2SVkQpm8iG2hqEmHFrMaHaQiAf5LRMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRIDiIn2NtcMVzH5qZFub/LUIKTmLScLFSVyeQnwf27lLdGhIBKK7wEPcBEmRi2+0bIS0fw0O4ey8QM+Lf9WBfcOjn+p/dEJk/KTvJ5ePeex1K265PPRJzrsmeOefF+hFjNZiu6+bGn/4LdlKH2eDofvvqDJzn6UMbIsr6xF4bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=kY7UBq1E; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="kY7UBq1E"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a1981228f8so29862211fa.1
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 07:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788790625; cv=none;
        d=google.com; s=arc-20260327;
        b=kA7RFdYw/WVXWnx0kMk6UxJ/CMiEVR3gB31ETXzJ9x+kfxK2MewADu5trf0K06MX74
         zCd1kU/uzhc7xTFqqLr4LdxevBRdGJp0Us1n47qwlBukRLIay/qUtpHLOHAJH4AknEbK
         imp4rotR2RUY4NBTo/Tk7KCr3ZjVeFig4HX9isoHgY+ERjPFgioE5lHALPte6CT3/6OJ
         fCG9b/dheUjRyODsAYDBQZ/KATdwHdsSiBaJftUHjKYR6MX5Vqmg7Ofd58yspFzltm1t
         nXShu2Emy4XQcSMmd65bwAnNmfAbzsdIlYnOAmMfiR+WIcdrcxpiA+k9em2WJXrhdoAu
         I/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V2WxJHHlkD8fUS255uW+8IwBMyK5/qJDdXTRBzJeCF8=;
        fh=+XDB5pxqQrxD3l6Uy68qeLrQScwabkTUESppwrr6sOg=;
        b=Jc3acTk9FXKN+0RCcW+wdeoH2GB0B8Wu6wULPnvXd8os4480Xxa7EgeeqMhruJW3AE
         m8Q7K4G24Icx3FKS+fg9enQ14D8RlKiaWNXcnTUfAjcKybmWkcEtFVWAvkWxWq8qMrcu
         JZJ4xY1myxgQVAxUHoLHstTrFGIUlvUBKOkWJmmG0s1jmeCF1ArE824H0rMGJxmwb0W9
         GuOzTYWn3cGab4XomfpRtqyXnE2WvSSZvfpPne0cC7jJQujRiXcHSBi9IY9uARzxnQ9d
         GFk8oq8J0zyN/f92eCXV+fepw1TPaZKyg6rdNHT8q0k5kdhmGWRo/hTvr/UJ/NDuNvxo
         9HPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788790625; x=1789395425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V2WxJHHlkD8fUS255uW+8IwBMyK5/qJDdXTRBzJeCF8=;
        b=kY7UBq1EB/j5MOJXO+63sSKGBKtvZfYjD8cWggylmec7OZ+HvHj4+NiXvhlMQLNibr
         AfFpYoe+n6War0K+6lmkIJgAKujfdo9cY0S1sp3pwkxyRZTEEuh62sBnfD+lOFWwjXt8
         APR9oo1mbn7WkPozSbAnxVGu5KkqmjOhU1kVOo47egQN8LPX/o2wTmFQ7qyeE9Q1GMYJ
         3AsDanjMElX+NEPMNf9qZzq0U7ccF/yUMDGQRTm8KD41K8VhVyO10Bl8Xvz8CA6/D7M1
         X7RP9vNImq0lWPj6Q2Lne6R3tPGfYECGDth8PFx+iIvUeTxcpRDQET+WydCyR2f3HHgt
         DSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788790625; x=1789395425;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2WxJHHlkD8fUS255uW+8IwBMyK5/qJDdXTRBzJeCF8=;
        b=H0Ps02LGFxeSI3Iz2QRwJAdc/0NTsaaUHtDIhkI8eGRzOWZkUNfcYwqjGGbTOz4T6E
         N5+KpXTGt+AMo2a7eZZdVimeWorYJ2HF7zQE1Fqr1USMvXFTzCJnR1mZeYHgp4tz+JCy
         fKpa+MC/l/dxs9P2r9rPfer4x6YOoowmNUVRWUJ6S20lV/Y8JsWKxmYS3J9dTOwFQr5p
         JW1sgzIg3JXkNNSy98ycdLK74iplJ11iKmtgGZYTsUzLBZ7/7Q2tSiGgZsNrBS7ivacm
         X8ss9pzed+pvfVWl8MR9u1+TWCsdvGiaht3vtDjdsz2CHVjSsWLfgWfkIABdjCkptmVj
         Mo/w==
X-Forwarded-Encrypted: i=1; AKwUvBwy/naoW3Ls5LmQsdB4+a8Gch5Y92hQgjOM5TvOm3L4u6U1vDOizkE6zvhsvDRSACQT4QMrwjs=@vger.kernel.org
X-Gm-Message-State: AFuF++lLrB9jAQ5SCfd2G45+B+Qs6Uv4mxksh4cZzb5mq71hgcsqfwwP
	5ftptyz72eUVIgR5RzbvbGLWi6NJi0Qci5sfvUaMmnOMH64tOskLk/PHfDyVfKhrxg31zWWDlKK
	D9fGzomcG7W+IPqoJ8ZtVj4+kKmnJhdvLTamoCIvj0sU=
X-Gm-Gg: AYBFou0AnFu8pkGotbuRmOUrq1G9sMSweYAqVokudra2DgeXONJhKPAxMIwXxJ/8aTs
	T6h2SNZuGqrCRuenUUU2795CfK26VaUq9l82mVEcsiN52tYKdYFQZWL7my5YQI6oLbzBw+/gHem
	LmIzierCVwtvkMG00b+NkD6kPAN3xb4wGE3xyMquC8IuTfyEOJ3MtNBwLeYxT5t6fVczFy+Z0o5
	OmCfAbRHjXURROCJlxfDWU9o4jJzDtH25fKIw7FpY8tIsaqR4z8jjKNhhcKbQAIwsjOtQNX0Fah
	sBexuaxIViTXfvLHTLJXwiDmraIbClc3kZsb9x/xLJ/j59hbY+rCNXkTgk6WRef0vVg4fA0vD2U
	=
X-Received: by 2002:a05:651c:a114:20b0:3a3:749e:31a2 with SMTP id
 38308e7fff4ca-3a3749e3344mr14616981fa.22.1788790624930; Mon, 07 Sep 2026
 07:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788775605.git.zihanx@nebusec.ai> <d1b0d3a224167afa0ee61db0c9f778a2d12ff9b6.1788775605.git.zihanx@nebusec.ai>
 <CANn89iJjUL9LJPipeCZKq3F=Rjhq-gdCKwnuW0pkvvpS_ai7UQ@mail.gmail.com>
In-Reply-To: <CANn89iJjUL9LJPipeCZKq3F=Rjhq-gdCKwnuW0pkvvpS_ai7UQ@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 7 Sep 2026 22:16:52 +0800
X-Gm-Features: AcwNN1U7aD2O-kbEJ_AiTgXWSyU09QYOnbLUYfF4yEMau5bpeNc0TtL7e78gZZI
Message-ID: <CAANe3eTxK3btTfTA9M0UVxJ3FOavnv3jgd3MUjLPoDNJMicg=A@mail.gmail.com>
Subject: Re: [PATCH net 1/1] inet_diag: cap bytecode filter complexity
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Vega <vega@nebusec.ai>, 
	Luxing Yin <root@tr0jan.top>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 10:11=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 7, 2026 at 3:53=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrote=
:
> >
> > inet_diag dumps run request-supplied bytecode through inet_diag_bc_sk()
> > while walking TCP, UDP and MPTCP hash buckets under their bucket locks.
> > The auditor currently accepts an arbitrarily long program, so a dump
> > can spend unbounded time in that locked section.
> >
> > That fact is already present at the git epoch: tcpdiag_bc_audit() had
> > no op cap, and tcpdiag_dump() ran the bytecode under the listener and
> > ehash locks. Later inet_diag extraction only moved the same code.
> >
> > ss(8) filters only need a handful of compare/host/mark operations.
> > Reject programs with more than 64 ops in inet_diag_bc_audit() so TCP,
> > UDP and MPTCP dumps share the same limit. 64 is a policy cap above a
> > normal ss(8) filter, not a lock-hold budget.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: LLM
> > Co-developed-by: Luxing Yin <root@tr0jan.top>
> > Signed-off-by: Luxing Yin <root@tr0jan.top>
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> >  net/ipv4/inet_diag.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> > index 34b77aa87d0a4..1ca528cd3e72b 100644
> > --- a/net/ipv4/inet_diag.c
> > +++ b/net/ipv4/inet_diag.c
> > @@ -725,6 +725,12 @@ static bool valid_cgroupcond(const struct inet_dia=
g_bc_op *op, int len,
> >  }
> >  #endif
> >
> > +/* ss(8) filters only need a handful of compare/host/mark ops.
> > + * Bound the program so dump walks cannot run an arbitrarily long
> > + * bytecode sequence under the socket hash bucket locks.
> > + */
> > +#define INET_DIAG_BC_MAX_OPS 64
>
> This is unacceptable.
>
> I am tempted to say that any hash bucket with more than 1000 sockets
> in it is a problem, not only for inet_diag.
>
> Since there is no soft lockup, this really looks like an attempt by AI
> to break legitimate Linux uses.
> (Or slow down as your prior versions did)

Thanks for the feedback.

We will drop this series.

Best regards,
Zihan
