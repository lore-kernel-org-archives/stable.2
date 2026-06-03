Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312CC30B509
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493535; cv=none; b=mGo3S/i6bigYWPrEjgPclcJXQOhrflM2ggN4VA5ToY+W60MCdwLjvuMNcgUrkpIaHjrJRU5ogwqEXVwtxMqXzZc+ACBAaleqfKqRpm3TYT/Uc+WTICk3GFcm+tf3NwODbFWHWnVbr74uPhq8NVX2DBM4/Ri4+NZMSGc2ldh+OSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493535; c=relaxed/simple;
	bh=0XaLpw8wCWCVqO3HuR7IIwW8qzeoCTixBtIKErorbuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGxaMhtJUhvu815mzVElnwjNeIZLOJ9NBQzZt+iftpFslCdiLsOQ1hWZnjyAcHNAG4pNi8OIaCV0OfQuLW12RvHQt5PiVEnXylMZaHVRGdUD/HhjsLXM3QFlZ4K28eEU5CkY7i9WVY6gkNHPJZ8sKt8XNCSmfdInsJjRMlmDx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5Pkbg1v; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5Pkbg1v"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso123654735e9.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 06:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780493533; x=1781098333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4TVbfpbXuT0Cc8+UmhjB+WjY3nKUaTcDDEiy2PFK/eY=;
        b=K5Pkbg1veMtiMn3iRnrbfarln4Qey7dy+cZiKbAKWdXixIno80/sRg1GRpSETsRJ9a
         UJZuJ0WcOX0IkHnFZHIxgVymDrTEYMAHqsqWio172F2jHdiOni0jzQoz6GlJeGLyU858
         OeAmEhtPgDSfr2wnSqkM+l/i6qP5GUlMEhtisBEjCtyk+a2qrjamrLHjw7k/yJsQsnaK
         96lUAQPcLtBNkgp99kccMvzvavbrvgtUdFPNvwXGfHwD76Z9W6zCOVLDG6M/CXpmiZ6D
         bYdWZM5gP1uzA3H6ILWm1aJeSzN/FPUcew6RcW/PV3hc66srs7qevDprvZWIA3wd/+ey
         cO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780493533; x=1781098333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TVbfpbXuT0Cc8+UmhjB+WjY3nKUaTcDDEiy2PFK/eY=;
        b=EJRPjHk8lIiG3RYaoNPHcM56zw2ufsCkJ/8V9cVW2gvWH2Y9ns9/TFxGt0q2QReQNu
         YDln3l5Q15HS2SiiByz7FBJoXQHctZY/6VrU4keD0QanNRqQjzl5ywVBda+BS1zeGvYG
         vdrjF7Tl/IIYF6Xip+xD++paNCADfP1CFydxUQnJOnxXOalxdgtbW+E0yUtniFUzKDGu
         ANHZauzXJ4J/bGkWW+9SSiI09+vEzxw3C71ABXbGBBhKihlIb2uXEXLEELCCBRCW1R3K
         1hmPdRhDfXEYBwhjBbULUVQq5JQRNZf9Dt9ZN1st5ScW6bbj6afP6hxfr055x/zgjXYJ
         FzhA==
X-Forwarded-Encrypted: i=1; AFNElJ8cLRS6r24SfeMJuZAdvtkMGAUbrvQ8mRYeL5CsBXCQTLOnmgXk9S4Bm0YYUwFDYHhdWxL/4Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaumDdfeUJhjrqZhFlWV4ls4W/eChXNl5Cvde8xUjZFDVbNw+1
	F3Kxbtc9CdtY1Agt9khZws05fiv8BPEjbY2XGEAh5xgsYdp+GPGJiJop
X-Gm-Gg: Acq92OFtDTBc8O+ffv/i75Fdu4P55/h7UHOWXLiASND3OHK3l5+/d7TthPVG9OjCqHV
	cuJDnwYR+R8anulYvjnIwEz2eUZXf2X9WcmqNvuygc7P0h7odEYH6aZnrAhSH8sMcwJEj3GLR0Y
	soZHRJnLul9nMp7C5+IWYZmaGfEtww4MxrzSMnFUjqXJBqUy+X/+Fspx4w8xkBSchzdei65BnRY
	P5+O+8YY4ar6gdy0AiiKgt/qmdnxGQb0DKqDBsQMd1bPHNI+W7kKYQOjxSGT7tZBz4TLx2qnsLY
	3M4bFDe9F4W8iAmDZqIcR2B6L5J+LQJuNJNFa3ERlYr9ESVXchk3+kfd4cw4tIR/969H7K5GJjd
	f+K2Q9NgKbnzkPJbLGjL1kkwgO/PqkDbMk8TpiGH5SZG3s5j0n7E71yQZw9a9IBjUbrueszjzq2
	a6uY1KpveCxGkLJQ1U4SafqBVcEMW4+UWFu2hVsp+iXDm5L6+FecZGiDoU0A6HWpVFKfZvqUYFo
	omMSZ7K4mw4OvQxuz4MKg==
X-Received: by 2002:a05:600c:c48e:b0:490:40f1:5314 with SMTP id 5b1f17b1804b1-490b5eb73aamr51371835e9.1.1780493532528;
        Wed, 03 Jun 2026 06:32:12 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm12355413f8f.29.2026.06.03.06.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 06:32:11 -0700 (PDT)
Message-ID: <755aaa06-9f6f-4f49-a3ac-5cf7f3574393@gmail.com>
Date: Wed, 3 Jun 2026 14:32:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] bpf: Restore sysctl new-value from 1 to 0
To: Dawei Feng <dawei.feng@seu.edu.cn>, martin.lau@linux.dev
Cc: emil@etsalapatis.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, kees@kernel.org,
 joel.granados@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>
References: <20260603105317.944304-1-dawei.feng@seu.edu.cn>
 <20260603105317.944304-4-dawei.feng@seu.edu.cn>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260603105317.944304-4-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/26 11:53 AM, Dawei Feng wrote:
> Commit 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value
> helpers") changed the success return value to 0, but failed to update the
> corresponding check in __cgroup_bpf_run_filter_sysctl(). Since
> bpf_prog_run_array_cg() now returns 0 on success, the legacy ret == 1
> condition is never satisfied. As a result, the modified value is ignored,
> and bpf_sysctl_set_new_value() fails to replace the write buffer.
> 
> Fix this by checking for a return value of 0 instead, so cgroup/sysctl
> programs can correctly replace the pending sysctl buffer.
> 
> This bug was discovered during a manual code review. Tested via a
> cgroup/sysctl BPF reproducer overriding writes to a target sysctl.
> Pre-fix, bpf_sysctl_set_new_value("foo") was silently ignored: the write
> returned 8192 and the value remained "600". Post-fix, the BPF replacement
> buffer properly propagates: the write returns 3 and the value updates to
> "foo".

I wonder if we can make that reproducer into a selftest, clearly this
codepath is not tested automatically at all, which is a problem.

> 
> Fixes: f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err instead of allow boolean")
> Cc: stable@vger.kernel.org
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
>  kernel/bpf/cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index a0b5f8cd8b10..3f06e2270f5c 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1935,7 +1935,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
>  
>  	kfree(ctx.cur_val);
>  
> -	if (ret == 1 && ctx.new_updated) {
> +	if (!ret && ctx.new_updated) {
>  		kvfree(*buf);
>  		*buf = ctx.new_val;
>  		*pcount = ctx.new_len;

