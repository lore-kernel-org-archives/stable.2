Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794954243;
	b=GSTftrzoFj5a9xpYAj96Esj57xvQfV2LLtBUB2x438Yes+BTNF74FgDm13G4da+3hQKL
	 FzctjZVTHLYcVP/0cxpMeiTheWjP8MKO+DDUKJrdm9CwZOyxv3PI/DO98RBRnb2l3Q04C
	 eHjU4fPh19m06gHdNyljjxRuU8uCIrMzfph1eY0+UwvxeZTm8RtUe5b3iRfa+wcp1d+PV
	 b7+jmJ5EWhAoqBP0mLNf27Z/SUtbsSU+dkVAuCQ/VsOrJXK3IrsfG1j8c5Y0NjVd6ZsTK
	 3KNVXUTGA/P/skdtpSdNFWMVZ9JaGxkkLXqzLkYvl+hjqkWwof3WdjRUYc+OLlnUYfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=LwIqolplvFPQ8pLuOMIrUwJFLJoIjzlGmOqkccHeiSs=;
	b=iW2iS3t++oBS29d/CoxrbezR6IqolZxFeVCNesj9IthjcE0d/am+vwYBUPXbwf4ZGHf0
	 hr06QJHXqOdHG76icda/CcdhBYcF3ciREsvhanZxtCAboLANzSqPxbHFKY3cwxka6cqDC
	 EmqMkODRlPK4THKcjF5AWU7inha1J+V2XTqRaNzMBI1/sn1yAlAkPvdTXYJ9ulGtR3BNi
	 eOXRubiYo4Q6RKYt6YB2RE1E2rUNYhGGToiWMYy4Xc5xO4BFI5dXZelnPUYmyapbGJWKE
	 WazCeYpsArmSiMIGPhQ5dyi3c67KkxsBrzR7Jvr2GXWjumYRSH+Cv/XDkhwc5vBKILg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JAfkUKxM;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413ED606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 22:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 413ED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JAfkUKxM
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b4fb5d96b3so3288297b3.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794954242; x=1795559042; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LwIqolplvFPQ8pLuOMIrUwJFLJoIjzlGmOqkccHeiSs=;
        b=JAfkUKxMIsZ9O/19B1RDiMZsWMjGMjj2HySow2eJJaOuEHZmxAVo1pEZ9GdUwC3Mf8
         wJjvXZOqxcswIa+NPUx+Drmq0C+6JwlEac4+q+X5HvdQrQ0KDNDfD5ciOlpQx3XvCk7x
         o73JycHTsjJGGZXnpRM1EQFUxfWbNoVNFFa6wAq3BhZSodNnQIAmaCmEv9FHT6QaQ6zs
         sT5J4yuTf5m64vuv/SPu0MVDX0Fice4rl1umUYadAegsk+1xqJVMB17W9iIap0CTehHz
         yBUV9AztexpUsvx1Q+AehZ9iitI76Wm54z8kCG3zRxlpWE39ytqe5z6vzgynPA4eXyOW
         PJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794954242; x=1795559042;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LwIqolplvFPQ8pLuOMIrUwJFLJoIjzlGmOqkccHeiSs=;
        b=KMQYiJeevcfpbBBKwuN4h+dksqW+n8E52KD15z41p/WLH/o6R+w6DtiGWphCQAMpQS
         JdL7XlRD3PiovxKMCWMlApjPzeQAayHg9pKqeLTaxwPLQhpTphDjnMkNGi5agSDZmOlm
         su8ARqzddcLo1wAICZPLz0ZAOkW8kSQe0u97dTs5nNw/rqnByJXRv53rmcqK8wZ//jaT
         ZLF4nrs5Ds3LxU1PwHhJ0FYBsCGL7adfqXQL8gxU+4gJaPtPkUS+WFpkFePlCaoZ1xjG
         5xhUAGDBZAcp09OCNFxyUzRlPn7xf9CWNHFNdndrsW8bM92buZ8Fi7DHAAscLwcrvj9H
         SbYg==
X-Forwarded-Encrypted: i=1; AL+hErGIPkRcLCXV+Lptv0VQaMtZHpMbFuPc5A0a32opD5GJ9hSQkpjsmEUhUau7Bq6mXhs4iYWSOXA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gLx6od7ggorqOtxtLzMf/iVbZ6MHucVZIcHMU6hHmDvGY3m3M
	k5GlorSopC/m/WZcLqf+bHcgWW1DmbTu9AMPSWhnHIn8ePuwYHwRizv3HMUd32D8Z2o=
X-Gm-Gg: AZFdTZdQw90B/ISt7oUBybfwYyug6uDLebr9r68eKhtWR5DCkMhJ7EnpNBns4Hwpn3E
	tANJlg3ckRBjpQGqE//ZV8MaB7rUQsMhJN+CCZP/U5/yBYVqcAnoRoGPidz/+DfifI8excoao9a
	/LvaADBzgVYR5rafGJ0qvOVNGW+HpW4eChj/iP29DOR+xRKETaMSW6yzQbmuVu2H792sHiHjp6d
	Lt/p2bpt52OFGcow2xpOkc2F6EvHluThB5zCcN/E88IKCrx/npYIRFQrhpbZX+dVgT8MUp6qxXp
	rVKl9SZjeG3dGAcwaN/GCj+Ehd29Rf7ENcdLw6zdPE4jROmN44ve0s3/OLxsbAd/npjVxed8znb
	NVQCjV7yhhu2hzlQsBVqByAS4Sx6iJUVP+MHgmG0vPDiE2qi+LJY1QN9UXH67xN9OyI2nHMrvFO
	U3HV+BaOgoruwk1Fsc8sw0boROeM0uJEA1uq7aZl2swtduc9OAoetSkKfngSSrIY16dkWxinWmM
	x7gs7xSATzV94HwTVvu5wQm20m5MvCifqty8bw9zng6E+jEpch+Zc9QHMdHZGdNXNWi/bj+uJlP
	Y0Qwks8veplx3s9tWB8CLSD3Goim6jgoFX9loZkoK6VNsurSI3xUhjb9QSfaWZoIhImf3f+uxbl
	jcOValrUxzDm5C+iYAHk+25yjfmWYUHYSiQC3AiF6aHoIHspATZyhzqJe8KWT9ROel8JHldtGnA
	qBwAyZm47NIYINoT0uHaI=
X-Received: by 2002:a05:690c:6388:b0:8b1:46a1:28c7 with SMTP id 00721157ae682-8b4fed12108mr3549097b3.12.1794954242140;
        Tue, 17 Nov 2026 14:24:02 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:d1c7:8722:e551:bec4? ([2600:1700:6476:1430:d1c7:8722:e551:bec4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe10d935sm7635637b3.41.2026.11.17.14.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:24:01 -0800 (PST)
Message-ID: <8fd3897b906abf373264aa852c84ed0c72ff211e.camel@dubeyko.com>
Subject: Re: [PATCH 1/2] hfsplus: bound btree keys by the tree's max_key_len
 in hfs_bnode_read_key()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: =?ISO-8859-1?Q?=D6zg=FCn_K=FCltekin?= <ozgunkultekin@gmail.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, Guikun Yang <yangguikun19@qq.com>, 
	stable@vger.kernel.org
Date: Tue, 17 Nov 2026 14:24:00 -0800
In-Reply-To: <CAP2AQ-AnKOvRguMAdxi6KhTw_XYME+8EqdeSpnbxWVRHwcC-=A@mail.gmail.com>
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
	 <342f864c01c694acc0ec59b4d79f18e627a1ea24.camel@dubeyko.com>
	 <CAP2AQ-AnKOvRguMAdxi6KhTw_XYME+8EqdeSpnbxWVRHwcC-=A@mail.gmail.com>
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

On Mon, 2026-11-16 at 14:41 -0800, =C3=96zg=C3=BCn K=C3=BCltekin wrote:
> Hi Slava,
>=20
> Sorry, the commit message was too dense. Here is the issue step by
> step.
>=20
> hfs_find_init() allocates one buffer for the search key and the found
> key:
>=20
> =C2=A0ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> =C2=A0fd->search_key =3D ptr;
> =C2=A0fd->key =3D ptr + tree->max_key_len + 2;
>=20
> For the extents tree max_key_len is 10, so the allocation is 24 bytes
> and each key buffer is 12 bytes.
>=20
> hfs_bnode_read_key() takes the key length from disk (for leaf records
> of the extents tree) and only checks it against
> sizeof(hfsplus_btree_key), which is 518:
>=20
> =C2=A0if (key_len > sizeof(hfsplus_btree_key) || key_len < 1)
>=20
> So an extents leaf record with key length 514 passes the check, and
> hfs_bnode_read() copies 516 bytes into the 24-byte allocation. The
> check from bb5e07cb9277 protects the catalog tree, where the buffers
> are big enough, but not the extents tree.
>=20
> It is reached from hfs_brec_insert(), which calls
> hfs_bnode_read_key()
> on a key that was never validated (record 0 of the leaf when the tree
> has no root yet, or the first key of a new node after a split).
> Mounting the crafted image read-write is enough: hfsplus_fill_super()
> creates the private data directory, which extends the catalog file
> and
> inserts an extents record.
>=20
> KASAN on Fedora 7.3.3-300.fc45.x86_64+debug, mount only:
>=20
> BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x39/0x360
> [hfsplus]
> Write of size 516 at addr ff11000003a0e740 by task pool-1/1720
> Call Trace:
> =C2=A0__asan_memset+0x27/0x50
> =C2=A0hfsplus_bnode_read+0x39/0x360 [hfsplus]
> =C2=A0hfsplus_bnode_read_key+0x12b/0x230 [hfsplus]
> =C2=A0hfsplus_brec_insert+0x554/0xcc0 [hfsplus]
> =C2=A0__hfsplus_ext_write_extent+0x4fd/0x750 [hfsplus]
> =C2=A0hfsplus_ext_read_extent+0x7a7/0xaa0 [hfsplus]
> =C2=A0hfsplus_file_extend+0x862/0x12a0 [hfsplus]
> =C2=A0hfsplus_bmap_reserve+0x2e1/0x4c0 [hfsplus]
> =C2=A0hfsplus_fill_super+0x135a/0x1910 [hfsplus]
> Allocated by task 1720:
> =C2=A0__kmalloc_noprof+0x353/0x9d0
> =C2=A0hfsplus_find_init+0x18c/0x400 [hfsplus]
> =C2=A0hfsplus_fill_super+0x135a/0x1910 [hfsplus]
> The buggy address is located 0 bytes inside of allocated 24-byte
> region [ff11000003a0e740, ff11000003a0e758)
>=20
> The error path has the same problem: memset(key, 0,
> sizeof(hfsplus_btree_key)) clears 518 bytes of the same buffer.
>=20
> The fix checks key_len against tree->max_key_len + 2, the real size
> of
> each key buffer, and clears only that much on error. max_key_len is
> already validated per tree in hfs_btree_open(), so valid keys still
> pass, including the 518-byte catalog keys. With the patch the image
> is
> refused with "hfsplus: Invalid key length: 516" and there is no KASAN
> report. Normal HFS+ volumes still work (create, append into the
> extents tree, rename, delete, xattrs) and fsck.hfsplus reports them
> clean.
>=20
> Patch 2/2 is the same bug in classic hfs: there the extents key
> buffers are 18 bytes in total, and the check is against
> sizeof(hfs_btree_key).
>=20
> I can send the image generator, or a v2 with this text in the commit
> message if that helps.
>=20

I think my answer for another your patch is applicable here too.

Thanks,
Slava.
