Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5A223DE5
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600955; cv=none; b=je5VfEJuizJj6ryMHK15YWY/UWGMiSbKS/ApDDSXBXLqCPSfUYPUvzZTF2ADvhwCgONDbmWLLcjYzT33bfXpPIGRttS4K5iPn7wvjHzGPUbEy8MKdxkMs3OxmnZEf4t/jec9+DHMEzFTMQJ5RWlNJ57J3YsFIr8/8REwl/pshos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600955; c=relaxed/simple;
	bh=lwAlT02BHjyP2mJgIUQIFSRAZLGH3T4v7v7ct4iNMYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQ27T0cwl87jzTRKP3Hgf5IROK4zf328ppZzdw/NZeBQOI3BDWa0hYMGCoDKIS5kLDoYnHrb55KDMukXbagYwT6M4zTVEtbgtZhDDrA0eO0QQZMXllf2KuPoWr9U4s9k0qTX9RzMX/5wn8198LNdQe/xrxGB+2GHpqDqbXnP8cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5cEZYlT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5cEZYlT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790600952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQs++mWTXYLPchSKZ2aJXcq46fdxtEFLIJ23TkCwnS8=;
	b=h5cEZYlTzlIzS1nwQEqpllMgWf1V5athESDHZ542LbIN4veQziyUuPKVTKPpgQa9XdYete
	bf/8WtKaPsvapwk1tvN5X5mZl/yKA3zvZM/I3R4/Xl+/ZXoqtVPTQB8knmX/DM1eJZpSLN
	o6eXLife3XsPkaqJRmRyZplSwu9XcaM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-0px-6BT7OxS0M9ZtKiTbMA-1; Mon, 28 Sep 2026 09:08:52 -0400
X-MC-Unique: 0px-6BT7OxS0M9ZtKiTbMA-1
X-Mimecast-MFC-AGG-ID: 0px-6BT7OxS0M9ZtKiTbMA_1790600931
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-69e70c286ecso3155982a12.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 06:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790600931; x=1791205731;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQs++mWTXYLPchSKZ2aJXcq46fdxtEFLIJ23TkCwnS8=;
        b=Tzud+qX49ZvLmcRxm9trNTOXuIikWZmbyLwZPKqFLSICP72cXFV7KBP9x8FKjZ3G5b
         NyfHtkqeb0fz02xDTVC00rB9LC9hB2Tc5LJcOnavVu9f0OldtnAnm4Cm1M0QJFgdkUXN
         lDXGv9rXwuTfIAzs3RC8DUcQPr5u3v/kCWR1bK2wM+Br6EP7mr9JzeAkEKCtnVc5dHyq
         u/B78WVWY4SD+HX9ZJj/y9BR4I7m/Jdma/BMnElIFgJ3yY+47KKAaWhoU9Z9lp4x5d8H
         w49eROLfnxBH6w7PfJgtPmZpPX4tLzG0kfOKnB/jK+qw++M8RbiC/C6EM1N15PL4iO2g
         /nJg==
X-Forwarded-Encrypted: i=1; AKwUvBwP38us1DF4pmRYYc47C9XNzC1o9o17S9VDaH7saL6cddL/BCGs1MLFfbC68JVh0AjQIL7cLfk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEG6Gs4h9jCCfZQfH34KwjmBaRhVd5yxeaQQRDEvE2727SrtZ2
	2J5zCNd9eJXtDzWk/aZyVIi6H2qlkQSEQ1ga7qHW2KHuL5ANGkpXxKd29Xf/sdtBjAYXdyKhM3n
	Ag5IUbiM/dcQggFRNPZnboSCvRBj1x/dKTeAH8BPl8DBSAX4QPzuaspnmGF+cGQzqGH4r
X-Gm-Gg: AYBFou1cqGUvLd802JP0VYFmvFzV9ZOd8XuMjNRIu8EAnOrGQ4mQ1VzxT/TUOvFwPeo
	0trd7QJkMepotomwpR5agh4N7pcLHGxOKEaQBYbpd0+fQoNGTdXkwPGuHf2issSJx4+LgpwXtg5
	maywX1kucjo/v1JsPx3bMVT29LaFXtPflqRMQ/YfAkxvzOzmJb6rjCnDzH/NK/VCLZkqnR9Ppia
	lgXvgyjoHgCcKfcGWaSsYQJrrgbBTQ36ZZYPMGWhRpInwzj+OaBQ1tPT6TQAOJipi4XGUaga0PO
	UdrH6bgJZzUsUUPQgKMPoIDgwGoyCoc3Cyi/qlZIA3n0tc1ua6TxpwOUTScLw9mVniOAhK5XxV8
	fCAk=
X-Received: by 2002:a05:6402:2787:b0:6a7:ee56:6160 with SMTP id 4fb4d7f45d1cf-6aac90e2d6amr10105589a12.34.1790600931415;
        Mon, 28 Sep 2026 06:08:51 -0700 (PDT)
X-Received: by 2002:a05:6402:2787:b0:6a7:ee56:6160 with SMTP id 4fb4d7f45d1cf-6aac90e2d6amr10105567a12.34.1790600930936;
        Mon, 28 Sep 2026 06:08:50 -0700 (PDT)
Received: from [192.168.2.110] ([142.172.30.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5e106c7sm4378214a12.29.2026.09.28.06.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 06:08:50 -0700 (PDT)
Message-ID: <7f58b9fe-8053-4068-89a1-ed217f62c9d1@redhat.com>
Date: Mon, 28 Sep 2026 09:08:48 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.18.y] selftests/mm: hugepage-mremap: fix mapping
 alignment
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 linux-mm@kvack.org
Cc: rppt@kernel.org, sayalip@linux.ibm.com
References: <20260925172129.2962208-1-luizcap@redhat.com>
 <2026-09-26-daily-reply-0004-re-hugepage-mremap-alignment-6-18-bounce@kernel.org>
Content-Language: en-US
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <2026-09-26-daily-reply-0004-re-hugepage-mremap-alignment-6-18-bounce@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/26/26 11:26 AM, Sasha Levin wrote:
>> On upstream this was fixed by a914785f6349 ("selftests/mm: hugetlb-mremap:
>> add setup of HugeTLB pages") as that commit aligns 'length' to the
>> default HugeTLB page size as part of what it's doing. Since this commit
>> is part of a 50+ patch series, we backport only the 'length' alignment
>> bits to fix the test.
> 
> The change itself looks good, but the commit message has no upstream
> reference line. The SHA only appears in the prose and the subject differs
> from upstream, so the backport can't be matched to the upstream commit.
> 
> Could you send a v2 with
> 
>    commit a914785f6349da754e1226420bf4e51961956769 upstream.
> 
> as the first line of the body, with your explanation of the partial
> backport below it?

Yes, will do.

I was unsure if I should add it or not because this is not exactly a
backport, so I left it out. But I'm sending v2 with it now.

>>   2. This should apply to v6.12.y as well
> 
> 6.12 has the same failure, so please send the v2 for both 6.18.y and
> 6.12.y.

Will do.

