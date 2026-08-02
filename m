Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5E331ED6
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785671819; cv=none; b=ntomA1d9rd4NcM7aAyMTVM6dOXUnqTarb/qorKvdgVQXseiE3bSuQxh9vwcQ2sA2Qe5frQIU8XAsUfEbVYlYeP+xzvotd6g6Wby0PeCh0h/eW3E0cxX9MhpVvh+r0wudHcnVzjACvjaGD+hM1b8miaHsoXGpYatV8n58Z+H2AN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785671819; c=relaxed/simple;
	bh=DPrR3gMiV2U/5iA7a8FGTFAozA5SAhBq6pSbzgQqg0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9SjXWC5sIMUr7n1744mjBhVJjPCq5W9Mybpd90TRKLiEOmsOFWp+xGr9Vc0f9oCZW0wCN4F7N2m/GJV/g+VPV3MpZ+KfIeJxMu6OEBM4W6z/8NsoxFOdg7mP9RgopVIlfLJ3mmJPB5MR5gkiyJ6AhEjp+uuFJfnyD+z0/2RW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4vekwgp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrndNjXr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4vekwgp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrndNjXr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785671816;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UOShm/Wtsy/GiMsmztssQM6a2ft1SsQqKChxVHMrYw=;
	b=e4vekwgpBvcs2IeYDjDyVEYeKhNOoAusyrOw/+LrCGLPAc257gnp+upccKWj7TylHu6McE
	P26vzdHfusjLncfrcDZegOCd+189lK5yIiITSiGb7shx4Vvsx1q0bN+M3fBhMNVS3XV8Wz
	N0XW/aObPqTLXGR4V1MefIVHRUEnnyk=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-rb9ockhKNWy0CQM1PtTAQw-1; Sun, 02 Aug 2026 07:56:55 -0400
X-MC-Unique: rb9ockhKNWy0CQM1PtTAQw-1
X-Mimecast-MFC-AGG-ID: rb9ockhKNWy0CQM1PtTAQw_1785671814
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7ebfcb4c999so3223912a34.1
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 04:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785671814; x=1786276614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+UOShm/Wtsy/GiMsmztssQM6a2ft1SsQqKChxVHMrYw=;
        b=HrndNjXrHfsInGe7KijkeNV5Ss2lbPU45+NRckpakwTbGbJLnMxMycrdJc65FBt5UX
         6WsmaHDkfV7bVL+XFha0+Xu4cK9N7HW65IveLeMXF9HBinkGsXmrNQpK5ogyK2Ir6D3/
         BLspO39JwMfbNg9m09kW2ptGsI4q3iCYZOchNpUJW5M/QMBhBo1BSLRRK8KOQIqQyZDY
         DDdwAMwabgxm9hAA95vovqGIYFrG8HtQMaKF6DKdPoq5XlntYAYQYFn22by3O2LDlfqU
         QPLkwfbMkcT5k/QyO74FRC0sOrWh5Vdxr/Wr3+xEou87WcH6X59N7JGqr+PjeBzlJdPW
         /cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785671814; x=1786276614;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+UOShm/Wtsy/GiMsmztssQM6a2ft1SsQqKChxVHMrYw=;
        b=CRZSm7RG7F4qXOnbNd7FUobJf/i/4PhkIc33RNiWhSQF6Yf/NVKpX1wF+oLKKyJVh4
         jO4ySkqzYXAAS88EVPI5adl+YTy5UHRy92w0PlKFxDP01GD3ASQIjGimHNFeFQeDEfd+
         7JXi5+r3cUOlc/gvosmxKdcFPLRi/5paB69W4t+ZtaAcXxqltmCHr5tRWbHlJDpc/z+D
         AMH408jDgZ4TgzZWl9q5g6jmxIcePwabJY5ulv8yzk0Exphy+pWci9aDK4w2SQAhRkEz
         Azs/jgxr1FsS0pgfqzf2bIJgf/RivCcRUYmvOoDDNMQId86VnTCz3QSHqyR8LKHtwN78
         t+Vg==
X-Forwarded-Encrypted: i=1; AHgh+RrTSjPg1sKe0bsNvXJvlbl5XaTufpARfzIgKtWaGul/7JlaGkDMwCj/WFmNlB8/BagIYA6RlCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhtqaG7CMipb3tag0RNkFtTeoW+nKmFOVb39PWrwBYKv3p9w7k
	0/MG0N6T39/wwYU4J7ySPvO2eXBXKkBB+PqpoQEqEuJnq6XdXe+u8e6tLWiXLkCl/gap3GCVGlW
	0wLBCSZncThkowKVwiQD1NOhWx4bk2yU8N3U6ZlsIYTQP9okHMxYpWyIYDN3pXHwQ7aFt
X-Gm-Gg: AR+sD10aSXVwio29olcWxbf/Bb/Wo2ZMWK38wIBp6NTTwni+rpNS+RO+tZVV4Dfd5hC
	2pdavKxHojcbnk0s0uZ8yxsG8z+hpiyjEGGf5D6ZIa3XvXrYKAXfS3+1xwlGR3Uh0aBiqDjh6tI
	KgMEt/GhUN8sR6bsIoatDJ9uDs6jT4Kv6/RKs0Z/2OALBGkTowIHf3rgDLsCQmrfC4qhN/bt3p/
	4JgAquF07DVNLyqyShZ+w1aY15c8gOXoz+vzTAaLMkybcIo1ivGHB/PoB/XgEWurApkDKXuzRRz
	zbv+zAVZ0TeSchI/90fVcFHo3F9xeAOiEI1gBLHTXLDAU80wFPJRJaobGm4PR2LdzXxP0hVFTPx
	Ln1vOq5V8A4QN9AshXuZkT02RMNmkfrFw5dRX+e1O
X-Received: by 2002:a05:6830:3699:b0:7e9:cad9:4bc4 with SMTP id 46e09a7af769-7f196c588dfmr10738202a34.7.1785671814494;
        Sun, 02 Aug 2026 04:56:54 -0700 (PDT)
X-Received: by 2002:a05:6830:3699:b0:7e9:cad9:4bc4 with SMTP id 46e09a7af769-7f196c588dfmr10738184a34.7.1785671814098;
        Sun, 02 Aug 2026 04:56:54 -0700 (PDT)
Received: from [172.16.0.69] (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed3c81fsm5031530a34.5.2026.08.02.04.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 04:56:53 -0700 (PDT)
Message-ID: <a7724609-20ab-49b0-aef8-4d7673f0d308@redhat.com>
Date: Sun, 2 Aug 2026 06:56:51 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sorenson@redhat.com
Subject: Re: [PATCH v2 1/4] cifs: use cifs_invalidate_cache() in
 cifs_do_truncate() for O_TRUNC
To: David Howells <dhowells@redhat.com>
Cc: linux-cifs@vger.kernel.org, pc@manguebit.org, stfrench@microsoft.com,
 hehuiwen@kylinos.cn, stable@vger.kernel.org,
 Paulo Alcantara <pc@manguebit.com>
References: <20260731153500.660569-2-sorenson@redhat.com>
 <20260731153500.660569-1-sorenson@redhat.com>
 <2259642.1785537449@warthog.procyon.org.uk>
From: Frank Sorenson <sorenson@redhat.com>
Content-Language: en-US
In-Reply-To: <2259642.1785537449@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/31/26 5:37 PM, David Howells wrote:
> Frank Sorenson <sorenson@redhat.com> wrote:
>
>> cifs_do_truncate() is invoked from cifs_open() without i_rwsem, so it
>> cannot use cifs_resize_file_locked() to perform a proper fscache cookie
>> resize.  Instead, add cifs_invalidate_cache() after cifs_setsize().
>>
>> cifs_invalidate_cache() calls fscache_invalidate(), which works without
>> holding i_rwsem: it unconditionally increments inval_counter and sets
>> FSCACHE_COOKIE_NO_DATA_TO_READ, ensuring that stale cached data is not
>> served once the cookie is later activated by fscache_use_cookie().
>> Truncation to zero leaves no valid cached data, making invalidation the
>> correct semantic here.
> What happens if there's a concurrent read or write in another thread?
> truncate(), buffered read/write and direct read/write() will play reasonably
> with each other through a combination of i_rwsem and the stuff in
> fs/netfs/locking.c.
>
> But apart from that, I think that invalidating the cache should work.  It may
> be slower, but since you're getting rid of all the data anyway...
>
> David

The lockless call is pre-existing; this patch just adds the 
fscache_invalidate on top of it and doesn't worsen it, since it's safe 
to call without i_rwsem.  Fixing the concurrent I/O issue properly is 
out of scope for this series.


Frank

-- 
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer, filesystems
Red Hat

