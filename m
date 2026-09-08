Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284EE579806;
	Tue,  8 Sep 2026 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885828; cv=none; b=pLhJCZ2iKn80zeNu+2GDgwaG7bgv3sJHwhNCE9Or8SZWvo1KQ3r+4mBYELmHrsYDiAib5SPDB5Z8aCdzjZrxzWvoZN0vui4IDsstU46Zo3sM6MJzFGkUB2ngGcKcDJEHHFrfyWW865J6EtXfXcxT461ppb10CQAJUivFpFwRNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885828; c=relaxed/simple;
	bh=BeVg/o6n5kVBf89V3PqRwqUEH/SxBe3/mZtoyE+Y2Bk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=peMqIrYPKlMbOUUg6GOO9z3CVR53i2WKE2v2asxnAKPf8K5ug9g+pAw4lFi/GlEmbwt8n46xEPwRAwdb6x7nvptS2egmh7Xn9qKY+yICmmoCW7fbeW+s8NmalzKYCP+ksEsiSIAOM7UUNvoaGc728bzIahMKhczlLROlbFPmcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Thomas Fourier
 <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>, "open list:QUALCOMM ATHEROS ATH9K
 WIRELESS DRIVER" <linux-wireless@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] ath9k_htc: fix possibly missing barrier in
 ath9k_htc_rxep()
In-Reply-To: <a5534789-351d-402c-b7a0-bdd98b68fcd3@oss.qualcomm.com>
References: <20260803104424.25880-1-fourier.thomas@gmail.com>
 <a5534789-351d-402c-b7a0-bdd98b68fcd3@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 18:43:42 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87mrtrg0ch.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <jeff.johnson@oss.qualcomm.com> writes:

> On 8/3/2026 3:44 AM, Thomas Fourier wrote:
>> ath9k_rx_init() initialises the rx buffer and its lock then calls a
>> memory barrier and then sets the priv->rx.initialized flag. However,
>> ath9k_htc_rxep() reads that flag and imidiatly takes the lock. This may
>
> s/imidiatly/immediately/
>
>> cause the lock to be taken while not fully initialized.
>> 
>> Add a barrier to prevent speculative read of the lock before checking
>> the initized flag.
>
> s/initized/initialized/ (or initialised)
>
>> 
>> Fixes: b0ec7e55fce6 ("ath9k_htc: fix NULL pointer dereference at ath9k_htc_rxep()")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
>> ---
>>  drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
>> index bed7ea2425a0..97d61f3f0aad 100644
>> --- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
>> +++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
>> @@ -1145,6 +1145,12 @@ void ath9k_htc_rxep(void *drv_priv, struct sk_buff *skb,
>>  	if (!data_race(priv->rx.initialized))
>>  		goto err;
>>  
>> +	/*
>> +	 * Make sure all the ath9k_rx_init() memory writes are visible before
>> +	 * proceeding.
>> +	 */
>> +	smp_rmb();
>> +
>>  	spin_lock_irqsave(&priv->rx.rxbuflock, flags);
>>  	list_for_each_entry(tmp_buf, &priv->rx.rxbuf, list) {
>>  		if (!tmp_buf->in_process) {
>
> I decided to run this though my review agent, which has the following
> analysis:

[...]

> So my question: Are there any flaws with that analysis?

Well, my conclusion was basically that adding the smp_rmb() is not
actively wrong, even if it's not exactly idiomatic.

But sure, we can go with smp_store_release/load_acquire instead; might
as well fix up that other tasklet issue while I'm at it...

-Toke
