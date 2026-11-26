Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709408;
	b=IMD+90mZBvZprdGlMPnzHcrWVyPSnvPKE0hroEzBbpRwsAo3LjICI9TCjNZsH0R2HkAA
	 ppJ/UogzWhXq0BpTvP3KPjOAo3sanr6c5+oNWNKB0iPJn3PpKCDmyX5fc18RhcqF70zHb
	 IFGyNZBio/t4CTZzaGlydi4xP2CY3ZdLpNKzXYNua/szJTr8YL4PhIO9UMHTHzn56ocFM
	 mjo4n/e7hhcVqbfqbRyrRbPIeocO6BoWTih06nffZM+BOG5TuaIUHSn4mewTnxpiqZjJy
	 JrQquFETRTUNrKYFAQxZIIn498WVI7lCnyXBl9SDLp4TiQFlf4W+IWEpAdWUPky8CCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709408;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Wxm0q+9pqrQa87GpYE9M2lUimiUIeR4Fl+shQ/7gsqI=;
	b=h+LEUeqCWp9js7glSb7cXmRt5uGk8Id7QuSJPjwF/1TBOXrSBDSVKFXyEDCV2XN2Oppf
	 u7K12TjBIvLEmDajd7adDog2TsXhin6r+aTu2CnHsKff9/1SG0S1laeX9L5ZtUbJ+fJEf
	 FBqLasKmz3qeFQqhIet2KdOSfptXkVVFsjtRcggPT0E8xG+TcVlTJNlmgIFQYpS4cA3o+
	 6L3s98IsUPBlAYiM+HZV8ANMix9KXhyPLNne/x2tuGcIS7T66939fAFGl40dPe0RIk8eK
	 SqVDbDFJ9E4yn0z3+mRSZ7ELDrS6oakc58t7BMf/iYqUygESr9WV3X7qtR5j7WZJtnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d3fYmMUp;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ObNigFBh;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F9606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F7F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d3fYmMUp;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ObNigFBh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795709407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wxm0q+9pqrQa87GpYE9M2lUimiUIeR4Fl+shQ/7gsqI=;
	b=d3fYmMUpdpho+a1ezTY1dNSj6NW7jFOVTJoM4+HtJhU55vy0Ox6BtpBQ54bgePY3WP0CGv
	dpr5Qwvx6cs4Iwi1PDMgUSnINA8BCV/5a7X2co4UrSPCudImI+BqMi/A7sR4CLNC+lr7em
	SlgCP+C8rw/jDTSAdGI7pv0uEP8KtqY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-jn1ecyuLNim6jvDahC0kow-1; Thu, 26 Nov 2026 16:10:05 +0000
X-MC-Unique: jn1ecyuLNim6jvDahC0kow-1
X-Mimecast-MFC-AGG-ID: jn1ecyuLNim6jvDahC0kow_1795709404
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-490c1867460so4087633f8f.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795709404; x=1796314204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wxm0q+9pqrQa87GpYE9M2lUimiUIeR4Fl+shQ/7gsqI=;
        b=ObNigFBhOx+JLbP6N3ncQjfnJzrL0TpzPV6FKj3GydJWyT6u2kx8aFKE7UQHrJJ7ws
         RsjH9pc5WW9+UxEckClkKvS3h5hoINrCpIuchDZGlHHydPlI2npU2H+uz01vLy0SX0Va
         x5kMuVsk0dHYDLGkQUCUOOyEoUfx0oMaF3YIuFW5Zx4LRj+9ylWCkqSnb///3OdrWllg
         M7Wr6XXtQVbwJnnRN2wamIoBsDK3hS8BuKPSGW3Q+wkaPC+ejbYdXNY+7dM4QHX4p/QK
         c5MuSd096oMeobFfm4TQ8CBBBFBblyJMhYmFpxaaO4DycOb3euoa1uP97nvD4+gvVYeL
         sChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795709404; x=1796314204;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wxm0q+9pqrQa87GpYE9M2lUimiUIeR4Fl+shQ/7gsqI=;
        b=WnrHGxJ5y0usfLH/CSzjQUgPD9d9CJtJHMt9dZw3gUKnMIMf5NoIkMyMULNyz3M2mp
         tbfVkgUWrga85sbtH52T7spSYHMHiXEDMFju1PP0Ihg8ROkYuidCllGyceF+OmzB7h88
         fRVpmyALfPua2pM6dVvh5GOUUURcopweAl8BDCBYC6bBwujPFrc6XxBCFCC6NyK7esN0
         ZDjv0aNw2z+YVnPgqR3Q4K5pmrhP10hygtefBRLpIncNOWZ5BZgLBUhIKINy4FG+l2w8
         zC/KxH1eQAUzgft9ZQ8YqKRt2mtsZ1zVHSFJa2+Bxp35PfE6WOYlcQ82jQWP01RMA72F
         DChw==
X-Forwarded-Encrypted: i=1; AL+hErETXhqZ257yHhYlu8AVeEwpA6bQU/d6RrcbXCy6SeGG+8kao+Y1H5bxlUHcC7Rbh4/jRC600WA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KyLmbJsH+sJu8OJyRn/73d7sk7MG3Y0KYEDXWvznVJ4VLg8Cq
	fioALZxjkV/ZuAJfJGgqT3mXBVOJhpg0xjfh7P2/OrqqGVLPHSwsDIQfP0vGh77rZn/3Opo9sMn
	CF/1q95mNBmFtzR4ELEmYZKDuR0dZRa7X6bKscWvVarC7htdG2Ff14oFPcg==
X-Gm-Gg: AZFdTZf3qCPCZwGA7DXw+GhwlBwfRarjFj64AIlpbmcweCw72MDIj7n5vRBf18aGPM9
	mWXeukqlTxuRj0emJ15+dmdI/AcOmNd78s1nvL45DKbzw5iF9Z2kSuKl2FrgAipSKqQILcoYb5z
	jKIwqmqeWM6qJhlclPTCLpuHyyOMCh/ptWVjCN5l5PqHH7sqcYlTwAm0l0PxkNn5kTMusPOaarB
	aAIW5gGL3SHJy+GIcp1NLAG9kr7KpD+gOwB4jsN2B9bsm0bEZLbDDuWHZ2QmCbTiQzf0xc10Qiw
	hk5Lf/ny/I/b5tMBwcSZUXVb6Dw3j7fJgXcXc/a/lQO2rlt38NnUaF2lQVPg6DB0HRrXDGvGE8m
	MXCYYGRGmWi4BJULyJuFCmEIc7Px8tWMP8WjiMIspE7USROBp7E2YHciOuFa7qdJtrshSZMM+iM
	NoTi2bSFcgxsDn6kGQRudjQI2bDlZkC6l2mXsG2UqU5quQ
X-Received: by 2002:a05:600c:8210:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4bb887e25e8mr430750295e9.2.1795709404055;
        Thu, 26 Nov 2026 08:10:04 -0800 (PST)
X-Received: by 2002:a05:600c:8210:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4bb887e25e8mr430749705e9.2.1795709403638;
        Thu, 26 Nov 2026 08:10:03 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865b1sm622216265e9.5.2026.11.26.08.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 08:10:03 -0800 (PST)
Message-ID: <bcbb57bd-6447-4faa-a56c-9bdf1c7bc90a@redhat.com>
Date: Thu, 26 Nov 2026 17:10:01 +0100
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
Subject: Re: [PATCH net 4/4] net: skbuff: limit folio refcount when splicing
 from sockets
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kiryl Shutsemau <kas@kernel.org>,
 Song Liu <songliubraving@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Rik van Riel <riel@surriel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Pedro Falcato <pfalcato@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20261118-skb_refcount_overflow-v1-0-5551b4954c3f@kernel.org>
 <20261118-skb_refcount_overflow-v1-4-5551b4954c3f@kernel.org>
 <14059088-7992-4d89-ac6c-1e6d1f61b3c8@redhat.com>
 <832f42a7-1d44-4138-a7f5-7cead4a28e57@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <832f42a7-1d44-4138-a7f5-7cead4a28e57@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/26 15:44, David Hildenbrand (Arm) wrote:
> On 11/26/26 15:18, Paolo Abeni wrote:
>> which is arguably ugly but IMHO no more than the tristate
>> return value in the current version.
> 
> That doesn't work. "len" you write in the function is not tlen ...

Sorry, I rushed it too much.

> __splice_segment() passes &flen.
> 
> Further all these lengths are unsigned int, not signed :/
> 
> Also, I think we have to respect spd.nr_pages.
> 
> If we want it minimal, a separate error pointer might be the easiest way to fix it. Still
> ugly, but I tried to get it clean above and there is no way around some churn I'm afraid.

I actually prefer what you suggest here more than the current patch.
I suspect Willem may have some other option avail, but he will
not back for a few days.

/P

