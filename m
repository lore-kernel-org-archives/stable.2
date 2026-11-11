Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361721;
	b=BCp+7dKQkFUiKf4+etZZu6DZjYCEx0QmVY5o+QLs2977NJuoOKT/3zK33loLb7KJ9g6o
	 oy4Kqd4lhizZ6hq/WvcietwwCld+ydkqrZSlPLtY20SoIvRf1ZyIPW7kye+XlsYY60tt7
	 0ml60iRE4VUxu82D19KSsSEDWGlRwd1KNV78YwwNJOhYT70LB7fs/E+Qu6FjU9XKpBViN
	 jTZ4wJXvOFDiUejaYi1Ymck2QHYiJrkN+jQxUdkEGHRs5gZjeiFaWDXREu2MtF2I8OwaV
	 JFTynC1WK0pa0fDjaHi1DXNYey4TVL+bQepH4bdmR9OGajMKgulraM7jpQzv+zDj3wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=f2RcHe64LeB/gnyTEhJrBfe4ypF50Xcw5AhrrNUhpVI=;
	b=4c9XBkJA0dgSvWJt3uomDHOmWv+WnGHeh1mdtbZZtwwpbnEclVetaz4vGAHR8YY1j0N/
	 nW0imwyOyglvAGfAGZsY3652CcgFa+rDlnCVl4tAj1ZBxKvUYEKulU2yFXf9OptN07sYy
	 BIlnT+e5H6C54QTTXnzyV+32p9a35laPcnwI4XoEX3P+6Z5VP9IEN6RFNPIoyX3qwcME3
	 34A4GcbATvn3w6LlSL0PcSjpJ+NfL/fcEwvHobUFwL0mn/N+IafMPJ3ioUl9zaoa/6+Ce
	 9sVZBWnA5LTy4X5wETd4WN3hnbaWxTsYBpTwrS1d94j3EucyCt+d5DuKTBCA73Cjs5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QpvXFC4q;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE9C606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEE9C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QpvXFC4q
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36e795af1d4so2262449eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794361720; x=1794966520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f2RcHe64LeB/gnyTEhJrBfe4ypF50Xcw5AhrrNUhpVI=;
        b=QpvXFC4qN5QJ0p8bI9c4XT2xJMP9QqQnJRrb0+E/4FPOEtQGqIfdwyAgZzZxp3+Qd2
         FMYtqpTjXuJAv7hM5VrDk0oByO4JH83W4qEkAk4lhzJr0y/qFfPhb8DorPMstZwwLw9E
         w61I9WaiAaxGBAokVOV8TmRg8wzzQuekBMpLbmACyn/bbxt5pfN9e5sEkS4drpyAjcvx
         wm5BNfYHeyHleflpj16Tw0cgsr+1RQOPs7sfyUkPesdAftEpm1lDeuaoFEgsSad9LGVG
         y1JzZTlGKsz58h/un9DcNxBRjfB4or4dJpX4dvd9qoI320is2XHFOJ40+/hfk3QDcelm
         MxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794361720; x=1794966520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f2RcHe64LeB/gnyTEhJrBfe4ypF50Xcw5AhrrNUhpVI=;
        b=dW+zMka7/Mco2/og57MdX2fIqZi8GyWg8kGUYOPNtmDSp1lrNazVFwoMcuw3OBn2+J
         Bxysteot5OT73utJ+HQlSzEjp+3bxcaI0b1F9npSkn53pkW4Q0wEnBKpoD8+POTXYHRT
         6HhlgOq1Jo9qJryBcLvEv9tWyBqcpqZAoPH86VceThz37ZvvrQ6Z8os3Yv3BTNCUe8uC
         BB362pG6c0MZF3Wqu69gZWNluXjMo9juYWVb/e0TFk3ThrOnHFK+x/CLUgLouuVYQmZD
         ICbcBRYjpf2oY0P2nvIzRoZqdulwN2zwkNnCdnFamoGzyIx/LXhStKwHwOPMvFN4QM+e
         EM7A==
X-Forwarded-Encrypted: i=1; AL+hErH6tluBNOiYGuXgPrn9PxS17YgjniaAbBZ2k4KRAZsJleeP+2IXYbCIdDPDxJLv8HB9dloNkVI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uGz/Bs3CqeJ/sspxxLVyJKYUQSG2evuxXuReeFrqX+CrEz/cK
	ucStzjf+WfStF7ed65Q4G/ODFPk09h5WzXnJJlFt9G0JCwM/RM7jkjnU
X-Gm-Gg: AYBFou2xdFaod4zycjxwgqguXRssOgVDf7V9KuOT25Emi4tIccdcRZeVdbyhU1tFmyq
	9QhMnJeLWqqFMF9cRquBnCViDC0PaNdLxGuXL1zl/h6xAlVXLqT0gqMQntzl2gBx7dcVjzXRNcs
	jatHQEWlB/Bzk72MKTszPUih57O9ruO91RTLTT9MGmEqZotByk481l/JqoJTMFNrsLlaAgjB3P5
	1H2Uv5qgq0mr+X1OA6XxXovU6pakyfFqEZVc6DwlVYSYa2CT/e9zSDSlqmU2RVhwnKvC69tUwfV
	I61w6jh7EkttwclmiiREX7xdYkJUPV2TDcO1o6Hn29jStxnb+5NvMq308y0abXtqylE3qgsM6CS
	y56/Vzw5qGTOv3j9BYz7iEsWmwCQs0D/0+6Fo38Cc7RnIC3TGfXJP/8h9rxHQFGtJbG57x5MRsU
	zfvoAfdbU4/XFNhBTHBEyzTUiSNQFOdl1181iimWxVMxyQ0gAk3MGH28tSpUn11ks9q9KpuLi4K
	JvyPCHwK1BmG2Qcw4nmvs8D/DPKWnOKA9W/cfLRrsgFYEUFTaHzLU4TuEa7ZInWZPl9iAzkS0JB
	wrMOo3qwTWFjouFfhP4O4WpCj540BisvUkHk+Zq8fqO6qG4=
X-Received: by 2002:a05:7301:e22:b0:36a:37:1404 with SMTP id 5a478bee46e88-37686d2fcd4mr1959136eec.13.1794361719645;
        Tue, 10 Nov 2026 17:48:39 -0800 (PST)
Received: from zhangbo56-PC.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e76e2sm11902533eec.24.2026.11.10.17.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 17:48:39 -0800 (PST)
From: Bo Zhang <zhangbo0325@gmail.com>
X-Google-Original-From: Bo Zhang <zhangbo56@xiaomi.com>
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hui Zhu <hui.zhu@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Yu Zhao <yuzhao@google.com>,
	Kairui Song <kasong@tencent.com>,
	Hui Zhu <zhuhui@kylinos.cn>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/mglru: fix a no-op lru_gen_clear_refs() call in lru_lazyfree()
Date: Wed, 11 Nov 2026 09:48:33 +0800
Message-Id: <20261111014833.2661236-1-zhangbo56@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAGsJ_4ybXskWKDLHkeeuVGirGaaZ8TdPEDX+xQXZcYmPMSjS=A@mail.gmail.com>
References: <CAGsJ_4ybXskWKDLHkeeuVGirGaaZ8TdPEDX+xQXZcYmPMSjS=A@mail.gmail.com>
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

On Mon, Nov 9, 2026 at 1:08 PM Barry Song <baohua@kernel.org> wrote:
> However, real-world workload data would be helpful
> to demonstrate the actual performance impact and make
> the case more convincing.
>
> The patch itself makes a lot of sense in theory, though.
>
> I'll arrange some tests with Android workloads and report
> back once the data is available. If Hui already has some
> data, it would be great if he could share it as well.

Tested on a Xiaomi phone (android16-6.12 GKI with this fix backported,
MGLRU enabled). The workload launches and scrolls 26 common apps for
5 rounds; each run produces ~7-9M MADV_FREE pages. 3 runs per kernel,
same system image, same sequence (fresh boot, then back-to-back), only
the kernel differs:

                            without fix   with fix
  workingset_refault_file      44.7M        29.0M   (-35%)
  pgmajfault                   13.9M         9.0M   (-35%)
  pgsteal (kswapd+direct)     100.9M        75.6M   (-25%)
  cold launch (avg)           2436ms       2034ms   (-17%)

Without the fix, lazyfree folios keep their stale refs/PG_workingset
and get protected instead of evicted. Since they sit on the file LRU,
page cache is reclaimed in their place, which shows up as more file
refaults and major faults.

Tested-by: Bo Zhang <zhangbo56@xiaomi.com>
