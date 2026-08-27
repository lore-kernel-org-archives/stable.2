Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C42F6586
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787793285; cv=none; b=PU9wYzZjFVBCFMIdUNHZsuJdgJf/rHxI/ZEZ3/zd5M5nMEkcF9aOTATyU6OSPTLBa17mChjwjxYapDXs8iiRFYnF4ps4toF55U2iuFNDsi0c6kjZQUSYE2XqurulQWa8F96ffSJzAyeiDJwCYX0qK+mXMvc66pL73tAurY8waRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787793285; c=relaxed/simple;
	bh=NBuM7Z8qJAkYuoJEbItk8rVmqNQCo+qHFYrg0x2wOxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5b2GimV9FsHoGcB/dEKtdpBxHDg7ALHahMcg19VbauvtPqC53ELCFBHYL1luYoCVJp/beDaVWwFAiAYp2/cbBTK6LYvZbD7O/3vSodvVAuVgp9A9rSWbvyJD+rZZz/wL5nMXJzMk8aMkujuLcz7Is2wB81azkC0p87EwgZ0laU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3AgovGt; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3AgovGt"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1965912a91.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 18:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787793283; x=1788398083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBuM7Z8qJAkYuoJEbItk8rVmqNQCo+qHFYrg0x2wOxk=;
        b=N3AgovGtE9a0FM6k1D9Z0Mqy5BbLhs7cDn9YJaPp/kCN9grQdyxmRfBPsYHnxUSMEw
         LmKE62+YO0t4Nl1MPDeFUVWXF0W2K7frcGLGQqij9ELdNmkpTpD+KdCnjgBFJkmRx6L+
         I93lOezFDNFa8TEHtfJ95tLFCom9TPZoXCbBDvvCHtGf/Et0o7hJbXSILwLWmjHgUwKy
         RXGFj74ahisT41Vr0iehUg1Fslrw9Hd5f9CZjb0cdkasbPOKvWs0TpYPdvPG/ycKiMRg
         SMJj2a+FLtvjUwBCXeiNe6d8gJCihOrr0tBlCSe/bZhks9GAvTdekaqNok8MtQmfrCTG
         ctCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787793283; x=1788398083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NBuM7Z8qJAkYuoJEbItk8rVmqNQCo+qHFYrg0x2wOxk=;
        b=gGuPZ8VBFAgZmIsRx5mnbtrs1cjGctKpMq94KppaArqtc1my0UV4iiqXqEbcvVaPwH
         8nRK1oiZLEyfUE8WId9SNvrmU08KwDTxtmpQUCTjQ9MhzVKx/l8xkaqikJRlKsrKhb8/
         iRsNmdybC+kzMeiTc+ZW+MH4fGJ/FeHzpW/1xOn/OFzcLMz4kaD4UcGH+F5p0H89EklZ
         2yGUFtj+sEk9q+/C6s3DfrN3xTD3KPj3yU5OwdJWPhWBXvk8DDnCCgbnhvKE6HNApIxM
         imPclrCUQ3prADIM0G328VviZotFp2l4xlWPUiYnyLmL2BfxSf3N8oQ+LcEVSmWoezNp
         T3Pg==
X-Forwarded-Encrypted: i=1; AHgh+RrF0BPugV+2XH5Lb4LZyUeWYFFn2mgXlICLGsnnVDNOL/fSSqhm0Bjno2+VI3zD9Qk627tT6Vo=@vger.kernel.org
X-Gm-Message-State: AFuF++lLaOzppjQ3Q9gbiuUbPUOSq0tkWHWOK3FHX89pf6ZjcAci05Rf
	okUEMiV7UiiZ950OAPXhDY6kg5m076CU4DOKZjgutfT2r8TtXBGMkiIx
X-Gm-Gg: AR+sD10sF8Ks34wWmgGQkkpaHzkfyyrzMzw+KIq9K3yOu9djBCotrrgSeATehtrkg25
	PJVDOMbBx5gKHcIaKcj41/Erw4bHhZesLk6TqMtRda8BnjDMbFerEp+dZ6fH+B7bEnV0h1Wl+sc
	+pxGRjS7ZW6ewkT7R2n/+PKD1ScWJqCdzjeKHwiPh2xtaY73y+VK9beWNBFqqTJcdx14TdaZJiL
	n84+42AwEkia5MITIu+yC8xlHlMoJ3MzJki0V17dIXpTol89BNkDim1ribxVYGjd0GhSjRiOeZi
	AsaDUO0O/ZPs9wKNhL3JiU+Lm4uah0dL+GB5kQJMIF0awfscM2iRmQZ7trxD7y53ygMKsnbJgVd
	h5CW4yDja6Qptqb7MMX4i2XvV5CWKhr8e1GYJWXmz5q6rOItfwtBTf1uj2ocmmABMtb6z6sqbXv
	pqMYLkkOHvwf59eD3gc8ZTpYqvrqrrZUYeabC35GeFFfr/PuTuC1pQJ66dtq/nKqBe4pop+a+Q
X-Received: by 2002:a17:90a:e70f:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-3966d4587b7mr23563979a91.12.1787793283407;
        Wed, 26 Aug 2026 18:14:43 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd5c34sm461051a91.8.2026.08.26.18.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 18:14:42 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hagen Paul Pfeifer <hagen@jauu.net>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/secretmem: properly account locked pages
Date: Thu, 27 Aug 2026 10:14:29 +0900
Message-ID: <20260827011429.1516473-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260826-secretmem-accounting-v3-1-94cb04399510@kernel.org>
References: <20260826-secretmem-accounting-v3-1-94cb04399510@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

I tested the exact v3 from this Message-ID on its stated base with an x86_64
KASAN kernel. The supplied selftest passed 5/5 in three boots. My independent
accounting-boundary and capability/delegation suites also passed in three
boots each, with no patch-attributable KASAN report, warning, Oops, or panic.

The independent suites retain the mlock-limit and fd-delegation coverage
removed from the supplied selftest in v3. This tag applies to the v3 fix; I
will treat the planned separate upstream selftest patch independently.

Tested-by: Daehyeon Ko <4ncienth@gmail.com>

Thanks,
Daehyeon
