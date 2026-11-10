Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794290504;
	b=ss3MxkJaXx3VIaCII24xrOmWMLLrNRkg5qCDQwuZ00rQKSpijxdiWt91cr9aTUYdiBNc
	 0RZft09XQstPHzVFbWpnrjQ6ksVVnl6BZ8fkbDrafUHq5KiFSnlyqV/19fM4Jf//LROpj
	 ORHQ4QoeXtVVIHxAwE227wKpVvvJjGFGhqamPiuwQ5hby2t2Q2ZQ+za52G19bRpjfu2sy
	 Zy8Xt+uo17sK4eSXDE403vec+ogARt0+4q6qNt2HDL8wPvs+RnQko75vXIveKGrmnSbby
	 O/HxyYcUpaqWCaNAG4N850+YZUTSaGNBibCMx7REaYXr4wM19zQdUU+egGz5RphrMYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290504;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=JmICRKQID+0ulQo3yfMRoaH0uyFxjYtLwmbQRsLy1kA=;
	b=wlEGgRalp/bNegK3LZswOHtljPnh5931jLUq6l7LStG86KozAq+/DYp96ZKOQa9hQR3W
	 5G+F74JuV9EuDKInL50DQHozQhXGPGgL11i7OWE6rsntryWOvhbR+nnwcCmCvqKIa+zQ4
	 9l621gz3dla1qj1BlR/AWgjTRb2+kMawPcnqCROuPiaEcwthXG+deX/zaCECrkH31BiGU
	 +DDoX+OZaViOEdvP9s/dniF0iZubYXHS1OoVK+6hjHuAlcTkc4S+EgDw5nEtQ3E02VHii
	 AfuOmfKZQiAhj1nj1luhMPtx099LiYY4F+IxUCG7uEiGacOuO7SDyqZZc7pGzElxJpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=C81mm3OD;
	arc=none smtp.remote-ip=115.124.30.101
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A5606A31C;
	Tue, 10 Nov 2026 06:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F37A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=C81mm3OD
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794290494; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JmICRKQID+0ulQo3yfMRoaH0uyFxjYtLwmbQRsLy1kA=;
	b=C81mm3ODPtW7jWMequR65auKje/UTnUUBiDmhUeveKsHonaFncoKFL7KlmaDs7o71xzo3eboapnVy6xdLEkGipwnsiLvkoTI7Uj8Tm/q6IdlJcIBPtq3StBGLu+nCH/lgsGzjv5M3jnUSpMsePf3ONpuly5qrSFMp3jvN/HXyns=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0XEUDAMA_1794290490;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XEUDAMA_1794290490 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 14:01:32 +0800
Message-ID: <cb36df5b-ef41-4a2b-b8a9-848d5c12e44c@linux.alibaba.com>
Date: Tue, 10 Nov 2026 14:01:29 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: vmscan: allow writeout of swapcache folios
 without anon mappings
To: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 axelrasmussen@google.com, baohua@kernel.org, baoquan.he@linux.dev,
 brauner@kernel.org, chrisl@kernel.org, david@kernel.org, hannes@cmpxchg.org,
 kasong@tencent.com, ljs@kernel.org, mhocko@kernel.org, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, shikemeng@huaweicloud.com, weixugc@google.com,
 willy@infradead.org, youngjun.park@lge.com, yuanchu@google.com
Cc: stable@vger.kernel.org, ryncsn@gmail.com
References: <20261106160432.2552507-1-nphamcs@gmail.com>
 <20261106160432.2552507-2-nphamcs@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261106160432.2552507-2-nphamcs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/7/26 12:04 AM, Nhat Pham wrote:
> Unfaulted zswap readahead folios can be dirty and in swapcache without
> an anonymous mapping. pageout() rejects them before swap_writeout(),
> so reclaim cannot write them out while their swap entries remain
> referenced.
> 
> Allow swapcache folios through the filesystem folio check. They already
> have swap entries and can use the existing swap writeout path. Anonymous
> folios outside swapcache have no mapping and already return PAGE_KEEP.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/sashiko-outbox-181078@kernel.org/
> Fixes: 84798514db50 ("mm: Remove swap_writepage() and shmem_writepage()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
