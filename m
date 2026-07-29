Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52994371880
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352033; cv=none; b=i2nIHkVNtTi53bZ6pWKwKWre+Op0BxvCvzpMoJZPJVx9/QrZw0UlYD+w/zOiw4dFzj1P1mxj6urRBO+r+KuA9t4ja1cKXEfS/3EF0wQYJ281pMmaRpB1IywBP0UwhF6sizb6zxJoS9n1gTpz9valKt+02/tg7qbIoD4cYMJ988Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352033; c=relaxed/simple;
	bh=XBygWj2PzviMXCbuNn/NXgkx0oFPDuGpmXQhjS9LnLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulsHwlcZgQ3+/GUDLXJoOM67rVDc9Idht8CbwOn3kChuf091YKHsXqo1fjkL9QcFY+dEuA1PiL/5kLJe9oonMJbM3epAY+WSmqzOcqD2Cm4aeMh3IzfD80wn88TaV5MK18hLIHOayODxYlewlHkLuZGm76w7DwUG3qnx9DAiFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=st1G4Cqf; arc=none smtp.client-ip=74.125.231.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="st1G4Cqf"
Received: by mail-oo2-f0.google.com with SMTP id 46e09a7af769-7e9f7e652a5so189421a34.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785352030; x=1785956830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7g/Y/3EO5HdmyXkEY6el5cBEpkupSveDLpqCGZOqYM=;
        b=st1G4CqfG+IkbmO3eIrjaYP9e4KLsmbFjJzf3d3MRIZDyLVVgdd2lXInKF9PXnvT13
         +sQGBNBoAQ2cFa4GiInxls0WsLK1IaWRyUhJp1DVmY0PCnQeGYN0KaGU23DblfBMwhYg
         VHZ2vZnfDrs/Y5KX61AXMI3WJQa3TYYFDOhrHL8+EFsP6+7s5G1N8KEGIMsW//vpjMMn
         zOYPfmYKHg0BTvb1Qv44YnO4AgXMihfSwsMuL78RPiD1Rl9X3R5Qay1SDa3WGAUKO2jJ
         l9G9sKdp2HAsayEaf5fYPRTBXWkDu/GDbsnaD2SkeEo3Ufsgwvr4TQZk1z1rbkKKx56l
         cWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352030; x=1785956830;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7g/Y/3EO5HdmyXkEY6el5cBEpkupSveDLpqCGZOqYM=;
        b=T318CcqQopU6JmjgxWN2XG6hWPta4Os0mutpNa3Iz24pSPQNw0fTOvqt3CBq24nSjF
         8++BE8jVCKDKrrTtpxTsi+UKEoREF/CmNU1lc49qdJNMXtyktjkUwizPHDheQXN6MqIO
         elZG0RN598+3icUh92dDL69i66XKvij0p7KVLZfbPmzfGmQKz1xAVq2TSYAbureALYyl
         sf7mDbheFD/X1vj1FKp7JY+q3hpVItCeVOIiSHYfWK25gQOH7ybixwln773gAWlB6YmV
         itx57Y5elG9vtb8xVVfKv+tHqzCiHZbQFOpg/GCp4N4AjrdyqvPlQEunInN2OOs58nk9
         msWA==
X-Gm-Message-State: AOJu0YwuGozju4hd3y0ZKigjwWosdvHgrZpiqWhxpTUMJbLuF/NSEygf
	Ue19E51wwGmiXs6xBb4QbJjp0sL5By99ZjTDDLS4mJDzOM8PrO0dk3UW8Y/zEdxoY+I=
X-Gm-Gg: AR+sD100Nh4a0Z6GGlGsg21+6haXLmQetfXFxvQDBFxcXBv5fO0GyMqzMfNvGfRMNre
	aXT5rTbqBEz2D1x+l3j+up77MwKGBmZPbdN3Z0YxPXXisCPlCxI4nyTDveAitBFqst2Eoe71aMR
	R203UiVcZLEPcvaaKywSjdEWHLjO6xKRwptnRbky9ozbCPZ0abcg1kbq3rVw/YsCCgMIKFm/3mD
	ZQSsQ3+4pj0i0pheDoeskme8Zx51o3tfYpSSwvu6JSN1gM+c+DhFZ3BMFbv8LrxG9gYafbgWS/3
	F4dbKlxQZE8AqC8n4NHMgoXfiSvO+0QVAHQ0TvSijInqt5ol7qrcyNmFsKp2NXscDUeAVXQIuI5
	B/ChnxYWatBtYNymrXVHQlARdlw5No8LZAvdUJ6RWr4JbpRHxWKIs6okuZrLLce9qIgsp2LjPkE
	0kJwT+hqjuDhBRYbSr9abvsGs/ckSShvLLpq7teiqpOiY4vEpR9iUzhe+RkWJp665zCERfsiW3o
	Cb/v2wsCXmfzL4=
X-Received: by 2002:a05:6820:4d04:b0:6a1:41ae:1be3 with SMTP id 006d021491bc7-6ac96bdd23amr4053368eaf.41.1785352030078;
        Wed, 29 Jul 2026 12:07:10 -0700 (PDT)
Received: from [172.19.0.220] ([99.196.129.79])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aca5263b27sm2538444eaf.5.2026.07.29.12.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 12:07:09 -0700 (PDT)
Message-ID: <d9ec68af-793d-41f4-9b9c-d68b1cd51200@kernel.dk>
Date: Wed, 29 Jul 2026 13:06:28 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix missing ERESTARTSYS
 conversion in read paths" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, yi1tang.yang@gmail.com
Cc: stable@vger.kernel.org
References: <2026072912-barn-caddy-3cea@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026072912-barn-caddy-3cea@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 7:50 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x ab05caca123c6d0b41850b7c05b246e4dca4a770
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072912-barn-caddy-3cea@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'
> 
> Possible dependencies:

And here's the _actual_ 6.1-stable patch.

-- 
Jens Axboe

