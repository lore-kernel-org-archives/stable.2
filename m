Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618752;
	b=Mhw8LD8DBphcZsgERClOodRY3Gl6uFzec4MHgUI66xcx0t2/z85VD1Esl5SzpQMpe4zV
	 IFAfqntf3qaI9haPdWwJ/qHrbyd0gAV5ms/Q/K7+m7ZWPljYlRGQv6d5vDuGv5vmuKkwO
	 eJfcYpguIdJMF3qEVGZY9rM38dRuGCwEeCN0FXZeMy2d40zUsx2ewsRcWKWbVrACMsJmp
	 i/mW3ATJG9K53Ip/TL4JUEOGZAEbwBXOgiGjo+AkFI7D2ugxM6TvBrwTM3Q707mK0n6DB
	 JXgHTs8plIcbnaD62Hx/i95RPLaQst1CfbFuE6figJA4W/kAhFnGaq1ZBU+OA67XOPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=7aSsI3GQaZDqbqXuxyzZG+SRg7vK5ys2tZcAxXLSe0A=;
	b=KriDTNpEjuJ4MpJ5DAZxFrIlvVHw94QTqDDdjbJeN7A7M7VqGg7yTwsgOBjRylrCBpn2
	 GVK/FOFZTarSL6YExwtgH8XkKeUsthypQAX4MEDzUq3gy9UwFqNoJPOkQmqvmbWHsdnyG
	 yjP7fEtp17wfBMByXAFLXuUY7Qo5JTPaBQx5MrPER2v6wLipNQ5AlQb/Fvu6e8GXbEr9A
	 Ry5R64ymUKyj8aqDjP/oM0YldLUfAKQwXMHMnRFwynciRpwx99KocAw0r7xKGvRITfAAP
	 BAs7kqgWHCk8rZw6QdsYuEXua3vyhbGkvvbhIcco/qxGR+4nWzNSPnXtDmKc21kx6CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=CSLgRh6R;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680F606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8680F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=CSLgRh6R
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-15ea896ddc8so9761233c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618751; x=1796223551; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7aSsI3GQaZDqbqXuxyzZG+SRg7vK5ys2tZcAxXLSe0A=;
        b=CSLgRh6RgHIFJrfHerA44rEZ6MHwYsal0CFPB9aCAUaQEY1aUo7xyFtmPX6v1YzZP2
         DKytTcqdPbrsFsG3jA6Uoe0rjIGmwFguVWClLir8EmjIn8YxJfKb3XIZnjaTbDzynSk7
         S4wfbqAkezDFlNN/2Y1GF4tJdOfbDidSpBwWtVPZaw0MrD950OI5ijvZs1GQ3riSzMHE
         CHF0ByVaSUYfdCyd6CjRPdL9E+jw2FUJfYsB2yc60mJiu8hOLyGS7tyZYoukdhXLvJgG
         ainD5KhcRssJCVx720FYtQpaZqLLahOJGmkQX69vBv6bwlPTfqjBtfm0HZk1btn+szTd
         /EKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618751; x=1796223551;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7aSsI3GQaZDqbqXuxyzZG+SRg7vK5ys2tZcAxXLSe0A=;
        b=i85ZpioawV+pyghu3150D/MdjA+gIyIi/PbRUzjYkjW03Kz6nRDBfyloFDI/s1dXAM
         02x4Mw3RA+SId8FzgKoD1xOapE2dFOPSLlbkKdOBxAyJUTlJO6v6ZbJziumSh8MM5D3D
         m53fbX20ZQ+H/LRtMpNahcmuI9KdxYRAYWbCCYGmxQgjmhl7YeASiPM3/AXFbVt6Q31/
         zEcq3OeTutMMP19LgH5RkcPULFGgTNfXi2vydFztql/QFdlqybBueKTHp+BccYjQmghK
         pLRbbrVPgZzCXXz7vABefLgZNWhwpvt3jO+qyQceWIg+ako5HCDZYRWeweCocm6SHvsy
         /kdA==
X-Gm-Message-State: APuU4Z+4CpIiDRt5TGGqeZlZ5IWO7rwuPN+OwTFg6iXSkzeOiKfFkeZj
	Ov43MQJrGpe9bk3ZgHc1BQZHDG6XWuh2jzRUpNya8qquy6gfB3tZXmDDC9CgpdbKCRQ6UW8cMSN
	yMpBH
X-Gm-Gg: AZFdTZfSpU30p7hTPfS56UHtobgJV5xpLAw+6DOMUiVaqlvvl6IIY6i45o7ZWT4AQSi
	Q4750eSiT67BjSPPMjz64fjo6fUk2pz5qc+cPO/x4lBPCZTqMcd1O+ocd3DvIBiSCIUNz/fL/7r
	DFClhtAy4Kt+ciY1dG89lAN/hSsvcPCAAGa4uDXP951DYRWjLUbfTXQPtlBNFUS2YiHpSj0IKGC
	M88+jtGvSSoA8zYNp1BrqtIRlbDBP3zXkju6JNZCE3yRK6xtg9uoiFNRvQ9wujMpG7xW7I4lE/8
	WMxnsV5puRJ0XRlv46r8IhgvBB+OGQtj8TRMklovDu3QNW1bBIGgC5PtDNOOs9732Eg2eEnJ4TU
	clBnTzBXqlM2cSNGcuXgr0OtbDLheEkUaRxkh15HRt2Zo0Eh3LIrmPhybDzxHu/S+g/zy9pGNqC
	vcy8/4Sr1UNOGpB+mEX9+G0G2KZHMFdVwPyChFpXkE72E4rx2zZBU+zhfA/l/fXtDoRB5CQZyaR
	58EVKzvp2FW/YPho2MYN9kGXvSV/0Q9PSVx1UBnoFf1frOYfg9imEIVgHnr0J7IEsmlhBztRt4f
	OUw2SCl3ClCi0Gekxb1FNA==
X-Received: by 2002:a05:701b:42c4:20b0:1b3:aa92:b183 with SMTP id a92af1059eb24-1b556898c1bmr18447463c88.15.1795618750479;
        Wed, 25 Nov 2026 06:59:10 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm56717298eec.6.2026.11.25.06.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:09 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)variable has incomplete
 type
 'struct cb_notify_lock_args' in fs/nfs...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:09 -0000
Message-ID: <179561874878.101431.12271523297758053287@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.18.y:

---
variable has incomplete type 'struct cb_notify_lock_args' in fs/nfs/nfs4proc.o (fs/nfs/nfs4proc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/fs/nfs/nfs4proc.c:7331:30: error: variable has incomplete type 'struct cb_notify_lock_args'
 7331 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^
/tmp/kci/linux/fs/nfs/nfs4proc.c:7331:10: note: forward declaration of 'struct cb_notify_lock_args'
 7331 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                        ^
/tmp/kci/linux/fs/nfs/nfs4proc.c:7335:19: error: no member named 'cl_lock_waitq' in 'struct nfs_client'
 7335 |                 __wake_up(&clp->cl_lock_waitq, TASK_NORMAL, 0, &cbnl);
      |                            ~~~  ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:decb6038d1dc259a7bac7bf65fc5fa73c881cd0a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  2a9f2c755feca19315a7f06d3ca477059f4c16af

# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f23d286e1965ecb39e57

#kernelci issue maestro:decb6038d1dc259a7bac7bf65fc5fa73c881cd0a

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
