Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793085920;
	b=d7zmO5dWuftDEvS8V+nf1XYJsvZCKYOihxeuvjqaG896+BVOg2RvBJRE9cjz5xQI6H70
	 6EwETl+bPOnwceaK4sjb8wT5YNo4/ZR+4cC8OVyao8LhirKbxk3oXi5jx6SyczW0u3Uae
	 p//7S7rEelChzC2JDh9VTT3YzidLTv/BKM3amSuaP0wypfOGoEcRkki3gfJ2qAE40Co6j
	 ONIRD/UNgavQWzGS7d+tSe+LZDUV39Ftj4esmhCRgmNJPWomVc9G41o/a9g+qrYylU+Hr
	 qq0u0FCulTTBq7YwMSAzpoO8yvOtwQ5msQxbH+eD2zZPP0xNi+lgpYneNBkM9lSewMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1b3yq9bDkj4cyY1tUi5WC5LVpuov7BX3buQ90jWR19Q=;
	b=xNUzlQnJEMOawuZfML96+UTrgJlYkRZZPo5zXwKiVftOlgYHq7FEUXlFFKw1XoK7dK/j
	 UPj0Lx7ENyFYTu2bnDPI5osFlszPAFqqkuYi+emp1FCBV25rK9Ae2f2nEqmFN4N8ZGPS+
	 QHPEim8IM2GS1oQBxZhyy6l37f4y+Tc3xbPSylx7QWYcN5clapFuz75ZtRcbFU4y4x2y1
	 fiJs50ilw8CptBt44fflt/LGzVVvFqx9Ome0G2JbxngLfNGNPiz9+BZAksvjVOMwoH0lI
	 o3nUa/xvrJStknSVtWrkTXneyVjzIDaThoFCCZiEcTLfrumzCjWAmwrpWo9BmxLVE4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=i4yqr7Tm;
	arc=fail smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1C7606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 07:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F1C7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=i4yqr7Tm
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so1601312b3a.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 00:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793085919; cv=none;
        d=google.com; s=arc-20260327;
        b=WtfCbOhzEVxggO46SIVV2OOVIXPM44L/9VqVzHVGz2okFGaRJt30RLtkCe2kIWvFq2
         ZRKhZjXAx9lsLxLxVS/t43OfvpqjEbfiXrWEStofmDOwC3puUdB5WAT7IFqIWMAayM01
         nHQJzZYBxa8tj/xM5yJVOo/A1Q46G2wgKOvWOGt8hvNiC+SWzurXrl2LyM3W97OVR/J1
         +JJ5IrGkk5d1p8P+iE40GrMA0erNfGJwDQvy3mCIE1kgs7/iDXJxRsnLweZw8rRZc61B
         CqIHbJJa+Ya05KW1Syhj8YgBoOmbpJS6g/rKFVbmKXjeFpvKEqJwqXkwdtQ0nzggOChz
         V6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1b3yq9bDkj4cyY1tUi5WC5LVpuov7BX3buQ90jWR19Q=;
        fh=/AwNByIXmjLlLtbAMpjzJGXp98/i6C2JISU6jhzhQ5Q=;
        b=JdcHXA5CVlkGA2TLcwx4suXG07RAHtxMMO4TRTQt0osz1bpzuwqkzljRmyWeZ9jUR2
         oSQUk35V7neC2og29NDHwrGsDI16ia3N1xwfSjmWqlyQ3FoBXXpVKQJNvMEU5DNRgiyW
         jn1n21LGZF7fNyV6hDvtVBwbnIQOSHn0iHEARTRNq06rK05nf0teJtZ9E/XXOQ1jAxoG
         lUwPlNc1ej49RItWWyHdwGwd7f68JsE2Eo7VSmjPvAXyCXzteEt5AKXfH4S09hsOgljv
         j3GLjeEDLm4ygnWSFp+16+Dc78kpA2t2uQ0J2yKKgx6GrYUw666zpjOoVGen8ctAUcQV
         zMbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793085919; x=1793690719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1b3yq9bDkj4cyY1tUi5WC5LVpuov7BX3buQ90jWR19Q=;
        b=i4yqr7TmR4nmOslL8RUixlCjBdWDnhnOn8mTXO0eJbWngP2C6b/ZZD1XVhWpDnOvd8
         C2qCLaFFSLRoLZZt/nXpQUBmikFS0ckpGKluZRI17EGPDMlY8n6iyVnwDjsgB2qwlpZh
         tSwWOHo5j/ZLYmvp1EIi6dYs5Ugfz2oOSiUNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793085919; x=1793690719;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1b3yq9bDkj4cyY1tUi5WC5LVpuov7BX3buQ90jWR19Q=;
        b=jCoCclkdejVFAjjwgD/seMc4pqMYeyrW1xG8GXbE+0R/vGX+nZgcy8Q3ROm2M5Ojx1
         NwUy4UCG9zhk1IeLO8cUJnWXP+jljy/5uVeBFh72IbUfb5mLCEAEmCMiu6Wq7ltuAQZz
         DDTHrkTaFx3uu/LNWLeA1xNEq0uDtcxZ2ulcTWbrlAez6L66ZlaHbgcTdfWK48TpuSMp
         WTVqKJz1CU6Jti2gVXs3X6rDzApmj19Ml+DCCBWk2XCkPti0lrrrNOrGYLj4b5mG12C5
         IxCpBTyznHP+7Akje/PTbySzJJfBh6gptvep8dLPJsWiyxbR1gxXZjaSbWI/dYk08TYr
         HTrg==
X-Forwarded-Encrypted: i=1; AKwUvBwpJJU9xNkJUZY14gMCWxlzl6uufNSq6iKhuU/rBS9Gzh5rQaMwrW+SNOwQK80qWYxgVF00cm4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTNTEAXkP6min5tPbs2OJqIl7teAqkkUrDRPJAPWfobTnGcedw
	1r2D8DUY1slfH3219qVrvSSlAR3DV3goRWpbxBXGyHDPPVWqroUnTqif4B+mZawG9PiiQHzXeio
	yzCwCVw3m/t9CGEeErjXR+NbyCzWLOKb3jf9dBl10woNwwajyYgg=
X-Gm-Gg: AYBFou1MFEaXbzNkmwZbln8nbuJc1j/hHPFE0AVevAHxl7xpZBmSjuKyRvmNc/Ok2Qw
	Z04RtXOsem/5nM9yQMdmNbS6SfCaJAaNWgJKVOVC8FpdtZ2GY1SHw1qr0cX9qx6S8HcenS/UYEl
	6bm1GUyKBwGXLaCQAiHpHSmhC5NkW/p03wPJqv65zpfbUYEvbzg+u45zvlaHvjVD3+dePeudXuz
	Z4iifkZm9Pk+ED3zJRZAfgpFkKNXcIMB1IFHxQELS/fWiDT/7ThfONbLTvSH4CEQpR3sWo4dygI
	w9Qj+IfmiGli5MrG0qRkdcyyCWGbhCiTfUeHYNrbYHnCHDJfZfaeJpK92qPCngQw/aNiwL6Nmcp
	psqRnhG5BNeKs49D951u+gVUyPcHkZzn/lwoMHZJgfmMcSPCx5vT0/Cop33c+qZkguEzDaY/W2o
	7EN7gCQ7fSSjGPwyk=
X-Received: by 2002:a05:6a00:9093:b0:878:3783:8a88 with SMTP id
 d2e1a72fcca58-8a3689a9e0amr7511811b3a.52.1793085919500; Tue, 27 Oct 2026
 00:25:19 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
 <20261026160747.283702-1-horms@kernel.org> <CAM0EoMm9piw8gLJ=t9YYNu2-8zb=qfA3G6djchL0QaeZZvaNfA@mail.gmail.com>
 <20261026174643.088e3f49@kernel.org>
In-Reply-To: <20261026174643.088e3f49@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 03:25:07 -0400
X-Gm-Features: AclHuK_uYZ49I43utjW4TiugqfGvmoGuDzSGM3UY8eQ0cCU3DR7mRFC8rpStjeI
Message-ID: <CAM0EoMmVv5WnzpQw2d7iLZU84KPDUMf7+t5m8BL+MBXR+oy7Lw@mail.gmail.com>
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, victor@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 8:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 26 Oct 2026 19:51:33 -0400 Jamal Hadi Salim wrote:
> > > This is an AI-generated review of your patch. The human sending this
> > > email says "Hi Jamal, passing this on for your consideration as it
> > > seems to have got stuck somewhere."
> >
> > There was nothing wrong with the headers this time - so not sure what
> > is going on. A bit frustrating.
>
> It is frustrating, you are the only one with these issues.
> Patch 2 is posted in reply to patch 1. IDK what else is wrong.
>

Let me send a repost3 - will take the opportunity to pedantically fix
the commit message (no code change).

cheers,
jamal
