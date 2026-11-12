Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450435;
	b=ARJxOhFYN8vFqCMCOew2reC9vofdNWJN9iAEL6+IkAn5fChlGy/4mejyDyiA3m8ldQNw
	 MXJ0Md/qpS/H0tgr/s0pc+owCL6pCdjvkuI1CbLKCy8g5IwaVMjT5Ahri6p71sWa96BGv
	 di170W3ytmf+Oe5pt0SEYcKeuouznvlXE47bQyfvP+X5f4enMEKI5pCnF0BQVhMbdp17p
	 xeocynM2Nb+ApLEzGdIfWY9jnUFJOFf335Bo5ysf3utW+d6Z4xiTl/sC2tUBxUs8oQ33z
	 QvjKG53Oq3kHnSb29rVYuFNpeWI8Bbf9AaBWm3Hs2JLFVCdENOMbnox5/OHfyrdtYhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450435;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=2kXQUvq0pMfnz4HzoTzQFMbsuHXEC2i6vljk1NL33ts=;
	b=lwX/4/G7juoIgNrTpynbzKc8kpQTIwxV1YtMHpaGSG4EviaJ/X5kVAiU3ghSClOc2iK1
	 jAksPFPU6nP4sfyieOgbjNk6/QxFaJQ6sBIS5phXSPlnh8H83S5IahxIWKoe3RhdiF3BL
	 ZDfHkgpBnEm4/DRudqLQ29c/7zjW2b4oMFFbSAOgtGEE278IwIQCiuxR5t4/OV2+9VcN/
	 DsgWIv78DbUY549eHKGOoQ5EVTyaPMhhKWGqLpmkqHbcjJHCIFbmBNwaMXFxjO+oUtqKA
	 TqQcaIPPUDszc4bR9x1MaElZ0wPDVnHIfnCYwT+C9YeLQyVB1DmJKWLfM0WiNJsH8ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="i/H2hxN1";
	arc=none smtp.remote-ip=95.215.58.187
Received: from mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D92606A326
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2D92606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i/H2hxN1
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lsq8XQTPFu5wkpyrYlGgMAgRBeoL0TX9wwuTx30+lDo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794450432; v=1; x=1795055232;
 b=i/H2hxN1wgzBhaueWtScsLuQzMUD+RLCn6qIqP9BunWdm36qayynlHwqyVDYy8yZvY7w0f/c
 +bWmVJ7Dernv/v9KUsPDxMlTBmRvTpyjDfZrCaH+VanmPJxO1LUoOsNUnAUwq+Gh9Z665nDkmWk
 5wCk7Qkst9lPERceSJBfZZkM=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 6e62475f303e8754;
	Thu, 12 Nov 2026 02:27:11 +0000
X-Mizu-Trace-ID: 6e62475f303e8754
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] memcg: flush nr_charged_bytes when the obj stock trylock
 fails
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261112013220.4064478-1-shakeel.butt@linux.dev>
Date: Thu, 12 Nov 2026 10:26:56 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 David Hildenbrand <david@kernel.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Vlastimil Babka <vbabka@kernel.org>,
 Meta kernel team <kernel-team@meta.com>,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <16F05AF0-BF45-4206-8B42-0D2AD6CA2B20@linux.dev>
References: <20261112013220.4064478-1-shakeel.butt@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 12, 2026, at 09:32, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> When interrupt code, such as an RCU callback in softirq, runs on top of
> a task that holds the obj stock lock, its trylock fails and the bytes go
> to objcg->nr_charged_bytes. Nothing empties that counter while every CPU
> using the objcg keeps it in its stock, so it can grow without limit.
> 
> Users see memory.current and the "kernel" field of memory.stat keep
> growing while the cgroup's real usage does not. With memory.high or
> memory.max set, the cgroup is reclaimed, throttled or even OOM-killed
> for memory it does not use. The counter is 32-bit, so after 4 GiB it
> wraps, and those 4 GiB stay charged to the cgroup and its ancestors
> until reboot, even after the cgroup is removed.
> 
> Fix it by uncharging the whole pages in nr_charged_bytes whenever the
> trylock fails.
> 
> Fixes: 200577f69f29 ("memcg: objcg stock trylock without irq disabling")
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: stable@vger.kernel.org

Acked-by: Muchun Song (ByteDance) <muchun.song@linux.dev>

Thanks.

