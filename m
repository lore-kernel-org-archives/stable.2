Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242D21C84DC
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787444692; cv=none; b=KxLNjnuC3/2ASrPMtocVGhuXNFW5UlPQJN3X2Q5+p4xLODY4KYJMWvK3EnD6m6Okp2/lVRu4/x+EvAzSkS0KvKX/+IVbMjy2ZGt2D9WUy3EE9hF/cpGoHRJ3BzWqh46AxtEnZgDjW8mOcNP32psW17CQ57Pug6sFPIuAqq4jMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787444692; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwkP3iERhTgI5EC2k2K1vskJpHoMsjLk1Ge035zVp8OjQ/wYcizgzDt7HVRnwlevgtE83HbeED9ACso/OAxEUGn1tSHjdu0CVFJt52GEofYTznIGI1pBzQV4eCqKpfeQXJMnBETMT+pi0HOVEkSEz6x1mJpkgGFPiU5Z322u2Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1c26d7e951so329079466b.0
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 17:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787444689; x=1788049489;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=aOwX1ebBsS4JdD0WJcemLopUeFt1dC6bCmejFFOawtCkVbKlohXXfYvZ1976wDqDLt
         qgcfUfIF33nQmFtk1i/k3+KGXS+BInP6xC/2I/COOZX4PTKiRfiNQaPbi5V35MRMy79t
         2pOcFh7NARL3OsiD/6kZczJJWXQDImLiOUf8fagQf1ZZgU87pTKdLF4mg33omuJK62GS
         auaxxX4/xdvpr06bgQEldZH4h0BKRYMUp0JdIkfnnIYUMlip6TadoZFhx6bCp0HsDaUU
         dVeus1t+EfbyUxWf/LyjzC7bKSkr3/WmExNTXFeeET8KRk430UiZaN1Wqu2JdSc44GEk
         zbXg==
X-Forwarded-Encrypted: i=1; AHgh+RovZ19Ct5bSP263LYIw21KLnYUMzR1zsLRykoN1ITZmf3FNlIUeVd4hJ0Abio7wzaVKSqsohbM=@vger.kernel.org
X-Gm-Message-State: AFuF++lPKTG08vvZMVj0KMJqFqYq3fOoMae7bj+T4kcIT/pibxPHWdQ4
	LAaJ7e0urqXRcJTMLjoGUtcY+t12tnhdhJ4RbqvCV6ozIemkcYh/bTst
X-Gm-Gg: AR+sD10ZmYcXuLiIDj1REFQqC9+0TfyQ8YDJdWKfTD1RhiJtGa2v+jLsgsXxVgvbCza
	bU+Vz7BsZPxaaBeDKwQrPkwRqsMvmGFcmcrXOBeyVc/n9rImNK7Z51wU/4RHDdVftI1uu2SLMtz
	Fd6pmivRY/uFwRcBsGQP76agCjAG/RRIjGkAe7tWtGElUwGyPynJ9s3sRYfdW5HmMqzooi0kxnI
	cBGaTLfq/TPkq/v/X8xne7YigV5x/5V2FsWNxPX1PYwemWVVLdc4NvdxdZwCuAxzxt8fobv664C
	f1VXng47oaa9ukM9Z1Xc1wFKtrhIX/VPa2vSIePps0IgcXGCj+Uued5us/tvuQREw4zDhJ1MzuV
	VHuvwbAaWdYE2vo5Vve1fm2joCM9YD2v0WVd90dLxbMxG9moVNzjjbU20AbBJ0VWT+HsXwolA4w
	l603VDuD2/Xm2OyUOIOAw1H7fxlrYQRsNROs0Wnn6fLsC5ThVtD9NNxwqlOJhy83o9265SkRNOz
	UG987oXgNOyP81l7vPNBGk=
X-Received: by 2002:a17:907:8b8a:b0:c05:b9db:68cc with SMTP id a640c23a62f3a-c2469f7b668mr1795736066b.0.1787444689196;
        Sat, 22 Aug 2026 17:24:49 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962a3c13sm578040866b.26.2026.08.22.17.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:24:48 -0700 (PDT)
Message-ID: <1c876ab3-e0ec-4c03-bb06-1f67dc4383fa@grimberg.me>
Date: Sun, 23 Aug 2026 03:24:47 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvmet: avoid recursive configfs open for passthru
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-4-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260819155228.84938-4-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
