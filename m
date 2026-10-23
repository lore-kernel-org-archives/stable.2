Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775955;
	b=gpIgWQyC3SJ/ywEHvsAog4qPVeuoaT3YR8wA6LiGKkjKVQ8ODkcP4hFacbcsfgCovAd6
	 ULo/1xW1Lh5tGnVG+f2lh+SNwtMV026MRewbfVL5TcYfOfdzmXRBHpejtIN9jdpntbkjz
	 yrGomZ5LWRz0sIwoZO+UJ6PioxszLkyvQDM9wiri5jLNi84AwS8A1smlRrdQ1Swbiqw8S
	 S3RYCiidScpy2Fh5zfdSqGrNSRZnM2WLvP2/J7++uuqavescyDU78zeifHynSHfgPEPci
	 h1xTDermKUk+FnYAu52INYB/mponkW1wmzR8642Rm4AIkuws8CUnJQ2dUO/+2BOcrow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775955;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=iCry58Hu1bv8DzSjqRIxh17FqFhYo6FkXUsOocnB8WA=;
	b=Ez0kBlQ8qi+2iNkigYhK+7La4/+zSHYG+YBZfjHYuXM4UqzWyrKlcJZZXLHeNnpXFXQM
	 G89C4cxSBwKibt6aVfjFesguqSsbc6dYsZ5MAsdz7uJooozuwq8dbc3Q8XbdiCjpZHqTO
	 iHbDEm6+gLb1gEUfSvenQjmEtxXZ0CnqO9Lgn8f8K9bjX+j2IKMCkayELdeGQGMPxysv+
	 pV1JURrqS9zDDJHUXr0hwxT5P3xssdlUkDtUmo/A4ebVodAHPE+43PtiMSqGsi5RIsnLJ
	 PNbl0Kk7wIAUBihN3yy1vozSCroqsha/6E4D3OQo8cpbZiccnu+cSp1zguoL6U33YLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=husSJDwW;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ha3nzJxw;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD3606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2CD3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=husSJDwW;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ha3nzJxw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792775954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCry58Hu1bv8DzSjqRIxh17FqFhYo6FkXUsOocnB8WA=;
	b=husSJDwWorGVBpW48SlKu7ULPp3qmYz+PSHVXYnk2kvPLwKI2yyVkQjSBvTGpeJguZlLF8
	0lbI8zVlkojtYH35PSXoqyONHLes4KT/W7P89zI1y7pCchf1iU33DtDkR96XR5J5ZHMyeR
	L5pIGoEeSSU2Kzlp6Sqnu1A2d5Y/zg0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-Xe0ViUhHMnKxsUo-c1eomQ-1; Fri, 23 Oct 2026 13:19:12 -0400
X-MC-Unique: Xe0ViUhHMnKxsUo-c1eomQ-1
X-Mimecast-MFC-AGG-ID: Xe0ViUhHMnKxsUo-c1eomQ_1792775952
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb7f9bb86so210254085a.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792775952; x=1793380752; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iCry58Hu1bv8DzSjqRIxh17FqFhYo6FkXUsOocnB8WA=;
        b=ha3nzJxwQoH3CSlaqkntmB6SRBjFRfpGenUDoIayMG/A6KjUC3Ab0TxWPZfmgSmrrL
         odibZVu76nVGryIsuft4BagzaQQo/IZavUKiYKqQBwL1e8cRQo1feeD9hSJmFO2Azj9p
         vShzt76BoJ67xkTAnUPEvy6uae5BxOpLXy9rbj0qZ9PQIazb8M+BBFvTb0QhgzNJGvkY
         1txuKIz+IXvfqUymftpqdwHQ4/+T20QgFLx0G86wi7xTCVCS8Hgletuwkkt1+k8FLixB
         0HvScooDtnZAWfvhRaeihqTyG/eoH/icMkDhR1IBtVhEgcTcoY8Vr1WBZjy2I74ti95R
         NmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792775952; x=1793380752;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iCry58Hu1bv8DzSjqRIxh17FqFhYo6FkXUsOocnB8WA=;
        b=ffLZKQGiJg4aNwzBKicWgIVK8IcsxDCF6/93JCWioA5sntvIV+JmWdr6vXq1REFABN
         6POkLgPGFjf5bqAa4+bXEEyvu0PukjvBcnjfkVUb6NFDl+l42Aax9iBRaKLvg5RTq8bO
         63l7Oxjen6T2OG1EQpw8hFl/uEmY6xcWh4Mlk9AhYCsrrAJHkVlaRZq9p8PZ/fV4alJ3
         qzyB8l3V6UBW0Z4QhXubByHSAdRdJdHCldORXGSCii6OOYVaX1SDcQGK00E07Frhyxm0
         TGZZ1IMDE3o99qRRVNIOsAiqhvfLUpLViAzPIrPzO+I4u+NQayye1Bc7JuRbL00R7RUh
         p7kw==
X-Forwarded-Encrypted: i=1; AKwUvBz9T0dCnnVpx+9bvk+QpcOoVRVh+/WExXTrvJUQHPaY6Z5KD/e6cdpfM0SG/oRA16E88rNlw/4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFEklOukGUxCrz00xPtukFpzy3LX5zKZCE2jeVdUgTfioYtLQ2
	gRZ0sa5JJeU2uUHTU+d19cMjoeClzNhPqJQE2flpwahmPyhLk6+TlrrDZPb+mxJfWbZ/12m1Ug0
	rKsx8R9GJAZcLy0dLF5szwVaACqElBgtdLDWImFV74QWwmAfjSrOb2Jdp4w==
X-Gm-Gg: AYBFou0thK9pmR7fruypHpgttdQGHV6igIcY4XsSz5fLk7K+vo33L+YDW3vB7I0zTcI
	t3bv+K6uYsl1Q1G2h085D0PDCTWG6c2WjcpIawve/IPNe/vN/ZiOMKH5JmshWH2jkWr5g/xEIzI
	T9I+7WGwo5BCsNvG7gElng/52T0blKkEB/eRwCzcCGRl5VLG9vpj4JMl5rP1NuZrqshHBPQbpKp
	9IN3sAs8PfGPxDYRGNeAs1xqtDmxCTX78VmqLWP1y7f8e+8Kh51/6xRZOGqv3mFDQqSzvGlePjs
	jEYRvCrWoWzAAENMdgnoqagU8R3S31/M+8ytZt9cANA0r+dkTJHOL7HEJ32etrZnaTSLrMU=
X-Received: by 2002:a05:620a:1a05:b0:93f:2b23:4820 with SMTP id af79cd13be357-93f6f7bd38emr559077185a.48.1792775951984;
        Fri, 23 Oct 2026 10:19:11 -0700 (PDT)
X-Received: by 2002:a05:620a:1a05:b0:93f:2b23:4820 with SMTP id af79cd13be357-93f6f7bd38emr559072085a.48.1792775951481;
        Fri, 23 Oct 2026 10:19:11 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9404722f226sm70474385a.9.2026.10.23.10.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:19:10 -0700 (PDT)
Message-ID: <939ee9cdaa3a561f5910fde2e4efacc8c92fd39b.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Clear fence channel in no-signaling path
From: lyude@redhat.com
To: =?UTF-8?Q?=EA=B9=80=EB=B2=94=EC=84=9D?= <dilddream31@gmail.com>, 
	nouveau@lists.freedesktop.org
Cc: dakr@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Fri, 23 Oct 2026 13:19:10 -0400
In-Reply-To: <CAGC3ukSVk=N4ttd3hwnXXXppHchwroJmySPAFP65Vt+uP0COOw@mail.gmail.com>
References: <20260928081450.19340-1-dilddream31@gmail.com>
	 <CAGC3ukQ7gX97E7pG0Oy8H0cnmQzoA1038io+VhrBogPB3y9dDQ@mail.gmail.com>
	 <CAGC3ukSVk=N4ttd3hwnXXXppHchwroJmySPAFP65Vt+uP0COOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-10-15 at 19:40 +0900, =EA=B9=80=EB=B2=94=EC=84=9D wrote:
> Gentle Ping.
>=20
> There has been some related discussion here:
> https://lore.kernel.org/r/1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordeaux=
.fr
>=20
> The patch has also been independently tested, with no reproduction of
> the issue reported so far.
>=20
> Apologies if you received this twice. My previous message was
> rejected
> by the mailing list due to HTML formatting.


It's no problem, I'm going to try to get back to reviewing stuff asap -
currently I'm in the middle of moving however so I've got to focus on
higher priority stuff at work at the moment. So it might take me 2 or 3
weeks before I can start reviewing stuff again
>=20
>=20
> Thanks.
>=20
>=20
> 2026=EB=85=84 10=EC=9B=94 15=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6:10=
, =EA=B9=80=EB=B2=94=EC=84=9D <dilddream31@gmail.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
> >=20
> > Gentle Ping.
> >=20
> > There has been some related discussion here:
> > https://lore.kernel.org/r/1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordea=
ux.fr
> >=20
> > The patch has also been independently tested, with no reproduction
> > of the issue reported so far.
> >=20
> >=20
> > Thanks.

