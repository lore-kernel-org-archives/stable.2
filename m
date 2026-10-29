Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253745;
	b=Wnwrns6jPxTKxmM6Djmdtb1X264hYeax+PBuovs/9bwI38J2WOO7GNQA9V6wkceivZ21
	 /KNMgy2jpMIEocX/ukuupI7hMKRUkY05MKAXeEcs14woOMR5UHPGub5OZZJejYl+jowUl
	 PxXCQarHgmE1iQGpHDscsxZffpnE207mG/NNqbDPYEbgOwrTMA+auJqjCq0UH7ZtOKCQ+
	 yTGSDwbRGVYjJkmmgrnyE4K40JJQN45tlo7C16ztd37nbkFkjAAdqBPiBX+d+XmwZZhS0
	 dugDhqA0TKYtUBOxtWPvDb4Ag1dBdSwqkvh/HPp6mwSVzUCn2BncoLPK4g4TpEeoVkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253745;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MaszquqzrzKNoBcJxBUNb8Lmnhh0W1i6uNLCQIsKc1A=;
	b=ByXxLkTWfTbAHq7EhDHgZ4ua5VXzMTKmugLodv2f0LTcyNfFnvZNW/msf4wKxxeSWhOb
	 vFUjHmrl5YM7jeKvbFw+a41jz0G9VQ+hyaM5UdtKPmqPgCt9xmCBoarf0xpcNWSxDZMGX
	 kJS1y3AVf81jzNQ+c5RhQOUg4v0WYVJmNAvn34ntDL+4OFxWsRhcKDEWMFEPkI+qQmbCN
	 UOU2pcm3EyknfTfiJsg/QOTMztLCx1oe9qgVN1eq8WJyWdvPvgUwCDeNj5IC7orQVf0Xp
	 TqFoJ9hA8tCKDgn7N+q7R/oekEjSdWRk6Yo0L+pNbOaf2lu5U+BDTRlbw0nHLE9Ed0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fj65yHa8;
	arc=none smtp.remote-ip=115.124.30.112
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5263606A31A;
	Thu, 29 Oct 2026 06:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5263606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fj65yHa8
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793253739; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MaszquqzrzKNoBcJxBUNb8Lmnhh0W1i6uNLCQIsKc1A=;
	b=fj65yHa8F5WVX/LkBebeGn0vP7oVTrQsnAfga39vWez/Kc5Ln7uCTa1Nqfxx6OkgCO3BpDIZfqJcHBaPZa22wu1MdDNeEG2OfrAfZY89VGMJG11Ooi9Y+/zZKA7kdML+/Ob6zlcPlRLSH4+FyETlzu+59A6idm/XvM9si96+19Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XDibLMD_1793253738;
Received: from 30.221.129.93(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XDibLMD_1793253738 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 14:02:18 +0800
Message-ID: <40009068-73c7-4a60-8789-34d32d574264@linux.alibaba.com>
Date: Thu, 29 Oct 2026 14:02:17 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: keep locking_state within the cluster
 connection lifetime
To: Cen Zhang <zzzccc427@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: mark@fasheh.com, jlbec@evilplan.org, heming.zhao@suse.com,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
References: <pm-ocfs2-objects-candidate-0011-v7-61e3ef8b1ad44ac2e817@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <pm-ocfs2-objects-candidate-0011-v7-61e3ef8b1ad44ac2e817@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/27/26 12:31 PM, Cen Zhang wrote:
> The locking_state reader calls ocfs2_dlm_lvb() through the selected
> cluster stack. Its debug-object reference keeps the tracking list alive,
> but does not keep that stack selected without a cluster connection.
> 
> DLM initialization publishes the file before establishing its connection,
> and DLM shutdown drops the connection while the file still exists. Both
> the mount error unwind in ocfs2_mount_volume() and ocfs2_dismount_volume()
> remove the debugfs subtree only after ocfs2_dlm_shutdown() has returned.
> Whenever the disconnect releases the last stack reference, which is the
> case for a failed mount and for any unmount without a pending hangup, a
> concurrent reader dereferences a NULL active_stack:
> 
>   Mount error unwind                  Debugfs reader
>   ------------------                  --------------
>   ocfs2_mount_volume(): out_dlm
>     ocfs2_dlm_shutdown()
>       disconnect last cluster
>         clear active_stack
>                                       read locking_state
>                                         ocfs2_dlm_seq_show()
>                                           ocfs2_dlm_lvb()
>                                             dereference active_stack
>   fill_super(): out_debugfs
>     remove debugfs subtree
> 
> Publish the debug files only after the connection and the mount lock
> resources are initialized, so a failed DLM initialization has no debug
> reference to drop. Remove them again in the common DLM shutdown helper
> before the connection is dropped: debugfs removal waits for readers that
> are inside the file operations, and the parent directory is still present
> at that point in every caller. This covers the mount error unwind, the
> ocfs2_fill_super() failures after a successful mount that dismount with
> mnt_err set, and unmounts whose disconnect releases the stack directly.
> 
> Only the relevant frames of the report are kept:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> RIP: 0010:ocfs2_dlm_lvb+0x38/0xf0
> Call Trace:
>  <TASK>
>  ocfs2_dlm_seq_show+0x36a/0xb70
>  seq_read_iter+0x480/0x1110
>  seq_read+0x362/0x5a0
>  full_proxy_read+0x11f/0x180
>  vfs_read+0x1a0/0xc20
>  ksys_read+0x111/0x200
>  </TASK>
> 
> Fixes: 286eaa95c5c5 ("ocfs2: Break out stackglue into modules.")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Looks fine.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

