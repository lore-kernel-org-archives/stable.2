Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465360;
	b=fidEWkIfJs42L22orrv4ibjs0knZJXPnMn+evpU5viwVNwBLeUJYTPuZwUM4cfxtLR9g
	 N6UFIslNFGlq9gWSmd/SAq4GXMx0O23kMeoyLBytiB+04FezWIfZTvQrZiBPV5E7MahVL
	 n3e/Mr4FSludXPwOFjhCtHnAigYbncfTjNPQsH+xAv8joOVDkQaSRS9WmuRV9Bh/NUUye
	 sRign5fMJ8OVCCdGkMESPggtJlBuQCrqrcUSdG9hx5J0VToF4we0Ho1nOt1fvjfnC9GBm
	 4t+dN8J1z8YdGNntgcdDVWEyuIyWIpLLCgcHtQJ8Pz4h/dRMeWQhtRT03Gx6S767HNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gCLRRKTFKXK2HkutDnNQ0o/EWQjNEj+82Vy1QomspIo=;
	b=DVwEKyKEEg/4qFhsI+mtDDwp57t1sME0FFnv02HE1rlohhsrKIiIL+2eEzYmAzY3A/yF
	 Dm4jEgF+by+ITTbvatDZ6iZCNUN/mZZh5X9NQhrgZfkuX2V1gVPac8N8AGT8j6kV2GHWp
	 J1ikcsAcfTt4toC6Oo7pFz3ewD7F7IRf/BpWjoWoccGfyAKTVtkyAcoQT4gPwb3BOo5PD
	 XdfFs4jrj54oW3Q+5VICmCXit09yxGipubd+ajjyBAYBU6rd34ZSCoskBf6mhUrsQiRAj
	 jMyUyOaB1HuaS9MqHfjfXnX4WYmEICrECzpu+rO51fsNMbFAPyR6eFJgFYMtnWhpZ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ppqht/oh";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C792606A321
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C792606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ppqht/oh
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so456645eec.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795465359; x=1796070159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gCLRRKTFKXK2HkutDnNQ0o/EWQjNEj+82Vy1QomspIo=;
        b=ppqht/ohwWl2aULz1yr6gbfVi6RFEHnBDhC+ETkHvKC8uwFFxj3pwj67/MkPMLnmrG
         NQc+56GMEIAKsTSB6tqvcnHnpR8+RqLBG3esAvqmB2z3Qr/GOkV76vRPQq0wdfLTgcEB
         3V0qbatuXHoaxwYxrkidodjS661LvtWMIRO7zbwZy6nckja0r0K25Tr+SiHlDETxpTm1
         HHUPJ54w+YijJDyvsTXu4qNNgHvEmqqDeb4bpiumh/WwXBlM+3PZ/qWaQ9OwEnSxms1v
         J6u7s+jvmvR9CUP3AwZQtUZNHx/NuPXnB+n83AuV6rF4RDD4eqD5OAm3HT2JUgqUAtC6
         +fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465359; x=1796070159;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gCLRRKTFKXK2HkutDnNQ0o/EWQjNEj+82Vy1QomspIo=;
        b=Mpv9tICEYy5J+YJV+csKN9M5cNga/kguh7whhxaAtX1KI1+beMFy4ODGpzVNq4UWBx
         yjnS7rUMmg0qJmn/a+f+x2THN+ryxTTf9AevSFOZcWmBETaX1W3MxKHF0VA+LxYLiX8i
         RmbjDyBgOeQZFrN8V/DhZh6fNnrNbFXpMIIqEbsMSuVHuT88UXXVLYubMnWvsy/z8OhH
         pMmmUtdoBgDv6plDg7/zraajPUxidKtR+6l1yvAEyvIBUHiRtmk677WzPsmh+sW7fjWd
         AZXO99lUOceEoxSGQsFHgq9epeWkqAsadOSttXHrIOADrzJIopqEsaaLK0rgHq7xsTJK
         7kKg==
X-Forwarded-Encrypted: i=1; AL+hErFDXaX8JmimYrEOaHMkMj9SYlp6HFPFCIIg2neSSx7+Y572dWyHCaWWi1XD89ftx7/np3dhNgs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ohQocfkEcGUNgnyNEontb6tITpv2NO3/BCiD1sT9BVBnw8F60
	y+nZ0fMn7ubv9vC3U0L+dl625DXyiw+O1NBpRUidRRy9akMruKM4gUFv
X-Gm-Gg: AZFdTZdM25uLb2fmuHC/1tAukhY5LbOZMP9WGmLl0WeFeZbr6RLaoEc29brZ0GEX5d4
	at/8Kk4CtHlfjWP4oqH+JtH1LB1Gs3DO1NyuZQeP4YMjaAvn85Yd+Yp3aQLAzxd8tL+YiJMFI2/
	EQWBJ8bKI3Mk9M/jF/73LR1Q5P0GBojBlhYUrpjaU7i0yWUUA0ppXw2wQUkzCsCy7kAvUV8Dg3O
	i1Ohf/w9qEN0Ny3hR7xhqLW74G1r9LHbas6nDnEYjOeU6i0kWXgayQ4Ir5Eob4NxRArVpJuvwm8
	ZUSLwykLMfmpkrczWt+fC2WoqjKhUeFL3N1XEVNEdvu9//1A54e1tGwlCIvd9g/ArbSZcBJtcUT
	0+bBGKkIsH7K8bv8PVxVRxAPhP80p6srggxXaVTVz1vZcRyMNsjV1T6b7ksnPNUnmVgQaEi/uvP
	D8WxbAjnjhAPqYglBc212FU1ZUrLkFzstmxHxnYAZzEn1hml/PufrqZe8t7LrzQs8vlmK75NQyN
	hJHox+2UlyCo7XlgU+qvtP49t7hn7hgjtbQu+n67gCrOSc7M2mWR4fEugBR8/o0PhXY7OOuqklC
	hBo7qmzuUxhXA/RMOxt7T+DeBz3rLgu49l0tyOwx8Opd95Kc1ufU9/VTEyPY5/cVv//MBdM=
X-Received: by 2002:a05:7300:b597:b0:386:9e36:df0a with SMTP id 5a478bee46e88-3869e36e011mr13076842eec.13.1795465358637;
        Mon, 23 Nov 2026 12:22:38 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm32126987eec.25.2026.11.23.12.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:22:37 -0800 (PST)
Date: Mon, 23 Nov 2026 12:22:35 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, Carlo Caione <carlo@caione.org>, 
	Hans de Goede <hansg@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 07/10] Input: axp20x-pek - skip IRQ handling during sleep
 without input device
Message-ID: <awSgh5DW3V1cLYCa@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-8-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123183200.3900004-8-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:13PM +0000, Lee Jones wrote:
> On Cherry Trail systems where an ACPI GPIO button device already handles
> the power button, axp20x_pek_should_register_input() returns false and
> axp20x_pek_probe() skips axp20x_pek_probe_input_device().  This leaves
> axp20x_pek->input NULL and both irq_dbr and irq_dbf zero-initialised.
> 
> axp20x_pek_suspend() and axp20x_pek_resume() nevertheless pass irq_dbf
> and irq_dbr unconditionally to disable_irq(), enable_irq(), and their
> wakeup counterparts, manipulating IRQ 0 (the legacy x86 system timer)
> across suspend and resume.
> 
> Skip interrupt management in axp20x_pek_suspend() and
> axp20x_pek_resume() when no input device was registered.
> 
> Fixes: 8a78050ee257 ("Input: axp20x-pek - revert "always register interrupt handlers" change")
> Closes: https://sashiko.dev/#/bug/linux-5ae6851f-784e-481c-900b-2e1686578c89
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thank you.

-- 
Dmitry
