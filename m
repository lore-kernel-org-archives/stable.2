Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241B37FF60
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789340894; cv=pass; b=sqkV5VKLxgoBTDYEPVwTtIt02Jx6tf+VYtlpJXosPOMycV1HCApeyA+fmdzdpQi+zHyy/RDuNZHpp8Ou6ZHVLK7iklsqs5W4NufTe1n4RajX5cxBc0ezLCuMAVOqX0GRs2oDoQLjGI4vRLD1H3nFdWVIjRVBjQewMN21Ef/VGFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789340894; c=relaxed/simple;
	bh=DXes9xsnyMTyzixU1rmSeIaBDLxOPxqOwPIfYET+/jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cE/1ZUrv1IThZsA1/gKOL4rW0S2SV7w7nfuf9XzHs/DEfenfpqGrsgvjKAiShkyroM6UfUFpTsJec0cHgnedRrBi5AkwFU7Smk89Gs4d9shvZ8tiglKU7N2RWlHrepiW0S8PDfHwRYrr/0q1qfRJ8IhRM9zgKpITf/NtBWSynrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hn5toEpe; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hn5toEpe"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530301ff353so15516891cf.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 16:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789340892; cv=none;
        d=google.com; s=arc-20260327;
        b=JcHZjnmWsWwUB0BiWyl+Aj8kOwYLD2q0/1zQUuWUZrDez+67E7ZpE3nvAyRgU6LesP
         4TtnCRyY9aKqIbQAunpouq6eX8GrNNepmMJZPb5WzJrSQsrMWTWUVrZt3dkItdoo9HM2
         RJMqQ99e3XD/vN4SvkoiyYZE+9fXi1ZbuRzLBtxtGmxrw2WUe1/XgiO2jZDyOL1qmuh8
         9OR/8QzZ2PR50fX8K/s/OzyINhVmFboCluXy2LKges86mm8P/YdpDmxl3m8VxpNu4Ui8
         p/P2L2kQ76hou5ZDZpNNse3Hr3dwv0msXJs6kzqMEqVGmzCYcQ+kkWDpXrRZqdbyRame
         xH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xRbG0DVQ5VHY3qqALlMkPrYtIobPfZTAAIFgs1QLm4A=;
        fh=bXwsnheXVFRrJmj8qDbWxSgv/0FBqkNUCFV8unbRBmM=;
        b=TVYmmIKLp6hvMI2gswgHyO0ghKPvyB+LMKz2oNfHi+LjRFuk1LCfym6DXJDmcCaIho
         9T2MnkRiNCiDF2J9XbxmdiXgkov7JsZkX0//J/QhOBDCJLiKLFDAqp5o5wiN60H5HqXT
         dA52yqngsLDPHr63DCtzpKWnENw/OEcLg7p04rqSWjHYSROAXveYVLxHGqpty/UT+FIe
         0y8aXqKZb24ZEY8Ckvc6TMvAv/sc/yfEps3zQtDBXB8n6IzssR2L46epGKWYzYUnwFJO
         QuFQTvQL6YEjYkP4nMS8Hk+Pz7TQIBRxpSAr+xv5+DDIz7NKjF/W6nUDvLdXq5ZxpxfL
         qU8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789340892; x=1789945692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xRbG0DVQ5VHY3qqALlMkPrYtIobPfZTAAIFgs1QLm4A=;
        b=Hn5toEpeGOh2oMptvnwj1kHad8duX7cPO3qapr2BUXzDQHXVeQLTmh1ePl60IcNJmI
         HRGPeHzYYIvlM8PxAkyAUROlq88FqZcpdWu+6vs2xojdeAS7dPFArBOwzBRjolze6b7b
         qewT+Ixx4cwK1+4CbT7iWxRBkvIhGlyiJrT/dTck2Qu2ew55i4W6Q7ssYHXXY8JxOjMu
         uIyjzb6RSajpfqpGiWr5Sb8guOcK/bbbOPSMd7FytKru3HHUoXLrBDnPXXytQE40KAl4
         bRoohPtYfPFOKsuSuIBS5gBnI4kyvqBLyNSrOLGITdViYTtE9QLtiq5QK/B4VN4nmgbL
         MlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789340892; x=1789945692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xRbG0DVQ5VHY3qqALlMkPrYtIobPfZTAAIFgs1QLm4A=;
        b=qBV3x1c51Tl/ZCnuft7/qD5FffzD62bwkiu5YVaX9NdX5jMrJRAhmCMevTq4Z+IFV6
         M2jkLiFRvh9M/FbQrGIrtIk+WEvUGbQ/UuQKuM3T1ep6T3dLC1lfhsoQOZYnmBo8krAl
         z0wtU7qDQTHJP2+dwwiPO2mYfUuTKjIjaSJF/C9x0VbAxIVw2SrSVVtSIgrijlN4WKRl
         wQeaXGGWNkIcbRxLvjZ2Rsyw936/d374vYppECy5rO3EhRVVf2hi4IoeDeck+la9IYDV
         0th7WZvY8JdIe0TslFIP5+gHaisZdAC1wl1oes6Dd2pRNn+cimAzy+zOP0MVe472WDBB
         5tmA==
X-Forwarded-Encrypted: i=1; AKwUvBwqr4Npwj0IftxMrzTnw4Pc37h8kyrXX4UlF20mNLXIsqhtSa7B9ZfYRkID0AzuxZSujgvUCKY=@vger.kernel.org
X-Gm-Message-State: AFuF++nmn6Q7gsRVNOiEjVlXGQ2IlT1JedP089G5yjXTRYuxJrEp5yDa
	lg4KHkhZde+CJOT7iB1m3ZmoQHi8HMMR1102cANlZMTVxwXpBPT/j67aYfFbeFjMf66Bx5/ttG5
	NIEVU0nMQIXNbqUnucg5mdVi+c0EhXQZjbHcGlD2B
X-Gm-Gg: AYBFou2K63WnAlEQEp4+0NKjc/QYdt2oQVG/B2bMWJq7eKaDNi5DFTtS1nGk1Nemoh2
	65cyAE0oUiXumgiTeMQ4xzJfN0q3BfMpiAqKwj8GGejzivlRI3Aw3rsGFQVfLrDpyBH2F9Lup6z
	XwrbQZeen1xcSdWkGLZaiOdyHSeyBB2t+8Hflbl3HFLkcauf6KcGMmlsrw6fr5MIIf5u8RBxsDv
	JsQIfeBjCc6E3pW3XuEWTd6ootmo4VHn37tsDeauvJ8/wtKFHEB8FpchVkYegeCGZGqqDSAVxCH
	Q2HBas/nGhN1Fd8AzxUHqWxxf1wy//5OfJh49CQpgwPUoWiUQVYyZV3OUJ99xwoIb1PWFz2uYNX
	L7bJ347kMBBVuDuWnqYOOL2QCuJ4TsmF6rOj1Hk///rwhT8YyW3z0c2yyqzAQ17vkgK8=
X-Received: by 2002:a05:622a:1904:b0:530:b2e4:d5a1 with SMTP id
 d75a77b69052e-5310d08ebd9mr1666031cf.60.1789340891034; Sun, 13 Sep 2026
 16:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789302084.git.zihanx@nebusec.ai> <a4f108b00c7d3c0997bfcee84a9e7e481c07ad5b.1789302084.git.zihanx@nebusec.ai>
 <willemdebruijn.kernel.57ad3a4d0955@gmail.com>
In-Reply-To: <willemdebruijn.kernel.57ad3a4d0955@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 13 Sep 2026 16:08:00 -0700
X-Gm-Features: AcwNN1XPieBwHmTcaQqSQYQyOFNrmOUAYYi4uLA-4au3SSGhTImp2iLuqjRICx4
Message-ID: <CANn89i+QqU5sw=WPrcki8W=-HoyNLpHGj2C568VHDU1CyZgodQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: gso: limit recursive IP-in-IP segmentation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Zihan Xi <zihanx@nebusec.ai>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, idosch@nvidia.com, willemb@google.com, kuniyu@google.com, 
	kees@kernel.org, richardbgobert@gmail.com, jiayuan.chen@linux.dev, 
	stable@vger.kernel.org, Vega <vega@nebusec.ai>, Luxing Yin <root@tr0jan.top>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 3:46=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Zihan Xi wrote:
> > IPIP GSO/TSO support makes IP-in-IP GSO dispatch re-enter
> > inet_gso_segment() or ipv6_gso_segment() for every nested IP header. Th=
e
> > only state that tracks this nesting is encap_level, which records heade=
r
> > bytes and has no recursion bound. A sufficiently deep chain can consume=
 the
> > kernel stack before a transport GSO callback is reached.
> >
> > The unbounded callback nesting was introduced when inet_gso_segment() w=
as
> > made stackable by "ipv4: gso: make inet_gso_segment() stackable". GRE G=
SO
> > support predated that change, and IP-in-IP GSO/TSO support later made t=
he
> > affected path reachable.
> >
> > Track the number of IP GSO callbacks in skb_gso_cb and reject the 15th
> > callback entry. Thus 14 callback entries are allowed to complete;
> > GSO_RECURSION_LIMIT is the rejection threshold, not the number of
> > successful callbacks. Initialize the counter for each top-level GSO
> > operation and check it in both IPv4 and IPv6 handlers so mixed IP-in-IP
> > nesting is bounded.
> >
> > Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: LLM
> > Co-developed-by: Luxing Yin <root@tr0jan.top>
> > Signed-off-by: Luxing Yin <root@tr0jan.top>
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> >  include/net/gso.h      | 9 +++++++++
> >  net/core/gso.c         | 1 +
> >  net/ipv4/af_inet.c     | 3 +++
> >  net/ipv6/ip6_offload.c | 3 +++
> >  4 files changed, 16 insertions(+)
> >
> > diff --git a/include/net/gso.h b/include/net/gso.h
> > index 29975440cad5..2665acbb9205 100644
> > --- a/include/net/gso.h
> > +++ b/include/net/gso.h
> > @@ -19,10 +19,19 @@ struct skb_gso_cb {
> >       int     encap_level;
> >       __wsum  csum;
> >       __u16   csum_start;
> > +     /* Number of GSO callbacks this packet already went through. */
> > +     u8      recursion_counter;
> >  };
> >  #define SKB_GSO_CB_OFFSET    32
> >  #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_=
OFFSET))
> >
> > +#define GSO_RECURSION_LIMIT  15      /* First callback depth to reject=
. */
> > +static inline int gso_recursion_inc_test(struct sk_buff *skb)
>
> What is 15 based on? Is that where in your test stack overflow occurs?
>
> A realistic practical limit would likely already be smaller.

An alternative would be to limit total header sizes (nhoff) to 256 bytes or=
 so.
