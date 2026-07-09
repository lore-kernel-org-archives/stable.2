Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72232FA0C6
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635354; cv=pass; b=GeMameebqxonEBW1UnSYeJRvZJzxDDVE0XhnQsjMxk+UiArtKK14TEWLgIfMHjDPgmJLsZlzBcGUpmtzGMZOuEvvZ0cgDFivVY8lYhLW0sGLJKwf8dl+cEcb4Yxwsy04KdDUAN4jp98HToCPhhXYMtItX6ogJckwUOkRuy0thq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635354; c=relaxed/simple;
	bh=jWjYzkNsjJZH5yGWvGBiZ+VdzbjgCvhdfeVBWM3yb1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtffKb6TIKZa0tlUXrO5yJzJ1UTYRXRLKUTEeabvMjU+ofeKn+Lr344e/wiHsmBby8eCvSH8+IChy2vEgyVGjIx/I98LTJ13hmPZ1ApVQEoSHotZai9R8EeXXxg3jT5b1fkX38zq85DTwBjiCI+9gGmpqQQ6yp7hPXWaJ6sWFG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRZO5o6B; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRZO5o6B"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f0079614b2so4027086d6.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 15:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783635352; cv=none;
        d=google.com; s=arc-20260327;
        b=ZI2BJ0mKn6WvBueWgdKGQfWq1ivAoo9vLPNIdM9rv+30YsHjWDYxA/xN87PVp5faOq
         po8Wo9iK5RW2pQFOZ+3MjwShLgHCIDgTv9M63mIFkz9gJNAwWKP4BfuTD80rMqt5s4ow
         xQGZZ3fdP2RvUshW66KGXP7UuURRv6dt3+makaUojutvI2PRAIpiGsAtLnwMMx+RgPOK
         G+UVhwL711LAmuw0jNZMS8TZC1DUgdXD/aDkRb3vXGRvnJdIlMQALOtpj/C9QCPFmrpa
         iVdJS+F1sPw1XEqxO7oS/TmBM7V83kNbGUyg3YavOTl85VexZ14IAaLvtygOLUBNH5Pd
         UA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/DCoOGjB3t2yqI8PL2v0s5UjSbFRMsQqTYSs+Ahyr1M=;
        fh=4Yo1DHnrGgqyNOLV6R/M02JnjVXkmzA8zePFmotGt6I=;
        b=b+w8o/tjHRnTo7BhAfOlhDtqjFfutLWrmGYTBIdxwCVMq5aDDTPQvJ+jzpVzH7PvCV
         UAXlBaQx8lkRHJnHXnI/EyMRDrSnHFeCilqBzPqbxr3KaahcdaVSF3EEP7n5g7MSprar
         BYa2y6vDd4Jbvw4A9BpISuc1cv+gvuugKbv4bn54P0woaN/y18jh/vKXJNDXyghprdG1
         cYlpO9Q3+zEfPC4c4siq/rUJ9gKdBpnOK2XD0BtPA4Piwe+LuN6sHMeMyOgFMS4QlVrg
         rOuPCpcXxbLxfqp+fCPmt23zMycW19TMk6kvt8hB14j7VPYQOYvlR+821F2exK93R2+o
         UlrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783635352; x=1784240152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/DCoOGjB3t2yqI8PL2v0s5UjSbFRMsQqTYSs+Ahyr1M=;
        b=WRZO5o6BySSdSS+OUVab5zEBMfpdLUFH6XELkOsYBvkNAdctvOlxatdqVsYsXBB3Yw
         Wgy/wKCnMOQdO1OvURaNezwAmhXYLa01JgdafwxDN5izAiXK+Zfvva4Nw4Nnct5gHGZT
         wowHvIuUQGqafaVxEbcW3Awwa2dv3JDppX82qB9+uZU4ap7Y9Je0GGp9gulM4wQiE//y
         Io/4VGng39XDWOgj2oO5NuNpbHbcYil6fflukPMMhhAOrEkWNKVdZy51n1KQ66USbd17
         fDUv33H2QFkNH6TR7fVsa/sjFw5/TyjRU5WFbcqclIQJWikA7+Mobfkaba3nQSxz9lxW
         LYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783635352; x=1784240152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/DCoOGjB3t2yqI8PL2v0s5UjSbFRMsQqTYSs+Ahyr1M=;
        b=KL6OVNlSVzXMSdXQzKIiciBAa+wChjuEr/OR9f5tCsT+zs3A0TSAAlNn35dh5iXCxc
         cstJGiRZoyQYUn4+cLar3B6C1TWpX7Pve3m9uc1TnmmSinY9yvSt4+kj6LC0nBIT+CMQ
         2K0UkpIZHaPvA49Qa+pRXDH0Q1Ozyp9H9qabTM/TCQHhDJkx0y6TIVaSRXhnMP1Dhqdu
         Xwo7tJwvBcK/DKFlE0SvKkcgS3vCwwDVOmF1zOuWggg38BhnqJPer0IU4jlPBrcHGJJz
         6eFiyrX+POYSsEPMel1nuMVVmQIx79M4xqe8i2C3KlFePEQccWsfUNso/wOHQGabOkKr
         xyRg==
X-Forwarded-Encrypted: i=1; AHgh+Rrf5SwZuosxELG82oGANq1DEYz+woi9F0YnxO9s+x03Q6UtTBAskHt+PcFzs/4oI1VQyTunJ24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSB4Gwipi64gu+leQ6SPO1SKb/vr3Bcrl/gOjY9oJjGFANboWZ
	ODvLvcIKAigxEz4YFFFe2v8pALefFOV2PAT0ZT9eUPSsu/yGObpmrGzPfrAveaiMSIw0CaNKxca
	bDbVMKaZtS3MY7QNWDFbQuaQpMNW+Arw=
X-Gm-Gg: AfdE7cn6sxoUeSfIFeA4ZKYNHdZSu9yjWg9aBKLZAXFDCpIwWliPGNxlRUFM37RiSRa
	zPAIk5P2Q/YIyAUWgxgZ4FU9LBZXkIQFbjDMDF54IXk9EDwseO/ZSk7ClCulQ+kexFOIatx2sU8
	4T93BKisSjy1D4vhSB04N6nTEuVNNEYIlrKi1yL7gtBEGt3XW7kDR7BMz/OY7MMaV+bA3jOiCXy
	9EACSRyfRMf7t5bWw3RMo+UYBM/IIJEfCYOzf2rSuwVbXDZ32wPmCzPZqgQydRGU8a9SIsWEr6H
	ypKtrbqx38rT6yMZ2N7WKnk+YoO+zYVjgv471Uq+Kg21+xBin4MCt0f22VJtmbZobz9Su60v33Z
	xatISZwcaSb41wKEF/L3/isRcAu07TyqJagbkU5pLIf7ohqp4pY2k8avozr77uZA13XvtcxE9iz
	iOTg1SqEV2iA==
X-Received: by 2002:a05:6214:410:b0:8ee:d9e7:be2d with SMTP id
 6a1803df08f44-8fec04e89f8mr112612426d6.7.1783635351816; Thu, 09 Jul 2026
 15:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709155440.2132459-1-doebel@amazon.de>
In-Reply-To: <20260709155440.2132459-1-doebel@amazon.de>
From: Steve French <smfrench@gmail.com>
Date: Thu, 9 Jul 2026 17:15:40 -0500
X-Gm-Features: AUfX_myw31UoHX4SuoiHG9s00c7k_AK6flUf0AJ6VGinZ_8FPM7X0vQl2j6Y5eU
Message-ID: <CAH2r5mt_Pd=wd-pXdaYkNpWE9NfeM0bhnEy-LKuhgOZchVPTJA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix DACL-rewrite heap overflow in id_mode_to_cifs_acl()
To: Bjoern Doebel <doebel@amazon.de>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, samba-technical@lists.samba.org, 
	stable@vger.kernel.org, nmanthey@amazon.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When I tried this it changed the length used (for chown with cifsacl
mount option) from 88 bytes to 236 bytes
which seems suspicious.  Have you been able to reproduce the bug this
patch is supposed to fix?

On Thu, Jul 9, 2026 at 10:55=E2=80=AFAM Bjoern Doebel <doebel@amazon.de> wr=
ote:
>
> Budget the destination buffer for the worst case in both branches:
> every rewritten ACE may take sizeof(struct smb_ace) bytes (which
> already accounts for an smb_sid with SID_MAX_SUB_AUTHORITIES
> sub-authorities), plus the smb_acl header that
> replace_sids_and_copy_aces() emits.
>
> Fixes: bc3e9dd9d104 ("cifs: Change SIDs in ACEs while transferring file o=
wnership.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjoern Doebel <doebel@amazon.de>
> Assisted-by: Kiro:claude-opus-4.6
> ---
>  fs/smb/client/cifsacl.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
> index 07cf0e5782337..6d572dd995d79 100644
> --- a/fs/smb/client/cifsacl.c
> +++ b/fs/smb/client/cifsacl.c
> @@ -1812,11 +1812,13 @@ id_mode_to_cifs_acl(struct inode *inode, const ch=
ar *path, __u64 *pnmode,
>                                 cifs_put_tlink(tlink);
>                                 return rc;
>                         }
> -                       if (mode_from_sid)
> -                               nsecdesclen +=3D
> -                                       le16_to_cpu(dacl_ptr->num_aces) *=
 sizeof(struct smb_ace);
> -                       else /* cifsacl */
> -                               nsecdesclen +=3D le16_to_cpu(dacl_ptr->si=
ze);
> +                       /*
> +                        * Worst case: every ACE is rewritten with a new =
SID of
> +                        * SID_MAX_SUB_AUTHORITIES sub-auths -> sizeof(sm=
b_ace) each,
> +                        * plus the smb_acl header replace_sids_and_copy_=
aces() emits.
> +                        */
> +                       nsecdesclen +=3D sizeof(struct smb_acl) +
> +                               le16_to_cpu(dacl_ptr->num_aces) * sizeof(=
struct smb_ace);
>                 }
>         }
>
> --
> 2.50.1
>
>


--=20
Thanks,

Steve
