Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602581;
	b=Os57MZkKJ8oZKKKteaCNjs2U0T25keyMHdUgm+V+axYyAkXUKw1aS6lmjVAx6tAibsrF
	 ZD7hbKZ1DgkNu93pgpz959bKofTSEiUiollQ1z8pGtTxrJnF7rdHPK49W84i9VVaf8MuB
	 YaJDW+TZoF5iEjYVHZg8SmsRxf1+n6yZrxOMFLWCaON5lt1bU8llK5+6/s+waci5lGw76
	 Xnong/lpcADAeiIBlBchpbLVVKnhiCImOrV9Y9U6cyXE4KXDkqb8UCow03fL0yWBWn3Yx
	 RfBDiabq+2nXRNHJMWfa+VHw7eEWEOw8XrmJtKy6tiK0IsOjA7ykcCTGx7Hi6mQX5sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=1UYRjKetNPMdOuEAL+DzBuZJ1WB5Vji040ubXNb6Aek=;
	b=dZ6DeB6SvjOg8uDIzEn/nxN1Gih0pYVJIHHXXHO5bpJsgcUkf4cNd0RaYv0Mjs3ycXX2
	 JFoXst+Zpa0YWE+3tZD6pGJgE/gbSyCAYU59e7Cal4VUNTf7vUzSRT+VNh4f05ev7QTQ7
	 7d0Z9rKI563NnM/IOAQlLLNQy/GYOIfGLw7FvfpxpE2yq/3//Tn4J9e1hDAfzrZ11ufJc
	 xm5qqPbB0gL5TKVf1rmDSf++lbIskmT1jI04bFgAyb8oUPmr8rjMzOFvptwDLDBJV0vA1
	 HaPsv0lFRqqzLnAbE3cSNX9GgqHoq7IAEpGLCj14XLkGChR0dLbc8cYpFbzhfXnct5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="e/GmYoEB";
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052B606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1052B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e/GmYoEB
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5366ae57896so22976431cf.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794602579; x=1795207379; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1UYRjKetNPMdOuEAL+DzBuZJ1WB5Vji040ubXNb6Aek=;
        b=e/GmYoEBC2/CDjguAsg+P6LqpCxzE9o9K2hOQ4GT6Gk8syKKGC1vAQmV/Z4rLZY16m
         +8oEzYhB+JQ6HHYRlRgQ1H0WtSXyUS9t1CHyxVUcfQfeyJkskhnfkBVZz5vqQk91yNXm
         ih33+ivo+U+OL0p7cV8pz2wRhbYwWtl4E/NygVma1BGpaTx3eyQo4F0O6i7Vy7/SfTWa
         y50vg3nA3C4ZuBvrCMulyrxX4vinodrlNubz0Ni7jLlkKddGHJkRJf1eMJPX8zzTsLkf
         MGbI9IL5k664+xJszHfsEXuetF2KNdCqjj3zkMcBFXbzrO3XG7H+kVlWkaFGGf/zi4wv
         inHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602579; x=1795207379;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1UYRjKetNPMdOuEAL+DzBuZJ1WB5Vji040ubXNb6Aek=;
        b=QdTv4mxhb+PLolXXzqtodJdDj21JGCXFacFcupAXbQD2WDms98dLS+GxQ26H5Z9NbF
         L5wycv5qGbLJOlcX6orJOTLnM7c8W1vmhgxkr7OjYVmrPHGQeTtyiA6WUm7e8MLu5kX7
         RhghTpAxtpCxmyAMEqZacyxzyIQfBEbCbz9pD4oGJ2e1V9LlUVgjQmtC1cvsF1FbOQ9u
         EjHg+oykShp8rPtBSLXLnvsIzAloeO+hIj8vJpyxeWq9217UGEBH6XqMJNekweDOy1aA
         H8a9Ela1trEaUQ9WTO4jG4yda1UeFiNGREgou7JXx4+5efw+jdMU6aKUE4bzhtLTXT+y
         E2bw==
X-Forwarded-Encrypted: i=1; AL+hErG9qLUP30Ts3tg4NUXjG/dD9d9cVhhTQgakOGUZvEzKnt/o2+4e9UdtQ8krxfYpD6va76tlasI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IhBiYWzSBhBW6va+MIzNg9ttx2PSnzJwoeNUdU1rd53+y6jRx
	b2r10zgt4t9lm/QuYnTMMUAHPfOxloOJ+kOtWL/ChzdqLa3K/7zeMYfFI5irUEBEi6Zw2/ex3Ts
	Np8G5
X-Gm-Gg: AYBFou09kGt6w52FWBjK6dPnY5k34TdbOWFHgOY97UXiUNF0XzYoPUS6OuA5288jH4T
	QTzR0qyIH02Xy/tZYZnLq72rZubO2H6FkcvyVyi9zJkyDaZRTIeQK7ckyqzhxbeBJujrAjMz+bu
	lxuDyvytWd2e/wXmmF6Rc4ksBWrAUTwguDSl037melo+cGsSrd6Y8PG76XVgW8f2kpE/GRIB1j9
	WPdbbJAfyLduXy++5CfByAOwt4oDL3b2LO4+4k+aBttqPjGbB/0DZqYQ8XeEqsqVKX0w50Z950P
	EqgHcJjwGs32rv3WqgX3jM2N8a6XCXMQKCwKaQoUbwNDnQXyT3jnMUPPyE9rt1fIF9AO61dNc5i
	NNoEEozwq/+CSZ43fEiYMGwE0qjw5TzwW+FCTpfGa/ldX7fw269VvxOEyXC4VDkrSplKeoJdYTq
	4cy7n4i3SwiKC/5J1yfejzsKqFJEMrSCkIOiNUFgIShUw3cGMQ6mNuBVeiGf1qMkQZCIlCNWIp+
	HMP/Eb2JdKM2Xiyo+cKeIX5+YSp9fGJ3RvBbBVLO5NPdgbe//oQGeroaSIeugDOBId+JFCkuGMz
	qv9s8u8HMHvW91NwMwGk6xCc0fruKI7Divb02tfNF8pnWsZdaLvm3pEswDhltc8ElWf1dyegJ5n
	M/mDQuzE=
X-Received: by 2002:a05:622a:a882:b0:54d:72fe:f3b0 with SMTP id d75a77b69052e-55ac8b983e7mr58211941cf.48.1794602579094;
        Fri, 13 Nov 2026 12:42:59 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55c3b7a4adbsm3582051cf.19.2026.11.13.12.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:42:58 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, jgg@ziepe.ca, 
 leon@kernel.org, akpm@linux-foundation.org, kas@kernel.org, 
 dave.hansen@linux.intel.com, bp@alien8.de, rppt@kernel.org, 
 stable@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
In-Reply-To: <69e27ce5-8378-489a-ad8e-37c364cf63c5@kernel.org>
References: <20261113195536.2660763-1-gourry@gourry.net>
 <69e27ce5-8378-489a-ad8e-37c364cf63c5@kernel.org>
Date: Fri, 13 Nov 2026 15:42:58 -0500
Message-Id: <179460257810.482102.3687220421358656606.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-13 21:03 +0100, David Hildenbrand (Arm) wrote:
> On 11/13/26 20:55, Gregory Price (Meta) wrote:
> Cool, so I can drop
> 
> 	e27dc0754e3f4 mm/hmm: refuse shadow stack vmas in hmm_range_fault()
> 
> :)
> 

Haven't seen that one :], i suppose *yoink*

> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> 
> I used the comment:
> 
> +        * Shadow stack VMAs must not be written, and there is no particular
> +        * reason to allow read access to shadow stacks from devices, so just
> +        * disallow it entirely.
> +        *
> 

Seems reasonable, maybe addresses Jason's request for additional
context.

-- 
~Gregory

