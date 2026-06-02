Received: from ixit.cz (ixit.cz [185.100.197.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786043D47B2;
	Tue,  2 Jun 2026 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.100.197.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395219; cv=none; b=pQio/ig9OQryZm/xbEfoX03pGR9ASdm7fVerTKNANTyvM4kOCU0ZYR2oyE3aUGZ/NpefCrPftwhBwU6shucfrw+MGJNIL4sW28TFxpR2T8/v9oZF8AWhLPKkLojPVwbwRD5J2ofd5ujYYxJgPxLGmzTKdUFo6+1zA3nr47YVooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395219; c=relaxed/simple;
	bh=9dWJmOeNAZspaBa8O+OPVMNFVl+ladrJV5YSlBcQeYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ij4I86EV89n3wVroIaq/20/0MqJjRrAQS+2t9OHc1rAIHUtAKhgI47JdjA427X6s3sW3Qw8JlTGqXPL5xOkb5WPZ4E4RKUz44tgTy4pupIDABC2ZT3kbnAUzCiGfgzFaLNJkCiP52yw9oXm5nNfEwSZFLSFao0AENRTWO159jxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=x531GGVs; arc=none smtp.client-ip=185.100.197.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="x531GGVs"
Received: from [172.20.10.2] (37-48-17-230.nat.epc.tmcz.cz [37.48.17.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 1E851534046D;
	Tue, 02 Jun 2026 12:13:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1780395212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UeAf18dGfpVcHM4ZsOsIO1hfpCZ9+x5/eIrTR0tYfNk=;
	b=x531GGVspMX8sbbH4BEgcNvtp+f8soQ/vqXaIstgLgjDshhHh2MtcPWBtYgblumBu8Ootd
	YsRsgehZjzXziX7BLyYMsdGVfZceShhox4D21BTC7Gy563jpfAjeqsuPGxeT9SpOfvHnfv
	W76KEnt6y2eEyef/71NzxpYUBiFmlhY=
Message-ID: <bbe9d826-80b6-4aec-80d3-b8faca0375f9@ixit.cz>
Date: Tue, 2 Jun 2026 12:13:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] nfc: hci: fix out-of-bounds read in HCP header parsing
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260505170712.96560-1-ashutoshdesai993@gmail.com>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260505170712.96560-1-ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/05/2026 19:07, Ashutosh Desai wrote:
> Both nfc_hci_recv_from_llc() and nci_hci_data_received_cb() read
> packet->header from skb->data at function entry without first checking
> that the buffer holds at least one byte. A malicious NFC peer can send
> a 0-byte HCP frame that passes through the SHDLC layer and reaches
> these functions, causing an out-of-bounds heap read of packet->header.
> The same 0-byte frame, if queued as a non-final fragment, also causes
> the reassembly loop to underflow msg_len to UINT_MAX, triggering
> skb_over_panic() when the reassembled skb is written.
> 
> Fix this by adding a pskb_may_pull() check at the entry of each
> function before packet->header is first accessed. The existing
> pskb_may_pull() checks before the reassembled hcp_skb is cast to
> struct hcp_packet remain in place to guard the 2-byte HCP message
> header.
> 
> Fixes: 8b8d2e08bf0d ("NFC: HCI support")
> Fixes: 11f54f228643 ("NFC: nci: Add HCI over NCI protocol support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
> Changes in v7:
> - Add David Heidelberg <david+nfc@ixit.cz> to CC (NFC subsystem maintainer)
> 
> Changes in v6:
> - Add pskb_may_pull(skb, 1) at function entry in both functions before
>    packet->header is first accessed, to fix OOB read on 0-byte frames
>    and prevent integer underflow in the fragment reassembly path
>    (Paolo Abeni)
> 
> V6 -> V7: add NFC subsystem maintainer to CC
> V5 -> V6: add entry-point length checks per Paolo Abeni's review
> V4 -> V5: fix whitespace damage
> V3 -> V4: add Fixes tags
> V2 -> V3: drop redundant checks from nfc_hci_msg_rx_work/nci_hci_msg_rx_work;
>            remove incorrect Suggested-by tag
> V1 -> V2: use pskb_may_pull() instead of skb->len check
> 
> v6: https://lore.kernel.org/netdev/20260502163116.3409687-1-ashutoshdesai993@gmail.com/
> v5: https://lore.kernel.org/netdev/20260416051522.4154698-1-ashutoshdesai993@gmail.com/
> v4: https://lore.kernel.org/netdev/177614425081.3600288.2536320552978506086@gmail.com/
> v3: https://lore.kernel.org/netdev/20260413024329.3293075-1-ashutoshdesai993@gmail.com/
> v2: https://lore.kernel.org/netdev/20260409150825.2217133-1-ashutoshdesai993@gmail.com/
> v1: https://lore.kernel.org/netdev/20260408223113.2009304-1-ashutoshdesai993@gmail.com/
> 
>   net/nfc/hci/core.c | 10 ++++++++++
>   net/nfc/nci/hci.c  | 10 ++++++++++
>   2 files changed, 20 insertions(+)
> 

Applied, thank you!

David Heidelberg
