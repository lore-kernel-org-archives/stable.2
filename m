Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA440D56D
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781744721; cv=none; b=qlWELblKEvnV60Qd8RT4UtSWJuOzQDtN85OLLTugvj/Dbrm6nUF6ORw9wbghY5Y5dFj+Xyl4LtpDpqFd+uF+QzQ9DyoKu1SBOxp2MiqKjXqicAup9tzYUCTaXYpSZ1xjmg43Cb5s+8NYMBVCALHhdmDdFYVB6K3abyKUmgMYeaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781744721; c=relaxed/simple;
	bh=+XRkizlxSiaIPccIILOZMMZ5RJB21hfbZmbwB1p9tVg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TO6ql78Ongspo0Er6l6vSle/08psZZ9bRQ1fcHZ0tCQ0TMl+M1ZzOwquu1DeH1ype/yY4FhGEBBHQDYehBnzeXKTgNYXyJfEW9h3g5wNKpMBaWUG69hYKR9tTUjw2FugYTJ5lwR0Qcq+Pz7lPfqZB5Yq1/HkINzN6NTCGVCwAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=GsMwObX1; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="GsMwObX1"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-307d0405e07so540246eec.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 18:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781744719; x=1782349519; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9uVgSQdUYBsWNxEjygFFmbqqwNexw95BMWZSodXtKY=;
        b=GsMwObX1CBvn5DgCUp1RMQEBGpjKPB+RKJlKxmU5uNgCYHIe2A5EQCcftaCemI+Jou
         jE+yZVaG6UDPoYShHbwzjdqzRq2ieN9P5qYBmXzZPTR1dn9fT86gm9veb82Gc8C13vVN
         Uld8eY10eGbBsF5IQ9IhgxR+ifKiO43ZcxMCi79iJVNvCiaR+Urk5D3m7LKasolUGF86
         CY0h+Q1AOuGei1FEsqyvdJDoYuCkcCXk8lX7MMWUNmSu2FN+uf2P3wksMOTVhu+Oc9xT
         okurzQjaILEM0pqVgIQ3IvGOeBVCtjqXszN6RhVdqZHQSTnPPHgLURUvU45mYn6C6rEx
         h1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781744719; x=1782349519;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9uVgSQdUYBsWNxEjygFFmbqqwNexw95BMWZSodXtKY=;
        b=KruU6UUOh9717kI/rAXbRWd01ziWkh9jvugShDz46UhgPV0Sz3X06ohkl1yUf0GLjF
         pyZBwFsLdXBT6DZFToCM8w/0JZOHtojLHcRfj8HwR7O7a6yusO0yo2ZHSwlnJGZhEk8z
         H3c9y/XbvjIyymR3e8U639SP7nT0U7Aq7itlYAbWTv7ilwXGG4u+9PNMZqFCst7Xjne+
         iTV2BDCWwe493pC04fYVGgJHl5E4VYXqETXGN7CnM8Mt3r9yePM4+OPWRdO4FPVA1ROC
         Rwd8a2ooyj6vIM4Cel4iHiLOl6IG2Uh78TaEqOTBKwW4wJ14MnzfEII1P08nW4bUq2Nr
         2jWw==
X-Gm-Message-State: AOJu0YwDKNvBDBfa4CQ31cy4+5YVr105sayzEFMLXauGKBdg7kRgVfpZ
	3EU5UMbUgnovUz7VrpeAmQIYJZienW224anvhdVswOG39oBG6DDnDZDb6/bnlFSGKoU=
X-Gm-Gg: AfdE7cmIQh/6XJV7dpxGor0sAG4syFq+HldD6wbfidDGwZMlOUIYCgZGEVzDzHne8ne
	yalCKAj1jgt0tjnZ6NPij9uiaTH9bLGqpO2Tnc2l6lUze4Ij2OqSw3TwHUMjMQefhuaEDv72iSe
	iqhHIAFPJpDpGJpZ6hpQAvQ70RbKgtCYnR8iaufAK3tkgCazLBJVNixZVXJpPYwadXXlKioeu8P
	r48WveJVm0pSzCojCRgL/yCePpVazonQTStBw83L5nheau7QPftFjchXp1+FQGn5RrLKvwgAfxa
	OvzXUaEidK39DxmPBAqaQdq179gRDPjpfmqwWoaJhdr3zzfYh1MWjZyCSp8wGkiopM3PgOljPTP
	MKrjzyUB8qhNOBJDqGkAU7z++uvKZREhYDThtlptx0wK37oNTPl8+SPsWByQr7rTLYC9+l0cSym
	GeVNJsgZUpUdb4
X-Received: by 2002:a05:7300:8ba9:b0:304:9b48:53d8 with SMTP id 5a478bee46e88-30bf0763f79mr850796eec.10.1781744718949;
        Wed, 17 Jun 2026 18:05:18 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm26591830eec.4.2026.06.17.18.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 18:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 18:05:17 -0700
Message-Id: <DJBRSFL3XYKA.6ZJOE7DGSPEW@nexthop.ai>
Cc: <stable@vger.kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Guenter Roeck" <groeck7@gmail.com>
Subject: Re: [PATCH 20/38] hwmon: (pmbus/adm1266) widen blackbox-info buffer
 to I2C_SMBUS_BLOCK_MAX
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Guenter Roeck" <linux@roeck-us.net>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.21.0
References: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
 <20260618003128.3112824-20-abdurrahman@nexthop.ai>
 <800cc395-c986-45dd-a01f-aa4e0f37c849@roeck-us.net>
In-Reply-To: <800cc395-c986-45dd-a01f-aa4e0f37c849@roeck-us.net>

On Wed Jun 17, 2026 at 6:04 PM PDT, Guenter Roeck wrote:
> On 6/17/26 17:31, Abdurrahman Hussain wrote:
>> commit eee213daa1e1b402eb631bcd1b8c5aa340a6b081 upstream.
>>=20
>> adm1266_nvmem_read_blackbox() declares a 5-byte stack buffer and
>> passes it to i2c_smbus_read_block_data() to retrieve the 4-byte
>> BLACKBOX_INFO response.  i2c_smbus_read_block_data() does not honour
>> caller buffer sizes -- it memcpy()s data.block[0] bytes from the
>> SMBus transaction (where data.block[0] is the length byte returned by
>> the slave device, up to I2C_SMBUS_BLOCK_MAX =3D 32):
>>=20
>> 	memcpy(values, &data.block[1], data.block[0]);
>>=20
>> If the device returns any block length above 5, the call overflows
>> the caller's 5-byte stack buffer before the post-call
>>=20
>> 	if (ret !=3D 4)
>> 		return -EIO;
>>=20
>> check has a chance to reject the response.
>>=20
>> Widen the local buffer to I2C_SMBUS_BLOCK_MAX so the helper has room
>> for any well-formed SMBus block response, matching the convention used
>> by the other i2c_smbus_read_block_data() callers in this driver.
>>=20
>> Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>> Link: https://lore.kernel.org/r/20260515-adm1266-fixes-v1-2-1c1ea1349cfe=
@nexthop.ai
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>
> I am completely lost. What is this series about ?
>
> Guenter

I am so sorry, I have sent these to the wrong list. Please ignore.

Abdurrahman

