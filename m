Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851952;
	b=VytxI8HYFC8A/YJu6ZIRj8JQvw6F0K3nBOdFn30Crqg9c0zKTBt545+oNyzhn9bXlN+M
	 MBGeMpMfUF66ifD+wvv9gF1W/ENnMie3VC+qaUqWI1q7TgB9iA6qP0Fu+TcDccu1r6adg
	 d3lYo2ssqieK8DL3F9X7itu0SeOUeMHcrMS/Kke0QnKYXjQJxn1Id772Avzcq5rX8I+nu
	 W1ZUZqf1I69OO9fu+c2iAFwuDn21cR55qYXj1fk/7JMhE4qEXF46urzjxzjUw8T3xj36K
	 LU4N65/CD0uuzb4hbXdZ7L0CMLI/41QJghKzezWS2Ns45jvR4PLjxXb2f6UJ35Nxx7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=e48WrKJ3F7BV2+Teyay6xxMrpGMg/AKyhOjzlwGuBqs=;
	b=PNTuTebF0CvTjUS5UlujfWawC9qFqg3S8sGn1H/OVLJyWPzOpXFvObGSOwktu0go1tiW
	 zklacIAaLgd2XGhRX1ZO3e+wHVI/7kL2Ah5/IJOnS24a7Z4Rr5hB7paNUBgJ83+p/6pMk
	 Im6EvFbR5Svc/tI+UxCeRKbflVgYLh6OfKd53oU9XIMOfNTFJxbR6+JVCnYEpuXVdzdqD
	 92QFrBMxF4eDb99GG/f3liOLwou5AII4eLfl/V1OdXC3Qla+151x6TLDWsTZJkjtQigSc
	 aVMKKZeHbeE0SeVZRo3UC62tasqCHarP6Oy4XrrRjBDX5hJqcgtqDC4O+oGTctMCgLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=H5bCwpO7;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296C606A880
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5296C606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=H5bCwpO7
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b3acec6677so5374393c88.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794851950; x=1795456750; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e48WrKJ3F7BV2+Teyay6xxMrpGMg/AKyhOjzlwGuBqs=;
        b=H5bCwpO7irYZIeF1DugBL/7UXkHONgTM4HDROLmxZhr79EkzmkOSq3pxEapEgS0TbC
         pxMbUYq7rSy/ftCFE3f5ffptHc/g0FtSYUCiY60p6HFfOxYsHilNZ+GlyovLuQ7BCQVc
         16hOm4zvb3+bdNBXX9dpj+2V02SB7mBFmJ+6qnaE0ALDJnKtVc2yub7jxs3YJHBjMzqw
         5eQEVcmMLpY8QdgSjITagteUiC6jmX0J4C+A4/ptI+4jBdAA2Gmba4M3AtnZmZQ1N7H+
         ZxlRSdNjo6DBH2UJ0RilOn73W4gcYiVorkp87fN0AK96fSvp0l1VypcL3h9NOdpLaGLy
         fOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794851950; x=1795456750;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e48WrKJ3F7BV2+Teyay6xxMrpGMg/AKyhOjzlwGuBqs=;
        b=mvwY9zpMgsDvPB6omAgfNvdo0DqVlhumezidygEYZgh4Gx7Y3ZdnUwWtMM4EWKwYNE
         ga1tF0c4ZKKKqgFfqtzBiWKIUXWugSRv0PAKqEf9C5e2kALg0gZapJWCvn+4gpAKoXbD
         BQjWe64gifTFQIiwkYpmfYuBTxjbZIkWXGy0Mh28KeH3a81lB1D7tj67UL+7S8VcNdw7
         yDp63RSVKB1bTCzTMmS5X9Md4JEeoWSUjSLN3Q9ZYOpBhh4gjqiiy8iZvIxPmVW084Hh
         L+sLuTtXto90P1aZk/NHiWOipVrGR6F6d8JCLoTHvonWN/5evKHMVbrxpLYBso/baqDC
         mh4w==
X-Gm-Message-State: APuU4Z+pzXXeyHWN9pznWuSp1o9APbJh8bLLTSOOYaqhSsZw8FpnMIJk
	prvWyfgrermq2k5f7ANVunetPiXQ2cpJJg3MHEDy1D3UVOttvbCjCvURCBFUhsWT0Ug=
X-Gm-Gg: AYBFou0hc5xpfNtafS/p6xRmpnjQtbRYukz9p6kUbF1Zu9ihOj4HLWbQa/FhBfb0Ykg
	i/snraHxEZui+WN+OBn9uEaDbS7oeC7dgTRuaOrfYBciNooTGJ7QDtbZUKJ/a0wNUgwQvZyhtLT
	ms+8ITgXLj1muEnReqA9B236RB229d1cATBPzxw/A4VTP/8mUhsp1M0fu+UyCWrjIXQCOnIKWOH
	TirMPCZ4gKvBAvgjE1w05IU5bFNVzQV23CfdWCiNWO8e4DlOgTl1k0fLQghB6YBO2oE8QAWqLdL
	/94iGFU2kZnuMTHoPwg08a1rMLOlfNjYST2hukZkfIEC9uAyery+Tk4O8rOTIyLz8FJeyaSRcBY
	FMQpCgrbExHGIlDryx2GsX1NdPODBZ4sTufmYjaUficZBIc5ayntgUEcrTd/w85Ic1LtpG3RXwg
	7YFiqAKJs0a4lNPB/yPV33VdOoqzn80V3+x6jj4uV5iHdUfH4OVS9/mfM408hd50aS4H5a8AiFY
	imFnBLJWycJeLcfcUnIB81k+It5+Oj+MgdxjGp8seXGWeVX7nSXSNrDUOj2efTaDX6N1srep96Y
	HPoHggoPAeA94QQwRinA+A==
X-Received: by 2002:a05:7022:b902:b0:1b2:4cc7:7db2 with SMTP id a92af1059eb24-1b503175e5dmr10656247c88.47.1794851950335;
        Mon, 16 Nov 2026 09:59:10 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e195sm38391570c88.8.2026.11.16.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:59:09 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-7.3.y:
 (build)./include/linux/mmap_lock.h:604:20:
 error: no member named 'mm_lock...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 16 Nov 2026 17:59:09 -0000
Message-ID: <179485194914.205922.8631386140753678@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-7.3.y:

---
./include/linux/mmap_lock.h:604:20: error: no member named 'mm_lock_seq' in 'struct mm_struct' in arch/x86/kernel/asm-offsets.s (arch/x86/kernel/asm-offsets.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from arch/x86/kernel/asm-offsets.c:14:
In file included from ./include/linux/suspend.h:5:
In file included from ./include/linux/swap.h:9:
In file included from ./include/linux/memcontrol.h:13:
In file included from ./include/linux/cgroup.h:17:
In file included from ./include/linux/fs.h:5:
In file included from ./include/linux/fs/super.h:5:
In file included from ./include/linux/fs/super_types.h:13:
In file included from ./include/linux/percpu-rwsem.h:7:
In file included from ./include/linux/rcuwait.h:6:
In file included from ./include/linux/sched/signal.h:10:
In file included from ./include/linux/sched/task.h:13:
In file included from ./include/linux/uaccess.h:13:
In file included from ./arch/x86/include/asm/uaccess.h:12:
./include/linux/mmap_lock.h:604:20: error: no member named 'mm_lock_seq' in 'struct mm_struct'
  604 |         if (unlikely(!mm->mm_lock_seq.sequence))
      |                       ~~  ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:a908861783f8fe2e891537eceda60c03815d1eaa
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  2a640ccd9d0b0927413e9778fa8970767b7d97d5

# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-6afb3c9799c74e1a996191a9/.config
- dashboard: https://d.kernelci.org/build/maestro:6afb3c9799c74e1a996191a9

#kernelci issue maestro:a908861783f8fe2e891537eceda60c03815d1eaa

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
