Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F01D416C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784637132; cv=none; b=CVLg0KrG86GHDR6XlfiRXHIlEcUt0sDAZayiogPv4u2fZxELFjGI1+RkNl6EhX9sguP5BqmJtBDdW/rb3+Ic2TVvpwo8wAVQoWfBK1llIJ7l2JT9w61B4+nXsMHAKC+812nylOVrpkq2P6yuYm1tCcPulC7gUGyV6wLaA6Bylww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784637132; c=relaxed/simple;
	bh=nY7DnnzzmElMSyHiuhMCgbyowwuaTPe7GX5RQdAmmEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeNIIjd+LjwfNqB9+LtjDYDAb+gAcCm4FMCugCawfqSkQyDCrdAXj+wAPNEkHh4o+3zFAnZav0MNyW6Vlfp61qISUB6QwYrYUZ7DSe7kWOEIUfgMn9igSPYo4gh2d50YbDP36CLJiYrOAkS+PACzRviGUiWOx7wURKbDrq1+ibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gQrTeC9F; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gQrTeC9F"
Message-ID: <68c2f52f-8d26-4325-b567-4e99597922f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784637128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q65LQxTH7P5MnN4PrDsN4BJErnDygKIsrKqfzVP5ncQ=;
	b=gQrTeC9FpIZcTs+d76ZU0PT1Vzmf0lEyRvmXmYqIAVjj1ApP0ozNfGyPpjQyCQfws2ad8h
	fxkXVS9Z4p12t2QdSc6V8q0CmJxZd5rIvW4Yi5W+dgZClimI+svf4KifWbzIGnp+JZGh50
	GcvvleW9MbTkhh5rxbPAzadO6DQ2usI=
Date: Tue, 21 Jul 2026 20:31:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5.15.y] netfilter: nf_tables: restore set elements when
 delete set fails
To: Sasha Levin <sashal@kernel.org>, Sid Kumar <sidkumar1@gmail.com>,
 stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Vegard Nossum <vegard.nossum@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Acs <acsjakub@amazon.de>
References: <20260624213654.2762749-1-sidkumar1@gmail.com>
 <afa30b9a-07fb-4f21-973a-72bc7ceeb9e4@linux.dev>
 <20260721120236.100005-1-sashal@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260721120236.100005-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/21/26 8:08 PM, Sasha Levin wrote:
> On Tue, Jul 21, 2026 at 05:07:00PM +0800, Jiayuan Chen wrote:
>> Is this patch associated with cve-2026-23111
>> (https://fuzzinglabs.com/repro-cve-2026-23111/) ?
> No - this patch is the 5.15 backport of the CVE-2024-27012 fix
> (upstream e79b47a8615d), a different vulnerability. CVE-2026-23111 is
> the inverted genmask check in nft_map_catchall_activate(), fixed
> upstream by f41c5d151078 ("netfilter: nf_tables: fix inverted genmask
> check in nft_map_catchall_activate()"), and that fix is already in
> linux-5.15.y as commit 8c760ba4e36c (released back in February).
>
>> I'm verifying cve-2026-23111 in latest 5.15 stable, but I can still get
>> garbled text by running 'nft list maps' like this:
> [...]
>> Does that means cve-2026-23111 is still exist in latest 5.15 ?
> I don't believe so. What you're most likely reproducing is
> CVE-2024-27012 itself: released 5.15.y still lacks this patch, so
> nft_map_catchall_activate() doesn't restore catchall map elements on
> the abort path (there's no nft_clear() there), which leaves a freed
> element visible to 'nft list maps'. That's exactly the bug this
> backport fixes, and it doesn't reintroduce the inverted check - the
> nft_set_elem_active() test it builds on is the corrected one.
>
> So this patch stays queued for 5.15. Could you retest with it applied
> and confirm the UAF is gone?

Yes, after applying this thread, the UAF disappeared.

Operation 'nft delete chain inet mytable mychain' will rejected just 
like 6.6 did (I'm also testing 6.6 stable).


~# FILE_BASH="file_bash"
~# nft flush ruleset
~# rm -f "$FILE_BASH"
~# nft add table inet mytable
~# nft add chain inet mytable mychain
~# nft add map inet mytable mymap { type ipv4_addr : verdict \; }
~# nft add element inet mytable mymap { \* : goto mychain }
~# nft add map inet mytable triggermap { type ipv4_addr : verdict \; }
~# nft add element inet mytable triggermap { \* : goto mychain }
~# cat > "$FILE_BASH" << 'BATCH_CONTENT'
delete map inet mytable triggermap
delete map inet mytable bonjour
BATCH_CONTENT

~# nft -f "$FILE_BASH"
file_bash:2:25-31: Error: Could not process rule: No such file or directory
delete map inet mytable bonjour
                         ^^^^^^^
~# nft delete map inet mytable mymap
~# nft delete chain inet mytable mychain
Error: Could not process rule: Device or resource busy
delete chain inet mytable mychain
                           ^^^^^^^
~# nft list chains
table inet mytable {
     chain mychain {
     }
}
~# nft list maps
table inet mytable {
     map triggermap {
         type ipv4_addr : verdict
         elements = { * : goto mychain }
     }
}

