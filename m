Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE02FE56A
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170668; cv=pass; b=uiX5TZ/SCyDccDkhPFl7u8V6tsdSS7unwbuO5uTvlXuGWY5DWlFN+h3gRJ5uVhDTen16su+3Q0ngtUeMvCMOIPrYyMIBlpgKRqXOIZnxSIp4or9o+n/HAV4ZZq6KMmWWEZny0VYqaVFL4x+Fa4PvysSfEOhGHWCBlRY7verKwr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170668; c=relaxed/simple;
	bh=BrD5X/qajhKhIpvg0g5OqxcGGS0biq4kJ1E5IjrsekY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBdbimq5BYGZKVWevtDKSBXCj7SUQS98MrQxlPkLR2szKx6/cwlSZ11926W53jWwKw07pArfpYzax+jquNJfUKRc88DsZynoifzXlP5hYVpbmyaC7QKCvU2WBK1gN5nF+pbxY8KZS06HgY94UudPYXSW6Ll9pMTtocAYHEFQbSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bgIrqiLO; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bgIrqiLO"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a17211b9ecso284591a12.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 23:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786170663; cv=none;
        d=google.com; s=arc-20260327;
        b=ZRKgJOl7m7d1R5kljOWLVFAcMdLWFq/g5x+Q/9chrtL/akEBSwnWuwoPXStRVzd7Fk
         /NwFzOexID9mv2TG7KHUhJCklqJQwTx8idKTgRGsd7WqdTYDj4w9GtA18j5zdjRjN1Cy
         zffaaiaX9h8CVjDOrkZy7Ssy+t7qs81Fctp7a8cPH8X2eiiomrFapZYX1233XWwg6auH
         9EYwZ76Rq52ObuI8Sk2J5/yIZlqabCywknk6ShTLozWMDjFk8z/2ECoqZtEpZL5c2co9
         JpVvj6/kqWPtlh1ZnrKOd6O27Mylv4CnxYxtotS5MIb7y5o1NxHgxtuTDI7SCzRhsciF
         oznQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BrD5X/qajhKhIpvg0g5OqxcGGS0biq4kJ1E5IjrsekY=;
        fh=Z2qTkYBshzDVdkLj4Ni/kXI8QYnQlze2uOmwk9M7ya8=;
        b=KlmNzt9SciSjaUqEE1n6TpnuqQcYvvaIK8NDTHY+AVmu++uvdpCyFrNmIv6/nvfgRN
         OhKAOPieUPYZbzi/nmzI++8w5uK/2sLnlhHm5VQEBg2ZaEr4aaxZ4gcdJiyAcK/J0+ci
         UH2nyazRy9ywOEJXcFPPq4rRbGCEPOxfkg/gm5pPqzNLsAi50D3qSObtN5/cLnpWuciQ
         QPu81ciSCl9+p8dzHD//7BQWERH3p2WMHb7l5e5Rtli9D6CdLS57+VaRlddchdfewDku
         05Y5luDU+Md3kTDuvfeUVGO3X1Bk4mv5afCXUUuFOVFEcH/IBH2pVQZfUvfI+NbaH6Ud
         9lLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786170663; x=1786775463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BrD5X/qajhKhIpvg0g5OqxcGGS0biq4kJ1E5IjrsekY=;
        b=bgIrqiLOYkmS9SVkbMnk/Ymlu2fyJtLtmI7FcXNEfJ3ZIqcsdFDb1sdktYCPcUhN6u
         txn93Y7CfRrUI409k4QQgHz+4BycVQ000GrIvl0RJbhHw2umDX0o/sCwuFbizpPxsrnR
         m06Gxm9Pl866PS6wmIR4dmXFweHlqeGacs+FHlQofkNZRYp2q08HceCf1+dy2kfDWRa3
         cBvRIZEMLEVE12U5PM8flnE5mw+Vys5SAUtYN/jdCBg2VRntNZfnOBJuVAy2UN1KoABu
         z4YLs2WQEm8wX7BOd/SeV52rOgyvWgyo1L3/BLnCdgCALFsWBW9pvzq5h4YrYLz3NZe6
         ZftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170663; x=1786775463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrD5X/qajhKhIpvg0g5OqxcGGS0biq4kJ1E5IjrsekY=;
        b=cC4Sd2x9acs3Ex7klhxfrloS0teLXCLY5/agz6FBUxTmnfjvuPi2rOmCiwGqMJWm2P
         no0N7RkpFen2C3gs1ANdPQu8+AC/AxvAtydE9m96kLtcgeDJaZzV8C8Vok4O128HdNc2
         DxfAwyyqSKY12NdktDw26BKYipbTnMiP3DYYPHTzCqVEtFxq8WMLR1Xa5Ip2KiH/ZXIF
         jQwiTGJzC4xdAOIjodjfi6QdO4r7d5GFpAmG2F2E8VrLp5hHNQ1BZwE8Bsbbp/DRzWfW
         0y9D1NOHRxXaSGRxaWL7NseYd44bZTIxlXZ+bh4LziwUgPbJeLamO1Zro4q75NE3Ugfj
         Gesw==
X-Forwarded-Encrypted: i=1; AHgh+Rpa5zZ8j1SckbLWKOlOVtXBjzkbvaJW3Qgtq0NI26qtYbrZY/xwY5sDS/xmTIrzRHCMlUX8XN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz87NYzg8P4RgHKERii0BJPRQbSIfv7TpbUVBcWufplP5spPPL
	jwvnrEHOLGRLapbaMCzutZ7TFPvN86riamcV3PLnEQDfD72AVP9+XS3AQlQpD6OC5aAXh7kVWiO
	xjbTNPg4sKp5vMmr0YrnmmbPZLVInimAubRdE2CKDsA==
X-Gm-Gg: AR+sD10wYDNOcOMe1Od99sOcvW+hwHDzPx7Y99xtYC3SOvMOhH14SRkFTzCbNxkCSzA
	K1LATA44jInp7zkzpEFyeJnoVomVwkChwRi0cG6myI/2f7Pga0A3cW5QuEqpHhTSAKuHPysHFRH
	iJCXAJhUWr1yrUv/q/pr/E0T5lImvZ7nNYpLLyhggAKNQxJSMk7M0wwSNKl9iTPQ8hVEE9QUu7c
	DENBmlRCO26lI+Bunke9t6FjqCTQMRPpGaS5VGmZZYI8Jy+ghFhzwsUhTCcHiQjPqFABOAKuDEp
	16n1Bak87B2F6JPALBK2nuLG+HF8OLkfQFIRNt6ee8s+aaElagePz0PYkK6ZAUqKQKrXOR1WpRr
	7T3rsfw8F
X-Received: by 2002:a17:906:ef06:b0:c16:101d:7afa with SMTP id
 a640c23a62f3a-c2039eef51emr1278998866b.16.1786170663333; Fri, 07 Aug 2026
 23:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727014745.1304657-1-zhanxusheng1024@gmail.com> <CAOi1vP-Ba2=Gd3_wtH0g9yfqB6xJVstjarsmUhXj7WGXedqGBQ@mail.gmail.com>
In-Reply-To: <CAOi1vP-Ba2=Gd3_wtH0g9yfqB6xJVstjarsmUhXj7WGXedqGBQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sat, 8 Aug 2026 08:30:52 +0200
X-Gm-Features: AUfX_myUHVU95ES5DR6AjP3dNKMdpCPqSEnOWDnoONHwwIDT1_sT3WiV6rWakkw
Message-ID: <CAKPOu+8Y35cfhz5gqus18-HPLoVMiSWF7cVXVbyn6GmdJA3Z6g@mail.gmail.com>
Subject: Re: [PATCH] ceph: use the mount idmap for the owner checks in the
 SET_LAYOUT ioctls
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 1:31=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> w=
rote:
> Was there any specific reason you used nop_mnt_idmap for these checks?

No, I copied that check from another filesystem, probably ext2. I had
no idea what this parameter means (and I have never used idmappings).
I guess the amended parameter in this patch is correct.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
