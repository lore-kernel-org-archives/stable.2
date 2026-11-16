Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794871274;
	b=C+tF3XV5uyRQYIpPTri5PxmWmMg5fcvYWo2W11FCMAvEJnm9Lw785CTp/977EbVfzgZb
	 nwCsfDxM/UJqTN3tGVtQq2JQrRQ12HXiBanvXIuXiqnP7nfcZmnPzedIgl8Q5wPNsnByW
	 3UZO1w20im3byREUJoVDqilYbf4gBBR+yMh3ql0G/ufaJu/NMFKWaZE8t+Nf8UBKelb1l
	 PnqkMqSnDxrljYHvIBg3TKIKj7PkJSPrU3v9O/wT2llw4P+o0QiDvrwjTqEw0rwDkedPd
	 L1QXNS1DKs8RwRkXMhXQyQmX3Rrd/1K2BkK1yWYHCz08piO9SkuYwGx85+JAPBom2Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794871274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=pwKOjke0ttq0aDvyUT4xTSYANM1tBHGR++OGa1KtOdQ=;
	b=uT69z9JS8+lAWoviuvmk8DWk2oTKrlLKKQ/qaKcWL+QiIaKS1crC8v0Fj5sVehrqCm+x
	 EQsDenq8hwTep8xSptjfd5ShwcKPSWiC1YAYzAdIR6Nrz4m1noX+v+xH6kAS648i0w1cX
	 aCN6pMNsz+8GMag/zW8tRgWmOsy6f8PMs6GXgGBExOrDQig2TD4X3ow2D7ZnUSxIUaaXA
	 +mhYJqd4fl78hoOVtw8xCrmJK8zpWjg+ADNIiCzdSqQAx2OL0vuLshZ99Uxx6YclL/p59
	 +XMbbuPrHhgfzgOuEiOslnlpzPJYb+9JrEUCXvEC9QFD5PEGAZ5ZH8Fj5duXJf9XMnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="V/46cNYB";
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A520F606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 23:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A520F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=V/46cNYB
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b30cbfa628so32628167b3.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 15:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794871273; x=1795476073; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pwKOjke0ttq0aDvyUT4xTSYANM1tBHGR++OGa1KtOdQ=;
        b=V/46cNYBjsn7NEmy5AUN9mzCDG/x3pX0OYeQB6clEBr2lVnO7wcu0UxaOQiwpli+yg
         YlWenpRfL2K4cNSHO5vChvoQnj4+YFwDv/nZoqcBMInDDB/zOOdj2n9VtwhSIppa5kdO
         mwc1ZE2k4OfJAFz8m9f1Tp0wvCxpC5z37wL8ianIZpflXQ6pQzSvt0/RSKebPBebR1cc
         dXoXcvMgHwGWm+cnszrwq2O7Mky2tMEyUFl1Up01bX/Oo1CyWTPXBP86/GX/4aPQctBa
         8FyIc/jpCkxK0uwZlzezlCS9cQPAqzan5jdNm6dSdnRGqvD9fC4dNjd0L4siajYbna0Y
         sLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794871273; x=1795476073;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pwKOjke0ttq0aDvyUT4xTSYANM1tBHGR++OGa1KtOdQ=;
        b=sG9KkeXioMvFcf6sZVgCxDPI0M40e/sJCZtGScTAnSIgesTWDNR4y96UntcPLItv8p
         ZTtWIeI/0clhYwDMJjZ+pLnrDHvS1Ntr4wtFt9kWb0Pby9+ekuDaI9U8oRxkGZMaNag2
         2txkYHxI5tmSt8e0/TEyW/EkniUUPjJU6MDIgI2TRwiAWmjejmtQKIoA7mHTGebHJ4wx
         xCuB/dfpCirrg33HbrKmKVakecUlFh1I4zKsrsNEoPynkBiE2iV3LC1gl1XCDMH4lW0/
         SktW9FSuRK86dBtzUIHthi8jE9CAH1rheYXxwZOmkpeS71QnlEH8yN/nnvVnCKadov2N
         m2QA==
X-Forwarded-Encrypted: i=1; AL+hErGkyn6vqsMWLU+807OmtlGEIM19ONqi4vyfYuvD45JFcEYBhCW7agfBYfUYI/bBigXg+YVlTXQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8t6BVcuyFsmg96K6eUoY7eKHIvZ6ikwpmp7DTGX8q6JZAaAGmM
	f+O/bHI3o9CbdcLcXmdFf6B3201wAqlUtLhZ/GuRHpk5Kx3qdW8PDWk9eTWbl5sXOHs=
X-Gm-Gg: AZFdTZelVqybzc7m4q8+RtcaESLgk5lSGM+yhVndGzvVFYv1UFjhpfILDvhmKCW+8Lg
	sPDjKTxOMpjk5c7vk7Ed/BpgM6OVH5maWehN+xBSIjdw5H+l20bf/JoceHZ7QnnOR7zVCbp5Tnu
	AE2HWyYTcgpgqiBMvqNjoVOgsNptgltL3ciaBhcesqZ4siGoIQpPujeXT02ccF9hD0YRqUdo5U7
	qB1WgYUlGcN9eZaczgnluaY+ow8HBFn/Jx4mMxq+5vbkAmU+sKQ/TjIG80ALJ3xv0qHRTNY2omY
	sRvI84yX8L/OaqzN1urpao+FkoyH7WO9QroBSRnm7ByvDwyDXqNTxtgCkX1JvISlovm99qptuQe
	h94/BNbw9wwtuIvTCEYjriXoE4lmCmCdjH07Rq0Up9+m3Ps9fhJQNwa8h1KfWyIiMieGq2E3UN2
	k1Ko+dlJYrfaZ3ZFP+oKUc8MNZMaa+gB45FDP2QejYg25vfbv47PAQ78vE0ndH6kgfNvqQbvOOH
	CDMQqh3VQFbdwVerp8pm5mCRxQ7/+f0j96JAtBSVjJJnJJkTlBLIAPsAOzNuxXxu1vhNe1uHKlV
	OVSXBJ3nYXJnbAUb4hWF0NoPgkdYvK685h+m212u8MTN0B+twogr1KIUxJ6xNuXbTQDlGROYmKZ
	GUx53ROhwzeVM4xZkyr9SgBAxoELmsR+O6cyFFa2H0DwCuiaW7jodMrfZaRFxnyMzH4pXYncccP
	t+IugRYFl174/ebPlcmwCG1NBXU9BUZVd+rG21tuKX
X-Received: by 2002:a05:690c:6b12:b0:8b4:ef5f:7832 with SMTP id 00721157ae682-8b4ef5f802fmr3309157b3.65.1794871272475;
        Mon, 16 Nov 2026 15:21:12 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:48ee:a3ac:5a4b:3831? ([2600:1700:6476:1430:48ee:a3ac:5a4b:3831])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ec3079fbsm10948967b3.41.2026.11.16.15.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:21:11 -0800 (PST)
Message-ID: <f59ea6b2a8c60594361ab596d92bdf98a217dd83.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: avoid reusing occupied CNIDs after deletion
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 15:21:10 -0800
In-Reply-To: <20261113194103.3825961-1-hengyul@cs.unc.edu>
References: <20261112110128.4082071-1-hengyul@cs.unc.edu>
	 <2bbc10eb1dd5ee69329a9307f14fd15b1815b898.camel@dubeyko.com>
	 <20261113194103.3825961-1-hengyul@cs.unc.edu>
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

On Fri, 2026-11-13 at 14:41 -0500, Hengyu Liang wrote:
> Hi Slava,
>=20
> On Thu, 2026-11-12 at 14:34 -0800, Viacheslav Dubeyko wrote:
> > I am still not sure that this approach could work. If we haven't
> > the
> > thread records in the b-tree, then we sort records by parent CNID.
> > But
> > folder can contain child with any CNID. So, if we keep the largest
> > CNID
> > in use, then, technically speaking largest CNID - 1 can be located
> > at
> > any node (it doesn't matter if it is used or not). Even if we found
> > node #1 with largest CNID, then it doesn't mean that largest CNID -
> > 1
> > is located at the same node #1. And even if we cannot find the
> > largest
> > CNID - 1 value, then it doesn't mean that this value hasn't been
> > allocated already as child CNID of some parent CNID (because
> > records
> > are ordered by parent CNID). Are you sure that this approach will
> > finally work?
>=20
> Yes. The patch never searches for a CNID, neither the largest one nor
> largest - 1. It only needs the maximum of the CNIDs of all file and
> directory records, and a maximum does not depend on the order of the
> records:
>=20
> - max_cnid of a leaf node is the largest DirID / FlNum of its file
> and
> =C2=A0 directory records. The CNID is read from the record data, not from
> =C2=A0 the key, so the parent ID and the thread records do not matter.
> - max_cnid of an index node is the largest max_cnid of its children.
>=20
> So the root holds the largest CNID in use, wherever the records are.
> When the record with the largest CNID is removed, only the nodes on
> the
> path from its leaf to the root are computed again; every other node
> keeps its value. For example:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 root: 20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
/=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0 leaf A: 19=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf B:=
 20
> =C2=A0=C2=A0=C2=A0=C2=A0 (16, 19, 17)=C2=A0=C2=A0=C2=A0 (20, 18)
>=20
> =C2=A0 rm 20: leaf B -> 18, root =3D max(19, 18) =3D 19, next_id =3D 20
> =C2=A0 rm 19: leaf A -> 17, root =3D max(17, 18) =3D 18, next_id =3D 19

You explained a simple case. :) My worry was about the case when we
could delete some number of items between [16, 20]. For example, we
delete 17, 18, and 19 at first. And now we delete item with #20. So,
leaf A should have 16 as a maximum CNID. And we can use 17 as a
next_id. Correct?

Let me double check it and I need to take another look to the patch.

Thanks,
Slava.

>=20
> Both times largest - 1 was in the other leaf, and it was counted
> because
> that leaf keeps its own maximum.
>=20
> next_id is then set to max + 1. Every CNID in use is <=3D max, so max +
> 1
> is free. Deleted CNIDs below max are never reused, so we never need
> to
> know which CNIDs are free. A red-black tree of deleted CNIDs would
> only
> be needed to reuse those holes.
>=20
> To check it, a debug build compared every cached max_cnid with the
> value computed from the records after each catalog insert and remove:
> about 88,000 full-tree checks on 2,000 files with random operations
> and
> 4 writers, plus a run under memory pressure that freed 55,630 nodes
> and
> read them again. There was no mismatch.
>=20
> > Why do we need this flag? If node is created, then it should have
> > valid
> > max_cnid.
>=20
> max_cnid is not on disk, so a node that hfs_bnode_find() has just
> read
> does not have it. For a leaf node it could be computed from that node
> alone, but for an index node it needs every node below it. Computing
> it
> at read time would read the whole catalog at mount, and again for an
> index node that hfs_release_folio() freed and that is read again
> later.
>=20
> The flag means "max_cnid of this node has been computed".
> hfs_btree_max_cnid() computes only the nodes without it, and only
> when
> the newest file or directory is deleted. The first such delete after
> mount still reads the whole catalog once; later ones only recompute
> the
> nodes on the path of the removed record. The flag is also cleared
> when
> the largest CNID of a node is removed, and on a split, because
> records
> move to the new node.
>=20
> Thanks,
> Hengyu
