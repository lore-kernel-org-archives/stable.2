Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109978;
	b=4V+nQIe3A+ZNZdu7MAiHb4nLht4jnHBL4p3NfaXO2JwfdDiN7mBuiPqWUDqmAk8u1T2v
	 9kzlvHkQSo7ZXw+/V2hjEnS+EVSrxCQo7nqDOJaet3xiPE3Jj8195wFCm+8DgTrie9bjx
	 F3NkRXhwZ+bn9fjRLaMnF7LYuR5Df6ql864if567KFNk/yK5L114NT8H9NRNi+IH6V0tQ
	 TJ0XyMuw+CZ9bsM6dvU3YTv9IB7GzaX1j8rHDOVhI248+CsaXpMeNNBN2dvCLdLaomfwk
	 Zu24iKysNER+ae6zwIz4b9rZdyGNgLQxQYiNpH110W8O50rJ6XzwXNOpaUaLSIwnZIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=CcioC45MmLY3DkNK9gmi2R+KmuN+SF2m/a7+FcEpEKk=;
	b=koH9dWboIm0SAD3qULo2wRuxb/N/xpDJHQ1IjOckRv616r7Z4K4O2SJOfkj6Do7trY7F
	 ic4uf0H+pxmV22oo9lP8XQHGKw7jNCQcaOrZbCcAIgi8FcLwfthNO5mhUSs2SLGPoTLzP
	 xL6HXMuPVgqzXzfkj1bnD2PA2+rDGHX0dR8Duk1p5XOCEXf19sZrghI8tO9aie5ROkpIn
	 J6ui2zvdWUNpxJu8PNCXYuT9ifMSxpIuO2nbWRnGzjD/0bOsH3+nmCx9Mrvqfps8lxvae
	 s8KvOAeahhmcl+k87T6bU8SXDKW3MAoCt6dv9feFBriLkoVp/Dz8RArtB9eaiHPCrPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=WocpRbPS;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED816606A322
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED816606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=WocpRbPS
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-745497ac8fcso1758230137.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 07:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793109977; x=1793714777; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CcioC45MmLY3DkNK9gmi2R+KmuN+SF2m/a7+FcEpEKk=;
        b=WocpRbPSqHP+BacSU/D7X3AgNcwBTyKCSmQa1WiDzaZeb/i/7127ANs4AQKkrhDpj8
         sre2xom8UwklJb0Fuuk+38Ac1aNbTkJEwpaMNjuw/lRn49lXI9yAJuDIvoBzbQXkq+69
         BDfcgpBufrlBxtepqsCgYCDXFgsZqNVIKQG2cofamkjfl1KVq9n6ZJaSrL7qbhwz+J4M
         gO/E3ecD6ph1V1pFV/pybEZvGUxvw8tQj5nBIFB9zsljg19A4tN4oPRpKDjrTwAJBRHl
         ARuZ7aYO0XD8h13N67wpXKHOa2Efgjnc9yytKyWBmunOKcWT1TbMIDAbh/AQZIUTthuA
         LCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109977; x=1793714777;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcioC45MmLY3DkNK9gmi2R+KmuN+SF2m/a7+FcEpEKk=;
        b=Ai5m+5x5aVOeNQA7tOSR14boOZRCV0vuki9h8E4tQ3U/PQAmIJD05o7E/Fg6eSlLuI
         GfNiBT6x5HlF6JlyW2ZgOmFwNrPu3UwB33cfX0qB+fo79yDOuWD1UAPIwpgryxhE9TaN
         uT8TKMj4vJcck9FpesZFNilWxBP1R9pEvVTfRqUydk4bkFVSSsOGNSFa8qzn4juNKyLQ
         Ycpte+fj67Kq+P5bafRVRfhj7e/nwWDEwVQv2Cqw/OFeCFmZ6QDLnC1bJ7aVxb6SMOBF
         futDUyYfNQQQ6FGFKeaXdRzOF1eSNSOTYF04yCqhPDkJJ5pWiP+7B7+zYhQQ4qS8C5/D
         rvgw==
X-Forwarded-Encrypted: i=1; AKwUvBxMe0pGNqm4WOVIj+azw8lhkth3xNUy5xDV7bR+tWcM9B7HiJjzeoFRDlDo9sY+QmOG3Ei0hFM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5WI/g9901pzqzVw6WGVJ4trkIntc0cfaq8u2ToQxy+1q7dp29
	wGyDrD7VugMovlCfawFa66VuuJ0G/BsGr1fh+csyFkkSG+IAIsWqL4juk0glaMSstC4=
X-Gm-Gg: AYBFou2AfgsdGVuWnVTvJtV0eUFwyRhIOiJfw4EzzXpaXuMCBrENXaoaHU9n0VBoe58
	LPNpsX8Awd/4yOS4zoZ4v961G1E3NVJO3fThFWpFJt3VuqbPyuGG5e3pDhQMnI8lSLqsvfFw/vZ
	V8ZzNFF67Yp3hTP+uwPN2Ry2vnxf49NU5bDJLbqG7clOlf5I34AUNDnj8l5ohG/8bcu0cCAMzGS
	xycLvvQMYtNmoagaAenGxFKCsz6ef4WvdEo1EVRqDfzIa3FkUMBOs45twUQHiv0Ez82vzKo4uW/
	kRRAxxflXEipcPl+lsrDOHS19lLDiqwrfx9XB9y0OuaBRzW+VW3ySt5/VpgY5vnBCHlZiIZDjZT
	9yHOdd8hnhslrgkTYVov4XW7Vh1DqUzOugcpgP3MtpAcZSgTtgMwjNBWmfIPjpvpXnngaq4N39e
	gneTByeTW5A/vXmY30xNl92+OT9Ti7UoSiNvJ/X1e6SfJ6Ih+PUs3eBHD/attK+TPCem3Jn/DiO
	m7MSvZn3M+88S4foQvEALCgCI/bRIq9PfaVIvnMq7Cqoo2jtxToTy4EWyyCEHdyPUOn03TAKotG
	e8auw+KuPszG/0ouRDDuqjM6mi8=
X-Received: by 2002:a05:6102:14a3:b0:7cc:28a6:ee1c with SMTP id ada2fe7eead31-7ce5ca1e4bbmr3674778137.2.1793109976725;
        Tue, 27 Oct 2026 07:06:16 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd2110sm103733996d6.13.2026.10.27.07.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:06:15 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/6] mm/page_alloc: don't undo another isolation in
 alloc_contig_range
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
 kernel-team@meta.com, akpm@linux-foundation.org, vbabka@kernel.org, 
 surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev, 
 hannes@cmpxchg.org, ziy@nvidia.com, linmiaohe@huawei.com, 
 nao.horiguchi@gmail.com, ljs@kernel.org, liam@infradead.org, 
 rppt@kernel.org, osalvador@suse.de, muchun.song@linux.dev, 
 iamjoonsoo.kim@lge.com, anshuman.khandual@arm.com, stable@vger.kernel.org
In-Reply-To: <a4fc92b5-7d99-49f4-94ac-89fdee699042@kernel.org>
References: <20261027042204.3741307-1-gourry@gourry.net>
 <20261027042204.3741307-5-gourry@gourry.net>
 <a4fc92b5-7d99-49f4-94ac-89fdee699042@kernel.org>
Date: Tue, 27 Oct 2026 10:06:14 -0400
Message-Id: <179310997463.2232644.3260379218896917308.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 14:37 +0100, David Hildenbrand (Arm) wrote:
> On 10/27/26 05:22, Gregory Price (Meta) wrote:
> 
> We have an existing AI fix for that as well already handled by Vlasta.
> 
> I think we'll have to establish some model of "ask David first before posting"
> because otherwise we just create duplicate work for everyone.
> 

Yeah, this is going to happen more.

I've been sitting in these patches for over a month while they soaked on
hardware getting performance tests.  

Maybe worth a private tree we can rebase on regularly for these kinds of
un-vetted/posted fixes to see what's coming?

-- 
~Gregory

