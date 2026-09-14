Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A143C7D3
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382431; cv=pass; b=TW6Yu9f/F7S1MmV2dcUd+cYMtCLRKpaEhskuVJQVaiz3TmvJ//N95MjCJqzCNAFuF9I0QItvHNiNEk79jNKGyWLWK3plbz3jDj0rNgc1cFjYiobIfv8359UApaWEZNix+0qvYkbhXKO1niVPJvZxzpQC9QNrLV8EsW0eNy+wRdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382431; c=relaxed/simple;
	bh=uRtnttauUpfeIGypcutrfS/HLykzoQ06BKczAkGSR14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lw4QtFArrzXe6CSoHcm5PQArxULkOqaYD6/Ea/HQou63kFwVk9J0Z9id5nu9rO0hxjMP+TF++fK9ORsl5/V83EtVlHefR5lxTNMvPG5JrVAr0bfyqtqWCPQf61IeHZf2F4uimnYzYGYTu2vs7W0hXzCvKw+O0K880XlyGCbyIxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LYkCx/gS; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LYkCx/gS"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5309a20a55bso19130631cf.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:40:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789382428; cv=none;
        d=google.com; s=arc-20260327;
        b=nMwm+u7E/PO47oN0zEfLUysm3WDU//XimgWPIhxtBDSfVg8Aog0KmlJtwkkQgAj6yD
         zoFdftC2NQeVXF+XFVjNVdRubXXFONvdOQPPB9kP1jGf6exWmJOk32SH2fqqmUEtZxGP
         m5AzxmHULnTPZUG0k9/EvAKJlMP+iUWJyZ2g/Oo/MogDFbxkRKGNNfPf/nktEHvjCLgd
         nIsPYQ99gCMuJWS71a36DiZx1eENxbYNLTzimyHrE7erwDWgtg+djfzytys7m4846g2a
         M5TbEQ8VVJtf1osqZogqDVLHMWB1se6858w/QmSiONgRlgrnaCIRGtjEipkLX/FhQv5w
         GgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GAKmENrqU15QTtr2B6AdmjiozxUTftLDYrpEGIkKWIg=;
        fh=RosOkB5pMS1C808BwYLV8pLoFF/afxDitf0Zuxprbh8=;
        b=nQiJmkK3OYX/NfVj3Lm3iqYnD6WLrzfVa/VE5OjX5TCFLHUb5VucRwZgbGHf9hlBbA
         WRv7w1MRbv0urCdtQ4q25BkZChJMnzzFKgJctM6lsAbM2C7Z1/4fZRVrEGiWpPfPJU7f
         7aR3GDYbI9bEekIYtBEu3x2t9HCnXj+GU+NTKU7dpvCGJTfuKFsC8Wf7vRVxPE3uDNkp
         riFafL3YgyMjAua2Kd5/qKJOjXghTpiB4DhyGC5L+RWus8zXPsHRza216njCxiP8XehK
         oVBnt2tLbuEbNnX64qY2WWRN8BB6iM4rYlG3+hq7v5IVymj6LkAe9oHiqSMW2bZrUVvI
         gDqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789382428; x=1789987228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GAKmENrqU15QTtr2B6AdmjiozxUTftLDYrpEGIkKWIg=;
        b=LYkCx/gS7QPVcr6ioAD7fXJwmgwVOxBSugUgtawV9OIf5SMgWXZLsTsG0o5kQQBPHl
         Bi81kAshdL8Mkpnvx2tGuj6qOEWQr/TI8xS23/lN0rsfJw82uhZ5nxkwriPjc1mh/G8Q
         zqKQhyMxxvCS+D+y6dEU24DKZGp966cQ7MBoOrXD3Vl/zzsLesa8QWKSHdmJ7bQIbsLt
         evQUHNvQ5AJqILSs4lcOBHv3Lvwzg95Z86H9y6GZj7w6n34dH6SfD6PKmydvnyHUgcSL
         2p5mzw8yrS6UJlprxi+3qyJbJp7ePvRZUu+o5NnvGaBaA6kJD0YRB1iF5kL3pyP31U+Q
         WqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789382428; x=1789987228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GAKmENrqU15QTtr2B6AdmjiozxUTftLDYrpEGIkKWIg=;
        b=aHdhVXfNA7BKOXr4j4THLhlxKm4hp8wrt0wZFur+fh9DBLvtF7Fx5l0vpAZRV6yuLP
         KKwVO8qjxZDfmmWWb4EPv9/EDfDMqpuzHZ9zo6KVHJyxBlTbiqBq+KgDqX62Yns3WO0c
         BGwd/1mQ17w4o4IRHdQIDOraCJdx7UCVjbQMZzqiD1oTSJn6vpPQJypJ1sFdHLEgAGXG
         Pp+OxqYLF9sGaElK/zCtJ6kDcShTECLCn88kcXGqc/9Ycg1+df81zdWV7UYmA/LFA25s
         ARGCvpJW+2lAEZdIkVrXeyycxGqW9BiaNIpRefcIrbxwerKmt01R5X00H/Ytma9u+mQ7
         u5Iw==
X-Forwarded-Encrypted: i=1; AKwUvBzfMqti1Ww2KupCr6ZuctWR3SKoZ095BRCzPq3GBJ9+ijmgzxj0K+fnsF3nYpW/tY1w5SWWCbc=@vger.kernel.org
X-Gm-Message-State: AFuF++n7Da/m4ipaYAMcN2AAwxe7WiypcsBU3da2HZC+DSpJu4tXuAUB
	cd4peEB/m10VScW7g81E0EWf5W/Q9NGOkXvkm7f6/NuuzwOgVQewK2+PnVgNdnJ8fkxmN5Ds2lP
	dMqR6Isgy6a9Vi9IRVrE7dJx1ilG1eetCq16iCL8y
X-Gm-Gg: AYBFou2WbiOAtIQo0nBKheFZxHt92smxUi6h/exlZyyXHbnIlM2rPsn0FpxUFRn+jH+
	eIwv6egLLVldw/wi5wM0vVz9ubSLD9Zv24y8m0HGLV6TUOAU0wKqglkDqeGr8XTRpXSLz/9Tgms
	sciSEZVeSlJTeQk8AhUNqANIkBhfQE43axfdAM1u7Xx9RAD+8ka4Tr+SupHRxRJaw5tIv+BNmmu
	YPuHjuzv3rt/Kd73O0Lnps7sHm4L3J5EaX1bNTcspyahiQqITGeaa3R+oqGust31JiBj8IsFK2n
	f+UX/eJXiM+lYD5G82mk1t53S8LZLLR1Jkt7IevHPH6eJcyxIlg4KKXafPRTryHywtsRUDjDakM
	LAA7QYxMCwAeMiPTin58+u2alTqxYH4fWBwCzvsJycjeSuj6K+UtJhs7bG4UOfIyepKc=
X-Received: by 2002:a05:622a:4005:b0:530:f3b2:9c8b with SMTP id
 d75a77b69052e-5310d093592mr28405701cf.48.1789382427670; Mon, 14 Sep 2026
 03:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914090408.1435080-1-inbal.lipshtat@mail.huji.ac.il> <20260914090408.1435080-2-inbal.lipshtat@mail.huji.ac.il>
In-Reply-To: <20260914090408.1435080-2-inbal.lipshtat@mail.huji.ac.il>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Sep 2026 03:40:16 -0700
X-Gm-Features: AcwNN1XeWYhpp_YIEh50XzUKFPCtVBpqJefPYlt_FATnNskzQk5FMIx10HNP2b0
Message-ID: <CANn89iLBHj=LnPgxtm6z2iLDUt894yKcUU-wFBrD7vzvz576mw@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] tcp: exclude old ACKs from tcp fast path
To: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, amit.klein@mail.huji.ac.il, 
	Tamir Shahar <tamir.shahar1@mail.huji.ac.il>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 2:04=E2=80=AFAM Inbal Schussheim
<inbal.lipshtat@mail.huji.ac.il> wrote:
>
> Exclude old ACKs before SND.UNA from the tcp fast path
> as well as ACKs after SND.NXT.
>
> Such ACKs will fall through to the slow path, where tcp_ack()
> performs the appropriate validation and challenge ACK handling
> according to RFC5961 and Commit 3d501dd326fb1c7 ("tcp: do not
> accept ACK of bytes we never sent").
>
> This prevents old ACKs from being accepted
> or modifying connection state as part of the fast path before
> appropriate ACK validation is applied.
> In particular, this prevents payload carried by a segment with
> an excessively old ACK from advancing RCV.NXT before the ACK
> is rejected.
>
> Fixes: 31770e34e43d ("tcp: Revert "tcp: remove header prediction"")
> Reported-by: Amit Klein <amit.klein@mail.huji.ac.il>
> Reported-by: Tamir Shahar <tamir.shahar1@mail.huji.ac.il>
> Reported-by: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>

nit: (no need for a new version)
You are the patch author, the " Reported-by: Inbal Schussheim
<inbal.lipshtat@mail.huji.ac.il>"
is redundant with Signed-off-by from the same person.

Reviewed-by: Eric Dumazet <edumazet@google.com>

> Suggested-by: Eric Dumazet <edumazet@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
> ---
>  net/ipv4/tcp_input.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index daff93d51342..03d317a58132 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6490,6 +6490,7 @@ static bool tcp_validate_incoming(struct sock *sk, =
struct sk_buff *skb,
>   *       or pure receivers (this means either the sequence number or the=
 ack
>   *       value must stay constant)
>   *     - Unexpected TCP option.
> + *     - ACK sequence number is outside [SND.UNA, SND.NXT].
>   *
>   *     When these conditions are not satisfied it drops into a standard
>   *     receive procedure patterned after RFC793 to handle all cases.
> @@ -6539,7 +6540,7 @@ void tcp_rcv_established(struct sock *sk, struct sk=
_buff *skb)
>
>         if ((tcp_flag_word(th) & TCP_HP_BITS) =3D=3D tp->pred_flags &&
>             TCP_SKB_CB(skb)->seq =3D=3D tp->rcv_nxt &&
> -           !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
> +           between(TCP_SKB_CB(skb)->ack_seq, tp->snd_una, tp->snd_nxt)) =
{
>                 int tcp_header_len =3D tp->tcp_header_len;
>                 s32 delta =3D 0;
>                 int flag =3D 0;
> --
> 2.43.0
>
