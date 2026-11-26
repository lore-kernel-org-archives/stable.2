Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710468;
	b=FggOt77mQ4OjmD6E0RnbhZ/Iwc8kNOefp+0G6l6MRgkJl8/OrVTDvFU3rXN1aitX3ZJK
	 3hDhcXZUveaqDyCwBoaVQnQIrzhd0fIo94zsi9DsF68ljaXKrhwxEUvf0sWqKmLwoZQJM
	 +uKOcqnSSsRucmmyBBd9JOA+mGxpgteRx8wVBDmoLGQQX1HMu0a3dZklsacKsMjO12pxT
	 kPHqEIiy2yIFRRrvvcsy85io2FnZ+0uLJUFn3eviwqqbZ0j7gacCAAFlIQwTsbKPadoOl
	 dv+ds2OhrY18LNU0tnBiC/7jjp9q6Im+GHvJrd+tTC9x/KW4GLhiZyX8LVZitq6cjnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/b7JOvQXXmoQ6+riyfmFa4IOM+ApazbsNDpOEn/4jwQ=;
	b=Rcc2LI8wupfgygZwv5X3cGZFiDTLt/ATUXyysGYrioW5PC/9ws6/rNXeCP8WdzLSqf4z
	 DXWijbOfvul0l6lj5ZDaLV0it+1T1H6UYD5eig3yRRu4LoRM/pewsB/dw/h5WRlLJ0EPG
	 3nPqCCl0IkKpDvkula+R9rdENQW116vP2jNwzTShUQK7CDurPdnSKBUBaQKpvLS54/HgW
	 oAVSwXtRcK3TtiQdQHzFfHm4I5BJ6kW6dOAYKmVn7qQ3cEKJSEFnQ3UFVSEN4qHPM8IOC
	 l2cHXNv9RquwtHXHlcC4b5jhlPuj0lLDsZAog2l9rDqf1VUREz4Xss3cUniRv7E8T2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eddM3Tz/";
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D65606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9D65606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eddM3Tz/
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so3534181b3a.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795710467; x=1796315267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/b7JOvQXXmoQ6+riyfmFa4IOM+ApazbsNDpOEn/4jwQ=;
        b=eddM3Tz/hy9WOl5fwh/imckNfBoirKacci3hdOuvENr9e17zVf2gJEyizNrVl1/RRP
         V8Ld+SYV7893kLXhWduOxebAHA8nvv/vAy+9YO230b62eMJ2boXQ8TFROjs4rGe6pXtr
         +yUbdJbW00q0jOV68kgvCLR3NqocLRmb0K58736+powwrxAdTP+M0X1sdNnqus5xGaac
         q93E7g7dBrjEAj2TPqLv0r6h1UMTqNDNsEgdBE8G8OEaGJmw/pelGTjBrRg6vF0ppchZ
         /yX04f1UPceXJy0x+j1SZJ295w8TtPc+7wdnuEpU92VF8lpFUxBBWOWZLYNhL8SWSD1s
         NxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710467; x=1796315267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/b7JOvQXXmoQ6+riyfmFa4IOM+ApazbsNDpOEn/4jwQ=;
        b=MgA8O/0uCEmdWj3v++zyOH7JqGvbZe8durU5B/MXUiwiaQV8zQkrzRGf0SczQ1HxSK
         REx2HabZLk1p/V6QlEQf+Jshvm/WGiGpITNQH6LdPHL+7dQ4nREJ3UjY14UajmCaRnBK
         nQjGMPh42iNMH5Iq6fFQ+mA2XxrC9ypoKfOwMTjg3edVZbDewz3+DurlKsdF8N2AvVNb
         NCN3aoVCKyBA9p2tmXG9U5Bn3Df6fhJCe5Ox6bkKauFIXiG7gWYe7UMPHS9dvXSTys9O
         pe9EGzspsK3FNbnxTGjqIUB59zcKurnNH4oxWFIXj1/yMXn+ghlRhcXhJW99g7/21NeT
         mX3g==
X-Gm-Message-State: APuU4Z9oFLdKqRCam6dyWmTnBuXBzBfgpWWpBsHojtd264HQAP/3lr1k
	jJ2QXjQ0VwxqoxlqjBmbFwrPQsXuUfmpnWenXAci9BBB3BEf02KikJm4M9g+25NU
X-Gm-Gg: AZFdTZctlmf8eHXBCoFCi/jS/D8xtJ40Zb39czzQCFdQPCZI5vos/Lk/mY9lYk6RCf/
	7EaO/e4o1mt3VvPiJI2vKAgmP8tfFMxpOeQoRwKtnRpJdyy97cQkQd5zCxThTyxNS1qfIk7nFGV
	iaHjMVitpKL3krEPt8tPozk1MlkVZlxz2sXXi811sYs69X4Auakk2D7OoDDTu6BZGz/Kgj5f7XU
	A1asx4raaNW2kr9A7myd6KXgKninhsiTazPPKx9AUek+uYLfmPQEaDUVECYXtklZEpEToEANtGr
	QcemUExIsW1TuMa/2WURm3C1jd5FbNbrSgAGISmhi3q4G5uZAkoQ/N3Fyhrq1dBgp+1bXRbcJnR
	PtUSKS12j7X/ubWBQu/dyH18txqPa9WN5R8dkDFoCgyQ5p/iq5s8GAOLmsQ78a3MzS6DXuedZwz
	d+O/JEu+xHqJuqsFwTihHELsCRgMB7qRVpWYZclRzT029FfhhDqceijNmbkX33d/jG8r/Jf7eGs
	s+K1VprOoUyPpYl6gZylQ4gQPy+eFUHlF/bGAXgOUbuS0JX0F52/Ybl9gG7ZSTA5HcD1vYZRpFH
	+62LDl25sKzYUJo8t6yBIcy8/o894WTzIW1fUNgIdbpzKFdsGPtWU4DbnvDcLg8ut7ZfDC4p9jX
	leAdUDshKKsGNLoXVy4sUkRntArumVoEN0g==
X-Received: by 2002:a05:6a00:4405:b0:880:e4a7:b1aa with SMTP id d2e1a72fcca58-8c87daf2130mr20658095b3a.55.1795710466917;
        Thu, 26 Nov 2026 08:27:46 -0800 (PST)
Received: from cchengyang.duckdns.org (1-164-86-80.dynamic-ip.hinet.net. [1.164.86.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343f83dsm11037097b3a.39.2026.11.26.08.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:27:46 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>,
	Kang Chen <k.chen@smail.nju.edu.cn>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	sched-ext@lists.linux.dev
Subject: [PATCH 7.3.y 0/2] sched_ext: Backport two fixes dropped from 7.3.7-rc1
Date: Fri, 27 Nov 2026 00:26:56 +0800
Message-ID: <20261126162700.22257-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
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

These are 7.3 backports of two sched_ext fixes dropped from 7.3.7-rc2
because their rc1 versions failed to build [1][2].

- Patch1: factor scx_reset_task_fields() out of scx_disable_task()
		   instead of taking a298fd5f4ee8.
- Patch2: drop the __SCX_DSQ_ITER_HAS_REENQ context line, so 
		  b3768d058c98, which adds a new kfunc, isn't needed.

Build tested on 7.3.7-rc2 with CONFIG_SCHED_CLASS_EXT=y.

[1] https://lore.kernel.org/r/0782adf7-20af-45a3-a09b-2a34c76afbac@kernel.org
[2] https://lore.kernel.org/r/6e2e92cb-6663-457b-8225-0809917f4332@kernel.org

Kang Chen (1):
  sched_ext: make DSQ iterator stay drained after NULL

Rahad Bhuiya (1):
  sched_ext: Reset task fields on exit of an SCX_TASK_READY task

 kernel/sched/ext/ext.c | 57 +++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 18 deletions(-)

-- 
2.56.0

