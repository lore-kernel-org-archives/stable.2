Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4E43935A
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783563302; cv=pass; b=EoUyc48e8vW/jWOCRjgz9Re49+ODRtiJ1bi4+74w7qA+Sp0/XvxIfs3Mc5vmsZ1Zzcbm9a3N39XQzc1cQdE3RnGHyrI7ZuInM5xq7oX9gtm3Vbphp2ithDGLW11JjsPxtzd1bY4Pw5+/sui1e+DE6gi8erY20AFxX9AZJ/MLPXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783563302; c=relaxed/simple;
	bh=SyuJJ3M/8TvqwCW6ooOoZHgoE1bqejHUnrU4L6RPaS8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTbVQWV65ULFQq8NBRp/2XxiVY7LtS3E8kyBmEZbMee8bkX1XR+R9tUcXtx+Ax7pJxnujwvLL0mScfSXN20PnYrwnJK6lQsPQCw6JE5RJaHPQbZhtBeqjMxun80Rf2rnB9Xi9j7nm4z7ALvl8n0BjrKOL1tN/FORZ7WV2R9diAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IIrRDya6; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IIrRDya6"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381ed661712so456572a91.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 19:15:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783563301; cv=none;
        d=google.com; s=arc-20260327;
        b=B7sPN3aU4Q24vgsL/XxZo+r5oxXtnljKROxn9T8SZQSd3LS1NZzZNBBKKRlbE2+xDY
         WzfqR5gaL4ckao8QeASJNTiHLWekQPevowkIqOsZCeJjkFbL/jAdgPZak1nCrTcK6nPL
         qNgmM91q3CNH/QbyjeCZSAXpnXm+P/7YghK+cTlbrG0DRCy4NAxJJJMNM9YPhvIoxum4
         PJuvczrNcpJH9MSDlTWcWVbIM3O5pfNE3H11vG3bxYmDf0Wmn1ukE8EMon6YVIbbbn+D
         hpfCVdWX7PLtnFvoOnW/9drG+OBkKBK7bSssIpbTV+pbJy628mT9phU23yjj7bUWQfYu
         y+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=4zWeqxfAf4eNddMGQ7g2wAFFizsD39eClXtJs6pIUh4=;
        fh=iA2uZpW0uwJTaiHA4eeDRgfnqOJWQ+8gU6PRcp7X+u0=;
        b=IPjVkk0EsnPuSudNeDO98EeH0SHPZGtRPv3myWfvI9xhKy07JeYn8H0I78zhnPi3AG
         FL+p7d0RGapuC15bRxEsoytz9FseP/y9zNu0LZqQbTRuoPxo487E9XJBGpkl+/sphRz9
         K9IgoHDsTWiA1D5NqxgVC9RBTOCKnuahOvXPJxMJOU1Im9t0ZA5ngZcv5XsPlvW9e7t+
         Qjw0X2VhpAOdDpNKVMoBKNSzbUn4IIWsVVbCue6Ezy6yUWAv8WMONbynTbaAxEPzl6Qv
         rQtHm1Ep4X2IuzzUsYZjN5sEyihEQYHfJqqq8RgULf25lqqyZkll25EuNUzcQfSbq1Q3
         jpZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783563301; x=1784168101; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zWeqxfAf4eNddMGQ7g2wAFFizsD39eClXtJs6pIUh4=;
        b=IIrRDya6oeDmhWGyGvHtyKnWyf2JsY8EQnEBfOoy8Fq4q7iWyZJxRz/t3jcmtjqFyA
         QvDeQoowRKxQRAueSyYJbmsJfFjLhBlUoTrwXk7qRV6UnJ+dCAzeZcGFzdWxqqbn1bih
         wlh0ngdZZGI0HEEkq1EEHEdBLFsz+pd28ncyRzBpWDWYPkfXdqlOgxPoqslLVPB7Ey2C
         d87EGNDxfK2uCW7WSRXJXH/r1vRe3MOnlvDxYECTenEZbnFrqqXlPETaAlTCdOM9n6ik
         8f+/4RpJxcCF6SWmh+IUmdExb1gD62jq/+wc0dfMIzPoTYlz5dJqzn0+AQDIh+I8zZbT
         VbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783563301; x=1784168101;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zWeqxfAf4eNddMGQ7g2wAFFizsD39eClXtJs6pIUh4=;
        b=IQrf4jYDhC4Yi5suVxFj52P+WMz62HVT2xLY+0kMqpOQD9SytJL+3Jzj9+j2FZ6gjT
         4VY9a+gLj0lkxVHWWW26KPu+ulxlWSjFT5GSyohTyv0TUltfGR3bBtAMrIAUa7D7okcT
         EunwSROw7FyNJUHoRrjj04dI6h6NGA3dWigMt9ALhiNKgzSC3YeeUwACBPgJu/9SCMFT
         YZaf+xKYSQWSlWut6vKWaRyz8kP1SjhtYYUpBgabJ1Y+WWAnhBMk7OOlHOfi9A4bc2ma
         poSi2v9TfK1Rim4hI3ZIwzQ9trZIeVt/LQDGB++GbHJLh5JAhKhtL7mImnhOi1144NwJ
         bZqg==
X-Forwarded-Encrypted: i=1; AHgh+Rqb2bevmzGOT36X+Q3YysdXbN2HyIDMyJWzJ7QKc+btqYzUiVEhw7uoqxnVcMeUHRaVelnexPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztZY3u5Uvvc1g8VxMde+8UAcxTm3otmfsQRgHCjm/3/2ap1aA7
	9/ovxbvu9ELOVkpxU8jI4NbzOJh5xryd16SjDWxSQCUtgvtOvh8HqyTdpM7eWy8NOR9bZjbnxbF
	hdhvwiXfRDEoXDFbg8rfUhG/rnmGHCdwNdvz9W/zu
X-Gm-Gg: AfdE7cnZCWFyuxiG2OGSAG1C75PKjBotInMlT8CInre7/dhfu0AJOqmDTVnWBGjlMS1
	6VRyGevYztA+L4s1d6ISTchkCZfTvO0Evrb7qQAwe7kikJoPXKYGgp6Av1DSMCF5ISeooxfspwp
	C8D9gZ/hG2p+cZ8HXC1rW0X/1O8Cm9X7+D9tGdiFyqgf/Q5FtjgbLX3zlvL1ew6IF7hzFhKYnim
	fnddpTgZSloITSlhc1HzMwmELEHmlxFR+ewnZLXQFdr+vZBjx5JjkkrqW+Mj09PvM7bD0h4UjRg
	iJmmhc38N59HMS5DegBgIS1tjLmm
X-Received: by 2002:a05:6a20:7343:b0:3bf:76d5:cc2b with SMTP id
 adf61e73a8af0-3c0bcec1928mr5597463637.22.1783563300230; Wed, 08 Jul 2026
 19:15:00 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 19:14:58 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 19:14:58 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b@google.com>
References: <20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 8 Jul 2026 19:14:58 -0700
X-Gm-Features: AVVi8Ccs1t1sSugbFQb-WlYWvA2uB04OV0NkpVbmjtfPNVkezHBwHBjNawuYamk
Message-ID: <CAEvNRgFMFK+pPZuV8ythDa9B3yhPy+mxJEhKM-9s8g3WO5dp+Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Fix bugs on HugeTLB folio allocation failure paths
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Wupeng Ma <mawupeng1@huawei.com>, fvdl@google.com, rientjes@google.com, 
	jthoughton@google.com
Cc: vannapurve@google.com, erdemaktas@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

Looking at Sashiko's comments [1] again, it looks like there are even
more issues. Seems like these bugs are quite deep into the weeds of
accounting, would definitely like some advice from reviewers and
maintainers!

1. Are the issues I've described the correct issues or did I get the
   wrong root causes? Is this the right direction?

2. Is there a good way to split up this series so at least some bugs are
   fixed? I kind of clumped them together because one fix revealed
   another bug and so on... Is it okay to merge some patches that we're
   sure fixes something and leave other bugs to be fixed separately? (If
   we get to a nice fix within a few iterations we don't have to split
   up the series)

[1] https://sashiko.dev/#/patchset/20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b%40google.com
