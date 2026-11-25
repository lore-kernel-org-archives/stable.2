Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647527;
	b=OS7UFLx1HNKFDSNnTIleamcYpw+SDvJ4mSPTWM/1gmC6aS2U8qLw7STghBL6pNhMi8LR
	 LWAZ4/9f9ET/pQQKzL0a1eFh1gR7vaSZNA1i4rtbiqGwsIIReN/dmV9dNGSpgsdhch8n7
	 bjTRXcEn17N97rUkjKMLZTODVmsj5axSXtewQcgOQHdsDJp7V3GAx9g2nWvKbDBVes64q
	 9SUtIpskkhdcVdf0aII+r/SY+yCSOqOTYma/u3quqh81300Hhkg8ARbJBAGTdGitZ+kDy
	 gEIGXL9jaaoF+5wbkQqGoFhqk4attBsf88z+h0cU1LynKqjgsvZ/6ScwbZ2lx+hWj9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=bifZaCO4TaTv8tA7DvDvwVwTAzZVHPafBMZMdjCezBc=;
	b=VgCunfGF76NiWvQZif8YALfmoRIrG45TAxCpPQ86p1SPtfd7fMexzedSBHav0M6qZKcK
	 V5zrYi4UdYaeTxXKe2qM+H3NX/Gul6ewfDfM/sw8RVwhs8NESdjDR6NE1+PhMYRsGo3el
	 Xv6nw6b1ACUNz0wWDoLN6Occlha2AvPE7SSqvP4jslUkVSbMHu5TGkeKu4ZKn786apDkV
	 c+TjHHa7z0pyRlH7ji1ZxPIP6cy7wNWCQaqm9tnCOoSkIcPTk7MVM/pwIwXVdn9mOufJN
	 8jxalJQdL7nqaWQcXRmH9FwDc1okCE44/jMAls2+ezlGtI+s9jnLoLzmAquDGzw00Yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k4eu7cVD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB19606A339
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FB19606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k4eu7cVD
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so1787907241.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:58:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795647526; cv=none;
        d=google.com; s=arc-20260327;
        b=C8LdGQotNnTtzqVkvjMAOdCHtetfRet9QiYQJiXWIHUDLY+C/TNYRspyCp3yzpJZrg
         j20Maa4W4rclcjouN+svGvxqYZwEwwySmvhBDpKUrx4Fb7e9p6d6MztQV9m6meaASWH7
         XdlVqEQqlFvqkn+sB5SRKd2vkWN9Bpvbx8F3ROtzRQn4PAwSBRkpSOA2/qvNSh9n1sfT
         3dEbveZryd0y46Hd/9orx4CFd4XlNE/RjAxb4KxiQi17V4hVmBiksjoCphxBQPytVqn7
         2KYXnvqZffXwUlAE6NAUI6GfEo86+dItIDAAAIHbKoD/NUtW1Ores/op+p1YYruoVSXF
         gLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bifZaCO4TaTv8tA7DvDvwVwTAzZVHPafBMZMdjCezBc=;
        fh=tX9zzkSEDhYt9iIWgJOj83hqscrJZNzQSJ+Myoaci30=;
        b=Ww+j1Y7ZTdw0ZD7q0GU71lv79/vuPomV7gMLVBp/WE0lw09EBIPXbQLCKnLx3iRTd8
         /YAM3IB7WKzzW7sUkluOEWBSRD5Ei0tODyAJyyWGGb8N3gTV2LFk0BcznAVFBzw0TgMH
         YzryWZQHcdEIfgvB11C96KdJOMwtubDi9jPpzQQDNCq5f/LaHqP6ekOhUtNRSmULmN+x
         /l0RjgJY0RMvVOZEQTJCqRiT+cy9hLosDaBUZV5+r54nGS17YrvLsqw/ajIyoyi+pkjr
         N9Frma0eOxU6iMyc68sOn8eSnbHeA9JWQS8EYv5r+IoDKhczCjWazcFc55XTA5Q7pUvI
         DbkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795647526; x=1796252326; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bifZaCO4TaTv8tA7DvDvwVwTAzZVHPafBMZMdjCezBc=;
        b=k4eu7cVDKPuTDA5873q5wq2f0EvT7ngxFl0uH3lBtrrRUvLbnueSHzMjPYkUH4T8U5
         XD/T6b94JD/2sTUSXsJRqREI5Mj4dNhQrxuw/AZTv4f1vQx99uCF2CrvdHFUARqWWb3O
         mZIDbStDBCi2l9ZvoUaWCVQylgiisSr8xsWocpGSND9+Dr4ddIR8aKKfR9yjH5Ub3148
         7dxUI/taty5stf0aS+x1j0IM1heL0WrdYEv+EThg7uE77JuwRDCooJNbZrLtCAut9ON4
         SNcbzsy+OfvwmEaIsDZm5A8Eu+PdySwbqLSlynFFmkLTmFgpUjXDGvbWHzzafHd9IwkC
         +//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795647526; x=1796252326;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bifZaCO4TaTv8tA7DvDvwVwTAzZVHPafBMZMdjCezBc=;
        b=bZpAakwLngdzzhxP/VeVYhF7dgBmehFRAnzt8/TJajsonKyPvvWeOp3PnJXbKlxH0Z
         dZuytRuuangGwdvuTCBfzZRQzIjHAd6in0GAb7aOCqmKcuNT28TVRF+z4qIQOtZJudQW
         bxb2aWpGahLgH73xUOxYGmjEBhTXFKIhKMKduK7FwCs27tN1JbyDRV9NqYuQKKVBLNkM
         s9lQih2TsIu+7hl2THtPBtZuNeZew7c+nLJdTvzJRUmgVrICfSmUXcUPjGQV8DdmPWRo
         kqbFSlAEcMiA/Z8b8gXvJNAvyByu6XEJElnwBA1rr4xPCgb2CrFpTFAfvy6yxNpzXw3Z
         9ujw==
X-Forwarded-Encrypted: i=1; AL+hErFj0bO4P79OaP+6OK5TwBqx8sOSMrbfHv8anL90YqmCjTbqpQfvFX3PlCrYZ/4kThkNBpfQiTM=@vger.kernel.org
X-Gm-Message-State: APuU4Z953A0P446W9iQ3RS89z4wfXyC7a33m7A4TArOHXqsH+4PXNLyp
	sVq0rEJ7HWhXotK4+yEJACyk8PvXMSGqCR+q7xUZwgTJ/ubU6BzqLaZm6PnbUwzc+HeOdauwpX+
	keDf1chzssoh59hThjjdTO7tFWsH9GG158gAA3quw
X-Gm-Gg: AZFdTZebCQgrHdYv6Df08PNy/X8TsEnTVhrmS9rFi1go/Gf6wMQi0+7p7eMyHQOCwcT
	Z9xaJidIjXdq5+AFxCIJ5kSyTh6hLnoTTA59F0wTVIYn8sSr/W3hVJELyRmLIDrHWg17dvhGbD/
	OV4evSJdVIR1ufvTH0qUDWVgGxs1XzTCgwv+3EY4jheEoU5/U54P7yfaZ7yfGGnsHFdPBFPCnge
	H8rjygrmOMLyMpOSxUfMRX6J8JkSqa+cc6PDVdiqAutKC0uWsJ1xKh2xh3At1SZDop/8K1uV+Mu
	re2v89afR+v8+CA3DkbX1zuXK6gahMxoPPsXEim9m408Ygu9QYXupiBU1+oZTnM0T4SWH7gIsC1
	zpl6h1LtVpcExMf1gXp5XKNH+tTJDMEzB/2VHQS8kV03nVMhF8S1ofyxGTWBnafslOYs=
X-Received: by 2002:a05:6102:c4b:b0:7cc:174b:f7bc with SMTP id
 ada2fe7eead31-7d7397267a8mr10844584137.15.1795647525632; Wed, 25 Nov 2026
 14:58:45 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125222713.1450385-1-elkin@google.com> <16ad231f-0cba-40a0-992a-a0d430da5a91@kernel.org>
In-Reply-To: <16ad231f-0cba-40a0-992a-a0d430da5a91@kernel.org>
From: Elkin Cruz <elkin@google.com>
Date: Wed, 25 Nov 2026 14:58:34 -0800
X-Gm-Features: Aa3M54rX82vBgzUZ__ab0jzhalBL3zfUm3mwj2OyMozxs06Jy0Mm2mHqwLtG9LM
Message-ID: <CAC_6YktiaVRXr3jbfx1ybhhxzHbO4NyMnseg9CLL5CNJgYbCvw@mail.gmail.com>
Subject: Re: [PATCH] mm/migrate_device: use locked folio in migrate_device_{range,pfns}()
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org, 
	Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	irogers@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Before you send any more: if you cannot reproduce it in the tree, don't report it.

As with the previous report, this one is just a hardening patch on a
theoretical case.

Please ignore this patch.

Thanks again for the feedback!!
Elkin
