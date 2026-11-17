Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794877333;
	b=GHs1h53pfkvo9SA2/2YKUu1mvjcA46iicJZhZ5qjKEtgXOzh1kNbDwawODaWt6ZdRs1Z
	 Zwaw6/mDmIypvcU6/jct/eILOoPti8ZdDNmN9MMJNWM0nodlIwffiQZOtut1Gj95v9EHY
	 F5p5XJZAkRbC5mTniIkAi53rnnJ9CR0wd7wgGyP95twrZXSMXfJuyLkdcQUYs2lTInS4y
	 UPI1Xmw9/JBdxIG4bb6Y5PeSLXvbiJHTXDtlbUQri2koaN/AIib50f3DdUAaZu2wgGmPk
	 nRvrcYHiAaC2rMLroJ185amj6BaHU7xBrBe8+12iY2nDnZZhvLxiflXjkwvVQIgyRkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794877333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=ctO9Vz6cUZ/f6mDE7Wd85I95KP6xrh4TKj1b7pGFnJo=;
	b=gxEueMJTczEQr+VUtuoBPgimTlEe35JPnWiwnd5ctFRa3mvQ3njGDV7vAW05ND8wZsnl
	 dn5zcUtMRq0jIFwgim3d6cvTdAwMMcWvuHi+xhNRO2wjf5EBiNu958NdYTMCrCX2MHqpX
	 VeWAoYiGyn4YL5d1C4VO/twq1krBWWN60PDSDmqnH0KhMYA9fo+lu0JWFN/ov4W8ywgnZ
	 s7DRt57d02L4lFDyVKT27LsItUY9ua6YtT/9mD1/K/G45ewGxxZixqooCRAeUU2GGgLbt
	 n0xojnPe2t/OWbxAbta+I+Q/cKJ3AZgn7D4LKl1+sUysS0oHUwsLcoB+Gg/Ur/0e+sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dt31SZdx;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0855D606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0855D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dt31SZdx
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b4efdc8c20so1827707b3.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794877331; x=1795482131; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ctO9Vz6cUZ/f6mDE7Wd85I95KP6xrh4TKj1b7pGFnJo=;
        b=dt31SZdxfONJbUY4PzJHpsbWv0MWVR/WO9awjT8S0C48qzdETeFT7+me5lmrUtQhdU
         PPW0iRgYMDFhf3rw8UZDchJQgE3Q6igEc6LM1TKAT8HsUlkDXHpEcc6EAEibBLjZhTRo
         hebOwyHjmdNjs9SW5Q7myC6yopooi2yjqNI9twtLk/x3f6LAJgyPswvaiK/cfD6QCSYl
         kIBCWgV3iln18rNf5WZadcyxaANDr6STrvecE5T29FP9XzpL+PrNjW/2VEsNnNen5R25
         UiLIUiFZzPStRrXYa+uYPv3AzeoC9baXgdsZri4mgLrffdmGK3mefj53O1ysT7gVmNp4
         f9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794877331; x=1795482131;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ctO9Vz6cUZ/f6mDE7Wd85I95KP6xrh4TKj1b7pGFnJo=;
        b=QeZN0JvzdGqwBcSMjHgy0FzENN+xR1mcLMaFczU6vneBfaHNRCkqkJ3kbDW4c29sRM
         roURpUOjO09crRw9IB6IJ9KwDYZ5qZn8rHfj3q/gUQjU64RVmTJjvQu8UE1EYoSGHysW
         GFInGPIGQKfI93VK7aMlBBVCQfUG32IxAEDXNvpnspMlrCsSw30Iqk2fgasM04v3Mq6i
         d9ah1cUFHZu4+IQXEWtQQUZcaaXELX/KDzdk9M8RNGRQdAeWODgWcrrdTVE58EXs+OG2
         XNmiWr2zDkG6SNo6AzJa8FT9SISB+9/Qg4KAs4Zu9+XVVZPwLw9YeS4tcO+YLMirzgMJ
         OkCQ==
X-Forwarded-Encrypted: i=1; AL+hErGRbrEt9uszY59x6fkXDoqp5BIXiGaEp1ymVIdbARPNGyKatGBRWorST3OwncW0YFRrCP2c+ZU=@vger.kernel.org
X-Gm-Message-State: APuU4Z94yzlZiQe6DJbPCLV8w8YXNT56CxBLXmK78BjfQHxgAPWYSHrc
	dNua/9e2BEECe8/Cgcfz/+8PAB5QedWNeyoo9sgi2nsBg/rwOXRMx6tAhwgbpzvPxMc=
X-Gm-Gg: AZFdTZerVU3aO4CteRZ20tvPbccT8aHukJh9C7yrRSh+sjvgh4d5MH4sLUWjnhq2mjA
	sDswuwgwjvZ4eSYTGsJnuf2g6YrEDVrrmXgtwoi/I4G8nnzTGMP7doEdfYCxweBdQkvRM2Cdzm7
	YM7H5ZUu0DHZMiEzWer1onNyC0dvjGoS0ZmVvfRhgX/OJVmyoVMZf5sUXWz2Q7wOnF0wDU5bQDj
	Ueaf3F7ymtZ6EAdpFbMEZWXKk1emZTnrKYV8EvEZufc6MFjqOCJ+G9D+xUw6HCd4Oo3LQr97sQ3
	5td1Fr1ySjS2Y4gVJqG+I9SM5upb1QTuHw6vZRfkYfbi+V3m0+pMH5lygBPkmcdAETFtLQK+nVS
	4wJy/Y7LdtwDXw4NaAbvMkxw3JBndx9v1r95VmvZ433dwhqVHddQiYG5Tw2i3yHONYBJfsTkIA1
	a37mM3x11P46GpORZALyNUKxTAc6qwcSWvntX8pzcPx53fuh1WwKt0qS2mnF7EGhSzH+Jb8FjBh
	SMp2Na1tAZjT5KxtvBx4Wb2yOXhoP6/Eph12aFZTimAA9+90ts6Ydgbab9G/hCztjLALwfZJYH3
	7evYqiGmGKyHWixrGG77uPD/HUS8xehChCMgzeVJY5MbXmeIisHB2GeOnkbPRcOvqnURP/DtBs+
	3QzobwKP9BXZ0kLjWfIFMxrWKZHAp0pNbC8TzpqMrztmxAoktm1SbTsSOPKQ9k8zkurftozHn2K
	boGXiEOERRrG981FRK
X-Received: by 2002:a05:690c:931b:20b0:8b3:5b88:a21e with SMTP id 00721157ae682-8b4aa326b56mr56600327b3.31.1794877330573;
        Mon, 16 Nov 2026 17:02:10 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:d1c7:8722:e551:bec4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ec065f84sm12694907b3.29.2026.11.16.17.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 17:02:10 -0800 (PST)
Message-ID: <138ca05e57377469c0e44126314c98d008629229.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: avoid reusing occupied CNIDs after deletion
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 17:02:08 -0800
In-Reply-To: <20261112110128.4082071-1-hengyul@cs.unc.edu>
References: <20261112110128.4082071-1-hengyul@cs.unc.edu>
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

On Thu, 2026-11-12 at 06:01 -0500, Hengyu Liang wrote:
> Commit a06ec283e125 ("hfs: add logic of correcting a next unused
> CNID")
> made hfs_correct_next_unused_CNID() lower the next CNID after the
> newest file or directory is deleted. It takes the CNID of the last
> file or directory record in the catalog as the largest CNID in use.
>=20
> However, catalog records are sorted by parent ID and name, not by
> CNID, so the next CNID can be one that is still in use. As of now,
> creating a file after deleting the newest one can fail with EEXIST.
> Commit 6592287869bf ("hfs: fix incorrect inode ID assignment in
> hfs_new_inode()") exposed this issue.
>=20
> The issue can be reproduced on a freshly formatted HFS volume with:
>=20
> =C2=A0=C2=A0=C2=A0 mkdir z
> =C2=A0=C2=A0=C2=A0 touch a b
> =C2=A0=C2=A0=C2=A0 rm b
> =C2=A0=C2=A0=C2=A0 touch c
>=20
> Without this change, the result is:
>=20
> =C2=A0=C2=A0=C2=A0 touch: cannot touch 'c': File exists
>=20
> With it, c is created.
>=20
> Keep the largest CNID of the records in and below each catalog node
> in memory, in leaf nodes and in index nodes, so that the root node
> gives the largest CNID in use. Adding a record raises it in the nodes
> above, and removing the record with the largest CNID makes them
> compute it again.
>=20
> Fixes: a06ec283e125 ("hfs: add logic of correcting a next unused
> CNID")
> Cc: stable@vger.kernel.org
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Assisted-by: LLM
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Changes in v2:
> - Keep the largest CNID in memory in every catalog node, leaf and
> =C2=A0 index, as Viacheslav Dubeyko suggested. v1 walked the leaf nodes.
> - Rebase on hfs for-next.
> - v1:
> https://lore.kernel.org/r/20261015110114.1649059-1-hengyul@cs.unc.edu
>=20
> Tested in KVM with KASAN on 34ee5f8c2198, without and with this
> patch.
> All fstests on HFS: 24 failures without the patch, 20 with it, no new
> failures. Deleting 8000 files:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unpatched=C2=A0=C2=A0 patched
> =C2=A0=C2=A0=C2=A0 newest first=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11 s=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.36 s
> =C2=A0=C2=A0=C2=A0 odd ones, then even ones
> =C2=A0=C2=A0=C2=A0 newest first=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.8 s=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0.19 s
>=20
> Creating the files (0.54 s and 0.55 s) and deleting them oldest first
> (0.37 s and 0.38 s) take about the same time.
>=20
> =C2=A0fs/hfs/brec.c=C2=A0=C2=A0=C2=A0 | 172
> +++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A0fs/hfs/btree.h=C2=A0=C2=A0 |=C2=A0=C2=A0 5 ++
> =C2=A0fs/hfs/catalog.c |=C2=A0 96 +++-----------------------
> =C2=A03 files changed, 186 insertions(+), 87 deletions(-)
>=20
> diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
> index 1ca1ee9f73ef..318bbee43529 100644
> --- a/fs/hfs/brec.c
> +++ b/fs/hfs/brec.c
> @@ -62,6 +62,174 @@ u16 hfs_brec_keylen(struct hfs_bnode *node, u16
> rec)
> =C2=A0	return retval;
> =C2=A0}
> =C2=A0
> +/* Get the CNID of a file or directory record of the catalog tree */
> +static u32 hfs_brec_cnid(struct hfs_bnode *node, u32 off)
> +{
> +	__be32 cnid;
> +
> +	switch (hfs_bnode_read_u8(node, off)) {
> +	case HFS_CDR_DIR:
> +		off +=3D offsetof(struct hfs_cat_dir, DirID);
> +		break;
> +	case HFS_CDR_FIL:
> +		off +=3D offsetof(struct hfs_cat_file, FlNum);
> +		break;
> +	default:
> +		return 0;
> +	}
> +	hfs_bnode_read(node, &cnid, off, sizeof(cnid));
> +	return be32_to_cpu(cnid);

This function is completely not clear. You try to read the hfs_cat_rec.
Simply read it and analyze the record. Now it looks like a dark magic.=20

> +}
> +
> +/* Forget max_cnid of all nodes of the tree */
> +static void hfs_btree_drop_max_cnid(struct hfs_btree *tree)
> +{
> +	struct hfs_bnode *node;
> +	int i;
> +
> +	spin_lock(&tree->hash_lock);
> +	for (i =3D 0; i < NODE_HASH_SIZE; i++) {
> +		for (node =3D tree->node_hash[i]; node; node =3D node-
> >next_hash)
> +			clear_bit(HFS_BNODE_MAX_CNID, &node->flags);
> +	}
> +	spin_unlock(&tree->hash_lock);
> +}
> +
> +/*
> + * The record at @off has been added to the catalog leaf @node, or
> is about
> + * to be removed from it. Update max_cnid of the node and of its
> parents:
> + * a new CNID can only raise it, and after the largest CNID is gone
> it has
> + * to be computed again.
> + */
> +static void hfs_brec_update_max_cnid(struct hfs_bnode *node, u32
> off,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 bool insert)

Is this insert argument used anywhere?

> +{
> +	struct hfs_btree *tree =3D node->tree;
> +	u32 nidx =3D node->this;
> +	u32 cnid;
> +	bool done;
> +
> +	if (tree->cnid !=3D HFS_CAT_CNID || node->type !=3D
> HFS_NODE_LEAF)

I would like to see some inline function with good name for this check.

> +		return;

Please, add empty line here.

> +	cnid =3D hfs_brec_cnid(node, off);
> +	if (!cnid)

The #0 is reserved CNID. It's not good choice for such check.

> +		return;
> +
> +	for (;;) {

I assume that we limited by tree's height here. Could we used it
instead of infinite loop?

> +		node =3D hfs_bnode_find(tree, nidx);
> +		if (IS_ERR(node))
> +			break;
> +
> +		done =3D nidx =3D=3D tree->root;
> +		if (test_bit(HFS_BNODE_MAX_CNID, &node->flags)) {
> +			if (insert && node->max_cnid < cnid)

I dislike insert like a boolean value. Why do we need to inform this
function about insert? Why this function cannot make this decision
alone?

> +				node->max_cnid =3D cnid;
> +			else if (!insert && node->max_cnid <=3D cnid)
> +				clear_bit(HFS_BNODE_MAX_CNID, &node-
> >flags);
> +			else
> +				done =3D true;	/* the parents do
> not change */
> +		}

Ad empty line.

> +		nidx =3D node->parent;
> +		hfs_bnode_put(node);
> +
> +		if (done)

You don't need in done if you are limited by b-tree height.

> +			return;

Add empty line.

> +		if (!nidx)
> +			break;
> +	}
> +
> +	/* a parent could not be reached */
> +	hfs_btree_drop_max_cnid(tree);
> +}

I will continue the review tomorrow. I don't have more time today. :)

Thanks,
Slava.

> +
> +/*
> + * Compute max_cnid of a catalog node: the largest CNID of the file
> and
> + * directory records of a leaf node, or the largest max_cnid of the
> children
> + * of an index node. If a child has no max_cnid yet, return the
> number of
> + * that child in @child instead.
> + */
> +static int hfs_brec_calc_max_cnid(struct hfs_bnode *node, u32
> *child)
> +{
> +	struct hfs_bnode *cnode;
> +	u32 max_cnid =3D 0;
> +	u16 off, len, keylen;
> +	__be32 data;
> +	int i;
> +
> +	for (i =3D 0; i < node->num_recs; i++) {
> +		len =3D hfs_brec_lenoff(node, i, &off);
> +		keylen =3D hfs_brec_keylen(node, i);
> +		if (!keylen || keylen + sizeof(data) > len)
> +			return -EIO;
> +		off +=3D keylen;
> +
> +		if (node->type =3D=3D HFS_NODE_LEAF) {
> +			max_cnid =3D max(max_cnid, hfs_brec_cnid(node,
> off));
> +			continue;
> +		}
> +
> +		hfs_bnode_read(node, &data, off, sizeof(data));
> +		cnode =3D hfs_bnode_find(node->tree,
> be32_to_cpu(data));
> +		if (IS_ERR(cnode))
> +			return PTR_ERR(cnode);
> +		if (cnode->height !=3D node->height - 1) {
> +			hfs_bnode_put(cnode);
> +			return -EIO;
> +		}
> +		if (!test_bit(HFS_BNODE_MAX_CNID, &cnode->flags)) {
> +			cnode->parent =3D node->this;
> +			*child =3D cnode->this;
> +			hfs_bnode_put(cnode);
> +			return 0;
> +		}
> +		max_cnid =3D max(max_cnid, cnode->max_cnid);
> +		hfs_bnode_put(cnode);
> +	}
> +
> +	node->max_cnid =3D max_cnid;
> +	set_bit(HFS_BNODE_MAX_CNID, &node->flags);
> +	return 0;
> +}
> +
> +/*
> + * hfs_btree_max_cnid()
> + *
> + * Find the largest CNID of the file and directory records of the
> catalog
> + * tree. It is max_cnid of the root node. max_cnid is not stored on
> disk,
> + * so walk down to the nodes that do not have it and compute it from
> the
> + * bottom up.
> + */
> +int hfs_btree_max_cnid(struct hfs_btree *tree, u32 *max_cnid)
> +{
> +	struct hfs_bnode *node;
> +	u32 nidx =3D tree->root;
> +	u32 child;
> +	int res =3D 0;
> +
> +	*max_cnid =3D 0;
> +	while (nidx && !res) {
> +		node =3D hfs_bnode_find(tree, nidx);
> +		if (IS_ERR(node))
> +			return PTR_ERR(node);
> +
> +		child =3D 0;
> +		if (!test_bit(HFS_BNODE_MAX_CNID, &node->flags))
> +			res =3D hfs_brec_calc_max_cnid(node, &child);
> +
> +		if (res || child) {
> +			nidx =3D child;
> +		} else if (nidx =3D=3D tree->root) {
> +			*max_cnid =3D node->max_cnid;
> +			nidx =3D 0;
> +		} else {
> +			/* a node that was read again has lost its
> parent */
> +			nidx =3D node->parent ? node->parent : tree-
> >root;
> +		}
> +		hfs_bnode_put(node);
> +	}
> +	return res;
> +}
> +
> =C2=A0int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32
> entry_len)
> =C2=A0{
> =C2=A0	struct hfs_btree *tree;
> @@ -131,6 +299,7 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> void *entry, u32 entry_len)
> =C2=A0skip:
> =C2=A0	hfs_bnode_write(node, fd->search_key, data_off, key_len);
> =C2=A0	hfs_bnode_write(node, entry, data_off + key_len, entry_len);
> +	hfs_brec_update_max_cnid(node, data_off + key_len, true);
> =C2=A0	hfs_bnode_dump(node);
> =C2=A0
> =C2=A0	/*
> @@ -183,6 +352,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
> =C2=A0
> =C2=A0	tree =3D fd->tree;
> =C2=A0	node =3D fd->bnode;
> +	hfs_brec_update_max_cnid(node, fd->entryoffset, false);
> =C2=A0again:
> =C2=A0	rec_off =3D tree->node_size - (fd->record + 2) * 2;
> =C2=A0	end_off =3D tree->node_size - (node->num_recs + 1) * 2;
> @@ -322,6 +492,8 @@ static struct hfs_bnode *hfs_bnode_split(struct
> hfs_find_data *fd)
> =C2=A0	}
> =C2=A0	new_node->num_recs =3D node->num_recs - num_recs;
> =C2=A0	node->num_recs =3D num_recs;
> +	/* the records that move to the new node may hold the
> largest CNID */
> +	clear_bit(HFS_BNODE_MAX_CNID, &node->flags);
> =C2=A0
> =C2=A0	new_rec_off =3D tree->node_size - rec_size;
> =C2=A0	new_off =3D node_desc_size;
> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> index 1f703f2c53d8..21f69cddc683 100644
> --- a/fs/hfs/btree.h
> +++ b/fs/hfs/btree.h
> @@ -62,6 +62,9 @@ struct hfs_bnode {
> =C2=A0	u8 type;
> =C2=A0	u8 height;
> =C2=A0
> +	/* catalog tree: largest CNID in the records in and below
> the node */
> +	u32 max_cnid;
> +
> =C2=A0	struct hfs_bnode *next_hash;
> =C2=A0	unsigned long flags;
> =C2=A0	wait_queue_head_t lock_wq;
> @@ -73,6 +76,7 @@ struct hfs_bnode {
> =C2=A0#define HFS_BNODE_ERROR		0
> =C2=A0#define HFS_BNODE_NEW		1
> =C2=A0#define HFS_BNODE_DELETED	2
> +#define HFS_BNODE_MAX_CNID	3	/* max_cnid is valid */
> =C2=A0
> =C2=A0struct hfs_find_data {
> =C2=A0	btree_key *key;
> @@ -140,6 +144,7 @@ extern u16 hfs_brec_lenoff(struct hfs_bnode
> *node, u16 rec, u16 *off);
> =C2=A0extern u16 hfs_brec_keylen(struct hfs_bnode *node, u16 rec);
> =C2=A0extern int hfs_brec_insert(struct hfs_find_data *fd, void *entry,
> u32 entry_len);
> =C2=A0extern int hfs_brec_remove(struct hfs_find_data *fd);
> +extern int hfs_btree_max_cnid(struct hfs_btree *tree, u32
> *max_cnid);
> =C2=A0
> =C2=A0/* bfind.c */
> =C2=A0extern int hfs_find_init(struct hfs_btree *tree, struct
> hfs_find_data *fd);
> diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
> index 490c5e130da3..ead094e44c9a 100644
> --- a/fs/hfs/catalog.c
> +++ b/fs/hfs/catalog.c
> @@ -271,102 +271,24 @@ void hfs_set_next_unused_CNID(struct
> super_block *sb,
> =C2=A0static
> =C2=A0int hfs_correct_next_unused_CNID(struct super_block *sb, u32 cnid)
> =C2=A0{
> -	struct hfs_btree *cat_tree;
> -	struct hfs_bnode *node;
> -	s64 leaf_head;
> -	s64 leaf_tail;
> -	s64 node_id;
> +	u32 max_cnid;
> +	int res;
> =C2=A0
> =C2=A0	hfs_dbg("cnid %u, next_id %lld\n",
> =C2=A0		cnid, atomic64_read(&HFS_SB(sb)->next_id));
> =C2=A0
> -	if ((cnid + 1) < atomic64_read(&HFS_SB(sb)->next_id)) {
> +	if ((cnid + 1) !=3D atomic64_read(&HFS_SB(sb)->next_id)) {
> =C2=A0		/* next ID should be unchanged */
> =C2=A0		return 0;
> =C2=A0	}
> =C2=A0
> -	cat_tree =3D HFS_SB(sb)->cat_tree;
> -	leaf_head =3D cat_tree->leaf_head;
> -	leaf_tail =3D cat_tree->leaf_tail;
> -
> -	if (leaf_head > leaf_tail) {
> -		pr_err("node is corrupted: leaf_head %lld, leaf_tail
> %lld\n",
> -			leaf_head, leaf_tail);
> -		return -ERANGE;
> -	}
> -
> -	node =3D hfs_bnode_find(cat_tree, leaf_tail);
> -	if (IS_ERR(node)) {
> -		pr_err("fail to find leaf node: node ID %lld\n",
> -			leaf_tail);
> -		return -ENOENT;
> -	}
> -
> -	node_id =3D leaf_tail;
> -
> -	do {
> -		int i;
> -
> -		if (node_id !=3D leaf_tail) {
> -			node =3D hfs_bnode_find(cat_tree, node_id);
> -			if (IS_ERR(node))
> -				return -ENOENT;
> -		}
> -
> -		hfs_dbg("node %lld, leaf_tail %lld, leaf_head
> %lld\n",
> -			node_id, leaf_tail, leaf_head);
> -
> -		hfs_bnode_dump(node);
> -
> -		for (i =3D node->num_recs - 1; i >=3D 0; i--) {
> -			hfs_cat_rec rec;
> -			u16 off, len, keylen;
> -			int entryoffset;
> -			int entrylength;
> -			u32 found_cnid;
> -
> -			len =3D hfs_brec_lenoff(node, i, &off);
> -			keylen =3D hfs_brec_keylen(node, i);
> -			if (keylen =3D=3D 0) {
> -				pr_err("fail to get the keylen: "
> -					"node_id %lld, record index
> %d\n",
> -					node_id, i);
> -				return -EINVAL;
> -			}
> -
> -			entryoffset =3D off + keylen;
> -			entrylength =3D len - keylen;
> -
> -			if (entrylength > sizeof(rec)) {
> -				pr_err("unexpected record length: "
> -					"entrylength %d\n",
> -					entrylength);
> -				return -EINVAL;
> -			}
> -
> -			hfs_bnode_read(node, &rec, entryoffset,
> entrylength);
> -
> -			if (rec.type =3D=3D HFS_CDR_DIR) {
> -				found_cnid =3D
> be32_to_cpu(rec.dir.DirID);
> -				hfs_dbg("found_cnid %u\n",
> found_cnid);
> -				hfs_set_next_unused_CNID(sb, cnid,
> found_cnid);
> -				hfs_bnode_put(node);
> -				return 0;
> -			} else if (rec.type =3D=3D HFS_CDR_FIL) {
> -				found_cnid =3D
> be32_to_cpu(rec.file.FlNum);
> -				hfs_dbg("found_cnid %u\n",
> found_cnid);
> -				hfs_set_next_unused_CNID(sb, cnid,
> found_cnid);
> -				hfs_bnode_put(node);
> -				return 0;
> -			}
> -		}
> -
> -		node_id =3D node->prev;
> -		hfs_bnode_put(node);
> -
> -	} while (node_id >=3D leaf_head);
> +	res =3D hfs_btree_max_cnid(HFS_SB(sb)->cat_tree, &max_cnid);
> +	if (res)
> +		return res;
> =C2=A0
> -	return -ENOENT;
> +	hfs_dbg("max_cnid %u\n", max_cnid);
> +	hfs_set_next_unused_CNID(sb, cnid, max_cnid);
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0/*
>=20
> base-commit: 34ee5f8c2198db9585da6c181c50869d2eb43c3a
