Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1C3C8C7D
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793139; cv=none; b=bV0TcEXFkal7Dr7zg9JCPGlQgPB2SVsSrIeLrOmLp1d/viScGTNrMe4anjXrjL4ioi/jdGyyBl1z6buLW19xjLW8tL82cZSvVF7CDoRbp7mcAmbck9INrFFjNLGnh0S3Jk2P1t1wQnbQb9Fpr1WEpRxT6SM17UbJX5UoXCiCnfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793139; c=relaxed/simple;
	bh=pOzr+4bkvPAd+tqVxnDq62DbUqUG1YPr92b7gG2YWUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSASpewZTk6kBriinLxuCiomAUOouR+vcgrc0NPbKxriSKrgsk31S2vo2PkV/ijwcrO24/sYo3dK0lUtxpvt3l8GJuWFjFJkwB0y3OimjlbdwDAFXx7Pa58+hn62SW3b1sfknzmxVqTIt1EPaJRJyRvgDKnZmSlRBAGHwoIfbWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B51SIBOP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B51SIBOP"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-88bc25fcd0eso1237129b3a.2
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791793137; x=1792397937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dPG7Y7H+r9R94i7P5GUiBC7BGzZ5i2tduA/5fQyP0hQ=;
        b=B51SIBOPB6eMPNhKIyFWsz03ymNUzdkx/IVerL02xHZpym0udVgSt/+9rPrrFFx8So
         M9uO7djqHUGvkOqgsc/9W8cTQ2nz1N+eSEG3Cd2JMFnG/InY0hEIiUOGv0obLwlnDQCV
         C2uWbwMyipZNJB8uNOs2lgHu7Aucnc8aYvGrXTyIrO/l8NAIpMLIde87/NPzYxlg1X7S
         njrLmR22blUxW8xYQ/ZgqeKOfU1HgD+tyUTzLX+Qgra6i/jIDRxIawgO7E2v8Va1mMST
         cjGBrMDHxPsOX5MqExTvnomkr1Sz+eaJnBuhSiZLJS5oDV1lvBiCTZQaAHdKDquCMmb4
         4Q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791793137; x=1792397937;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dPG7Y7H+r9R94i7P5GUiBC7BGzZ5i2tduA/5fQyP0hQ=;
        b=nrq44pZVJ/+c1MRaH/EqNOopBvtZhAIVeMkkLZOkf+jTfIwhe8gG7qB/192xvH+/gK
         m3DfnMldZ1NeuZ2rKaqseT4Mc08xkbI/ccNd8NLqbJiKTQ2SeBOyEMprU+VOnNZ250Fe
         VtJwH0uhxQrVWiG5goaoTEVe0FCDiHMnPjam5I5y5t0+HTW7g9Bqshqe+YY6l2gXSNuU
         8RoNGkfLqmNDkNfxz3zmmYDrP0CAOE6viLF78Kn8Rl4VrVqcopcwICFR56rKktfgCTP3
         MSIUlZT7n5JSpbgqemcU/Jyt0XQcxqOHpEbvC1cQ19mIdJFFt2IJxcf4XKZyUGrqeXi9
         59Yg==
X-Forwarded-Encrypted: i=1; AKwUvBzid7PQIiEHombXrlS26kN8tOtJJ+EDFv/V+sXngzX+ymBgkllsVf99BRVZfLxVHjN4FtDQPE0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7luED3AeSdNAPW5o4SKH4JAG7tSq+irXIW5aHEqj24bxM7Rdi
	OvrSSP3OIrtHnKGqoS5NF8dSsm1Cv8BCuRGmRHnW7N+fdc/7DMHYDCit
X-Gm-Gg: AYBFou2aIvZQjyTWh67K8CL+IHmZzeD3Zb/gv98J2zi5ypRRZAjpOTgB3JhTqLpDT0H
	GrekES/jIQi60N7IMFhSdHt9IFu0UKMQCK0HEZt6AlZ1NskJixexcDYVzHa2m6XPdvKnVQLypgd
	rXk5O6dluuOqjkx8rcX1GexSLryNOwv4Wklt3ewazihZHRqqGSc0gVbG6hGhBiAgYJF2UmX1+Tw
	besEEviej53fMnS3I+V17Vwcb8Nehd07XtaNOfBX00USTzKkfRTD2mea6IWk70duZ9HeU+d586S
	xKFZOYHr/hm9kN0X75dwt5ZvDtNrEdYfPKrJS6JRRuLCRYe+cp+0/wSC/rSYonQd6WYuMmHdJ0B
	Yu2G/ei9RYgjGzaE5pJ3tzNSsdtpfG2iM96hMK+NsFf+Tjk5o5ve/bqoOTPPJ/cZXcCWdVI6sQG
	xwA7Y1jY+WMz8+x3ZTcGl8AYMOVB/Yx1ySq1SeoAL1lj+WDRfNylJKvX0BKlnNAzEZewyse8oQ5
	185DrPaMkGe8rU3ZCEpe+hBNfm5pUeW2Tf9
X-Received: by 2002:a05:6a00:9508:b0:881:a5b6:7954 with SMTP id d2e1a72fcca58-897c7cd4565mr7903109b3a.39.1791793136976;
        Mon, 12 Oct 2026 01:18:56 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1189? ([2620:10d:c090:400::5:b3cd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c3107373sm3519766b3a.9.2026.10.12.01.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 01:18:56 -0700 (PDT)
Message-ID: <40b3432d-b597-423f-9279-ab4aa1157f44@gmail.com>
Date: Mon, 12 Oct 2026 01:18:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/5] eth: fbnic: only act on Rx completions naming
 a posted buffer
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
 <25ce85c9821fba5d94932b36b9c9afb9a2fbd12a.1791775409.git.yhlee@isslab.korea.ac.kr>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <25ce85c9821fba5d94932b36b9c9afb9a2fbd12a.1791775409.git.yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/11/26 9:15 PM, Yehyeong Lee wrote:
> An Rx completion descriptor carries a 16-bit buffer id that the driver
> uses to index the rx_buf[] array (FBNIC_RCD_AL_BUFF_PAGE_MASK). The fill
> path masks the id to the ring size, but the completion path does not, so
> the device can hand back an id that is past the array or that names a
> slot which was never posted. An unposted in-range slot holds netmem 0,
> and netmem_to_page(0) returns NULL, which fbnic_pkt_prepare() and
> fbnic_add_rx_frag() then dereference.
> 
> Masking the id would not fix this: it aliases an out-of-range id onto a
> posted buffer and corrupts that buffer's page_pool reference count.
> Reject a completion whose id is outside the array or outside the posted
> window and take the existing drop path.
> 
> The same id is used as the BDQ head in fbnic_clean_bdq(), where an
> out-of-range value spins the cleanup loop; bound it there with the same
> test. Validate head0/head1 in fbnic_clean_rcq() before they are assigned,
> and drop a META completion that arrives with no header buffer rather than
> building an skb around a NULL pointer.
> 
>    Oops: general protection fault, probably for non-canonical address
>    0xdffffc0000000004: 0000 [#1] SMP KASAN NOPTI
>    KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
>    RIP: 0010:fbnic_pkt_prepare+0x1a2/0x5a0 [fbnic]
>    Call Trace:
>     <TASK>
>     fbnic_clean_rcq+0x1ba/0x1350 [fbnic]
> 
> Fixes: a29b8eb6e533 ("eth: fbnic: Add basic Rx handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> ---
>   drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 87 ++++++++++++++++++--
>   1 file changed, 82 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index 10caacffee0f0..305fe6d2f511f 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -797,6 +797,34 @@ static void fbnic_page_pool_drain(struct fbnic_ring *ring, unsigned int idx,
>   	rx_buf->netmem = 0;
>   }
>   
> +/* The device names an Rx buffer by its index in the buffer descriptor
> + * ring.  A completion may only name a buffer we posted, that is one in
> + * [head, tail), so test the index against the array and against the
> + * posted window.  The window test is not enough on its own: it masks the
> + * index, so an index past the end of the array can fold back into the
> + * window and run off rx_buf[].
> + */
> +static bool fbnic_rx_buf_posted(struct fbnic_ring *ring, unsigned int idx)
> +{
> +	if (idx > ring->size_mask)
> +		return false;
> +
> +	return ((idx - ring->head) & ring->size_mask) < fbnic_desc_used(ring);
> +}
> +
> +/* fbnic_clean_bdq() is given a position to consume up to rather than a
> + * buffer to use, so unlike fbnic_rx_buf_posted() it also accepts tail,
> + * which is how the teardown path asks for the whole ring to be drained.
> + */
> +static bool fbnic_bdq_head_valid(struct fbnic_ring *ring, unsigned int hw_head)
> +{
> +	if (hw_head > ring->size_mask)
> +		return false;
> +
> +	return ((hw_head - ring->head) & ring->size_mask) <=
> +	       fbnic_desc_used(ring);
> +}
> +
>   static void fbnic_clean_twq(struct fbnic_napi_vector *nv, int napi_budget,
>   			    struct fbnic_q_triad *qt, s32 ts_head, s32 head0,
>   			    s32 head1)
> @@ -882,6 +910,13 @@ static void fbnic_clean_bdq(struct fbnic_ring *ring, unsigned int hw_head,
>   {
>   	unsigned int head = ring->head;
>   
> +	/* A head we never posted cannot name a buffer we own, and the loop
> +	 * below masks head to the ring so it would never reach it.  Leave
> +	 * the ring alone and wait for a head we can act on.
> +	 */
> +	if (unlikely(!fbnic_bdq_head_valid(ring, hw_head)))
> +		return;
> +
>   	if (head == hw_head)
>   		return;
>   
> @@ -985,14 +1020,25 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
>   {
>   	unsigned int hdr_pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
>   	unsigned int hdr_pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
> -	struct page *page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
>   	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
>   	unsigned int frame_sz, hdr_pg_start, hdr_pg_end, headroom;
>   	unsigned char *hdr_start;
> +	struct page *page;
>   
>   	/* data_hard_start should always be NULL when this is called */
>   	WARN_ON_ONCE(pkt->buff.data_hard_start);
>   
> +	/* A buffer ID we never posted cannot name a buffer we own, so drop
> +	 * the packet instead of running off the end of rx_buf[] or picking
> +	 * up a slot we have already drained.
> +	 */
> +	if (unlikely(!fbnic_rx_buf_posted(&qt->sub0, hdr_pg_idx))) {
> +		pkt->add_frag_failed = true;
> +		return;
> +	}
> +
> +	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
> +
>   	/* Short-cut the end calculation if we know page is fully consumed */
>   	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>   		     FBNIC_BD_FRAG_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);
> @@ -1026,10 +1072,27 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
>   	unsigned int pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
>   	unsigned int pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
>   	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
> -	netmem_ref netmem = fbnic_page_pool_get_data(qt, pg_idx);
>   	unsigned int truesize;
> +	netmem_ref netmem;
>   	bool added;
>   
> +	/* No header completion has set buff up, either because one was
> +	 * rejected or because the device sent none, so there is nothing to
> +	 * add a fragment to.  Mark the packet so the metadata descriptor
> +	 * drops it instead of building an skb on an empty buffer.
> +	 */
> +	if (unlikely(!pkt->buff.data_hard_start)) {
> +		pkt->add_frag_failed = true;
> +		return;
> +	}
> +
> +	if (unlikely(!fbnic_rx_buf_posted(&qt->sub1, pg_idx))) {
> +		pkt->add_frag_failed = true;
> +		return;
> +	}
> +
> +	netmem = fbnic_page_pool_get_data(qt, pg_idx);
> +
>   	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>   		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);
>   
> @@ -1270,6 +1333,7 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
>   	while (likely(packets < budget)) {
>   		struct sk_buff *skb = ERR_PTR(-EINVAL);
>   		u32 pkt_bytes;
> +		u32 pg_idx;
>   		u64 rcd;
>   
>   		if ((*raw_rcd & cpu_to_le64(FBNIC_RCD_DONE)) == done)
> @@ -1281,12 +1345,21 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
>   
>   		switch (FIELD_GET(FBNIC_RCD_TYPE_MASK, rcd)) {
>   		case FBNIC_RCD_TYPE_HDR_AL:
> -			head0 = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
> +			pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
> +			/* Only take the head from a completion we are going
> +			 * to act on, so that one rejected ID does not discard
> +			 * the progress an earlier completion in this poll has
> +			 * already reported.
> +			 */
> +			if (likely(fbnic_rx_buf_posted(&qt->sub0, pg_idx)))
> +				head0 = pg_idx;
>   			fbnic_pkt_prepare(nv, rcd, pkt, qt);
>   
>   			break;
>   		case FBNIC_RCD_TYPE_PAY_AL:
> -			head1 = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
> +			pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
> +			if (likely(fbnic_rx_buf_posted(&qt->sub1, pg_idx)))
> +				head1 = pg_idx;
>   			fbnic_add_rx_frag(nv, rcd, pkt, qt);
>   
>   			break;
> @@ -1300,7 +1373,11 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
>   			/* We currently ignore the action table index */
>   			break;
>   		case FBNIC_RCD_TYPE_META:
> -			if (likely(!fbnic_rcd_metadata_err(rcd) &&
> +			/* A metadata completion with no header completion
> +			 * ahead of it leaves nothing to build a frame from.
> +			 */
> +			if (likely(pkt->buff.data_hard_start &&
> +				   !fbnic_rcd_metadata_err(rcd) &&
>   				   !pkt->add_frag_failed)) {
>   				pkt_bytes = xdp_get_buff_len(&pkt->buff);
>   				skb = fbnic_run_xdp(nv, pkt);

As Daniel pointed-out on V1, the device does not make up the buffer 
ID's. Rather, it only echoes them back as provided by the SW. A 
completion with ID's that SW did not post would indicate a bad device or 
an inconsistency between SW and HW state. Either of the two would 
indicate that the issue is somewhere else. These checks would only mask 
the issue.
