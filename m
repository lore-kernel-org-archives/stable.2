Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465C79CD;
	Mon,  5 Oct 2026 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226913; cv=none; b=bQsmc1YPTuTMDXRW5vTaa6LX6FJOma0fbebR495maURxZZBBsRN/opMK742nZI8fSAS2kKAAQd24VFBRzL5sygV4sGamVq5/wc8BM4XTdNB4Kc9O5odd9qHXNI3qD4IxMU1QeBkp48N8uxkSe/wtqGSRXZ/1eTUvO68jF1fWP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226913; c=relaxed/simple;
	bh=hnm6bOUZbgMgPBRT4+7ffT/wy4OyP5ZauIF5q/q0wHw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aOQd7UTtDGY7Z0gNOBpg+Ga448cX/0XY/TlzML/fgu9RMamsZav8WPO3wCd5ihdig/619a9uek48TXXzqWndtt9UJ1bqxnrmEEHPc+WR/0CImrHE8ml91uiKaWS9i2tKs6wGqd+gg/AiCeKWFb/YiU9fMTR+W8T4QsyRfjormyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=OEBkDISV; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="OEBkDISV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MFmvViKGM02BTIPHCsWBHeyAcfFFDZ4nwZbqK2y2Fco=; b=OEBkDISVDy6iMQlVMG44QL6uCr
	m7Jh0cTlwe6WWjkOummiuJA9pYYzUJPfMV1wu2IGzlDVYoEHacByBGJfDrEqUPIW6mwECm9oUofpE
	esdQoaVhTdDToNBTBEyBFbFs9kf4CcPqQCpRytEetWsyp36oiq5r1WbQItM6wPEsROad3qcV4udZ2
	wRSYP3TA16RiPdCxOp4Uq8FJXpjrP0W4j5r+6OVcjzXpuuc82QgoGeoi4P6NbK6H4dG6tk1JiDmiE
	PskV7AiU7Dsiq/DYBiw2s2hYNuf40NkNXExUXl33wk3HJdtjfnL0l8htSANWB0J0YQ7aKjDn41E3i
	xUwUiJew==;
Received: from [::1] (port=36386 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xDnwc-0000000E0B2-0Qa3;
	Mon, 05 Oct 2026 21:01:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Oct 2026 21:01:49 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jon Maloy
 <jmaloy@redhat.com>
Subject: Re: [PATCH net v2] tipc: protect received keys from concurrent flush
In-Reply-To: <DU4P189MB37501CA7DBF5D6C3C8752349C6962@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20261002205932.1874012-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <DU4P189MB37501CA7DBF5D6C3C8752349C6962@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <2ac35bd0a3d8c774d0ee2bc977a45cf0@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello,

On 2026-10-05 04:14, Tung Quang Nguyen wrote:
>> 	/* Attach it to the crypto */
>> 	if (likely(!rc)) {
>> -		rc = tipc_crypto_key_attach(c, aead, 0, master_key);
>> +		spin_lock_bh(&c->lock);
>> +		if (ukey == c->skey_in_use && c->skey != ukey)
>> +			rc = -ECANCELED;
> 
> This check should be done earlier, before calling tipc_ahead_init() ?

Would moving the check before tipc_aead_init() be enough, given that a
flush can still happen while AEAD setup is running and before the key
is attached?

Indeed, the race goes something like:
1. Worker starts tipc_aead_init()
2. Flush clears rx->skey
3. Worker finishes AEAD setup

AFAIU, we still need the check under c->lock, immediately before
tipc_crypto_key_attach(), so that a revoked key cannot be published
after flush.

> 
>> +		else
>> +			rc = tipc_crypto_key_attach(c, aead, 0, master_key);
>> +		spin_unlock_bh(&c->lock);
>> 		if (rc < 0)
>> 			tipc_aead_free(&aead->rcu);
>> 	}
>> @@ -1151,6 +1158,8 @@ int tipc_crypto_key_init(struct tipc_crypto *c, 
>> struct
>> tipc_aead_key *ukey,
>>  * @pos: desired slot in the crypto key array, = 0 if any!
>>  * @master_key: specify this is a cluster master key
>>  *
>> + * The caller must hold c->lock.
>> + *
>>  * Return: new key id in case of success, otherwise: -EBUSY
>>  */
>> static int tipc_crypto_key_attach(struct tipc_crypto *c, @@ -1158,20 
>> +1167,19
>> @@ static int tipc_crypto_key_attach(struct tipc_crypto *c,
>> 				  bool master_key)
>> {
>> 	struct tipc_key key;
>> -	int rc = -EBUSY;
>> 	u8 new_key;
>> 
>> -	spin_lock_bh(&c->lock);
>> +	lockdep_assert_held(&c->lock);
>> 	key = c->key;
>> 	if (master_key) {
>> 		new_key = KEY_MASTER;
>> 		goto attach;
>> 	}
>> 	if (key.active && key.passive)
>> -		goto exit;
>> +		return -EBUSY;
>> 	if (key.pending) {
>> 		if (tipc_aead_users(c->aead[key.pending]) > 0)
>> -			goto exit;
>> +			return -EBUSY;
>> 		/* if (pos): ok with replacing, will be aligned when needed */
>> 		/* Replace it */
>> 		new_key = key.pending;
>> @@ -1201,11 +1209,7 @@ attach:
>> 	c->working = 1;
>> 	c->nokey = 0;
>> 	c->key_master |= master_key;
>> -	rc = new_key;
>> -
>> -exit:
>> -	spin_unlock_bh(&c->lock);
>> -	return rc;
>> +	return new_key;
> 
> Remove lock from tipc_crypto_key_attach() is enough. Why adding many 
> irrelevant changes that do not seem necessary ?

Those extra changes in tipc_crypto_key_attach() are more cleanup than
anything else; I preferred the direct returns since the function no
longer owns the lock, but I can reduce the patch and keep the exit
label.

Thanks,
Jérémy
