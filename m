Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F268547077;
	Wed, 14 Oct 2026 03:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948944; cv=none; b=a64ZBxG65C58HgTPFXyoLFUibmxVXSudZd8boaEPBsqsoYYRbJAHd9Yl5nmT+fBT+AX0FSA2OoBag25O06jfGwkm9nThG09O5W+AvQyvC/GI8Cpk11/w5styiFxFRFoSukLyKtlqmPo4oEMkKBZWSO6I/AWOcq02MSPqfaUQKo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948944; c=relaxed/simple;
	bh=3rXikSuEr/4lYGBSWgU/DXW15Z+WPekOPtiqTX10Oi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7UB6ZV63ByN/HzYC6nPqAQjdIrmW5rodDO/MGKlmAuVGmN6+Tbx6xa006ALEz75p350vdpb3koaxT/6ySvgW8V7IM0seEGmQB0rcqUlLR3+1NlCX5tNx84oQP95plHTtYRyXR3NqVijhKhLOocG0ORBVbOS01rR5W1cguwxs4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HRdeoYsF; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HRdeoYsF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791948939; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=euiiv0haxE5k/k8PT/ZRBONcRT6uKwGCzJ99UZ9s5DA=;
	b=HRdeoYsFkvj3SnvJG0fRcvUHkS9J7EY4epyj75FulA0kNUIUwBFJLt+0/F4bbyhAr1QbzEmLrTCG3EG4QOXkfku//8WAlxcL5TFHuRi+5X/f2Px7cGn1dT43T6XkXoJ2r0qsoeOtGefXnz0kPnkXdIbSR+9bmC9jO4WRVYAAkG8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XCnt3KH_1791948936;
Received: from 30.74.144.153(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XCnt3KH_1791948936 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Oct 2026 11:35:37 +0800
Message-ID: <303ad1b0-c2a9-4608-9fec-e94d592f4593@linux.alibaba.com>
Date: Wed, 14 Oct 2026 11:35:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: vmscan: don't count per-node proactive reclaim as
 memory pressure
To: Vernon Yang <vernon2gm@gmail.com>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 hannes@cmpxchg.org, mhocko@kernel.org, ljs@kernel.org,
 roman.gushchin@linux.dev, dave@stgolabs.net
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
References: <20261012022917.1102467-1-vernon2gm@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261012022917.1102467-1-vernon2gm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/12/26 10:29 AM, Vernon Yang wrote:
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
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
