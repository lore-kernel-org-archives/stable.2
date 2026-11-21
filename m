Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795298143;
	b=WAHifjXXEoJm/edug5ggD+PChsfn5vBzM1r8uTvFAIMfQ867S+bvVJeZTMXxlS1ZgYjf
	 /32NGkpLj6vlWXmY5yidQfvA/EzxGCHkIsJ3yMOWs5FiStOTI5d/VXLDKqdrO6LykIkHf
	 xCqPoapxVr+bRHfedSN+4DsbnIXCv2rhrtIv7E2qD65QCqo2rVsZrL3wU6/2knYikM5DR
	 +Y5d1vlcwmhIkU93hudSe2jW+O9TEpygyFw/3tTRHSb/L09gyQjce+ocCPVz6OGOoulof
	 1PWOPLcqrhhD5V4mTXfehCz/hxf0I19B6IhBgZn4LrMzTy9XbuDoHeO8UMBJax1s7ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795298143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=KCjUtohJo1syh5AF9wt+LVHJxvbyrd0qzAwW5js+pGw=;
	b=EQJZlpflqKq5XIlCy1HHTesR09hZrva1s2m8v9pKqQIOKMmEl0evVp6TWUua+3iooZiX
	 F2sGme9uJhiSrFyC3/wjmubzQlinfK9lGKieyiYsfHELWKb/3yh4ANSZSMYS20+ZhQ/+7
	 Y0ME8fzqXTE/x0N0CdUFtmvx5sMGSw5UlbifyDjoYdbMCQQrRR3c6m1vAhL4dy6jp/ERj
	 DHLd3ydunixatBgpls9G3dmYbo1cwIna+uXSzeYGp8RN8lOKZYggX6ymsX35P5sw4vymN
	 OzbT7yzZWChjtm1VX/eBNxISDNvmBEGCAI60QN1X4xefKGdMKcoYeZGjwcGJdeag4Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=elRo4E8e;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B265E606A33C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B265E606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=elRo4E8e
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c516a160d24so17393566b.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795298141; x=1795902941; darn=vger.kernel.org;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KCjUtohJo1syh5AF9wt+LVHJxvbyrd0qzAwW5js+pGw=;
        b=elRo4E8eL6Ff9JTxWokGSChCv6ga6xjLaxbwG4IuokCWQcX+8wY/4TwbB9eLmqPNvd
         Fh3vzMvwpzy/pOr2RX9SlCQFI+Hjk0445UVSnhuh4ztDmhLZM+VCJtLlSDSy7y76lSic
         c37MaL4b1Qz4CtJy8OeIs3V21nTsac4UlO4hgwJ8SnYbq9OyCNug0iwYSaixQfjAzjpY
         qPi9C6xCmDJPR0eKep0Rxz3wp82ZhOkjc38M9DvXOyC5JPcdEuj9G7TBP8QX4eJJsx/n
         sOs4jdQxDBwnYwTPuxSdyz7MRdh2JqrOe9sBMUh6XX6rEf5X3LuB5PNqbH0zit7TtGC9
         NUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795298141; x=1795902941;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KCjUtohJo1syh5AF9wt+LVHJxvbyrd0qzAwW5js+pGw=;
        b=07yXvzI/9yJemHBrQOVl9f9IvUtomGAOm5mqJvzTQbGRedKg8Bb8xzN/Ixlp72k9tY
         lrrU68zTzvVHN5RhlTNl79XwryfTMSAZSW+ZhzlBLj3j9lxe5YKbeXxZgi/PMkWtR2nH
         c9YdbUv5pSfkujNlsJU2GV4s/iRIhdGCaNQZ5Zo4PGfzUoDNPPgN0fqIyR3OTZHJs/i9
         BgWfufkCkw5EOW955sfp55cE6V/ryvq2UKC895Fiwxcy4575nNWsNTjEchg9IcJXQaiv
         JkIH6TPLadx5i9872l0rRU8fijYVAPa4iv43ZsBQJj6my7nAfh2D3bVVTTxys224UvTp
         AQtg==
X-Forwarded-Encrypted: i=1; AL+hErF2t0qg8qc/6L8tq02c2/24OutrGn0A05GwmZKd/osOV4LlKwlUh4xXGfA+AmTcJvcVPTxkPE4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qhJIrroa9jLpWOJEmdM2V0OYjxEwPcBHEkbWNpeXo+9GfzvVS
	Q7ejO2nGmiKL7zK+MtwMus2A1aTF7CZuFwtmsK67E4nXkbITcr/9B6Cx
X-Gm-Gg: AZFdTZc4Ua3UaQ1e/d50f8OmCVyNJzae0fuzKvWmKxsXC2JuI6ad95dpm+FvV+NJI0x
	ZyWz6rklHJJ6NRiNbaD9cC2bAww7K+inrTHhMa4ku1bo26A9BJknywQiNN00cbcBoWCMMiCHM1i
	lezXszh86UIWqJf3sWaMD6JTnDzWIKTSUDlzK53uQl/5Em6WNI0vyzAp+4h/M51N2GViVIe7DYh
	dnCVbDH58StfyshKIwURzs2tA8sYuiMkDhRqDw+8WFYZ+hLx7z0BJQfEACVIiPlgua0KshqilJI
	lzi/Je18VlNeQyWlaWShROXSmkb+MOHBJZJQCelVETVB+yVyrju3YIGihg2o101p8pkYaLgK9Q8
	5D2eoXJdjZOPgZdPsOMDh9PtNLi4/Q7hEZPORzX0Q2KeFYWALD2SRzpF1Q4CWXFicYgXvCfF7Py
	Z1EQ7+EjMFDBrFxfZgBSQoN7javSP3FNaMMhGBBlDEpZ1agmtkRF0QXtgQOeDOcrbwmdGXL41Eu
	RFOomTNZcBHF2/hXkUdtNPO3D6wJurZ6rYOuKnl3wPL48xSVF6qYe4lLZL61Xtws5drBkQkbCBG
	IcG+ytkJfCYWrMWxLsC63fxxxBDguPrz
X-Received: by 2002:a05:6402:13cc:b0:6ba:88b9:71e6 with SMTP id 4fb4d7f45d1cf-6ba88b97656mr636301a12.14.1795298140925;
        Sat, 21 Nov 2026 13:55:40 -0800 (PST)
Received: from [192.168.1.182] ([2a0c:db40:0:80df::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370faeeasm3038747a12.22.2026.11.21.13.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:55:39 -0800 (PST)
From: Konstantin Nikiforov <helllamer@gmail.com>
To: linux-raid@vger.kernel.org
Cc: linux-bcache@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Yu Kuai <yukuai@fygo.io>, Song Liu <song@kernel.org>,
 Coly Li <colyli@fygo.io>, Kent Overstreet <kent.overstreet@linux.dev>,
 magiclinan@didiglobal.com, xiao@kernel.org
Subject: Re: [PATCH] md/raid5: complete unsupported discards successfully
In-Reply-To: <179529607529.5.3302391929789139470@gmail.com>
References:
 <CAO96y0V6oncv54ihXnHfJMYiG_QAQ-NM8BOdqPDXKL8r8-kR9Q@mail.gmail.com>
 <179299857972.12222.2729359466842183358@gmail.com>
 <179529607529.5.3302391929789139470@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Sun, 22 Nov 2026 00:55:36 +0300
Message-ID: <179529813639.2.16814857958553170519@gmail.com>

Hi Kuai,

A short follow-up to my tested-by report: I removed the udev rule that
zeroed discard_max_bytes from the md75 initramfs and disabled the host
copy, then tested the real HDD-backed stack with an actual discard.

Same kernel: 7.4.0-rc2-md75+, md-7.5 tip c526b7cd32f7 with b964c9240a37.
The stack advertises discard again:

  md126:   discard_max_bytes=2199023255040, discard_granularity=1048576
  bcache0: discard_max_bytes=2199023255040, discard_granularity=512

devices_handle_discard_safely is still at its default (N), so this is the
raid5_discard_limits() path the patch changes.

I created a 1G scratch LV on vgpcrd5 (dm -> bcache0 -> md126 on the three
ST1000DM010 HDDs) and issued one 64M discard:

  blkdiscard -o 0 -l 64M /dev/vgpcrd5/discardtest-md75
  exit 0
  /sys/block/bcache0/bcache/io_errors = 0
  bch_count_backing_io_errors in dmesg = 0

So the real bcache -> md126 -> HDD path also completes unsupported discards
successfully, not just the loop reproducer.  That was the last test item
pending from my earlier report.

Thanks,
Konstantin
DeepSeek Flash v4.1
