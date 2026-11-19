Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127571;
	b=sBmHsbi/PaGw4OMiNnN25NEwG4W81CFW0/HjEQ6jtwG8UkJ3b7vFuY2TDIgbGhdDfOu3
	 vhPNmu2KAgzxPHrpdSxSVV+MRFNYwRBS+l93Om33xWH5mylVn7svmOqjKy98QZfp1xhln
	 CEkkx+x3G3nMGB6t5qsOIJ2teuBlUwj0tjUB/mCFZce29mitU1x8KL8jQbmExoThhrebf
	 9c+Y0dQQ9rykoMX/aDCtZOJSQHTiQo6ad/Vxg8IaQtl6n779/SsaxKgFqK8AtKki0Mb8S
	 ni0XUG7I2rRFNY/G8+a3hpKNMauZasmL3MY33dIeWy1YGe6YdFMjAfIWCnh7wtNZl2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=jrr4HcrEAkwEK08sDfVW0qFjcfdZdHWM+k+VxkfGpeU=;
	b=SLOuJtHnaR+P79hmLVBtSYgUUv8WdyXT+e36HWlSeE5u381khIWa2KP5WgtGi04cM7xz
	 HKx/bfpXTt0Ie3xhtbTIoQtFFrUq59WL4DjpYQJlzzodC0DcznU64iAnD+MrdacRogSzz
	 bZUCzfsoj37o8V4uGwuVmlM6lOEpmtxUfFxytokhfyqdj52LIXxOwc8Idku57SaZYNsWT
	 9R1Qfc5uPyNtOTRSQ8FLC1mVfwJHJHVhw8TyktTnujulsfzPKX/Z/zBzmBC8x+bj4myM8
	 pWGnZSpTURrDeEjfVLHBUzN7d/BLibCGxp5sngk0Q1xzmLqBshP88v52bF3fdbIbHFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hnq5NOsi;
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F465606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 22:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F465606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hnq5NOsi
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67df3b1ca06so394836d50.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795127569; x=1795732369; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jrr4HcrEAkwEK08sDfVW0qFjcfdZdHWM+k+VxkfGpeU=;
        b=hnq5NOsiuGjLqvIrTk+BAOk+/WkZJ0Y5ClUSi7SkTmv1zPv+2WpWDWraTIYDoEs61I
         mHf4V9Me7v0OUkZs5rm2i0jyiZbt8YB3m2muNaS7B/Fj02TEtEI8VrqQA8JJgUI+DQq0
         kKmrUg8XYWSECzXW8lE6/E3LRmoPplkUipNM+d2FLhOed/hvLWYM+WBivqa/bzR45SGg
         ey5cjkkcIJNbaWf083UgI5/8kxd+8XFqXvx205GVTj+yfjZo9J/t+vrQJ9bpBYdXpWPn
         Kv7xffXdDbakVPOYmVs+OWwMrVH5gMbzASJbNeXkT/hkStVXRzViiNQ0GOaP4mKqgQrB
         qkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795127569; x=1795732369;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jrr4HcrEAkwEK08sDfVW0qFjcfdZdHWM+k+VxkfGpeU=;
        b=Dm3BA0bvkEGbYADv6kSOBHZtZydevJglWLxtIcIxuvjtomgwBuQuSGCpOR2HMCMwJ6
         F0wqEvIWfMw/tGn/aKR4XZuwSmSUMMXu2MrIvzaIHIHsUFoBugVNrIwq62xhtRl5hihL
         uM2cMBXbP7Tts4ffT5JyVJr9g0r/1fc6DPcDxjhRz8YNtcbHAZG1DOtekJqffkY22Kn6
         M734Mu8R3sCLeNu9vkO637KzUkYRqHPFyOimv2dvrIhZUBMMepzzoZfZPT7R+exlGOmp
         j8hQE/x8ZINREXS7RAxth8Mrv36iMRjhK1EEm6vvPU22FujQc8QzX/2BDmD7rHs7Ts9d
         LImQ==
X-Forwarded-Encrypted: i=1; AL+hErGIckWW/CUsfJB+23c/e6B2//B4a1GtUgenYqbhy5Nqto0oUJMfc8Havng7vmIh7IpqJabQgl8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JEVosojgxi/TZLRDQYl7/Y/2JNpiR3XW4orjEUX6gq7/skxSU
	Okd0q0JYKIWPIsA958JaN0I7GuvfMzrlB+29dFC5X73Ku7/3UHgubLYBXOL5NG64nYk=
X-Gm-Gg: AZFdTZewJWNGr4sTojYSFJNA7Hlhzv86qDJ4jhh0XfKhAFVT7xZVYqneeQFJP4lVrj4
	PhUcMuv7eDxFLdxfPRGuWHehTn/JykGp3LZiXD43F8nEVHiIEA5oTpe25IzgWEAXxdkF16//Dmx
	R/ThVCQbgK5K7AIzXIrdzYoEML9fcjkVHgVEq9lbgtwlP/FgIgTMK8eEA5HjRMo/M6ynct3SHsM
	s+e0ANUZ4u0VPgS/Je2CATaNDpt/c3g8n39p1DFi/kuum+B+IS13QyyE3kXufLgt2q1cfRzuahm
	vqrwjtj3kIkygqVIfvjPnZdEn11T7cX5yJ3lFRCmZOAv/KH7hp1LjZniT+xmNP5XmKcv6Zln8/w
	QyYoYB0R9mFlbm9iuEUTPgsi7QpCMtMPHDKnNVITVN14CmLQmsb9ml73Wp9hjysAs8D4p0oGkxz
	AIivn7tJv4reBDYBXAmnlwsrdhoLtQ0r3D7e8dPJWMdmW6afbdzayTUhMBhDiPhIqywwpU9X3MJ
	zpGv5olq7vd9uNnto1hn/2X2/NuDOPFAnyvV/N7iT7BiejLVk2Oxt6+eORJlzaxdcNeJNYCthel
	lIKcgi/DbeFRw5f3LweLE3jpydJNt3IHiqldgLZzRfozIUTT/rkRVcSpRR+JoQP9eNiiq5hA5OH
	uFWbQNFS14XpyupLXxzF/AgEtUJolnPIe7lxzSpRXfAdk8AH1pAtshTpMYOvcqDp85uMBP0KPTE
	/NNL65bMYiQ4IFre+XH3Tk6czJOJfx/qPkfvJxy7Qj
X-Received: by 2002:a05:690e:c4c:b0:67c:1a7d:d968 with SMTP id 956f58d0204a3-67df44934e8mr461560d50.92.1795127569195;
        Thu, 19 Nov 2026 14:32:49 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:1932:ad09:1827:11fb? ([2600:1700:6476:1430:1932:ad09:1827:11fb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33d64a0sm755323d50.22.2026.11.19.14.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 14:32:48 -0800 (PST)
Message-ID: <cc1627ab6fc51312b610c8af19f63c70c3a92ac9.camel@dubeyko.com>
Subject: Re: [PATCH v3 2/3] hfsplus: pass the key buffer size to
 hfs_bnode_read_key()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ozgun kultekin <ozgunkultekin@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, yangguikun19@qq.com,
 stable@vger.kernel.org
Date: Thu, 19 Nov 2026 14:32:39 -0800
In-Reply-To: <20261119005943.37851-3-ozgunkultekin@gmail.com>
References: <20261118013337.67813-1-ozgunkultekin@gmail.com>
	 <20261119005943.37851-1-ozgunkultekin@gmail.com>
	 <20261119005943.37851-3-ozgunkultekin@gmail.com>
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
> Do not let hfs_bnode_read_key() assume the size of the buffer. Store
> the size of each key buffer in struct hfs_find_data as key_buf_size
> in
> hfs_find_init(), allocate the two buffers from it, and pass it to
> every
> hfs_bnode_read_key() call. Keys longer than the buffer are rejected
> as
> before, and the error path clears only the buffer.
>=20
> The allocation size does not change: max_key_len * 2 + 4 is now
> written
> as HFS_FIND_KEY_BUFS * (max_key_len + HFSPLUS_KEY_LEN_SIZE). Document
> struct hfs_find_data while adding the field.
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
> v3: key_size renamed to key_buf_size and moved to the "filled by
> caller"
> =C2=A0=C2=A0=C2=A0 part of struct hfs_find_data, struct and fields commen=
ted, buffer
> =C2=A0=C2=A0=C2=A0 size written with named constants, as requested by Via=
cheslav
> v2:
> https://lore.kernel.org/all/20261118013337.67813-1-ozgunkultekin@gmail.co=
m/
> v1:
> https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.co=
m/
>=20
> =C2=A0fs/hfsplus/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
> =C2=A0fs/hfsplus/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++---
> =C2=A0fs/hfsplus/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++--=
--
> =C2=A0fs/hfsplus/hfsplus_fs.h | 28 ++++++++++++++++++++--------
> =C2=A04 files changed, 33 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> index ca9813f58..948bc3086 100644
> --- a/fs/hfsplus/bfind.c
> +++ b/fs/hfsplus/bfind.c
> @@ -19,11 +19,12 @@ int hfs_find_init(struct hfs_btree *tree, struct
> hfs_find_data *fd)
> =C2=A0	fd->tree =3D tree;
> =C2=A0	fd->bnode =3D NULL;
> =C2=A0	hfs_find_result_init(fd);
> -	ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);

OK. It looks like we try to reserve the space for two hfsplus_btree_key
(search_key + key) and for two __be16 key_len. Correct? But any key
struct hfsplus_cat_key, struct hfsplus_ext_key, struct hfsplus_attr_key
already include __be16 key_len:

struct hfsplus_ext_key {
	__be16 key_len;
	u8 fork_type;
	u8 pad;
	hfsplus_cnid cnid;
	__be32 start_block;
} __packed;

Do we really need to add this 4 or sizeof_field(hfsplus_btree_key,
key_len)? I assume that tree->max_key_len should include the size of
key_len. Am I right?

> +	fd->key_buf_size =3D tree->max_key_len + HFSPLUS_KEY_LEN_SIZE;
> +	ptr =3D kzalloc(HFS_FIND_KEY_BUFS * fd->key_buf_size,
> GFP_KERNEL);
> =C2=A0	if (!ptr)
> =C2=A0		return -ENOMEM;
> =C2=A0	fd->search_key =3D ptr;
> -	fd->key =3D ptr + tree->max_key_len + 2;
> +	fd->key =3D ptr + fd->key_buf_size;
> =C2=A0	hfs_dbg("cnid %d, caller %ps\n",
> =C2=A0		tree->cnid, __builtin_return_address(0));
> =C2=A0	mutex_lock_nested(&tree->tree_lock,
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 3a1a1fa6f..9fd06ce88 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -71,7 +71,8 @@ u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32
> off)
> =C2=A0	return data;
> =C2=A0}
> =C2=A0
> -void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
> +void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
> +			u32 key_buf_size)

The key_capacity looks better.

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
> +	if (key_len > key_buf_size || key_len < 1) {
> +		memset(key, 0, key_buf_size);
> =C2=A0		pr_err("hfsplus: Invalid key length: %u\n",
> key_len);
> =C2=A0		return;
> =C2=A0	}
> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> index 37e058c5d..2a63b06d8 100644
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
> +				=C2=A0=C2=A0 fd->key_buf_size);
> =C2=A0		hfs_brec_update_parent(fd);
> =C2=A0	}
> =C2=A0
> @@ -167,7 +168,7 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> void *entry, u32 entry_len)
> =C2=A0
> =C2=A0		/* get index key */
> =C2=A0		hfs_bnode_read_key(new_node, fd->search_key,
> -				=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE);
> +				=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE, fd-
> >key_buf_size);
> =C2=A0		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
> =C2=A0
> =C2=A0		hfs_bnode_put(new_node);
> @@ -467,7 +468,7 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0		fd->bnode =3D hfs_bnode_find(tree, new_node->parent);
> =C2=A0		/* create index key and entry */
> =C2=A0		hfs_bnode_read_key(new_node, fd->search_key,
> -				=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE);
> +				=C2=A0=C2=A0 HFS_BNODE_DESC_SIZE, fd-
> >key_buf_size);
> =C2=A0		cnid =3D cpu_to_be32(new_node->this);
> =C2=A0
> =C2=A0		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
> @@ -480,7 +481,8 @@ static int hfs_brec_update_parent(struct
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
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index dd88053cc..f19787eba 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -257,17 +257,28 @@ static inline void
> hfsplus_mark_inode_dirty(struct inode *inode,
> =C2=A0	mark_inode_dirty(inode);
> =C2=A0}
> =C2=A0
> +/* hfs_find_init() allocates search_key and key as one buffer */
> +#define HFS_FIND_KEY_BUFS	2
> +
> +/* Size of the key_len field at the start of every key */
> +#define HFSPLUS_KEY_LEN_SIZE	sizeof_field(hfsplus_btree_key,
> key_len)
> +
> +/*
> + * State of one b-tree search. hfs_find_init() sets up the key
> buffers
> + * and the tree, the search functions fill in the rest.
> + */

I expected to have comments here but not inside the structure
declarations.

> =C2=A0struct hfs_find_data {
> =C2=A0	/* filled by caller */
> -	hfsplus_btree_key *search_key;
> -	hfsplus_btree_key *key;
> +	hfsplus_btree_key *search_key;	/* key to search for */
> +	hfsplus_btree_key *key;		/* key of the found
> record */
> +	u32 key_buf_size;		/* size of each of
> search_key and key */

I think key_capacity could be better name, finally.

I spent some time for analysis. I think my request to put it here was
not good suggestion. Putting u32 key_buf_size after the two pointers
leaves a 4-byte hole, and pahole shows struct hfs_find_data growing
from 56 to 64 bytes. Also, "filled by caller" heading was already wrong
(hfs_find_init() fills these fields, and tree too).

> =C2=A0	/* filled by find */
> -	struct hfs_btree *tree;
> -	struct hfs_bnode *bnode;
> +	struct hfs_btree *tree;		/* tree being
> searched */
> +	struct hfs_bnode *bnode;	/* node with the found
> record */
> =C2=A0	/* filled by findrec */
> -	int record;
> -	int keyoffset, keylength;
> -	int entryoffset, entrylength;
> +	int record;			/* index of the record in
> bnode */
> +	int keyoffset, keylength;	/* offset and length of its
> key */
> +	int entryoffset, entrylength;	/* offset and length of its
> data */
> =C2=A0};

I am thinking about this:

struct hfs_find_data {
        /* set by hfs_find_init() */
        hfsplus_btree_key *search_key;
        hfsplus_btree_key *key;
        struct hfs_btree *tree;
        /* filled by find */
        struct hfs_bnode *bnode;
        /* set by hfs_find_init() */
        u32 key_capacity;
        /* filled by findrec, reset by hfs_find_result_init() */
        int record;
        int keyoffset, keylength;
        int entryoffset, entrylength;
};

Thanks,
Slava.

> =C2=A0
> =C2=A0struct hfsplus_readdir_data {
> @@ -372,7 +383,8 @@ void hfs_bmap_free(struct hfs_bnode *node);
> =C2=A0void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32
> len);
> =C2=A0u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
> =C2=A0u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
> -void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off);
> +void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
> +			u32 key_buf_size);
> =C2=A0void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u3=
2
> len);
> =C2=A0void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data)=
;
> =C2=A0void hfs_bnode_clear(struct hfs_bnode *node, u32 off, u32 len);
