Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB5318B9B
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787496713; cv=pass; b=TqvXx44+1I5CzeHiegk2sywNMpqRj8/6n1iIMd59WCcOCsZLBtQgdwp/DT1plAGlZ7tiofdGOFKGuPai9IX4jX82HustQCXDXorPC62EIQjXFwBGMRqeZg9mnLflLzD+hxen0XSk2V3DJ2wyLmtOO1tio0g2oT4fKqvwJRI9014=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787496713; c=relaxed/simple;
	bh=Le1qMMXndZqMhyvPrNPrroqdRA/dktc4UX2DKI7dx+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zl6ntOtksF0NYtpudQzvcm2XSE459HIG3C+4UFY9K3MraaRqw4MgeAU/I2KH6LTj2L0amwRexzcLtATnmD5nJ6Ck2tMLHSlUJMfBORcqkg1M5Qf2ycLm23isFtvmm/jWudBqc8JRdVMqp3U0ueqMl/ZRg7Q+v3JGCD74O/zzR2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFB9IZro; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFB9IZro"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-936c02e58dfso141262485a.3
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 07:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787496709; cv=none;
        d=google.com; s=arc-20260327;
        b=oUNBW1q0FUbFB/UPtrkz1BWK4QjCc5GQExgJd7usXLu7TkqVtuwXgx0UTOhE1Qhqu0
         lC6gP2Tdr33mC4LN/ycKfhRiXbnFzLrkrXdLq+U1ipfIh9HBQ3pcwavF/OuKh1XNi/Ow
         Sj0aszdVk3vNWPvGBr6saiH8hulXpkzhLAQvYpfPQZLveRK/IucZROwm7dhX5H5/DIEo
         Y1jUmoP6NJLuTXwyuQ5b93IghDfSwiJoEVx3Ndy2hADhLQNQTxpRbDMd5MVAgpRDnmHP
         xY0eEu/JZYQFaWtBNygdnLJaZYFzAPEe/IgAzvPzYKOK2IB1I1+zFRAQvRx6t8davynj
         B6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xwG6NI1rbMeiLX/3P+c85FlciFYa4SxM2JUZchrcE58=;
        fh=VB/0GY6lQZwrV5F/HtP/QuHr4ZFzP/35M/53eTxIkLI=;
        b=AUy6nY7YV9fFGA9AJnq4/QiASEQ96N6YVZPIhdqxSwa3mZ7auQwtb4Va6fYhZiQln8
         0YqBdN/fI0EPZ978ZTT0igEdIJoaXOGzJdC2YxiMB2OPdDEnFY4MSF4jLmE1FZKLb07u
         D2zuAZYslCXnjVl4QOzuKRWWrLD1R0PzIZKYm7AOKyAhDQP6kWq+yyc3icxJxCUzArlg
         INxplBKVKMuWKKV1ONUeakklPduHj0sGjhs5+GcSEawb1X84S5IVbbF/Om1jdz7Xn4wh
         4NUxBclXMU2tdCaTHsFRqOLx9V5mr1LpXfSjQfEF2vGlxWANrqMhJOKs9JT/Td6T6sLw
         /HzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787496709; x=1788101509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xwG6NI1rbMeiLX/3P+c85FlciFYa4SxM2JUZchrcE58=;
        b=VFB9IZro2Qw+C8MuStZLwrrWI0Acqv2qTDrmkawNTTBjRcK+N8dVQCZd61Uon+8Fcr
         g7BUn3mMS0lMNn/CmnlRgA93//ulGIl792lyKL86EKM/Auxqg8ZaqfbHNC5BtzpfT87S
         MBI6p9YaWDymQdlELBMZW9+ULcoCHzHwJDeUj9hTMX7zL9Wm6yeK7MXHOUgyBUF51dEg
         lDshmXCe9U5I1Bji+bGI+5VWA29CVZunSQz3JNbqp1RNEaGrEKpe2gB7/tgwmA+bf6Ql
         QpyUNQGdhNLWiiIKYCdGqxIpNIFrd8hsb+UXsoe12PY24C4fqk80eGdCu8ffquDrpaA3
         Nt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787496709; x=1788101509;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xwG6NI1rbMeiLX/3P+c85FlciFYa4SxM2JUZchrcE58=;
        b=b9IaJnt7vQkECPvm/LxqRe+vpg/FDJoUbs5GMNEbNxvkiJZjgNlqdRWTR8sDKm8M5v
         ArnXh3+PznRgvdbXGK4IzYge7TSeZFLc/aO966gFtK6/zqH0x/zfXheSossoHBld6qqW
         6lrzrnXgzt58WY8cfTCkq9bn0FlGWNbHVInbFS7MbxcpOGybzf9h3L3PIL4gbTzMg3Cd
         4husq74o/AbDX/vAwO34KWARti7g3BTbRES8/Tt8hhi8oZ/Bx2rEcV9TG9tFj/NKeXc5
         SuGqVOlYitwKye8J3LFt5B443Q3mFSeRkEfNSahM6UL8A25ic5gGZGC6R75WM6f5Gds/
         gDXg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7hPhyQvrjg6DKo3ajjbuy0Apvt0galQ9pSsw1VCrV5m5nk5YM5YI+oiw1twwBUYVOfS96/7A=@vger.kernel.org
X-Gm-Message-State: AFuF++nSlpqPDJSsubmPtdzfrd5PNn9QlPD3wpkpLlmaoeRD4A6dKCap
	guHFx0vBJOH7aiNj1OTzI3x/wGpUUFY/1ndP7L8zlrjALpuDGZUt2mHzOFLmYpJsWDYgbZSMteE
	ZA4bkVWxudCA4joOnDcU+U/7BHshDGwGb66wa7r9w
X-Gm-Gg: AR+sD12WFMYuFezQL47qjMb5GNe4nEGI+4NSf7YfRILzMfFR9Oj33cT+cEx/M04jgsM
	Z/dFOSvtv7W0uQHveK4unkujKdXnEh5sdi5o2hv1jz/shnQPrMqln1YDb23qqDTRtjRcgIA0Mr4
	FSS4ithBydNAb3CIjpRLULmt3ELdT+idojigfvkp7dHjaJucc2V3ur+vku1FRWvaTWewKKDz1GY
	q7EnNEGxJfXbLTClsVNajvgp4LYm6upzSEPbaugDwbP/wnNsMGWIgHLSzw9yNjN2+n4m76VhxGB
	Dc+U4p05HTCgExZXO5PBWyESsZC58E7J1P86yRPLl1X4L1rqTRqAUadMIWLK9kIobeROTfK5Elp
	O7cqWTL/F6fg/m7+5DqRD24G8UhNgMxkictI8rMpGtKeU/O1pDSxkca5I
X-Received: by 2002:a05:620a:3714:b0:936:befe:42a4 with SMTP id
 af79cd13be357-93739693082mr1777467585a.42.1787496708724; Sun, 23 Aug 2026
 07:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823142620.126424-1-shlomojune6@gmail.com>
In-Reply-To: <20260823142620.126424-1-shlomojune6@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 23 Aug 2026 16:51:36 +0200
X-Gm-Features: AcwNN1UvSqU38SAKixc2_G_TDw1LEOp1jNSBCTwPktQLry4hJ_0mTRvDAKBudgo
Message-ID: <CANn89i+5o16tSTk9MpLE24nCAn+SkMeZvHv0W=MqxnXGZDBBiQ@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: reject invalid pull bounds
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 4:26=E2=80=AFPM Shihuang Liu <shlomojune6@gmail.com=
> wrote:
>
> skb_maybe_pull_tail() subtracts skb_headlen(skb) from the unsigned max
> argument and passes the result to __pskb_pull_tail() as a signed int.  Th=
e
> function does not ensure that max is at least skb_headlen(skb).
>
> This can happen while parsing IPv6 extension headers when an skb already
> has a linear area larger than MAX_IPV6_HDR_LEN.  Once the parser needs da=
ta
> beyond the linear area, max - skb_headlen(skb) wraps and is converted to =
a
> negative delta.  __pskb_pull_tail() then passes that negative length to
> skb_copy_bits(), where it can become a very large copy length.
>
> Reject this inconsistent bound before doing the subtraction.  In this cas=
e
> pulling up to max cannot satisfy len because the initial check establishe=
d
> that skb_headlen(skb) is smaller than len.
>
> Fixes: 1431fb31ecba ("xen-netback: fix fragment detection in checksum set=
up")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM

> Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> ---
>  net/core/skbuff.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c82a147..33022f7 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5838,6 +5838,9 @@ static int skb_maybe_pull_tail(struct sk_buff *skb,=
 unsigned int len,
>         if (max > skb->len)
>                 max =3D skb->len;
>
> +       if (max < skb_headlen(skb))
> +               return -EPROTO;
> +

pw-bot: rejected

Please ask your LLM not to slow down the fast path, and find a better
fix in skb_checksum_setup_ipv6().

Note how skb_checksum_setup_ip() is fine.

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d4382b68d56e0b3b247868b4d29ab383cfcf7440..f77d7480594ca6a1dcce2fea737=
e421d5ea2d38d
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5974,7 +5974,8 @@ static int skb_checksum_setup_ipv6(struct
sk_buff *skb, bool recalculate)
                        err =3D skb_maybe_pull_tail(skb,
                                                  off +
                                                  sizeof(struct ipv6_opt_hd=
r),
-                                                 MAX_IPV6_HDR_LEN);
+                                                 off +
+                                                 sizeof(struct ipv6_opt_hd=
r));
                        if (err < 0)
                                goto out;

@@ -5989,7 +5990,8 @@ static int skb_checksum_setup_ipv6(struct
sk_buff *skb, bool recalculate)
                        err =3D skb_maybe_pull_tail(skb,
                                                  off +
                                                  sizeof(struct ip_auth_hdr=
),
-                                                 MAX_IPV6_HDR_LEN);
+                                                 off +
+                                                 sizeof(struct ip_auth_hdr=
));
                        if (err < 0)
                                goto out;

@@ -6004,7 +6006,8 @@ static int skb_checksum_setup_ipv6(struct
sk_buff *skb, bool recalculate)
                        err =3D skb_maybe_pull_tail(skb,
                                                  off +
                                                  sizeof(struct frag_hdr),
-                                                 MAX_IPV6_HDR_LEN);
+                                                 off +
+                                                 sizeof(struct frag_hdr));
                        if (err < 0)
                                goto out;
