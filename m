Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597256;
	b=37DR+PB5hNgYZrNd3p4p13mVXL+7C0anjJ9nNZcLvLW6EL5izHujmNLmzahPRYp0AzIu
	 KdFuMddYv7fUJzwggc318PEuyq3vRa71mT1HC7ZUYFbNyUUfdZOIN1mT/cZLZiwbO6aSB
	 bPFtXABDUkhVwIrcDT71DdHTcqqAib5UfofHWW6YACYWIx1Z2eXk/S5udFjGEEYQqcSmi
	 VjnsuvFPjXnFLI4sE/exITkqRqS3Mef+iZk0rpihG02Wtf0E30RDIPfCFd6iA+wRxgrBh
	 hkBDtd8z02IVAGdp5x89YUL+EAbSP+ikNe7TXXOLYrsTWFiZpucPwPxiKMSXQRx7uyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=naomhjRVZ+IJsznibpYW1bEFswFz05AA59NadPrGXtI=;
	b=cF2qelb/O6oe6qzA+quWow3Z+76w5ysh0Lss+9yXLirk8JWVa2aYOtGY9bAe+P7Xy7u+
	 pGjtw8YXRDtGisWxOsMwa24xH4uycsQiOS2BXyLPE0XOQ0C7cLEJsl1il2CBSSxS7XcvA
	 RY2yOWRlL5/XEg6jIxXDTnBtd1Gh6dIZy1cveYKAR3jZKgpwTxjs2xZcCEAlvU3AYeGxP
	 FOGyVs5XTk5/NSWfsEvycrqRMUeX0P3uUcoNU6C+cxyRYoV/HBYnJsS0YdKSBoSbyB+NN
	 eBb+CDuybv128wF7br6Bt6m6gEt43EgjFXmII6cqx5a9Wm8BFd/YckpKbB6SpMsmlkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jm+wy5yg;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F94606A33D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38F94606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jm+wy5yg
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso17104747b3.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794597255; x=1795202055; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=naomhjRVZ+IJsznibpYW1bEFswFz05AA59NadPrGXtI=;
        b=jm+wy5ygWGsdY+Ma+99qkE8tcIX0YUU2ekNVzRJEIKwI8g5X0mZlvtaSJRJW3sV7Pv
         DUGnWRWzb3Lkx4JaDT3Ebx8ecJItSNiUOp5HA45GTWTPRwQ2AuANnucylGfv8H7NJCUS
         BVilqj4f4Futpa8fT1Mt/lS6IRv3ST07SGUj+mJkytFAZlzfbIvZReMU/VZJSGuhY1xx
         EkBRgR68kFfGEuobFKAgoyvOoe5TeCB3r5cDMfKsRB8cPHVqt9LO8/mF15gcBpeyUnwT
         6hq5YiCoV/CBJjuWHLxlnFRkpM9Jd2bj83D4CP5nFjqvNZMqJoQbV976KtVyEbwE1/tO
         72Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794597255; x=1795202055;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=naomhjRVZ+IJsznibpYW1bEFswFz05AA59NadPrGXtI=;
        b=k4CFUu8SXtGzP8L/PucQQpRe4JmrlHk6HanBoMoRWopP3Yj1ydwc+R1scD0UMfrs5z
         IgSqEm3DBVJPqrqemC3x7QOLiZanPHnDFKDwY5fvemjTft+PhQYf2rDa/WI5UuOo+y21
         O6U9uTpIT6GN8N8pESgQ/NTERhbCyfD0afUtKFhCW8NMuSL1d3KnWxr8NN9bF6EfF6pt
         K0N8awudhUcBe7fm5enZhBQQ0ALNNQ6bkWiF3FSEfZ65/A+9rCdJHrnAPj4BuKLHb9y8
         rDgF0CyTEPwrVLfIU7j/kXUvoG8RzQLHDOBs74lFtXANAZ6ZgA+AXggx538oqhf4usLe
         lKOg==
X-Forwarded-Encrypted: i=1; AL+hErHcRd4d0so7RDQQbD94FGjVo3H2xeUoyiAN7RtRBaGrcoxcJSHXTpZHYP6c4SSQI4H+8AP/Ay4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/ppVudjK/46wS4HNUZBHA7t1o0pUDu1F8Y0P/F3twJwLZKgFG
	sn/GD4xyEhhscZgWL1EHKd0bs3yyJrLw3CgT/Ck8fWYORQ1dBqtvl3kdDwcv841lyyk=
X-Gm-Gg: AYBFou1bAXRS3oA4Nv5VWkPsly64BPMx9IUXj2im1eIRZEex861SXRD07NQuOaKkC+m
	NhUV19flhSfZ3IeXax5bRti3yYRdlhdHoXYta4RjibNVFI9P3uMMWkWZYIIVgDwU+9xGstrNPNC
	Q6PV+mohwcw33/Ac3Jk6WqEBFMRqqaDTyWlTdG6PvGcuY8FYfOLE7Dpg/UHwtP7Jt4egBF2NeBw
	75iHlQ82+rx0hKIP/ogXW1pBPE8ZT4Ntlv5CDJOojq6CjC5hyUVAt0RcOksstLmndeRZimUAIcj
	KWtAL/xaqo4ywUYEWiJpsd3thDquFrF0KoOvD8q5AN5b97oA9+0y1ny9rgfhPpbhh2nzujlR0I7
	gAciK2KsjFlPryHWW4LxysCQMxmIHIOXua0xIckaqOzJu+2MIm9eSgpKG3nJiwaZ5qPAiek3Bhz
	W6OERvgda1VOOK2tk/WkuQDo39CD4MYWNPuU6DBMlIvs7JCHCLMYnFbor/Nk/IcaOHVIgeeFdt3
	/ny06TXbjbapfFlZ0vIgDYuJMnKVm1BPwfqMPl8TtOrQ5bwi5g2pG2ocfb63+StXb2L6k2jpqUM
	VdRe9FH4Vd5RXZxZFrUnbmEHP6V+LueWtIWfIRT/K3PQSsyvRirYTlxRh2snaJKvCYJn3DKNUMq
	xJuWurCSigbsf7AIx9+5kUe77XHGP3htKOQwesv2znUfM5NIxLLrCC8RdqdKTQjfhixnqaD74Mm
	4nRwuXG86C+jRrspF8oa0=
X-Received: by 2002:a05:690c:e3e7:b0:8b0:ecb2:8861 with SMTP id 00721157ae682-8b4aa327872mr23049057b3.63.1794597255053;
        Fri, 13 Nov 2026 11:14:15 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:93fe:5aa0:2dc4:7807? ([2600:1700:6476:1430:93fe:5aa0:2dc4:7807])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aaa0ea50sm26909557b3.42.2026.11.13.11.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:14:14 -0800 (PST)
Message-ID: <0a8b94b8985ca42018f840eaee7c8b4fb90b21ca.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: avoid reusing occupied CNIDs after deletion
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Fri, 13 Nov 2026 11:14:13 -0800
In-Reply-To: <2bbc10eb1dd5ee69329a9307f14fd15b1815b898.camel@dubeyko.com>
References: <20261112110128.4082071-1-hengyul@cs.unc.edu>
	 <2bbc10eb1dd5ee69329a9307f14fd15b1815b898.camel@dubeyko.com>
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

Hi Hengyu,

On Thu, 2026-11-12 at 14:34 -0800, Viacheslav Dubeyko wrote:
> On Thu, 2026-11-12 at 06:01 -0500, Hengyu Liang wrote:
> > Commit a06ec283e125 ("hfs: add logic of correcting a next unused
> > CNID")
> > made hfs_correct_next_unused_CNID() lower the next CNID after the
> > newest file or directory is deleted. It takes the CNID of the last
> > file or directory record in the catalog as the largest CNID in use.
> >=20
> > However, catalog records are sorted by parent ID and name, not by
> > CNID, so the next CNID can be one that is still in use. As of now,
> > creating a file after deleting the newest one can fail with EEXIST.
> > Commit 6592287869bf ("hfs: fix incorrect inode ID assignment in
> > hfs_new_inode()") exposed this issue.
> >=20
> > The issue can be reproduced on a freshly formatted HFS volume with:
> >=20
> > =C2=A0=C2=A0=C2=A0 mkdir z
> > =C2=A0=C2=A0=C2=A0 touch a b
> > =C2=A0=C2=A0=C2=A0 rm b
> > =C2=A0=C2=A0=C2=A0 touch c
> >=20
> > Without this change, the result is:
> >=20
> > =C2=A0=C2=A0=C2=A0 touch: cannot touch 'c': File exists
> >=20
> > With it, c is created.
> >=20
> > Keep the largest CNID of the records in and below each catalog node
> > in memory, in leaf nodes and in index nodes, so that the root node
> > gives the largest CNID in use. Adding a record raises it in the
> > nodes
> > above, and removing the record with the largest CNID makes them
> > compute it again.
>=20
> I am still not sure that this approach could work. If we haven't the
> thread records in the b-tree, then we sort records by parent CNID.
> But
> folder can contain child with any CNID. So, if we keep the largest
> CNID
> in use, then, technically speaking largest CNID - 1 can be located at
> any node (it doesn't matter if it is used or not). Even if we found
> node #1 with largest CNID, then it doesn't mean that largest CNID - 1
> is located at the same node #1. And even if we cannot find the
> largest
> CNID - 1 value, then it doesn't mean that this value hasn't been
> allocated already as child CNID of some parent CNID (because records
> are ordered by parent CNID). Are you sure that this approach will
> finally work? This is why I started to guess that maybe we need to
> think about Red-Black tree that can keep deleted CNIDs (however, it
> could be not efficient way).
>=20
> So, I would like to be convinced that this approach can definitely
> work
> before taking a deeper code review. I suspect that we still is not
> good
> shape yet.=20
>=20
> >=20

I've spent more time considering this patch. Probably, my worries could
be wrong. But the main issue of the commit message that it contains not
enough details about the problem and how implemented approach is
solving the problem. Could you explain it in more details? It could
help anyone to understand the correctness of solution.

Thanks,
Slava.
