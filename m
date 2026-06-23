Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02983CE4B6;
	Tue, 23 Jun 2026 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204647; cv=none; b=C1c11Mq2Je1Nu50Mk1d6s4LzN8305SXvblNHlQavYTVCyK6N6ssQme2HIM7sLi6lRzht24o0OB/IMtr1As/gNBoLyTo8af00gM0MgnxtQyR3HRAQNzEJh1bON3bE/yM4vTeAV2/39tv7wB44MIDHt2dxCaf8Vq0dBWPSfWWe/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204647; c=relaxed/simple;
	bh=ymyLnNo2wfX+1LVNgsG48XC8G/ZktpRxoS4AYqmXBes=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IeXOeiMixOGqG6KoVkPWRXND7y/U2OWfZqbJ9GnLY4aFAERuLtGyLFGudzN2/ZCEmRyd6PQoicjZtypud+DTc4bf2X5F7oPauqY+Sve65UJtoOcnCkTk1E9flhHW/FabbSUgowO1cTv/wfLgCPvLVtOT9nZkbv0Hv/cT8/mwLlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbF7w1y+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbF7w1y+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B561F000E9;
	Tue, 23 Jun 2026 08:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204646;
	bh=0YLaSGVbAXAi4eLXg080mHSZJtv4thCtHhEgcK7CLFc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=XbF7w1y+9xegvP1N0qKa+yoV8eSwctsa9IO9SJkio6qCWJQYyhbYceQT+hJruf4PN
	 nvOeMjQVFy3UBMmQ7uhJy8CyrDiW+JfmhhRQOduCOktcNKiWg2rOFNz7lQdUq7g6DO
	 IjvN7N+JG8p1S/YR15CrbE1DX/K49zYxtRAxIPh0omew5DFArbqX7Sr/relWMs1Roi
	 oWwj4EUWXkRVPm+Ao10nRj7BxKDBYnKj04U/yPXhxAcHc0J2C6RaQsIiLGAWRC3I4K
	 6+Ek82Wnt4CRBy88v79ysZKj30PpVaJmNwaM5NvHIQYr5eSAQiGRLPuRfJeW91Mam2
	 DQHAP9cWVyAEA==
Message-ID: <ddfa2884-c5c7-4cf5-b857-b9ad8d55736b@kernel.org>
Date: Tue, 23 Jun 2026 16:50:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daniel Lee <chullee@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org,
 Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: Re: [PATCH v2] f2fs: don't drop the top folio order in the
 f2fs_iostat tracepoint
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <69618bed-db94-4503-aa9b-c78fb51a945c@kernel.org>
 <20260623072641.3547410-1-zhanxusheng@xiaomi.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260623072641.3547410-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 15:26, Zhan Xusheng wrote:
> The f2fs_iostat tracepoint stores the per-order read folio counts in a
> fixed-size array and prints a fixed number of buckets, both hardcoded to
> 11. The sysfs iostat accounting array is instead sized by NR_PAGE_ORDERS
> (= MAX_PAGE_ORDER + 1), which is not always 11:
> 
> 	arm64 16K pages -> MAX_PAGE_ORDER 11 -> NR_PAGE_ORDERS 12
> 	arm64 64K pages -> MAX_PAGE_ORDER 13 -> NR_PAGE_ORDERS 14
> 
> f2fs enables large folios for immutable, non-compressed files, and the
> read folio order is bounded by MAX_PAGECACHE_ORDER, i.e.
> min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER). With THP enabled this
> reaches order 11 on 16K/64K base-page kernels (MAX_XAS_ORDER caps it at
> 11). So an order-11 read folio is possible there and is accounted into
> index 11 of the array.
> 
> On those configurations the sysfs file reports the order-11 count
> correctly, but the tracepoint silently drops it: the memcpy is capped at
> min(NR_PAGE_ORDERS, 11), so index 11 is never copied and the trace
> disagrees with sysfs. There is no memory-safety issue, only the order-11
> bucket missing from the trace; 4K-page kernels (NR_PAGE_ORDERS == 11,
> max order <= 9) are unaffected.
> 
> Size the array and the printed buckets by a ceiling that covers the
> largest possible NR_PAGE_ORDERS (14) with headroom, and add a
> BUILD_BUG_ON() so any future growth of NR_PAGE_ORDERS fails the build
> loudly instead of silently truncating again. The human-readable
> "order=count" output is preserved.
> 
> Fixes: cb8ff3ead9a3 ("f2fs: add page-order information for large folio reads in iostat")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
