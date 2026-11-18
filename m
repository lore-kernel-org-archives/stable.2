Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028775;
	b=G4X6wlCoujnHj9dlSOnWqBFHplaLtXTxmjx82AQ5Ldb0nhijbkuxf9xA9C4v16vifxec
	 Bg1T9FKeyuJmq3WXI2szLLDxrWIqVqtGf/ZQihjYeFSUFcVMbkgblUJHhCP4JSIGLLPFn
	 g+qPl4Soj6i42tT7bQAK5/vqU0Gl+SMMZ+TtdZoerGZImLZMHp/lOR69qWMDH/5k7GP02
	 2VzYnhzL3DsVwhRWhiXrdmFvnzbovbBxtB3cs5EtULmnixcxsz9RZ9pcPobyPWlkIndB2
	 V0pJUNcASugfYfM0WDVxYlaKn8X1eUE59N2NJ4qJ01CinO5APGim2UKrxAMRA8smehA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028775;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=K3ymRzhdwjzx+FHWbWjH8FmcD60wOZPkk81WKbPdQck=;
	b=4NECKhiuymBlwzXMZqn75+aeBDhITOT5I63/um10dKNx49osCjUAGf+LGB3rI7nkDuuV
	 DjS7zz3YU7J77hQSdIOORv9npfoYY/JgGP8dUCRK1v+BZ2ISnheIelMJkRMflqYbX8Wdz
	 dGzfFmTgFiyQCpPj1fzkFb77xDbtMhllw9GLlyqhysnhwBTExh6XBndWz6Lc6s8HzQ+7g
	 napOlbeTfIGCRinr0Odk21PYDFIRjnphp3wcRv1rtUO0YxuP5F3ep8rbpxRHcwXQrlA+W
	 80BCypmApMLH70oaP+QUojt70y7L5NbyFsr3/Kko1+LRCGlIKDBY/CwWwgG7Qnn8AEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VqcbGsbm;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F8E606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77F8E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VqcbGsbm
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b30ff12f84so9204937b3.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795028773; x=1795633573; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K3ymRzhdwjzx+FHWbWjH8FmcD60wOZPkk81WKbPdQck=;
        b=VqcbGsbmDaeaML4RSnH8xjyVvH/4tJRsVJ52dyy0Tmf6pKzrGWlfvkvtzm26IeECQ/
         iaMahTPY+rJcp8O4xYwQIzzQsDobGjsQviEXlQqYoSFl5rILQjtBmU/uL+HSZo2sf6yw
         9ttvZlqHJzOYU572Hiz8F6iNHkS9QDt8rBcxRO15uNNr+G34/MoIfA3it+67pVHrNy7g
         Krn79JfetVz15s8KVUaubz8xwTfss9fkDdFzhOJIo8V1/ivrWlmsySMfizJUOgez0OCQ
         62fWog+dUG954OE+tWqOpQjhWcGmcMFilbermyIkAFs2Sz+qmAaISGb48OGPo6Hn9qIy
         aBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795028773; x=1795633573;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K3ymRzhdwjzx+FHWbWjH8FmcD60wOZPkk81WKbPdQck=;
        b=1JQcXJCfJs137AlXGg3kVUBPn36I82KhYALYv31SYW6DqghA592kcX0wZxMuFUC+by
         lrOuyBR/S/sUw+BoTbRqk08n/sn3QqXwbCI65VUeK5ePrSFZIaT1qrUnQrC9Bupa0bsz
         BNV1dOCQ2OLHOuQeUtSeoN9wtq2kTEe0/u+77H64WUFBGchx6z9PJY2KiYf9o8kcxzNW
         TzsE0MnzmStcuoWGpLicTPZtpZWrU6z5RAKrbthjUiPw67lLbOMigmbmy13Ry05Vfqnw
         ukntk87ZoQ3vgv6jshRlwcjUrGrioeWe+nvH1fcnpajl++gMUzpQ8Z2u1A6IyBxhvgSu
         JgEw==
X-Forwarded-Encrypted: i=1; AL+hErHoSvpBAfUXaQ9L+Msx7luzYeYu2U6/eZu7ov+eGBLrV1T0o783BJKD4vtP3p0TBRYrgLt65Pw=@vger.kernel.org
X-Gm-Message-State: APuU4Z90GtTXB6tmxkh1bKXuQatKZMIrfgdVE2pw9O6AKPpOrlWWMFvJ
	qfWeVJupqutNxv1hhikeVvvnzrIeN3zMroBuRcpVsOH24/z5rTwbPKLV5sTFtdspwS0=
X-Gm-Gg: AZFdTZcCS/QW+/B5hjx5IcvqeX6NF4oVss0oZmCDALdt1IrfCRqmtmOXiy3OToTA6Np
	zKO/5E9T6CZPGWMsqAgBlCKOIyDLORzFwZE8f4yOzluVczVGqgfMAj9U5rzE8Y7C0o/fXCaYEXE
	5I44y5b8MMnZmLaiGwwX/GopQqosJ/COmxE29lx2t+EDENCnyL8K5F7d7vH9y0NP23qzp6OHr/f
	gDI34tHQLOY9pR7gmeR2Bs7o1qm1PTcnUR5jvkhLl1cCyPiO2SLfrV84cIpIVZzNRHJ7nKt9xHd
	JHsQtI3d3iEXhf5qxDXPvLR9f2B37SYayzPo9CuemZ67D60BWksQ/nYJP/fFWc/l3r8WSiBTT/U
	PMp/5heis/CvPX82aZ78cQLTAVVVds5rUNR6gc3q7GhzYaFrk8MaMHjOxspqmTlohnuipQn4Ekl
	jVkAli0bEPTf0nFf6V4ov+xGo9uEK7M5gB0Orhfp9J49erzrlHNbX7wszXwZMbFLIxlxwbQW0b7
	Q1ddrAyC0MX/Wmheoyk6v5PB91G7ks9Leyfc3YTZRJCFLcNrohiPqLRlrf+R7fwoYKFPCsFbwdW
	5fso85GqvE0qPznVtqYq6LKw2WjVFBUH+MjcBGNxrTSqloew+THFQV11OpLiReDLBOAz8dlkHkG
	4KBFvHwBBH7Jsb1UbFZrpDhA62LkqAr3nfhU4/ZVTcVQwdalsEvKUP9C+27S2mVIgUXod0VqUcd
	cs66viSOugDkagkJNq9qs=
X-Received: by 2002:a05:690c:6087:b0:8b4:b5e4:e7a4 with SMTP id 00721157ae682-8b4fed37af3mr17906877b3.21.1795028773351;
        Wed, 18 Nov 2026 11:06:13 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:5fae:4d02:7055:94ad? ([2600:1700:6476:1430:5fae:4d02:7055:94ad])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe0e8d9csm22451747b3.35.2026.11.18.11.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:06:12 -0800 (PST)
Message-ID: <906a3c99edd0b9216fecf4994c96a5fed9ca5253.camel@dubeyko.com>
Subject: Re: [PATCH v2 1/2] hfsplus: pass the key buffer size to
 hfs_bnode_read_key()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ozgun kultekin <ozgunkultekin@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, yangguikun19@qq.com,
 stable@vger.kernel.org
Date: Wed, 18 Nov 2026 11:06:11 -0800
In-Reply-To: <20261118013725.90985-2-ozgunkultekin@gmail.com>
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
	 <20261118013725.90985-1-ozgunkultekin@gmail.com>
	 <20261118013725.90985-2-ozgunkultekin@gmail.com>
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

On Tue, 2026-11-17 at 17:37 -0800, ozgun kultekin wrote:
> hfs_bnode_read_key() reads the key length of leaf records (and of all
> records of variable-key and attributes trees) from disk and only
> checks
> it against sizeof(hfsplus_btree_key), 518 bytes. The destination is
> always one of the two key buffers hfs_find_init() allocates, each
> tree->max_key_len + 2 bytes long. For the extents tree max_key_len is
> fixed at 10, so the whole allocation is 24 bytes and a crafted leaf
> key
> writes up to 516 bytes from the image into kmalloc-32. The error path
> clears 518 bytes of the same buffer.
>=20
> hfs_brec_insert() reaches this with a key that was never validated:
> when the tree root is 0 it reads the key of record 0 of the leaf it
> inserts into, and after a split it reads the first key of the new
> node.
> A read-write mount that extends the catalog, or an append to a file
> whose extents spill into the extents tree, is enough.
>=20
> Do not let hfs_bnode_read_key() assume the size of the buffer. Record
> the size of each key buffer in struct hfs_find_data in
> hfs_find_init(),
> allocate the two buffers from it, and pass it to every
> hfs_bnode_read_key() call. Keys longer than the buffer are rejected
> as
> before, and the error path clears only the buffer.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in
> hfs_bnode_read_key")
> Reported-by: Guikun Yang <yangguikun19@qq.com>
> Closes:
> https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@=
qq.com/
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
> ---
> v2: pass the key buffer size to hfs_bnode_read_key() and keep it in
> =C2=A0=C2=A0=C2=A0 hfs_find_data, as suggested by Viacheslav
> v1:
> https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.co=
m/
>=20
> =C2=A0fs/hfsplus/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 ++++--
> =C2=A0fs/hfsplus/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 7 ++++---
> =C2=A0fs/hfsplus/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 9 +++++----
> =C2=A0fs/hfsplus/hfsplus_fs.h | 5 ++++-
> =C2=A04 files changed, 17 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> index ca9813f58..5ec72fc98 100644
> --- a/fs/hfsplus/bfind.c
> +++ b/fs/hfsplus/bfind.c
> @@ -19,11 +19,13 @@ int hfs_find_init(struct hfs_btree *tree, struct
> hfs_find_data *fd)
> =C2=A0	fd->tree =3D tree;
> =C2=A0	fd->bnode =3D NULL;
> =C2=A0	hfs_find_result_init(fd);
> -	ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> +	/* search_key and key, each holding one key of the largest
> size */
> +	fd->key_size =3D tree->max_key_len + 2;

Do you mean + 4?

> +	ptr =3D kzalloc(2 * fd->key_size, GFP_KERNEL);

This is why I would like to exchange this tree->max_key_len * 2 + 4 on
the statement that includes named constants instead of hardcoded 2 and
4. Please, rework it.

> =C2=A0	if (!ptr)
> =C2=A0		return -ENOMEM;
> =C2=A0	fd->search_key =3D ptr;
> -	fd->key =3D ptr + tree->max_key_len + 2;
> +	fd->key =3D ptr + fd->key_size;
> =C2=A0	hfs_dbg("cnid %d, caller %ps\n",
> =C2=A0		tree->cnid, __builtin_return_address(0));
> =C2=A0	mutex_lock_nested(&tree->tree_lock,
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 3a1a1fa6f..e2335c6d7 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -71,7 +71,8 @@ u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32
> off)
> =C2=A0	return data;
> =C2=A0}
> =C2=A0
> -void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
> +void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
> +			u32 key_size)
> =C2=A0{
> =C2=A0	struct hfs_btree *tree;
> =C2=A0	u32 key_len;
> @@ -84,8 +85,8 @@ void hfs_bnode_read_key(struct hfs_bnode *node,
> void *key, u32 off)
> =C2=A0	else
> =C2=A0		key_len =3D tree->max_key_len + 2;
> =C2=A0
> -	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
> -		memset(key, 0, sizeof(hfsplus_btree_key));
> +	if (key_len > key_size || key_len < 1) {
> +		memset(key, 0, key_size);
> =C2=A0		pr_err("hfsplus: Invalid key length: %u\n",
> key_len);
> =C2=A0		return;
> =C2=A0	}
> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> index f416e562d..779d7df0b 100644
> --- a/fs/hfsplus/brec.c
> +++ b/fs/hfsplus/brec.c
> @@ -148,7 +148,8 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> void *entry, u32 entry_len)
> =C2=A0	 * at the start of the node and it is not the new node
> =C2=A0	 */
> =C2=A0	if (!rec && new_node !=3D node) {
> -		hfs_bnode_read_key(node, fd->search_key, data_off +
> size);
> +		hfs_bnode_read_key(node, fd->search_key, data_off +
> size,
> +				=C2=A0=C2=A0 fd->key_size);
> =C2=A0		hfs_brec_update_parent(fd);
> =C2=A0	}
> =C2=A0
> @@ -166,7 +167,7 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> void *entry, u32 entry_len)
> =C2=A0		entry_len =3D sizeof(cnid);
> =C2=A0
> =C2=A0		/* get index key */
> -		hfs_bnode_read_key(new_node, fd->search_key, 14);
> +		hfs_bnode_read_key(new_node, fd->search_key, 14, fd-
> >key_size);

We need finally rework this 14 on named constant.

> =C2=A0		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
> =C2=A0
> =C2=A0		hfs_bnode_put(new_node);
> @@ -464,7 +465,7 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0		}
> =C2=A0		fd->bnode =3D hfs_bnode_find(tree, new_node->parent);
> =C2=A0		/* create index key and entry */
> -		hfs_bnode_read_key(new_node, fd->search_key, 14);
> +		hfs_bnode_read_key(new_node, fd->search_key, 14, fd-
> >key_size);

Ditto.

> =C2=A0		cnid =3D cpu_to_be32(new_node->this);
> =C2=A0
> =C2=A0		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
> @@ -476,7 +477,7 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0			if (new_node =3D=3D node)
> =C2=A0				goto out;
> =C2=A0			/* restore search_key */
> -			hfs_bnode_read_key(node, fd->search_key,
> 14);
> +			hfs_bnode_read_key(node, fd->search_key, 14,
> fd->key_size);

Ditto.

> =C2=A0		}
> =C2=A0		new_node =3D NULL;
> =C2=A0	}
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 6f240f87f..d0d4fea94 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -268,6 +268,8 @@ struct hfs_find_data {
> =C2=A0	int record;
> =C2=A0	int keyoffset, keylength;
> =C2=A0	int entryoffset, entrylength;
> +	/* size of each of the search_key and key buffers */

We need to have a comment before structure declaration. Ideally, it
will be good to comment every field.

> +	u32 key_size;

This is not proper place for this declaration.

struct hfs_find_data {
	/* filled by caller */
	hfsplus_btree_key *search_key;
	hfsplus_btree_key *key;
	/* filled by find */
	struct hfs_btree *tree;
	struct hfs_bnode *bnode;
	/* filled by findrec */
	int record;
	int keyoffset, keylength;
	int entryoffset, entrylength;
};

This is the field is prepared by caller. So, it should be group in the
first section.

From my point of view, keylength and key_size are not semantically
different. Could we suggest some better word here?

Thanks,
Slava.

> =C2=A0};
> =C2=A0
> =C2=A0struct hfsplus_readdir_data {
> @@ -372,7 +374,8 @@ void hfs_bmap_free(struct hfs_bnode *node);
> =C2=A0void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32
> len);
> =C2=A0u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
> =C2=A0u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
> -void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off);
> +void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
> +			u32 key_size);
> =C2=A0void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u3=
2
> len);
> =C2=A0void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data)=
;
> =C2=A0void hfs_bnode_clear(struct hfs_bnode *node, u32 off, u32 len);
