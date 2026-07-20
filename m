Received: from ixit.cz (ixit.cz [185.100.197.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356138D40C;
	Mon, 20 Jul 2026 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.100.197.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542801; cv=none; b=oToOZSGZ90HBF+VTVl+idZID0flPhvHMGCssY5NK7OApo1rk14Dl6SDp6fj+bnTaxigP8/8pFJITB7br4kPTinK4rnrGjy6DJQyGAA9UWhNOxd/O265NebMZOQUWKadugB7eiQDwL/eVV5M08sWrRoSJJ1E8BJCC4PTo63c+dbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542801; c=relaxed/simple;
	bh=KQFle3mVwzRYw+iZYzfuPZpd+rXirZ8KjSV9GSKecPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9zQ+flJoN5HtzDt8QBu2mbu4q09dul8pBt4lNODGvQZ0PbQN/Hky++BVMwAubFycp6/vqyOzE7mLC0Qn4iV0Ucz+eJofvU0btnyI+L9kuNxrk21b67k9BozkIfSHbVzuQ90c07dmpxivSCB3xq4RLP6sFzyoTOINaEbW5gHebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=jP3lKWH9; arc=none smtp.client-ip=185.100.197.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="jP3lKWH9"
Received: from [172.16.124.192] (ip-78-44-13-22.bb.vodafone.cz [78.44.13.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 3981553402DF;
	Mon, 20 Jul 2026 12:19:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1784542792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qcDhn224rStfvptBJiigEu4y85c4gmPOk5mFKMYgTfI=;
	b=jP3lKWH9qVUH6g1X8zuhBq5M6kn0Ls3Lq0rD/nix6Hlh79FYOdtb8SGctUWswMFgsIrlB/
	RBgc2DqGc5T18C3Z1YRGgVqNynSl1Wp2j/jVdXSSJCbGwuKZMIj0kG7X6yDmJ1atLiS5iv
	BWxFC2g3RndhFMB0ISbTve+bhSHYrRY=
Message-ID: <879ab436-043a-450d-87c0-70e7c6f4ff8f@ixit.cz>
Date: Mon, 20 Jul 2026 12:19:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nfc: fdp: bound the device-supplied read size in
 fdp_nci_i2c_read()
To: Simon Horman <horms@kernel.org>, Doruk Tan Ozturk <doruk@0sec.ai>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260711123641.32502-1-doruk@0sec.ai>
 <20260720101620.GD19108@horms.kernel.org>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260720101620.GD19108@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/07/2026 12:16, Simon Horman wrote:
> On Sat, Jul 11, 2026 at 02:36:41PM +0200, Doruk Tan Ozturk wrote:
>> fdp_nci_i2c_read() reads a "length packet" from the FDP I2C controller and
>> computes the size of the next I2C transfer from two device-supplied bytes:
>>
>> 	phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;
>>
>> next_read_size is a u16 (up to 65535) and is never bounded. On the next
>> loop iteration it is used directly as the length passed to
>>
>> 	i2c_master_recv(client, tmp, len);
>>
>> which reads into the fixed 261-byte stack buffer
>> tmp[FDP_NCI_I2C_MAX_PAYLOAD]. A malicious or malfunctioning controller
>> that reports a large length thus overflows the stack buffer -- the
>> r != len check runs only after the read has already happened.
>>
>> Reject a next-read size larger than the buffer and resynchronize.
>>
>> Found by 0sec (https://0sec.ai) using automated source analysis; the
>> missing bound is evident from source. Compile-tested.
>>
>> Fixes: a06347c04c13 ("NFC: Add Intel Fields Peak NFC solution driver")
>> Cc: stable@vger.kernel.org
>> Assisted-by: 0sec:claude-opus-4-8
>> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
>> ---
>>   drivers/nfc/fdp/i2c.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
>> index c1896a1d978c..581f85f0dfa8 100644
>> --- a/drivers/nfc/fdp/i2c.c
>> +++ b/drivers/nfc/fdp/i2c.c
>> @@ -128,7 +128,7 @@ static const struct nfc_phy_ops i2c_phy_ops = {
>>   
>>   static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
>>   {
>> -	int r, len;
>> +	int r = -EREMOTEIO, len;
>>   	u8 tmp[FDP_NCI_I2C_MAX_PAYLOAD], lrc, k;
>>   	u16 i;
>>   	struct i2c_client *client = phy->i2c_dev;
>> @@ -140,6 +140,13 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
>>   
>>   		len = phy->next_read_size;
>>   
>> +		if (len > FDP_NCI_I2C_MAX_PAYLOAD) {
>> +			dev_dbg(&client->dev, "%s: read size %d too large\n",
>> +				__func__, len);
>> +			phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
> 
> I think it would be more robust to explicitly set r here.
> Because it is assigned a little later in the loop, overriding
> the default assignment made by the first hunk of this patch.

I agree, I was looking at this patch yesterday and the current format feels 
unfavorable.

Please send next revision with Simon suggestion :)

Thank you both!
David

> 
>> +			goto flush;
>> +		}
>> +
>>   		r = i2c_master_recv(client, tmp, len);
>>   		if (r != len) {
>>   			dev_dbg(&client->dev, "%s: i2c recv err: %d\n",
>> -- 
>> 2.43.0
>>

-- 
David Heidelberg

