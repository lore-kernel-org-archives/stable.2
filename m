Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C37577E4B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969291; cv=none; b=sNT7RKKkASO0WRqxm+6O81fgzTqVoNZ5yurdW5I9Ya6vg+Fz1wbv+pT6fzIqTc4H/pMZIY/KZJST0Bru8fbr/KJK7NSmOcpgtixRgYOwDdhMzMRSc7wUfhjeAHIQMFAX/OoHUVZwfzpxDXIUQ7WwZ/TxOUQi/ymxGN/ecATfLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969291; c=relaxed/simple;
	bh=ZS57qCJaJZzvLtWT5rb+UsgkBAE6cq2kv5Ow6zPtdvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbAF12X7SMzKhKNUpfOxS5WWAiJVoX0TJAaAGhFD2XvRY+ug5Hcntcw1IShm/QSviFbjaYw0H3hYQSeJ1Sfe+UW712L6VgX6hKY+j6OfIY0eMH9id3hUcV8ESsU/RpWcDxkdNcViQexL+WB07f2V1HA888biF6yKQE6pKlDBTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWHZ1BnS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fa5g7st3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWHZ1BnS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fa5g7st3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788969288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhAkYk+BLfXoLVmp1k/Z3VniIpgJgKO5MbxyHejQ6HY=;
	b=SWHZ1BnSahpqXgpTF7i7H/PTQo0nLq1uwhbktvZ9cj5tdSfuJ2LprNS4RDKmyi/mAmSPYT
	uqQ5EiJRB/1yUWwAWx8XaaKOhliqHDyHsmt3vnB/Ic2zi3PRYT62aqWHMe2+tWUz4GTLb6
	OkMN53mibvOMAadu+D4dkAq1Xu5ZI/M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-a3n4YG5ZO5Kcup_CBMWSQw-1; Wed, 09 Sep 2026 11:54:46 -0400
X-MC-Unique: a3n4YG5ZO5Kcup_CBMWSQw-1
X-Mimecast-MFC-AGG-ID: a3n4YG5ZO5Kcup_CBMWSQw_1788969286
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so5174833f8f.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788969285; x=1789574085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QhAkYk+BLfXoLVmp1k/Z3VniIpgJgKO5MbxyHejQ6HY=;
        b=Fa5g7st3Z0sZ6+TymEI5E+NzBfphSSlY768Rw+F3Ax22kVyCGETd+Rx7hiWsf5LZVH
         nv9HOHh1Wzuix3zuyc17XHy/pbkGAYY7QYu3FIIMLzwlNXmVcKE15YxNFAQQ75N8XdGR
         yq40Ix6JJqU745NMY0Fbjq7ZSENafV/1TO5OFBdYwIkWY+b6/PM9Z10iP0FqYc1GSVLQ
         cpBb9guDxJuAu1lxNrGfbv6Pz8FJ74FifvR9IsCcN8gTjL9knYG5eQvO9cS8gCBpAarZ
         VxLsBQDERPkFDkJQfApUgK3akRqd1CFf7JVQhfy5C+sQFYHNyS+CT7RzvhmoSph462Yd
         Oytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969285; x=1789574085;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QhAkYk+BLfXoLVmp1k/Z3VniIpgJgKO5MbxyHejQ6HY=;
        b=grYjfSlBfdBdDG/47hOsKma5Au2m17wbxWYrZxCbgbVRjz7EhLBxcURUxxwrkhUNZg
         pJLfLWqPdHVW697/aeWi/w/O677nEGAcqGx8q2xHwqlvOfiAXwqC9h3HeRgZ+r3RYfaR
         cCqCeztitOLFnKlh3Ps8mHBhNQH9Zp3irlU+XjOuTHDESrTnxISlOYTFwoEldJ6vrAdT
         NAnlMBb9sSlTqSkje/jCO+4ZEPjsn6WdbvNCiWk02YIaEr1gJI86boip4zJuOjZSRcKo
         dBSTPnI8YxFwEIiZJioyOztO1VQI8PyoUTvUlQVlrzCU6vkPlrnYNpslPnPlAE+lL0R2
         REIg==
X-Forwarded-Encrypted: i=1; AKwUvBz4sVQzXFP1Z4Fkg+8zIR1WtFsp2GPrmAU1kQA3p6wm71XtGWiXNJEkx6dJGo7TKLmOwoO0vYs=@vger.kernel.org
X-Gm-Message-State: AFuF++mK7emp59g17BpJ7Vj20doAPPxkkKYpIITtzwf+4p67TmDz3HHF
	6kqYr8nL8N/DPy6eI/Pe+hgixSN0hbVgqbO9YyTyFmptG4zrkFu8Dh+BeApLcYS/nmaodsVAAGP
	F9AAsTeNpN3038HmJi7L5TQygM6aO9vUoSxqtv1yD9Fb4J3t0alaQXJluwQ==
X-Gm-Gg: AYBFou234maKX+jqFLQbSrWP/izVsY6n4MTJj+uV3S9ez3CNgb/9tJjsI09Mw/DS77T
	ZI3aUlZbApmOho5ZNflQVyz6l+6Z/Koci4FPeZ0FoR+re3VZgsYGGIrylcmD4+5F0rnJEb+xXyy
	KAA8JcgJi5m5gj2KOpX8imjGYDfkulFKhg5b4swK2I/IJrCgKf/KsisTgiP+aSZvRxjgUfyXoNp
	ePk7XGZD81mVB5XDPWDWq87877efMVdFCUko03HJDkE4FaVnKBdF3YeQ4Y9yMI4b3I3gknqjkKo
	LoXgqaZ7b33hczpUrGmSF/8zqGQgZjkgvMRAu1/GAYWcCiB0eqzTy3tQxZH9GFK9CzkHnrHfpTV
	2cGVQQ8odgXcK2hgWwvIJzPnODpCFKFzeIdv17muNfDouEeJg82IJkmgL1FyycXncj0etpmUexw
	==
X-Received: by 2002:a05:6000:288e:b0:485:8c16:a33f with SMTP id ffacd0b85a97d-4858c16a5d0mr33596612f8f.52.1788969285577;
        Wed, 09 Sep 2026 08:54:45 -0700 (PDT)
X-Received: by 2002:a05:6000:288e:b0:485:8c16:a33f with SMTP id ffacd0b85a97d-4858c16a5d0mr33596570f8f.52.1788969285051;
        Wed, 09 Sep 2026 08:54:45 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm44531453f8f.21.2026.09.09.08.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 08:54:43 -0700 (PDT)
Message-ID: <03f37b1f-a115-4c63-bdb1-7467ae8b165d@redhat.com>
Date: Wed, 9 Sep 2026 17:54:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 06/15] mptcp: prevent race between disconnect() and
 rtx
To: netdev-bot+sashiko@kernel.org, matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-6-df1de70348b6@kernel.org>
 <178896537655.219967.3201901026877077910@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178896537655.219967.3201901026877077910@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/26 4:49 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 0 · Low: 2
> 
> - [Low] The commit message of "mptcp: prevent race between disconnect()
>   and rtx" describes the change as only "Prevent the race using the…
> - [Low] The commit carries "Fixes: b29fcfb54cd7 (\"mptcp: full disconnect
>   implementation\")" (v5.18) for a real race that can leave a reused msk…

Here the code is actually just fine and sashiko don't like much my prose.

/P

