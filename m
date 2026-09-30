Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C034CDDE9
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803568; cv=none; b=m2nRGJ862X7LsHI34CsEsYDue99+ybj9WlLtAfsqQu8NuLGdaCdvNzXImL9jtOsLQHwQ+9WywMyceyqdc5p6mOlbjizOEJnKZHIoPuyUqkUHjgHjXpXmZ21mH/bKKwaWbVjFvmDcoCXBOfwuVY22ER/QSRf5jCFH0VOZVi4Sbzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803568; c=relaxed/simple;
	bh=iXpeLJ2IQz6dj06pIp8CpdyiSrvgdjV2iaNmpg8p4ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0giWS44/w8I2uafOrkP8UdP8SlbQIJaZttQkw9SMsoBIma4OormHDdVNKC/4+aT8tEhNaEfk0wtdCRMPzSZ5Vr/slTNVoWbzAuRn6p5P8ZdOlL8jmx4VvU3BwX2iaiKS1ZT143VbqVPScsxOgc23ipwNjsewGjGu229ro7gRDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsVxrfn2; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsVxrfn2"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so31929165e9.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790803564; x=1791408364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6NcEBo2bS8P+fcdvedqvJ3Az2pTigqmXIzaSqCZiwQc=;
        b=NsVxrfn2Kljkmos8XO1C4TcS63vOjOpRnApgTy+8RX/0eZ5tiYSQZ+DSYvtv8OFqwR
         KCyb/UI4nPc23lkbaYA+3GqL1O2o6EHU8il03ie9jKkcg2Q1kK9gNTk7xRUvQiEdbTHf
         Juhh2qiKRVNEvF8/lDV6f8CJv9/MSXEoDllGrwwZM08eVe6VTceAOJtCS+G4MuBcTdhL
         G1y9o5CJarQu3i9y0iNVxTYPNY59GWmepUTaEm5lQix4DROPQgNlPCD4Y2zOiNfcZOAO
         2WOPdEGb8Uu2Muyr7ozNvxIQL+E/zjnFKw8BVHw9WAhoQxo8HnjEFaxh/+MrwQRnyhXh
         1iDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803564; x=1791408364;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6NcEBo2bS8P+fcdvedqvJ3Az2pTigqmXIzaSqCZiwQc=;
        b=GVvdBXD+iqB+NlqwTBZ1cFr3RiqrQpxX+/3Khmd5ydb21kJnEXHnhoaAkKLj79uXZK
         m9itpvSwmhbrnSzeRZUScEfQp8MT/wUScwshq3WmBPzVKBK55T4wBLGWvdMyAnhxrX4D
         dF2oJcuH41zbpZpqWK9EpFl8RPTNbk/gJNQhQ6YAo1istNvigL0zQUyzbAvClPYwVA85
         sRbyvAoQWXDCJgute5tbgOd4fBONlQhFirJ5pIXE9M/mdZuu2HgLUlBorKvrTLie92Ev
         gCRfG9LmBEg5Ukhq0qyQMK11IHAn18omd8EfW/B2+l5mDgAnM2vOtu+mW//Jued2Kvga
         W9Tg==
X-Forwarded-Encrypted: i=1; AKwUvByQOu7UxDpTtdTdijn6Rdn+l83DDrRQDbFKGTemIS5fePHiIhPIjmQqCzOFvG58NCAmmxKGyQA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLU4NGNWkMO3sp1w7u990qZOzflkFpHyhE/uZ2BaUFN3i6bpbJE
	qNMheZi3Y8UD/k4p+KBIlV1xxRBTcIG/iOYhRIgoEtMhbF2zjanOPjRh
X-Gm-Gg: AYBFou3hC9RIpKyaCyqkjxSojCBXcFejQ6TFw88fPViSNbUqAzz415Xtv6GjYlFQIuS
	dkLf/6uHmXoFilXbmBCqX1imDyr/Ax9bm0esJTjxDXnJlXK4WiU/+GUpE/UwGoy/yio3ji2HjbS
	8JbCcUX9bYECfLb7wZALjBXEAa48049lfnRa7u8ePEg+6m1xqW3+5cg/aZ8gGK264EqZ0rSf7WI
	BP+yApmFSiJgPIr7w03Te9By9HgzWXAz33AOM+ONWbqeUV9xKBNZILOvi0HEn5AWZk8dOr9O3qB
	5WtoGf8UE8CAxOQEDVfmmFRnZDbzuUK1kUe0UxVMNXHOBrQwTveCFN0eem4xKhvmf9jXf0O3fNq
	00t4/7rMP909a9YvnvVaNYiaVoF4ReBoqb5GYoXx8d7umxedG6whTA4niovVuMZ6q7co0nBEvcc
	k8FcgLxKVjJURmylsYSdc3PKyd7hO+JEspy5iAoGo0AUpTtPB6Qja790mLm/I=
X-Received: by 2002:a05:6000:40ca:b0:488:6561:b324 with SMTP id ffacd0b85a97d-48b024dc409mr4686934f8f.9.1790803564433;
        Wed, 30 Sep 2026 14:26:04 -0700 (PDT)
Received: from gmail.com ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b068bd8c9sm1825610f8f.2.2026.09.30.14.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:26:04 -0700 (PDT)
Date: Wed, 30 Sep 2026 23:26:01 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: sample slab_state once in kmem_cache_destroy()
Message-ID: <ar153_VaZlIY3qeQ@gmail.com>
References: <20260930195110.13296-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930195110.13296-1-kaloz@kernel.org>

On Wed, Sep 30, 2026 at 09:51:09PM +0200, Imre Kaloz wrote:
> kmem_cache_destroy() tests slab_state >= FULL for sysfs_slab_unlink()
> and again in kmem_cache_release() for sysfs_slab_release(), with the
> cache already off slab_caches in between. If slab_late_init() runs in
> that gap it sets slab_state to FULL but never calls sysfs_slab_add() for
> the unlinked cache, so kmem_cache_release() ends up in kobject_put() on
> a kobject that was never initialized:
>
>   WARNING: lib/kobject.c:734 at kobject_put+0x64/0x2c0, CPU#1: kworker/u8:3/55
>   kobject: '(null)' ((____ptrval____)): is not initialized, yet kobject_put() is being called.
>   refcount_t: underflow; use-after-free.
>   kobject_put+0x64/0x2c0
>   sysfs_slab_release+0xc/0x20
>   kmem_cache_destroy+0x104/0x1e0
>   bioset_exit+0x13c/0x1e0
>   disk_release+0x54/0x140
>   put_disk+0x18/0x40
>   floppy_async_init+0xbec/0xd10
>
> Seen on sparc64 at boot, where the asynchronous floppy init tears down
> its bio slab while the late initcalls are running.
>
> Read slab_state once, under slab_mutex which slab_late_init() holds when
> it sets FULL, and use the result for both the unlink and the release.
> The kobject flags (state_initialized, state_in_sysfs) were considered as
> the key instead, but slab_state is what cache creation and
> slab_late_init() decide on.

the enum has nothing between UP and FULL, and the create path skips
sysfs_slab_add() while slab_state <= UP, so both tests are the one that
decides whether the kobject exists, and a false value cannot skip a
kobject_put() that was owed.

it would read better to me if the changelog said that. otherwise LGTM.

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

> debugfs_slab_release() is not part of the race: it only looks the cache
> up by name in the debugfs root and does nothing before that root exists.
>
> Fixes: 4ec10268ed98 ("mm, slab: unlink slabinfo, sysfs and debugfs immediately")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>

--
cheers,
jose a. p-a
