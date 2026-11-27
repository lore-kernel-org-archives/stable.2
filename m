Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773903;
	b=XeQHjA6dpjyzi20W+QHCY14UR6uWs6gOXFkXvlLPqv7mUdy0CqiCYQpWZwX7HrjRWcEC
	 emvZCxyzRi7a2Kxa7CHY+wLy4DXy8DP4ui6Xdtg6JJBJVc0F7LRGucm7V3gz7xO8sCXrp
	 rcwu1evLzMA6tNgz9EjxYiNj3ApNtjJixdTpkcFyfIM8x+VRPWnkn0wZkEd6BOdjMDYYb
	 DqHhwBcn1gxz+PVwnsgV3n1hDMvuX9pssq8y4vVID1PZZIe5juioX2iL3Vww3UKtFNe1m
	 G1IoHFhmd1tRNAbbGax8r2WeMH/d0tWh5DWpvNg2hdTqnOrvS935VR6ZKyCm4VzWqrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6LNt6LCYfisU+3PUtDqGPrc6AXpiMExriMvsMZPkWPo=;
	b=lB4LxvzG2Sy+/MOMZV+JtdJkvzeFzcBWQplbam4dh81KhXdGOtf5WCDihPxzhhRTzYgx
	 /rc+YcHNceqzU/5Im02exJTlwM8nfGkOX47xl+kkbV4Lk88I6QMwhJXoS3AEtXz0Pl/XZ
	 rQhWCBuewWMWP6kzzjqWHMKab0B9q6T2m+e66gaq4YO/k8XJgocKnLyfepvWeZsSn6H6v
	 DWR0iE/4vudnmpWgVFT9Iw2w5g8/6r0O9UY0CSID9ZMBa71tcNBTT08tNO6U8ONDtlh/K
	 IZ85jvs3qTZbEZ6/fyEiFocv3meIZl5cLL2ZLAPrrh048WrgyC3/LOpHwwlXoAG1ZOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Ij3OBjgG;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652AE606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 652AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Ij3OBjgG
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b4d86f5328so52073687b3.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 02:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795773902; x=1796378702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6LNt6LCYfisU+3PUtDqGPrc6AXpiMExriMvsMZPkWPo=;
        b=Ij3OBjgGvdsYsaMFenIVx83KMXTYHdXbxYVhOn2SmApDjpV7OsNoiCmskMVgCRqt+h
         5Y6IP5QxOnpdNQLhwWfAed9km5jncqo0jqNDNd5Ck5+mdsmAZksgTF5Ksd000G6IYNJM
         HbngFgL+CHPUrYhbIN5CNoiRZor+cQsbEGP2uR+ouOgCYX2hhoXpQNFHH1RapK64zJWp
         o+vA+hiPhfe5pSMucQzdT5max9zFYv/7sIg1+tr0fGTQW5OtRtOEenecMqAKI6CxVBUv
         IwS1Ew6pzlXMq8BRq9GJRA6GGheRsGdPXhowSfxx317vaY4XFVxdPQvjhWxi51hYwUjY
         44OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795773902; x=1796378702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6LNt6LCYfisU+3PUtDqGPrc6AXpiMExriMvsMZPkWPo=;
        b=VyG27cXwaeRd1nwrsngJbv5b2VzrkeU0LhLZaM6Gkj3N6JUQd9qnUBtGECQY+8GeSN
         VKh/IbEtHb+WjLoa/jlWVL97N34TLjAeFclEW6S/vQH1cDyrHlVfM5BobslxmRECgEdC
         Eb69tL2GOkhPR42K3rKrCFVLDPm/oH5Ko7pYMZbr7Nd9C9vdz+N5hkU4ow+NMvlhg3yF
         6revZdOjV96Rg69IN4m7ylJLPuqMb6i5yvt28BEGd8rSpnpDCNgFu7PbNOP/lVhIGi8F
         DZL8R8U2GyZe/J7zRk6K0xkr3dSyXzjTFclQLBLEs4S8rbmh7k8UmYNSBKq9s8fPolUX
         saFg==
X-Forwarded-Encrypted: i=1; AL+hErEQM66hnOFybbbuA5/8LpUCJFgVyrV1uozD0N8DFRdlI71R1XTs7swaT3VzKZRmO7gzMoivKu8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8M54+PpoAHPYPCZqleYKopmSkY2NiK1969h6W8mRcio529kNY2
	+eIcO0ZTOjFNpEMwwRQq87Ah/2SnVxySq8hGJPY9WV4Gzn2uM2G06qyQGhC4zLFoJw==
X-Gm-Gg: AZFdTZeR7VOBroGQUrCMsF1VGuotQCkCKmaaL6a6jHcDNaAEHZPdR2njFV+dgOjg3qO
	zTrNeJTGfFJJzYAHiJ4wVhWnr3nSJXSkeSKEBbmJdPaHVmk/eqGGgQzZhQJddRk6FNwJed0T0sd
	tvju/fzs/jkXrpONTi/hF5REBVvwsG8uA6XVe+LFY3zI7LTMBkGlbmWXa9fB9nTfc34JiQF96Bf
	dj6avY3qN06/EvKQ/OlRHkqOsgX+iEzHMzY1OsW+Y+ApFAAj8pEEmGRu/f3ntIrV3iOxwvMBykf
	x8KTSVULrKiaYc4qe+iUF3EDOvmrcGOOZcSjoLa8+16/PSo6GAEmMKLs44gCHFb2TdgCL10/y+d
	76kkvSn/hIKDxyq++neQ85qwcXmWGG0UkG8lN+t7e9htOkjjCxrwM/m3UvxTLLQUfMANIX6UF50
	MUadM274u62FrhbyDuXZsAfOcgE061yIG1pCxBT4kUPBkRcw43x7L5lQndqEBW77l1jSkSwEesy
	RCBbrVHRJc+e+sAfLvENQh6c/99fzo22EW/5wLDIx26HM5ZQbEsJXFKEmS+bhhTnrt7h952qNcB
	X7D/NxNir8nVXJIIlN/kYG4LBf9wTLdiPDLGshPFQfw1uCWtPUwkgQsTgAvDpPSvOV2JorZWRQ=
	=
X-Received: by 2002:a05:690c:45c5:b0:8b4:d882:49d6 with SMTP id 00721157ae682-8b5201f68edmr98152497b3.0.1795773902358;
        Fri, 27 Nov 2026 02:05:02 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52028c802sm94799507b3.11.2026.11.27.02.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:05:01 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: David Hildenbrand <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/gup: fault in ranges that start at address 0
Date: Fri, 27 Nov 2026 05:04:57 -0500
Message-ID: <20261127100457.1388226-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f5ff8f43-c75c-4b19-b683-fdff0c6dd7ae@kernel.org>
References: <20261125173202.3636133-1-hengyul@cs.unc.edu> <f5ff8f43-c75c-4b19-b683-fdff0c6dd7ae@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

On Wed, 25 Nov 2026 at 23:51, David Hildenbrand (Arm) <david@kernel.org> wrote:
> Okay, but you did not actually run into this yourself, right?

No. I found it while comparing the behavior of different kernel
versions, and I don't know of an application that hits it.

> Likely this is "nobody cares" and we don't need CC stable.

Agreed, I will drop the stable Cc.

>  	/* Stop once we overflow to 0. */
> These comments are not really correct anymore. We don't stop once we overflow to
> 0 anymore.
>
> Likely we want to be more careful when calcualting+handling end instead.

Something like this, in all three functions?

	unsigned long end, cur;
	...
	/* Page-aligned end of the range, 0 if it reaches the top. */
	if (check_add_overflow(start, size, &end))
		end = 0;
	else
		end = PAGE_ALIGN(end);

	for (cur = start; cur != end; cur = PAGE_ALIGN_DOWN(cur + PAGE_SIZE))
		...

A range at address 0 is then handled like any other, and the loop
still stops at the top of the address space. This is close to what
the code did before a7797e74bd39.

If that is what you had in mind, I will send a v2 like this.

Thanks,
Hengyu
