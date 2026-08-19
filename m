Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013CF47989A
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150197; cv=pass; b=r5YXqxpB67yATc9lPV1czyzLtmjyIpzKfDX6cF+FcZC6ve9Qlw4RfIxYqdT8yjpvS2ff0MEE83ywvy8PhW77i9mw9q+5Z7AyeW/abhOsBq5DWhbsyGft/C/Pt+YmDb9WRv6ELB5GUUG5TVgC1Int1naJeLgAm8r2VdEzjbHiaq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150197; c=relaxed/simple;
	bh=kDjXqP8m0kVACEIX1owlQEem0wUj0wazig15t7e9Pq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQ4KQgJuj/dj8aOnPYnIq26+NMvHky/7AkEz3GO0An6m8TlQ2FK0bo+WkrW87+s0W2t/S/E6koIQQyJAGHaOZM8CIdT0DvTjFbaLA8FjZPIcuww4xoGr3V26RtF+uoDdFbUObhK00xs2rgDnmwieqY8qfzMhdLbd80rtYe++Urw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqJ2/s+d; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqJ2/s+d"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so169837166b.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150194; cv=none;
        d=google.com; s=arc-20260327;
        b=RhDmZ5LYd1Y9q0mc1NBHILzcBy8ttXx0C4mDsYojc4uNFK6oOkbGOmuLNqNanY1AuX
         xRvp32YU0UWV27xZAdGHEYxO+RIfFMWqcpQObYuj8h/TMJ5WeV6geqev0Ui1fbvgJLZg
         YXHmJO0RziEBIk7rQJYBjC2DEZ5KGb3Jri3wSwgvmUhuFz4Uk8TVz5T7Up6UCY/VJIAP
         BfSi4soQkQfr3QMCAMc+iHlP+QNaZmwsYQXJqFwIt+DZXp3B08IkUGD1EO4X3A6kwUw/
         AbDeCUaQyUXlPEjtoJzKpny3RgC6FjWlOc4/9NLqjyFXcHEO+UozLjKv75PgkFHKWG5Y
         6GLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kDjXqP8m0kVACEIX1owlQEem0wUj0wazig15t7e9Pq4=;
        fh=QFGSg31SyHofVf30PelMWqLx9huUU5XRW2aZhIdnM1M=;
        b=XrzrHToJTB4eppKIh/GqOAmYB+ZwBd+voFEVBDMa3MZW2+/OLEJU/5sWOqPVX8xwUi
         n8t4mxdJp67xx9cz2XJ8Ij3XwRHmeTmNc0rwlM7buIabByY+qAy33Ywn/q9JOPTVlGJY
         OFXJmPVx4Z3R9wcfjNVHA8ruQsAbB5fLKdf9OKa8/fy8iOASqk6W7jpWi69elUaM2l+i
         faeHNjEjxDVW2snWAw0GM/n5RfD3MBRarKmm3doQCJv2Ix5HrEn+ffB4pMrg7gmKSZAZ
         eI4g8F47k6ih00gD5XJWs8XbUtOPV3yR2DWti2I7zRbqGIs8qp4AZi0b2KBb5AK53PTQ
         pORw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787150194; x=1787754994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kDjXqP8m0kVACEIX1owlQEem0wUj0wazig15t7e9Pq4=;
        b=SqJ2/s+dWe2M9kOOAXmLI8eGNrl5oJLx0ICFe+gnTR712n+Mfy1QU87mwWw4uEKlkI
         zhO/i2w1EAb6eoE9wVrhoiPg5Ls5tB+GoCW9U1m1zokeHkFqofkyeydnU25k5jzXg1zW
         PhnhDvpecfZOdIAj85pDtK+WiRrrbAgbWtkEKlIbuGDY3wReSB4ioji3CoEl1jTm2fPs
         fWyX/a6Gs/iDGfLX6rURjAQ/3hCkeFERfi4j8qVjAiKaNEOk00Q3lluRIzeS/g8i+hGU
         ngKhcbXrddiLuPaW6Oq+SVhBXuTCp1XNRnPrDicyt5AG3oWdEMzK1wQuK33Ye294IJmo
         pLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150194; x=1787754994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kDjXqP8m0kVACEIX1owlQEem0wUj0wazig15t7e9Pq4=;
        b=mRKAznViNjvZ9bbG6VE2wydjTNvaovTtkHe2/Y2V7wsxKxzVWfYvptzi2cMfxfcMpS
         bYf/Nhjh43Tug4ZOJ4dwLCbsu4cT1gWjI13miKr6Yrs7JvC6+BAFHr7z6SZosSoSq34X
         xjVD8FJEjQDf5YBbyLky3mIvuTgoa1Gw9IYJ+Rst3noExuvoLKieycRt6kbntkaQyQdt
         jHfMYmu6YK/TBxHfnQgtl3hhz98i2A2BuNOO+R58h948YsMJQ0EaCHVvzcpTP5MuFEmo
         X4udgC/W0MwtUtpnV3D/IrpKrkY2ml9S5bdXrseJ6RIrkNT7JP2Do1uGGJKZf9e1f6X5
         9CAA==
X-Forwarded-Encrypted: i=1; AHgh+RqNDGBcx8GwKZ8VeHRTzX2zZVgSIntYCZ0wxvis/ss87iADr7jP6hTrB4UqdZ8c1HersB+URjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zeyiNhSwT0IXSv5PMcaJ7vSLdbywS5TG9s8rvzqDGZe3F/y/
	+CYwiW86Y1UebsqkRaeHXMtbdG3sgutydk+0+YuDywlrV4ruFBreSWEfIDgFMbvcdIcQbHir4Ed
	O6JtCKSEoX7S/EaypKPuE8Iz5U/U1+RpNE/j0
X-Gm-Gg: AR+sD130/TtEQH0X9C6q7n4xZXshjJBPOjRxSwFOswWG8sMub+tGPp96TbP2Vau+7Wz
	N/uRuAjr1/WdQ422GzlAPZ50mg2dEg+S5J+ztB02RRkRmDFbbxTxOPudqbd7Y8LOUDeG0Nc5sYO
	lhw/sxVuufvaXy7x2H9+6316kLp+pejQX8PWwsbe1RqcK+fccO+Ie0SiXEew2Q72SR2JSGdulkf
	IiDaz00a1QmpHVOcJ1kUOCW1+C87nOVRSBjJKkeYLX8Grja3pB1DX1F1pTjwwBVsLd5Bkb1h2c+
	zVc9WOoCehVs7ydTbJxmBdeLH4Wcd4WLgzmXE4mit5qgVQ==
X-Received: by 2002:a17:907:d382:b0:c12:3059:4071 with SMTP id
 a640c23a62f3a-c242e21037cmr389133366b.15.1787150194142; Wed, 19 Aug 2026
 07:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817175859.2966055-1-coshi036@gmail.com> <20260819055219.GC326@lst.de>
In-Reply-To: <20260819055219.GC326@lst.de>
From: Chris S <coshi036@gmail.com>
Date: Wed, 19 Aug 2026 10:36:22 -0400
X-Gm-Features: AcwNN1WoGj_WrlxBwgGBkMOQVQx5sPpl7pnF5ffM10kKDwbOz4EwrE2E8ISW4EY
Message-ID: <CACd_6n2d3XF1YfRFjm50pjZD4N0D7nJ18iEOx5T=pK6TcW7FFQ@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: skip the zoned limits update if the zone info
 query failed
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, dlemoal@kernel.org, 
	joshi.k@samsung.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you so much!

Best,
Chao

On Wed, Aug 19, 2026 at 1:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
