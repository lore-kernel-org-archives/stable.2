Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076151;
	b=aHXaiEghqH5xrMNWLoP34VVIqHHmrsv+Paafx5okBdmHJYebW4TWELIWZEQ/vSPqDhSY
	 5wlnYSmzmqryOeN3bGjFX2355Icwcx/Jb45L/ZFpWr0xGYepYiieUpjNkSHayVVQ26qIl
	 hWsozN5W7P2M5lT2Dxu2yZHWRPe1hVRRWUEXRicsgg5lD2XrnO/JVZM0bkOVFoijkNzYi
	 zRObgq7nYFEe1YTk0qWo5xaTrfYYaCikIhrQoJjC/+36G961F3YFxctCOcG4wl2z++Qmi
	 s2k3ZWUBVG0I1SltyhTx0JCphl5CmO7mqlb5X190v6xRaX6Y9zEVUTrtDLK3XfGGIxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Content-Language:To:From:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=N+YjgwIoX4f73J3ZsRVql7hx9g3wjHCbxjGp0yS/4mo=;
	b=39XELD2zFYANulnShjGK3Tji+BdJ8l8ZHl7iUnSb9hykkfXtwVMTL99ESCSqUYZwdHKJ
	 gwgZGxZO/trfnVCRjSg+qBbHYEs8x65r+B4fJMMaMbeZSU0df4R0zU8QL4RCaP2bPe+uM
	 QkARcRwyXX4xv+5MfvnZEuftq/+aWUpVUovZNK4gBgRbqz/yR6HG2r4NgaIDzH2Smv8W7
	 6802aNlJTAg8wm7T0C+YZg4E9MJZOtHsYjYaxoEO7a+70N1r5ofR+c7lzV18AkTLEjDjJ
	 sa9xSJMcU3V36yHtXLZB2+qHCsY30YJUqv2pv6FrQRJqsNCHrV0KMDC+nYp/pUeeFOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GUF1mBZi;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EDC606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39EDC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GUF1mBZi
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b86fcbd647so1298311a12.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795076148; x=1795680948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N+YjgwIoX4f73J3ZsRVql7hx9g3wjHCbxjGp0yS/4mo=;
        b=GUF1mBZiNF1OqK+J55vBXprtZfIP+o8Eymoc3yEKhCFSg48FFha7YYaHnvkk50VP2z
         yYqX27avD3a4DAcNSAtlkDrCaqfasX+82rDzToft8fX292dkzrKlr/Ml03nuW0Epb+Xb
         vN72+GZu2NFsPBXkDazh2m5juWwi7HN3pW2HNUv1ZEn/AaFSRJdt+X1WwiyjkHowFycL
         1lomiwklO1Dadtnzqqrd8esB3gAksARhDgDeLG5I6zp+pcbL4JvMcdzKPzdUI5dYbaVp
         Bzp1WQgNzOJ6ewYQP0Qhlx0Wdl6twRZfG0hXvj8kr3LGAhXnJnC+KiRp/VwU2S8tHz+D
         50Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076148; x=1795680948;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N+YjgwIoX4f73J3ZsRVql7hx9g3wjHCbxjGp0yS/4mo=;
        b=W2m5JXDMSMcnQzq76h7MPJ7SVTjgS/yIe86Mjc7K4ddmMlN95AE3uOhUGRRCuwEjjU
         oR6G8Rul6FyIVq2S7mev0+IW6Nyapbn79KWD8kFqQ1mA0SUIs9Zyf5fpX8Ymp5lAsL8E
         5fBv5IvQ77A8D7Qd2u9loNpwV/TUS2dyI7jek6qfDNHlY9BODEyQ8KQ8WCcTjLN7VdqE
         46zr/p+5Wj9W+Hc+TG7TggmN1K+mpMU8QZx+/kamKVNrpjFayRpS8JuzS5luGoXfKFGM
         De6uk5/iWGSuuTFvX79yAMRtrPmf+tbtqkOJMGFaU6ZG0shOn30kjhHwxmODpn15WO0e
         kObw==
X-Forwarded-Encrypted: i=1; AL+hErEjXDbKs49UNfo8l/fFIxs2IvGw6dDBgyy/HxXIggJ455VnUY8hp68nnkYQX2FqufNZklJXonU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lxGcZQ2d8kuDQamh2mKLhPfr6GeFQHkMvh2bCTB8qI2hPMUal
	mcTd5M5mOGK7VRmLrnjvyOZ7Eicta5TjXdpDsjMIV/Ye/MxqWfzmlN/Leoq7zQ==
X-Gm-Gg: AYBFou3KIS/0TlZUQH7TjwCkmgkgLzInG1eWutggStTPY9xr5F/6l6gqPXTnoBF4NXP
	0a7wwqC/LX09JWsTDwQTrlmAPegyjRuBMBE4iVAghEUz1i6jL7AIoIyyZuxou+WCKiSmPIqHQrT
	p4iG/4yPV3xAAORMaTWLVdsdXnFNc+iP9gZE649Uwy4QcmM5eFF4dl0t0ypS8ZXCb966RWbvZI4
	Y2o+SaFsLZx1nZAouAtuQOpioyukbbMEqrdADtQ6Yy1nHZvYtr2s7KCUSfByFellKpKS8in4dld
	UWSF4ScNHAK0Kkc073LcxskgnNywVqE50YtMHq98RL/JqC/+S9SUGUHxw++p03G4Ge1+9Do8yX1
	yTQ9vkQoFK8QPI1pF88oTgItigEFAhUhQnIcECy/MSXe6xETJP98plfWAXmno++VjBXSvpE54Yj
	nALwiHtwAhk8iAWxPK/opht3CGUuR6Oc7GEyhGycZ2tW2otXnhVkl+EcCTKtY4SegZ3sUT2rDeP
	LGB8qxeBrDb3z/CIoinv7IS4owiEjqgASpE0xQhesCPdnsQdOkD19zHWQ1XFpFYhpBzhI/6KA6t
	XrvL4sq8spoc+k8568NFc6RJmx+77ZOhyswf+mp2Ohe41HGC7NaQT0L6sSLt5T+zFlj3YMYcuA=
	=
X-Received: by 2002:aa7:c68f:0:b0:6ba:1355:1b3c with SMTP id 4fb4d7f45d1cf-6ba1fac0f05mr271267a12.16.1795076148377;
        Thu, 19 Nov 2026 00:15:48 -0800 (PST)
Received: from [192.168.11.2] ([195.66.73.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b888ef94a5sm2066084a12.4.2026.11.19.00.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 00:15:47 -0800 (PST)
Message-ID: <81b3f525-0d62-4a46-a0f3-77d54b11d847@gmail.com>
Date: Thu, 19 Nov 2026 09:15:46 +0100
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
Content-Language: pl, en-US
To: linux-ext4@vger.kernel.org, stable@vger.kernel.org
From: "Safe-Lock.NET Dawid Partyka" <internet.jejkowice@gmail.com>
Subject: [REGRESSION] 6.1.192: NULL deref in ext4_mb_load_buddy_gfp() after,
 dropping page cache (__filemap_get_folio() returns NULL, callers check
 IS_ERR())
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

After updating from 6.1.190 to 6.1.192 I get a reproducible NULL pointer
dereference in ext4_mb_load_buddy_gfp() whenever the buddy/bitmap pages of
an ext4 group are not in the page cache.

Reproducer (100% on 6.1.192, 100% OK on 6.1.190):

     sync; echo 1 > /proc/sys/vm/drop_caches

The machine oopses immediately (panic_on_oops=1, so it reboots). It also
happened without any manual action: a nightly cron job (rsync doing
unlink()/rename() on an ext4 volume) hit the same oops at 04:45.
I have not yet tested 6.1.191.

Setup: Dell PowerEdge R820, x86_64, ext4 on megaraid_sas, CONFIG_PREEMPT.
Kernel is tainted (O) by out-of-tree modules (vboxdrv, xt_IPMARK), but
neither appears in the trace.

First oops (from the cron run, rsync doing unlink):

   BUG: kernel NULL pointer dereference, address: 0000000000000000
   Oops: 0000 [#1] PREEMPT SMP
   CPU: 15 PID: 73107 Comm: rsync Tainted: G O 6.1.192 #1
   Hardware name: Dell Inc. PowerEdge R820/066N7P, BIOS 2.7.0 01/07/2020
   RIP: 0010:ext4_mb_load_buddy_gfp+0xbc/0x390 [ext4]
   Code: 89 44 24 08 f7 3c 24 48 63 d8 89 54 24 0c ba 01 00 00 00 48 89 de
   e8 b3 f3 70 e0 49 89 c7 48 3d 00 f0 ff ff 0f 87 3a 01 00 00 <48> 8b 00
   a8 04 0f 84 24 01 00 00 49 8b 07 a8 01 0f 85 19 01 00 00
   RAX: 0000000000000000 RBX: 00000000000003e4 ...
   CR2: 0000000000000000
   Call Trace:
    ext4_free_blocks+0x3a7/0xb30 [ext4]
    ext4_ext_remove_space+0x80f/0x1570 [ext4]
    ext4_ext_truncate+0xb4/0xc0 [ext4]
    ext4_truncate+0x310/0x480 [ext4]
    ext4_evict_inode+0x308/0x720 [ext4]
    evict+0x103/0x2b0
    do_unlinkat+0x143/0x2f0
    __x64_sys_unlink+0x3e/0x60
    do_syscall_64+0x35/0x90

A second rsync hit the same function via the allocation path
(ext4_mb_regular_allocator <- ext4_mb_new_blocks <- ext4_ext_map_blocks <-
ext4_writepages <- ext4_rename), different group (0x3fa vs 0x3e4), same RIP.
The subsequent oopses were fallout (BSD accounting write from do_exit() into
the already-broken ext4).

Analysis:

The diff 6.1.190 -> 6.1.192 of fs/ext4/mballoc.c converts bd_bitmap_page /
bd_buddy_page to folios, with code like:

     folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
     if (IS_ERR(folio) || !folio_test_uptodate(folio) ||
         folio_test_locked(folio)) {

The decoded oops matches this: "cmp $0xfffff000,%rax; ja" is IS_ERR(),
followed by "mov (%rax),%rax; test $4,%al" which is folio->flags /
folio_test_uptodate() with RAX = 0.

As far as I can tell, in 6.1.y __filemap_get_folio() still returns NULL on
failure/miss; the conversion to ERR_PTR() came in a later release (I believe
6.3). If so, the backport relies on semantics that do not exist in 6.1:
   - fast path (FGP_ACCESSED, no FGP_CREAT): NULL on cache miss ->
     IS_ERR(NULL) is false -> folio_test_uptodate(NULL) -> oops;
   - slow path (FGP_CREAT) on allocation failure: NULL -> PTR_ERR(NULL) 
is 0,
     so ret = 0 and the function continues with a NULL folio;
   - ext4_mb_get_buddy_page_lock(): IS_ERR(NULL) false -> folio->mapping
     dereferenced.

I verified the 6.1.192 source of __filemap_get_folio() returns NULL:
<yes/no - please check with: grep -n -A70 '^struct folio 
\*__filemap_get_folio' mm/filemap.c>

Possible fix (UNTESTED unless noted below): either handle NULL explicitly at
all six __filemap_get_folio() call sites in mballoc.c, or add a small
wrapper that maps NULL to ERR_PTR(-ENOMEM) so the rest of the backported
code works as written:

     static struct folio *ext4_mb_get_folio(struct address_space *mapping,
                     pgoff_t index, int fgp, gfp_t gfp)
     {
             struct folio *folio = __filemap_get_folio(mapping, index, 
fgp, gfp);

             return folio ? folio : ERR_PTR(-ENOMEM);
     }

(fgp is plain int in 6.1; fgf_t does not exist there.) For the fast-path
lookup, -ENOMEM simply falls through to the FGP_CREAT slow path.
<Tested with this wrapper: yes/no, result: ...>

Please let me know what other information would help (full .config,
tests on 6.1.191, etc.).

Thanks,
Safe-Lock.NET Dawid Partyka

-- 
Safe-Lock.NET - Dawid Partyka
ul. Zebrzydowicka 137
44-217 Rybnik
NIP: PL6422786434, REGON: 276286525

tel     +48 694 590 047
serwis: +48 784 947 278

