Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907826;
	b=l6UFLdUMpye0wUJMdmKx4YkVlNV/RNOzq4oMRGhhXRCs/Oifau1UagxXWwUkcYeXvD6E
	 1SuKFfiqPew0ARbXdTtZdurCY+0wpi2XdTBxuYS/hYsJRcUoecmgghe2yAqWsm5S1Glzg
	 oobX3g4NHoKuP7hfaNDPAVxtZuF62npAJlPfhV41EE7ig4DAAh+diL4bRFecBoXWKLkAM
	 7RpTcRocKfH447ePXChqrLq4R/YCydhOqg6wksUv6ImUr3RInJazRX5186yMxZOQ8nO37
	 VoiD0CQj4RGuLDOwK+uyyss0ReKZtTTIBiFyFSH+ng8EYWYQ9wSJ2L+nI6vj+7Dk5Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZhathjOgBLFBYBU+7Oumjoctx0BqmNgulsJHx/5Cbyo=;
	b=LbfjnZQmDfvj+FDUKfuJqfrn29jsJCpuidQ+uGpgnHVcawRHEXHCoGAFtRJhJFpV4NT8
	 8Ruk/3X+U2iYLO8Xmw1h3MB9O5Qw+AaX0e1v4NAjBDvPoFCWc0EwJg2WyLu8qqcBg8Qfj
	 o5008m3W31/t2jmJQJMvDmJSU+nbmPQehXln96wisNhwee/uS+Th9uQzEQsMq14sZDZoI
	 ThTzTDw7LxolCYhpCc2QzINRXnEWAFbna7eSigASs7mFYLVcwEeSLHUpS+/cFCG37DdG9
	 lTYt/JOQO0Xh9WOXGl3+d3taElpnB4x12HoFTsPFZ48888P6OLW6IEKrUx175DU7pVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=DY+zJzZ1;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1B606A6DA
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFC1B606A6DA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=DY+zJzZ1
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso18620825e9.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 11:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793907824; x=1794512624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZhathjOgBLFBYBU+7Oumjoctx0BqmNgulsJHx/5Cbyo=;
        b=DY+zJzZ1LbUUA7lWJslgpLY9Z8HgU6AvJnVYVQTi/G7WY56EhjFD/gz2Sb3uaPc/jp
         W/OIY72Ske8q1bobN0Iwt8Lpt8G1TkS14N5PWGqSxFwgJU8bfndF31pAXA0t2eqBq6Ur
         pKDRuP60QqoNutBgYQ5GtO7m7hlnQM/oAtlXfihhzJqE5umhtnqPVvx2fVJgT7IQ3vr+
         e6GcAgCVoihGuB2ZKlvhrakFV7qXYQM6MkGERU4lTYXmfdIMpzOeF4z9slFAmn/OT8r/
         CE+2PpQ1UHr6HXJax7/7LGixp0pHL7cWcljhNUhDEehP23+OVMoEJqMob+iQsvKuU0S+
         on3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907824; x=1794512624;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZhathjOgBLFBYBU+7Oumjoctx0BqmNgulsJHx/5Cbyo=;
        b=RTeKm3XyoEvi+4GKStVLd/wbRHnh6FQEBc9TtRgyBc6UtIOyYYWP/q2CU29pOWNsGZ
         jjQnr1wfxFBe4mF118TkbEhs/yAnMNHhEM9QK6MqELWRNSJ+6chqfqwc/Av6QWMsbGDk
         Jr5oAm2s+9u43LHYaBa0Sgb0+GeYFm2xei2TLP+kFw5Mf5ypY5TYZkOCwnhqh1DB73io
         OoAwvwwzJMMEOtliItfXopwIdfWjKD4b6AFq5lRLpvC4409u5Cx4GQ8lTvCfkjSIadeP
         VrwW64QPXBraxMIua8+xUNik8fbiB/16kByBk4ifw2d1ffzwQFX/1+Rxds8ZXF6t/HDU
         AVNQ==
X-Forwarded-Encrypted: i=1; AKwUvByFuYLOML+8SCXNVNctADeNhQfkKbBAMxsC+kqHj3oMnDp0jNqdICw9/pqcaFd/QYHNnFSfBqM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8d21gUFhhEvkFsNrc84a+FWvwMdK4f4WmBs4soJwZmAkxRrA58
	2jD1HWlbcSjfirD/xBrMjOXxWkmD4vABlcFkCshR5LAReTR7RxbWtLzvprWAXaasLy16FvIE0wZ
	NCS+Ga9Oljg==
X-Gm-Gg: AYBFou0lZfSss1e4AqVjmMBj5Wb/TemBR6evi+Hn7nVjy1CzHzcQWK56H9FZ0anIymi
	4UVZznw/x8glZSrRtSI49jesGdN8nlApY9ClIOto7Lo4r05+WPEAZAif0FF3eIgzoZgJDg/PLem
	WtHSi6aiOpL6plcqHihOkyM7B+0afo5ksCsEIfCgGQUGxdsq+WheQIn6hd912NoyYvEs0/W3uBH
	WLaojlf36/aw1J4UQKrxspSPxGh1HHpOHGqgIAC/H99s46Ru+zk4dCAGqqbKySa4d9+6R0OXoaF
	V2bV+GJ7OkQ1LID/qlJSHHSWkMbBAv2i0TvLy9AMdg7YbvrGTz4/xxvmxjhUdGEG6chxU9xhp0u
	PK2GYEdMgpsRjGThvTBLHFzi/sxvGJ0d49J2WtRO3M5p4DzE7HV9a7dOCkFbuQP0N5pQIpeGvUJ
	9ynbjD/3Y/PxEYR53aO7VshC6IbeV0yJMNNlWY+o7NZinBgUjuHAovjkFHjCDWhLjCN6Tfq7gWF
	kOXxEMbHSLGsauJx0BH+CaQ8H+L61PA0IEVkl1D50yV1e1HtZeglSYF1CzNSGVs22JPYkg4Iztb
	So8RXlyALrdNy82jQ1bIOlIlDW3VNm7lCd9vB22GdjbcE3w+iM21yDyqkETmpkE1AayA
X-Received: by 2002:a05:600c:190c:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4b6e0bffd81mr2367485e9.33.1793907824242;
        Thu, 05 Nov 2026 11:43:44 -0800 (PST)
Received: from ?IPV6:2001:a61:1322:c01:9fdd:c901:f470:904c? ([2001:a61:1322:c01:9fdd:c901:f470:904c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecac1a1csm11424488f8f.12.2026.11.05.11.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 11:43:43 -0800 (PST)
Message-ID: <e6593c6e-63b3-4198-b587-85b5636e033b@suse.com>
Date: Thu, 5 Nov 2026 20:43:43 +0100
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
Subject: Re: [PATCH v3] usb: uas: ignore UAS for ASMT135x bridges (174c:55aa)
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
 gregkh@linuxfoundation.org, usb-storage@lists.one-eyed-alien.net,
 stable@vger.kernel.org
References: <20261014165741.35758-1-olivier.kaloudoff@gmail.com>
 <20261105173250.97239-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261105173250.97239-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05.11.26 18:32, Olivier Kaloudoff wrote:

Hi,

thank you for testing this hard.

> The wedging CDB is already identified by the abort log: READ(16) at
> LBA 0 — the 128 KiB partition-table probe. (usbmon isn't available
> on this kernel — CONFIG_USB_MON=n, can't hot-add without rebuilding
> usbcore — but the abort CDB narrows it to that one command, which is
> consistent with your partition-read hypothesis: other OSes typically
> probe differently, e.g. READ(10)/smaller LBA0 reads.)

We should definitely get te partition code maintainers involved.
But that is secondary priority. This issue does not eat filesystems.

> Where that leaves the patch: the enumeration stall is now proven
> cold-rare and cleanly recoverable, which by your rule makes
> IGNORE_UAS look heavy *for that failure alone*. The justification
> that stands is the load wedge — two filesystems lost to a failure
> mode that only exists under queued commands. A depth cap could
> plausibly mitigate it, but I have no positive repro to prove it
> does. If you want, I can run a longer soak (hours) at capped depth
> vs. full depth, and/or test whether a first-probe mitigation
> (smaller LBA0 read / INITIAL_READ10-style retry) prevents the cold
> stall — that would let UAS stay on for this bridge with the enum
> race neutralized separately.

May I ask you to test once more, harder?
If that remains inconclusive, we will go with blacklisting.
We cannot risk filesystems.


	Regards
		Oliver

