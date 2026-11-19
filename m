Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795128394;
	b=dRazGo1HOt3q/y/7oiu4c9b1JhvOoOrPRM05iy/34lFrBEYX7bp20QTQXF2xTUwT5KWp
	 69pwrqCbRf361IWTUQ5uPdTX1pplZ+rYkDIzzbPFps+4MPgeKsWKIXTpPO3NJlz2393Sw
	 Nje+2WsAbXG9nXN/TLQlMkeDCKX3QOL1EI7HlZ+VcLrLVbl/nNKRa8H6NsySrZCLwselX
	 1cChQo3pZ/lKczxNthtdFkMKX5GtGkFnIAHh9ruASUF0uRRPkam2FhaG5oVZe1V49UO8m
	 7KTbJ3cmpcuc5t6H7TncSwhRE56TZKd6ZyG9HJQC13jzwE3JGmp3Wu8Egb7Um/r7+7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795128394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=qv5gJvtNIAuhRD34Za5jfn9wJJHs/Ut0eswJ0g8a59E=;
	b=2ukxwCdwOw31pj5RwcR24lUtYeuDsrkfVJ6z+U1lJPnWuQsceSWmJHqq8oCRS8UrIAzG
	 kMdetYI0gwpV8JpN+fO/VjpYKv5fg+GuqL7Zo/XJGhQ/uKc+D8vJyhHVrDQqrvY4xui4X
	 9XeMas8hy5JiEG0r2xc2D+TXYK3x5rFfk0fMPdSUVQKbdBMwZ4vMWpIkQ6hhWtNqfL0Kf
	 GErrSZXsMZHrnWZkHL32YkNylqZDRwfLmGHe5R+tP0F+kayMhdUbdZVSGNc/AM6MTh5mR
	 d0XlYgtZHq4vCDzEtiDUs1H8EX7ICz3pfZCMcL6HTzDwwmlskgVgBltaAp8/XjJQMCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LdQ7KKwU;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22DA606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 22:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A22DA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LdQ7KKwU
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b360828905so2299707b3.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795128392; x=1795733192; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qv5gJvtNIAuhRD34Za5jfn9wJJHs/Ut0eswJ0g8a59E=;
        b=LdQ7KKwUNQ8Yi8jtApWu2Grax6XWhpnuCmnWjGgFZkcZXZnPDlQsoourdJGC291+VN
         H5I8XS61GOmvTfyXFZBaIyEOuew+rsgZdzmWm/iTMX/Rgmz6PX/KrFaFLl6HchGwBPSl
         cJqt1JMkYo4d8A0uH6MuVs+c/JSHqpEto3vh0Etw2oZkOlfGuPioq++MPqaKe8/VMXWm
         ZOqLSEJjKaqpNc5knh/l6aOTqU+znfTyA/OAZ7mgdPG40sKXYc/Wcs/oOZvh9PHRXifa
         PbSgJXx5vlPq2fLG1Rk57IxIjlpmElF1i2rJhMhZ7aXrKnerLxuAmZz8mm4llQBtCHjX
         gDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795128392; x=1795733192;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qv5gJvtNIAuhRD34Za5jfn9wJJHs/Ut0eswJ0g8a59E=;
        b=uzHn7VhcrEEuSytwAUm3FnM+3N1o1d/+cBYOguLRxvUCIeliq1di/2JGUWmll699k9
         jR29d3wKcTmCzrD/a9rMyWvMgSwuJ3Ic6D2RtFKBgqjE36kGRF5cA0iB73wyHrLY0OSY
         VyldshIeNB9gHhfJbmQOVZyq5FazicK5oJJb3DSmKjpDsw7q7yXdRnuycgyb0LKUZnG2
         iXM1YNaTRqmzBCXju2NbqEWkU/kzNWJDv9Xy9CQMeEQKvSI936YdcrmiIobR+jfFZ+uh
         goezNicLEmJMmqpeR8EM8eYdQNbqni8NcJQxyk4WYyXxuTsgldm0iBqRBFpVQyI3GD00
         Yggw==
X-Forwarded-Encrypted: i=1; AL+hErF2HihV0AORXwjOUTgB+MrOnTUJH2TX3NdAH/7pYzYGIeAsFFw6V9IqLYhBwK4PtsE4htQEXnk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zdjKgY4RQUchf5qk88d1ClgUY9fi/ah88md3mqV2ismm6kss+
	3s3qs0rsJPqm8hG56vt2cKPTYOuRBA/ifFEdO1hF6DZXaDfWck8CmXf45B2mvx0yxU8=
X-Gm-Gg: AZFdTZe/27Cxxth1DJbCoG8WknXBrmgvd0I6U599S8TZorr25hRsMBQm+Evy5y5Cjrg
	2LmRIcH0nrZTI/U6vkp9KvPxPmRW7r56uhSNGDr0qxPPs5l4rYeoBKvNEZgrTBuR9SzWCU+SyTl
	q4aUno4gTtgfISs0eseQRZgUWamaVKy+YBf57a1NgKog2b5NFvpqFJno5GCDsTANvOwU66lyB1m
	Y5laezo6WU8OlO/PoLWeDAePRKYS4VEykK46fkmUe6pryE+B1xWcgJeojwK3SwIyrCkTX053ney
	0e8oaZftuj5VcYghXGZ7rDzV/raMXjC664s1JRsQbvC6IptQyeSIfbliD6E6HafonOkRNt1icuL
	1dm+Tu8JezTcSJ/Nw65n5HnN6+Whk+6FiDi8cDvwHqbqssEvtz6/9n63jpwUglJ3jD26z7exgsZ
	6T5rQoKqjL4JiEhAZ8APNKIgmI7/wJ0EQgsB5R1tVgjUEYEeZYnK6uzp/C/l7KuCu7qNh7Jb8dV
	YEZopJ18hGwz80P4vyjGdpUt69XEcHPEn7JdwycwIXRPCBKuWdgwF1P6BFrTpNL/u9fsjqsNlwJ
	PLDJFPWyMSrC80sNznESvOsZwgSUimiSxT7wsP6TgTlFKGKdpDdhrH6kMA2MeTiN4l06RfuZDTk
	atKsYeP4qRVTz7J01qpu7fKw3LWB9EiFckSC3F55mLFUU05myUf6NO0r1qT8uD8qXBbGl9Sbaki
	SGitIn5wuztnnOvJLT9ZFq
X-Received: by 2002:a05:690c:22c1:b0:8b5:28c:b962 with SMTP id 00721157ae682-8b5204f714amr5007937b3.89.1795128392554;
        Thu, 19 Nov 2026 14:46:32 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:1932:ad09:1827:11fb? ([2600:1700:6476:1430:1932:ad09:1827:11fb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52032d09esm6138597b3.35.2026.11.19.14.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 14:46:31 -0800 (PST)
Message-ID: <21fe9f22140ed8225445a9b6d0478bfafa20652f.camel@dubeyko.com>
Subject: Re: [PATCH v3 3/3] hfs: pass the key buffer size to
 hfs_bnode_read_key()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ozgun kultekin <ozgunkultekin@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, yangguikun19@qq.com,
 stable@vger.kernel.org
Date: Thu, 19 Nov 2026 14:46:30 -0800
In-Reply-To: <20261119005943.37851-4-ozgunkultekin@gmail.com>
References: <20261118013337.67813-1-ozgunkultekin@gmail.com>
	 <20261119005943.37851-1-ozgunkultekin@gmail.com>
	 <20261119005943.37851-4-ozgunkultekin@gmail.com>
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
> hfs_bnode_read_key() reads the key length of leaf records (and of all
> records of variable-key trees) from disk and only checks it against
> sizeof(hfs_btree_key). The destination is always one of the two key
> buffers hfs_find_init() allocates, each tree->max_key_len + 2 bytes
> long. For the extents tree max_key_len is 7, so the whole allocation
> is
> 18 bytes and a crafted leaf key writes up to 256 bytes from the image
> past it. The error path clears sizeof(hfs_btree_key) bytes of the
> same
> buffer.
>=20
> hfs_brec_insert() and hfs_brec_update_parent() reach this with keys
> that were never validated, the same way as in hfsplus.
>=20
> Store the size of each key buffer in struct hfs_find_data as
> key_buf_size in hfs_find_init(), allocate the two buffers from it,
> and
> pass it to every hfs_bnode_read_key() call. Keys longer than the
> buffer
> are rejected as before, and the error path clears only the buffer.
>=20
> The allocation size does not change: max_key_len * 2 + 4 is now
> written
> as HFS_FIND_KEY_BUFS * (max_key_len + HFS_KEY_LEN_MAX_SIZE), where
> HFS_KEY_LEN_MAX_SIZE is the 16-bit key length of HFS_TREE_BIGKEYS
> trees. Document struct hfs_find_data while adding the field.
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
> v3: same changes as in the hfsplus patch
> v2:
> https://lore.kernel.org/all/20261118013337.67813-1-ozgunkultekin@gmail.co=
m/
> v1:
> https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.co=
m/
>=20
> =C2=A0fs/hfs/bfind.c |=C2=A0 5 +++--
> =C2=A0fs/hfs/bnode.c |=C2=A0 7 ++++---
> =C2=A0fs/hfs/brec.c=C2=A0 | 10 ++++++----
> =C2=A0fs/hfs/btree.h | 31 +++++++++++++++++++++++--------
> =C2=A04 files changed, 36 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index d56e47bdc..d052b613e 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -21,11 +21,12 @@ int hfs_find_init(struct hfs_btree *tree, struct
> hfs_find_data *fd)
> =C2=A0
> =C2=A0	fd->tree =3D tree;
> =C2=A0	fd->bnode =3D NULL;
> -	ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> +	fd->key_buf_size =3D tree->max_key_len + HFS_KEY_LEN_MAX_SIZE;
> +	ptr =3D kzalloc(HFS_FIND_KEY_BUFS * fd->key_buf_size,
> GFP_KERNEL);

I have the same concerns here as for HFS+.

> =C2=A0	if (!ptr)
> =C2=A0		return -ENOMEM;
> =C2=A0	fd->search_key =3D ptr;
> -	fd->key =3D ptr + tree->max_key_len + 2;
> +	fd->key =3D ptr + fd->key_buf_size;
> =C2=A0	hfs_dbg("cnid %d, caller %ps\n",
> =C2=A0		tree->cnid, __builtin_return_address(0));
> =C2=A0	switch (tree->cnid) {
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index ec1b0189a..0cdc2ddf9 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -71,7 +71,8 @@ u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32
> off)
> =C2=A0	return data;
> =C2=A0}
> =C2=A0
> -void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
> +void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
> +			u32 key_buf_size)

key_capacity?

> =C2=A0{
> =C2=A0	struct hfs_btree *tree;
> =C2=A0	u32 key_len;
> @@ -83,8 +84,8 @@ void hfs_bnode_read_key(struct hfs_bnode *node,
> void *key, u32 off)
> =C2=A0	else
> =C2=A0		key_len =3D tree->max_key_len + 1;
> =C2=A0
> -	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
> -		memset(key, 0, sizeof(hfs_btree_key));
> +	if (key_len > key_buf_size || key_len < 1) {
> +		memset(key, 0, key_buf_size);
> =C2=A0		pr_err("hfs: Invalid key length: %u\n", key_len);
> =C2=A0		return;
> =C2=A0	}
> diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
> index 31574e562..3d2c64c57 100644
> --- a/fs/hfs/brec.c
> +++ b/fs/hfs/brec.c
> @@ -138,7 +138,8 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> void *entry, u32 entry_len)
> =C2=A0	 * at the start of the node and it is not the new node
> =C2=A0	 */
> =C2=A0	if (!rec && new_node !=3D node) {
> -		hfs_bnode_read_key(node, fd->search_key, data_off +
> size);
> +		hfs_bnode_read_key(node, fd->search_key, data_off +
> size,
> +				=C2=A0=C2=A0 fd->key_buf_size);
> =C2=A0		hfs_brec_update_parent(fd);
> =C2=A0	}
> =C2=A0
> @@ -157,7 +158,7 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> void *entry, u32 entry_len)
> =C2=A0
> =C2=A0		/* get index key */
> =C2=A0		hfs_bnode_read_key(new_node, fd->search_key,
> -				=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE);
> +				=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE, fd-
> >key_buf_size);
> =C2=A0		__hfs_brec_find(fd->bnode, fd);
> =C2=A0
> =C2=A0		hfs_bnode_put(new_node);
> @@ -462,7 +463,7 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0		fd->bnode =3D hfs_bnode_find(tree, new_node->parent);
> =C2=A0		/* create index key and entry */
> =C2=A0		hfs_bnode_read_key(new_node, fd->search_key,
> -				=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE);
> +				=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE, fd-
> >key_buf_size);
> =C2=A0		cnid =3D cpu_to_be32(new_node->this);
> =C2=A0
> =C2=A0		__hfs_brec_find(fd->bnode, fd);
> @@ -475,7 +476,8 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0				goto out;
> =C2=A0			/* restore search_key */
> =C2=A0			hfs_bnode_read_key(node, fd->search_key,
> -					=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE);
> +					=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE,
> +					=C2=A0=C2=A0 fd->key_buf_size);
> =C2=A0		}
> =C2=A0		new_node =3D NULL;
> =C2=A0	}
> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> index 1f703f2c5..56de6425e 100644
> --- a/fs/hfs/btree.h
> +++ b/fs/hfs/btree.h
> @@ -74,14 +74,28 @@ struct hfs_bnode {
> =C2=A0#define HFS_BNODE_NEW		1
> =C2=A0#define HFS_BNODE_DELETED	2
> =C2=A0
> +/* hfs_find_init() allocates search_key and key as one buffer */
> +#define HFS_FIND_KEY_BUFS	2
> +
> +/* Largest key length field: u16 in trees with HFS_TREE_BIGKEYS */
> +#define HFS_KEY_LEN_MAX_SIZE	sizeof(__be16)
> +
> +/*
> + * State of one b-tree search. hfs_find_init() sets up the key
> buffers
> + * and the tree, the search functions fill in the rest.
> + */
> =C2=A0struct hfs_find_data {
> -	btree_key *key;
> -	btree_key *search_key;
> -	struct hfs_btree *tree;
> -	struct hfs_bnode *bnode;
> -	int record;
> -	int keyoffset, keylength;
> -	int entryoffset, entrylength;
> +	/* filled by caller */
> +	btree_key *key;			/* key of the found
> record */
> +	btree_key *search_key;		/* key to search for */
> +	u32 key_buf_size;		/* size of each of
> search_key and key */
> +	/* filled by find */
> +	struct hfs_btree *tree;		/* tree being
> searched */
> +	struct hfs_bnode *bnode;	/* node with the found
> record */
> +	/* filled by findrec */
> +	int record;			/* index of the record in
> bnode */
> +	int keyoffset, keylength;	/* offset and length of its
> key */
> +	int entryoffset, entrylength;	/* offset and length of its
> data */
> =C2=A0};

The same issue here. The pahole shows a 4-byte hole, and struct
hfs_find_data grows from 56 to 64 bytes.

struct hfs_find_data {
        btree_key *key;
        btree_key *search_key;
        struct hfs_btree *tree;
        struct hfs_bnode *bnode;
        u32 key_capacity;
        int record;
        int keyoffset, keylength;
        int entryoffset, entrylength;
};

> =C2=A0
> =C2=A0static inline bool is_hfs_bnode_range_valid(struct hfs_find_data
> *fd,
> @@ -117,7 +131,8 @@ extern void hfs_bmap_free(struct hfs_bnode
> *node);
> =C2=A0extern void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32
> off, u32 len);
> =C2=A0extern u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
> =C2=A0extern u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
> -extern void hfs_bnode_read_key(struct hfs_bnode *node, void *key,
> u32 off);
> +void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
> +			u32 key_buf_size);

The new prototype drops extern while every neighbour keeps it.
checkpatch prefers no extern, but a mixed block looks accidental. Keep
extern here for consistency, or leave a full cleanup for a separate
patch.

Thanks,
Slava.

> =C2=A0extern void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32
> off, u32 len);
> =C2=A0extern void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u1=
6
> data);
> =C2=A0extern void hfs_bnode_write_u8(struct hfs_bnode *node, u32 off, u8
> data);
