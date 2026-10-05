Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C9224AF1;
	Mon,  5 Oct 2026 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182177; cv=none; b=LmtYQ2bj/24W3eb+5M8JQHrJGi/Mj9fXQKaavD9WjUw15j3Ev5rlfYwQTtctsib1mIL1Fm3BFxONxrJRbL93DiWntEoD1onx8I4nDSpgrbF4ACl1ED5rFpDRDEUCo6LfjMfj1YiSlr4LmxXcTv5Hu5UtgtcywU4uCckgWBxOpw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182177; c=relaxed/simple;
	bh=gNT5lACWL6SnIN1yxv0VJwwX4aOHfVA7jzbbJw+8RsM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ffYEMCCsz2X7dIckP9DXlYcCfbqNG+QON5d2cCUIhuR/y8Zy2+tJWlxyYoHuisYvw1WEO5QwPNBchjecKDMNzhpBiGWxFxYFKYIWVMRnm0XotmF5CP7igPx8Xjv+RBlKvEw406+h9YJxZ9Q4UVCdRIJnGzNDhhdqMZDbf/zl+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OrbE4PEd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OrbE4PEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BF11F000FF;
	Mon,  5 Oct 2026 06:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791182176;
	bh=mbDE0v1NrHNoI7W+4NVAoanI+Fqx6m2jrPk15Sb5Q2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OrbE4PEdyLw5DXjC4jcVD/Tri+x0F2xafcSrTG6gZSBwEEnwX7hQq0Nbs26c3junY
	 EWq9jV80bGcJyrkrcmdCQ9jtbwZ/alCT7O1sUn57Va/TUcca+V6cydKzNTblpHA0C2
	 zycxKNEimZNI9MGugDKAfwwQT4qxQrJdwDFprQdE=
Date: Sun, 4 Oct 2026 23:36:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: david@kernel.org, kasong@tencent.com, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 hannes@cmpxchg.org, mhocko@kernel.org, ljs@kernel.org,
 roman.gushchin@linux.dev, dave@stgolabs.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: don't count per-node proactive reclaim as
 memory pressure
Message-Id: <20261004233615.df26e580c1bc916c7f3a23b2@linux-foundation.org>
In-Reply-To: <20261005062236.564210-1-vernon2gm@gmail.com>
References: <20261005062236.564210-1-vernon2gm@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Oct 2026 14:22:36 +0800 Vernon Yang <vernon2gm@gmail.com> wrote:

> When the cgroup has no memory pressure at all, writing to
> /sys/devices/system/nodeX/reclaim triggers proactive reclaim on
> NUMA node, causing increase in the writer cgroup's memory PSI.
> 
> Due to this reclaim is performed in the context of the write(),
> accounted as memory pressure on the writer, like
> commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
> as memory pressure"). This is unexpected, the phenomenon resembling
> senpai will appear again.

What is this?

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
