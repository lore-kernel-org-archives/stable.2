Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAD381E97
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439074; cv=none; b=o9iUx8IUVVU+G5oeWlWIx0ZmWPCqcm1bJSUxp46U7aKctnV2A1309V2V6KzWic2endWUFrqGCTZnZ2U8X780vGW5Kl8qculT1B72gSTA7pF1CxGlGxO43wieNwJXoJDTyVQkDLF+2fFCu9Af4Q3vX7pe/OQ+acubrVWpPEsXgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439074; c=relaxed/simple;
	bh=oSIyKewTZkvF3qneODU9rL2qWluSKrjnRXG8YyrzFAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVs1auRelsobdfQDVjC3O5hcRzrqMyjnquiSNBkdrkYXTyEfbmHlrb+jTSUEXtICiuLHkVbpC3T4xOVZZH8dUQAJvnQsomWci435Z1hjl+ft4cWfYUva7KWTPb1VROUqIb95fylQyo/vwwJMY2Wcs+pzIC8yeKHHCnHSdXQ3rq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1670dad7a8so393757166b.3
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 15:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787439071; x=1788043871;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=by00rSofcVW0o+0DH/mIAxhhdK7UHVRdpxSnTxPjoUQ=;
        b=XdnRAfOzVdDUWDeGPfP46DTbwompk0w+32lHVv+ztZoG1Y19ymLhk6c3nnDdjr3CrV
         89qNgA3wZou5lVhmp2M8+YkulbO3+sMhDHq27arwuzgJmS50hwfB6g3RiU0XUt7f/nfC
         BNMf7Cc3o00L8+yuIf8HnrccsJm7mZcUlzK/PlQRGYSQ3+JJ+vjzE7Jfzwwc2MgYaFz9
         BtEgvcXCu3BCdq0iSAuAr2AeS8WUuZBWJO19AneLAlgJ7f9PNv7sdqzJlMtSt9a/3gbS
         /dWJoUogo63Df0zVwr5tEXPkVUpApkVrPIOw5ka5s7j9Xl46in4ZmpXAmxGgQDuEKE7k
         kZoQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYkGWzqPXPzK0wmPVKFB+jzPSLdKz196HOsHrQzuMUjVD790WtjAsuzVgkcZOb6iXosNU+X7U=@vger.kernel.org
X-Gm-Message-State: AFuF++l7Pm5cprrXiEOSOgAcrJa2bizubwLsVrIi5ylG0Nz4s5iW9qoN
	c9kupMIpCCe7svLGLVGW6xK8dOa9NM5/NXU8RaAHgsmY1H7Wg1VnIpkJRahY8g==
X-Gm-Gg: AR+sD11ebibrLFg74Llv3/JTln3tn/Qn7Z1VnraFOkNK5RdAlsPzn3DWyxh4AScpYcn
	BaPZwWtSfrswCd68mbaW1xMN0RNIxtE5Zm84JDEXdwCSXqHBWgB32nabciPfcsLA117xt5WnhKy
	WyJVISYxqHALfilX6IK5HbZbXmpX0x583S8oU97PrAHrC0Fbep7bPHKXq6e2DknV5MfUaoYBvaK
	gnXLmI4k393b/hY7SjMS/lc04Ed4FIWxPPuLmcSCsbpRXvjl0CJaU3gW+AQ/FRfF3rpdqfiyx54
	/h5pPq47OcXHb23BUnkJM6qvwjCZJlK1A23AP4/8A3fF3SPSKKB2vLVGiSZJuuvshlu2jB3IyWG
	YkFIu8ZTJpdTlQe9odbJfA0jr4mJyMRr3vaFCS8BYubWGf5hU+G1eaeBjlkHjI2PGIyN8D+nZko
	PUn05790J9RRIfGO8oLwfFvo+F9AAkmCDBlUmnBf81TtBBTG5QVGRvS2bD2gdRTVYEKSFJzAABy
	HPCyy/RxY7w7sCO+usYaorK
X-Received: by 2002:a17:906:f049:b0:c24:6045:2a94 with SMTP id a640c23a62f3a-c246a39f420mr1603195066b.4.1787439071040;
        Sat, 22 Aug 2026 15:51:11 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b683sm578023866b.5.2026.08.22.15.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 15:51:10 -0700 (PDT)
Message-ID: <cfd6f450-220e-430d-a5e9-b8c9952ee44d@grimberg.me>
Date: Sun, 23 Aug 2026 01:51:09 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: check the data direction of a C2HData PDU
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260818110405.590548-1-yhlee@isslab.korea.ac.kr>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260818110405.590548-1-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/08/2026 14:04, Yehyeong Lee wrote:
> nvme_tcp_handle_c2h_data() finds the request by command id and checks
> that it has a payload, but it does not check that the command asked for
> data to be read.  A controller that answers a write command with C2HData
> therefore reaches nvme_tcp_recv_data(), where _copy_to_iter() hits
> WARN_ON_ONCE(i->data_source) and returns 0.  The receive path turns that
> into -EFAULT and resets the controller.
>
> No data is copied, so this is not memory corruption.  What a controller
> gets is a kernel warning it can raise at will, which is fatal on a host
> booted with panic_on_warn.
>
> The send path already knows the direction - it consults rq_data_dir()
> when it builds a command - and nvme_tcp_handle_r2t() checks the length
> and the offset of the request it names.  The C2HData path does not check
> the direction at all.
>
> Reject a C2HData PDU whose command is not a read.  Rejecting it fails
> the command and resets the controller, as the neighbouring check in this
> function does; what goes away is the warning.
>
>    [    6.885580] ------------[ cut here ]------------
>    [    6.886457] WARNING: lib/iov_iter.c:193 at _copy_to_iter+0x289/0x1330, CPU#0: kworker/0:1H/71
>    [    6.888137] CPU: 0 UID: 0 PID: 71 Comm: kworker/0:1H Not tainted 7.2.0-rc5-NVMETCP-gf5098b6bae76 #1 PREEMPT(lazy)
>    [    6.891165] Workqueue: nvme_tcp_wq nvme_tcp_io_work
>    [    6.891875] RIP: 0010:_copy_to_iter+0x289/0x1330
>    [    6.903739] Call Trace:
>    [    6.904085]  <TASK>
>    [    6.909254]  __skb_datagram_iter+0x433/0x820
>    [    6.911026]  skb_copy_datagram_iter+0x37/0x120
>    [    6.911622]  nvme_tcp_recv_skb+0xa07/0x4320
>    [    6.913378]  __tcp_read_sock+0x1ab/0x810
>    [    6.915788]  nvme_tcp_try_recv+0x152/0x1e0
>    [    6.918222]  nvme_tcp_io_work+0x1e4/0x6c0
>    [    6.926906]  </TASK>
>    [    6.927226] ---[ end trace 0000000000000000 ]---
>    [    6.927878] nvme nvme0: queue 1 failed to copy request 0x71 data
>    [    6.928709] nvme nvme0: receive failed:  -14
>
> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> ---
> Applies on top of "nvme-tcp: do not accept C2HData based on
> blk_rq_payload_bytes() alone".
>
> Measured over a user-space target that answers every write with C2HData.
> The warning appeared in 5 of 5 runs without this patch and in none of 5
> with it, in each of three shapes: a buffered 8 KiB write, a 4 KiB write
> carried in the command capsule, and a discard.  In every run the command
> ids the target answered matched the ones the kernel named.  A conforming
> target is unaffected over 5 runs each way, including writes and a
> passthrough read, which rq_data_dir() classifies as a read.
>
> Those runs were on 7.2-rc5 with this patch as the only change.  Repeating
> the write, the in-capsule write and the conforming-target arms three
> times each on the base this patch applies to - 7.2-rc5 plus that patch
> and its predecessor - gave the same counts.
>
>   drivers/nvme/host/tcp.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 85a87ed6df936..a62d6e48f7190 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -679,6 +679,13 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
>   		return -ENOENT;
>   	}
>   
> +	if (rq_data_dir(rq) != READ) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"queue %d tag %#x unexpected data for a write\n",
> +			nvme_tcp_queue_id(queue), rq->tag);
> +		return -EIO;

Minor nit - EPROTO would be more appropriate here (chiming in late here 
- not a really big deal)
