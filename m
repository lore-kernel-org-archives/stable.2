Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291514;
	b=n8giBttvdkLV69joFdqViCGwLiRBsDoUOVAmI8S+7xNqJkKkysvEdNtQ5dUdmChqZoCU
	 GGHNrUAFNZAXAjyEqAxEDu30Y+vHlbwD/o+l1AyZx64gn4iEBTI7lWqTbokididOR0JT+
	 uSI7S8QcllCtirSWJ0yJD9JQR2BxZZ3IEOEsEXAZ2Hdg3zznZ6yd9+5R2isaWcFAu2Z/p
	 +QuO1/Kbzou6PIh/I0EFX7+ZijgyWFTVDon2wWkSeSr0lrUm6LJdrPtif9dByxwLob3V3
	 ll/5OiPr9brUS+00NF5kZJAOwkjq3s0dfI6qR6vCH0O3BDBUPS9nzRutgGusgNaHuXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=alj3tH3ZvQk6KSugbPj+OZJPkIUe62frupKKgUNXdQQ=;
	b=gHp6nzxyfKMGSt07gEoL/hjiOmFL47cJEeapKkniK9YT0HUnqYUe64FSO0cCuATojabj
	 Y+B8u1bjZnqMctMha3IuIaVabwtKcBjsR+8O1U+SCsEc/hIzupWLHXJB1zNkpRJJfudNe
	 ahUTgjtFUILaldxHcEam2aV3Ezb11h/DcYYFB2Zk4u/dSoo68Omxbc48Jq+hpP5S0RyMs
	 rv3cSxn9goZ1ZOQ4kdbcU09HV+sDK3mSS0wewwATDCc+wsSiHoOaS0R0r3v+sVebwkQQM
	 UjKjjlidUB1ydYqDzmEO7oOy7Dl+g4d5Q7ZGdEKXZrG4qdAf4gGOrSE1vQhscoxmnCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="IlRv/HB4";
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569A606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E569A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=IlRv/HB4
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53381e53b80so27479941cf.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793291513; x=1793896313; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=alj3tH3ZvQk6KSugbPj+OZJPkIUe62frupKKgUNXdQQ=;
        b=IlRv/HB4pmk2+NxDwLfzjqCWH3uxCqOqqAYfjoJrsB6PHzPrgpOVmjoBbbHu0kUXsb
         PmW035eG/8UmGcDM424KwPgIj46Uwvl7/rkF7JXc4/YhX4FR14YSKjJkOW6U7bjgF28V
         0+3bqPsqxEXdwAtmgf1gIKhfH6yGdmXha5H7QYRjbT5RpWx4pHkOSQrs/Kj3lM5DxV43
         IWn7oGS9HKBkwd7T3+x9jFb69pxrdDF0u5Tk9LLDRqSuhwCZ4toGXMb19InDBaA8ucy/
         R/f9hQKU69V6OkYk1V+Hcs5iyUuPdS7SACfis+Ldliq0DOqg8D5ttsu1WrxHB3mdMTqe
         q+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291513; x=1793896313;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alj3tH3ZvQk6KSugbPj+OZJPkIUe62frupKKgUNXdQQ=;
        b=mun9TBW3iKb54cf17lHJY2ZSg0AX9vO4+zhgnxW89BQ8GXiiMKzPhlTteKwAHDYFVu
         OOOtgNd4fmIDosKE8NIVakb3vaZhCdffNYXMr1qr/EVEVdkdAWNVqmgzIkx8ICIHA4OI
         2JEAKKzwpFYu8jeBKxZmbbilbbInosI+ozo352u4OlcvJBHqRlZeALQs8Ye/jYLGP1hs
         qMFbYLRBxP+Ny+Sd3CmIV6IG3MG6PP8H8PpBNrCAsMmEbnlIgVw3I17kjkeG7TIu2AiH
         jz8AYnI5uhDuoBt4ClcaK9d5j4P5jH+NkFN9NrY3s9NuQws20lJluktQ6dPJGB9fVVAQ
         881A==
X-Forwarded-Encrypted: i=1; AKwUvBzIB3j04rJe0IhOQ08XRaJ25OgUvrm/Ikp3SVy/nPVuLM2DfGr/YcuCRTkWJAHsMXAEXZZ6+PI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwTD/NMWRzhxvcDAkaE/Eidxt8dfFWGzlwd91p2QYVFYHfbfOF
	K+F+cpfMsmJQEWBqV9Dgt0U4kSQEnx2f9YNkOOcRf1tWmLiRsiKuf51secIxr6XG33g=
X-Gm-Gg: AYBFou1RHytlDjhWngQK+VxRR0vR+prBAeTbPqkVXbcsiJbYBotvI/Axf0xoQwLrC5K
	okc4CIaSUC6wazTHhAFX8OYVgkbaIFXdttl/6BYxx8JoM7JNOuc+/iTrL2TGft30atdXAkthDCs
	raOAD97k66pubdhpYqFcuL9Dczsov2kuMjniIkVMqdcA5sh0Rd27WKE1wsfsSJeJgGKbcd01GZz
	9BTDj7fmRKXnsUEy6nd2Rq7DFqs9keTu9JsIOTLWsRrjNTcBW9G11TaOae4AlIxKmFTTN+Usst2
	aRL+EJ4kP7E/dk6gMrWfT5zNGIIYmeUrM95JV7pTHPTyDXDAc3TGC4otHvWocLsrSr6LlgY8e5V
	hxuULtaXhdWhjA3/7Cvtmqp/GKPBb3DCp1D27yfSKtAhMI9QhgY9q6+0eL+5Kr9ThVsAFwIlPdm
	JrP1FHqWMH5Ue4u9hmOJm2Zatel98/MMD9tvcZ+tsv313zAQRvifAZNiHTvIsvo5kqUK+nzQWdr
	fp6NRCM89x26YVeaw/6k+AelOVUYLp8nn60CXb3u/JRuH7K0bCMQULTGRkZZXq+l40dSa21u4M5
	pdteej4AnMlJ+bSOyvPAF0nfUwfdVUORhzTw2Ys9s15KREAWlDFldNWhJVj/b7NIiH31wEZpQaI
	C
X-Received: by 2002:a05:622a:888f:b0:535:a5fc:3b58 with SMTP id d75a77b69052e-53fcd191600mr104371091cf.68.1793291512757;
        Thu, 29 Oct 2026 09:31:52 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5428cccee9asm45321cf.13.2026.10.29.09.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:31:52 -0700 (PDT)
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
Subject: Re: [PATCH v4 1/8] mm/page_alloc: reset can_retry_reserves when
 the slowpath restarts
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, muchun.song@linux.dev, 
 osalvador@suse.de, david@kernel.org, akpm@linux-foundation.org, 
 ziy@nvidia.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
 ying.huang@linux.alibaba.com, ljs@kernel.org, liam@infradead.org, 
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
 brendan.jackman@linux.dev, hannes@cmpxchg.org, mgorman@techsingularity.net, 
 anshuman.khandual@arm.com, stable@vger.kernel.org
In-Reply-To: <68fd8182-cdfb-4f11-95de-1472e6c92d33@kernel.org>
References: <20261028211930.3504634-1-gourry@gourry.net>
 <20261028211930.3504634-2-gourry@gourry.net>
 <68fd8182-cdfb-4f11-95de-1472e6c92d33@kernel.org>
Date: Thu, 29 Oct 2026 12:31:48 -0400
Message-Id: <179329150807.2127828.16376500334625424120.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-29 14:37 +0100, Vlastimil Babka (SUSE) wrote:
> On 10/28/26 22:19, Gregory Price (Meta) wrote:
> > Commit 2c4c3e29897d ("mm/page_alloc: simplify __alloc_pages_slowpath()
> > flow") retries an allocation once with reserve_flags when the caller
> > becomes eligible for reserves, guarded by can_retry_reserves.  The flag
> > is set at its declaration and never reset.
> > 
> > A restart after a cpuset update or a zonelist rebuild drops
> > reserve_flags
> 
> I don't follow, nothing "drops reserve_flags"? after the restart,
> there will still be a get_page_from_freelist() without them followed by
> get_page_from_freelist() with them, right?
> 

"Drops" is the wrong word, sorry.

After a restart the reserve bits are recomputed, but can_retry_reserves
is already false.  As a result no-reclaim/PF_MEMALLOC callers don't
get a reserve-retry attempt (we just exit w/ nopage).

Reclaim callers are fine.

This problem exists regardless of the rest of the series.

But you're right, I will rework the commit message.


> > Reset can_retry_reserves at restart.  Only a cpuset or zonelist change
> > restarts the slowpath, so the retry still runs at most once per change.
> > 
> > With kprobes failing every attempt without reserves and the first with
> > them, and a memory block onlined during the walk, the allocation
> > returned NULL in 3 of 3 runs, and a page in 3 of 3 with this change.
> 
> So IIUC the allocation was racing with a memory online in a way that it
> would fail if the online happened fully after the allocation. So this just
> turns part of the race window into the allocation's favor?
>
> I mean it's not wrong and if patch 5 depends on it (unless it also only
> fixes a racy window in the same way I think is happening here) then so be
> it. But the commit log would need correcting.
>

Not quite - without the online it would have succeeded.  The zonelist
rebuild rewrites the lists in-place, so a concurrent walk can miss valid
zones or pick the wrong zone.  The rest of the series detects more of
these restart scenarios.

Those restarts then exacerbate the issue this patch resolves.  For
example, patch 5 would free a reserve allocation that succeeded - and
then fail because can_retry_reserves is already false.

-- 
~Gregory

