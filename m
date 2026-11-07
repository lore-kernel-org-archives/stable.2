Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067152;
	b=rjj7/2t9+enZ3L7uP0zfrpdZKA7dOVU0SjBPp0tnv+VpvyRqNKk5rgYDVh+4VqnihYBA
	 SkqBFgTQysXjw+oJCCQWZS133KrcobpR/H+lLOu5siyTTDCUPG4b4gVU+7D4CayAs6/1E
	 TPH/UUR4TsoMCg2lEhWE2nZauwo44fmrXq9/pKUNN2SokQrWgDSrPLlqHSPjsYSt2c0wI
	 dEZ7en6S9PMN+5CwcsGkwimrkAR+0Rd10/f7yjMFkBa5zBMKdJFvULfvHi407uVfKK8pY
	 6lxEJi39l5PVYvt3CT7feRI/Q9WAIKdG+YsegJBL7fekR8UD496Lsg8qR+Mk3yYQfZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=Ak33MOCzItuR6VF10WzkbIPxlmjtzf/BGtPBLjZ0+3U=;
	b=jEtY0zW50Vc2A+mRIMMThT5I+0GybhM5zdGhlEoxGSH+AbGhRhw0kpk1on6BPWiuBFoi
	 YccTtPlEkUGRmVWujHbvP9WirgevYKgDfseOLiGwVPpNyhQ0+iB1z/cgbZ4OFkI+HzFLu
	 YjKJ40lyztgG0ZQso3ZaLmRekPxYgkGNcsCqBDD/i+WL8Shykz/UNnw9zuXCA1/AHBQnj
	 R1BVd9lJFxfbqHrFHJFaIFpJH6UGPn4At2c38hOwtRrfHvRHHqPuur3o9OBgX7Bw7k3an
	 0hB39W7Zkxj0YC4zyHgYWwizwjlUTFMNtdGVwqLLJyjTwzF7XjcVbLdbhAonivx7Lfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=ZybpfMli;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388FA606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 388FA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=ZybpfMli
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2812475eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 07:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794067151; x=1794671951; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ak33MOCzItuR6VF10WzkbIPxlmjtzf/BGtPBLjZ0+3U=;
        b=ZybpfMligYKo95HLSp4JC3lOKe8AeU1NVPSEBwqPCHLdVBrXOXi6YnefLcflk8XmUO
         eQknMJFgQfQPlCO2ADUKI6AaafnT93SmYSFsISSplBX5o5mTcEceF4umVbiRk1EpwLrh
         Ehz73NmkrQAHx9vDEYaVtamzbrGe2mXTJvtoohkU1bbUxg/o7ZrOj8l3h0vteGWzZhm2
         oyZuust7UJRrhELqdPUR+ndMvT7oUC6e5R0l4g/Lm18X7NPK8uA0j4969gCxEH6vnCIQ
         trnQKaeolzWOfLUuIo5nyFK8JEzjSf9I/iPuHZvYArCOWnpUARAb0/68AkZr01aaobHG
         tRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067151; x=1794671951;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ak33MOCzItuR6VF10WzkbIPxlmjtzf/BGtPBLjZ0+3U=;
        b=GqBCt6hOlIEycOIZDtO5TdY2yq/qy3Sb5Bh7ZGWZG2nL6EZVvvrw8e46OoPtdlRo6u
         jx+MFbbw2Fovtj8e8rmshlSsUUfvYAXI9rJl8Xti+51837WEWGHGkSYXonLz7eBmMHkc
         qB4FIbGTAbVS2yMzywQfcIm0ColRptt49wIajwvvgKrCxoqvMGFqmhE0YzV/uPvAHNKc
         NjMXnMNiyMUSHJcxU/Rb5OtjfZkHPm9JtS6jVSVQjl4swMKwhc5WRiCC1sCt5hIJfqRX
         hp72MbYtr+/obj995hXd+OMfAVQ4iNmyxBVtRov2hyNi6vq4NMmEf9iIR6h2HV8J+L/L
         F3ow==
X-Gm-Message-State: APuU4Z8IsCpFfy4N2pJXq0zn0rVCwQpL751NaDuZZuMfZctnzf2XFDiQ
	Z3Xdv3KJryMMIbQm4u9Yo9dmUCxjwuIRGHgHzV/NvVL63kHyo2ZgPqM0CiKrqVOPr0E=
X-Gm-Gg: AYBFou1gLfPhhrUjklHi4N0fhcpWBuuRIbMyxIDrcm2aBvuzPXlx5R9IMVQRpEI6sna
	QacXns47N5N0kQ5YUPAm+/B80cfNrI35zWpwW/os3C8cIuwbV3OfVM0i+G7cVIny5XJGUUBwieO
	utYrjlMgriBaOGGNp7VydX1QALUeOSHbU/g5MoTy1+iOqv9LmHtWxpmQrO4qY6x6kxT6cQNbz9V
	6N6Srmps0WN3jn/eec1ATZWqy9+B+7LRiphVVNf4r0q7Qk8Vm1nhUz7hFJIE5/T+SutA1ZoJvWz
	gJvM+3QQiTLp/8Hq5Bo8NH+sOvdAV7zCq964+aOq8oMQUR82heT1RXxJ54qzMWcYoMWlYqZvA4Q
	ppK5c7f2Uy4FmIzYHZ1oPkuhVu+Za+f9yDJWSiruQaNAijeEVgMSE1qB+eeZepi/fmqFSz4w3Ud
	WHkP622jrF7qU0VTGpcPOR8kSWD0D5gvLyXDCi9ueWB8PpgP7EauZOdIGKg+PhNFUJ11fN47KME
	7PxU5QG6eaL63KTUs1NvTl3hFytsuqct4UdZtSMvoK9qlk031WI57JKi8NQy7I6OVAnhXspRjyi
	BggONzimTWTljPbEcPJNAQ==
X-Received: by 2002:a05:7301:648d:b0:36d:37c4:3759 with SMTP id 5a478bee46e88-36f76428495mr8468626eec.18.1794067151211;
        Sat, 07 Nov 2026 07:59:11 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651c57asm18130372eec.2.2026.11.07.07.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:59:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)'linux/cfi_types.h' file
 not found
 in arch/arm/mach-omap2/sleep44xx...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 07 Nov 2026 15:59:10 -0000
Message-ID: <179406715007.479450.10240371758058533623@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
'linux/cfi_types.h' file not found in arch/arm/mach-omap2/sleep44xx.o (arch/arm/mach-omap2/sleep44xx.S) [logspec:kbuild,kbuild.compiler.fatal error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm/mach-omap2/sleep44xx.S:9:10: fatal error: 'linux/cfi_types.h' file not found
    9 | #include <linux/cfi_types.h>
      |          ^~~~~~~~~~~~~~~~~~~
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:dc563ea803d634375962aeb838b35e5e3164eb50
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  7a87f3505170e2196b67ec5e2713c06767ef1601

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef38bf5b429d354e114ed5

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef38bc5b429d354e114ed2

#kernelci issue maestro:dc563ea803d634375962aeb838b35e5e3164eb50

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
