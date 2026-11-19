Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795049894;
	b=rczAyj/PpX5Oq5hHH67oNnFjAu23j3E7R3uCGRn7rM4zK44GTLnnVXUoLNUIT7IHEKhc
	 gOQfnel06fuSDNdB7AhPXPXvWa0bdc17Sowyi88INSHiL/dfZ8T+Gt5+kkZYUZHu+dvwE
	 7AbpIww2agynSTfTfTMJDQC7p7eIsjveqw7knHVattDp9LhmtC7eWGCRzuwyoB5Edq6HO
	 GKgjjd5tquExRZVwoaJCsP0VeVrwDIc1SSuThNYxO+yEOAApnwCpRPqc/Z5n2J32gISmM
	 xmMLr9MHt3hMUsCGQtViLtZUs+HF+EY+rPYTsnSRDwVxST+b5Ubkf9H36KHVPlcxErg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3m4JP2toyOf5wM/Gm/lOr8X0+HToBEJENBBYIRuWj6A=;
	b=MUinsvE2v+ZeucAD/lAV0sqndOcbe4YF7XibMWOBxWOMvmjAhQ6S8aUeNUsPUq7k7x9L
	 9EeRda8193brG+77bkpn44zCclb8LtAEvLJFAqB4Nt22+PqQOBjE3mARJJcfg6fU6kTEx
	 LQR3lEeKJ2lMxlCF83IK6y35BjU2fXK/cdqY5VGukYa+xUqfMBePGq/LRW3FqJKh9tPZ5
	 H2q8fF0AiXwBJns+p8bKLAJoNgbDakC/g8ay1pD4Ul7NTE7MZAeHevVP7bQicMvvITM0r
	 f7T5U9sLCH7LqJTkoABGKiUloezmlufS9FPn8VJ0EHE/LC/v1x9sxfChdO1kyt+auuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KcsnJPEA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE08606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFE08606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KcsnJPEA
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67da69e7c31so1574206d50.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:58:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795049892; cv=none;
        d=google.com; s=arc-20260327;
        b=s81otKYZtw++VebAZ7uQDmzxgXp5DtvLmNTeFghx5M9Y4COHKKRxViiozZYyfkq4e5
         XaBb2FsvmErkQUvFA0N8GpRxhHPqHsakew2TCEPKjfAuFVm2nu2U/c/A23IitFkXO13T
         QNbIILMQuw2/HlqN8/Cf5O/ui7oq3/V0ByRzL6UVRxzaowWaZwdE6aNSjiHHPioAGpf7
         WLt9UILgshbCHLVORLkXn1/fyOHr7dUmzHvsXx3AiK+Du8dL8t/EJ3BgJjPa0EBBv1rQ
         J2nRH6DKRF4tWVWPIpPe2BZdz6A66SKJir2OqNTszZ4g6UiJdIOimT3AcUAXGM7nh5Nj
         Szrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3m4JP2toyOf5wM/Gm/lOr8X0+HToBEJENBBYIRuWj6A=;
        fh=y3jRlD79B4bIJMEsx+3F9E0m9tAPMksSfRyw1xcwlO0=;
        b=mjPo7Zlm/VMQt1QbpC9YQlu2hEtoT9EWGfoOV/MKEBlFQCU7+gMhiAYI6pueL4gAYy
         iQ/9rAzJyvI+BkK5vSnvR49tGQOOGIlORPbymnVhX9/cFoHdDfH3SXnTSulwjRKpl5cK
         l0NKCHh0czNR0BKL4YWmSFuNFEjPTHi+H0qFiJMrHO0YELQWuTLXABVMbBIQQpz9ykQw
         8MDcioX+zlAPDQkSk1A7gSEoLHviVnKiJ5VdAsHYXnavq89/3rmGRnYQBa8K1YRt+VFf
         ng9NgLRTcjYou9Bxiud7owPwq/qYJXVFwD4FLA9cIIQ7kJ+2D2Y9vQXBsTJvxniCgQAv
         WlDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795049892; x=1795654692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3m4JP2toyOf5wM/Gm/lOr8X0+HToBEJENBBYIRuWj6A=;
        b=KcsnJPEAq4go0fmvz1i2YFD7EdXnvLZs3Gb/1vywvS95lmVbCMBJeaNnm23XHvkM8G
         p5HHhaWJacOW2zrzmKqBnYU8DGh+chANp4g1piXPuqtzUQTRCLpjxBrwCOO9AdfHNlPy
         AVdfsWg5xNSTsrb70vA/s17IuWKHEFtq22/i8wuOf3l4J8tnKzKqKQ00vOtiQw+eA5QE
         Afz/VHekdtH+52CXU1o+yOx06JPDFogeofVi2cSfBCtA1kXMtRFijQJg6kLVYKsgBtqu
         y0m74xZIZ6Fl3pfprCgCr6ej8kDHpS89MZUnR/i9Jv7iNu3zfcHvXYlYT2/Z7kO9kSMt
         cbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049892; x=1795654692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3m4JP2toyOf5wM/Gm/lOr8X0+HToBEJENBBYIRuWj6A=;
        b=HmcTXrVR09Vic2U3LDoT8KpqrxKQllwahqg8l0FsSdQ7Vy19ysxM9fiw2NQ6PKIqZA
         AyY0+GqHgHJyyHFUESSQUD8sJR4DZiAfRhql81OEVTuVTwFqsKjCgQSb/jlGG3UTUrvX
         dsn4+/mXA97kym160B+UkSHBC/ZV7qhBB8nkPCQXjXeKrwjfQBordEW6S3DjNG1/7Cya
         k753Utsx8gvImjFmWCCh/Y2DxCXOwYnEM+HPlGRNEkNVOBWXrd6Emjl854h4Sx+JiGqZ
         4N4WfSSLgm+4m7xcJ0Sp3J+Lp2+rfn2FYp5tXUjx4+s3CGNj1C8lU8JUljRTmDiHmJ3R
         bEgQ==
X-Forwarded-Encrypted: i=1; AL+hErFRhdxHW/wfPEro7ydSAZhrXfVVMqdKS/eVK7WbnKDdm5mTOzssLnVmHGMHQKMvW3UG9PU+Wco=@vger.kernel.org
X-Gm-Message-State: APuU4Z912vyJgpAzgocAA7i2P3Qll+MmQ521CA47OSGeQ6cSS/LOTmhz
	0Ct+V5vCnXIngMkdyYgbChl94eBWo5u1uGDizU8ZwHCmToVIYrmx8yYJvrzxNzOP1OBOUJSwMbA
	hqXz8jc+jYbThT+gRASX7QelIhJlMLbw=
X-Gm-Gg: AZFdTZcBqoS7v9jV2EGiumPKiayglXZAuqn/5m3nvDHIMQGZNDQcjlxOZfRbFtly5wc
	QvCUmlX0DBoXq8l8235z/09DcHCAXU0DfSnBRmXs467X29Sopop2UNHcnm6/adrDbzOOsMyOJSf
	zGexzz82B/fnsFcEtVzOTQva84X8qpmOysbH54aM8NU7L7bUNhoZPWWZ1g4k4yAqN0GvPoYZTUC
	BidwTk6oqDszTTmNNvIb7Msvz+1lJtQI6mHCZPcnU2V6YBTbavH8QcNSvvmrqd54kJVdLNQd7nN
	1P6TeijnZuLiYX61dFjeaIMsVohyVLxwGewP1sDVNNlQiUP/btJpSgjI+Oy47sr0OcxTV3ccAvm
	IWy1CBMz1HbzpkZB6DnJsEaEC+lj1Y+zFj9utfxerp/NhpF0B0tidLNDM6X+qtWzS0r2OxxN+DA
	7MDa9MvB9f9j0VyktLnnvQ6nyr
X-Received: by 2002:a05:690c:6ac1:b0:8b4:fd7b:be17 with SMTP id
 00721157ae682-8b4fed36c83mr18132497b3.27.1795049892653; Wed, 18 Nov 2026
 16:58:12 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
 <20261118013725.90985-1-ozgunkultekin@gmail.com> <20261118013725.90985-2-ozgunkultekin@gmail.com>
 <906a3c99edd0b9216fecf4994c96a5fed9ca5253.camel@dubeyko.com>
In-Reply-To: <906a3c99edd0b9216fecf4994c96a5fed9ca5253.camel@dubeyko.com>
From: =?UTF-8?B?w5Z6Z8O8biBLw7xsdGVraW4=?= <ozgunkultekin@gmail.com>
Date: Wed, 18 Nov 2026 16:58:01 -0800
X-Gm-Features: Aa3M54rfcnLyrJUJ6VbyPAushlyD4haK0Inbg6Dr4Kkg8V4cKKwQVp2gUxaqK6c
Message-ID: <CAP2AQ-CwxT1HHDCS9ZmtD=8Wuq0DXmUK_uDu+WG3ZwpE1ufHkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hfsplus: pass the key buffer size to hfs_bnode_read_key()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, yangguikun19@qq.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Slava,

Yes, 2 * (max_key_len + 2) is the same as max_key_len * 2 + 4, so the
allocation size did not change. v3 writes it with named constants and
addresses all your other points too, including a separate patch that
replaces the 14 with HFS_BNODE_DESC_SIZE.

ozgun

On Wed, Nov 18, 2026 at 11:06=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.=
com> wrote:
>
> On Tue, 2026-11-17 at 17:37 -0800, ozgun kultekin wrote:
> > hfs_bnode_read_key() reads the key length of leaf records (and of all
> > records of variable-key and attributes trees) from disk and only
> > checks
> > it against sizeof(hfsplus_btree_key), 518 bytes. The destination is
> > always one of the two key buffers hfs_find_init() allocates, each
> > tree->max_key_len + 2 bytes long. For the extents tree max_key_len is
> > fixed at 10, so the whole allocation is 24 bytes and a crafted leaf
> > key
> > writes up to 516 bytes from the image into kmalloc-32. The error path
> > clears 518 bytes of the same buffer.
> >
> > hfs_brec_insert() reaches this with a key that was never validated:
> > when the tree root is 0 it reads the key of record 0 of the leaf it
> > inserts into, and after a split it reads the first key of the new
> > node.
> > A read-write mount that extends the catalog, or an append to a file
> > whose extents spill into the extents tree, is enough.
> >
> > Do not let hfs_bnode_read_key() assume the size of the buffer. Record
> > the size of each key buffer in struct hfs_find_data in
> > hfs_find_init(),
> > allocate the two buffers from it, and pass it to every
> > hfs_bnode_read_key() call. Keys longer than the buffer are rejected
> > as
> > before, and the error path clears only the buffer.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in
> > hfs_bnode_read_key")
> > Reported-by: Guikun Yang <yangguikun19@qq.com>
> > Closes:
> > https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F0=
8@qq.com/
> > Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
> > ---
> > v2: pass the key buffer size to hfs_bnode_read_key() and keep it in
> >     hfs_find_data, as suggested by Viacheslav
> > v1:
> > https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.=
com/
> >
> >  fs/hfsplus/bfind.c      | 6 ++++--
> >  fs/hfsplus/bnode.c      | 7 ++++---
> >  fs/hfsplus/brec.c       | 9 +++++----
> >  fs/hfsplus/hfsplus_fs.h | 5 ++++-
> >  4 files changed, 17 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> > index ca9813f58..5ec72fc98 100644
> > --- a/fs/hfsplus/bfind.c
> > +++ b/fs/hfsplus/bfind.c
> > @@ -19,11 +19,13 @@ int hfs_find_init(struct hfs_btree *tree, struct
> > hfs_find_data *fd)
> >       fd->tree =3D tree;
> >       fd->bnode =3D NULL;
> >       hfs_find_result_init(fd);
> > -     ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> > +     /* search_key and key, each holding one key of the largest
> > size */
> > +     fd->key_size =3D tree->max_key_len + 2;
>
> Do you mean + 4?
>
> > +     ptr =3D kzalloc(2 * fd->key_size, GFP_KERNEL);
>
> This is why I would like to exchange this tree->max_key_len * 2 + 4 on
> the statement that includes named constants instead of hardcoded 2 and
> 4. Please, rework it.
>
> >       if (!ptr)
> >               return -ENOMEM;
> >       fd->search_key =3D ptr;
> > -     fd->key =3D ptr + tree->max_key_len + 2;
> > +     fd->key =3D ptr + fd->key_size;
> >       hfs_dbg("cnid %d, caller %ps\n",
> >               tree->cnid, __builtin_return_address(0));
> >       mutex_lock_nested(&tree->tree_lock,
> > diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> > index 3a1a1fa6f..e2335c6d7 100644
> > --- a/fs/hfsplus/bnode.c
> > +++ b/fs/hfsplus/bnode.c
> > @@ -71,7 +71,8 @@ u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32
> > off)
> >       return data;
> >  }
> >
> > -void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
> > +void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
> > +                     u32 key_size)
> >  {
> >       struct hfs_btree *tree;
> >       u32 key_len;
> > @@ -84,8 +85,8 @@ void hfs_bnode_read_key(struct hfs_bnode *node,
> > void *key, u32 off)
> >       else
> >               key_len =3D tree->max_key_len + 2;
> >
> > -     if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
> > -             memset(key, 0, sizeof(hfsplus_btree_key));
> > +     if (key_len > key_size || key_len < 1) {
> > +             memset(key, 0, key_size);
> >               pr_err("hfsplus: Invalid key length: %u\n",
> > key_len);
> >               return;
> >       }
> > diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> > index f416e562d..779d7df0b 100644
> > --- a/fs/hfsplus/brec.c
> > +++ b/fs/hfsplus/brec.c
> > @@ -148,7 +148,8 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> > void *entry, u32 entry_len)
> >        * at the start of the node and it is not the new node
> >        */
> >       if (!rec && new_node !=3D node) {
> > -             hfs_bnode_read_key(node, fd->search_key, data_off +
> > size);
> > +             hfs_bnode_read_key(node, fd->search_key, data_off +
> > size,
> > +                                fd->key_size);
> >               hfs_brec_update_parent(fd);
> >       }
> >
> > @@ -166,7 +167,7 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> > void *entry, u32 entry_len)
> >               entry_len =3D sizeof(cnid);
> >
> >               /* get index key */
> > -             hfs_bnode_read_key(new_node, fd->search_key, 14);
> > +             hfs_bnode_read_key(new_node, fd->search_key, 14, fd-
> > >key_size);
>
> We need finally rework this 14 on named constant.
>
> >               __hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
> >
> >               hfs_bnode_put(new_node);
> > @@ -464,7 +465,7 @@ static int hfs_brec_update_parent(struct
> > hfs_find_data *fd)
> >               }
> >               fd->bnode =3D hfs_bnode_find(tree, new_node->parent);
> >               /* create index key and entry */
> > -             hfs_bnode_read_key(new_node, fd->search_key, 14);
> > +             hfs_bnode_read_key(new_node, fd->search_key, 14, fd-
> > >key_size);
>
> Ditto.
>
> >               cnid =3D cpu_to_be32(new_node->this);
> >
> >               __hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
> > @@ -476,7 +477,7 @@ static int hfs_brec_update_parent(struct
> > hfs_find_data *fd)
> >                       if (new_node =3D=3D node)
> >                               goto out;
> >                       /* restore search_key */
> > -                     hfs_bnode_read_key(node, fd->search_key,
> > 14);
> > +                     hfs_bnode_read_key(node, fd->search_key, 14,
> > fd->key_size);
>
> Ditto.
>
> >               }
> >               new_node =3D NULL;
> >       }
> > diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> > index 6f240f87f..d0d4fea94 100644
> > --- a/fs/hfsplus/hfsplus_fs.h
> > +++ b/fs/hfsplus/hfsplus_fs.h
> > @@ -268,6 +268,8 @@ struct hfs_find_data {
> >       int record;
> >       int keyoffset, keylength;
> >       int entryoffset, entrylength;
> > +     /* size of each of the search_key and key buffers */
>
> We need to have a comment before structure declaration. Ideally, it
> will be good to comment every field.
>
> > +     u32 key_size;
>
> This is not proper place for this declaration.
>
> struct hfs_find_data {
>         /* filled by caller */
>         hfsplus_btree_key *search_key;
>         hfsplus_btree_key *key;
>         /* filled by find */
>         struct hfs_btree *tree;
>         struct hfs_bnode *bnode;
>         /* filled by findrec */
>         int record;
>         int keyoffset, keylength;
>         int entryoffset, entrylength;
> };
>
> This is the field is prepared by caller. So, it should be group in the
> first section.
>
> From my point of view, keylength and key_size are not semantically
> different. Could we suggest some better word here?
>
> Thanks,
> Slava.
>
> >  };
> >
> >  struct hfsplus_readdir_data {
> > @@ -372,7 +374,8 @@ void hfs_bmap_free(struct hfs_bnode *node);
> >  void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32
> > len);
> >  u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
> >  u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
> > -void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off);
> > +void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
> > +                     u32 key_size);
> >  void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u32
> > len);
> >  void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data);
> >  void hfs_bnode_clear(struct hfs_bnode *node, u32 off, u32 len);
