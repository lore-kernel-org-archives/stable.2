Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163293;
	b=ySfGGhB14UdmHw4N/Ev0hYZPwftLlhmH5jGAdVdOC0azZ5UFzFjdh8Y8Bqq2L+BKiT+A
	 r3mIh1PkQ8M8KAos4PIIXKdGcro9N+RJHPfVloanPpdGkcpn2uG0zFdtt/SCrL2LRLFCv
	 6yLhU0BndbNUE7XMGLzdDKJk6B1oa/4vTCAZZE0VRg6i9fTA4Evf32a720lNO3ZDARFM8
	 Z6f1JbAuuZB6LnWrrOGnPRawGfQ7Yj25UUolncpv2WZcX3xMbynlgkLTdUk3wvbDStjzz
	 xgFwU4nbflSl6npKuHE7klIpfKeD3xE0674VkGUC+uI+5bAHivL56T/ZfVMSPm0sSXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163293;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9+i5xixGIKGbTgxZ2JcYbfetPNWXyaA6+oLmNRQZiVY=;
	b=K4L9qCNQ8OT6aDPlV0DzbpBHUZwPlYDtqJ9LNXojNgnA+QcAAnUEG5ChW8gF4ddeux4L
	 V026v4dYJlV9JxjeNjda+LnhMJFCU0gY87DjzNbqh6FMuOuPZ9daCPYNYLnABeAJMq+Mj
	 tFm+qSeLpOnKABTuMqkEniHHJcdBocY5P2SYgfoqNCN7iQxT+R04CCLPV+soGs7ariRoU
	 U+Ae0RB/F8qGJfM7p3WiSeVD6Omp6QToHZ+QpJFlALh776Vk+GOlfh1JcE8nTxCPLQTVF
	 UYbiPUrVy80OXQpIrCNW6a4ktsopqMWpMlhNqmihiAVugVL4CdpgW34/ouQiT9gE0WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NsfE5jcp;
	arc=none smtp.remote-ip=91.218.175.1
Received: from mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6F7606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E6F7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NsfE5jcp
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9+i5xixGIKGbTgxZ2JcYbfetPNWXyaA6+oLmNRQZiVY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795163290; v=1; x=1795768090;
 b=NsfE5jcpRy9qjqGZxkB660ga0WmVk66uO3Au3RT3Ii31yhQjBTvCaHPEpSBNfH90l8NcwTKm
 n3ZZagErWQ/mkLuo1jOm8f5HO/gkufUVvu1GjW8zAf36UbGZvEkegaEItItIQPvswbwiHk/c8+C
 PQEwKYJqqLjb7Rwo4lSuAceI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0849da6ad725a7d9;
	Fri, 20 Nov 2026 08:28:10 +0000
X-Mizu-Trace-ID: 0849da6ad725a7d9
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	samarth.colleges@gmail.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	kas@kernel.org,
	david@kernel.org,
	mgorman@techsingularity.net,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jglisse@redhat.com,
	aarcange@redhat.com,
	peterx@redhat.com,
	bobbypowers@gmail.com,
	bgeffon@google.com,
	dplotnikov@virtuozzo.com,
	dgilbert@interlog.com,
	hughd@google.com,
	hannes@cmpxchg.org,
	cracauer@cons.org,
	mcfadden8@llnl.gov,
	gokhale2@llnl.gov,
	xemul@openvz.org,
	riel@surriel.com,
	shli@fb.com,
	jthoughton@google.com,
	corbet@lwn.net,
	pbonzini@redhat.com,
	seanjc@google.com,
	sj@kernel.org,
	ziy@nvidia.com,
	med08elkadiri@gmail.com
Subject: Re: [PATCH 6.18.y] mm/ksm: fix userfaultfd protection during merge and unmerge
Date: Fri, 20 Nov 2026 16:28:00 +0800
Message-ID: <20261120082800.23727-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <d81fe81c-be1b-4766-8030-9cbbe83428b6@linux.dev>
References: <d81fe81c-be1b-4766-8030-9cbbe83428b6@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Nov 12, 2026 at 09:42:36AM +0800, Lance Yang wrote:
>
>
>On 2026/11/12 05:54, Sasha Levin wrote:
>>> [PATCH 6.18.y] mm/ksm: fix userfaultfd protection during merge and unmerge
>> The 6.18, 6.12 and 6.6 patches are based on released stable and do not apply to
>> the stable queue, which already carries 2efc6332f18b ("mm/ksm: keep soft-dirty
>> when merging a page") in replace_page(). The fix itself looks sound. Could you
>> rebase and send a v2 with the two uffd-wp lines placed after the soft-dirty
>> block?
>
>Sure, thanks!
>
>> The 6.1.y series for 990d6c2194a9 ("mm/ksm: fix userfaultfd protection during
>> merge and unmerge") applies fine, but it has to wait until 6.18, 6.12 and 6.6
>> carry the fix, so please resend it together with the v2 of those.

Checked again. 6.18.y and 6.12.y have the soft-dirty fix now.

We're just waiting on 6.6.y. Did the soft-dirty fix get missed in 6.6.y?
