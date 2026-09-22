Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C7552FE21
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116754; cv=none; b=BOA2OZa340P5sHRORvgr7/qnC+Me8bPrqoAzDZHNYvY2aieVvZqSEnaP8GsX2d08DGD406C9v7nHGpAVRLXhbBjmhbnwrjldS3/L2Ov8SvoZFbchk9GwzIStMgBmBgeT8xs+krnguydklbGO1g4d8Sn92CadBNWZjnAyVCJRTpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116754; c=relaxed/simple;
	bh=FUIHg5v5Bu/yb7MK3/zub37OE0xQfapzSfUZ+ijVUjY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hpLZwo8Bw8c3Dgqsa0SRb91bcpKAyuAkcMh3YkFNeZcKlI3ktw+0XKK0ek12JUAkiXJRZIdwsWZkOSIIk7Mh60K+5Wk24iJIvanTjNzjjK2X0HeqzIn4LSbconamPDzscLBeceFK7pNe73ze9xMy1/CxnCmqiilkKVAcTDCY+ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=bgglo49/; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="bgglo49/"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d43ac8d1eso5166167b3.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790116741; x=1790721541; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3aYKfeLVLgoruW+NgdrNs0QadKbygBb+wWs5Xxz8GQE=;
        b=bgglo49/7Gn3LvtKk8XnWb3UPW9reQKPXcOxkTNp2Ck5xakJhB/IqDqvxJjiyLFVOJ
         KWX1cpebSUIwU8CIj9X85iIUEwBza0CSSmU37MoBD27bA3IxKipDZdDpz9Cx5v30lcNr
         Wh5X31FGZeYWuCnTDn/RQoToc56gldyndxDAjKAzA579Gb34bRXovwC1ekTFvwbhUoHw
         Gd3U9VutgOoUlPr9ZAuHhfdwAwDFkqvMI2+yhK7Vb0J6/tD9G4ud9pwZrZ6w6CUjQDPA
         TmeSPcbKQIoqnfHnZJaXvi+1Um+744HhHaOeIl4NyozvJ5HfgXvAqjmgtp5OIHxVQRUn
         +ykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790116741; x=1790721541;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3aYKfeLVLgoruW+NgdrNs0QadKbygBb+wWs5Xxz8GQE=;
        b=gQ4aBNUXsKWbUqQ0F/97ZGXI7ZshU0qyabCkyMWoxWFrdHuem+TRfot6dtOTjSBjQj
         3eVUsKbH4izct8TzftsIlljLPqvWhOUFhjFa9lGRBeKYKMVcyV36zBeP9xnX5yrAexNy
         jxVMRgEJN8KJ6aAnh0f/UDL9BbUNi4eXnCnQ5mD98zKHTh5G8yduxw8zQzWYBfHL9+k5
         khXOGU7khIjPbO+1RH+qjU0fUhkHg+M1JykzNWBQ5rbhrDvgX2QA+/O+5csSOoaolLXH
         DrfVkGaiSGIhbVb/UeDe7T5rSIbKtCZvG5BlZVcY8diOlvS/aeu0aZgsThlxIwKm+tsf
         DHDQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2pcFhgLkqW6Drwv8mKgoxucC2Lgf7GnzScBqcPzLf5sd4jCMh519DoGJnTiEJ3yITnDYR5AE=@vger.kernel.org
X-Gm-Message-State: AFuF++mf1ovSWRNUQvPmB9brYf83WT3l53qJI8jOAQYX9Sh1I+IM5XJH
	jhAyPqHBaghhfnngdApWQmsUJEMuffzxAuqEMpjpZbdwBAc93W0kz9T/xxRSfOpjsz9LyRYAyTM
	psARBR3z5tg==
X-Gm-Gg: AYBFou0eKl/eG3bTGQKXHQ53hhKVZ/VDF0H5w+fqGXiDvZz9tQXnUWwj5WxGBZM/lfl
	rGHmpBAPaoxHMYVZUD/Q2I7xoPrhg3OgmPy8w6lDsyh8tMfq1ewEqtQ2aC72qyI/mEoPVQYNLdi
	6TGEGNTPa5wXpJ8xxXivehk75SaWEOYsDnVENceU35M04Dv2FaCnEy1E0a0eipOObWzitfYH2lt
	v99fp9DzqZ/cHFzDC7z+4oVsVyDM/DGFgubO6dy6DaEmt/kliavvghKwDJ0VR3aioLas1GCXOcu
	nzwNyGAjDxEKFUu5Id4tV4z2Iyq4VWir5pVJMxL3ZepWaxr3xitIGifnuN1LfADI0q1QEj30XMT
	mPFmkGeKlZ4FNWXrm98XOxzinCPjBs2g4NxeoYvdJ+WeK///3ornCoWV5+byGufZ2YI4AJvFMcR
	lX9WVfA7AW2L2VYwLIPoTYiwEE/SWdavq88xel8KzN7MYdCwV7zmK4Q3YJ1V1OONodxxId9I9mQ
	9m4LFR36MSqJyijOWtJug6LsB0YSio5+Y49z/3DYkjksZu6vcxyNHOPWaieadRMcsTJTktDwcie
	3h2sWPek1o0m/QwNl+yJrzVL+j5sOK3dghLvnVA8tFHMYcUcVDyJYEZBqm49IxWm
X-Received: by 2002:a05:690c:e3cf:b0:897:7280:3dd3 with SMTP id 00721157ae682-8a458d259b0mr6608177b3.21.1790116740820;
        Tue, 22 Sep 2026 15:39:00 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:af0a:8535:f1b1:7cb0? ([2600:1700:6476:1430:af0a:8535:f1b1:7cb0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a4667cffc0sm3182727b3.43.2026.09.22.15.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:39:00 -0700 (PDT)
Message-ID: <b58a589247b2dffbc716979b6869a7bac64a1c5f.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs/hfsplus: serialize B-tree close against folio
 release
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Bruno Produit <bruno.produit@trailofbits.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: Kyle Zeng <kylebot@openai.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dominik Czarnota
 <dominik.czarnota@trailofbits.com>, 	stable@vger.kernel.org,
 syzbot+d729df28d933979e017a@syzkaller.appspotmail.com, 
	syzbot+2eac7d175baf21e6a5d5@syzkaller.appspotmail.com, 
	syzbot+7155b2fe09e033c91381@syzkaller.appspotmail.com, 
	syzbot+adeb387cede15eb11607@syzkaller.appspotmail.com, 
	syzbot+ae7f2423f3648100506d@syzkaller.appspotmail.com
Date: Tue, 22 Sep 2026 15:38:58 -0700
In-Reply-To: <d094915db6225a50936d6a59b7cfd7b6604ef30a.camel@dubeyko.com>
References: <20260921153729.600313-1-bruno.produit@trailofbits.com>
	 <d094915db6225a50936d6a59b7cfd7b6604ef30a.camel@dubeyko.com>
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

On Mon, 2026-09-21 at 12:51 -0700, Viacheslav Dubeyko wrote:
> On Mon, 2026-09-21 at 17:37 +0200, Bruno Produit wrote:
> > B-tree nodes with a zero reference count remain in the node hash
> > until
> > folio reclaim or tree teardown frees them.=C2=A0 The folio release
> > callbacks
> > remove nodes while holding hash_lock, but hfs_btree_close() walks
> > and
> > frees the same hash without that lock.=C2=A0 Reclaim can therefore
> > unhash
> > and
> > free a node after close has loaded its pointer, causing a use-
> > after-
> > free
> > or double-free.=20
> >=20
> > The following syzkaller crashes seem to be the same UAF in=20
> > {hfs,hfsplus}_btree_close() (or {hfs,hfsplus}_bnode_unhash()) and
> > follow=20
> > the same pattern, but do not contain a reproducer to confirm.=20
> >=20
> > Detach each node with hfs_bnode_unhash() while holding hash_lock
> > before
> > inspecting and freeing it.=C2=A0 Drop the lock before hfs_bnode_free()
> > so
> > a
> > large tree is not freed while holding a spinlock.=C2=A0 Apply the same
> > fix
> > to
> > the matching HFS+ implementation.
> >=20
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: syzbot+d729df28d933979e017a@syzkaller.appspotmail.com
> > Closes:
> > https://syzkaller.appspot.com/bug?extid=3Dd729df28d933979e017a
> > Reported-by: syzbot+2eac7d175baf21e6a5d5@syzkaller.appspotmail.com
> > Closes:
> > https://syzkaller.appspot.com/bug?extid=3D2eac7d175baf21e6a5d5
> > Reported-by: syzbot+7155b2fe09e033c91381@syzkaller.appspotmail.com
> > Closes:
> > https://syzkaller.appspot.com/bug?extid=3D7155b2fe09e033c91381
> > Reported-by: syzbot+adeb387cede15eb11607@syzkaller.appspotmail.com
> > Closes:
> > https://syzkaller.appspot.com/bug?extid=3Dadeb387cede15eb11607
> > Reported-by: syzbot+ae7f2423f3648100506d@syzkaller.appspotmail.com
> > Closes:
> > https://syzkaller.appspot.com/bug?extid=3Dae7f2423f3648100506d
>=20
> I still don't see Cc: stable@vger.kernel.org=C2=A0here.
>=20
> > Assisted-by: Codex:gpt-5.6-sol
> > Reported-by: Kyle Zeng <kylebot@openai.com>
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
> > ---
> > =C2=A0fs/hfs/btree.c=C2=A0=C2=A0=C2=A0=C2=A0 | 7 +++++--
> > =C2=A0fs/hfsplus/btree.c | 7 +++++--
> > =C2=A02 files changed, 10 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> > index 41b4e8fc9..4f0ddc76e 100644
> > --- a/fs/hfs/btree.c
> > +++ b/fs/hfs/btree.c
> > @@ -310,14 +310,17 @@ void hfs_btree_close(struct hfs_btree *tree)
> > =C2=A0		return;
> > =C2=A0
> > =C2=A0	for (i =3D 0; i < NODE_HASH_SIZE; i++) {
> > +		spin_lock(&tree->hash_lock);
> > =C2=A0		while ((node =3D tree->node_hash[i])) {
> > -			tree->node_hash[i] =3D node->next_hash;
> > +			hfs_bnode_unhash(node);
> > +			spin_unlock(&tree->hash_lock);
> > =C2=A0			if (atomic_read(&node->refcnt))
> > =C2=A0				pr_err("node %d:%d still has %d
> > user(s)!\n",
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->cnid, node-
> > >this,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_read(&node-
> > >refcnt));
> > =C2=A0			hfs_bnode_free(node);
> > -			tree->node_hash_cnt--;
> > +			spin_lock(&tree->hash_lock);
> > =C2=A0		}
> > +		spin_unlock(&tree->hash_lock);
> > =C2=A0	}
> > =C2=A0	iput(tree->inode);
> > diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> > index 2ea8cd565..bd4dbdbc8 100644
> > --- a/fs/hfsplus/btree.c
> > +++ b/fs/hfsplus/btree.c
> > @@ -417,15 +417,18 @@ void hfs_btree_close(struct hfs_btree *tree)
> > =C2=A0		return;
> > =C2=A0
> > =C2=A0	for (i =3D 0; i < NODE_HASH_SIZE; i++) {
> > +		spin_lock(&tree->hash_lock);
> > =C2=A0		while ((node =3D tree->node_hash[i])) {
> > -			tree->node_hash[i] =3D node->next_hash;
> > +			hfs_bnode_unhash(node);
> > +			spin_unlock(&tree->hash_lock);
> > =C2=A0			if (atomic_read(&node->refcnt))
> > =C2=A0				pr_crit("node %d:%d "
> > =C2=A0						"still has %d
> > user(s)!\n",
> > =C2=A0					node->tree->cnid, node-
> > > this,
> > =C2=A0					atomic_read(&node-
> > >refcnt));
> > =C2=A0			hfs_bnode_free(node);
> > -			tree->node_hash_cnt--;
> > +			spin_lock(&tree->hash_lock);
> > =C2=A0		}
> > +		spin_unlock(&tree->hash_lock);
> > =C2=A0	}
> > =C2=A0	iput(tree->inode);
>=20
> I haven't any comments for the fix. But let me run xfstests for the
> patch (at minimum for HFS+).
>=20
>=20

I don't see any xfstests degradation for the case of HFS+. The patch
looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Tested-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
