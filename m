Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618753;
	b=a7jr36nQW5djXgWPN38kPJg+FakSfFjXWEnoiLwm0KjNQlZ0GZoLGLOLCsXGAKBqyf8S
	 F6PMeyfTCar6e17rIPQ2MjT6lFFkYrDwEIqkp0QI/34hZKV5ENuO+plpxT8iNfBtIBzV0
	 D/stPrlhRlHuyXmeCOq6ulUx7AXJV92SvnykcFRIBa24WNddvxeL5WJOcerF1HqCwnGrt
	 J03xACYk8gE1B99CfTJjCSgkwnF6SS+rtwBEGaWSuqdv3mL0ffXobjPLyqQCINmUwiGnT
	 a3UqhGe3PZFpPrr9gqG57fzJmjcHdeivCyF2pitna8XXLIx7u3PXncEqNuzW5eyORMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=GMrbuN1pF4jHva1q7hR4tCRd4RCYxjzLSNkfzkv12LU=;
	b=WxctQq5RkIBvcYgrL9HArObrgbHA8q7YWL3wuwyd9WlX9xVXGtJYWS4+ONsselNpKTGO
	 /jUp0D/fhLuOLQsWGsUxSm5QKQlIFUj+Mj2+X4AHTh3+kf7mlM/ddcCSnAwhiy8Gv9i1A
	 sKA958TyznEq6b0qRkF4q8xEZRv5gBd0Q716L/xA49E1AA1I9XIRE81eU+qpU9U9Pit5S
	 sYnSmukN5SUKn2dYpCUayGyAl1mZtLztNesUniPgYfCDATiREFgjq/1VggOP8BtOwK/KO
	 ZgB4OZQGQAr2H6Hstgm5eRwub3aAFcXnDd8Y8Zn9NfTcPlLjgICgTKNt+4eA+iY+WQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=HiPHgNgW;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4C8606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F4C8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=HiPHgNgW
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so9761266c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618752; x=1796223552; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GMrbuN1pF4jHva1q7hR4tCRd4RCYxjzLSNkfzkv12LU=;
        b=HiPHgNgWxe8hEhZpeWSL/ibByrf17J4TN77DmPvU1EAWzTy/jTfSDTYxjE/c8grOU1
         n21MgcYB1y42m2Wxg1q0yPB0HX+WcnaRHnQtneTew10xoD4gSMtY2MuIXiGMOtTjfgD/
         fMrp+IbWO72q3gkyNq2nHstIu/4Cstfit7FBdB5Ox+1gZv2tzk7batH/cKSlSRnrMcb/
         VXKknHt4lN4VWY633Qfxuf1TNbUrL1xZeJYKwX6UCC6zbbNZw2EaRRf1eAOoR+Wb8c2n
         OA8kbF6qWTCVbBDaDTMV/42+824GaH5RKvnIH6brDsRm9RRz5qdUN8dOjhqH4mF+eNTn
         EfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618752; x=1796223552;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GMrbuN1pF4jHva1q7hR4tCRd4RCYxjzLSNkfzkv12LU=;
        b=k+Y51uzK/Gzp07bYyxC6g73dWRE/naNV8cCYKWKuVBLqSOq6Z0KRllm3sQvVBbt+nf
         DUJBIyftVm3Z+yEKS0OJUKWOs+kLG4Hn7XQm+p2S9SA31viTgPQHCX5cdEl5n3t5KTco
         yXYkirUMAzT0r/2xeYxc8StJ2KBUdl3rKGWoNTI65gcFNFElbA3IGPVYbdLhTqedLlNA
         nZ3VduDI7NMs9uuxa7wsc6kqpUk7FIwiTjNtgUw8eTqqlGV2zJ1HuPM4jhF8eCPckB9M
         3I1E1FmWeRj1zMQm5gi1yRDVWN6eqFLdCaEiFbxcOMNox2WRB0+MTo1QOdgkl6q7uznZ
         nPOw==
X-Gm-Message-State: APuU4Z/HU83cW/iYInpQF4aah8k42o9/HsPTOuNmvoRCJeHQhH/QU52l
	86iClETLvZ7iSvFfD8LrWDgNm8V1/eqPKTQaO2xi2hNviwbXp/00W5cu0Xbh3Ff8htO6cBWWovp
	NdRYs
X-Gm-Gg: AZFdTZfb6/CmnTYA+Krqum3i9LzZxtK00PJEBJcllty61dBKowQ5QET/XqxYKpHUuWB
	x2+41+ex5/FhwmVZkbqQvLyOYmbEUZl6DJCOISRcXagVvy/pI3mzPtr6zEZx7hxennuwLbvgPYI
	q2dFVWi9pUEJpk/YLvFDxBGoHZ/KLnyzXOXMs4LU9QdVFJsF9Jy761KoKVMIDpGK9rtzGrEFYtL
	Jya9o0UyHYaU+rztG7lOcwD73xqOYtWtUAt/bBq/SUJlh73IJ9x8IiC3AOWmQ8ohXFOkw9iETwb
	AUDtfoD/RuyT1bxDUqgPxmOOTZPnOdYWOAE9C3SIzo1Mz/VJtbjp+7fIASjqdFzZxmL6G9gZ4JT
	qNvbKkiuDxGEeHVE87K4pmq5HUskXqphNndSXNsuI+cQbmPFiZDpYVpmXQ6GW5+r1R5FipBHuX7
	yXAoUocFRNes3DccwBt2MUvahLUUufTfwsMDN6y+ECdg+wxlvjtnon7SFOB1qLFHwh9v+ScF335
	YM27k0TKDfnZXsK9Wh9yyEsMo+T+zKJOoCqVZMQK8OP3s0WbKIMyDVbEctk6T63dHUw/dtLV23A
	h2NjbpWKszGRgo9vhm/jFg==
X-Received: by 2002:a05:7022:4181:b0:1b2:42db:8a1d with SMTP id a92af1059eb24-1b5568c8f3dmr22541283c88.29.1795618751969;
        Wed, 25 Nov 2026 06:59:11 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556829d31sm69560381c88.9.2026.11.25.06.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:11 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build)variable has incomplete
 type
 'struct cb_notify_lock_args' in fs/nfs...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:11 -0000
Message-ID: <179561875066.101431.1493392377635775644@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.15.y:

---
variable has incomplete type 'struct cb_notify_lock_args' in fs/nfs/nfs4proc.o (fs/nfs/nfs4proc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/fs/nfs/nfs4proc.c:7058:30: error: variable has incomplete type 'struct cb_notify_lock_args'
 7058 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^
/tmp/kci/linux/fs/nfs/nfs4proc.c:7058:10: note: forward declaration of 'struct cb_notify_lock_args'
 7058 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                        ^
/tmp/kci/linux/fs/nfs/nfs4proc.c:7062:19: error: no member named 'cl_lock_waitq' in 'struct nfs_client'
 7062 |                 __wake_up(&clp->cl_lock_waitq, TASK_NORMAL, 0, &cbnl);
      |                            ~~~  ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:f9c7a96186c330773c3b7ab59e78751090a3da55
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  dff336abbc2b3923b31da85cfe6cd094c4bc0d48

# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06ef21286e1965ecb35f05

#kernelci issue maestro:f9c7a96186c330773c3b7ab59e78751090a3da55

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
