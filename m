Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793225386;
	b=ndlHiPlvBA24Xw6mf4mmvBESAeUpqEwD26ayi60VX7yvTGfYQXgrlwo2/ZqJW4NUfBpc
	 t2eqU5ddtjAr4vyRkKtYr0MojVDsipWWWEz+3koNBYL+c5ncZxlBQ2pqiOZgeBulvA8vj
	 UZFS/rBfidiklTYXHKZSg7IrrruZejSFrlwaUXYcRwMPiev3yM6xeKXwlmzCgyvucwOmq
	 CoSKRTcN6zyhNTH0JLryyqrG9V2SToIiq+ga2bvWVeWNEGmpyoVmIUsNL/CyzKzDhl17f
	 HphIOShHmPlqbPuh6/A0rGc9qnIw9EP30OvawrhAbBtXEA0L73OLXw4wEa12M+xcmDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225386;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
	b=5TWIpLYfm6imKkDDrUPyBPEOH/a0O5V01tsBfAPPBSVdJccaVCdmp+5Q0tFsWJZDAjdN
	 M18dAWOizqxRH7IEYA01JYs4A0Ik4jbQYZEReZzMnRBvCQYDQEpKaHsR9QDBXo/AcQEP9
	 qcheAxYcuQKC9H5zJphVM8vsk8t9AvEEeGKQ/12aczhMjBb3u/cq1ILG5tJd3H44pINYz
	 U2iEmzMXk+6C7ZaWKFVzp5qHDZVfTtmFtQN3EovcYE/LQ4jXqKVWzdix5NJ0Cf6bLXAiU
	 bbi9nuWCZ2w+u8tENXAt0yI6eR7jY2Me7NlxHAyK+Rr+m2M6iP5Zk9NviihSQeeqFSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PNja0RrK;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dMvVeWef;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5874606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5874606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PNja0RrK;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dMvVeWef
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793225384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
	b=PNja0RrK+GAXFseGHRAPgDcQljq0pWRU5IrNz2yhBUldeqB5xObADIbjyjHyNHrutF7Pt+
	rJoNk3kv9NPLEvl8XKZoimFvycT999RKjoXG01AAR++Ak8kkM30MDhOQrx+KtOHBWo5kfK
	yRocWGrPgLWx6N9WURbn5mAhp5Y0UlA=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-XaNHbmUcPiaMaJ_samwXEA-1; Wed, 28 Oct 2026 18:09:43 -0400
X-MC-Unique: XaNHbmUcPiaMaJ_samwXEA-1
X-Mimecast-MFC-AGG-ID: XaNHbmUcPiaMaJ_samwXEA_1793225383
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-67906c453b8so313561d50.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793225383; cv=none;
        d=google.com; s=arc-20260327;
        b=nLiIZprmHiomBJMHLuzf69tyQLCDhMdnANThH4paKvHQIjKpU/oARkAI+dTr46t3pD
         OLS7uFooqaD52nvlhEwo1utYfwojDbO9Ph9hZhwf7lY05lFPMiCI3gDQjr6a6EZ4mi9v
         sIIwi7H3/Bk6j2UkSA8H8xymDljQcRFfKuzmycEcDdkuvwSbFPA8P9y8MmV0FG/AJKSr
         ykJsZu2DY3qkw5I5rhBbGSKjtfyyflpD4IcAiXqSrgJel8r6xWA7J8ijs57PqCW+fpSi
         97mrBQyOeUZ8KeGfG34zGi5f3tm0VLGfQpuLNa8S3Q4oOouI6rITeo07GnPCmEC/mSWR
         fJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
        fh=U7v6eG8XY65s4brnkZIEWkV288Jj5DGOs3mf3Hb4LyE=;
        b=HZc/MFpO1ISkwOo5+lWyVKe43jCk+0Ci8kxMCqoWjJmhlheUv2evNeqT4A+NQ4OgFQ
         qMGIQ/abqesytTZzapb4qKHILFGxpfEYrrYXmhqg+clzDe6OQYs4YCNsQnoc3alrw/q7
         9gbdI/0fKxO0ESojepUH9Zga6EFw7NwyrJCVi1qsqutRi4mMh+3zyNVr0gOAsnIf0ogo
         fQkZ+SbS9ZftzJWpu4bxSDMhNglebOoOnMoH0n4E3ZJvD7HwS33y/V52LzfhGGKaQGsi
         T2H739XWz5LurCDXWRzXvieLsl73PFnrY87MNn0ST/IjKcqSrBynFehg3M9CWxYbZBpw
         e1ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793225383; x=1793830183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
        b=dMvVeWefC8P+UdQKNVCTRzDnhWHngZQGob2rSgzwsZSnRN8SAHr7CL96OPYJXufFq7
         zSTFFPllhPr/w76wrseeWsykFIT3XNeylizZvRvScikFw2Vx8ZBVf5aKYuJSSTUPuuch
         XBaTxNgE5Gyy25Odb94BXqgaNMMlvyhAsHvl+cohQ1ckCaDBDm4+NkPEdFeD/j45D4SX
         9JdubWa1Rkola0sqbNiDrUuR0ynjj8Js5euvpFf83x/dOZOzpzImQtYe9Q9exxMiq/qr
         mXS/pEC6VjG6Gc4ktJQ1wDheP9WEZsIfL+MfkoZBHHuqMX4NfKOOS6gRPfYVsrX4HqWa
         L7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793225383; x=1793830183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
        b=crTGvdUBrwfbwwS4P9KVKga4dy+ECTl06tEtoHIfDwYV5oSH7TZ7ePqjfm76YsmQM8
         iT+gB//bIDED+C5aikOVrCClCBtezRsykQ5BypwLvLeDLLe99SSD7w/VcH7oris8Hv8r
         IdwFxniSNHrW/RdMXBv5glS1rYkyy7frBo4eRoF12o7kEmbeGa1dSDOc1LHHFs1Oo9+y
         5YOBO1Z2Zb83N3XsCdEcY6jBwp5A+bcRoSPQ0VH5DgeIlr5EZiO0BsrerafLMDXgtGlP
         ZTNolJBQr8E5QykODZ+dwKecj5RKg9qosD9itcnyCMjSOhbG7Vg0yj+6sKZkmhnAnOaO
         w0VA==
X-Forwarded-Encrypted: i=1; AKwUvByHDS6Bz6YhBmyXo0KQi9RMflKmeVpD/TFo46ca46s9RcnFpPWgxPkIF2uPpymomW5/CjWOoFI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDSRqEDA22GK8tHqPVR8oKozdKtCnLsBATEZCse3kuXjPEpoMv
	MnP/zIDpm+JgL5pMl0Esn1+tkzD+hG0r0B6Lk6qo7qUo+yW2poTXJ5WvJDbEougE3OyhHxx6FsN
	eUi3uNxquLvzubaCnIDiGrxf3i7qsQlEfItT3UyL8FxncQ2QmjJjBNNegM/v5cFeC4f3EOIdZoC
	aO6EV8xdnK4buXGMMg8WYJdVYR5dxYqkzE
X-Gm-Gg: AYBFou06BUWrc5SUARAdMtxrumm8ZLi9b2vGUNA3at1zboo54U7byNFMJV5cF/hX5jo
	XNNNOPxQ9WS69ba2dLwju7EJXgNo/k2AjAl6oW3qKDGuTCzAL/K4kRPZD8oG8dS8DfLUYmziP+m
	4W7ZMXgTSKhsDHzQW3lPHZSfYuSHeuqKs9GlaBRRstF4XGw+jUfxRjtn+B4jgu+9wYQtbRktLdw
	WDUXmzozX01PXM3Xz+5V3PDS6dBwmIGMVrNGrEJ5ZZqTw==
X-Received: by 2002:a05:690e:1918:b0:679:ad2f:3fbf with SMTP id 956f58d0204a3-67a8d0047a5mr704876d50.8.1793225382866;
        Wed, 28 Oct 2026 15:09:42 -0700 (PDT)
X-Received: by 2002:a05:690e:1918:b0:679:ad2f:3fbf with SMTP id
 956f58d0204a3-67a8d0047a5mr704846d50.8.1793225382297; Wed, 28 Oct 2026
 15:09:42 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012-work-fs-sb_rdonly-v1-0-60743a3dc326@kernel.org>
 <20261012-work-fs-sb_rdonly-v1-21-60743a3dc326@kernel.org>
 <CAHc6FU6z4kX5R3Og8m0dYOHsjFcw+4Btvfe87AGPxy_EWs0E7A@mail.gmail.com> <20261028-zurschaustellen-okkupieren-inkompatibel-d11525ce88b8@brauner>
In-Reply-To: <20261028-zurschaustellen-okkupieren-inkompatibel-d11525ce88b8@brauner>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 28 Oct 2026 23:09:31 +0100
X-Gm-Features: AclHuK9MzobLdiG2EG9M5KT_ibZzYxdrTghiXff6ZlesOE7YSK8Ag_RtXekxyZI
Message-ID: <CAHc6FU6VSAWQ4RJTO_eLnpqN5qvrShbJeT+ADwiA6ohpq8dO4Q@mail.gmail.com>
Subject: Re: [PATCH RFC 21/28] gfs2: don't set SB_RDONLY on withdraw
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-nilfs@vger.kernel.org, exfat@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, ntfs@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, linux-btrfs@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-efi@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 5:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Fri, Oct 16, 2026 at 02:01:00AM +0200, Andreas Gruenbacher wrote:
> > According to commit d564053f0746 ("GFS2: Clean up freeze code"), the
> > idea of the freeze sysfs file was to make it behave like the FIFREEZE
> > / FITHAW ioctls. This isn't what the code is doing at all.
>
> That's a pre-existing and separate from this series. freeze_store() calls
> freeze_super() and thaw_super() directly with FREEZE_HOLDER_USERSPACE and=
 never
> goes through gfs2_freeze_super() and gfs2_thaw_super(). So it never takes=
 the
> freeze glock. I don't think that's for this series to fix.

I mainly wanted to point out that this behavior isn't intentional.

Thanks,
Andreas

