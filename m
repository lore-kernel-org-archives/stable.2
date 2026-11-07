Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794039221;
	b=Ak07B9dlfEOG8Ro8D4c1cBoCD9uab/mc/7L/+uylMl+FZqPn1quahIERmcKqMi3ho792
	 2UDL6KsxomwmrTzQsRJ7r1t4bFVSld7vKNdZUp51+gg3sqpEIKM/vS1GOpCN+zf6bcsdl
	 aK6GyvCqZpz9GT/0WuLLawqHtxzqcINYZ6Ck0qQEEEuWlcMZVBVkaRvxg2M0OJfTLUOz/
	 4zziyrv74KwvaTGo9h5qcIF+ns1YXGE09vjt1S0f/m+EHVY/eOc5uORNecbbk+59WEDoG
	 fXkBC+P/cNyaiGOmae4PAviDGHaIOK0YS/uzmngw9apOEISGzdA6SdTI31LgR1zIoSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794039221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=drqqMV56464i4tsg6wHrzxaF+Ciezd2Nv4lHeIMrI/0=;
	b=CU7nl+iON2sQiR04go9iGewDIpTeux5JAP6CPzHingf3BTS4ClngZTjwXGBOFEMQfIdd
	 EqeSKhg79KjLx8DO0uL9niXfQytL9oJxJ9W5IWxLyjWOyj56FFVDEsNbQeO2vJIh5iEzP
	 AXaSs9CgzdAk2bLR7kh3gQujiNTczrn0QV6hoH4kgyhDfYU4FotPYayvudSi9abRtpb0q
	 X/Zj4ZzoVZLWR1dYA0IlkmW2+xHaLObHoXJZZj3yT6qz6ZLxjd9w5621HdeHvuSa9cuPb
	 mo4pDRKCLhFUQGOKPpYi8Wfr8PCN16Svv8Ox7v+yh1AtQApKH59MAoNnRhNbDEBi8DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZvVjFvY;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DF606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 08:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C7DF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZvVjFvY
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso2832670a12.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 00:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794039220; x=1794644020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drqqMV56464i4tsg6wHrzxaF+Ciezd2Nv4lHeIMrI/0=;
        b=bZvVjFvYYsdSzfWwQT9YkMoTP8JqeZm4/UzCAp81sLLhJzxMtyORcr2aeCuQYaE0yN
         YMguZpntuDTDP4YvBUkVr73+CnKn3upZ8VOxyXz9OZX8v5pXNMUpjWSGRQiStPu6y6LT
         buUjSwLh4C8SG0Q90s4kYfgivk/FS5Icm/8zhEfN30QKHh1Uedv9t5IZN7euR9Zh6h3s
         mEGBaFfe6+6QAhdmq1zecfl2fYrBFQ5nVlOpWk/E4cd+AAoPId8GoRLEoPcOvpFp1PR/
         tio5yKKhX+mAxTfnvUy7t5/IM0VC4XzhVc+sX+Q44IZGGFAWkrX6ZOMDEt+DhSv5JnrX
         0ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794039220; x=1794644020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=drqqMV56464i4tsg6wHrzxaF+Ciezd2Nv4lHeIMrI/0=;
        b=Lhr9miHfhN16SUtsO/Ok2os46GToeWnFriZMPeJkrWcb5g6E6oa7ftdpvD7FND7JvL
         1nPbv04rhACposf5zaQHiZCiDWgpa6DMQ1rva7Q+/v54k4Unr8+swuGAGxNSBylvafG6
         f19xf2Tu4nKZc7lINHwO1nuWKQezGS660OL2atYFN/+DCfysKBqqLV1fIPUdNlNCXAen
         oqLc2SCWVVDWeRy/1pxrjQ79hgX6QorIaYodTPn9l1nyG6zucSxcgSzd1gdi2i923cOb
         MUXIh+/E0o60VAasZ98Y34uil9qlj1PbJdZqkdKihIzDqw1KoWHTcC1LJTNVu4tfIyMq
         94mQ==
X-Forwarded-Encrypted: i=1; AL+hErEq7mX0QhfeU0EN42gwyaZUp4eK94cJjcSHu7Pz+6gY5cMkHXkaQsoEzdOoQMVLzV0XBz3KhWc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aVbaXmeFnN0hJbN+hR3x+zIuh92CH+neCL4rb1DEnfqNJi8/g
	N8FkwT7LspQSCWKRsOoFme61vRwQgXvUON0IeiuENEVgQrNyNtIYf4hq
X-Gm-Gg: AYBFou2feASDN9B4yNwERn2hI/2PKruuo3nA6diiXlB+GNtlMRGsxTVGfZb75nkMfj/
	npcldWxDq6GNBALpQJFPe18Z0FExtBfX2pdhfCy1iqmUyeM/EP2gVuLk0FIOf4UmYHVsLRWWdpg
	BJXX1sGdo/lahif2XXdstpv5Cmp3/GC8AGKhWx0KVLykEh/2hIBa6FJ1h8jTmo+84iz5qraWMHW
	Yngi/PFKQEzq3/n1EN1ofW+l1GQlp9Xk3I7/tI/5KM/lWhJSqkVJohUlKfLzxI4UK6XnPxKLU0T
	iYaHz+7rfpozvUNS5GUML1/8HOo4OUSI5n6L+/avJVmMIG8xlqLjIS1F8oVEoYbfgzDbJ/y3HQ+
	Nvv4ffdm7loPsKPV1oYNyXNwsVGYCmB1vUHCxK0QJv5yh5PjxQYwpa4IFDm0ZotbR3fxb+H1LST
	YRjSVvXyIPifEZane179MoMnNSR7dwtLKi5ojocTDGIxsiR3OjYMqQLTOhLJcSakWbbV+b+LBvh
	XRxtp8EkttNU7vtEVm2a8TUupb3qGEJ08sleFKO7SGGpDQNSpJIDWit7gyA/V1oTQvCEEPaMrMR
	i18EtG0gb5fT+Qc47BMsBf3qN1B7X5kiH5FiGjVSQJytfxk=
X-Received: by 2002:a05:6402:4503:b0:6b6:e857:19d4 with SMTP id 4fb4d7f45d1cf-6b6e8572a11mr2906303a12.11.1794039219559;
        Sat, 07 Nov 2026 00:13:39 -0800 (PST)
Received: from localhost.localdomain (luna.k.pl. [193.239.59.185])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ae576asm1527357a12.19.2026.11.07.00.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:13:38 -0800 (PST)
From: Kyrylo Biryuk <illofspeed@gmail.com>
To: rylos78@gmail.com
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ata: libata-pmp: disable the SEMB port on Marvell 88SM9705
Date: Sat,  7 Nov 2026 09:13:35 +0100
Message-ID: <20261107081335.3360920-1-illofspeed@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103215706.508495-1-illofspeed@gmail.com>
References: <20261103215706.508495-1-illofspeed@gmail.com>
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

Tested on a Synology DX1222: four 88SM9705 (0x1b4b:0x9705 r160,
6 ports) behind an 88SE9235 that is passed through to a KVM guest,
6 disks. The same 7.4-rc1 tree built with and without the patch,
one boot each:

                                    softreset  reset failed,  last disk
                                    failed     giving up      attached
  7.4-rc1, no libata.force          60         12             197 s
  7.4-rc1, libata.force=N.05:norst   0          0              70 s
  7.4-rc1 + this patch, no force     0          0              11 s

With the patch, each PMP logs one "ataN.05: failed to resume link
(SControl 0)" and port 5 is then left alone. The same disks attach
in all three boots.

Tested-by: Kyrylo Biryuk <illofspeed@gmail.com>

The test boots were scripted and run by an AI coding assistant on
my hardware; I checked the logs.

Kyrylo Biryuk
