Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794868885;
	b=V6K8YQQVjAvFU3YSHo/fRb3BQSj3QOFBlP8Eas50rIr9+pdYAThwaiHDxIgPU+dWnAbb
	 OODk2MHp1bj9i5/KeZG37CiyTW7pQfUI6yZRscZ0R/bSzH+XQ+MlA3itaBTJiKeIDDyWs
	 GAFaaWHYGu4bCYXYkovrybRp6hxOZnS/FxNI25r7E8XssI+1ymOufOFt0bwcKMd+SiUtM
	 JmgATwRys+lH599BwaW+6VS2NxXZhgG1qQ9fG44shiF2JsZ7nwBx4n0ohpot2XzP5EBml
	 65V9xPeaw0egszcMvO3BWNJFt17zGEDnkSzcAoPErU21wBpWLexPLtu6lrD5FOzovFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gpp9LcCSgKl2cI7lJtnwvTOl6rqLL+9p0xxnoRcf0oE=;
	b=5lnIhVMr4SZ0fBDhp9BUsYY2ODtDZh3snFXn0me2GTmeL2PP9C0vULnij9pWHuVYyC8v
	 jsnnjl37/V5rqBWmtsAeycbt4K5a27v5/RermXM+znl2tWPFd46g1zG5r8jZx2BbTsK19
	 psHqPfPwwYt5uq71rtayAafQN0mrk7Qjq3Su08rxOLJkdtfWltyTyo3rHi6EAWvFO2L43
	 EECps9UvBEpoPW+HDO2w9LP+Y93118qw0wGHjwCf+oBfsJaGgsE+C+cRUERc1WCyhkydC
	 mVJjef61+olnWUkVCrEzQCimHpCTtlecoGTDSOCEmm+HWR/X3y0wVMVhx9eNMBXqqdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jc5k7Grm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F11606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5F11606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jc5k7Grm
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b4c2da74c0so12869947b3.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:41:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794868884; cv=none;
        d=google.com; s=arc-20260327;
        b=co5POSnCPM4bj3bNgKYVYPW5IESDwI5Rk/d+J9lizg2BTw+KjzcBN/mziyKMk3xJe4
         43hFEIlsEvLplXXY/K6BvBzGG0WhXouIqCWpldutG73cZQcFgbAjgd7D0TPMvw2V72dF
         JCpIsDy+cFLRLED7hzBJWOdWpAHzbantdSGn+YvZOwdp/N8XkMESqaqFEobCdhe/Hrrt
         Cp0XMQeDE9ffpiaNfLUvAsRhDN18kdAKiK9eZKeoFLNks6M9wviwxB9NldniVuykvsBw
         BX/UrHqFlfa7T4OSPUB+dzROx4/BV2vjYuG+4FXPqRV3y0bpiyl5cGJQjKkrKBihcciT
         IzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gpp9LcCSgKl2cI7lJtnwvTOl6rqLL+9p0xxnoRcf0oE=;
        fh=HissRdJ2BV80tagY2ZSvpwpJeyyUvZKTIf/wyEJ09sA=;
        b=D9Iqi1XShqbrnMbVxpodHCe0cZ1Ddn2rE3zQHSYZ7WBg0HXF1v8YO+JZJLI9sJdr2F
         NstZktkeFJO11I7MkgNv0qodarrLd9Q8Ue9lVE7KLrpii5cZ67W73uosigcOxq+oLBo+
         kLeW6VFx1iyjFvCD5Zc8QtsGe47/8EUzHtjIYxaiUX4uCP5kTo6s11IhGBn+pIKROvDG
         841A7xAiQA3LZQG/ube1w1VNjVtDFdBL3z2dAQranGHQBhJYqPO1gR28byy73k641tLy
         Va5e3JuXNmJBk6NQoV+1ssXLIcMbRf+ySUG/Eou8JCaETgnG4dhsb/G8QW68mLyNWmeT
         7Zlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794868884; x=1795473684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gpp9LcCSgKl2cI7lJtnwvTOl6rqLL+9p0xxnoRcf0oE=;
        b=Jc5k7GrmHEAmt0UUyFczLhxRSOuPWwl9lkXkjJO+coclp8jShxdCh0xiK40mf4cbI3
         Lm6UzEYuK+CdmbE/GoMPm5HecHiE3W2LnDpQz1Jg2pXwCDQ6shRhgnna/3QVI01ZrgMQ
         tdmUfTuugImvJHhXtOenDPHT7Dw0nkMM/7nsWp5HgtqJ3Weybze7/rW2HT1Ung5GdW/F
         49yT89/xGe7x2mKOQxwzcL/2WXKpr59fYtbAYYg34WdvMFr0D73/sX9IhaPA4CGEUSch
         ZExOKzyQGBB1/WNxnNWuCJGcF4H/+t/dEj8pLEuEInKLFiW1yGVrFLBrROLgP4UO6t1x
         hU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794868884; x=1795473684;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gpp9LcCSgKl2cI7lJtnwvTOl6rqLL+9p0xxnoRcf0oE=;
        b=Tu2aSWfOwKjEZwAQ7uPzOZ9IgPcwoO+eRvcUtmCUFCmWp6kf41zgoTkT3+5JX70WwB
         hRRjYTx6dpkUpnsO0H5EQKcvoHjYT+RiM5PIhACJbnKdtU4cMXzXJlbZH0SOvg3dgQ0F
         lTp3tOvD/QmpAXC7ZTWObfyYKPhUFgqvVFxqw2XdHorH0A6ngJ1CvyzqnVnwf/lZZSfx
         WPXtdHAP4SHENDg0GFzhGOJCFx08v7eE2NMUrP8EWOkPC38zXsMBofthxj4czYkmH9lp
         AwlwCalErdIpj/cVZkzcpKzjlfPXD1eJeEDf8ZrsiuKSNc6DOwEXtD+YIfJoebgzyafH
         lIKA==
X-Forwarded-Encrypted: i=1; AL+hErFrJbzUmKIVu3AyLZcqebvMQOwHYX50uUYgepEOZsz/x4ku7y3Lutzx52CY+LO2dEmdgL+BtEI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CFHylLeN5j4wSdxi58AdRe4YJy7QLGgka1NKyWg1LGwYtaJ8E
	gTT97GkAa2pNqkLo6FJscWPuQHouyBdwibsJzy0xb/VtmpASjSN0dqCp+ROlSUIIiB9T3imJWLI
	ugp2ZkwBGVOR8Mb61JeSuqnzJKnLLSoY=
X-Gm-Gg: AZFdTZfKHJVY6aAyuudG1ebN6M7nqquck5aoS4RLMFe7nnwsxqieEN+LRxV7SNdJp+6
	IxkbAeCUkG7o8LUWJmde41dUUnQUn/LVRt6aI24JInzxzUFtF3I1drHMWx8x+HyPBPygpfn6Jp6
	d4dULqO9tddVUgBFdIdmE7VUb1ZXUeVp5+uPXSNt/4bMUWhxGPe7nTFKfpUVaLoNdS/QnSbHkkB
	f0IURRaR0M/69TmUOwRVsd378C8j8iq9J/fak+XKD2Xq5AdtPPlaHVExv1T+0qpQyMaYyvEpyKp
	dpD2VKF4imCy4Rpcs6Cy8LScRuvYKpD6EbcP46liGWD5ccm6nqlAFNbsh6asHm/YFhamUQHkcgd
	N16Xj4vheckG38HQcbEI69S1dGZx1GeJBgnnC/D5vk23HQRQVSoa+z/NSAkvNixAFIMG6KqLHub
	6jkFIMtt3UAfiXqB5p8fFxIZ+1RjwkgrbcZYrZlu+Ky2EG
X-Received: by 2002:a05:690c:19:b0:8b3:7621:f691 with SMTP id
 00721157ae682-8b4aa39510dmr61981927b3.58.1794868883895; Mon, 16 Nov 2026
 14:41:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114043522.48764-1-ozgunkultekin@gmail.com> <342f864c01c694acc0ec59b4d79f18e627a1ea24.camel@dubeyko.com>
In-Reply-To: <342f864c01c694acc0ec59b4d79f18e627a1ea24.camel@dubeyko.com>
From: =?UTF-8?B?w5Z6Z8O8biBLw7xsdGVraW4=?= <ozgunkultekin@gmail.com>
Date: Mon, 16 Nov 2026 14:41:12 -0800
X-Gm-Features: Aa3M54pYTt9GjzCqNOUVY3T7b3LZBifqVTCc5WOUnoDmeg9LkLB7qIWfc1SBSbc
Message-ID: <CAP2AQ-AnKOvRguMAdxi6KhTw_XYME+8EqdeSpnbxWVRHwcC-=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] hfsplus: bound btree keys by the tree's max_key_len
 in hfs_bnode_read_key()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, Guikun Yang <yangguikun19@qq.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Slava,

Sorry, the commit message was too dense. Here is the issue step by step.

hfs_find_init() allocates one buffer for the search key and the found key:

 ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 fd->search_key =3D ptr;
 fd->key =3D ptr + tree->max_key_len + 2;

For the extents tree max_key_len is 10, so the allocation is 24 bytes
and each key buffer is 12 bytes.

hfs_bnode_read_key() takes the key length from disk (for leaf records
of the extents tree) and only checks it against
sizeof(hfsplus_btree_key), which is 518:

 if (key_len > sizeof(hfsplus_btree_key) || key_len < 1)

So an extents leaf record with key length 514 passes the check, and
hfs_bnode_read() copies 516 bytes into the 24-byte allocation. The
check from bb5e07cb9277 protects the catalog tree, where the buffers
are big enough, but not the extents tree.

It is reached from hfs_brec_insert(), which calls hfs_bnode_read_key()
on a key that was never validated (record 0 of the leaf when the tree
has no root yet, or the first key of a new node after a split).
Mounting the crafted image read-write is enough: hfsplus_fill_super()
creates the private data directory, which extends the catalog file and
inserts an extents record.

KASAN on Fedora 7.3.3-300.fc45.x86_64+debug, mount only:

BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x39/0x360 [hfsplus]
Write of size 516 at addr ff11000003a0e740 by task pool-1/1720
Call Trace:
 __asan_memset+0x27/0x50
 hfsplus_bnode_read+0x39/0x360 [hfsplus]
 hfsplus_bnode_read_key+0x12b/0x230 [hfsplus]
 hfsplus_brec_insert+0x554/0xcc0 [hfsplus]
 __hfsplus_ext_write_extent+0x4fd/0x750 [hfsplus]
 hfsplus_ext_read_extent+0x7a7/0xaa0 [hfsplus]
 hfsplus_file_extend+0x862/0x12a0 [hfsplus]
 hfsplus_bmap_reserve+0x2e1/0x4c0 [hfsplus]
 hfsplus_fill_super+0x135a/0x1910 [hfsplus]
Allocated by task 1720:
 __kmalloc_noprof+0x353/0x9d0
 hfsplus_find_init+0x18c/0x400 [hfsplus]
 hfsplus_fill_super+0x135a/0x1910 [hfsplus]
The buggy address is located 0 bytes inside of allocated 24-byte
region [ff11000003a0e740, ff11000003a0e758)

The error path has the same problem: memset(key, 0,
sizeof(hfsplus_btree_key)) clears 518 bytes of the same buffer.

The fix checks key_len against tree->max_key_len + 2, the real size of
each key buffer, and clears only that much on error. max_key_len is
already validated per tree in hfs_btree_open(), so valid keys still
pass, including the 518-byte catalog keys. With the patch the image is
refused with "hfsplus: Invalid key length: 516" and there is no KASAN
report. Normal HFS+ volumes still work (create, append into the
extents tree, rename, delete, xattrs) and fsck.hfsplus reports them
clean.

Patch 2/2 is the same bug in classic hfs: there the extents key
buffers are 18 bytes in total, and the check is against
sizeof(hfs_btree_key).

I can send the image generator, or a v2 with this text in the commit
message if that helps.

Thanks,
ozgun


On Mon, Nov 16, 2026 at 2:02=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> On Fri, 2026-11-13 at 20:35 -0800, ozgun kultekin wrote:
> > hfs_bnode_read_key() reads the key length of leaf records (and of all
> > records of variable-key and attributes trees) from disk and only
> > checks
> > it against sizeof(hfsplus_btree_key), 518 bytes. The destination is
> > always one of the two key buffers hfs_find_init() allocates, each
> > tree->max_key_len + 2 bytes long. For the extents tree max_key_len is
> > fixed at 10, so the whole allocation is 24 bytes and a crafted leaf
> > key
> > writes up to 516 attacker-controlled bytes into kmalloc-32. The error
> > path has the same problem: it clears 518 bytes of the 24-byte buffer.
> >
> > hfs_brec_insert() reaches this with an unvalidated key: when the tree
> > root is 0 it reads the key of record 0 of the leaf it inserts into,
> > and
> > after a split it reads the first key of the new node. A read-write
> > mount
> > that extends the catalog (creating the private data directory), or an
> > append to a file whose extents spill into the extents tree, is
> > enough;
> > no other file operation is needed.
> >
> > The 518-byte bound was added by commit bb5e07cb9277 ("hfs/hfsplus:
> > fix
> > slab-out-of-bounds in hfs_bnode_read_key"); it covers the catalog and
> > attributes buffers but not the extents buffer. Bound the key length
> > by
> > the tree's own maximum, which btree.c already validates per tree, and
> > only clear the bytes the buffer actually has.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in
> > hfs_bnode_read_key")
> > Reported-by: Guikun Yang <yangguikun19@qq.com>
> > Closes:
> > https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F0=
8@qq.com/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
> > ---
> > diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> > index 3a1a1fa..f414020 100644
> > --- a/fs/hfsplus/bnode.c
> > +++ b/fs/hfsplus/bnode.c
> > @@ -84,8 +84,13 @@ void hfs_bnode_read_key(struct hfs_bnode *node,
> > void *key, u32 off)
> >       else
> >               key_len =3D tree->max_key_len + 2;
> >
> > -     if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
> > -             memset(key, 0, sizeof(hfsplus_btree_key));
> > +     /*
> > +      * The key buffers come from hfs_find_init() and hold
> > +      * tree->max_key_len + 2 bytes each, which is far less than
> > +      * sizeof(hfsplus_btree_key) for the extents tree.
> > +      */
> > +     if (key_len > tree->max_key_len + 2 || key_len < 1) {
> > +             memset(key, 0, tree->max_key_len + 2);
> >               pr_err("hfsplus: Invalid key length: %u\n",
> > key_len);
> >               return;
> >       }
> > --
> > 2.47.0
>
> I don't quite follow to the fix. What issue are you trying to fix?
> Could you please explain it more clearly?
>
> Thanks,
> Slava.
