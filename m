Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795629035;
	b=udX5oQbOvt8M1/6U6OlgGZEj1i3Xn2WKT+J7BWIMuGQOEhSGvSIvP2eqZmB8ZbBL5bGF
	 2FzXUl7iKU1j42McQFLG/9aTOrCIK1rd7tJYxCpJpgXNsu3mPFX10kTHMTrfzmgGr1GCq
	 Sgr3j1r/MEafLAhbq7yOGKFfIJ4Ak75dslZ+QoUu2ByL7hGXLlezXh+KI3ixf4LUgnCdw
	 /nAOo10yg8/ahMVhP9ToWWJiGpSGqZ34tZPbSEdYu7Kxy2agnLmdkDYJaYc900Wo26OTS
	 loc2JAiM+vyBc3RyQzSCKhfKNCw3722S4qKFEC/FOL6w5FKfxAhDFbkXQFRQ3XWotCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RfPxo/aBNHz+uEsj4QdIP7gFGpuoo0qtgUa4pVHLuDE=;
	b=t+q5cJfeSFhhcqY+VduvoU9ptDAjxIkjhNblHsBpPS0VqRDKnOjNStFWO7w2wwHxSfT6
	 Se1nV/4BTpUYMqqD7IwZ745vMsaOcB8mkuSvdHNgDvRGIB/H7x/yifV7ILtjkYkHR0AD6
	 jKgNsWM2y4tkmF/OpPwDPoV0vXzGvBorFlRYALd94WqXzKuYFlHmCtDHaAJWctzF4wbC7
	 0au3fbf0/tfmVGMp+ROUiUgAerVTl5VIcxpWWv9MpbO4b2uaOkTGKIk58PBf/NzK+lO1I
	 MvPCYXSGOz87lHiWNL+NdVnO2uAmf99bcLOKHhPvlby0BIpZmdCZYGGQ21bD7RZfT+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RzrnzIOd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80CC606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C80CC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RzrnzIOd
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so3967734b3a.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:50:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795629034; cv=none;
        d=google.com; s=arc-20260327;
        b=lXZGV+jRQmbiAW3r2wyd2x0+fmLE5nFkujAruHFR4y6qo4gEica2BZuEECA14Xd260
         nsEqHsBWN0/GkDeXJV+yCydqSpzoD2XjOHMo6Wn7wr19J3oJoH7BoTKBcG9lBJAT0/jt
         sNcp1O+EBd0RBz2A/8tWLFILgNBJ5fWqXmiXqAfTuZXoOG5EY9Fv9F9xWaEPiRMJtzqu
         VVpe7o7UqW/bXpwQGShovWB5rQp/JkgyMCOrGSVHo6pFzJNnqZc81+SEBTsdKej33S1Q
         nYJrl8JD7Mkv3+3G5Y9tKNFWTeaP18fsOT/Oe8tnFZqRJibb9DgvcMd5zK26X49KLy9k
         Remw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RfPxo/aBNHz+uEsj4QdIP7gFGpuoo0qtgUa4pVHLuDE=;
        fh=1oHlsmWRGw2nDo10FUc3cilzmGRz1i0pWE2Oqh0HojI=;
        b=V9CwK0pQdH7B0SBmTLd9Y10kHxBqpAmKU4EXS/FTFktzCu1HbdKHoBxkepG95RISjM
         OrCuKct+7eLcw8uTt120LnUj+Em3SBm4eFimPo2O5J/qmWejQcIwmLpsBSnwvbXh3dEW
         icsYURS5bFyNvP81nrpeIdo/HUUUK3YoeDUL/UkzE2Kgkzy1I+ik6M36DSjjPhWy4Ixn
         oOqs0Go75Lo4l5OzG3IuMWDXoIHMKEyGKIKx+qzgyUX6lcFVxb9JvItXKyZtHgas8+T3
         gz7naTDjrcpacDIocAOeDCrWAGNtmbvEpsS1PvJiJ3XFvymcN0jEMlXgvSpXymcxqj2J
         aGMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795629034; x=1796233834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RfPxo/aBNHz+uEsj4QdIP7gFGpuoo0qtgUa4pVHLuDE=;
        b=RzrnzIOddMSy0/gtb8UILgu3s7kq+AW6xMj8vnNYFlLsUstmpxo2bu+ZL/+t6ZA395
         ZgNjTGGZS8Iis6a1xMG3pPHiF2pS+lzMfEdajHXNHC5vIkDtY1ektkGYxh8fsCEalPl9
         bjMP/hJ7scXuutgpkiha1/sTpcU04wlV7ZKqA0HzLXF7oLzTSRsn+6PhBIY/WfOIKf4E
         iqJq81myqrwEybsZpA0H1mbCincek5Sez0jIQsuMApfR3WrPaLdWWts4UzTTARM+UOKF
         1VJYEVYhGBCh8rM6LzVZGGxsitpbmTDtypVh4HvV2IdxbHox3ImYtRQggVwFMdKbuohZ
         5e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629034; x=1796233834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RfPxo/aBNHz+uEsj4QdIP7gFGpuoo0qtgUa4pVHLuDE=;
        b=aQi/HSmye274NfyqKs3FmFNyMdHmKTxLW0jc3OQqajHupY/H7mXx4iPlhVrDSb3i3s
         42+Hhp9oqPtbQmXWA1ImVcDXPUAlu59lyu+7lo96A91wBxE27ox3AoRAtpc2kItOw+Gi
         0lEsUJ+ItDNEY2aPbdMLfzNiw2mmFY//ApsNz/elusKEfc9/K4BcBZpBkSZDdiKuIxd+
         Hi5ScPOKUVjgndEptflJW/VmEivtHvxGP4RlOF59k8XFTQ8QjmgaiqcP96JJK7DuUKcr
         yX+/54WJSfD7W29kMLy+ayj86hav4WNKirXFoIldQgR0swgicwPzYHNzYI4WTVwLLvKm
         qpmQ==
X-Forwarded-Encrypted: i=1; AL+hErFVT8q+/oQirqvDBVJ41KaS6TX++lxih1D0JBm3gTkwIz1nVF0ebxeW9CgEzOkoMwGNbDvxMDU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xleMSRE52zg3f2970T6m1KX76KPHX0Q77atHQ/a8T9QN3bkB8
	rv8OIbg30feUaRAwXGaft/a01NcS7BQrKLrzkiz5qxsB3jvmo9/FqqYZPP7qQdd4DmWHXzWJr/5
	zaUuw+YMFRAlI3Mf7DqLkzKDO+2uHGRw=
X-Gm-Gg: AZFdTZckq2owg/QB9sOI/afvfNwD6ksEExmZGiiWt+n6bn9s2VHuPALlDzU+UzNRFTG
	NppxD5H59DBTReJa2J2kESvpHULJZUsuOib+gytw8WpWOCMb1aYk00WVnZFed8TLcgXFJOMtuIO
	m5JM8TwvBu7P8pK71cr2LdHeDGORbU/L7ttb3EdnmPvJdN/AprH7Vb8F3BJTgzSqf6XrzrLli43
	TN4EJYBVzt8E9rh/zB+f/bN5ztFTA2b7PNVkT0Vp62w1SkYaOaB9htLfolGetidHAmifI2tdO/A
	lXoOnE5S6dALBz+FuzrGpqdXFP8yNVA+dtaERKMVO3Wp2OMImt0kiajeqOQ3e201Pda6wwuEaOi
	nJ/ng4gAhOUrxgV/g31M9ESPyRZvEFYk1V6ES6axcu8f6SiV/cg5OCTqcEbAFa92an1l9m2feF+
	3f70gKNqiIZEkIA2W8QOd8BpzF5B8wP5/Yee0bBgw2jv7ZvThWCqkcev5LweMNujv/SyNf
X-Received: by 2002:a05:6a00:3686:b0:8b1:e117:3978 with SMTP id
 d2e1a72fcca58-8c87b4efa61mr19112715b3a.18.1795629034041; Wed, 25 Nov 2026
 09:50:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124022107.32283-1-ljp1205831794@gmail.com>
In-Reply-To: <20261124022107.32283-1-ljp1205831794@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 25 Nov 2026 12:50:21 -0500
X-Gm-Features: Aa3M54rTrVlRJogvLdZlOlBUntzVGX-lKN5GyjMtLtm6uLQGHabDbIb2QZZt7fY
Message-ID: <CADvbK_ekpmyug=RZ4nLUotK7jimxKrw9gUiEyF0zzopM-rzPUw@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: preserve the peer transport during INIT
 error cleanup
To: Lin Jiapeng <ljp1205831794@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	vladislav.yasevich@hp.com, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lin Jiapeng <jiapenglin@tencent.com>, 
	stable@vger.kernel.org, TencentOS Corvus AI <corvus@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:21=E2=80=AFPM Lin Jiapeng <ljp1205831794@gmail.co=
m> wrote:
>
> From: Lin Jiapeng <jiapenglin@tencent.com>
>
> sctp_process_init() removes non-ACTIVE peer transports when INIT processi=
ng
> fails. The transport matching peer_addr may itself be UNCONFIRMED, becaus=
e
> sctp_assoc_add_peer() only promotes an existing UNKNOWN transport to
> ACTIVE.
>
> If no ACTIVE transport remains, the cleanup can remove the last transport=
.
> sctp_assoc_rm_peer() then interprets the empty list head as a transport a=
nd
> passes the invalid replacement to sctp_assoc_set_primary(). KASAN reports=
 a
> null-ptr-deref in sctp_ulpevent_notify_peer_addr_change() through
> sctp_assoc_rm_peer() and sctp_process_init().
>
> Keep the transport matching peer_addr while removing the other non-ACTIVE
> transports. This preserves a valid replacement path without retaining an
> arbitrary UNCONFIRMED address from failed INIT processing. On a live
> COOKIE_WAIT association, T1-init remains armed and can continue using the
> retained transport until association teardown. Successful INIT processing
> is unchanged.
>
> Fixes: add52379dde2 ("sctp: Fix oops when INIT-ACK indicates that peer do=
esn't support AUTH")
> Cc: stable@vger.kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Link: https://lore.kernel.org/netdev/20261112092114.12458-1-ljp1205831794=
@gmail.com/
> Signed-off-by: Lin Jiapeng <jiapenglin@tencent.com>
> ---
> v2:
> - Keep the transport matching peer_addr instead of an arbitrary last
>   transport, as suggested by Xin Long.
> - Update the subject, cleanup comment, and commit message to describe the
>   retained transport's use by a live COOKIE_WAIT association.
>
>  net/sctp/sm_make_chunk.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 15c2d87575a8..65594eaaeacd 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2525,10 +2525,14 @@ int sctp_process_init(struct sctp_association *as=
oc, struct sctp_chunk *chunk,
>         return 1;
>
>  clean_up:
> -       /* Release the transport structures. */
> +       /*
> +        * Release non-ACTIVE transports except the one for peer_addr.
> +        * Keep it so sctp_assoc_rm_peer() always has a replacement path.
> +        */
>         list_for_each_safe(pos, temp, &asoc->peer.transport_addr_list) {
>                 transport =3D list_entry(pos, struct sctp_transport, tran=
sports);
> -               if (transport->state !=3D SCTP_ACTIVE)
> +               if (transport->state !=3D SCTP_ACTIVE &&
> +                   !sctp_cmp_addr_exact(&transport->ipaddr, peer_addr))
>                         sctp_assoc_rm_peer(asoc, transport);
>         }
>
>
> base-commit: 145480b28ca82e9fae789427cc4569e596515a32
> --
> 2.55.0
>
Acked-by: Xin Long <lucien.xin@gmail.com>
