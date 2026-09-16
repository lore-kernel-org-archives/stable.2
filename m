Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A116550DA0
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583643; cv=none; b=jYUM5dKOpM/zk1D1UEfLiDGt3hkW2yeWypwNxFnI/gVv/41JR104+HetzeNvU+K+mSk264o+ODItsnOfHdHmJMljW834WdCCYw1pLKtJ0Z3Y7ZkGMbHX5ItNQPvbC9vl291SMCkXGCexUGjy719+b3GGeN3tsZZElgnmPM/nT0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583643; c=relaxed/simple;
	bh=kCZFspvHZ9tRLjdxKXZWCpHLq8aaBrTCKUoD7EZAf1g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S2OTWRDng1F8gWvM/TI9m7R201sbKSLabh+vTLw/cX2itwEEW1TGiUuwsEwjMHjebxDqx/hrFHmFoT7izuoCSfhMNjmbL9VqyGKUpkCRpktycub0gemCsb1bMyb79+S0XxqiDU2Qs+Jg6ewx7BFKB4mOcH3XXfbXadQZrtPAG9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=t+kBPlb+; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="t+kBPlb+"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d4ddd1d91so10073947b3.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789583622; x=1790188422; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kCZFspvHZ9tRLjdxKXZWCpHLq8aaBrTCKUoD7EZAf1g=;
        b=t+kBPlb+sYWlxw6U7veBMpcQR4IDn3qj36nXmr8vnA9Lu21/LKbuUGgRrx42xwXa3I
         wqeXKSqlEfVNL90+F5oUFExWmM9riBtmBaM05AW9N01UyZ4V4jLkjP1w8ZfBY4XO7Avs
         EAHI5EULZ1RIA+t/lJ1+gW69EG1t81nFxOMx/RmudFX92T+mk5DVaQuEg160e1eBg9Mn
         ryR9Xk1iD1ArhhEE5trEwmXtrrRCxsGDgEk6Qy5TBP79AuiwL3S/jsEoZI/Ddvh0+eDd
         DrJp7dz0rP35cnHJRfz923LtYERY80AyI9Rjl8CQ75eZbKAssZfHzVN+wx4ILd7JjEJX
         ZmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789583622; x=1790188422;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kCZFspvHZ9tRLjdxKXZWCpHLq8aaBrTCKUoD7EZAf1g=;
        b=CmyN2/jT2M9u4oqmvovbjrKp9YItPu/8k6HD5qjFsCOenv82Sg/RoksSDMm8e15dBo
         Yffkp6PJ3m0ZlMFkVEhxElyJtYYo1C71ZXLb3Nn+3B0EImCeX8zKudyYtLkVCOk4ASQM
         p4eYCdJY1xkjm65AI+vSd0Hd3p0YuydqA+/sltYDyosMgvtaaZ96FPNc/RXtZE9+I+fm
         K+0vxe9+d5btwhiogYCFliZsTMUz7k5moSxCYmFlaHhrH/uJC5yk0y68m7WydomlmcY7
         B+7Rex/n+xBCTC2+hC/nwOtDIC3boicHFUdstuOCXk/FzP36RmVApqIpOovqSctGkvOB
         pd8A==
X-Forwarded-Encrypted: i=1; AKwUvBzR8w8JuDJzk8Vy+ht+1e4N9z6I4LoC77YugYiP11QDQ4/wNAo2rp4ecc8qJ9T77WoEHgHGo7o=@vger.kernel.org
X-Gm-Message-State: AFuF++kQ1ur0s/9vW8B3e/FCsE5NAJW0k6iSz1+UR1I1ltrg1QSt7nQ7
	5a2cC73/81mul1YHHxapeyvBjw8QnngX9o8IWtjIQMRbTDgps21TJc2Pi9c03LSr8+E=
X-Gm-Gg: AYBFou0WFU2nP4exozKbSpwOvLmDi2rV4t1VUZFnNsMM5z6x+FtouSsRIRBRcHTmKCl
	Yj+2tL2D2v7zLXfkdoQY1kDw+8PycrBE8DGWyPiFOgS5c4PFD1rN0H0TaFtVVwBQWK0gDjNA5Tk
	mJASXlizRkPoCNjJZKRBhpWA9aLvjKOmX96kH5TVSC36ytoM+WsNRyARnkNIwbrnNypnCi4Tz3N
	JHSygSLvQuDij7jtJ+wxQRh9mfQvd2cnTHyN/OjN/7FbKAJlyFm+295kIHtsM+j1RpxPeS3Dhng
	AEK1ESX4gg1b6+cSB2/QqoPLHtuOHajzZC2VCsUYAYFefU3BTGW7yBOsjk2j8MPG+MgkUM6zcjP
	H8qY7xEXn+1BB9rJYVfX/BRsn29vZIVv7Njevqk5VMXpzObyCftpu0FQM1k99kSCqUjZITgmgYg
	JitakLqzT1ODO6ncPO8keHeQVTMC3Teliht5EqOd9YaeHFyqJe7kHelrgVV0JRuTWbX+IsphJ9o
	nI+nvBDO9QvB2+EGl1X4C7RMlxntsGwC+13+5fxeAE9cRDMgokKOKagodvEYwCIGqq6J1TEal3W
	vyAFOEBAMdhc6zi3ASUWPY/ROGYwqynIpVQjz1KB3O+syrwB+pKlxCOxQIgzEjW6
X-Received: by 2002:a05:690e:1918:b0:671:3e63:2e91 with SMTP id 956f58d0204a3-671632d88a4mr1650293d50.36.1789583622221;
        Wed, 16 Sep 2026 11:33:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:f547:a2c0:72f7:6671? ([2600:1700:6476:1430:f547:a2c0:72f7:6671])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6715f6df1a6sm1653225d50.8.2026.09.16.11.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 11:33:41 -0700 (PDT)
Message-ID: <fb6a6e2ff419fc197c793d9a98fccd2d1332e49d.camel@dubeyko.com>
Subject: Re: [PATCH 1/1] hfs: don't let internal B-tree inodes leak into the
 VFS open path
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: 1sh1ro <yangguikun19@qq.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Mateusz
 Guzik	 <mjguzik@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	stable@vger.kernel.org
Date: Wed, 16 Sep 2026 11:33:38 -0700
In-Reply-To: <tencent_6BAAD177CBC8B253A2297594808F7D546606@qq.com>
References: <20260916080000.0-hfs-fix@localhost>
	 <tencent_6BAAD177CBC8B253A2297594808F7D546606@qq.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-16 at 17:09 +0800, 1sh1ro wrote:
> hfs_btree_open() creates the extents and catalog B-tree inodes with
> iget_locked() and never assigns them a file type, so both stay cached
> with i_mode =3D=3D 0 after mount.
>=20
> A crafted HFS image whose catalog contains a record whose DirID/FlNum
> aliases HFS_EXT_CNID (3) or HFS_CAT_CNID (4) makes hfs_lookup() ->
> hfs_iget() -> iget5_locked() return that already-cached internal
> inode
> (hfs_test_inode() only compares i_ino), without running
> hfs_read_inode().=C2=A0 The typeless inode then reaches the generic open
> path and, with CONFIG_DEBUG_VFS=3Dy, deterministically panics:
>=20
> =C2=A0 VFS_BUG_ON_INODE(!IS_ANON_FILE(inode)): inode:... fs:hfs mode:0
> opflags:0xc flags:0x0 state:0x0 count:2
> =C2=A0 ------------[ cut here ]------------
> =C2=A0 kernel BUG at fs/namei.c:4271!
> =C2=A0 RIP: 0010:may_open+0x2ba/0x480 fs/namei.c:4271
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 do_open fs/namei.c:4698 [inline]
> =C2=A0=C2=A0 path_openat+0x1600/0x3de0 fs/namei.c:4863
> =C2=A0=C2=A0 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1385
>=20
> Fix it in two steps:
>=20
> =C2=A0- give the B-tree inodes an S_IFREG type in hfs_btree_open(), so th=
e
> =C2=A0=C2=A0 "every cached inode has a valid S_IFMT type" VFS invariant h=
olds
> =C2=A0=C2=A0 regardless of what is on disk;
>=20
> =C2=A0- refuse, in hfs_iget(), catalog records that address the reserved
> =C2=A0=C2=A0 B-tree CNIDs so a malformed image cannot alias internal obje=
cts
> =C2=A0=C2=A0 into dentries at all.=C2=A0 Returning NULL follows the exist=
ing
> =C2=A0=C2=A0 convention for unaddressable records: hfs_fill_super() turns=
 it
> =C2=A0=C2=A0 into a mount failure and hfs_lookup() into -EACCES.
>=20
> Without CONFIG_DEBUG_VFS the assertion compiles away and the same
> crafted image silently makes a typeless inode openable, so this is
> not
> merely a debug-config nuisance.
>=20
> Found by syzkaller-style fuzzing of v7.2-rc7; still reproducible on
> current mainline.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: 1sh1ro <yangguikun19@qq.com>
> ---
> =C2=A0fs/hfs/btree.c | 8 ++++++++
> =C2=A0fs/hfs/inode.c | 11 +++++++++++
> =C2=A02 files changed, 19 insertions(+)
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 2eb37a2f64e8..bd69ace8f309 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -43,6 +43,14 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
> =C2=A0=C2=A0=C2=A0 if (!tree->inode)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_tree;
> =C2=A0=C2=A0=C2=A0 BUG_ON(!(inode_state_read_once(tree->inode) & I_NEW));
> +
> +=C2=A0=C2=A0 /* B-tree inodes are internal objects that must never be ex=
posed
> +=C2=A0=C2=A0=C2=A0 * through directory entries.=C2=A0 Give them a REG ty=
pe so the VFS
> +=C2=A0=C2=A0=C2=A0 * invariant "every cached inode has a valid S_IFMT ty=
pe" holds
> even
> +=C2=A0=C2=A0=C2=A0 * when a corrupted image contains catalog records ali=
asing these
> +=C2=A0=C2=A0=C2=A0 * reserved CNIDs.
> +=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0 tree->inode->i_mode =3D S_IFREG;

In HFS+ we call hfsplus_iget() in hfs_btree_open() [1] and it assign
the S_IFREG in hfsplus_system_read_inode() [2]. But in HFS we call
iget_locked() instead. I think we need to call hfs_iget() there and to
have something like hfs_system_read_inode() that will assign S_IFREG to
the i_mode. But current fix doesn't look like right solution now. Could
you please explore this direction for the fix?

Thanks,
Slava.

> =C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0 struct hfs_mdb *mdb =3D HFS_SB(sb)->mdb;
> =C2=A0=C2=A0=C2=A0 HFS_I(tree->inode)->flags =3D 0;
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index ac4a9055c5c0..bb759345f1fc 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -432,6 +432,17 @@ struct inode *hfs_iget(struct super_block *sb,
> struct hfs_cat_key *key, hfs_cat_
> =C2=A0=C2=A0=C2=A0 default:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> =C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0 /* Refuse catalog records that address the internal B-tree
> objects:
> +=C2=A0=C2=A0=C2=A0 * a crafted image can otherwise make hfs_lookup() ret=
urn the
> cached
> +=C2=A0=C2=A0=C2=A0 * typeless B-tree inode, which then reaches may_open(=
) with
> +=C2=A0=C2=A0=C2=A0 * i_mode =3D=3D 0 and trips VFS_BUG_ON_INODE() there.=
=C2=A0 NULL follows
> the
> +=C2=A0=C2=A0=C2=A0 * existing convention for unaddressable records (moun=
t failure /
> +=C2=A0=C2=A0=C2=A0 * -EACCES).
> +=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0 if (cnid =3D=3D HFS_EXT_CNID || cnid =3D=3D HFS_CAT_CNID)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> +
> =C2=A0=C2=A0=C2=A0 inode =3D iget5_locked(sb, cnid, hfs_test_inode, hfs_r=
ead_inode,
> &data);
> =C2=A0=C2=A0=C2=A0 if (inode && (inode_state_read_once(inode) & I_NEW))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_new_inode(inode);
> --
> 2.39.5

[1]
https://elixir.bootlin.com/linux/v7.3-rc3/source/fs/hfsplus/btree.c#L286
[2]
https://elixir.bootlin.com/linux/v7.3-rc3/source/fs/hfsplus/super.c#L60

