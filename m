Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.143
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767047;
	b=T6YnOJ6h0YRCF+ACptEZDcWdnoh4t1Y9Ue7nXjlkD0rzlbDlLvWYa8X1jKN5OUAMYdWS
	 HXsm3KppClSW61V13TRxBKKCLpeFA2WgIgbd20HbUeMvWf9zxd/pmr6pQfrKP7GZj09Os
	 Ow/IPWBdIuynOMcSedu4cXH2trd38qVxMxzjjDi9bqvnBnldCU/LESrD2K9zhV/Qszwl1
	 RYqDgUvmm/rDjtW5cZTM5ADgF/VqMMTgV95u2V7IEdH9iNmimaujv2YdwYficMNWA3KWz
	 No5xqmolJ3krsNNVfEcCOGGeb7f/p30Hgn6c5OD1+SC/9ZxG4U7o88EMeTWcIaChf7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767047;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cx7sW0XE3e3GkkuXCIa8aE7dwlRl3GBZAuCQy670DI4=;
	b=FDDgrsoZ0fhLCQSLoq1kvBd8cbSjtivQnTyr4B7D2kudIeRmKlWIa8S2B4xeWjy0JeTk
	 Mj362K0kbyO1eygjJrwWoIRdsj2HhsVeat7Ub+ZuE5om3n9qJrNuSAoh22oFIDi3MQ4ii
	 0rq6/1O9J3ve3+5w/E0h5xpf7IgDBMVECTTR6KniciHp5A73ALAl9XC0D6Xsm03O2wDE0
	 0cXgyIYrXMkK97TfKPnoXAZzGnRUh0y1DCpP0LXxFqthBrwbsjslcsldw1PZOWgrm0b5i
	 ZT0F32C4jZKiDu9CgzSg3ySKeuyfsiCX2mDTiCrmWQTOz46QHFrakIhk9u7zwU7xIig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=clvz8avz;
	arc=none smtp.remote-ip=95.215.58.143
Received: from mta1.migadu.com (out-143.mta1.migadu.com [95.215.58.143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB665606A31F
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 14:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB665606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=clvz8avz
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rM7gfWKY4WpRqwq90Mbl1M08Z1DYoWLMUw09JRN7Yrc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792767043; v=1; x=1793371843;
 b=clvz8avzEWPzhYA3pwKHhDcMrxkxId2j2bHp2crrKXGx0zDx3OBIdME6vlCDDoZRBhX2kN1Y
 5YsW9OgeHQfMWBAdnMuXCoqWvBqooOmTLMREir63Cr6dG7LRqUY7VKupq+CUNrAhS/s9udg5Ozw
 1iDIFL9L+njxKN/0PwccaJ+I=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 17396e17f5dd6b28;
	Fri, 23 Oct 2026 14:50:43 +0000
X-Mizu-Trace-ID: 17396e17f5dd6b28
X-Migadu-Flow: FLOW_OUT
Message-ID: <af2ec5b0-7c62-4c6e-a28d-33ed401020af@linux.dev>
Date: Fri, 23 Oct 2026 22:50:28 +0800
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
Subject: Re: [PATCH net v2] tcp: limit tcp_tso_rtt_log to a valid shift count
To: Yingjie Wang <1075151112@qq.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <tencent_31D2FFCCE76C50A695A1270151F825E90906@qq.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <tencent_31D2FFCCE76C50A695A1270151F825E90906@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/23/26 10:40 PM, Yingjie Wang wrote:
> tcp_tso_autosize() right-shifts the u32 returned by tcp_min_rtt() by
> sysctl_tcp_tso_rtt_log. The sysctl uses proc_dou8vec_minmax() without
> an upper bound, so it accepts values through 255. Values above 31 make
> the shift undefined.
>
> A process with CAP_NET_ADMIN in the target network namespace can set the
> per-netns sysctl. With CONFIG_UBSAN_SHIFT=y, setting it to 32 and sending
> TCP data over loopback triggers:
>
>    UBSAN: shift-out-of-bounds in net/ipv4/tcp_output.c:2264:30
>    shift exponent 32 is too large for 32-bit type 'unsigned int'
>    Call Trace:
>     __ubsan_handle_shift_out_of_bounds
>     tcp_tso_segs
>     tcp_write_xmit
>     __tcp_push_pending_frames
>     tcp_push
>     tcp_sendmsg_locked
>
> Limit the sysctl to 31, the largest valid shift count for a u32, and
> document the accepted range. Writes of larger values now fail with
> -EINVAL.
>
> On a UBSAN/KASAN build of the net tree, values 0 and 31 remained
> accepted, values 32 and 255 returned -EINVAL, and TCP traffic with the
> valid boundary values produced no sanitizer diagnostics.
>
> Fixes: 65466904b015 ("tcp: adjust TSO packet sizes based on min_rtt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <1075151112@qq.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


Thanks !

> ---
> v2:
> - Attach the upper bound to tcp_tso_rtt_log instead of ip_dynaddr, as
>    pointed out by Jiayuan Chen and Neal Cardwell.
> - Re-run checkpatch and boundary tests on the corrected patch.
> - Do not carry Eric Dumazet's Reviewed-by tag because the code changed.
>
> v1: https://lore.kernel.org/netdev/tencent_53CDCF8AA0022B75CF72A294CB9993D2FF07@qq.com/
>
>   Documentation/networking/ip-sysctl.rst | 2 ++
>   net/ipv4/sysctl_net_ipv4.c             | 2 ++
>   2 files changed, 4 insertions(+)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 8edd2eb2a..66a54c510 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1128,6 +1128,8 @@ tcp_tso_rtt_log - INTEGER
>   
>   	If you want to use the old autosizing, set this sysctl to 0.
>   
> +	Possible values are [0, 31], inclusive.
> +
>   	Default: 9  (2^9 = 512 usec)
>   
>   tcp_pacing_ss_ratio - INTEGER
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index e3760daa3..bf193e7ec 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -26,6 +26,7 @@ static int ip_local_port_range_max[] = { 65535, 65535 };
>   static int tcp_adv_win_scale_min = -31;
>   static int tcp_adv_win_scale_max = 31;
>   static int tcp_app_win_max = 31;
> +static int tcp_tso_rtt_log_max = 31;
>   static int tcp_min_snd_mss_min = TCP_MIN_SND_MSS;
>   static int tcp_min_snd_mss_max = 65535;
>   static int tcp_rto_max_max = TCP_RTO_MAX_SEC * MSEC_PER_SEC;
> @@ -1406,6 +1407,7 @@ static const struct ctl_table ipv4_net_table[] = {
>   		.maxlen		= sizeof(u8),
>   		.mode		= 0644,
>   		.proc_handler	= proc_dou8vec_minmax,
> +		.extra2		= &tcp_tso_rtt_log_max,
>   	},
>   	{
>   		.procname	= "tcp_min_rtt_wlen",
>
> base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
