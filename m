Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752F44A708
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793660; cv=none; b=GXGEI29bL2IAF+MeStTUkyBIEPEBmEtv6vEEfX0gLlMygr9ITS3BOf+vf1ZR0EAGjfnQTcOWIt/InxaIRnQ+FtgJnFhqGJsAfRxXSKLK1Ntt1uxm7NPB+jV5vsyD7/0tpAcFrsvDCIvyNQK3ZZpY+UDnaVA3DxTVcNkrP5v1V08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793660; c=relaxed/simple;
	bh=3GqsGVRUjoj3lPssoI6fkQedInMU5d1nzfzfv6u1A4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+gGqGotfhnc6I4zT7SucR6imKHQUFOEMAQ7pSA1Po2hDRekE+s9HdZNcTWDFKXAj10wOXcctAD2XbRwp4zxK3RTd3r0nIX42urC+GoQGnDoPlWn5SNbD0iKX/OxIKdQq92ZqxrNxLlXMgyZc7Y0NFhma06SpVpuwr2NUYiw8No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ44dp4/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ44dp4/"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-398b3c37877so727171a91.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 01:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791793658; x=1792398458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cphMCACc/G8raeeyalkj56O+G8JXJUyGWoABQ8mUypk=;
        b=fZ44dp4/8jJ81RrVHGK9/rPEBs0MeG4idUzzXpmEq3mhTxoimoSnAu1IGNfbtdV82s
         90A3c2GSmtJZhXRjvvUQUBC4vNTdAUwyTWXeXAcdIUyHnRniNXgJKy38TTYM1akxbees
         FP+6wwVvN4YAIa4TwhYbQKwCKqhmrkuU0jojwwUZPvz3+JngjhtkWMbLFKzIwDSsq+0X
         1fiBRdB99/WnfHplZYtAAYrIfN6G1TbxdLeD49CZ1UqxXqoPmb1msFxFPrpTEJhyQQmX
         mT96vnku9ymQ6GXJEijLqAdA/Yn1725S8ZgKtzhTRY8tslDfJvZSXYF+0JzdMW2GoPwV
         dc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791793658; x=1792398458;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cphMCACc/G8raeeyalkj56O+G8JXJUyGWoABQ8mUypk=;
        b=lOBsTPHD/xgZhI2qDU5aAauopLeNf9AXMETUECKlbL2YE81KU2nICezaLg63EB0zY9
         yMWXMMzB7MYQUcyRo9VBfXtCFKAfaiPayJMzOcKeChlTt7SSTtoCUUvIUl8fE3E1ksjE
         yElPVzr8/VqV/60yB2WHWHuRf5CEkm2R+uLVi3cLGjkZRX3a9pSyJVsiGV/xlcy4ZpDt
         b8XDx29rRtBnKJIb/HY062SEnSO9Qe+s7++2osDD62M39rUY8Wo5rfj4HhkPcYa3oyD+
         YQpAI4/TdQrs9HecQTi/kYiEdzkSEyTlbfybbUFUdtzoUzZcqD/tHEaRYrcOd17enUzb
         eyjw==
X-Forwarded-Encrypted: i=1; AKwUvBwldcCI4Hhy8ZT0VLo0b6hQIWYQTAVz8atUMBxB828pnIdnWgegz+UkkKMNTmGliefOab8fcSc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVez1RIFROA3VQCFh0nYk3lQzyPUDzhYMID7Xxi0QqoRLpCmYZ
	6GwtRCzDwWcgCUH+1SVjb+CCvY/SGSLsgliIWWwG+Akn/uE1Gch5EkRg
X-Gm-Gg: AYBFou11R4dxNW8TEHA+nBQP8IUob3wNSHt6c6H+dm7BA9sb/gvY1Pob2qsW/tWeqH8
	xxxDe7Z50hbASg2fqLkLfPARkI34+yDCxKBsGWmqXab49uxsHWyIAn30xbFzh1kyDvvG+9dK4CU
	1XuF9WAcjk/A1y1oqP3PX0KsjHukrtA0DsPqjPvH0+eOgL5XMMld+YX6fUAvjqR9m/gf1bDnVNC
	hzkxk5uYwWODcmW/XruxFdjX2q6XGHnIef+jesZxGjm1Gj2yxJQ/04DU3pRt7CZ2gocG2WgvKKK
	CbygUnJEN2lRmCVBZ1iqJ154HeWw7ooN72gOuoCJFxkKssDPxm54Olihv9V+5e5Dnc1XyP2sJKi
	6ejsCdYLC9CMQIHzK0YuNnV5i6E/xv/fFu+JpQtYr6a9MPXm9S7+L4JV29pp9d4aIVnxDy2Hjq4
	mEzeKWpxQOyl1e7UE/dlHO8PB0Yk5X+gSvJkz2NcrqFRBMUxLBi0kY2bdpOgkypRUU7FRrjSn4e
	/5KZvsfzoNDuqoY96ujuF0duCS64T2t6h/E
X-Received: by 2002:a17:90b:4b09:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-3ab3ab60614mr6616690a91.16.1791793658108;
        Mon, 12 Oct 2026 01:27:38 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1189? ([2620:10d:c090:400::5:b3cd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f8277bsm15241625a91.11.2026.10.12.01.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 01:27:36 -0700 (PDT)
Message-ID: <51a0e3f7-1e53-498f-81a9-af61a07b2d68@gmail.com>
Date: Mon, 12 Oct 2026 01:27:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 4/5] eth: fbnic: return the page reference taken
 for a dropped Rx fragment
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
 Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Dimitri Daskalakis <daskald@meta.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1791775409.git.yhlee@isslab.korea.ac.kr>
 <9d77812119330cd316b7eea7fd35fa4038ff86a0.1791775409.git.yhlee@isslab.korea.ac.kr>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <9d77812119330cd316b7eea7fd35fa4038ff86a0.1791775409.git.yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/11/26 9:15 PM, Yehyeong Lee wrote:
> fbnic_add_rx_frag() takes a page reference through
> fbnic_page_pool_get_data(), which decrements the buffer's pagecnt_bias,
> before handing the page to xdp_buff_add_frag().  xdp_buff_add_frag()
> fails when the buffer already holds MAX_SKB_FRAGS fragments, and on that
> path the reference is lost: add_frag_failed is set and the frame is
> dropped, but the bias is not restored and fbnic_put_pkt_buff() only
> returns the fragments that were actually attached.
> 
> The page is then never returned to the page pool.  A device that keeps
> sending payload completions for one packet past MAX_SKB_FRAGS leaks a
> page for every completion beyond the limit.
> 
> Restore pagecnt_bias on the failure path, the exact inverse of the get,
> so fbnic_page_pool_drain() reclaims the page.
> 
> Fixes: 61f9a066c309 ("eth: fbnic: Use shinfo to track frags state on Rx")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> ---
>   drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index 47ded7a9e0a81..7a9bd91bcc41c 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -1171,6 +1171,8 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
>   
>   	added = xdp_buff_add_frag(&pkt->buff, netmem, pg_off, len, truesize);
>   	if (unlikely(!added)) {
> +		/* Give back the reference fbnic_page_pool_get_data() took */
> +		qt->sub1.rx_buf[pg_idx].pagecnt_bias++;
>   		pkt->add_frag_failed = true;
>   		netdev_err_once(nv->napi.dev,
>   				"Failed to add fragment to xdp_buff\n");

We can expect to receive at most four payload frags per packet, so 
exceeding MAX_SKB_FRAGS is not expected during normal operation. 
Independently, Daniel already fixed reference handling in 1c85ea5df86b
