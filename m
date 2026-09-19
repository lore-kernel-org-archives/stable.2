Received: from outbound.ms.icloud.com (ms-2001c-snip4-1.eps.apple.com [57.103.73.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A23B67E
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 00:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.73.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776557; cv=none; b=XpXz8AZbTJnxWWuRVwd2KBHjsCVKWjtMRH9XA8k9UnoDtYYz76bmbNFfc9wzmWAlR2XF9fRnfYs/qWNIbr9oZkQBa0P5/w20Ogb8YSPfdeAErLxsPTI1jYb7Kks/VubvmJ8cPRijNFxLFs/NniFvguk018qhNDPS4PKIc0oUoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776557; c=relaxed/simple;
	bh=nVD/Wq1bffouIXB6sEuIEnn5KaOl+dJUz6TNKysi7PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+yM5XNncnllRMPz3yCof6yh+rI+Tk6pWJDhXbz9CUMdsitswUKVhiisFju62uajpAnXI8dlPCIKzsR59GFwK97jAgV41H26Ga0L3kTFOgici4hrVEEy1/D8mZ0sbWBzJ6kTLofryl+cPM6QTa+GT4dPx0nfUo1Jf88DCmGHntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lcb.to.it; spf=pass smtp.mailfrom=lcb.to.it; dkim=pass (2048-bit key) header.d=lcb.to.it header.i=@lcb.to.it header.b=gxSzVl8M; arc=none smtp.client-ip=57.103.73.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lcb.to.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lcb.to.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lcb.to.it header.i=@lcb.to.it header.b="gxSzVl8M"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-2 (Postfix) with ESMTPS id E1ADD1800192;
	Sat, 19 Sep 2026 00:09:11 +0000 (UTC)
X-ICL-RepId: 01a0b6fe-df24-7d74-b4c1-7b16bc828ad8
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhBBkMEWRxBCU0dXwVcEhVdRV4MRR9bHlZWQwxHDkAfeRRQDxkfXV5QDBMLU1ZeE1tWRwIZAkZQSxsOWxcDVxxWRVwYQwldBVccHQBERVsTVRdGCRkIXR0ZCEcfCjADQg5WA0MHRQAtGRxXUFsIUF5NFx0EQ0tfGV1FDwsPXwsVAE4KQARdBhMUTAJeD0ZQRF1IHghUXARBCUoBDARZVDBVG1FDQwQcGU1GExlOG1dNWg1AGVgGbRRWFVIEWQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lcb.to.it; s=sig1; t=1789776554; x=1792368554; bh=xKp4/RRNjf7CFluY7B04eZM12U9KQe4R3f9PTydW+qI=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=gxSzVl8MvV5AGhXU/3+/2soWY0fhHsIu/TYOdJ7rrksEPSuQ/bCXTlCGl2u6jeT2msbZGYsfyN2anMfCo011O0xmTBWJh/tpkLl1DWbZLLXCm5u8QmIkdWWVY31aJGh1dS1aLZSccpppzsYoa+NvUZqKSWbXsw0JL3NLaA28WAenBgNqBJTBSpom5f8d6qcVB0uY2pZWx4g38Ex5LbJvm1B0ogXMnPU40S3sVVVWS9XiWdHm3fIFaLlJrlInXcDYLPuiGGa2Q0UTOdk2M0vcg9CUa5kuzQF4NNkgaspVmOwyxiouU0yHid/cgksyqc1ALREsla47y6shKPuk5StKsA==
mail-alias-created-date: 1748381178872
Received: from [10.69.1.69] (unknown [17.156.208.39])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-2 (Postfix) with ESMTPSA id 15DF3180018F;
	Sat, 19 Sep 2026 00:09:09 +0000 (UTC)
Message-ID: <f849e969-364c-4138-b4d0-ec761022a32f@lcb.to.it>
Date: Sat, 19 Sep 2026 02:09:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3
 14IWC11
To: Hans de Goede <hansg@kernel.org>, Iustin Ivan <iustinivan2002@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260911182328.9267-1-iustinivan2002@gmail.com>
 <db8af2fe-481d-454b-a205-4f22cd9b7a0d@kernel.org>
Content-Language: en-US, it-IT
From: Martino Papero <martino.papero@lcb.to.it>
In-Reply-To: <db8af2fe-481d-454b-a205-4f22cd9b7a0d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Info-Out: v=2.4 cv=M+BA6iws c=1 sm=1 tr=0 ts=6aadd2a8
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=l0MiAaP3XIdLQyEXZS4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDAwMCBTYWx0ZWRfX2YRQCxa8cX12
 Ctg5yDcoGE6Kgj0rji0/y1mTPGr2n9KyDGjzH6gW0AgJ1+ybIPuncUEAQLQejw4wHK0RUPLXW6O
 1ySCd7e0rEhKJ4eHbkdAOTOl0CS7OLtf/X+3gqJF6j5PHlVZAyt4owMg7drDXEy8ecLS8GjMtaD
 2ZafeRbxbLKTafLqQyfgULWGUlNbhpyyKUCnu5RlqwOUWc49RakAuH4y4ZmPVRyePPU0w7++cAx
 v0Clbx/pXoEBlvpbpzwAhAjk7j6myOuNtOpQwEa+GVWGWpcMHs4No3Qb9dcxLlmd7vpl7wZCpov
 P6q6a2dx9Q54jbN5Skwkied/Mr/t10wXO8lE8uwAOTysIuSO5B4v4a3f0Z7Z5c=
X-Proofpoint-ORIG-GUID: frZBqAUdx1N_rdLCK-4fVDxq8vqKt9jR
X-Proofpoint-GUID: frZBqAUdx1N_rdLCK-4fVDxq8vqKt9jR
X-JNJ: AAAAAAABTVUeWKANSERCDdK+LL5hNOoqj3KVzwZdON6F+8LTIE6d6GWdwRjW2kXWsUA6pr3nKwpc7h2KProF9S/2DBuJYy0Yr40b1ow9ysNTBTsC3xVJlpowZBL319tFBma8ujABpn9+lnFUhsvYh/3eIOfFcuxV/sVMGRnXkF6qHfrKF8/y3Y0TDXe6rR8KkIuRmeQWGirnZNpK9Vi0904p0Xz2L0Xwwvn50NcP5HXz81RM0IuH4MpiAkR5rhU6VmiHrsxtjz4aMwY+DH224xl/8UmBJqjb2p/iyMhsB9Ie7co8QIipaHA08xMH4si+LCXTByguY3tT122+dnUPxZ5a6Jmmhma4wWsSykki1SLHds6jlRb+mCjoAUrVN+MWg7PGeg5xrM7sHmIm6+5CtSXUvartyDvMZ78mfxrdJMadH9SoJO4zv8kPFY/sOczKsRvCpkV1ZaDEzVax21API0wFeSG0C1JIHocTCFRsm25EemX+qpbg4KJwJXwnn8FOlzOs7dbMXnbCznq0RD/LHt4IBsxzGXuyaWI3lIJWNmNE60kc3k3ywBLqNgT1/m2vJkSRs5BNw68vPXLST4E+kdmyErcKPrys91lBCwGRKj7C03UF6JbzsN5cysZGnKobEAS26QNZCKYYFa8JX8Bxv09ZQxhrRuU5xz0hMcO8gUG2fANGp5bDVyuSVDfkUQrZZXWvQ9gLgbYBakqRM/a5mf9ehRhw+O+ik+nNzMSfRCNooybz8UtiIdRRpY1AvIaa0EBz0iqW8UtITg8QmjeIvRKT364S00xH4A/iCvEET51FEDrriaOev0EdtqCRUr+KA3xk1eoTgvCoKnqKotr3/nBhoHipvd1WWLS5/if+m9sQTTDWO4KQ8awl9/CZ33EmxKKcR/KwQVFNqcn2fQSziu+9FuaEaTycKF6l+yEyMuMfqLQN/Pt0ZpgnOGjT3M8SenYlaxhJtHcD82dn1VDmstA8236frF3
 I9vybrkpD/uk1SSM2ZGs2NMarNWhlagCQ2CZ3u1EpJses7lK3nW2WOz4lGJ/MluPYh+4hdOYhGN3oP/7UG3iBdR56KOLc8V4Bx5l6tuAUKSrj9hWd7KEvgWpwjjyEeehJFwuz+J8l9f0vk3tp2GQSLz8LY/iYiWm+aw1nv0Dl3VBKZTGyuQmXTzZXCdhg4TxsJswK5VFg6EBROCjAMHmBqqjP5jW6o118uxXskzJZ9Xf9st3enZ4du+COZeVZUm4dREoipE9Z8edCsdzFj7fDELkCaz/r+pJEfY8fAD7F3lNjVfTdMHuB2330UKojKiCF9c1M+QhfhxYVlCYQncLpdzAtUvo3HSHPkRRtnmDXmLoSyNs=


Il 11/09/26 20:52, Hans de Goede ha scritto:
> Hi,
> I'm starting to wonder if we should not just make this behavior the default.
>
> IIRC the whole deactivate thing was added as a workaround for multi-byte scancodes
> getting split-up during suspend/resume. I wonder if we can come-up with some
> better fix for that ?
>
> Regards,
>
> Hans


Hi,

I tested the same atkbd_deactivate_fixup on a Lenovo IdeaPad Slim 3 
15IWC11 (83RR), which was affected by the keyboard issue previously 
discussed here:

https://lore.kernel.org/all/20260628-ideapad-kbd-leds-v1-0-50b421d94927@gmail.com/ 
<https://lore.kernel.org/all/20260628-ideapad-kbd-leds-v1-0-50b421d94927@gmail.com/>

Without any kernel quirk, the internal keyboard does not work. I had 
been using:

|i8042.nopnp=1 i8042.dumbkbd=1|

which makes the keyboard work, but prevents the Caps Lock LED from working.

I built Fedora kernel 7.2.5 with the following additional DMI entry:

|{ /* Lenovo IdeaPad Slim 3 15IWC11 (83RR) */ .matches = { 
DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"), DMI_MATCH(DMI_PRODUCT_NAME, 
"83RR"), }, .callback = atkbd_deactivate_fixup, },|

I booted this kernel without any i8042 command-line parameters.

The internal keyboard and Caps Lock LED both work correctly. I also 
tested suspend/resume and a cold boot, with no issues so far.

DMI:
LENOVO 83RR
LENOVO_MT_83RR_BU_idea_FM_IdeaPad Slim 3 15IWC11

So it looks like the 83RR can use the same atkbd_deactivate_fixup as the 
83RQ.

I can test a revised patch if needed.

Regards,
Martino


