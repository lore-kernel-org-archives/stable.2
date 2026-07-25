Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82B314A95
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784965193; cv=none; b=GxqVZZ7F5s9R2gorqYFz3gEZQZY0kAcAmFBHW1LD4WOYw09Ccxdi28VOp7Wi8ifG4XVSBMBO2G5tpvipKHSgsg8LRmH1UzNmIGiZ+JIKuRyuUKmmktwiy0JRSL2qWyaSIsmRd69XaxrWxx8DiBfqGNfMB8xQF1NW+iyUdaw2QUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784965193; c=relaxed/simple;
	bh=k/KUxMM9Py7HCnvVEMRVoQcgtuSIjjJo87FOXQLaZjk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TQFrBdYJ+Wy5Fa1eIWiGtyaULBdldJazu0zd2WQTN4VKqTrsJ7s82eNrLFVOCnV56tNU2QJDNDRZYOcIlEJjPw/TgrQsgxc5I9SoaqRZM59AlnyAABvH8Bodh95Tv35AkHvEoZWeAoTVNEQJ87nkIjfXB02IcvKOwN0OCPOQTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUKXGokL; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUKXGokL"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6681e7911b0so1365336d50.0
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784965191; x=1785569991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k/KUxMM9Py7HCnvVEMRVoQcgtuSIjjJo87FOXQLaZjk=;
        b=rUKXGokLrTNmWa0a04KYKnIokAVenKPIEJXGfNLbbeIj0nmoWtl8OSGPHqlh0+hNWY
         JczXSOLEmUHNP4JA5l/HnpL6hFaTsFxYqlkBLYqJSLrrmdh+pqRHawiuA8yOuJlHdMmi
         FlCBXskcf9wyv8LtKegbl6m8AXRd9FeVEvmyRj8t5gBcqgpq2Or7NGdEf9kGhyJquZqX
         cnGQaTKa7Ub2q4+AsJpY2P25o3JK4DuF3IAgl6Xt/9JBwKzyCmBn7wQYJ5YWBWZrIBFn
         QuNbiiTDo74p7Iz8V+m8+ptRZig7BwK0o8wrWy80veZGPGAd7ANZufW88t/KJEffaodf
         T7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784965191; x=1785569991;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k/KUxMM9Py7HCnvVEMRVoQcgtuSIjjJo87FOXQLaZjk=;
        b=dFbQF+1MYgZgWQcVn7cvRsGx9/3jwq5TiX5oxiu7abuoFLlhNf85a/5PG2+H2Iog4b
         lJKQI5sd5dFIQzAt9MF7qx0HxcDTsfF1G7g/JwFN0vaJg1X2vlBjfoGIRRkm9K0ylHlQ
         x97VszDadN3AoSGYMd3wvWZPoHVuy6ckMQ2d4SrhjAmNHcOFuJk0klRVl8rqzlqZ64dg
         ajLpIIdMs5YE9RkWtf/86Ey50TeY0ObI+Wz/viKxk5pFoT/hbxClOUEbScKG3DvXiFlW
         4d/ezYrPnw+mXi0TvXXsG6yAU6t4R17GoUR+9dhghAU1mSv0NMz1kDsR7lzcwiaHlCjf
         f7sw==
X-Forwarded-Encrypted: i=1; AHgh+RopNG7iOUFDnUFr6T4bEzsNMhLBr0Q5m2IRZfjVb4qBW1c8jcUWIiQnsNUXgVHAU1xTyZBUr2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHp8R7wk4M9kgg50BRKjwSwYnY3jtC4ShG1sYz6s3FG2ENHm/W
	07643ABpiglCh4m+4lqi1OuYHBDfhJDoyLbA9IJYfhOQFKAtTVLok+3K
X-Gm-Gg: AR+sD106Hec9ZHOyYaiH4QdCX+JsCB+DkUt36E5DbLZPzstR8Uv+JV/74ld0Ni369HW
	8W51P6ox5Fwc3nnkMd/qssp8IpA0rM9AQDsLgFY/82qMB5bnX2RF0o1X2ru6aDltna6dQO+V3RO
	buGM0W1Hh+/t25HIztu8rmlADmUM3YsEJTU51d8VG77MMKFR+v798Vb0kaQVdEoY9/fVKSzA5eL
	EW+sDrzt56wl0Mg2QUbYLNQ3b9iohtEYIfTpA5rysYFazom34utUcMe6TB9mnq01GjR1PHdBcPJ
	1pTWvrojppkzOPjfS/U4qrsE8p/POVOLrNq3xQxWUxELVzSfjgpLjsMfdwbQeZvM6xMmmDGq9Ji
	hM7eMxedfazHGhVQFawwb2qL8Y8fW6yumPVcGX8BoS4GJDw9reAt023ahxLOB5ZogpB8gX9w9U1
	kzEZpB5WEjtpbKgpyy+LlIZgMiG74X3Sl5zro1QpVOVlTZs1mmvTrs7xk=
X-Received: by 2002:a05:690e:43c5:b0:668:96a9:e57 with SMTP id 956f58d0204a3-668c7afe620mr245052d50.56.1784965191387;
        Sat, 25 Jul 2026 00:39:51 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c7041256sm527879d50.19.2026.07.25.00.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 00:39:50 -0700 (PDT)
Date: Sat, 25 Jul 2026 03:39:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.18684a639029c@gmail.com>
In-Reply-To: <CAH78Gvuoqf89L8dm-FwRBzCGm9LaB7H_vt3MsOY5QPd0o_zhrw@mail.gmail.com>
References: <20260721084935.12312-1-q.h.hack.winter@gmail.com>
 <3e4b1552-57d4-42ad-a244-a91b74b8dae1@gmail.com>
 <willemdebruijn.kernel.3e74e4fda69b@gmail.com>
 <CAH78Gvuoqf89L8dm-FwRBzCGm9LaB7H_vt3MsOY5QPd0o_zhrw@mail.gmail.com>
Subject: Re: [PATCH net] packet: use a consistent hard_header_len in send
 paths
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qihang wrote:
> Agreed. Caching hard_header_len fixes the RAW paths' inconsistent skb
> arithmetic, but not the SOCK_DGRAM race between headroom allocation and=

> header_ops->create().
> =

> I also missed packet_sendmsg_spkt(), which needs the same RAW-path fix.=

> =

> Would you prefer a v2 covering the three RAW paths, with the DGRAM
> callback headroom issue handled separately, or both issues in one
> series?

Since the DGRAM path is non-trivial, better to fix that in a separate
patch. Can be same series, but no need to delay the RAW patch for
that. Thanks.
 =

> On Wed, Jul 22, 2026 at 10:26=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Daniel Zahka wrote:
> > >
> > >
> > > On 7/21/26 4:49 AM, Qihang wrote:
> > > > packet_snd() and tpacket_snd() read dev->hard_header_len multiple=
 times
> > > > while building an skb. Device reconfiguration can change this val=
ue
> > > > concurrently, for example through bonding device type changes.
> > > >
> > > > For SOCK_RAW, packet_snd() stores the first value in reserve, lat=
er
> > > > allocates headroom using LL_RESERVED_SPACE(dev), and then subtrac=
ts
> > > > reserve from the skb headroom. If hard_header_len decreases betwe=
en the
> > > > reads, the skb can be allocated with less headroom than reserve, =
moving
> > > > skb->data before skb->head. The subsequent skb_copy_datagram_from=
_iter()
> > > > can then attempt an out-of-bounds copy. Hardened usercopy catches=
 this as
> > > > a kernel memory overwrite attempt.
> > > >
> > >
> > > Wouldn't there be a similar issue in the SOCK_DGRAM path with
> > > dev_hard_header() calling skb_push() after packet_alloc_skb()?
> >
> > Good point. this does not use hard_header_len directly, but e.g.,
> > eth_header() assumes ETH_HLEN is available to push.
> >
> > Simply caching hard_header_len won't resolve this. dev->hard_header_l=
en
> > and dev->header_ops (incl .create) are not updated atomically.
> >
> > I missed this earlier, but besides packet_snd and tpacket_snd, the fi=
x
> > is also needed by packet_sendmsg_spkt.
> >


