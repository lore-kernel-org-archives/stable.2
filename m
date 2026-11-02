Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617971;
	b=n+qSyOhemPLqTnBZMcE99ky1VQbW9GRJ52b42mIavTXuryVZhr1z9DXNHAenIWwfu98K
	 FTFBg5+ZoSsBk/8qBDwgosYy8biA9/Rk+RbwpWGZJbcgCkcQZJkTM2H55+zcyouNj/ECU
	 Jzu/1pNRHA395UC+LABhG9yXJqt8CEpdZRcFzHcjzYh4kmXj1GYAQmoznFZ2wEPurdHAb
	 fSRUN44nZ6vbKWw5CottRvfzZLqufR6Tk7zhZTzRHpe1VgT1K6ekf7OuOXCVUzEeDAL+s
	 pdckkrHeBirTxNpNR4B71fsgUNKb0Ib+kYSrLe27CpuUJYhQPXT5Tu7mVoctyWqwd4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617971;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=vPV6V8DGBlGRUTmkiPIegMrg4UNT29rSxD2ysSV6YuQ=;
	b=uRRkUnno4nbgbFFFYHTbVuw3Z+QXe2/oSk7g+aTyfT16RFesiiG4xOuu6LVlRnhnI4Zb
	 X0S/RRAxjQ+zpsOLdHSMlr9XV0n3t3VQMiD3NYeDISkzlGpCNtOxF9ChKO6xq2dPdmTV+
	 dy0eEKvZL1x5ebdONx+nns7ejOUc7vb3hQC7mscpAVOf8gc3EPO3M/Hs0+9TzNxApb+lh
	 4EgZMqZONWpuAvEXHnF4AEaW6ecTBdTEfADeDKS6mLSsqWTXjGHx+z2Pu06H26c3HYZ+G
	 Qxw61YbWqdwN0gESZfKtHkS6NRueGWq+6+3+Zn70YJsinBXul50nppJZFrI94vqOeUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PLCrBEBG;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QwUeOSU7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA21606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 11:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEA21606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PLCrBEBG;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QwUeOSU7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793617969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPV6V8DGBlGRUTmkiPIegMrg4UNT29rSxD2ysSV6YuQ=;
	b=PLCrBEBG+4Uo5f8xJKiFVygMYM8Qu62VVb/i/vzQAU/lMwEE5tQe7FDNDVKIJbSBOkvB40
	3WNF+h7Dxg1jxEz+J2wc1BMXeQ+gl8Pr4sGqZffRQriTNFZJG8zJ2pGeT5SC2oPolTuBIy
	aZdfMKH2I3aPH4rXTldI22lLybSQMPE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-iPlApDJVMPu6KssudAtQWw-1; Mon, 02 Nov 2026 06:12:48 -0500
X-MC-Unique: iPlApDJVMPu6KssudAtQWw-1
X-Mimecast-MFC-AGG-ID: iPlApDJVMPu6KssudAtQWw_1793617967
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c46582442so1726554f8f.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 03:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793617967; x=1794222767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vPV6V8DGBlGRUTmkiPIegMrg4UNT29rSxD2ysSV6YuQ=;
        b=QwUeOSU75xqTuqzaG8svKaACP4/v4JCMnkTT/VstAZ6PBWUXpiOrIZJWUI2gwRjhrI
         8OEIRapdQ8+80TChU3b4PgrocaxhQzOvRy6Y4p2T9Ya7NCm+dT/JlG6dp9CWO9Y24XnS
         NNSBOOlsQEPGjBgVBKvfn2P/iBdbvHwaQJkX/Lhr4Np0TYi1WfA/WHlN+dqb1qj6D53z
         iPFFWEFGNHwemSS92fs/zAnfWH907se0AOwzL5za9nbfUsXZmm/ENARLLHcThBnOLU0t
         vXbL9qioiOXYLgQRj1BQbRG5+vEuhq3TZgtnPg+zy18RTSxpaNpwEcaxCZzwAtHvfItG
         3BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793617967; x=1794222767;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vPV6V8DGBlGRUTmkiPIegMrg4UNT29rSxD2ysSV6YuQ=;
        b=n0Zp75STDYXT5ryx0Gk7z4gKuGeyBIsYSYVyOUnaISyCZ+H5SxRYD+cIjA+GtKv1X7
         VkvLzTVtVI0aPCLxfVrb7xS2TC/eJTehHMwpcTEt29yTI6NsArojPJFQv1X7uZaFTLug
         IfllItpbqooi5OFisBqeD/kzPTc69m7YQD6iXCd22mmM8KhjzKSvqVonmQe427x09Zlc
         nsRi4t7SqoLBIfhBECmDZAlZN8neGWagFTd1fxlByIlfN5AiB1P7Wa3V0L34rwJKJj2I
         KiO0gHRK5Vn16YjH6/P81rxoIFHa+khVYswfkJN6QrkwY2rXZ9uJFHGDFU36JXfZ923I
         fQNA==
X-Gm-Message-State: APuU4Z9hg4C3FlPXtZMiC5s2Td4KLPpq9Eb3o1lACad2fx1/kZtlo3kr
	qnhhrpjUMRXLwSGHBetp24NVcXwQ94ZrsBcHSzyezywmNg4vU1yIGAhuWIv/Bi4aSHn2fRD+5ju
	FkMS04fQ0a8uM1P2KBHlvt4ZIUIZ8fH5xSl2yQWbTheHEW0+s/Zbhz0JiWxNqqmgUMQ==
X-Gm-Gg: AYBFou1fJkGZQds7GMSWfLlw5DxGEiKE5tCl4PrOZ5NHz10/hQgnGnkDjE+1y5k1R6K
	pPyrahtS2fxMpJS3rXtQTaCZIkXr8yBASyKztUMc3tspCwKBNPoCzdfpv/6CBqf9SF0qpV78PV5
	b799b14ORwvY5mvNsMC5BBryHTJeI3X6UFF8yxevJNUxNyKV869H9SWlhKo2Eq6zDzsZexUSBlJ
	x/hTCDO0w0N2UQ6Yc2Sm/579TZIr65dT90Qur9AzSXjC3XV73Dr42eb+NrOm+FOpTK97z6n0vRd
	Oii4X3qBnQUACvpCnhv7DEg0csbNovlnxtmQGeKq8G6bNuP2jcsxJ/Ki4ApvfobDOwfzpMPjr6u
	1IZolN++VgsYT9AKrPkU9bdWuxxSMvkcbAMDfCAHdPB3JlknSPmnGVp58o+dRGia0i+0x1mcMs0
	my0iqLGWL7nv72q5Ri2OB3O3pYslDjQePmDCSFu6+3jDg=
X-Received: by 2002:adf:fc0d:0:b0:48d:f383:2356 with SMTP id ffacd0b85a97d-48e6e500514mr17234870f8f.53.1793617967290;
        Mon, 02 Nov 2026 03:12:47 -0800 (PST)
X-Received: by 2002:adf:fc0d:0:b0:48d:f383:2356 with SMTP id ffacd0b85a97d-48e6e500514mr17234823f8f.53.1793617966763;
        Mon, 02 Nov 2026 03:12:46 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c0b6sm18758756f8f.41.2026.11.02.03.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 03:12:46 -0800 (PST)
Message-ID: <3288235b-136a-4f97-b9f1-f007a9eec0a1@redhat.com>
Date: Mon, 2 Nov 2026 12:12:45 +0100
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
Subject: Re: [PATCH net] net: atl1c: free the RX buffer when the descriptor
 reports an error
To: Federico Musto <federico@rimpianto.com>
Cc: stable@vger.kernel.org
References: <20261027121810.18654-1-federico@rimpianto.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261027121810.18654-1-federico@rimpianto.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/26 13:18, Federico Musto wrote:
> atl1c_clean_rx() drops a frame whose return descriptor carries
> RRS_RX_ERR_SUM or RRS_802_3_LEN_ERR by calling atl1c_clean_rfd(), which
> only marks the RFD free and clears the skb pointer.  Nothing unmaps the DMA
> mapping and nothing frees the skb, so every errored frame - CRC, alignment,
> truncation, runt - leaks one skb and one DMA mapping.  The driver uses a
> 32-bit DMA mask, so on a host without an IOMMU each of those mappings also
> pins a swiotlb slot.
> 
> Unmap and free before the RFD is recycled, the same way the good path does.
> The hardware already counts these frames in its own error counters, which
> atl1c_get_stats() reports, so no software counter is added here.
> 
> Fixes: 43250ddd75a3 ("atl1c: Atheros L1C Gigabit Ethernet driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Federico Musto <federico@rimpianto.com>
> ---
> Spotted while reviewing a fix for a different problem in the same function
> (skb_over_panic on oversized RX frames), by the Sashiko review bot.  It is
> independent of that patch and applies on its own.
> 
> The guard on buffer_info->skb is there because the slot can be empty after a
> reset; rfd_num != 1 stays on the old path, since multi-RFD is not supported
> by this driver anywhere else either.
> ---
>   drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> index e58f1d2..2d68955 100644
> --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> @@ -1908,6 +1908,23 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
>   rrs_checked:
>   		atl1c_clean_rrd(rrd_ring, rrs, rfd_num);
>   		if (rrs->word3 & (RRS_RX_ERR_SUM | RRS_802_3_LEN_ERR)) {
> +			/* The RFD is recycled below, and that drops the only
> +			 * pointer to the buffer: unmap and free it first, or the
> +			 * skb and its DMA mapping leak on every errored frame.
> +			 */
> +			if (likely(rfd_num == 1)) {
> +				rfd_index = (rrs->word0 >> RRS_RX_RFD_INDEX_SHIFT) &

Sparse is not happy with the above:          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> +						RRS_RX_RFD_INDEX_MASK;
> +				buffer_info = &rfd_ring->buffer_info[rfd_index];
> +				if (buffer_info->skb) {
> +					dma_unmap_single(&pdev->dev,
> +							 buffer_info->dma,
> +							 buffer_info->length,
> +							 DMA_FROM_DEVICE);
> +					kfree_skb_reason(buffer_info->skb,
> +							 SKB_DROP_REASON_NOT_SPECIFIED);

Also this is duplicating existing code a few lines below.
Please factor out as much as possible in a common/shared helper.

/P

