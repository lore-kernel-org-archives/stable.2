Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2254499AF
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630447; cv=pass; b=eQYFNM6MHjyxkSvnqoc7AA7fLJmF6TArmlXGm9rPD4p42TRltOYToBqOSby6olhL1gNdffoF7ZYJ5BET1kuSW7c4f80dUNsXFj3gr3IcK2tPFleVuvuItVlVUBLQPkc5rXkU7i8oKM+5GEqFEzhb++HbghJcVnNN9WojzgSTYj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630447; c=relaxed/simple;
	bh=6CpaLGU5EUy0vMVHx3KnNb4rh6my4kZN9Yxb54V1PDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ko2lxx3RjNeLu4giNJnWGBLtgd/arnK2fU+c+/TdZjk4BdDQT/KLIXYr8ieqsv7PV7F+1z3zzkYBNkcI9toEGXm5mancXzWOyFo7BQFpdh/GxRihoSl6Dc68s+U6oj0paCKIJV6vHQK/DXNg0STKzblbzhN7ZU05GMbVay3MgCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZtxIq3u; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZtxIq3u"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c2a449c57so1361691cf.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 13:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783630445; cv=none;
        d=google.com; s=arc-20260327;
        b=aTNS7gxmQhikOwCI0aH7lxHkG2gvmpomxOnxykTyoGu1Y2KF1Hw2JS/naOP8eG6jSv
         Sijt45+000fC/CSarP7c24j/ApwJOfI+vdWhoUuGx0hlSwG4leZ/4sq1LnG66kbWuX8C
         AffeFAotgwJmz6grukudisKCr4nUAGj6LvMYAMXQyQMxWCS18ybuF0gRvqyeZFqRTLXF
         PRth5zZWfdse4hzXubjh7wWB9gjZJihSN6AsVORtnXuCdCy/2f5aHmfODmiJSktkxHwo
         K/f97mSmDZYj4LRbrvCZfDN0H8Yajo3Qnzg87lIOJvWtrE04ablhVTjBEia325j24ohD
         MzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x5evxCKgLnEs0QTFditB/MvAAlaTMW3SCAomkp6FBCA=;
        fh=qkhYLtT70AvcSAx3d5nOE221/2mXz+ZeAoRBU3MdIDQ=;
        b=W+I75SqV1AvEnBmLEqF5qb+wgvfDKLVAYPcbqOtw+c6E5r6glSOotWNMZVtf851k6h
         t1ov93HpvV1J1TN/NMs5zvkeTQ3FRG1LUHq+76tu6bpr2iPIkn9amQWXYsCcG1OTH9zR
         p62bmjFlKbPTpxQ+EkSZtKnsTSMpE30l5zgiqFqb2uzbMf+BtEYFpFVeX9ktl1PwHQ0v
         DHn5IIclDPDY0kmdG3YCimvzmZLftamto+I3Kbn4dmn7IBiFXvNIE7zggeA1OJd44Alr
         yiaOfFc6PFSCETIHaGGzlX4OWP1i8jXqzjxTYOgTrFZhKpcBsdFWns5BxrOOym91pb9b
         FWVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783630445; x=1784235245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x5evxCKgLnEs0QTFditB/MvAAlaTMW3SCAomkp6FBCA=;
        b=rZtxIq3ucANik3O6tyHtVpY3ik9fVH0fvBT4g2sfeKyXnH5FGpn/CZAtH8O6wU9ywk
         E5742fXSo0Zr+VEiqyPWRTUkujF4/hK/Rg2/FJi/GD9hPiHLuTp0Ede1OoWculBEsUtG
         Z/OBROWxtThsbwncLzq9OEUGI3aqHMySO+gbup0foDTiHAHcG4hxKldx8/q/Gq1BMAyb
         E4wBO5hQJxIVCyYfxP9sFWZwEQiirKMq0f2dL5gN0T+y6LOvmlaeAMxLe/9MSEPH0aSH
         8eW7deSw2st2Xf3KXHRKSOapxDaQZHN1sqQ3utQlozkQsZUSzf1MzWIP8LZKI/RuePtD
         yelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630445; x=1784235245;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x5evxCKgLnEs0QTFditB/MvAAlaTMW3SCAomkp6FBCA=;
        b=Vnmqpxo0eenZ0Gm8xhTPdpI7cPCecjdUNriUbCJO5fYyq3u9EcQY9ylfqhk7M/Mevs
         om+otQ06xZbeyBiQkToozX5kefaTwRFYvJcqYqf6SzQvqXgC3+Ys86+cICsOFSvXv7YB
         mxP1Ss5ZBBmgjazoEhHSHb3qSe0GB6mg3nv/o7npJ8ddIJtdtE7OgmD0SQGI4bnY9BPI
         H8PoFMi4Tnh//Ov5LL3Qr1Ye1r0R1zvt2fGJ+wJ+aj70l2lN+mu8jNvQmzkVnXnop6Qp
         lR4TGYqWTZuLXOv0kGLC3E6aj0PMlDKMSOm2qlxbakSIbJo6WgfJ6VRr1xxHG3v/2QU2
         7VHw==
X-Forwarded-Encrypted: i=1; AHgh+RrUiDJnwh314JuLrUR3UaSobmmu4Zg/bC50zW8aUEiA6BFrlYLWz7fcw8OCGIum7gG0Rp3dosw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF9cbzVRrVk0ZbaYvCWrYRRnMFrHhq5xHeD6dX+hZp7QeP59NF
	DRJUX9ZEifMz77WOzoOCNLG1rNmY/UN59zY+vzGljoNrp6x+VKRGw63k9Q7tfCTUDyWoqzTUKjh
	w+kSp0gsoRKJC3T6PTnHJ+lyzfZCPMZw=
X-Gm-Gg: AfdE7cnpfVOaQidxdOjTBw1DAwPYOQVedRSxF0d0R6IxEPUSfaj+tj5yRLkH8Cbc/im
	VtfyHalKSOyM6+HQttdNb6xRjA6TcPDTC37dqqyU4ll069FQTIbmVigPGi+KjuWSPku4UDDMEwk
	flDcCSIkl0kgfGXS49dRT0fgOd4hdEoZtuBMURss+7Px1LYnLYezPQf7L+n6hl7YKElqcDtBNBs
	dbdAqaklBfec6y+WfmEPEOvK1DSnxT/Mfx/9s6r36ytlqw4HHte+co6vBv7eer3JN3m0QHFVYMw
	0LpnRYW6J1tuegvPZaQ0xe1FQqKq1qIbo9GAeL0Xm1SkM/dvhPZc/czSLwXc92xzjGFho7SOsS6
	Ryh6uy/u97J5Qcl1vRj7kRHci96kt/+gRhQfMsJxMVKwD2iRVdIN2g5GS0ImO9daa6mR3x3xnlh
	FSzAmSpF8J52Q=
X-Received: by 2002:a05:622a:4d86:b0:517:906b:c043 with SMTP id
 d75a77b69052e-51c8b30194dmr112033741cf.36.1783630444769; Thu, 09 Jul 2026
 13:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709155440.2132459-2-doebel@amazon.de>
In-Reply-To: <20260709155440.2132459-2-doebel@amazon.de>
From: Steve French <smfrench@gmail.com>
Date: Thu, 9 Jul 2026 15:53:51 -0500
X-Gm-Features: AUfX_mywyJw7Jb2CzVjlGHcEYnBTz-s8FGewaFQhIIMmJBSp0jiEvTm8UOBbBuo
Message-ID: <CAH2r5mtg=Ko8FMO0dkTw72wu8rVJuC312bQ9QKUyNaL3gf_wbA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: mask server-provided mode to 07777 in modefromsid
To: Bjoern Doebel <doebel@amazon.de>
Cc: Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, samba-technical@lists.samba.org, 
	stable@vger.kernel.org, nmanthey@amazon.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next

On Thu, Jul 9, 2026 at 10:55=E2=80=AFAM Bjoern Doebel <doebel@amazon.de> wr=
ote:
>
> From: Norbert Manthey <nmanthey@amazon.de>
>
> When modefromsid is active, parse_dacl() applies the server-provided
> sub_auth[2] value from the NFS mode SID to cf_mode without masking to
> 07777. Apply the correct masking, same as in the read path.
>
> Fixes: e2f8fbfb8d09c ("cifs: get mode bits from special sid on stat")
> Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
> Assisted-by: Kiro:claude-opus-4.6
> Cc: stable@vger.kernel.org
> ---
>  fs/smb/client/cifsacl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
> index 6d572dd995d79..a0a68404fbff7 100644
> --- a/fs/smb/client/cifsacl.c
> +++ b/fs/smb/client/cifsacl.c
> @@ -962,7 +962,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *e=
nd_of_acl,
>                                  */
>                                 fattr->cf_mode &=3D ~07777;
>                                 fattr->cf_mode |=3D
> -                                       le32_to_cpu(ppace[i]->sid.sub_aut=
h[2]);
> +                                       le32_to_cpu(ppace[i]->sid.sub_aut=
h[2]) & 07777;
>                                 break;
>                         } else {
>                                 if (compare_sids(&(ppace[i]->sid), powner=
sid) =3D=3D 0) {
> --
> 2.50.1
>
>


--=20
Thanks,

Steve
