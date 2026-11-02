Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663948;
	b=GzmQYy/Q4RRsxP0Uaq6pM3wo14QUJqekeQwcAXK8M+E7vBASh5LopF+cvPy9lFjO3mP/
	 ODHoYH+V6Hp+kIGFRyqfkUXcenPEJS8leWel25fOdgqhfz66ubXJRuk8LQ+HsIUvhlmdn
	 S7i9LOb1WC7B4AyUaoA0YN5aY1jOLfMr82izc1YBBMLdm3ozs3DZnUhs3kwU0DgxmVYgz
	 QaZFKcfgSh5Shhy4iaXeHRJ7ny68xiCJiwEN0cRYF6KwAAIb/WvTuTwu5uB9cTiPA3Uo9
	 TSnhPp5m1fM4/1L0SNc9yJ3jiY1kuYkEg2r6hT2PdxaADzWrS5fl4Z9u0RJYvE1Vd4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=U8GhTlFkdp9GmP8nCC2cAmb44M/QEHf1sfzZYujU5tU=;
	b=ouyiroJPDZ7bHHL7N7aUTwhTSEi+ufCczGmjipETOtamEyPOMp9z30clpVv3G+tjpMRD
	 XQedF5MHjBR2aG7zSG0jPOz23jE6dAuU766UwJvKTs2hvd8ogTW6S8gAtChgSb0BN5REM
	 uOiOrzuUyYf1tgQQKb/M+DC4WGge3+n5U028S0pEwOJhBci/KawmDC8GrAeXnUlPq1eAX
	 bdATZhQXwu0doy3NxD5DLfg2nD8xMPQ66rPS2Ro0VFWNj2EJokR4tMuAJLzZo3rQxmYjb
	 Ga4O7854thgFXR0CcV+SrUd9mnoks4zWy03F9XdY6ePVsk+ZJxpI24tIqLDG0kwnMhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XXm2fPl8;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB142606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB142606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XXm2fPl8
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b0e21048f8so30294217b3.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 15:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1793663947; x=1794268747; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U8GhTlFkdp9GmP8nCC2cAmb44M/QEHf1sfzZYujU5tU=;
        b=XXm2fPl8B4NTDmc4DDSxB73yibbHFf24PJV/veEA4iXity28WiraqDbYM/4ZVQHSI1
         qSrWUMBia/OsDivZIBboc+w/eSxngg63QEEudftbQgTwejrMzfxaGHK4l6IhYuzVBCgK
         Tylx+J4VtvdMfK5cPukm8CCpiIcYwuHaudm9d4bAqqqV2YOFJ322Pv6+NkdUc2cVyeJW
         bGSCD6/yx0DNZqJ/wCucFhoVh1fFDBvJgz+2NUOX5KCAyRXST4kkVYVcnJLpgj2UXS0s
         ttsNNBuRuy2wiaAToL//RJRSv4fSL1y+iaZtsZsKHkfimlOXL5rggHnfLQFqOvhKktv1
         0adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793663947; x=1794268747;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U8GhTlFkdp9GmP8nCC2cAmb44M/QEHf1sfzZYujU5tU=;
        b=U8uwizgSEmBu37NV1YNI6zQm4+DkMkDO3mIN1eLLcIg5beoP7SBk0F71D8wnGv5BbD
         4z7DA7zUWk829d/sHxZGlzxmuE36tt9Q2BtBRYRLBMt6c+dnzWiLYcDd+snvpBdOIWc7
         Wyy+NSPrx+5qzvFsCd43qt+q9oLzB9xmifq9Cj5rIXHKJASen0oHUlgU7pBxjYpyegvV
         JzqruZ5B1RW4WuDFDIb6CSI/Ez42oBCvZESKk7BkazZl6h/lkNz667pFlcs/2+V/Kpmk
         oCuOpfwgpFfoD0fMccQNa7jdBinsyYFtlflSGGYmCF4H9qQ+3Nh2lhgdzrxSRAvIzM+T
         gdoQ==
X-Forwarded-Encrypted: i=1; AKwUvBywquMOolGOrL9cEuSdHwRRGjfyIdIVHJI0w+RUeiBdZ+Cy3djVWXXz+Y6Waa1VM+Y9GkfH2Cg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9OEnniMPrCGRbQtA0ELQ7o1UraiIWdKFeYVz8q3hMTL8yN5Cc
	CLhmqs9zU5zBSkIeNx10Dzj7Bd9fCNjkOA//sJzftp1UkiWnfSIRlB2vCYH59+/9CzU=
X-Gm-Gg: AYBFou39xhlC2Ylmuha4fgRUTltbomyLWgXL+YAOCmIXQYZu3ZhQ1wAfkJwZ7vP/HNi
	EItogeZfrzpk6nRULY1acvi1OXNgTzk1GMznr5t8xW9L946QFAcraIAX4F4v+5GtLMrNLDNIrR3
	6L3c/TOTiwOdVjHDeAjq21uaE+SD0bDBwcrNiArQheW/wrmN6+wUPxS2/Jaad8l6/GdPoj8QOvi
	A/cqSxwtlzdWdcp/s6nUUSmtFROwEqm6mN83AFZ51wgqrrJrfQFlC/k0aOWxQLEIxHDuvx30/zn
	DAJb9SMry7JkcSqDV28m4DesTX5/XqJyWCynNBTlTGQaaA5gCe2V+zBrZqGv2t5DimfJWS6Em9W
	isP0a/YoZ5OIVzh3277pP6fnDRusx5AnlnMvyRZBAK6zeHKKjQ65V6BGVFCwP0eh3uruO1hDxdY
	eZeysojwYIZ28J9mbhiNbVS/4naxIa99g+QWpPk7KSM1CCYk22BdMDy2JFKGgk5IUDQvzDWYiSX
	7JA9j9heQBFa+0t4VE9rPh76jMVC7iE2Gjp6xBkhJhihUh1fXRpouogyRaUEQxWOvcc10H/0QiO
	6tPMrS2G1OhOZHwmMgt1TfRRfX91KhPyOJauyOv8vGWkg/0R8uJiY625h4mUXSpxF179AnH6lZg
	DM4wYZ4MmJmGZE8MhXvp5+pKTokjAvEDaO9JYRe5oWOtg3XK/7OwYIaBsOCOcSVUfMDyxohni3y
	BG3ynpocloli99G06NhUlbYSqE5qU8MNe8mT2/Mg==
X-Received: by 2002:a05:690c:6d84:b0:8b0:b0d1:fc47 with SMTP id 00721157ae682-8b2b67fb2a4mr72460237b3.60.1793663946905;
        Mon, 02 Nov 2026 15:59:06 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:2f9f:a96f:bcb:6021? ([2600:1700:6476:1430:2f9f:a96f:bcb:6021])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b71b70fdsm60981457b3.43.2026.11.02.15.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:59:06 -0800 (PST)
Message-ID: <2c4ec08e9e0afaee01de0a7b3869b4de74172413.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 02 Nov 2026 15:59:04 -0800
In-Reply-To: <ac84b2b863415779536a98a0d0b835e85d2976c7.camel@dubeyko.com>
References: <20261015110114.1649059-1-hengyul@cs.unc.edu>
		 <b6f1cb66778d09015ad5862ff273edc37c44ef28.camel@dubeyko.com>
		 <20261021153141.311425-1-hengyul@cs.unc.edu>
		 <1797b66dee80c9553748d4a961470894c917bf5f.camel@dubeyko.com>
		 <20261022120658.1328124-1-hengyul@cs.unc.edu>
		 <cd6cc32dd2aae90b88b4c3d19e1fb35a5be6f4ac.camel@dubeyko.com>
		 <20261023173259.3275078-1-hengyul@cs.unc.edu>
		 <e2ee251e8ad47c6f1e2faf9ed1be787eccf5215c.camel@dubeyko.com>
		 <20261028035919.733823-1-hengyul@cs.unc.edu>
	 <ac84b2b863415779536a98a0d0b835e85d2976c7.camel@dubeyko.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-02 at 15:49 -0800, Viacheslav Dubeyko wrote:
> On Tue, 2026-10-27 at 23:59 -0400, Hengyu Liang wrote:
> > Hi Slava,
> >=20
> > On Mon, 2026-10-26 at 10:20 -0700, Viacheslav Dubeyko wrote:
> > > I am not suggesting to change the on-disk format. All
> > > modifications
> > > should be in-core metadata structures only.
> >=20
> > Sorry, I misread that.
> >=20
> > > The algorithm only solution will be inefficient and it can hide
> > > bugs,
> > > anyway.
> >=20
> > The table below is about efficiency. On bugs: in both variants
> > below,
> > a lookup or walk error leaves next_id unchanged, so it can only
> > stay
> > too high, never fall onto a CNID in use. Which bugs did you have in
> > mind?
> >=20
> > > I am thinking about adding to the struct hfs_bnode (b-tree node)
> > > a
> > > special field: u32 max_cnid. [...] What do you think? Does it
> > > make
> > > sense for you?
> >=20
> > Yes, it makes sense, and it works. I wrote a prototype (max_cnid
> > rebuilt when a node is read, raised on insert, rescanned on remove
> > and
> > after a split) and compared it with the unmount walk I suggested
> > last
> > time. Deleting 8000 files in KVM on v7.3 (KASAN):
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unpatched=C2=A0 max_cnid=C2=A0 u=
nmount walk
> > =C2=A0=C2=A0=C2=A0 newest first=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14 s=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 7.0 s=C2=A0=C2=A0=C2=A0=C2=A0 0.4 s
> > =C2=A0=C2=A0=C2=A0 odd ones, then even ones
> > =C2=A0=C2=A0=C2=A0 newest first=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.1 s=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 3.0 s=C2=A0=C2=A0=C2=A0=C2=A0 0.2 s
> >=20
> > Both are correct: no duplicate CNID in any run, including the
> > threadless case from my last mail.
> >=20
> > > If you believe that this approach will not work, please, explain
> > > your
> > > vision of solution in details.
> >=20
> > The unmount walk, on a delete:
> > (1) do nothing unless cnid =3D=3D next_id - 1 (your step (1));
> > (2) if cnid - 1 has a thread, set next_id =3D cnid;
> > (3) otherwise keep next_id, which is still above all CNIDs in use,
> > and
> > =C2=A0=C2=A0=C2=A0 set a flag.
> > At unmount, if the flag is set, hfs_mdb_close() walks the leaf
> > nodes
> > once and writes max + 1 to drNxtCNID. The walk cannot run in
> > sync_fs:
> > hfs_new_inode() takes a CNID before the catalog records are
> > inserted,
> > so a walk there could miss that CNID and lower next_id onto it.
> >=20
> > Your max_cnid
> > =C2=A0 Pros:
> > =C2=A0 - next_id was exact after every delete in every run, so drNxtCNI=
D
> > =C2=A0=C2=A0=C2=A0 on disk is right even after a crash or remount ro.
> > =C2=A0 - Nothing to do at unmount.
> > =C2=A0 Cons:
> > =C2=A0 - A delete of next_id - 1 still visits every leaf node (about
> > 3000
> > =C2=A0=C2=A0=C2=A0 here); the per-node max only saves parsing their rec=
ords.
> > =C2=A0=C2=A0=C2=A0 Checking the thread of cnid - 1 first brings the fir=
st row to
> > =C2=A0=C2=A0=C2=A0 0.4 s, but not the second.
>=20
>=20
> I think we need to reuse the b-tree mechanics here. Let's use the
> index
> nodes for the search of biggest CNID. The b-tree has this exact goal
> to
> speed-up the search. So, we need to keep the max CNID not only in
> leaf
> nodes but in index nodes too. Do you follow my point?

Maybe, we need to consider a Red-Black tree here?

Thanks,
Slava.

>=20
> > =C2=A0 - max_cnid must stay right on insert, remove, split and node rea=
d
> > =C2=A0=C2=A0=C2=A0 (hooks in bnode.c and brec.c). A missed update would=
 let
> > next_id
> > =C2=A0=C2=A0=C2=A0 fall onto a CNID in use.
>=20
> We should keep the max_cnid always valid. And b-tree operations can
> guarantee it for us.
>=20
> >=20
> > Unmount walk
> > =C2=A0 Pros:
> > =C2=A0 - A delete never walks the catalog; the one walk at unmount cost=
s
> > =C2=A0=C2=A0=C2=A0 17 ms here (cold cache).
> > =C2=A0 - Only catalog.c and mdb.c change, not the b-tree code.
>=20
> It's not about small change. It's about correct and efficient
> solution.
>=20
> > =C2=A0 Cons:
> > =C2=A0 - next_id is not lowered during a mount: after deleting all 8000
> > =C2=A0=C2=A0=C2=A0 files oldest first, the next file gets CNID 8016, no=
t 16.
> > =C2=A0 - After a crash or remount ro the high value stays on disk. In m=
y
> > =C2=A0=C2=A0=C2=A0 8000-file crash test drNxtCNID stayed at 8015 on the=
 empty
> > volume,
> > =C2=A0=C2=A0=C2=A0 more than 4096 above the largest CNID, and fsck.hfs =
-fn asked
> > for
> > =C2=A0=C2=A0=C2=A0 a minor MDB repair.
>=20
> We cannot leave file system in corrupted state. We should prevent it
> by
> any cost.
>=20
> >=20
> > Which do you prefer? I can turn either into the next version.
>=20
> I prefer to elaborate an approach that will be correct solution. I
> think we need to re-use the b-tree mechanics to improve the
> efficiency
> and to deliver the correct solution.
>=20
> Thanks,
> Slava.
