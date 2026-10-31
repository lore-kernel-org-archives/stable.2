Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465627;
	b=5kTpcbq9AI+btVe4vRoUgwhGbWeihdKgxMJ7JH1BNyfmqVyp2E8Atji+txCvzNTYvNdQ
	 l/sISFMRp3UAI4ToDClygqSPere05Z6EEAvKqT1S/PtjcgrT79JyGyG/K5npXa/MR5jiP
	 UWeBEfL7IWTtxdKn2W5fWWsyHoDlWcvgXipmADYf8Vv96LWjEFeMi542cjp9xqwa2TxPh
	 FVAsl8GuVWNcqy8Jhb8FI3lWbG8F5GREMEiKmI+AGq5bVC6qYg90k6EszTb2jdfqQlNKp
	 3oxn7cdY0CLteScoiSxyj92f8IVxBrqbhthHhbnFa8DiLNEOzExSa5A0LDqmjSxqYKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465627;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WXG/VuGgA2nLHyyo2HBxCIFByTCjqyBPDh3lixMNfY4=;
	b=S9kran24E3KYgeAKZ/0GqwmqTaVvya1Nxly62HnQteq7MY4d89yV3shqe5nqwquhwwfj
	 vrbQQKPm90X/RPitx4AOTwvmWJ7SnOP96w/4yqZ46dnRig8w5q7rFHyy0az1BvAliI9SS
	 5y4Kg1fcnAu8vwZFmDcW4C+d6TR3dZyIg9rqZJzajMWruAiZ/q5kxAhPPWbNCy4bK9lar
	 FAD7vZ8t0xMLOd6nneb+nhg3SzO8vxdq+Vk5H7gM2oUiAb+9QIe4LXxy10ZZM7MGeBC1F
	 OcOEsK30XD6DZ3MuPNF59jf7M2++sXVQpQDGJFaKuHDzeP1klDBKTkXTj6futcB0Yww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w0+M577m;
	arc=none smtp.remote-ip=95.215.58.196
Received: from mta1.migadu.com (out-196.mta1.migadu.com [95.215.58.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E6606A31E
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 16:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D9E6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w0+M577m
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jade3sx8Nnul+MHi6aqoKxBIknYtcAapdEpzanu8AQo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793465624; v=1; x=1794070424;
 b=w0+M577mVaWzqtdSUI3kEqiAiA64yOA9tnImxrrKnPp7n5JJoXbPlfWGM7FwWuWM5y06ESp5
 MUs5SfJhO0QzMIWJKGHpN+UTN31dxavlleBVkc1FZp9bbfIK9kTN81+qB4EclE5K4IcYPCdnAGV
 6PrUwCvKHgOS1w4QSUcd0Co4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a73ddf1f7291a74a;
	Sat, 31 Oct 2026 16:53:43 +0000
X-Mizu-Trace-ID: a73ddf1f7291a74a
X-Migadu-Flow: FLOW_OUT
Date: Sat, 31 Oct 2026 09:53:38 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com, 
	qi.zheng@linux.dev, baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	ljs@kernel.org, roman.gushchin@linux.dev, dave@stgolabs.net, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: vmscan: don't count per-node proactive reclaim as
 memory pressure
Message-ID: <auYc-G488bbhy9QY@linux.dev>
References: <20261012022917.1102467-1-vernon2gm@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012022917.1102467-1-vernon2gm@gmail.com>

On Mon, Oct 12, 2026 at 10:29:17AM +0800, Vernon Yang wrote:
> From: Vernon Yang <yanglincheng@kylinos.cn>
> 
> When the cgroup has no memory pressure at all, writing to
> /sys/devices/system/nodeX/reclaim triggers proactive reclaim on
> NUMA node, causing increase in the writer cgroup's memory PSI.
> 
> Due to this reclaim is performed in the context of the write(),
> accounted as memory pressure on the writer, like
> commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
> as memory pressure"). This is unexpected, the similar scenarios (e.g.
> senpai) will continue to occur, only this time it is for the
> /sys/devices/system/nodeX/reclaim knob.
> 
> The Documentation/ABI/stable/sysfs-devices-node documentation also
> notes that "This interface is equivalent to the memcg variant."
> 
> This patch unifies the semantics of the memcg and node interfaces:
> per-node proactive reclaim is no longer counted as memory pressure,
> and the per-node proactive reclaim interface no longer produces
> phantom pressure.
> 
> I ran demo[1] that performs per-node proactive reclaim 10000 times
> in qemu, writer cgroup memory.pressure as follows:
> 
> without patch:
> 
> some avg10=31.53 avg60=13.42 avg300=3.31 total=10602985
> full avg10=31.53 avg60=13.42 avg300=3.31 total=10602985
> 
> with patch:
> 
> some avg10=9.59 avg60=3.41 avg300=0.81 total=2686221
> full avg10=9.59 avg60=3.41 avg300=0.81 total=2686221
> 
> [1] https://github.com/vernon2gh/app_and_module/tree/main/reclaim_node_psi
> 
> Fixes: b980077899ea ("mm: introduce per-node proactive reclaim interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
