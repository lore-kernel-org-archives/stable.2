Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F0A3563D4
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784244398; cv=pass; b=Sj4vnkXEA67k1CazAKX5meDrzsA/G6wlQA6y73rzTFqcGMDxTHo8a8gW/9uLfq0itehtsNciH5jZqjMyYLF6PxU0T64Reppr2y0LSIFjDLZpFiQxd53g3+Me82+KvgrgfWTN3mJ+spjBfOHJx3CDagDJT7YaGd+wODo7BN+spa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784244398; c=relaxed/simple;
	bh=g+zbN7i0Ld0/5VxtaP8iuYmbfEiLGqlXkkdPJoQb1c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYhlfeO+SbBQvoGAMRXLQitt3Z0lRT7utIC2hCVR9JkOsW0+xPz9iYizXS/oMyL78D03otN1JCNhk7W36/HRinj3l11J21PX4S6bU2KCu0lKwWtWlKLkjgdPNIPENv/I0IX/5S6Hqkk6k8nDYiw9kZAuE0vF1T9TgHH1tskWIH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfvxGUUW; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfvxGUUW"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so895981e87.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 16:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784244395; cv=none;
        d=google.com; s=arc-20260327;
        b=GqSIdid7UFWLaEQUrCxH18BrGjlOjQBbS0HvlM16CrnlIIIbNSKLXRQdWHEgzbmsYv
         VB0NlZJWnxyiE3BNWiuDHB3gUUUmc2rpUG4+VzIyxJlxPwgoZBQCVHNI7c6hNiw7Rggo
         QE5+oddxh32BTQ3XTxH0jJHhE0wecajVzXpklYaqn9h2FrWVBYL8EsL9OUmk+HTqcxdJ
         8QyAd5k+Vez46d7XFi0iiMmKfUvMv5XjMVXa8eYM/7qRxOuwgvNN8wBUD+L8CkYTmTJT
         eUNYmZZhveNPQS6t0qU2fHCWqcvhyq/rX3l3lgzZQAp7mT9d5YbXiuY4S3wkjDg0XBrc
         KHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TUDZG6t3tBj+v+xcwcH2u+ZyuWYZ6P6HE5tnGyLIGcI=;
        fh=FSbZmTMLfXJ7p31oQhNnTR72TUVZdJFXsVw4J9+RQi0=;
        b=A6DiUM5wDQXsEbemuL5xeWNE/EhuEoK9sL7HVEL7063mQbPhrlsrC9d8+kppr5gBzZ
         2gI8IjaLnppvBdPRi9RSu9sKsRh4XHxIk8fAXlMjx+gY6A70nUxLwHB6hC4BE/RQSyIg
         I04/+fPz2I1UrKPzc8mHklHaDFfosq42qtH6H4TKRk2FJkP36p+RjKIvbHno2+SqHVqD
         Yerdz1vnQHAD18qXug2LgOP8Xg4XHqBU0fiuz6dPgh8qd0cIgiG0k7W9pBAzztAmmhW1
         8ihu7JiCZMHYI5idaQua/vlmq/1ggRRuZ/SGHdBd/DIU65421C8gcmYGLPYl3uFgRMFa
         Wktg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784244395; x=1784849195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TUDZG6t3tBj+v+xcwcH2u+ZyuWYZ6P6HE5tnGyLIGcI=;
        b=FfvxGUUWz88xMIyR/P65lKvhJUVGzZRh1xRb3LK8gNM8rbyfmmD24V6PKs/yt7sBzb
         qTZL0SYZ9shXd1wSwj6/jl8rttXVBKbr6RwfV58w+vb1em/4AVFGAttjqR52t9+/+Kxu
         D/HL3+K/sOegCtjfy2XO22/BCpuw9JMLVOcr0EL+83E8XSHvCLXpTYh5Ejk8Dh69LvtW
         bTrroFmo9D0xa94ecRtZnBCjmfQWkXJTVAL+7885Fff4G7J7AUIjW63F+9Vbd3r0tzeh
         GHbWYttEvqTzZoo/c+tvEz6HdrBDejW/eL+GSUhjDJMIY9yl73ywzNF3Coa35zMEwkk7
         Q+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784244395; x=1784849195;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TUDZG6t3tBj+v+xcwcH2u+ZyuWYZ6P6HE5tnGyLIGcI=;
        b=LVQLBiF4Xui0eh4PPx84QnD3fIS26SVzgNh4sUis00xJBnozGmWfS1QrmFtDULoTOu
         2ywJ7bsYRbFiy3AojMMx21nEC2OiMgxEkqL/5GRgmu4woa9JvIboWjvNcZjS5oso/r1x
         LJPL6R459zyC46+b2EV7LWRntbsET74wXVSXDX7lAW01ksiREWZrgIzoMbl4p7uA4aP4
         oTSPyMUhmn4jrwf7Wc0QnazsaoWtVCRqLXqpaWfBf5LodvTHy0zEl3F5jtitWXe0/HxF
         Qeq8qsMWNe8sBHPX43vkg8c73jQtistXSmyVFlixWpU/WS1ygryYpEriOTtWnzp8Jssr
         sERw==
X-Forwarded-Encrypted: i=1; AHgh+Rot6vAFX2ThzP4jaQpoSxPjbIs/ZxJC4HwHo/AikYtrbFUQ6S4HMumAGBohFQ6EY00Ill2iUkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGC00nYxH0mkr/Nip4sz8G5PrDzru3UPdGNfMOfH8sT57dvGaI
	IeQ8+qBrxnFAxv1vhj446aZXJce7YVMttbIOAxYnOz2IFubGn6XoxDHAN53waM0WbcF6vVCcxbx
	NpVVSdyNHLcXaRRizY42SLLA1khHsSGw=
X-Gm-Gg: AfdE7ck760BJNytwOH24ZeeHFBjUbH61j7cXMzFk9FqPEfUrAiqqsW1uw5dxy7dizEi
	Md6gE9hKVZhbw2sG9ey0uhyU3RvujgQpmUCRKtlBWKjJzBg1dSvllOthV9r4sd5agUIWzOh6X0K
	NaFD/fXNl08ns35+nX941fLI1PkPsEBk7QcWbvsUXcsPXB7HUiXLWYRLl+eiszLJMjIaIlY+nJv
	Bk+1YSArI1wKNljY7nyAwdWO8nBgg+bEc2XJVDmV0WkzHCpNSTjrFryx4eaOhw=
X-Received: by 2002:a05:6512:1253:b0:5ae:badc:47d3 with SMTP id
 2adb3069b0e04-5b28a1bb566mr937877e87.28.1784244395307; Thu, 16 Jul 2026
 16:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <714A2D6E-5B61-4185-AD6C-328250C8E040@nozominetworks.com>
In-Reply-To: <714A2D6E-5B61-4185-AD6C-328250C8E040@nozominetworks.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 17 Jul 2026 08:26:22 +0900
X-Gm-Features: AUfX_mzpJvJDTCE5ql8NEhcy82qiN6QH2IrJOqE6Gxg5V3dZK23CkDPcqz3eTvo
Message-ID: <CANFS6bbAW=XRf=d5Pb6zkyoJkAOQM1H3Wu6F5T31s8j664L52A@mail.gmail.com>
Subject: Re: [PATCH] fs/ntfs: Fix index_root heap OOB write in ntfs_ir_to_ib()
To: =?UTF-8?Q?Alexandro_Cal=C3=B2?= <alexandro.calo@nozominetworks.com>
Cc: "linkinjeon@kernel.org" <linkinjeon@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 16=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6:46, A=
lexandro Cal=C3=B2
<alexandro.calo@nozominetworks.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Alexandro Calo <alexandro.calo@nozominetworks.com>
> Date: Thu, 16 Jul 2026 11:30:04 +0200
> Subject: [PATCH] fs/ntfs: Fix index_root heap OOB write in ntfs_ir_to_ib(=
)
>
> ntfs_ir_to_ib copies all entries from index_root into a freshly allocated
> index_block_size-byte buffer without verifying that the entries fit in th=
e
> available space. The entries in index_root may be larger than the usable
> entry space in the index block.
>
> This can cause OOB writes past the end of the allocation.
>
> The validator ntfs_index_root_inconsistent() checks that entries are
> self-consistent within the IR value, but never cross-checks them against
> index_block_size. There is no bounds check in ntfs_ir_to_ib() before the
> memcpy.
>
> Fixing this at the sink in ntfs_ir_to_ib() since
> ntfs_index_root_inconsistent() validates the logical consistency of
> index_root as a structure and a root with large entries is a structurally
> valid root. The bug is a size conflict of ntfs_ir_to_ib().
> Also, the validator is called once per inode load in
> ntfs_read_locked_inode() while ntfs_ir_to_ib() is only called during a
> reparent, a check there adds no overhead to the common path.
> Moreover, even a future call path that bypasses the validator would still
> be protected.
>
> This heap out-of-bounds write is triggered by a crafted filesystem image,
> which is not in the kernel threat model, anyway, fixing memory errors wou=
ld
> be nice to keep  things secure.
>
> Signed-off-by: Alexandro Calo <alexandro.calo@nozominetworks.com>
> ---
>  fs/ntfs/index.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> index faa7ee920a3a..529697b5891e 100644
> --- a/fs/ntfs/index.c
> +++ b/fs/ntfs/index.c
> @@ -1112,6 +1112,7 @@ static struct index_block *ntfs_ir_to_ib(struct ind=
ex_root *ir, s64 ib_vcn)
>         struct index_entry *ie_last;
>         char *ies_start, *ies_end;
>         int i;
> +       u32 ib_cap;
>
>         ntfs_debug("Entering\n");
>
> @@ -1127,6 +1128,15 @@ static struct index_block *ntfs_ir_to_ib(struct in=
dex_root *ir, s64 ib_vcn)
>          * as well, which can never have any data.
>          */
>         i =3D (char *)ie_last - ies_start + le16_to_cpu(ie_last->length);
> +
> +       /* Entries must fit in the allocated index block */
> +       ib_cap =3D le32_to_cpu(ib->index.allocated_size)
> +               - le32_to_cpu(ib->index.entries_offset);
> +       if ((u32)i > ib_cap) {
> +               kvfree(ib

Could you add an error message?
Other than that, it looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> +               return NULL;
> +       }
> +
>         memcpy(ntfs_ie_get_first(&ib->index), ies_start, i);
>
>         ib->index.flags =3D ir->index.flags;
>
> base-commit: 37e2f878a7a660a216cc7a60459995fefd150f25
> --
> 2.47.3
>


--=20
Thanks,
Hyunchul
