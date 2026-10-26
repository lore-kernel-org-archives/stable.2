Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054519;
	b=LrNgBAkNzL0dWjUaR3RBZI631tugMnKLJn/lTc51rD+JZunXJzwdCBMvgQjqZKG3v+0E
	 kYc9SIZ8x60iT2jsKpYTOV/9If4a9hhttLf4bG6yvciDTBFZClK0h0s2qqujEABnpyX+K
	 mq5gaGYh7uWC7yBDyGy1czDIl2DqwNqMtmovg7BHDhd2zc14u4Zw9qAI+quHqbyzSq4A2
	 gnV+NIW1YpeB26MBHnc9YORKx1e7nMLe8NKnFkIhDaplvhro6YA5npzefOGx3fe64JxDv
	 tG/0tEiQ6ZP7D7d74yuYAOruO4kVgsWIt4gpJ6Mk47cA0ncBjrhWBvHvAKs5J/zO2Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9TJ2uWGQA28B7/IVLdQOUeh7B2n+/HiF9b/pWpbRQp8=;
	b=SoEJ4JMWQ2t5ZbM3lllofpQaiaKi3Ch2g4BonMsPaK9P0MFdAV3NfHLJBkNIbUmmVdp5
	 1tieBlydI4HXaMNTS2kXJ4hZx3+gb62p3y7gdCGm7YL35m1qZp1TsSsE7kyfAuDqDT3I5
	 4EgHnvYXfA01B8T/trbvR62zvLDtvAqOuTmiy0Xgc2/EQEKv/S1aqqrnVoWEhlXOc1/AZ
	 QkIFW9ImaaTr8VetQnbQJKXcfkz/K07LjEIJKqn86AwKkOalFHyYlFExXbklm2o6mY/z+
	 MCMeHBSIPauif4Jw3D+mMRfDdWG0Z6mOzwXrE5G8/4mvYS9YmkUMH2iQ5N8lm/6V4WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sTR+N0rG;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239A606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 22:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A239A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sTR+N0rG
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so22731445e9.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793054517; x=1793659317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9TJ2uWGQA28B7/IVLdQOUeh7B2n+/HiF9b/pWpbRQp8=;
        b=sTR+N0rG1eZuvFqHfBbcpGz3dtTjerA5lXe1bEMttgS8nsv33ERnGeZnDqeMZfzc9d
         tlbLJUgj2VgJ7Sk7V5qzTyGTFywijunoRW6dxp2pekNeJuohvkWkMkqZFvLlfVRWHRn2
         YwCSMBl6E1CJsaBedBHyfbkKfvX6molQ5dK8Jd23ohTYLxQVhmIGc+7SaBzM9pjJTjzV
         PctpyRgTvTIv7NIYQYiklT1HTHeE789laPiMiOf54QF66H0e1VFNmZXKSDeWW7MfvKD6
         1uCsAXegaBbTd72u70LFKABs2/C3Hn2JYGBq8zcglgUUmRWKdNNYLxaKwCGehtRzvbr9
         tJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793054517; x=1793659317;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9TJ2uWGQA28B7/IVLdQOUeh7B2n+/HiF9b/pWpbRQp8=;
        b=auKbnMz5QBTLpN3Z8oyJs+py+7bslhxp8QeEF4lFhlLTPr1oP9RgJg6/bitlIQ0lcI
         odM/dEQ9BaY78V86DWAPgUqV7oB+8q2C2Ppjr1KZDHBqtwTHdiU1qyXRWjT+PlsPurDf
         8+QwZgFhoUJCLq2QAODJF7t1Inf95oEiIwAfWTGp47onHm40FmrfA32kcZwlGfsAuvUw
         JOZOymUFP2c+nMfU2RPTh6t5SIJ1sRXHAzQJ2284O1H/l++IRvcPPUCER2GXZOa55eGN
         yjpw/L9bJ3RT7Q7mTVp+yElP+xLnJ6WJUHnJKbQoc700tepAXk+waeiYm0PIdzrwhbs7
         HheA==
X-Forwarded-Encrypted: i=1; AKwUvBxmG1Ha+EpVxXMmUE5yR+XyPFMmHOmBf6uSF1uF/cUJQqXB31HFlaAXG1b3OBZCve/UtVX/XSs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1xFgHzIzbDsrxr1lnjMsUmwDUEfnkl5f95Jo07EcMVevd0Y2v
	58Fo4bBzHZJN1kVcg2cFpHXw2nUf/cd1zzzjz2cRy7v2oIaSMr+3qI5y
X-Gm-Gg: AYBFou2FHPptvLi46VeQXbY8+adYeCeKEfb7QMuarAR7sT72hD+eKmBQtjJGFnjS7gj
	kvLybMZZsfJ3dBtG4fp9FvG/Z+6mZy/UHC6mE5FPEj+Mha8KwI3LkBjB9Y/amtSuKeH52DQF/5T
	0lIvWonX8GHB+8iu+aTct+2LQ6tJHOJdnYjOpUsqvlQFVXHhCxLRp5GtnQPNnXXrQED21u/lLHm
	8QySEWSSZFp3HIHaDpGDt8ioGsyeKANtcwru6ycq+KwHK79CgU9NOmI+x+gTfxL1368Ee+iM8wT
	e5icPNMOTkuWXnPHt74gG+nhEordSE7wZ4OFFw2jX0AwAOYi63H0ydk9Lckkvw+b2Q+rfxRYfje
	Gi+zwrvqbmnvnWBgmqve+k+MZb9I/toZ32l5sWsuVu8GK2Sf+PfrdZYDOX2oNvzMh6Y0oz4G2CD
	azSyVEY/gI56lW+Jw28ts+8ZTnSRZNfQgcnu5QG5hPhdH/ulA1JImhWjqJD4uEEhq7+QlhAqFMl
	f6g/9+gZBFpUGDi0P1aYZHfYSc5u//srF6xyNQcbgdHWiruuyn8A5TKSgbhwNO4NFy/o9K5iz6u
	gbAlwoPC17gKpcpTDl2NCCHHKMv89a+ijaWCDjjW/o87B48jtF1efGBF++Cx6bp20TXoov7XTyC
	KlbzANQ==
X-Received: by 2002:a05:600c:4e87:b0:4a1:f7f4:7cf2 with SMTP id 5b1f17b1804b1-4a35acaa046mr152446335e9.17.1793054516772;
        Mon, 26 Oct 2026 15:41:56 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07190050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:1900:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a55e99fsm228800335e9.4.2026.10.26.15.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:41:54 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.100.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1xLTO3-00000000SgX-3CYi;
	Mon, 26 Oct 2026 23:41:54 +0100
Message-ID: <7a52a44b-d674-4469-bc77-35a5a648472d@gmail.com>
Date: Mon, 26 Oct 2026 23:41:53 +0100
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
Subject: Re: [PATCH wireless 3/3] wifi: p54: fix IE parsing loop bounds check
To: Johannes Berg <johannes@sipsolutions.net>,
 Tristan Madani <tristmd@gmail.com>, Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Ivo van Doorn <ivdoorn@gmail.com>, Kees Cook <kees@kernel.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
References: <20261026112151.2515228-1-tristmd@gmail.com>
 <20261026112151.2515228-3-tristmd@gmail.com>
 <9658b549be7c1c0f1637699b8b61960d2101dfca.camel@sipsolutions.net>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <9658b549be7c1c0f1637699b8b61960d2101dfca.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/26 12:45 PM, Johannes Berg wrote:
> On Mon, 2026-10-26 at 11:21 +0000, Tristan Madani wrote:
>> From: Tristan Madani <tristan@talencesecurity.com>
>>
>> p54_find_ie() iterates over information elements using a loop condition
>> of while (pos < end). When only one byte remains (pos == end - 1),
>> the loop body accesses pos[1] which reads one byte beyond the validated
>> buffer boundary. The read happens in the bounds check expression
>> pos + 2 + pos[1] > end before the result of that check can prevent
>> the access.
>>
>> Fix by tightening the loop condition to while (pos + 2 <= end),
>> which ensures that at least the IE id (pos[0]) and length (pos[1])
>> bytes are within bounds before any access.
>>
>> Fixes: 0ac0d6cedf611 ("p54: Move mac80211 glue code")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
>> ---
>>   drivers/net/wireless/intersil/p54/main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
>> index 57a62108cbc35..16614f65dfa5f 100644
>> --- a/drivers/net/wireless/intersil/p54/main.c
>> +++ b/drivers/net/wireless/intersil/p54/main.c
>> @@ -81,7 +81,7 @@ u8 *p54_find_ie(struct sk_buff *skb, u8 ie)
> 
> We'd probably be better off just replacing that whole function with one
> of the real search functions or iteration macros?
> yeah, I think carl9170 probably can just straight up use cfg80211_find_ie.

But p54 needs to edit the beacon and the memmove the (found) TIM element
to the end of the beacon and modify it a bit of tim in p54_beacon_format_ie_tim.
The problem here is that the helpers are all casting to const. So this will
look "funny" via to "uncast" const. Unless you meant something else?

As for what to expect if something read past the end? Well, p54 works on skbs. So past the
"end" in p54_beacon_format_ie_tim() would either be extra tailroom then padding or the start
of skb_shared_info (u8 flags) I think? In case of p54_pspoll_workaround(), after the "end",
there will be the FCS (32-bit checksum) - at least on real hardware) and then padding or
the start of skb_shared_info.

For rt2xx: not sure. But the existing use cfg80211_find_ie in rtw89_core_cancel_6ghz_probe_tx()
and rtw89_core_cancel_6ghz_probe_tx() looks suspecious.
Because from what I gleamed, both just pass "skb->len" as then len parameter. But shouldn't
that be subtracted by the offsetof mgmt->u.beacon.variable? Because cfg80211_find_ie thinks
len starts from the "ies"? I can't tell right now as I'm sick and need to go back to bed.
This all could either be a fever dream an be true/half-true or completely wrong. So I have to
ask in advance: Please don't take this all too seriously.

Cheers,
Christian

PS: Is there also a patch for rtl_find_ie (isn't that pretty much the same as all the others?)
