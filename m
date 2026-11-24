Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551245;
	b=sXfQlqLUS/yh97gGinMVKP+i+oDNX0egSQ1nCab7vnZpQgCVtlfWAz4VPFZa05SRcbSI
	 +72b2m06lfqpx3CyfTpCQt5l+6kGyX+2iRYT74Q5SiU9dfPHn8GJDobQfQRVx8Drx9gXx
	 EAaPRjqVLMw4wPP0P8wgGmW1ze4badGsaPHoystfTqGGoM246sp3kog2hJK/XJNmocLlk
	 PMSxrVn5qVlchKn6mTkocqicXrEWRc/U0OQ5PTasDXwMWCRKR4wYUJlovpKMQmhumjgb9
	 plB1kzgQ/KV0XdJbqOgXA016icRXnZY7kBWSEPuXNnuMcAIuaz/4noPuDnPmupsQ/nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551245;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=CtbqCWcplP8s8TS4XxS3H42+jZhVRK/WEZW5XIZ9ues=;
	b=Uvfcr3SZMGU1TsGlYVI17lNw7GfQt01inEOxos7az7Ijw+54PRTtwssVYfS5HM8ty9nq
	 t9o70dv17zLvFRenOEfI2K29krTbMsb/Hiw5zy4HeUhsitSbPGWF2FKyr593Sx8QHdEgc
	 QLdC5MUhAKT7OGKHL5GK2wEUgEXQJuw3yABVoZNEeyDnagEQsZULbUegTsyRPE29/AHfD
	 NsNn8IVBx9T02oriUpzgC5FyS3A9ZvixY5bK8+/EVW8TdzFz0On6T/Y1wvkBTpNJLmSIn
	 yhUVfGgLj4l6sQdaxJB0qGyHy4IfV7oZk71FTDt0uzR/bPviXQ0Riv6Cks6SGlyjh0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EsA9Klxn;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D4606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B41D4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EsA9Klxn
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cddc597d062so2940557a12.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551244; x=1796156044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CtbqCWcplP8s8TS4XxS3H42+jZhVRK/WEZW5XIZ9ues=;
        b=wKYVLBnK2X7I36jHo4sWEIYABF3TUAewi4AEwvYkblqlhSeXlROhtsF4OCTX7dS964
         2ixokEvOWtWXFPcDNczenE4QUQV0pm2fHXo28fDLH/EhOJ5HGBV6Jj3Z0b1J9Tp8urrB
         ZNp9EGe1UUhkGN5z5yYiDP3p2cWIs33TgSY2OzR9cutd1gHJUP/iB7EIh2vrSDFTPSaS
         V5xj+QpfHVqVA96KKB+TvyVkJjvluTSA9f+mtRQzGwJy/+3ispuQiqMH8O1vsDAG7IiU
         llyE4ZjHR7e4BSAlG6ePrtVCIdMNENUHldYdvI+712a8jK/DOQBI6g0YVejlQoL1egWa
         TZXg==
X-Forwarded-Encrypted: i=1; AL+hErHeg8AIW63ggbPJThkqqospUI+H2GkcDA0G4XG9wZNI3XUyYqFxLAGBbHNGY3Zd7KGGkcnbQNk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IZSJVLpN99yXO6KdeSwYE2o/sg1752uAzp4qxLsmCb11zUgjn
	viWp+veSFoupiaN1Bg3fFFepOBAzHS25s4XiKHxXX9MiuLMHA3xMmvhNvz8drgm+7LhvMT9n3pt
	FxjclceHzekTP0t3Q1hvq4EN9XAem6RRk3qR/uC3HSkN3ammUVe3QzwFissvPasAjC9JakJjsAT
	kUcZ6WY99rzP4rw+yuGsChs93QFSP19qJ4hH3RY3F+1Mz4RWyYnY4epygNVzdabFpiXJip0kCFO
	DLDAo9a1u6+zp5x/A==
X-Gm-Gg: AZFdTZcYfOsIZU1+MR6GnZpc3Kg/X36pmyOcsRP0RlCWEAlS8C/+kUArTXHeHpurvdB
	kj1GNl/Av+aRYZVI8TX3Y3uhTRtsrOxpHGRCc2mII4Mg0vCV2ps8N39XaTrJOONrYz17/tsjJNG
	j9OOLdpvl5dK6hDqA9iV6nQaNNWZH/YW2xGkV0zq2QRV3CEw/4CLioy+bx3cPTma0hYS+WLZtEb
	O4IxWHomPoiWAOvH5jZXkDOO2vBUBcpaUSIoNGGmaw6tgN7nyckNzMA5WF1vPoTbNAe3XS9BJM1
	aIAEnOuqFwrU0jYpBcmh7UQyTnsA/q0eoyMEIYv94XT7KCXlYvF4aM9t+A71dBGyiHfyWpc0g0K
	g+LI4fr3mVdCQt93wt7PBE3/UrGOyipCJzfMrXkGk8epVpPuBuc9FX6YPQZkYSkifbpEhCf1ZWI
	MBS5NWJqhr1RKnRc8QxhBrLZtrSYZQ/lDlEGRFUqU=
X-Received: by 2002:a17:90a:ec86:b0:3b4:889:883a with SMTP id 98e67ed59e1d1-3b41c9bacbbmr15656926a91.66.1795551244043;
        Tue, 24 Nov 2026 12:14:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b40625d66bsm11924138a91.4.2026.11.24.12.14.03
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2026 12:14:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-54af6c38092so61867351cf.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795551242; x=1796156042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtbqCWcplP8s8TS4XxS3H42+jZhVRK/WEZW5XIZ9ues=;
        b=EsA9Klxn+Q/y106PP2cCt1oIAmkdeOy89dF//oTCBnZmBkwacwhkEJqXikg8/lUb9r
         f8gkhuMl174WemRY1o3X/buRu5ByJJu1Ltr8vbvRw9PijMhq10j/qn8hbqWtpk94UJLZ
         hdoxxQnUYFSYdQITP5MjfUInRkzNobLDtF2wI=
X-Forwarded-Encrypted: i=1; AL+hErF/VMjClEsUEiAUWf4ZYmZa2v1Qj3kDDsxJAeNviEFOl0HoxYZKLAuI9LeHrXiCwLTHAGtwZs4=@vger.kernel.org
X-Received: by 2002:a05:622a:ea15:20b0:535:baa:a78d with SMTP id d75a77b69052e-55daab921bdmr54306261cf.10.1795551242434;
        Tue, 24 Nov 2026 12:14:02 -0800 (PST)
X-Received: by 2002:a05:622a:ea15:20b0:535:baa:a78d with SMTP id d75a77b69052e-55daab921bdmr54305701cf.10.1795551241893;
        Tue, 24 Nov 2026 12:14:01 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7884d01csm136284651cf.21.2026.11.24.12.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:14:01 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: michael@amarulasolutions.com,
	linux-amarula@amarulasolutions.com,
	stable@vger.kernel.org,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Benjamin Drung <benjamin.drung@canonical.com>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH wireless] wifi: brcmfmac: fix use-after-free of the watchdog task_struct
Date: Tue, 24 Nov 2026 21:13:57 +0100
Message-ID: <20261124201357.3497730-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120174231.2024897-1-dario.binacchi@amarulasolutions.com>
References: <20261120174231.2024897-1-dario.binacchi@amarulasolutions.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Fri, 20 Nov 2026 18:42:27 +0100, Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:
> The watchdog thread exits as soon as it receives a SIGTERM, also from
> userspace, e.g. when init kills all the processes at reboot. If the
> driver is removed afterwards, the reference taken right before sending
> the signal by commit c623b6358088 ("wifi: brcmfmac: Fix potential
> use-after-free issue when stopping watchdog task") comes too late, and
> kthread_stop() runs on a task_struct already freed.

[...]

> Take the reference before the thread is started and drop it with
> kthread_stop_put() when it is stopped.
>
> Fixes: c623b6358088 ("wifi: brcmfmac: Fix potential use-after-free issue when stopping watchdog task")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
>  .../net/wireless/broadcom/brcm80211/brcmfmac/sdio.c  | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
