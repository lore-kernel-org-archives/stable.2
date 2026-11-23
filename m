Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472288;
	b=RuMtOOjpWw0S/nTEQYboxUf4dHsH51UWFA3lGrblEgFUCaQhPHUKqakuYrcmlXiglwzn
	 0wA5KtuZgL3lP0tTeckC/KOskE7b2YUXSK14LXpLP6QDidcAUahDO4NN7xaooeo/40Zr8
	 InOHw+q525yLyqFQaMF0lhZ16fKvp807rd1P4ZGyq3+p4PDs7vAOSyPgtG79Ebdbxnh2A
	 ICpJPRS+I1iaIlXloTHAkkI3ZzEeGXxuKT5qIL6sgGIXAZHTA4tAEO1cHM5MvGgid/GaS
	 Yn+ycI7Jd/gcZaE6EoyKyqEjp6EpZThjygfAzfSFNOHvIqJQQh5jJYUAnyfIM8Cl6KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=+JzEw1NTjpwpKhUYsPVL4QgZ9Yqxc8qT5kiHgIxpGy4=;
	b=fgvIW/d7pqoD8ZMVxE1wJag7G8yprMi2mBGkcpSjWjXdwC/zMUHLaq1WJwZZA2eloc9F
	 D1q4w6yNHlZRUqbKr9dHPKZR/NKp7Hx96Yze5PD20NeKHLpif4U29PvZyQ3wtuZnwQBYF
	 YDAFhK5XroCG/Qweyvd2ZFGNzXkeRNJwylyfvapkuzDa0vZZDA12u9YZrcP1c5lgv/5nl
	 CRsaasZ+i+fTNUGKycBXQf5iwySP2NsadeBiaCRrfrU+9LGmbr7NYkYDsreU2XGCUVTCo
	 pHFba+M/WroqLKtltmfNMgadsmzLQ9pXOTe5FdKyPL/2BC0YwkjqYen388cdnDhbD4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bxyijer1;
	arc=none smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66A606A326
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 22:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D66A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bxyijer1
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67db1f6f50eso3940733d50.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795472287; x=1796077087; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+JzEw1NTjpwpKhUYsPVL4QgZ9Yqxc8qT5kiHgIxpGy4=;
        b=Bxyijer1uz8P/JT8UYnL/ameNM4PCr4UUHLmQD1yaTO26Vrn8HZkqvS7H740bbYd9B
         eZ1sVejr3Ge3bRLwHafdZ41JqaXVvZlWy+x3171KDkN5x9KiH9lSbUGc1W5H4t+M+Gsu
         TTeSaZ+VRjML9qBnyboSNpMpWo9jAp/D8deSXVkBadszV7Z35kv65L4hPGaqQxBK9bWF
         f9ztY6HpdvgHAPm7e0Aaj4p0ekmvxBHxChezsPM7Z7k0NH6LIMvizSkq4PV0+MB4bcNC
         I2OLCgxNjCEusw6JU8KLfe1r6Q2Zk16QISNfGEv6dE6OVRyK8boR3aCj9ROfM852uUDT
         beNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472287; x=1796077087;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+JzEw1NTjpwpKhUYsPVL4QgZ9Yqxc8qT5kiHgIxpGy4=;
        b=dQ7Vdawz7QfcwaVpuM7FemDgbIP3YvrTbGzKXWE+/ir0siGV160lvu9eNX+RsvtRQc
         USDAPuTHWRumW5nOEzb2iispNFqlwnhz2UVQ9Dhb9fYHOAEabAyxBxgbsG0Fj2VmvqeJ
         9dAcp7Igl9US2A9ooy4w4lRsoXfQfAW/sRZXeuObQm4sm58E7Wl3txvlplB50wmNTNRr
         yY8+2LJ7bcr+h3ldDs9OtSOPBXpSYjpIcLnAwMG7JJw5dfJaUqN2r3yYo619DiqPgEak
         RSeOfUoviKjn3PuArZjTj1ny7Y749rTtS25u47836n8YDl97MU+ZMavcrt0kty/Blj1Z
         K1+g==
X-Forwarded-Encrypted: i=1; AL+hErFk2b6pLPH2lzTxVLRkw3QI6e8bWDFS0cOqa+Mo8aC3WDMFp3kEArmvxOIiPPnZHq82WRCBuyY=@vger.kernel.org
X-Gm-Message-State: APuU4Z++9EUMjsUASJ32LT61g6Muw1HAdcjf8GXHPmVk/gpE8sHoyIHz
	yw7iCF9dRkldPjr5WrCm+lORMyc8x0PtjQMd26SAmpAcQQiRJhPx+tKvBV7X+MPCSmBWRNFIInY
	c7qBiY0Q=
X-Gm-Gg: AZFdTZdIsOJ71SrucKOmHxJSH1Kt2+BVAeUYiJccTMBc2anwNLW1GJEHpDjq+1J3bgy
	oribn+1+K+P2y751iGLq9A8oSSUlAIFg7bOcQJRjrnHp5pMUwTc3jFrxWYJNn/7XbFms//dfPYr
	lDToefllQLj03mBNPM0o41D4Z80++4v5bUM86wCx1s2R73HEwaMg2B31Wf3Z+O3WdyU1aw7Oz5X
	ohJ4AIkQMZU8HbGSJ4EBpvdiZbKalcqpV2q+5O9egrnxbBY3fccDKuBTGd1jMmHyI+JWI5W0wfb
	TwEdzeYXsRmITn4AOtdbzqDQczyl2s7Nl0OaKTR292V7xy8ETJvdeSnzz5wKY3N30hPhrhpA7I5
	WeTcjbstvNOeivni2VC+Lq/I86jveFh0S+vDJLNKWaUH1Ll7seaYSlD8jbNiY6I1sJkv+amE9d8
	uqLVL/B38kUsD7og0umQndBbuTL1S2q8vw/ZO8sKkEkNsGvme56x3L1av+DMMxsWss4Kaya7wSo
	Y0B84Xam5EOsw8oWH5Id3LCLLefXNonwKZEqLDr/GFo8QJEHyHkBRk9Ew9KzYUj4DuIdWPX+MyD
	ulA/P9TqiZPe6Ce3EhBJKwBMpoS02uE1XjWYyk6zrZpcyE8JevrBNCq66d4ddH9zaI1xGjzFa0K
	N0NpnodLoZ9RzNc3lvqsevgXCNHrC8o3X70wSrRdI+HSs3SBE5rsHPCH28DPUnseH4GCiA8g=
X-Received: by 2002:a05:690c:3386:b0:8b4:f757:6ff1 with SMTP id 00721157ae682-8b5204bc0c5mr50521777b3.40.1795472286875;
        Mon, 23 Nov 2026 14:18:06 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:83a2:1030:d4d1:10b8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52033c2d4sm50567147b3.36.2026.11.23.14.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:18:06 -0800 (PST)
Message-ID: <f9f16109d00dd0caef1bdda38b71ad63e44e78d5.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: avoid reusing occupied CNIDs after deletion
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 23 Nov 2026 14:18:05 -0800
In-Reply-To: <20261121101929.3395994-1-hengyul@cs.unc.edu>
References: <20261112110128.4082071-1-hengyul@cs.unc.edu>
	 <138ca05e57377469c0e44126314c98d008629229.camel@dubeyko.com>
	 <aad484f0a78493723cfe379df5916e9f7f2a2bb4.camel@dubeyko.com>
	 <20261121101929.3395994-1-hengyul@cs.unc.edu>
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

On Sat, 2026-11-21 at 05:19 -0500, Hengyu Liang wrote:
> Hi Slava,
>=20
> Thanks for the review. OK to all remarks about empty lines. The other
> points are below; there is one I would like to check with you before
> v3 (the flag).
>=20
> On Mon, 2026-11-16 at 17:02 -0800, Viacheslav Dubeyko wrote:
> > > +static u32 hfs_brec_cnid(struct hfs_bnode *node, u32 off)
> [...]
> > This function is completely not clear. You try to read the
> > hfs_cat_rec. Simply read it and analyze the record. Now it looks
> > like a
> > dark magic.
>=20
> OK.
>=20
> > Is this insert argument used anywhere?
>=20
> Yes, in the loop below: an added CNID can only raise the maximum, a
> removed one can only lower it.
>=20
> > > +	if (tree->cnid !=3D HFS_CAT_CNID || node->type !=3D
> > > HFS_NODE_LEAF)
> >=20
> > I would like to see some inline function with good name for this
> > check.
>=20
> OK.
>=20
> > > +	if (!cnid)
> >=20
> > The #0 is reserved CNID. It's not good choice for such check.
>=20
> OK.
>=20
> > I assume that we limited by tree's height here. Could we used it
> > instead of infinite loop?
>=20
> OK.
>=20
> > I dislike insert like a boolean value. Why do we need to inform
> > this
> > function about insert? Why this function cannot make this decision
> > alone?
>=20
> OK. In v3 it will run after the record is added or removed, recompute
> the leaf's maximum, and compare it with the old value, so it no
> longer
> needs to know whether a record was added or removed.
>=20
> > You don't need in done if you are limited by b-tree height.
>=20
> OK. The loop will still stop early when a node does not change,
> because
> then the nodes above it do not change either.
>=20
> On Tue, 2026-11-17 at 16:20 -0800, Viacheslav Dubeyko wrote:
> > > + * of an index node. If a child has no max_cnid yet, return the
> > > number of
> > > + * that child in @child instead.
> >=20
> > Do you mean that we return CNID? I don't quite follow. We always
> > have
> > any CNID in the node that will be maximum one for node. How is it
> > possible "If a child has no max_cnid yet, return the number of that
> > child in @child instead."?
>=20
> No, @child is a node number, not a CNID, and this only happens for
> index nodes. An index record holds a key and the child's node number,
> but no file or folder CNID, so an index node's max_cnid is the
> largest
> max_cnid among its children. If a child has no cached max_cnid yet
> (for example, it has just been read from disk), the function returns
> that
> child's node number; hfs_btree_max_cnid() computes the child first
> and
> then comes back to the parent. I will make the name and the comment
> clearer.
>=20
> > If it is the index node, then we don't need to traverse the items.
> > No?
>=20
> We do need to: each record in an index node points to a child node,
> so the loop goes over those records to find the largest max_cnid
> among
> the children.
>=20
> > It looks like internal error but not I/O error.
>=20
> OK, I will return -EFSCORRUPTED.
>=20
> > The max CNID cannot be lower that HFS_FIRSTUSER_CNID.
> [...]
> > I still don't see a necessity in HFS_BNODE_MAX_CNID flag.
>=20
> These two are related, so let me answer them together.
>=20
> max_cnid is not stored on disk, so a node that hfs_bnode_find() has
> just read has no max_cnid yet. For a leaf it could be computed right
> away, but
> an index node needs all nodes below it, so computing it at read time
> would read the whole catalog. That is why the code needs a "not
> computed yet" state.
>=20
> I can drop the flag and use max_cnid =3D=3D 0 to mean "not computed yet",
> by starting the computation of each maximum from HFS_FIRSTUSER_CNID -
> 1
> (15) instead of 0, so a computed value is never 0. It has to be 15,
> not
> HFS_FIRSTUSER_CNID: a node without user files or folders (only the
> root
> folder, CNID 2, or only thread records) then gets 15, and on a volume
> without user files the root gets 15, so next_id stays 16 (15 + 1).
> Starting from 16 would give 17 there. Would this work for you?

Yes, I think that "max_cnid =3D=3D 0" looks better. And we can introduce a
constant HFS_INVALID_CNID =3D=3D 0 (or something like this).

>=20
> > We need to have comments at one place for the whole structure. Here
> > it
> > looks not good at all.
>=20
> OK.
>=20
> > I still don't see the point why should we change anything here?
>=20
> Changing `<` to `!=3D` does not change the result:
> hfs_set_next_unused_CNID() updates next_id with cmpxchg only if
> next_id is still cnid + 1. The `!=3D` check only skips computing the
> maximum when cnid + 1 > next_id, where nothing would be updated
> anyway. I will drop this change.
>=20
> > The max_cnid or max_cnid + 1?
>=20
> max_cnid. hfs_set_next_unused_CNID() adds 1 itself (and uses
> HFS_FIRSTUSER_CNID for anything lower), as the old code expected.
>=20
>=20

OK. Let me take another look and double check it when you'll send the
v3 of the patch.

Thanks,
Slava.
