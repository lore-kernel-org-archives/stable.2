Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847685;
	b=OnR0MGsyS6hsO1ZVg+oC8WNfK4qD4Ig71fjkSrG9z5zjD3sQM1DiqDPQzHX+h9s+iNBx
	 UdmJ9UAl1c/b+YQly+p7VT+GgGrkLlfxbGsFn0cFZUrOoXzQhUL6NUy3ve3kclPdhFN7L
	 ayoNgjBzStOwAh5sBK6TfQUE5OMlaurmaz0T2jk7XBjDQX6DF4jiV34eZaWo8gZRCFaUz
	 qfPbirjDecjsb2vd0zaGCRh6J9Z/+CKSd8lZb84ofTJvgsAkIWZcjiaKwpQBHBOdiSil6
	 wvqn3ucZ8l8senYHoVODBEsZxc7CaYmcc594kKjyZOUw2p3GRvSNyLtlAcNsEf+fvEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=9ucaiasafJWVLo8H1ml0lvhBlTDBTGfYuTcr2tmIkkk=;
	b=yFZF/UWs/Zx0C8e6Xux6e1DMZu8LUoRSKr2sHqCHg7BpAjCK66Jjly3gNR81s2fdjJ5e
	 WGZABsHZ1OKYo1bUWip5519SgDKu3EJ4nDEH/rfqr0EFsfdru4sF4BT4yHH1V2ENONC0N
	 b649xzbdZoaGtZG/xjnQ62z+aqWHW/Dru680EZUOzXIamaIe3DRX+U5K/fzwg5g9pLJNP
	 aQZVVB3JIe2SALuJKQEsULWrcSGoZKjV8q7C8C9i6tjLbJTISpoxhxAZZVQIePiMSWwv8
	 DlRKk0eSH+CqUa7Bz+UzNgxNHpYA5+B78lxfGY25kolDFdLBdoTBYJ44hF3leLIDRrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BRZpPH7C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1273606A32C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 16:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1273606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BRZpPH7C
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4cdc606b47so641413866b.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:48:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794847683; cv=none;
        d=google.com; s=arc-20260327;
        b=CHXA77zhugitAseBNE66tAz3KjvMGNLtP11v3dZFrNlXG6rhr2DAs2fs60G28Dz1Dx
         t0YRLJKQtZmq8HT3tRLJa6pNBvyrnaKnr++/TfcRzgCkqEGnIx5rxJJZDA6VzZUY49Ic
         GVDhmSxzW3gFc+bA/QfOM5Wu04Qju9BOSpkoVntqHE5SegMfx99xc4Zm6V8BLIftnPbf
         s3kdBNOlOpIlsfzatpt7gnRDxJMJ8LHIRcKdhLukWnRU4dhbLBOIL9CWTstNPDc2RQk4
         2nbHme6EerQhHQalQvBYJZY6Pc+3Y/Gj7lTHf6bpd3XtzwmAzqfB5Vg7lYLTaaQDKqEf
         yFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9ucaiasafJWVLo8H1ml0lvhBlTDBTGfYuTcr2tmIkkk=;
        fh=DDDQPzRoUyfCznCtvIpx/MJaXNI66t8MUcMiLt5vFRM=;
        b=l8lzi6AhdhJfKfnPZ6uJ0nDvaQiybVC1ol9tTQO8cCakVWR8F2AT4XXF9BN70neJ5V
         XQYrU5MBg14GOBf3JZ+7N7NlkaXeLBOVIMjrV1MrnwOJpJyV6zogyUSCM6rhbQomU4BM
         3NxMkMTAs0AG2p/MU4k6SrI1kFjekBfQfKP0VI2J8QlIuDXFjLoPqsjKOPf2w+x58aO1
         JwkcIOdmXH3JD99fJMxL2NHvg6G2Fn5luoR7ZPdpT1N9VndmtD136p5C/1fL6dz3sf3P
         4TSakjixChgA4UMWoC/VbABy91EBGURrKsPnwkFEGW50KyVu2eaPRWiKTI7lwgC76nnP
         gm0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794847683; x=1795452483; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ucaiasafJWVLo8H1ml0lvhBlTDBTGfYuTcr2tmIkkk=;
        b=BRZpPH7CWREXoIQVx4hqWeRD2Q55mF2ONQt/rqbgFw+JCVZynGVS5mcNl9MqThYOT9
         20+ObweLK0jkmtZ1W290Qf+4riG2nCByG2J+6GdLBeskWBTA2tLFL5mcEmBDnPSWATBU
         BQI5CY9G1xEXxZu55qFcoBCQwGmjz9Z9pC3gd3xNAHs29aEmMKIRONon9FOOpo2uHZ2Q
         ywr+KylRdBAE1Eik7ZBk3/A7E+nr4uU+WVQ7mcRDCRBv5n02bfNhsTlxCqKMeqNtrDyF
         VbvgectNG77arQt+0qlPXBhIA+2vS1vGuQyqbekduzFfPYsk9xzMDhHUNP9rb2ifqGnD
         6T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794847683; x=1795452483;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9ucaiasafJWVLo8H1ml0lvhBlTDBTGfYuTcr2tmIkkk=;
        b=nexJs5YPwATm8VtGEFYewPP6M53DDduIdOvtaHNUZ1CsSFsoFkkBYvP3UsbwWHJvUb
         8GVEJ/LK29r3TmlgKe1SG+WQDqFk5HTXa+EW+FU1JBUb9GgTKt6SttTq/0xaPN1OJz1+
         IMQg3i2WeRCQbdgBa1YnwK8gWR2s72MhJObHURj5yRLR+Moyt72Z99Wu0XhQuG38cRd0
         rMkZbw0SRBvkCR8OV02PxgENy/E5INhiN0q3KAJriqupuWgRkhGoEuGCVMVoczI6eibH
         g2ZR2UP2lf+iWJJMZnucYn4d7j1aEkqwNrMjC5LyBhtnrUY6vtUYOAXnJ6wHLSWOZnzY
         yzSg==
X-Forwarded-Encrypted: i=1; AL+hErEAmHsnRpkpoVsgfecmFER0umzXgYbvy9OcJbB7OIiVarAADDh40d9eYkYSwS8qdCrg1KqLzzM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/e6XrIi0U7sb/6Br1sBzNdrZLZz9SwSJ7f7bvvvhAxcPI4sLEr
	QGGQ4XcjRvMn8jQgV9hsxR1oaMDYnJ8bOq7G8dNR+/D40HWjlB9ni3JYLjiIKTcB+cJGM7UYG5E
	/pTWbQL8c7VjQSAkorqR35btgFr3jMGs=
X-Gm-Gg: AYBFou2d/S6G77+U8K7dGeY/2WqYHg7AZTRixGIGhO2/zBy9W+Yyp6hrqWwRaT3INRm
	v20ZAwbO+6Z6uIol3v1TlTAvkV1q6vutQ76z/xoP9Jb0+xzEMD9sYHk+ZcVpXK0P0DyPvawerPH
	WIppnSVraeEvgw7V0IKtLSQUehb7df6evAa11viL3wZKZYxl3Oz0R7T2/sFtEnYGwKqTG5Qna1u
	fFF6qBQHD62akXaDvldWSMnEV9atFVnZKxdG3cI7klN0/tkSkba8fVGwKy2GLnPtHckPq0yH6q+
	UX5ySXGRDYdEcDIyKJftI8TeHoOk2JucDFSijpclI7T2eknfSmUXVH6yis0Hy/75+9sK1wLfnDM
	h4WSxipm7MpUeIZM8zVMbYxHhpPjPlCGOijJvcL1Pem5ZPCG1BtWiBcqaxjQ=
X-Received: by 2002:a17:907:1b06:b0:c41:23bf:18af with SMTP id
 a640c23a62f3a-c509614e4famr897868466b.5.1794847682879; Mon, 16 Nov 2026
 08:48:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-sm8750-llcc-island1-v1-1-64055702ca3f@gmail.com> <79ac053a-3235-4da0-87da-ebd8da01e4a4@oss.qualcomm.com>
In-Reply-To: <79ac053a-3235-4da0-87da-ebd8da01e4a4@oss.qualcomm.com>
From: yzddMr6 <yzddmr6@gmail.com>
Date: Tue, 17 Nov 2026 00:47:50 +0800
X-Gm-Features: AclHuK-Lr4J3nNZOiRUCcA8IWzVao3HnhljllZthBc3TfeqQ8ypxS6Przkn-9Ek
Message-ID: <CAB63uaGQzATJHQgA2ohAothVDYsAhAhPDrcPmgLzwO9EvnB-Vw@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: llcc-qcom: Reserve ISLAND1 ways on SM8750
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Melody Olvera <melody.olvera@oss.qualcomm.com>, 
	Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 13, 2026 at 08:55:33AM +0100, Konrad Dybcio wrote:
> On 11/12/26 6:35 PM, Vladyslav Tymoshchuk wrote:
>> It does not cure the reset here. The tree is v7.3-rc5 with out-of-tree
>> board support, without Ajay's series. Each run is one 60 s s2idle on
>> battery with the USB cable disconnected:
>>
>>   this patch, Wi-Fi WoWLAN enabled                    reset
>>   this patch, Wi-Fi WoWLAN disabled                   reset
>>   this patch, rpmhpd domains left at their highest
>>     corner (rpmhpd sync_state callback removed)       reset
>>   no patch, MC0 kept voted in the sleep set           resumes
>
> This means something is accessing DDR as your platform sleeps
> without voting for it. That indicates it's likely something that
> Linux set up, as various subsystems (ADSP etc.) cast their own
> votes.

Thanks, Vladyslav, for trying it on the Pad 3, and Konrad for the
table fix [1], which includes this change.

On this tablet the reset went away once the ISLAND1 ways were
reserved, with CX and DDR still collapsing, which fits that reading.
Some of the numbers below are from a second tablet, a OnePlus Pad 2
Pro (OPD2413, from the same erhai project as the Pad 3), which runs
this patch on the same v7.4-rc2 based tree as this one.

>> On this tree the two votes do not seem to be dropped: with all five
>> macro codecs runtime suspended, clk_summary still shows LPASS_HW_MACRO
>> and LPASS_HW_DCODEC with a prepare count of 6 (LPASS_HW_LPR_VOTE is 0).
>> I read that on the workaround kernel while awake, not during suspend,
>> and the codecs have no system sleep callbacks here. So the resets above
>> most likely happened with both votes held, which is the state your
>> tablet resumes in.

In the one s2idle cycle I ran with each of LPASS_HW_MACRO_VOTE and
LPASS_HW_LPR_VOTE held, this tablet resumed with cxsd, aosd and ddr all
staying at 0, as with your MC0 vote, and Gopi reports that held LPASS
votes keep CX and DDR from collapsing on Glymur too [2]. So with the
votes held I would expect DDR not to collapse in your runs either, and
the MC0 vote to make no difference. Since it does, I think the votes
were released in the runs that reset.

On v7.3-rc5, as on v7.4-rc2, the six consumers of these votes in
sm8750.dtsi, the five macros and the LPI pin controller, take them
through pm_clk, which drops them on runtime suspend. With the five
macros suspended, only the LPI pin controller could still hold them,
so I would expect a count of at most 1; 6 looks like all six were
active when you read it. A device that is still active when system
suspend starts stays active until resume, though, unless it has a
system sleep callback, which is what Gopi's LPI and SoundWire patches
[2][3] add.

Here the count read right before suspend was 3, 3 and 0 for MACRO,
DCODEC and LPR in each of the 23 s2idle cycles I recorded with this
kernel, 18 on this tablet and 5 on the Pad 2 Pro. Still, cxsd and ddr
grew by about the time asleep in 21 of them; in the other two, both
on this tablet, they did not grow at all. This tree forces all six
consumers and the SoundWire controllers into runtime suspend at system
sleep (Ajay's TX/VA patches, changes equivalent to [2] and [3], and
the same for the RX and WSA macros), which drops the votes during
suspend. Without such callbacks, a non-zero count read right before
suspend would mean the votes were held.

>>> All of these suspend tests were done with a USB cable connected.
>
> I don't think ToT linux will let you get cxsd with a cable connected.

On this tree it does: 21 of the 23 cycles above reached cxsd with the
tablet attached to a PC as a USB device, and so did the tests in the
patch. The tree carries a fair amount on top of v7.4-rc2, though,
including Vladyslav's USB GDSC retention patch [4], so I can't say
what ToT does.

Vladyslav, to your two questions: yes, this tablet resumes with the
cable disconnected, though the battery cycles with stats here were
PSCI system suspend, not s2idle. Each tablet ran two cycles on
battery, with an RTC alarm 180 s and 70 s ahead, and resumed at the
alarm every time. On this tablet mem_sleep was deep, and cxsd and ddr
grew by 179.1 s and 69.2 s. On the Pad 2 Pro they were s2idle, and
cxsd and ddr grew by about 178 s and 65 s. aosd stayed at 0 in all
four, as in every cycle I have recorded on either tablet.

As for MC0, nothing that I can see is voted on it in the sleep set.
The interconnect drivers are as in v7.4-rc2, where the MC0 keepalive
only votes in the active and wake sets, and a sleep-set vote on MC0
would keep ddr from growing in every cycle, while it grew in 25 of the
27 cycles above (21 of 23 with the cable, all four on battery).

One difference between the two tablets that may matter for the Pad 3:
on the Pad 2 Pro, adsp_island did not grow in any of its five s2idle
cycles with the cable connected, which ran from 59 s to 2.9 hours,
although the ADSP does enter island mode there while awake, and cxsd
and ddr count a new entry every 5 s or so (every half second on
battery). On this tablet the ADSP stays in island mode for nearly the
whole sleep, and with this kernel cxsd and ddr count at most three
entries per cycle, even in one of 1.8 hours. If the Pad 3 behaves like
the Pad 2 Pro, the ISLAND1 slice is not in use during its s2idle, and
this patch could not make a difference there.

Since you offered to run variants: could you read the three prepare
counts right before suspend on the kernel that resets?

[1] https://lore.kernel.org/r/20261113-topic-8750_llcc-v1-1-6536cb46d7fe@oss.qualcomm.com
[2] https://lore.kernel.org/r/20261112-lpass-lpi-system-sleep-v1-1-438cb997e0e9@oss.qualcomm.com
[3] https://lore.kernel.org/r/20261112-qcom-swr-system-sleep-v1-1-a61a83f6475d@oss.qualcomm.com
[4] https://lore.kernel.org/r/20261110213346.1359-1-tvlad744@gmail.com

Thanks,
yzddMr6
