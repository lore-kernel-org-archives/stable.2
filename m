Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7F46DFED
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250507; cv=pass; b=e4wc8tFGIs6D5JL92M8HWJGfgoo5RcJCm0ajbs6fhVLl5dZRTaVYBk+kvYX9CWDy5bwQHcvH64cN/MxoKfqVVGELpgbzFK2lJCn+yAbAMVOQi32aeacKmGn1MLwZVHJBKfUYtQ3m4lV11LsqeFuZUb+0F2N7iTBD6v9U6Y3Vnhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250507; c=relaxed/simple;
	bh=p4ZS2QnTFpdtxEy/xf7l2zuepNnHiLZl9CMn7GOvXPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a92cqy7421Wjo/JWUCOu5Vk5He78okabOAJBrhZ8wICnwmbSSDgVlGm1zZvdQBaRe9QbazZZbv7GhNiWHSW6SKnXG/+yCwq36+dDRivmYIJc6xyUQMQkdqUJIPCqoxhjW4cYj/YBVXZMHOxL8D9rfBQ+bSpJgfDQChwAGlg3I+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSRnyLjZ; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSRnyLjZ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1059574b3a.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 07:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785250505; cv=none;
        d=google.com; s=arc-20260327;
        b=ITn8nqU5WKskW/wL7UoS0KmPGX8Yk0KXAhYOrGd5KQEMLSRe28fhiHNnL8oGVl09su
         mvL3qFzQ4saJXk1GIWtK+u5e5Cc37FwD61BGEy99VJEjb9NjrgkdV2h0UJJPssuN5z7M
         y4LeeirvPLWkhPgFFJxreX3BfEQZGp7T+nhz9Satk7dn0OogeOo9y49t6nfZRZG1FuT3
         7BYyp2p+GLAyrxAmdm8qFUT3OjmpTRcN7HTHHjCjC/gL9z5h/8KqAqVhhDiDxu9AArXk
         1ngnR9bWR1lxriUB1KCErhTBtch1LkKYsLwoz3lnp+OphGugP2MitDFsDvad/hRzMqVQ
         CDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wnZiRzYZKi9FGvHEmv0/yAIIifQ5Iqwvf7aqNKU+WYI=;
        fh=x+H/hjRblhVLUBBQSouLSlaGuhk385gJGJ3Tj4rQ4ng=;
        b=MYrge+2N6jxvQBIQwzSP66tIuZW4n7l3FY5widC9J1DRq1NGyzY9ArMHQleEhpfDlo
         4xmNSeFa2DKBjQxR7uepgEsRCDd4LsoU7/OcdMnpLTgKK0bgiGLhRO4zKz+fjd4BLp2R
         D/ItIRVWBi0C7xRNBUjvDpCz+xyMKx6Vv4Wy6g92eDFRnq44OuiNzCYTaEA5CGiuGZvF
         eHthGAxM+H5oooewELgr8PDKHH71xXzKh1cRnWIQFrOQHt89EXtJwktB00sdouRpPu42
         BdaPgNd/4hnmSyVZ86vsh+CsNVRdeLfknUAkiiSesDP9AkPA0pnaJ8f6RS6BnVDzS0lB
         ml5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785250505; x=1785855305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wnZiRzYZKi9FGvHEmv0/yAIIifQ5Iqwvf7aqNKU+WYI=;
        b=TSRnyLjZ+xYBoBMy+KO6VVj7+iu27i3jsCc2jsDijMSzbv4440IgWHIYQj1rpFkSMP
         pNXxYrUsg8n+6eKjg72pqcJcLs6NMyebu9PlaRH8VOw4h5E/DhehUFrkYwscysSwwOeV
         l+JsjoTjGc0oLHsiExjKxqi5vCwKhFwb8zDh+y/r5Uy0wuFdHUBvGdRROeFXqCuLixP6
         Xt9JjRsnq4gkIddnSD/GI/CVcdul0LsAXcgl+WNic4hMME5nIdxS41rpdk/N9tyH5J04
         kzn1E4IIqrxQO5WYKpRSMmcUKcyzY9qudDAS+rm4LerICHNxjSCB35FtF4Hm1di2Usft
         uXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785250505; x=1785855305;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wnZiRzYZKi9FGvHEmv0/yAIIifQ5Iqwvf7aqNKU+WYI=;
        b=KqedQ5vWUpuhkVyYqiyBRP8/RcjqUKcHYLvqgkR0zuPzjP5hJIX91uvKk7mNqqzwkD
         3Gp1bKF7mSg15bZaneU76g7jvfXSsLL6UzfBRsXiwMMF4Pl7GIQBDUBJXTvFR/5B/PHW
         gmJckA5ykEMVAH9YFWlAMh4betGQrKpgCZEIjvzPtzx7K9OPFdPfgbWd8F9Y2m/IqvRm
         suYvBevRnq4989XC8/4cJ8xs+7gL79zVY4PJy9VGpKeV/1MFs0e9EdBiXHMPibYDHu/q
         YXIU21Ed8Yoje5RceWif1DFZ3I/BwNvBXQkfgZHeCyAAsUJHO+Qo5Ugt0ien1CkjasyT
         VPGA==
X-Forwarded-Encrypted: i=1; AHgh+RoPrH7vSFEBazA2MkymUJJNDlYK19cyuPXoPly7e39+rQVgp6VNHCmzsek62X/Zau/j3vq/9pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXeeQ8vYTxpwUBt6zRZMgU/wtbosES5ysorCl8gKoHGzZtzfpf
	SuyVX985OWvEKFEgm5a5KbstkwW4rSnIlIxLtWvqoiOKMEGvnQwVsdftLMpCZPD+51nPxbiv1zM
	oZStlEtn0SNGKCafhQWgGNYzfIEZrVIA=
X-Gm-Gg: AR+sD11ZvqSmGjCIQPB1OfJ9fp7zDgqrl53gJl+4bFsSunZNLcG0ftj0x640097ryOI
	Z+BG89FSwPaaz0vmf+2Zf+0LdAJsWjwkwYGQbIepPq8aYVaeatIIRCq/XLenr8BqH5VWD1J6J3B
	QaDKFH8tc0aAsTOzpuS6z4yUQb60OS4tJu21zH8UbHX6u/bLXa2WFmgt+zYvKQxJSpVHsuYmKBw
	QX3a5GUmH9A1ZrKy2IzAzfiFrIDv6uUUjAvKxSdmai/p/BE9EgaeO9Qdoujob+BlvU4fWlLHJIY
	YDudj6D/fhMZXURjaPnKw9dauAl9SUpHeipuFKacHRcrBkovIxHJgl+XE7wiAOpc34MX+7M4sjx
	roMt8hNOy1uEFDn1M2w==
X-Received: by 2002:a05:6a00:27a5:b0:848:2f58:e1e9 with SMTP id
 d2e1a72fcca58-84e9329c546mr2926596b3a.36.1785250504812; Tue, 28 Jul 2026
 07:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-sctp-adaptation-length-v1-1-0ab58b2810a5@gmail.com>
In-Reply-To: <20260727-sctp-adaptation-length-v1-1-0ab58b2810a5@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 28 Jul 2026 10:54:51 -0400
X-Gm-Features: AUfX_mw0BwbrM7UVJQNAz32ePThYFDRt2stVo7wKa45Plugisja7X07u24HlGCs
Message-ID: <CADvbK_esmVbc9hf5ihxkXOGrh=b7=wN2dVKzbnbp2KNH6CGC0w@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate Adaptation Indication parameter length
To: trilobyte777@gmail.com
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 7:18=E2=80=AFPM Charles Vosburgh via B4 Relay
<devnull+trilobyte777.gmail.com@kernel.org> wrote:
>
> From: Charles Vosburgh <trilobyte777@gmail.com>
>
> The Adaptation Layer Indication parameter contains a fixed 32-bit
> Adaptation Code Point after its parameter header. However,
> sctp_verify_param() accepts a header-only parameter because the generic
> parameter walker only requires the header to be present.
>
> sctp_process_param() then reads adaptation_ind beyond the declared
> parameter. When the malformed parameter is last in an INIT, the read
> starts at the receive skb tail, and the value is copied into the state
> cookie returned in the INIT ACK. This may disclose four receive-buffer
> tail bytes.
>
> Require the declared parameter length to match the fixed structure size
> and abort the association through the existing invalid parameter length
> path otherwise.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Charles Vosburgh <trilobyte777@gmail.com>
> ---
> Runtime-tested against net.git base 53658c6f3682.
>
> The patch passes checkpatch, builds net/sctp/sm_make_chunk.o, completes
> a full x86-64 bzImage build, and rejects the malformed header-only
> Adaptation Indication while preserving the baseline and valid
> eight-byte controls.
> ---
>  net/sctp/sm_make_chunk.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index c02809264075..1f7a097802b4 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2168,7 +2168,13 @@ static enum sctp_ierror sctp_verify_param(struct n=
et *net,
>         case SCTP_PARAM_HEARTBEAT_INFO:
>         case SCTP_PARAM_UNRECOGNIZED_PARAMETERS:
>         case SCTP_PARAM_ECN_CAPABLE:
> +               break;
>         case SCTP_PARAM_ADAPTATION_LAYER_IND:
> +               if (ntohs(param.p->length) !=3D sizeof(*param.aind)) {
> +                       sctp_process_inv_paramlength(asoc, param.p,
> +                                                    chunk, err_chunk);
> +                       retval =3D SCTP_IERROR_ABORT;
> +               }
>                 break;
>
>         case SCTP_PARAM_SUPPORTED_EXT:
>
> ---
> base-commit: 53658c6f3682967a5e76ed4bc7462c4bdcddaec3
> change-id: 20260727-sctp-adaptation-length-aa16536552d0
>
> Best regards,
> --
> Charles Vosburgh <trilobyte777@gmail.com>
>
>

Acked-by: Xin Long <lucien.xin@gmail.com>

Note: case SCTP_PARAM_COOKIE_PRESERVATIVE may have the same problem,
it will be nice if you can confirm it and fix it in another patch.

Thanks.
