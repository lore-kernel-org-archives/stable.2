Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792619411;
	b=SuXO5KHP900E5kWXzPtDxzGjMfAvtNxJLOMAn8EGLwj1GMvdVIo5o7GKJphq0/YQHK0W
	 mHrbLLB7uL92/yuWogQIxfiNfdekB3KqML/XnFo1TtLmVTdNBSYO4WIxBgnlCoKGQ/7GC
	 Ay98i8w7PVJmEIWmG92GnwzrUNBTmM8k8TthG+1RS1u2tSqUs1RWABJBYLv3LpbOznAfC
	 jHqMP49gnqwalOXGV1QhY43GpfbGTFK3mxzbEuwt9pTHG8u2prQKcH8Lw2gG5j8eQH22E
	 Kvgs3f7WmpJrL3AMluaYF7WaCPSo3xmk60DJBMdkw/yjpDpRKWAiUPuZiXdskgaCBqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792619411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:Autocrypt:
	 Content-Type:Content-Transfer-Encoding;
	bh=pG/003MQQY1um8GPL5yg2wMvrMwUO9tsXiweKrMHMqE=;
	b=UIujzqKoKsYbtz5oG+qBCQEW4SepVzqHLWEXXXL20VhihzR/q2Z13UZma6dVFBLxdfdC
	 ienNUH4ivRYP8u531c/+h1Cul/Pxj6QHIZMdmfelduQM4y+X6A+QCBj165Oz0sLnrFW2e
	 Z8et+O9tCPOuPptWzUFb7y6iiwbhTFBAAzMbKfWIrH1vGsfp9hG+7c4MftNWrT7EVHvqc
	 S24fFpXlq9dFDku6TnMweZCmKbLdstSHezgyQRsfkwsGq4xvT4Dm8h21aOR94N+BFoiOA
	 lxVBQ6aC+FDAgMWgZ68FBmxsYOcH1mvo03RofYPz1khE1PomKu1vCx0lN4P+th4dCGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QYIVsVcw;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D530606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 21:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D530606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QYIVsVcw
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1409392eec.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792619410; x=1793224210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pG/003MQQY1um8GPL5yg2wMvrMwUO9tsXiweKrMHMqE=;
        b=QYIVsVcwTqn+Tm84u/Wn1UR2PGbG6ZIY7wzbBWx3i5oBv38UcswK4Q16So1UmHDgO7
         sqEaR3HaNA02T9sGlxmLSW2CnAurA+k9Fj0/0NYC8w8liFWaNnZsP0Oy9ubDL5dlOgR6
         4w4YTJ5B6lBwNe84Q1sBqppFq8dDtq6WXd0rhBCkUtJnxJZpE9iJm1QMiwBKckn0tdMf
         yQuS1kJUsArsFsOWS6DyzyHc8LwqRdX6gyja2Ei+FXSbRCnhE30ZUa20VEvcIpEl3YMp
         a3hwt/zVjwTKfISAdqysX9P0rdtBV0232oF6C2FmxPVIgtMmewmnaF5uI7cbgBc85c8E
         /fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792619410; x=1793224210;
        h=content-transfer-encoding:content-type:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pG/003MQQY1um8GPL5yg2wMvrMwUO9tsXiweKrMHMqE=;
        b=HtKU8GMsS27E8Y10NIxml7XeREOgnR7fCPoDQXVgezxnK7bCD+EJG6p3TxdF6Z3u4x
         79oxp5TBWI49llj7IpDez3QcrXDSati5lURVUUuXEOszRJj+ihwQQGpnImoqnEh1D+3w
         bDNmc0BB+jY3PtQLUb1hD3/HfvHiEfm7cKoS/n/h40veKf3sMlHa03zZ/cRS6GPYG4px
         v8rFxt5M4ShCufu0uZ5M4fSy+r0RE6mDPDGBk3QngLE79lnBtTqaFI6iCQoSpJB0QRhd
         4n1BhGwQf+YSqVQfJHeOBzv1toX+XWTLRFH7glvM821n6suGvd4NYLie2HAgxXN43Cra
         cUfw==
X-Gm-Message-State: AFq9FYIEOzArVvtbMtoGnx2mk1soe0qTAKeu4YV0tXIGgIZjWv7HXh2g
	RlyTluwxFBU3CJN80WPbI/eb66t9HBZCIQnckLFErn79YxOn/F1qAlFLqSk5bg==
X-Gm-Gg: AYBFou2ZfncgQE7K8O7lvzIouvxHGIH12vfC2HEPl2g5ymDlzCswGi4hzE1n2fBKOXX
	6l09q/oQ9OctK/3F1wG60Q384/XeBNX7jIGqX91dI+HLWNXMNHmpWqTtc84Vzx8aMvrn0hv/WCu
	oKnZX8A4nd9/k3TfAQUUFYcSyp9+m0n6jCrjTqnCwIJwdZCqV1HpOvmQ0iAsFiJaJDMYVSKxWVD
	N+vwaHoEcpJC5LA03hzbbInFuvbxXcZadb2Jrw5//bW98h9ANDcoiFISLd3k3ALsP+HPs+LQWd7
	jLAbJR7sD+Hi6uDRljuViLVVLAsZw6ngA77L2iIp3xKrGa9CzYwaf46QX1N49l809vlqy4UMPPF
	oWJT2XxVL3FOdmRy4bY606X6V0dwvr0CFeFNlzgiu8tFu86Or6oAYDZsTRcANjpxAyaDi1KxR13
	Jh0AUoTgm8zK4ovRp9tdDBz2gpZ55meMtOL7QgmFF1SrhjHJXacLkmkGVfLcn65gd2WDofcTR5d
	KyDCOVF/yNEc9y6x1xtAM0fRwPLlSIEOmMKtPHCU9fujjZKMvLa3Ac9vdg41ab99iYlixGExTU0
	yzvI7ZAIONpMJgm2QDjXjmk3yt5b7Q==
X-Received: by 2002:a05:701b:454e:10b0:171:a066:938e with SMTP id a92af1059eb24-190a7756cc9mr3907227c88.21.1792619410303;
        Wed, 21 Oct 2026 14:50:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e4f2eacsm8395649c88.23.2026.10.21.14.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 14:50:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7701ab76-4761-4596-b6a5-92c74e03ce5f@roeck-us.net>
Date: Wed, 21 Oct 2026 14:50:08 -0700
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
Content-Language: en-US
To: stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Please apply commit ebe559609d78 ("fs: get rid of __FMODE_NONOTIFY
 kludge") to v6.12.y
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

all sparc32 and sparc64 builds in v6.12.y fail as follows.

Building sparc32:defconfig ... failed
--------------
Error log:
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
kernel/fork.c: In function '__do_sys_clone3':
kernel/fork.c:3114:2: warning: #warning clone3() entry point is missing, please fix [-Wcpp]
  3114 | #warning clone3() entry point is missing, please fix
       |  ^~~~~~~
In file included from <command-line>:
fs/fcntl.c: In function 'fcntl_init':
include/linux/compiler_types.h:543:45: error: call to '__compiletime_assert_325' declared with attribute error: BUILD_BUG_ON failed: 21 - 1 != HWEIGHT32( (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) | __FMODE_EXEC | __FMODE_NONOTIFY)
   543 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)

Bisect points to commit 07ee6057f92a ("fsnotify: opt-in for permission events
at file open time"). See bisect log below for reference.

Please apply commit ebe559609d78 ("fs: get rid of __FMODE_NONOTIFY kludge")
to v6.12.y to fix the problem (assuming there is interest in sparc builds
on v6.12.y kernels - this has been broken since v6.12.105).

Thanks,
Guenter

---
git bisect start 'HEAD' 'v6.12'
# good: [4f6f4e5a33282e36228a54085b9fbcac0f386787] ext4: align max orphan file size with e2fsprogs limit
git bisect good 4f6f4e5a33282e36228a54085b9fbcac0f386787
# good: [b6d79102894ac748f87ac9b3903dad8b89bef157] net: ethernet: mtk_wed: fix loading WO firmware for MT7986
git bisect good b6d79102894ac748f87ac9b3903dad8b89bef157
# bad: [105cf16f692e7cff3d2cfc7e1f52b8469c4a1d20] RDMA/hfi1: Stop flushing the global IB workqueue
git bisect bad 105cf16f692e7cff3d2cfc7e1f52b8469c4a1d20
# good: [22f954f7a8afe975e85517aff41b35defe05144b] tracing: Check return value of __register_event() in trace_module_add_events()
git bisect good 22f954f7a8afe975e85517aff41b35defe05144b
# bad: [1a6a41b848455bf6ba2c9da2dfb0730e608ce7ab] nfsd: fix nfsd_file leak on inter-server COPY setup failure
git bisect bad 1a6a41b848455bf6ba2c9da2dfb0730e608ce7ab
# good: [52566c150cadb1a17df840dd25862a61dcf84bed] drm/amdgpu: check ASPM on the dGPU host link
git bisect good 52566c150cadb1a17df840dd25862a61dcf84bed
# bad: [b2a0b55bf613bd3e81ed26a847b0f6b8e6b7f804] mptcp: pm: fix memory leak from alloc-during-teardown race
git bisect bad b2a0b55bf613bd3e81ed26a847b0f6b8e6b7f804
# bad: [0f286458012df6eaaeb6feac03b4bf47c19f1c41] x86/mce: Remove __mcheck_cpu_init_early()
git bisect bad 0f286458012df6eaaeb6feac03b4bf47c19f1c41
# good: [f7ea7dbaf0ccddafa07eb93e9fedfe6ff325f1b4] smb/server: fix minimum SMB2 PDU size
git bisect good f7ea7dbaf0ccddafa07eb93e9fedfe6ff325f1b4
# bad: [6fb118f5b48864a6bbdde5d3afb2c8428c5ca790] vrf: Make pcpu_dstats update functions available to other modules.
git bisect bad 6fb118f5b48864a6bbdde5d3afb2c8428c5ca790
# good: [69d040448067cebdd5598684db36ce7d8fb2f43e] KVM: x86: Cancel delayed I/O APIC EOI handling before destroying vCPUs
git bisect good 69d040448067cebdd5598684db36ce7d8fb2f43e
# good: [1b338ba55789a3fe0f0799c79af944a8c0d69de3] net: pktgen: fix code style (WARNING: Block comments)
git bisect good 1b338ba55789a3fe0f0799c79af944a8c0d69de3
# good: [b7212a0cc80afc260507aaca7c8391a92e51cfc6] fsnotify, lsm: Decouple fsnotify from lsm
git bisect good b7212a0cc80afc260507aaca7c8391a92e51cfc6
# bad: [483217fd6f7ccd98b3ed2531a54f75ed144b4499] fs: don't block write during exec on pre-content watched files
git bisect bad 483217fd6f7ccd98b3ed2531a54f75ed144b4499
# bad: [07ee6057f92a27ee7296f4b2362cb1570cba9223] fsnotify: opt-in for permission events at file open time
git bisect bad 07ee6057f92a27ee7296f4b2362cb1570cba9223
# first bad commit: [07ee6057f92a27ee7296f4b2362cb1570cba9223] fsnotify: opt-in for permission events at file open time

