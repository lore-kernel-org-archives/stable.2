Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA5365A03
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782971398; cv=none; b=a1ZObRVPDSLs9EiJpJP/HSZO+wvd2GmB8PCaNAkA1l2U6RoCJ1O6v9sBHeOGakWdv1EqkcM0GiLx0mSUCW4vPqTIp01tpZzayDo7EnOb4gIvsYo0FsGCoAwJ+xVrktBP6ZxzxvBvNxDjRmrJrap5chHw5VbF6V1yPVnrFVGnPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782971398; c=relaxed/simple;
	bh=L0C3+rSNWpqX28URVZs4meNKDTVprxT11MRHCkWEBxQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJz9/0NPzGHv6ikwUf8cvma6GAjq2dQV4l6Fldlmu2r1SKTi4qfwLG8/LzDERLDRSnnHWzWQskZ+Af/eCJ5xUsvVQlJZbDAnh+wIL1otFpkxkC/LwTDu8ogNgWBAZ48usxrSUurPuzAYcpbsO7T8QH00CJkjWyfCm68ce0qOGd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rO+mBtpZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rO+mBtpZ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84622d6102dso1818760b3a.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 22:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782971396; x=1783576196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aS/9VmQWUzGE31JT9VCNaZ4dhsuSJsHqr8RJ/ilt9nw=;
        b=rO+mBtpZ81Br/krObRBzTQ7nzoHETY4/dqcf3Wpo6Pw52Cbfa4MaJq09SFmckzSWnZ
         UWblOrkmdhaNGvLJph4HRy+RDh7OZKaTMoQPQAwvve8o+SOTlF3f4ulrr8+drvvcgCRn
         TAIL4fFEYTE9k3WvHamz+UtHkxoX/Z8wgZAadmamoMNr0+6LqmQ6he/HgdPBFsXCVFed
         2ENpg8lRUT47SRLGZDliWUv5pUdrMH+IU+4Xwecp84kmwk1Owmn2g9qFdk2aWpO8iHrz
         2FwcUCVXdZiFKhlkMIy3SuUA8bhM3ikPq8I9cd0WKlMA4wVlF2gJzG4e1GPlyxoYFVc/
         fmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782971396; x=1783576196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aS/9VmQWUzGE31JT9VCNaZ4dhsuSJsHqr8RJ/ilt9nw=;
        b=CGPuRw+3B3Y9OxPBFgIq4LhWpf34UWe8goWELORWTkYuWP/g0ovJLmuNQmFQCSsp+a
         h+RqGmArqGPV09i/FL4htU56FUki0ReKxddZexiwlYlFrdPySeK2BxSDjdGsZ/x+dCqg
         ZkgWoCmoUUKuEEICVYapySPDXhpV/KnLsuQuC15SflTV9rhO5PnSAa9sn7QJFGQUwa/e
         fFs7lvHV06ZE9qBCLnNi3z3dmDNehqhjoCtBt9e8GF5826/a+qr2wObYSoJBD31pyvg8
         hCQXH63YhjB43EAEHuv4dDK1cgJ+lMK2OEnYDa8qzWka4KKEmaoWI6fGVs6v2SQsRm34
         9u+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8ieg9C/gVmB0WKKcriHpoiR+grNkupQyvMiNbwpwxT1ebOId1QfZdkMq+QBxTwiwSq8tJ29Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEGZKRz1Z/t/uiYSSAn+ngrbTeNKnQ+thxlk0ONYCUWdts0QMj
	HYRaV1aboAPkx0I402OcbNsYaRNG/u86KPHRvfiR+x88yHhJd9dYF4QJbzj/nBwdsf/xHJCvCao
	daFpAvw==
X-Received: from pfbmy11-n1.prod.google.com ([2002:a05:6a00:6d4b:10b0:847:84bb:c71c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc7:b0:847:95a7:9b48
 with SMTP id d2e1a72fcca58-847c5071ae8mr3893776b3a.22.1782971395753; Wed, 01
 Jul 2026 22:49:55 -0700 (PDT)
Date: Thu,  2 Jul 2026 05:49:42 +0000
In-Reply-To: <20260701235014.73505-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701235014.73505-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702054952.639157-1-kuniyu@google.com>
Subject: Re: [PATCH net v3] ipv4: igmp: remove multicast group from hash table
 on device destruction
From: Kuniyuki Iwashima <kuniyu@google.com>
To: yuyanghuang@google.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, xiyou.wangcong@gmail.com, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu,  2 Jul 2026 08:50:14 +0900
> When a device is destroyed under RTNL, ip_mc_destroy_dev() iterates through
> the multicast list and calls ip_ma_put() on each membership, scheduling
> them for RCU reclamation. However, they are not unlinked from the device's
> multicast hash table (mc_hash).
> 
> Since the device remains published in dev->ip_ptr until after
> ip_mc_destroy_dev() completes, concurrent RCU readers traversing mc_hash
> can still locate and access the multicast group after its refcount is
> decremented. If the RCU callback runs and frees the group while a reader is
> accessing it, a use-after-free occurs.
> 
> Fix this by unlinking the multicast group from mc_hash using
> ip_mc_hash_remove() before scheduling it for reclamation.
> 
> BUG: KASAN: slab-use-after-free in ip_check_mc_rcu+0x149/0x3f0
> Read of size 4 at addr ffff888009bf1408 by task mausezahn/2276
> 
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x67/0x90
>  print_report+0x175/0x7c0
>  kasan_report+0x147/0x180
>  ip_check_mc_rcu+0x149/0x3f0
>  udp_v4_early_demux+0x36d/0x12d0
>  ip_rcv_finish_core+0xb8b/0x1390
>  ip_rcv_finish+0x54/0x120
>  NF_HOOK+0x213/0x2b0
>  __netif_receive_skb+0x126/0x340
>  process_backlog+0x4f2/0xf00
>  __napi_poll+0x92/0x2c0
>  net_rx_action+0x583/0xc60
>  handle_softirqs+0x236/0x7f0
>  do_softirq+0x57/0x80
>  </IRQ>
> 
> Allocated by task 2239:
>  kasan_save_track+0x3e/0x80
>  __kasan_kmalloc+0x72/0x90
>  ____ip_mc_inc_group+0x31a/0xa40
>  __ip_mc_join_group+0x334/0x3f0
>  do_ip_setsockopt+0x16fa/0x2010
>  ip_setsockopt+0x3f/0x90
>  do_sock_setsockopt+0x1ad/0x300
> 
> Freed by task 0:
>  kasan_save_track+0x3e/0x80
>  kasan_save_free_info+0x40/0x50
>  __kasan_slab_free+0x3a/0x60
>  __rcu_free_sheaf_prepare+0xd4/0x220
>  rcu_free_sheaf+0x36/0x190
>  rcu_core+0x8d9/0x12f0
>  handle_softirqs+0x236/0x7f0
> 
> Fixes: e9897071350b ("igmp: hash a hash table to speedup ip_check_mc_rcu()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
