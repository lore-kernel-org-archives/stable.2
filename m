Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028843;
	b=N4NjagPpH9PUihF4E8kBs5Nl1/44aU0YhVnY+2CeYnVY+6E1f1/ba/Y5HaBefeSQa5sL
	 0+rLZOBugpxlXauVf8J3ryysKO1H0LXQcpSEHKyZ1vsTh447dGl7IUgYV1ZPjuUyGeNbB
	 lSPih4ZKeLCZhco2DTIrpmwBBMbMJpMVL8ElNaRn01ryRMQOg/Zs7zVSqrcArppqinCHu
	 Sbhqy7QuX4NEfVBFfux5gOH6tFDC1u7Zh+n7rkVEEw7IABAHxhdBBbRvVHrwg1bQYVrxA
	 LSLKPHZ/WXKbKQ+jsPMuCowQp0WKjqGDNgvkyZfGk7mjGGJZon1y9BJdIkKUfRtdWJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=5Is/0gtB/npS3a6DA/01BZS0zta18kJe8PFrYizj9bM=;
	b=KJVnZb9L+bci96C5cn2Fs22te9eUY2JjpACmPD3vztFkqdt4vlmkVqcjlYVU5ap1DLBU
	 +rQCcKMdIZ0zm/ZCiajjD26+eEy4JecIM5aWGIqf2XWtbrCq3DY7tNrobn8gPw5n0zzrc
	 NWSdEmhtqK22ICa1jIaoCVf9fyshGfhkKDvP44tcDNL4W3thJg+egFRwPWunNnXccEmae
	 P+n1VfoZ2W2ftdGBp4EJrEYxBT085q+Gn0MnCcLwdlQ6EC55Iy9KnHXsk/q5nix0uLZZf
	 q45L5VvNnCCgrf4voMzeEcBRuByy860uvULRWmvdO9m70A2CkuThP4zTJxDvhar5VCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=C6NPlSfh;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EEB606A336
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96EEB606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=C6NPlSfh
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b4f4095a7aso13121757b3.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795028839; x=1795633639; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Is/0gtB/npS3a6DA/01BZS0zta18kJe8PFrYizj9bM=;
        b=C6NPlSfhAtP8uGvfR2RMGIU/3LEOP2n6n8hwWtj+BmuxBdP8HKau9UB9vzPjSaxWhc
         thUFEBydTXtkjZisV6zxWXFPZ6VbogfrBnu1WZ+mzakgVvXKqvf5xrtE+gMVlpOf943P
         er5shC7Pm8FGK7dK0NJk2jnjrubsV5pGeinXTekNHynWUWNdoy5rYTC1Q/Kdw5yh26FO
         tLPLNgaym/IGksEK7tseAhKsBYm9KNL9DLVZ6+4wp9qSHf1pP3GNib2vElYWdqEXLtku
         opvfdNHKHMXIDbNMSyeXZPWMQ7bycpGqZubSYPGauBFqmRqdYdF/Q/0NIL85t2KC1/DS
         XGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795028839; x=1795633639;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Is/0gtB/npS3a6DA/01BZS0zta18kJe8PFrYizj9bM=;
        b=L2sX1u33skGjKD2CtjQN0MKfsxUYahRHpUfluD+D7hX08zH+oiF4stdfGCMRKCfYsX
         +RN0cfwtM1X1JibfOxNzfxw3OLC0qr6VIR5FeDMTxojosP+busmxEldolINzPrUdznfd
         KurcOXuH1CESEHoCHZEus5cO+FZ9PH9ZtudSAYgNNsrsgoZIhOiH/hyYFNkOeg/UMG/K
         jrLIktIssV/ZlcTh/QVRvjmC4PHLktd332+0Bal/Prg/NP8U2p9JiPfGaeYOdLoJfefG
         8oGL0iFKkzyLlr2Czxfete1u5/yPG/xF7R4vLVJBpGvYBDcvpIaDyMaRgSVMZzB93Of0
         bPag==
X-Forwarded-Encrypted: i=1; AL+hErHWy0eN9eFNT+o8huqCTUsMFSvZ2ZLOKc9p3bEEhiKZ0/x971KIKGC6VY+TjvLLWoRJN4p56Kk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cRYLpR55bFbS90Q6pF6NffFx4D3Jj7qlI8muixvPu6/0E51Es
	3BJfM+r9rb5B9eQJqfNM2g2O595BZdyOEcq5tpzXFh/t82dFyZhTfNZpSoB+YWFAEG4=
X-Gm-Gg: AZFdTZfUCISPPkWtQtu/CdYfhx9qVkMgmBWd9IbC/CzXMutqVYNVnI4irlng18HtcGV
	6PGnhtz2Njyfs/o5fq6LMER69755Q8XCSwCklnAOUHVGBlVIIDtwGYzQB+nKHA7OhK3W0cgoow7
	3ThS7It76PQzZiXTeOzo0iEbnEZIacYGh3l+NEZG90zGokJKBc9nccTQYoR7/e6Ns1/HXHWfT3p
	9hII29eZMPanx89yVy1AQVB6eJEtdtgMGT9LI/0fvm9RT8oyPzwr83XF0lr2Ex88tpOPjXQR42Y
	7k/KsjOE9TwpHwPr8xEQXctGxeDab876ErA5AV1iSItnRw1ayIjchVr6fz8aHqpIe6Qwvz/o5i9
	buGgX2lJG89ROWCtVZ0GVIHraLPRyUwB5Llj8z1POatQ2qZnfT5ugCWEWK7lYvs6LiKrkOGuBTm
	3sz4mgQ0a7Z+E5C6qXcjJelXs7ooE11AzKfkBAVwYS+e+Ia81gS6Wnom3dd5TdNi/2ukMa4kvJ/
	TuEo6NfKh+/dbkgtiSiYlHM6OS5QiofkWGYh2lqJi18743Flj2BTPr1njHG74xeXtGudt/YxchE
	tcMp2afFmpEVqUKdL/du459cl9rQoRZwUTeZXxSPfKNj8mhqjMaNVOINp57LHFSFrbS3i0SWgrI
	BHoNGavUGB7NIB3YIR+NCQat7HEcEEea+oejIYDn06JzBytPQ0BoxWIjkruSFmsOy10vQfes=
X-Received: by 2002:a05:690c:302:b0:8b4:d9cf:4582 with SMTP id 00721157ae682-8b4fec0e799mr18348367b3.5.1795028839621;
        Wed, 18 Nov 2026 11:07:19 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:5fae:4d02:7055:94ad])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fdf1e147sm22737017b3.5.2026.11.18.11.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:07:18 -0800 (PST)
Message-ID: <ca0aee0d8c6b51a70e0440bb53d84cbe652962c1.camel@dubeyko.com>
Subject: Re: [PATCH v2 2/2] hfs: pass the key buffer size to
 hfs_bnode_read_key()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ozgun kultekin <ozgunkultekin@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, yangguikun19@qq.com,
 stable@vger.kernel.org
Date: Wed, 18 Nov 2026 11:07:17 -0800
In-Reply-To: <20261118013725.90985-3-ozgunkultekin@gmail.com>
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
	 <20261118013725.90985-1-ozgunkultekin@gmail.com>
	 <20261118013725.90985-3-ozgunkultekin@gmail.com>
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
> Record the size of each key buffer in struct hfs_find_data in
> hfs_find_init(), allocate the two buffers from it, and pass it to
> every
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
> =C2=A0fs/hfs/bfind.c | 6 ++++--
> =C2=A0fs/hfs/bnode.c | 7 ++++---
> =C2=A0fs/hfs/brec.c=C2=A0 | 9 +++++----
> =C2=A0fs/hfs/btree.h | 5 ++++-
> =C2=A04 files changed, 17 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index d56e47bdc..15b0763ba 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -21,11 +21,13 @@ int hfs_find_init(struct hfs_btree *tree, struct
> hfs_find_data *fd)
> =C2=A0
> =C2=A0	fd->tree =3D tree;
> =C2=A0	fd->bnode =3D NULL;
> -	ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> +	/* search_key and key, each holding one key of the largest
> size */
> +	fd->key_size =3D tree->max_key_len + 2;
> +	ptr =3D kzalloc(2 * fd->key_size, GFP_KERNEL);
> =C2=A0	if (!ptr)
> =C2=A0		return -ENOMEM;
> =C2=A0	fd->search_key =3D ptr;
> -	fd->key =3D ptr + tree->max_key_len + 2;
> +	fd->key =3D ptr + fd->key_size;
> =C2=A0	hfs_dbg("cnid %d, caller %ps\n",
> =C2=A0		tree->cnid, __builtin_return_address(0));
> =C2=A0	switch (tree->cnid) {
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index fcb5b9cd1..11d3bfc9d 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
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
> @@ -83,8 +84,8 @@ void hfs_bnode_read_key(struct hfs_bnode *node,
> void *key, u32 off)
> =C2=A0	else
> =C2=A0		key_len =3D tree->max_key_len + 1;
> =C2=A0
> -	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
> -		memset(key, 0, sizeof(hfs_btree_key));
> +	if (key_len > key_size || key_len < 1) {
> +		memset(key, 0, key_size);
> =C2=A0		pr_err("hfs: Invalid key length: %u\n", key_len);
> =C2=A0		return;
> =C2=A0	}
> diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
> index 5a2f740dd..d64cc2e53 100644
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
> +				=C2=A0=C2=A0 fd->key_size);
> =C2=A0		hfs_brec_update_parent(fd);
> =C2=A0	}
> =C2=A0
> @@ -156,7 +157,7 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> void *entry, u32 entry_len)
> =C2=A0		entry_len =3D sizeof(cnid);
> =C2=A0
> =C2=A0		/* get index key */
> -		hfs_bnode_read_key(new_node, fd->search_key, 14);
> +		hfs_bnode_read_key(new_node, fd->search_key, 14, fd-
> >key_size);
> =C2=A0		__hfs_brec_find(fd->bnode, fd);
> =C2=A0
> =C2=A0		hfs_bnode_put(new_node);
> @@ -450,7 +451,7 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0		}
> =C2=A0		fd->bnode =3D hfs_bnode_find(tree, new_node->parent);
> =C2=A0		/* create index key and entry */
> -		hfs_bnode_read_key(new_node, fd->search_key, 14);
> +		hfs_bnode_read_key(new_node, fd->search_key, 14, fd-
> >key_size);
> =C2=A0		cnid =3D cpu_to_be32(new_node->this);
> =C2=A0
> =C2=A0		__hfs_brec_find(fd->bnode, fd);
> @@ -462,7 +463,7 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0			if (new_node =3D=3D node)
> =C2=A0				goto out;
> =C2=A0			/* restore search_key */
> -			hfs_bnode_read_key(node, fd->search_key,
> 14);
> +			hfs_bnode_read_key(node, fd->search_key, 14,
> fd->key_size);
> =C2=A0		}
> =C2=A0		new_node =3D NULL;
> =C2=A0	}
> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> index 1f703f2c5..a24a3c966 100644
> --- a/fs/hfs/btree.h
> +++ b/fs/hfs/btree.h
> @@ -82,6 +82,8 @@ struct hfs_find_data {
> =C2=A0	int record;
> =C2=A0	int keyoffset, keylength;
> =C2=A0	int entryoffset, entrylength;
> +	/* size of each of the search_key and key buffers */
> +	u32 key_size;
> =C2=A0};
> =C2=A0
> =C2=A0static inline bool is_hfs_bnode_range_valid(struct hfs_find_data
> *fd,
> @@ -117,7 +119,8 @@ extern void hfs_bmap_free(struct hfs_bnode
> *node);
> =C2=A0extern void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32
> off, u32 len);
> =C2=A0extern u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
> =C2=A0extern u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
> -extern void hfs_bnode_read_key(struct hfs_bnode *node, void *key,
> u32 off);
> +void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
> +			u32 key_size);
> =C2=A0extern void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32
> off, u32 len);
> =C2=A0extern void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u1=
6
> data);
> =C2=A0extern void hfs_bnode_write_u8(struct hfs_bnode *node, u32 off, u8
> data);

Please, see my remarks for HFS+ patch. I have the same comments here.

Thanks,
Slava.
