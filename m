Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276608;
	b=iD77PRA+RpttFzCwbomV7S9lYbS0mngXQU7vb3wVWS31EF84WSgkZJab+smk5S3GlWQ5
	 9BX0jYR7R7sSieMzhI5zEmICwY+hNf0xjhM3lrbO7H9/ntFsMsCW+MpmMshwl/NpmfuuE
	 M2UJYsQ65kcHrW1UDH4kNZB1jc2NGleg0xhGIeHqeuaVpud/6CrVzwQUomiklE80cgZWH
	 yScPV5NDGG9MTtYgcTt8Lak8BFvxYLkDlQ4l99QgQwN0s1iWWChnmrMfvg11dQ7catY7Q
	 2xub9A/ptml3L9R9cZ+eI5NqepEYj7cxN4rqN9W2bsdLYjMD+gVwHXVaTx5wvUbk/gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276608;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=SYxtGMKwalYgdDriaZyFlHUIaJ1hNSA/fziq3mU9ZJg=;
	b=rV5fSIF1ZvASsbF0/p043DKTPVMvPrjuxgKMBSExX9JVK3Awds890C7eq8C5GRQw33IB
	 cUXzxBNKPFs0nyJL1BfZT01N8+KAi6GG2H9zwavpeTDRR6+GW/GfAy9VZyOnnEw0ksTjy
	 p+7vQXxSPE5m9PtICjSwOcDvr1ZUtHHOu526Mo7pCqJtbyEYfpTte7hTDQy/nLBJJvjBR
	 7z5OjkKqx450E/9qrv0ABQxpKZVQ+cKPzNJZ+kv3SK9KBWgI+3sUlDCDuyZeWSnBzyqK3
	 cxaTr7syj1IG2+PMVLNrRmc84rOjf2HxwSOMPx8ldzSbaVQFYi2wJx2TJMcQ14L0FaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b="J/+peoyT";
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3584606A31C;
	Tue, 10 Nov 2026 02:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3584606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=J/+peoyT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1794276057;
	bh=SYxtGMKwalYgdDriaZyFlHUIaJ1hNSA/fziq3mU9ZJg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=J/+peoyTckvyOebwJs3HH3XUZndKvgCzp4omBxJFi1Ij2fydyiMK6WJQpmH2vqimi
	 2QgqVLI/z1mhJ4jgbkdfjAfy8MTjtr1qaouYL21fg3hYR3VCYJTzFywkl+nWIzELyi
	 rizQKtUoHRvCu1BihZt+ED0czRL1z4aN0DDNKyyc=
Received: by gentwo.org (Postfix, from userid 1007)
	id 9D2524076D; Mon, 09 Nov 2026 18:00:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 99CBC402BC;
	Mon, 09 Nov 2026 18:00:57 -0800 (PST)
Date: Mon, 9 Nov 2026 18:00:57 -0800 (PST)
From: Shubhang <sh@gentwo.org>
To: Shuah Khan <shuah@kernel.org>, Lu Shuaibing <shuaibinglu@126.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
    "Christopher Lameter (Ampere)" <cl@gentwo.org>, 
    Davidlohr Bueso <dave@stgolabs.net>, 
    Manfred Spraul <manfred@colorfullife.com>, 
    Jan Koester <jan.koester@tuxist.de>, Cheng Yongkang <teel4res@gmail.com>
cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v3] ipc/msg: fix msg_qbytes truncation in IPC_SET
In-Reply-To: <20261029-ipc-msg-qbytes-v3-1-fc3f4307c85b@gentwo.org>
Message-ID: <166800aa-ef71-24d6-39a7-11d1e29ae0dc@gentwo.org>
References: <20261029-ipc-msg-qbytes-v3-1-fc3f4307c85b@gentwo.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hello,

Gentle ping for v3. It addresses the issue identified in the v2 review,
and the targeted selftest passes on the patched kernel.

Please let me know if any further changes are needed.

Thanks,
Shubhang Kaushik
