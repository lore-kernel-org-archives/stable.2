Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.220.73.82
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135101;
	b=nCLs/1Dm8w8mCgOCU6LO376VPe56zB/gjPuBGaGTe2E+RhXBHI2bB0//TOkcpglmd71m
	 DkKIjLhy6n581KqTI0vvY4batI9umidQIC3yDy/12KHcjR5YuejRhXp4CvrZCqci/GpRb
	 UDp1uuDWoxVN0kj8aBZ/j4bnj2ViEaQ4KeuQQd63iLjkRPQjR1HnRQkrbXyP7TXwyYxmI
	 L2VESdtAle50WD37gV0T0dTTVSNc4IWeB0gL8akGjfWUs90wJUlFtGUZ6/rmsbBcx06l2
	 8qvrQssVBygUCo6ttAOG8QwxhAMBhYPOG1usiOhd+mtwgbFQWrZQX+WANYfMSr+Ii7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135101;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:To:Cc:References:Subject:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=FLUULcZ5Th52iRf5h59OCF/dLSjqO3QJ39mbKLqDk+w=;
	b=XTtw30trCb5p6TF/llUfUHplDTs9dOFt5h1ft6UcIQ2ccJFphjBpCT5MuEFHADxpWSIg
	 4NwSWqpmdj20/YomiYD0eHK+x67FQQtPdVCwywEgsdwForG6fDgpqPzUsU1AcWc0P39QB
	 uQPWSJk527R0cmnY+Y3jfGWMkwnIsm2l864VKpKdeOtmIXpm7tXihGPs6enFZBlZW6auj
	 JklMg0s1vxBucITnnEjOkLD3knAWq6Zi5v41gVCZQGEiG+rVUdoMvU4zanIrR23toc35a
	 BwHQvbINR12f2f3cHvMO3UI0toPCSYgetXC078h0lkrCkk3z7izcDavzV4H01+pvpQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=robert.meijers.dev;
	spf=pass smtp.mailfrom=robert.meijers.dev;
	dkim=pass header.d=meijers.dev header.i=@meijers.dev header.a=rsa-sha256 header.s=november2021 header.b=T+Mr2MVB;
	arc=none smtp.remote-ip=31.220.73.82
Received: from mail.meijers.xyz (mail.meijers.xyz [31.220.73.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245C606A31D;
	Tue, 27 Oct 2026 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=robert.meijers.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=robert.meijers.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=meijers.dev header.i=@meijers.dev header.a=rsa-sha256 header.s=november2021 header.b=T+Mr2MVB
Message-ID: <c329cd0a-1396-4a71-a0cb-6921427f7699@robert.meijers.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meijers.dev; s=november2021;
	t=1793135096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLUULcZ5Th52iRf5h59OCF/dLSjqO3QJ39mbKLqDk+w=;
	b=T+Mr2MVBqJTteemE/FpH+pdk14MnOWJ2BrL3gGV070LFD9pyzVzVHgoLn+6eiak3tye70T
	bHo6baFlsIpY+KgOYYBLCXyKvyzx3EEowhD3L/LpG+ROAKzVokMx6/Gp1vygeqagqgQGhK
	SNpbd+duEmX+LSwgvf7zjZPnxL5O9cY=
Date: Tue, 27 Oct 2026 22:04:54 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: yongxing.mou@oss.qualcomm.com
Cc: abhinav.kumar@linux.dev, airlied@gmail.com,
 dmitry.baryshkov@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, jesszhan0024@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 lumag@kernel.org, marijn.suijten@somainline.org, quic_abhinavk@quicinc.com,
 robin.clark@oss.qualcomm.com, sean@poorly.run, simona@ffwll.ch,
 stable@vger.kernel.org
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
Subject: Re: [PATCH v7 00/35] drm/msm/dp: Add MST support for MSM chipsets
Content-Language: en-US
From: Robert Meijers <linux@robert.meijers.dev>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

((Sorry, re-sending because the first was rejected for not being plain 
text))
(First up this is the first time I'm participating on a mailing list,
so sorry in advance if I'm doing something wrong).

> Add support for Multi-stream transport for MSM chipsets that allow > a single instance of DP controller to send multiple streams. > > 
This series has been validated on sa8775p ride platform using multiple > 
MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P. 
 > > With 4x4K monitors, due to lack of layer mixers that combination 
will > not > work but this can be supported as well after some rework on 
the DPU > side. > > In addition, SST was re-validated with all these 
changes to ensure > there > were no regressions.
I have applied this patch series onto a near mainline 7.3 tree for the
Xiaomi Pad 6s Pro ("Sheng"), with SM8550. But with these patches
applied I don't have working audio, over USB-C to my (DisplayPort)
monitor, anymore. If I disable MST support on the monitor audio works
again. Debugging (using AI) reveals that the DP0 Jack is not reported as
connected anymore when connected to the monitor, with these patches
applied and MST enabled on the monitor. As shown, for example, by
amixer:

$ amixer -c 0 contents | grep -i -A8 -B3 -E 'hdmi|displayport|jack'
numid=208,iface=CARD,name='DP0 Jack'
; type=BOOLEAN,access=r-------,values=1
: values=off

With MST on the monitor disabled this outputs "values=on". The same is
also reflected by "pactl list cards" and "pactl list sinks" where
HDMI/DisplayPort is reported as "not available" with MST enabled (and
"available" when disabling MST).

(Again, suggested by AI) I also checked the ELD, which in both
cases (MST on and off on the monitor) is identical, including audio
information (like "speakers [0x1] FL/FR"). (Also, audio works both using
an AMD and an Intel based laptop, in which case I can also choose
whether to use "HDMI" or "HDMI 2" to switch audio output between two
monitors, in daisy chain).

So my foremost question is: should audio be supported in case of MST,
after applying these patches? Or is this possibly out of scope?

For clarity I would also like to note that without these patches
applied audio over DP does work as well, irrespective of MST being
on or off on the monitor (obviously always running as SST because of
missing kernel support). Which would make me believe that no audio
support in the same setup might be considered a regression?

Note that I do understand that me running a forked kernel on a
(by upstream) unsupported device might also lead to issues or require
changes for the fork. And that if audio does work with MST then this is
something the maintainers of the fork should, most likely, fix. But
from the cover letter and commit messages it is unclear to me whether
audio support should work and/or has been tested when MST is in use.

Kind regards,
Robert

