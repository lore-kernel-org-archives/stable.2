Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795637662;
	b=ERiA4OBLm0PqGbFXym6SN/s6TLYGfQ8uNTWks+YIrX27+obwgcVq/zZujDy4RCzCDARB
	 tbVf6jiowhTAOCCVtvqKZED0woHJT7QZnH1FM7ULkXN/dRxImlRtIfnAidTiL+644HvSu
	 pslUEj7481TbGNT3TV5Ltcw0HLg8Tj9+uTdQoCqbZ82bzZ2QPPH3S3lCyQDnUL/O/D9JD
	 UHRPogwWIW91AtPy//A9aWOr7sNFORrOQ1d6FmkNhpr8mtuRaHU8FZ4SUe0IIZABSWV+X
	 NmJ8y0O2Xn6Y+ANooIOMSfTQBCia4u7ngdnpknyElFeMrQf7b0PfNpL6E+7tXO8eIlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=4gJ2nfJNNsnooY22Q28oVKhV+c39iAo3Qrs/5iBNEqU=;
	b=5DXiq9fN+yI8EuoVYAtv+8q8AwUOT2QHv/X1tG9sBrLOgDA/QLn6xht9AsigQJALUizX
	 WEM3KKX9m6eVXQoY42vGSNJMmBOZlGXE3D39A3JzNRnneunEvsmHzsYruuSVCow3EAvON
	 7te2JwVkQdmG1T/cwxx3jW665hfig/Oxv7uEb1TFRHFUnj6eVw69BuZ91BRsY68VyJPu6
	 TJ1ZI6UcQJnZnWChk9eRXijo41hHW6NeWGC41mnmCjFGCBVsJQ9z/p0wd8tq0SSevKB23
	 C/plVb6DI+kMZpSR9Y1w4AbIJPsHUjkXDLIecTbDCqCiQOoNVXLgVsrK1EcLPBCtA8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=Gkgsw+go;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC633606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC633606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=Gkgsw+go
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6798eb0d190so5200689d50.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:14:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795637661; cv=none;
        d=google.com; s=arc-20260327;
        b=iGtv4/oX7z48KHBlStOhfQ9/2PyDCQnKO9VZ3Z1uCPqfAYzD3dLbcCYP8VSeP/acWm
         ihPfMBvYpcOh2i4hnZPZcuWZM6oVuA7KeUhivG8T+Tv9BlaVvqGtNCAMk+Y/X3xUu0Ps
         JOTrIUNGeobzA7tg6nxhxcrsyTfhlsV0tCvJNsOqcG+P4g3vQ1yPDy2vJAs2t5zj/xcX
         p94Qvom0cDxW6jwPOScu8hRNR49DsWOWtucDzKc7mFtm9gCpPPu1+o2D6NBMeTvKfqTM
         hqgTH5edSVvdhJ2saEgdgC/o9+fSMVoeap2bng6JaHtMVJRnJX5uASyL643ZP7Gff/ss
         vvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=4gJ2nfJNNsnooY22Q28oVKhV+c39iAo3Qrs/5iBNEqU=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=HojG9HamG383OoZIyauBK9p8SvLb52f/+MZ2qZjIzPmLyrydkpS32ajjHrk6dfFjH0
         5x/bd8O6CisI1JORO9i8ukH7Imh/DODBwcbwF3iKCbrTDlRNOrP30J7JEez6fV4FPQkq
         VQOBjcNHvGjnFhzlH+FO3Zfc0GRtyMSqyCuqRpacxDwNh+A5PgI9V44n6Ht2bQpimXAa
         1nPB0ni9AdxnqOSsKelaaG2UWJjMQ1wWydep/9JrMyINUw6FKaMiMHGeSgZ/lMMCfhe4
         VIQJMWrJPBS+KyhtT290oWvE0q0peohuXGshBtSYre8PgPEpJY+A6gayXTad4VFH8E28
         TqhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795637661; x=1796242461; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4gJ2nfJNNsnooY22Q28oVKhV+c39iAo3Qrs/5iBNEqU=;
        b=Gkgsw+goLS295pDfcxAmuVyGpIw3rtGcfpzbiE01K4tvRBZGNtS6zE3N/gOcabBL+l
         ZdtPY5/GyZU9EymflsYDc+JzyibFqWddbZ2LZv/s8+uU6ohBa7t8YWnFDp9BnsKcP9ps
         EddsGv+rXbEowk1Rwurcz/RkoZiexhBECXpaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795637661; x=1796242461;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4gJ2nfJNNsnooY22Q28oVKhV+c39iAo3Qrs/5iBNEqU=;
        b=uaIyAHthPrMn+Vt8vSM6O7WeCAI9Fip9TecSucWVlXKBZF+0DQgLeXJ5Dr/ZWg/tii
         kMZoUgCDLUft+t0iX5sWKtsGEdpGUOvYt+4eJRQFQCz7H6Yun9pR3WIVXY/cHjUUKTP6
         3FMhbAm94Cs3yLlKimqWsF4YGWNCrL6mmD6rSqa5fi5OG7PNkauZe/XLUA+cYweDrQfa
         hoH0+1xwggautkJ/3t81pSFeEI7t0HQDaswd/Y4jv0LYy/6gYoixlYPpKAoo9VMq/LCn
         e1o5WUFDty4Cz6JVmoFYQ5S6OiQDZTxdVMGVER+x4j5wOUBFMYniiaLRes7qAPruZDz2
         YkKQ==
X-Gm-Message-State: APuU4Z8rkSjYulpv/4wguGH3b/+D7nBjCaiS3poh3gB/SO8hXfJInCqd
	GScfE1/TNUMJmdDJtA4Vvu8n01vkbuqmoiVil+MIYdZkj2bulfIImC+ETfLY+ATuVKble1Ix52M
	sYkBHhYi3cSfk51s2sw1reLigfCzUpLR+k2CQtHMR2WuQ6Enq71XSWoQ=
X-Gm-Gg: AZFdTZfAZ//iGuf3tS/sqPO7ua/jK8UttqdL9ixPHAv1J9jUgmLUnSzhfh9Kitle2WL
	OHJykiCJieEpTLp0fXj6L64aqGgmyGFzWMSI9Pmrqa3wl+Ch8NqTEZ9oHHCfj5aVG4+nvdeRDkE
	95SkKmdcLO3O0MT9Yjk28d/Lbi7GQHrX/X6P9dLGtGoy1EFPrJa/2qVfPHvLlLMlQ8kiXMDq6TT
	I1V0fLbCqsRKoUWPZmrjjMFBpw5Y6uPVgZp293Ey8RtJ2PwVfhnrMAjVYCiZ2+kjI84YfvprWkp
	Is6pcoN7kAOb6ozQ42Y+pHQfWp55Qu6zMnAnvDZ6YRUymZ2OO+oZ6vMD87cLHxjGDzg1MjkMNuv
	657rralzmtxBGuVpel80Oj8VpO58gGB4NMVcOvnwyr6jC/H4RrrpV1aFBpdEJX31SBtG/haPFNd
	u9WkpD5J3Zep70h3HCIYRxQef/GNdVPAikBmeRgd4/IY2RJTW2vpQbHA+dK58I5FMWGG/n2HdST
	Ce8o4l74hbUeiB+rLXf4/grFQSQXx43qKXa1VFK0VOpXc3kUOWY5Pq6O1M=
X-Received: by 2002:a05:690e:a4f:b0:679:b50e:9a with SMTP id
 956f58d0204a3-67df44b21b9mr8433040d50.108.1795637660681; Wed, 25 Nov 2026
 12:14:20 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 12:14:19 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 12:14:19 -0800
X-Gm-Features: Aa3M54oJ-VJLCCgS-5ZIIEuvMz2GEgSHdsYR13vhxGESAPOauVpoeB1_2atbS-o
Message-ID: <CAFaZ9eqzNSgQejze-paRJ720iMQpNA=0HCXB6YOgfK+c7YBfRw@mail.gmail.com>
Subject: Request: security fixes for 6.1.y, 6.6.y and 6.12.y
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg and Sasha,

Could you please queue these upstream commits for the trees below? They're
security fixes, plus two prerequisites, that newer branches already have.
Each applies cleanly to the current branch tip.

6.1.y:
- 7a6d793e9ca8 ("Bluetooth: hci_h5: Add ability to allocate memory for
private data")
- de4e88ec58c4 ("Bluetooth: btrtl: fix out of bounds memory access")
  CVE-2024-26890. The first is the prerequisite: on 6.1 the H5 device is
  registered with no private area, and btrtl_initialize() writes struct
  btrealtek_data through that private pointer. 6.6.y took the same pair.
- 0460253913e5 ("NFSv4: nfs4_do_open() is incorrectly triggering state
recovery")
  6.1.y already has 7813adb38c88 ("nfs: use nfsi->rwsem to protect
  traversal of the file lock list"), and the upstream message of that fix
  says it relies on this commit draining the session slots before reclaim.
- 87cd6b717e40 ("net: ipv6: keep room for the mac header in dst_dev_overhead()")
  CVE-2026-98570.

6.6.y:
- c88c150a467f ("nfsd: fix possible badness in FREE_STATEID")
  CVE-2024-50043.
- e8d97c270cb4 ("media: verisilicon: Fix kernel panic due to
__initconst misuse")
  CVE-2026-31573.
- 167e54c703cc ("rds: tcp: unregister sysctl before tearing down listen socket")
  CVE-2026-68290.
- 87cd6b717e40 ("net: ipv6: keep room for the mac header in dst_dev_overhead()")
  CVE-2026-98570.

6.12.y:
- 87cd6b717e40 ("net: ipv6: keep room for the mac header in dst_dev_overhead()")
  CVE-2026-98570.

87cd6b717e40 is already in queue-6.18. 5.15.y and 5.10.y also have the
rpl_iptunnel commit it fixes and it applies there, but I only tested 6.1,
6.6 and 6.12.

Testing, on v6.1.193, v6.6.163 and v6.12.119: cherry-picked onto the
branch tip, W=1 build of the touched objects before and after with no new
warnings, and x86_64 defconfig with the relevant options enabled, built and
booted under QEMU/KVM. I didn't run targeted runtime tests for these paths.

The list and the test runs were prepared with AI coding tools (OpenAI Codex
agents, with review by Claude).

Best,
Dickson
