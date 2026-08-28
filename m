Received: from mta1.migadu.com (out-112.mta1.migadu.com [95.215.58.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4418A6DB
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887627; cv=none; b=GEuy3nuriT1UkN/X4yLxwcnTRKquDaQPPK/+sXtqosGnVu2hMxC/PbDwdNWszKE9fRhJnKr/awP9zONczujx73CY0S3ALaBNvfhfTk+UWlqaV2QsYU8TWWKFhFcCLZfPXFoyU4dhkMXqXwhYcyUtFB3bI49MYksdH7Lr/GCjKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887627; c=relaxed/simple;
	bh=Ts1xVkuWbeJd1rXe3DJ7aP7vZaIUXkgyACVVNVNZJZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdT/GPc+QW9HhNaFxDPlDfMB5bEGcmIFZ6XClxUzsvpvaKwl7XBhnYb1ir8jWnP0J0Td4MYi9k7PcuAsZexdMxyfgBY/preBCswIUAa9WZ8weBskmrh0ZQHMDgqLcuHWloKJGbb1KqRwzICqy5T6PN4k9/hXccokC6yvenONFpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p7PYntHp; arc=none smtp.client-ip=95.215.58.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p7PYntHp"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ts1xVkuWbeJd1rXe3DJ7aP7vZaIUXkgyACVVNVNZJZY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787887623; v=1; x=1788492423;
 b=p7PYntHpdYNNzfsaw1FiqRejYWnOnBFksl3igtLgw9R9ufmVN1/AWomEvcb7ON3NWulRQSzi
 RkbKGbTGAC+/ZIutbi/MX0qC6YhJYYzD+pfd9k7aNqASH70eNr9VxlHc5WUakL1k947KlK96SN1
 sVVu4isU3dEc8fYt4p2p2+XI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c5a619796e3bf126;
	Fri, 28 Aug 2026 03:27:02 +0000
X-Mizu-Trace-ID: c5a619796e3bf126
X-Migadu-Flow: FLOW_OUT
Message-ID: <749b6e89-edf8-4478-a003-f10324d60d1b@linux.dev>
Date: Fri, 28 Aug 2026 11:26:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] tcp: fix use-after-free in
 do_tcp_getsockopt(TCP_CONGESTION)
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, edumazet@google.com,
 ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: kuniyu@google.com, horms@kernel.org, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, yhs@fb.com, kafai@fb.com,
 andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu,
 tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
References: <cover.1787870710.git.blbllhy@gmail.com>
 <d3f97f1acbf0010898148be6e6406e4b8b4a5c84.1787870710.git.blbllhy@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <d3f97f1acbf0010898148be6e6406e4b8b4a5c84.1787870710.git.blbllhy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


on 8/28/26 7:55 AM, Cen Zhang (Microsoft) wrote:
> From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
>
> do_tcp_getsockopt() reads icsk->icsk_ca_ops->name without holding
> rcu_read_lock(). Since commit 0baf26b0fcd7 ("bpf: tcp: Support
> tcp_congestion_ops in bpf"), icsk_ca_ops can point to dynamically
> allocated BPF struct_ops memory that may be freed concurrently via
> setsockopt(TCP_CONGESTION), leading to a use-after-free.
>
>    BUG: KASAN: slab-use-after-free in _copy_to_user+0x37/0x60
>    Read of size 16 at addr ffff888013505260 by task exploit/149
>     _copy_to_user+0x37/0x60
>     do_tcp_getsockopt+0x158a/0x2460 (net/ipv4/tcp.c:4585)
>     tcp_getsockopt+0x91/0xf0
>     __sys_getsockopt+0xf7/0x170
>
> Fix this by holding rcu_read_lock() around the ca_ops->name access,
> using READ_ONCE() to load icsk_ca_ops, and copying the name to a
> stack buffer before releasing the lock. Also annotate the relevant
> icsk_ca_ops stores with WRITE_ONCE() to fix the accompanying KCSAN
> data-race issue.
>
> Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Link: https://lore.kernel.org/all/20260821182449.79785-2-blbllhy@gmail.com/
> Cc: AutonomousCodeSecurity@microsoft.com
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub-Copilot:claude-opus-4.6
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


