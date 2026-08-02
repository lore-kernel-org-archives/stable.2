Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50DF3BE16F
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682821; cv=none; b=p4Z5dhKBW4uw2UM6KePEwckZhLGh7IGOxU1WqN0vp5reT6AT+dgsGPzDBBQid525dVwyxiYiXfomEVHIbnoF6eHLHP3+ganu3JMmBCtcAkGhNe5zWta9MWrbeI5dhwksyCv2PNoSOc4EwYR8SpEAA9iMEM0+3adrHW4+cDlOxOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682821; c=relaxed/simple;
	bh=1ABiPp4UdOFHDmR/kVqOSaBai6KDqRepZunqk3UqW+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSOeumz5IodzwrxlFdPngtFHpR9YmE2tqDe1r4l6wZcY1DN818yWWBv+FMMmuIpvTozoZ7cZA11hlRHsQw5QaYty34DczyLB0/a/Odo4epK4fBkQIycog/rWXQyCW30mGrz8sgWnVaSFXa0/KEZjQMQkYa7Ujmjodnr/A3/RLQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdCWJWtv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdCWJWtv"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc891373e0so26303975ad.2
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785682819; x=1786287619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m7GubX2oexnzGSUu+7RCqdftEDvzwkCvHfcYB+mewBQ=;
        b=FdCWJWtvfSawpyugPc2/UNCCX8f5j9jCnMiCqIlxcyhx/GCzhTZ2ciOELTYmivrcS/
         jW6JeCDUdPBTn35pMkKRlvF5lZllYTj9O6JhA3ZX2h7VqT+jhgNUpXVCYO+AECJ3lEEn
         /ty9bHMCYlgyUhAVesxa8VM1Tgp8eyEzg5DIoeJibGfwgscAcdjYbei2xsBhFpLleUxe
         FTVk7mmloDSBK6QNa45KMc87EMVQRDakmd723VYfEZAZ3TEq6tQAggInJbGd92bLkU/S
         pHfkeyTxK+zAd+U3wjjozkeX13yEbh1rZbdeh32uNXR/LXx3qVyQ+PVB7FigROO8wxg5
         NHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785682819; x=1786287619;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m7GubX2oexnzGSUu+7RCqdftEDvzwkCvHfcYB+mewBQ=;
        b=k2/iPOUZyKt4VkM+BQSG5VaOGcwxVpjPpSGtllPr4yBXaOxJEoLtwaNfRFBLPhkIo5
         tEtswXleKrSYSceJCKjZUh8YjOccFuy4XUuvfeQgU1T7ICrLB0bqytIw1lvJXjhvGHAD
         jSicYixxQu73Ozoal8N5smPIS9zj9PBOxJcsx0qT4toOxz8z4f3vuAxEvAasqCR2Ps2J
         /lW/zWChCAFy8ZobNL3xzavyu5iRauMZ3JdZJZLgNL6dLEBF34vZ8AsIu8dL57TE3h4L
         XorWxp6n+SdIyfsM5OK78GtIDfDmedfGek1Mzg1TnV7ZcBWtDBbOmD4lG3H4orcdK1QY
         ujLQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQBZ0PzZxN5yxad2oLSkVOU3rB+hssFXIlJAZlCqhLhb7FUE1EEbs3bdfYm1yaElQI+asVdNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiKE1zL2/i7FlwGWsL4S5sJhq30FYZG9a9qLQA/uvF3FF/ZMmQ
	o8K0Xtz5yXelOB/vxyEYVdx04V1UFQFgPOWLqZjQQUlTPak11ZOo9mZw
X-Gm-Gg: AR+sD12y7+4n4GefZZQBl1YOfpRcogJ3SmGYxB9aJBJUdTBdXO7hHCAVc4KvTRyi9aw
	k7c4DPoGV3A/E7xMvV2gKCBct64OUrJcwelLenMdip++BE7nYiJx48bPJdA2n426eg0mPmPl3IY
	fYjEUV0P80FPZ/nuYa7w65xWQuxFNyJJUGJsLncYfKqmlLniLMZJ1kNbqJea1e825gzLPn+DKi0
	Ixa3yLpr5tL6SOrUacW2spSGgRRkyw686JBz7NUSKLWeQiJbwQ7H00EGcv3UT8xMTY9A1LQNXVB
	kJmaRd4qFA5/16Tcgabjj0HFpXMoTNmu39LR9W+Jvs/M3Dc3+n5NL8FtikBie7jJOYmLiZtqTv0
	8F6U4LWzq6DayvX8H2LnjqEIM/fsCJqT0RElTqmMYNDQk2HN0ZspMZY2ID1gLIKQSdFOwrFEZSx
	LWWXTAaTcBJ2Jhbu9bQtm2hCCIWs09wykPpauCCECsl6bLZo7uBKPri0yVlrMIHDMjwGWw6sOBF
	GdjRUgo/cIpJmKgPamAqbDnXbPoglmoWQ==
X-Received: by 2002:a17:902:f612:b0:2ca:f44b:63be with SMTP id d9443c01a7336-2d0521bc1b4mr67661545ad.3.1785682816962;
        Sun, 02 Aug 2026 08:00:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5ac3dsm26830925ad.23.2026.08.02.08.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 08:00:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8f25c37b-8408-47f2-8069-87a1ef96ce7e@roeck-us.net>
Date: Sun, 2 Aug 2026 08:00:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (sg2042-mcu) reject short uptime reads
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Inochi Amaoto <inochiama@outlook.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260802130728.25721-1-ali@iusegentoo.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260802130728.25721-1-ali@iusegentoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/2/26 06:07, Ali Ahmet Memis wrote:
> uptime_show() asks for two bytes and only rejects a negative return:
> 
> 	u8 time_val[2];
> 
> 	ret = i2c_smbus_read_i2c_block_data(mcu->client, REG_UPTIME,
> 					    sizeof(time_val), time_val);
> 	if (ret < 0)
> 		return ret;
> 
> 	return sprintf(buf, "%d\n",
> 		       (time_val[0]) | (time_val[1] << 8));
> 
> i2c_smbus_read_i2c_block_data() returns the number of bytes the transfer
> actually produced, which the device supplies and which can be shorter
> than the length asked for:
> 
> 	memcpy(values, &data.block[1], data.block[0]);
> 	return data.block[0];
> 
> time_val is not initialised, so a reply of one byte leaves the high half
> of the reported uptime as whatever was on the stack, and a reply of zero
> bytes leaks both halves. Either way the value ends up in sysfs.
> 
> Require the full two bytes. The other registers this driver reads go
> through i2c_smbus_read_byte_data(), which returns the byte itself, so
> the existing negative-only checks are right there.
> 

I ended up asking AI:

Does i2c_smbus_read_i2c_block_data() in ./drivers/i2c/i2c-core-smbus.c ever return less than the requested number of bytes unless there is an error ?

Here is what it tells me:

   No, as long as the requested length is <= I2C_SMBUS_BLOCK_MAX (32 bytes), i2c-core-smbus.c will never return fewer
bytes than requested unless a negative error code is returned.

   The only scenario where it returns a positive byte count less than the caller's requested length is if the caller
passes length > 32, because the function clamps the request to I2C_SMBUS_BLOCK_MAX.

   ### Why this is the case

   1. No Count Byte in I2C Block Read (I2C_SMBUS_I2C_BLOCK_DATA):
   Unlike an SMBus Block Read (smbus-protocol.rst), where the slave device sends a length/count byte as the first byte of
  data transferred, an I2C Block Read does not include a length byte from the target
   device. The master reads a fixed number of bytes determined by the caller.
   2. In i2c-core-smbus.c:
     if (length > I2C_SMBUS_BLOCK_MAX)
             length = I2C_SMBUS_BLOCK_MAX;
     data.block[0] = length;
     status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
                             I2C_SMBUS_READ, command,
                             I2C_SMBUS_I2C_BLOCK_DATA, &data);
     if (status < 0)
             return status;

     memcpy(values, &data.block[1], data.block[0]);
     return data.block[0];
     Before calling i2c_smbus_xfer(), data.block[0] is initialized to the requested length (clamped to 32). Upon success
(status >= 0), it returns data.block[0].
   3. In I2C Emulation (i2c-core-smbus.c):
       • The read message is set up for exactly data->block[0] bytes (msg[1].len = data->block[0];).
       • Unlike SMBus Block Data, it does not set I2C_M_RECV_LEN.
       • When copying the buffer back upon completion (i2c-core-smbus.c), data->block[0] is never modified and remains
exactly equal to the requested length.
   4. In Native Adapter Drivers (adapter->algo->smbus_xfer):
       • None of the bus drivers in drivers/i2c/busses/ implementing I2C_SMBUS_I2C_BLOCK_DATA (i2c-i801, i2c-viapro,
i2c-amd8111, i2c-ismt, i2c-mlxbf, etc.) modify data->block[0] to a smaller value on success.
       • If a target device NAKs before the requested length bytes are read, the controller driver fails the transaction
and returns a negative errno (e.g., -ENXIO, -EIO, or -EPROTO).

   Consequently, any successful call such as i2c_smbus_read_i2c_block_data(client, reg, I2C_SMBUS_BLOCK_MAX, buf) will
always return exactly 32 (I2C_SMBUS_BLOCK_MAX) on success.

Please refrain from sending fixes for non-issues.

Thanks,
Guenter

