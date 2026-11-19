Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121774;
	b=F01bc86Uh5IQbqoKQsFhZY4I5s6ORrd+BvUZbeyOGcnqmiM98ePMckkS/1nLf7FpOPKc
	 F97dajEiJb+YOkBn/7fXHiNknQaYBYGWZbYTVFzmNOGscATXptkjDRP3SaBDI+J5qiDcm
	 5b3RzjQMXUlWDoslq62/y0SFRVnsAclm+UfPaExYCyF3AiH7rto2tWJk27wj17bTLAmic
	 nem1skyxIDFh8+2+lhwpK4eo7/cSgo57s/V87xFQMKsXaeCgG2M1vN8cKdaCkaCj1LWmS
	 8RZW0a0fxfYxhZcYruRmoOT7lRhfLqf2uN0L4wpLPlRHRSpcIryt/0Wpsk/w63iwGVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=vMk589fI0vloaWsV/PEYRmc60/eNdwTMIDfcB72CPGE=;
	b=Vv79u4odKB6s1K+KYateo76ogDcKEXxYf/5hXgWYP7Nz+VnqXGrWWe0CwSWlawGlvezv
	 HPZHhK0PFomtKG6ZmjIqcls09/wTXpcuTq+8Ng4NhzLSmsxr9RMJx3+iMX3NVt+6mPzSq
	 LQL3ReUk9oUj+VPNBHzd67SulQr1GZl0SInv8hny4VgzX2EpVU8XSyN8PQDUTMAGgwyMi
	 QKmBO9o9AxBUIogThHMEgaaalzmHT8qxsrN4OvC1cAmm8CbDNGsdxYDHHGjqZY0OcWpXa
	 W3QokTu2q/pe/GbEbNRm19+WFV8c+MIBaolvhMZUOfKjbyThnY6FKHLSYzXMFRjTkmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="m7xrfM/c";
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC0606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 20:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9FC0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m7xrfM/c
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67c246c0c60so1220246d50.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795121772; x=1795726572; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vMk589fI0vloaWsV/PEYRmc60/eNdwTMIDfcB72CPGE=;
        b=m7xrfM/cGpcT3UqJQvE5gqqJW+zBwVrLhE6QgKrMuEKjZkiO7ZfhhNGWB2a/1tc9bH
         iYEQS6utZfKeWL8g9HbBuXFoms5VI2h85P9Lm74n1BU+d9qn1dw2jJ/v+BBaGPalEDZS
         oJvxUsh8779UM5YKCdzYFsgCqfVGe2eXz7kGJ28IXz/VSjZCxxLXUglYiWL4KMhP9pKM
         cAk+/XZfU4kQVIR9r6qF4q0LRLpekJH79ZnzagyYZj2SZ0FVnF66a0fAjxLkgoZ7BGrR
         dyOEH6q/wpomh9Xq4nnRUQ2kIThYeT0os8ZSvGWqZnj86p1geNIs3UpJYYmoAn5xm3bX
         GYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795121772; x=1795726572;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vMk589fI0vloaWsV/PEYRmc60/eNdwTMIDfcB72CPGE=;
        b=y6Uv/gcdRNuB+UIYdeaw7wagLshk0UFLFEPEPHyePbQINe0LByn+2qtCZah1ypCHAH
         DMVS47pjbRncuGoOQ5cfhr4uyslY0/598AjPJPoupUohl6KfCAIyRJuHEuQvgqzYFIgL
         UpcHPHrDvsGltDO1IccZlbSL+z4h0p3i9pXBiJyFL3dKx+srdUIBscOiVGFzT3DJcDpz
         biC6dE47H6ZkHRthPk0Xec9TxzE6+Zd8fUrHpCz1pxNo8ATY7qirT1LEMigKVzPCij1a
         kyjuDx1aNiZj8YZU5i5cDr8p6KuW/C/ZayLRAKO/uVRyQgumpvUz2diaRP+jt3MrgOxG
         qVNw==
X-Forwarded-Encrypted: i=1; AL+hErHW0K0kdS/qcsiTWhMpx2y155uPEVUk8bh73p5ecdWuv+uaBvvlzk5OW36AuzGu0KIEsGr2OwM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EiWVBuLYYIZb+25GBfybRXB767vMnSo5vHbgGiEXHUjFMhfPF
	baLaomJA0huTpMEVQ8DM1QR7tNlEyGxajwUzV0wDSWMzJZfoNHDQ50EyZ2C754MEe7Q=
X-Gm-Gg: AZFdTZefnYWf6ROnmDWHb609yf+3rFb9EcY7hgx1U3kF50pTSdjuSR23XBNhUgYSnkL
	5kcHeNPNT4KWFco5uIFbx8KHKF1IXBgnmEoP/t8afbkPc04qf/9QZal5cI+gA42g/gaAthnNZnk
	NfD2fFbu1ttaAjjlhZstBWWS0pbP+sR0vkkdLFyueagxlcRqLtIJqDD7OZsw5VzJ4dfYWnALeN6
	PVf/WD0mVlw0G3v7NJhu07TL4iQBx5N9ZRw9+vSaqy8/sLYhIWOvY3+hg7UNGNw9HrBZ9C09Yer
	Zbg1MDjg5zVqJaUfyJpCkLu1jogFEQJboV0LnmK8gRzqO5zx+3CCS6FeYhonwiWz/VRm++pLl6/
	EesDUSWMneKDGd/xyXH36hlARwIDYdYfEENOeP3a001poq/hZXRokUH505N1q4jmg/9eyuGxlDz
	8cm5WDbJPRY/xP5Ng08Pe5VYmnFsuTDqGequgpLhj0NHazAUdvZB7EkUxFVJPh1k8B5ubJl4wkh
	L584KddG4bw8f5TmMOfybQm5HqqEyrenQC73WsWc/0rEoojNm1v0mpWkI6vOcY/4Z+AWQszia6Q
	m58UStn79PFu9c7coAO+r60Do+53x/U8guaZzKtsd+eqv7ZsO6bg+MYdhD8xb4BppcDv3JQ1VOC
	Cwca9sMRekXNLf8pSRfCxi/+yz26JsWsrodIHUzoIQcR7a5/fgZ8Z2t/6A/5Lh+Xlsd14OpKnTm
	uIX7Ew/Wr4WEeouSTuIJU=
X-Received: by 2002:a05:690e:c8e:b0:67d:ab84:3bd6 with SMTP id 956f58d0204a3-67df42c2a16mr292087d50.1.1795121772580;
        Thu, 19 Nov 2026 12:56:12 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:1932:ad09:1827:11fb? ([2600:1700:6476:1430:1932:ad09:1827:11fb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df31f84e6sm688253d50.3.2026.11.19.12.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:56:11 -0800 (PST)
Message-ID: <84f8b4c3cf158516d201d844ae63cf3d673f532d.camel@dubeyko.com>
Subject: Re: [PATCH v3 1/3] hfs/hfsplus: add HFS_BNODE_DESC_SIZE for the
 node descriptor size
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ozgun kultekin <ozgunkultekin@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, yangguikun19@qq.com,
 stable@vger.kernel.org
Date: Thu, 19 Nov 2026 12:56:10 -0800
In-Reply-To: <20261119005943.37851-2-ozgunkultekin@gmail.com>
References: <20261118013337.67813-1-ozgunkultekin@gmail.com>
	 <20261119005943.37851-1-ozgunkultekin@gmail.com>
	 <20261119005943.37851-2-ozgunkultekin@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-18 at 16:59 -0800, ozgun kultekin wrote:
> brec.c and btree.c in both drivers use the literal 14 for the size of
> struct hfs_bnode_desc, which is also the offset of record 0 in a
> node.
> Add HFS_BNODE_DESC_SIZE next to the structure and use it instead.
>=20
> No functional change. The next two patches use the new name in the

Usually, mentioning "next two patches" is not good phrase. Because, it
means nothing once the series is merged.

> hfs_bnode_read_key() calls they change.
>=20
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Cc: stable@vger.kernel.org=C2=A0# prerequisite for the next two patches

The include/linux/hfs_common.h has been introduced pretty recently
v6.19-rc1 (ec95cd103c3a). Older stable trees declare it elsewhere, so
this patch won't apply there.

Probably, we need to reorder the series so the fixes come first with
Cc: stable, and this cleanup last without it, because the header only
exists from v6.19.

> Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
> ---
> v3: new patch, as requested by Viacheslav
>=20
> =C2=A0fs/hfs/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 32 +++++++++++++++++++++-----------
> =C2=A0fs/hfs/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0fs/hfsplus/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 31 ++++++++++++++++++++-----------
> =C2=A0fs/hfsplus/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 4 ++--
> =C2=A0include/linux/hfs_common.h |=C2=A0 3 +++
> =C2=A05 files changed, 48 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
> index 1ca1ee9f7..31574e562 100644
> --- a/fs/hfs/brec.c
> +++ b/fs/hfs/brec.c
> @@ -156,7 +156,8 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> void *entry, u32 entry_len)
> =C2=A0		entry_len =3D sizeof(cnid);
> =C2=A0
> =C2=A0		/* get index key */
> -		hfs_bnode_read_key(new_node, fd->search_key, 14);
> +		hfs_bnode_read_key(new_node, fd->search_key,
> +				=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE);
> =C2=A0		__hfs_brec_find(fd->bnode, fd);
> =C2=A0
> =C2=A0		hfs_bnode_put(new_node);
> @@ -402,7 +403,8 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0
> =C2=A0	/* size difference between old and new key */
> =C2=A0	if (tree->attributes & HFS_TREE_VARIDXKEYS)
> -		newkeylen =3D (hfs_bnode_read_u8(node, 14) | 1) + 1;
> +		newkeylen =3D (hfs_bnode_read_u8(node,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE)
> | 1) + 1;

This looks slightly weird. Maybe:

newkeylen =3D
     (hfs_bnode_read_u8(node, HFS_BNODE_DESC_SIZE) | 1) + 1;
=20

> =C2=A0	else
> =C2=A0		fd->keylength =3D newkeylen =3D tree->max_key_len + 1;
> =C2=A0	hfs_dbg("rec %d, keylength %d, newkeylen %d\n",
> @@ -441,7 +443,8 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0	hfs_bnode_move(parent, start_off + diff, start_off,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_off - start_off);
> =C2=A0skip:
> -	hfs_bnode_copy(parent, fd->keyoffset, node, 14, newkeylen);
> +	hfs_bnode_copy(parent, fd->keyoffset, node,
> HFS_BNODE_DESC_SIZE,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 newkeylen);
> =C2=A0	if (!(tree->attributes & HFS_TREE_VARIDXKEYS))
> =C2=A0		hfs_bnode_write_u8(parent, fd->keyoffset, newkeylen
> - 1);
> =C2=A0	hfs_bnode_dump(parent);
> @@ -458,7 +461,8 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0		}
> =C2=A0		fd->bnode =3D hfs_bnode_find(tree, new_node->parent);
> =C2=A0		/* create index key and entry */
> -		hfs_bnode_read_key(new_node, fd->search_key, 14);
> +		hfs_bnode_read_key(new_node, fd->search_key,
> +				=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE);
> =C2=A0		cnid =3D cpu_to_be32(new_node->this);
> =C2=A0
> =C2=A0		__hfs_brec_find(fd->bnode, fd);
> @@ -470,7 +474,8 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0			if (new_node =3D=3D node)
> =C2=A0				goto out;
> =C2=A0			/* restore search_key */
> -			hfs_bnode_read_key(node, fd->search_key,
> 14);
> +			hfs_bnode_read_key(node, fd->search_key,
> +					=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE);
> =C2=A0		}
> =C2=A0		new_node =3D NULL;
> =C2=A0	}
> @@ -524,28 +529,33 @@ static int hfs_btree_inc_height(struct
> hfs_btree *tree)
> =C2=A0	hfs_bnode_write(new_node, &node_desc, 0, sizeof(node_desc));
> =C2=A0
> =C2=A0	rec =3D tree->node_size - 2;
> -	hfs_bnode_write_u16(new_node, rec, 14);
> +	hfs_bnode_write_u16(new_node, rec, HFS_BNODE_DESC_SIZE);
> =C2=A0
> =C2=A0	if (node) {
> =C2=A0		/* insert old root idx into new root */
> =C2=A0		node->parent =3D tree->root;
> =C2=A0		if (node->type =3D=3D HFS_NODE_LEAF ||
> =C2=A0		=C2=A0=C2=A0=C2=A0 tree->attributes & HFS_TREE_VARIDXKEYS)
> -			key_size =3D hfs_bnode_read_u8(node, 14) + 1;
> +			key_size =3D hfs_bnode_read_u8(node,
> +						=C2=A0=C2=A0=C2=A0=C2=A0
> HFS_BNODE_DESC_SIZE) + 1;

Maybe:

key_size =3D
     hfs_bnode_read_u8(node, HFS_BNODE_DESC_SIZE) + 1;

> =C2=A0		else
> =C2=A0			key_size =3D tree->max_key_len + 1;
> -		hfs_bnode_copy(new_node, 14, node, 14, key_size);
> +		hfs_bnode_copy(new_node, HFS_BNODE_DESC_SIZE, node,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE, key_size);
> =C2=A0
> =C2=A0		if (!(tree->attributes & HFS_TREE_VARIDXKEYS)) {
> =C2=A0			key_size =3D tree->max_key_len + 1;
> -			hfs_bnode_write_u8(new_node, 14, tree-
> >max_key_len);
> +			hfs_bnode_write_u8(new_node,
> HFS_BNODE_DESC_SIZE,
> +					=C2=A0=C2=A0 tree->max_key_len);
> =C2=A0		}
> =C2=A0		key_size =3D (key_size + 1) & -2;
> =C2=A0		cnid =3D cpu_to_be32(node->this);
> -		hfs_bnode_write(new_node, &cnid, 14 + key_size, 4);
> +		hfs_bnode_write(new_node, &cnid,
> +				HFS_BNODE_DESC_SIZE + key_size, 4);

Maybe, introduce a local variable for HFS_BNODE_DESC_SIZE + key_size?

> =C2=A0
> =C2=A0		rec -=3D 2;
> -		hfs_bnode_write_u16(new_node, rec, 14 + key_size +
> 4);
> +		hfs_bnode_write_u16(new_node, rec,
> +				=C2=A0=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE + key_size +
> 4);

Ditto. For HFS_BNODE_DESC_SIZE + key_size + 4?

Yeah, we cannot solve all code issues in one patch. But 4 looks not
good too. Let's fix it step by step.

> =C2=A0
> =C2=A0		hfs_bnode_put(node);
> =C2=A0	}
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index f07038403..4c2f82c1c 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -356,8 +356,8 @@ static struct hfs_bnode *hfs_bmap_new_bmap(struct
> hfs_bnode *prev, u32 idx)
> =C2=A0	desc.num_recs =3D cpu_to_be16(1);
> =C2=A0	desc.reserved =3D 0;
> =C2=A0	hfs_bnode_write(node, &desc, 0, sizeof(desc));
> -	hfs_bnode_write_u16(node, 14, 0x8000);
> -	hfs_bnode_write_u16(node, tree->node_size - 2, 14);
> +	hfs_bnode_write_u16(node, HFS_BNODE_DESC_SIZE, 0x8000);
> +	hfs_bnode_write_u16(node, tree->node_size - 2,
> HFS_BNODE_DESC_SIZE);

Do we have normal alignment here?

> =C2=A0	hfs_bnode_write_u16(node, tree->node_size - 4, tree-
> >node_size - 6);
> =C2=A0
> =C2=A0	return node;
> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> index f416e562d..37e058c5d 100644
> --- a/fs/hfsplus/brec.c
> +++ b/fs/hfsplus/brec.c
> @@ -166,7 +166,8 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> void *entry, u32 entry_len)
> =C2=A0		entry_len =3D sizeof(cnid);
> =C2=A0
> =C2=A0		/* get index key */
> -		hfs_bnode_read_key(new_node, fd->search_key, 14);
> +		hfs_bnode_read_key(new_node, fd->search_key,
> +				=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE);
> =C2=A0		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
> =C2=A0
> =C2=A0		hfs_bnode_put(new_node);
> @@ -409,7 +410,7 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0	/* size difference between old and new key */
> =C2=A0	if ((tree->attributes & HFS_TREE_VARIDXKEYS) ||
> =C2=A0				(tree->cnid =3D=3D HFSPLUS_ATTR_CNID))
> -		newkeylen =3D hfs_bnode_read_u16(node, 14) + 2;
> +		newkeylen =3D hfs_bnode_read_u16(node,
> HFS_BNODE_DESC_SIZE) + 2;
> =C2=A0	else
> =C2=A0		fd->keylength =3D newkeylen =3D tree->max_key_len + 2;
> =C2=A0	hfs_dbg("rec %d, keylength %d, newkeylen %d\n",
> @@ -449,7 +450,8 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0	hfs_bnode_move(parent, start_off + diff, start_off,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_off - start_off);
> =C2=A0skip:
> -	hfs_bnode_copy(parent, fd->keyoffset, node, 14, newkeylen);
> +	hfs_bnode_copy(parent, fd->keyoffset, node,
> HFS_BNODE_DESC_SIZE,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 newkeylen);
> =C2=A0	hfs_bnode_dump(parent);
> =C2=A0
> =C2=A0	hfs_bnode_put(node);
> @@ -464,7 +466,8 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0		}
> =C2=A0		fd->bnode =3D hfs_bnode_find(tree, new_node->parent);
> =C2=A0		/* create index key and entry */
> -		hfs_bnode_read_key(new_node, fd->search_key, 14);
> +		hfs_bnode_read_key(new_node, fd->search_key,
> +				=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE);
> =C2=A0		cnid =3D cpu_to_be32(new_node->this);
> =C2=A0
> =C2=A0		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
> @@ -476,7 +479,8 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0			if (new_node =3D=3D node)
> =C2=A0				goto out;
> =C2=A0			/* restore search_key */
> -			hfs_bnode_read_key(node, fd->search_key,
> 14);
> +			hfs_bnode_read_key(node, fd->search_key,
> +					=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE);
> =C2=A0		}
> =C2=A0		new_node =3D NULL;
> =C2=A0	}
> @@ -530,7 +534,7 @@ static int hfs_btree_inc_height(struct hfs_btree
> *tree)
> =C2=A0	hfs_bnode_write(new_node, &node_desc, 0, sizeof(node_desc));
> =C2=A0
> =C2=A0	rec =3D tree->node_size - 2;
> -	hfs_bnode_write_u16(new_node, rec, 14);
> +	hfs_bnode_write_u16(new_node, rec, HFS_BNODE_DESC_SIZE);
> =C2=A0
> =C2=A0	if (node) {
> =C2=A0		/* insert old root idx into new root */
> @@ -538,21 +542,26 @@ static int hfs_btree_inc_height(struct
> hfs_btree *tree)
> =C2=A0		if (node->type =3D=3D HFS_NODE_LEAF ||
> =C2=A0				tree->attributes &
> HFS_TREE_VARIDXKEYS ||
> =C2=A0				tree->cnid =3D=3D HFSPLUS_ATTR_CNID)
> -			key_size =3D hfs_bnode_read_u16(node, 14) + 2;
> +			key_size =3D hfs_bnode_read_u16(node,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> HFS_BNODE_DESC_SIZE) + 2;

Maybe,=20

key_size =3D
    hfs_bnode_read_u16(node, HFS_BNODE_DESC_SIZE) + 2;


> =C2=A0		else
> =C2=A0			key_size =3D tree->max_key_len + 2;
> -		hfs_bnode_copy(new_node, 14, node, 14, key_size);
> +		hfs_bnode_copy(new_node, HFS_BNODE_DESC_SIZE, node,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE, key_size);
> =C2=A0
> =C2=A0		if (!(tree->attributes & HFS_TREE_VARIDXKEYS) &&
> =C2=A0				(tree->cnid !=3D HFSPLUS_ATTR_CNID)) {
> =C2=A0			key_size =3D tree->max_key_len + 2;
> -			hfs_bnode_write_u16(new_node, 14, tree-
> >max_key_len);
> +			hfs_bnode_write_u16(new_node,
> HFS_BNODE_DESC_SIZE,
> +					=C2=A0=C2=A0=C2=A0 tree->max_key_len);
> =C2=A0		}
> =C2=A0		cnid =3D cpu_to_be32(node->this);
> -		hfs_bnode_write(new_node, &cnid, 14 + key_size, 4);
> +		hfs_bnode_write(new_node, &cnid,
> +				HFS_BNODE_DESC_SIZE + key_size, 4);

Local variable?

> =C2=A0
> =C2=A0		rec -=3D 2;
> -		hfs_bnode_write_u16(new_node, rec, 14 + key_size +
> 4);
> +		hfs_bnode_write_u16(new_node, rec,
> +				=C2=A0=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE + key_size +
> 4);

Local variable?

> =C2=A0
> =C2=A0		hfs_bnode_put(node);
> =C2=A0	}
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 0a9b32d5c..519f07b81 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -497,8 +497,8 @@ static struct hfs_bnode *hfs_bmap_new_bmap(struct
> hfs_bnode *prev, u32 idx)
> =C2=A0	desc.num_recs =3D cpu_to_be16(1);
> =C2=A0	desc.reserved =3D 0;
> =C2=A0	hfs_bnode_write(node, &desc, 0, sizeof(desc));
> -	hfs_bnode_write_u16(node, 14, 0x8000);
> -	hfs_bnode_write_u16(node, tree->node_size - 2, 14);
> +	hfs_bnode_write_u16(node, HFS_BNODE_DESC_SIZE, 0x8000);
> +	hfs_bnode_write_u16(node, tree->node_size - 2,
> HFS_BNODE_DESC_SIZE);

Normal alignment?

> =C2=A0	hfs_bnode_write_u16(node, tree->node_size - 4, tree-
> >node_size - 6);
> =C2=A0
> =C2=A0	return node;
> diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
> index 802d1590e..1b639bbd1 100644
> --- a/include/linux/hfs_common.h
> +++ b/include/linux/hfs_common.h
> @@ -495,6 +495,9 @@ struct hfs_bnode_desc {
> =C2=A0	u16 reserved;
> =C2=A0} __packed;
> =C2=A0
> +/* Size of the node descriptor, which is also the offset of record 0
> */
> +#define HFS_BNODE_DESC_SIZE	sizeof(struct hfs_bnode_desc)

HFS_BNODE_DESC_SIZE describes the size, but most call sites use it as
"offset of the first record". Two names would read better: a size
constant plus something like:

#define HFS_BNODE_FIRST_REC_OFF HFS_BNODE_DESC_SIZE.

The same quantity is still spelled other ways in the same files: the
local size_t node_desc_size =3D sizeof(struct hfs_bnode_desc) in
hfs_bnode_split(), plus sizeof(struct hfs_bnode_desc) in bnode.c,
btree.c and hfsplus/xattr.c.

Thanks,
Slava.

> +
> =C2=A0/* HFS/HFS+ BTree node types */
> =C2=A0#define HFS_NODE_INDEX	0x00	/* An internal (index) node */
> =C2=A0#define HFS_NODE_HEADER	0x01	/* The tree header node
> (node 0) */
