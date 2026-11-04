Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833151;
	b=5qXFBIQk9LXt+j3bi3RwvX7YBIXGKK8m4jIKi9e01dm3xXkRqxoThhWHnq+zF109zSxZ
	 gRtWTzGo1HjCkIqNaEdXZNaRRqVLE8m7p2nTsuQPcE8RXgnEHOBiNEYlxyu2qABe4vGAt
	 86diYPJYIr3ITNGmYVYOMTd2293+mOJ3+KWLLmKAbaRkXrkA1ZqZXLIZIrPxFgZWgdF98
	 ii1kzEu1a6ZXUtBRUxaUxgNT9KJ7q+IXX5FhHVrhXAOk7Kosumzo+MTbRF4kNa+P+rAQt
	 I6ODjcIAs+NjrTXpwVGxzmRbXmjXdzxuRBh/kJHIDrrwMU4PEcKZ12+3hZhnTz2OB7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=0F+SiKVCDAz2QLBT+Mz4MH+FWDqgzrGn24bTvDzXtoo=;
	b=K+mbeMZ6Uu19vFoDNgTEp/Nn6yAyW86vPXzOxaCDY4b5wa9rekXonW76/VLOTijP3hZ+
	 W9pcKakyhSbfb+1hzwTDu70oWwjy4YCV+Vx2AvEU/SKhhMsCqM0/kqiNOrq/sk71GpPyb
	 TLeuvDlNUnlNrIVhnoZDkiWJvC8k84tSqMFnY9er4KBhM1yub0G5doeloLWOe5/j6U+cG
	 KGnx2oaZ3R/MelMtwybFPAxRE/Q1NeCHCzN90EpIJ6YQEWSte7+6hXQAYgL8CyJiQiHli
	 KCeSvyVHrT1nuGWRZZOrZ5ysaEfIkCQee+JdBPiWC/Jkm5eWqCKrEN9pK7NObz1q1CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=P7r9CmEa;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4E606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18D4E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=P7r9CmEa
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a3c08d6928so1962920c88.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 14:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793833150; x=1794437950; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0F+SiKVCDAz2QLBT+Mz4MH+FWDqgzrGn24bTvDzXtoo=;
        b=P7r9CmEaIy/HOOEHYn+mDJim8FFlSEmPPvewCEeUn/Y4CtyerMrQ9zaclPPbWzPWfb
         nxXq9L1jISefFOzlIfYbSK9Lb212bagZzkviwXfWG0vC6XC7GTASxOel2OPV9NToGyV/
         rGSh9PPAQrimFTQl/HygIOkJA+Z9HI75D2TE+SWm6ZJ+xet3R5i5LYLEPouBVWI6d089
         wbHOdcrk9V9tyCx8rLLIdsfuVPOEJ3Nh9Wkw6ezwn71akVxsY/RALxV/ElmKbGU663zM
         L7VPLMOEwCcrw6eTtqsT1NtL9VUZiP6PiFoayXaE4DNmRHFB+wZoHJt0oG3uOJQLyJ26
         Nqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833150; x=1794437950;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0F+SiKVCDAz2QLBT+Mz4MH+FWDqgzrGn24bTvDzXtoo=;
        b=BpXrIE57HObe5pfphfM1ReJcgj5H/PTJwjKsTcnp6zc8n5f0FJh3z/JKmjyrTIPiZm
         xQ3HJxyjR/LOzC0uvgRUlCJ/wQ4ryi6Fvc1nmXXlMZZ8dm9nu/OWlGqDcfQvJjiWJZh5
         1Vuk8soHLGQcCNqbvP2N3aXcJVyXPjvjy3uYCwWso8oN+jaBIHnx+5MP41/816rkXvhO
         PVdyTxnbw+bcUY2hahkl/rxe0DKp13SZtjHb+UP4pFz9ASwUnsmcRWMFqsAGByHP5Xy5
         c4G/Q0uNtspKN5pfXjKX4038ay5+9bCrEoY+wHtcvkdHm0jS9ChkKULD8/nAc8kh7HPS
         T3qg==
X-Gm-Message-State: APuU4Z/17ssrwTM1x+rZ0RNUyW3yFqfyvCgDLE5VJMY+BCBR3PcXYnvm
	RlzKy5iYU8TbHkAGThr2RX2WUcn+gCpo9OkZnspCF9BtTi69tVFUjpGqZ4xUOVLNosRdJolT7bb
	GY25R
X-Gm-Gg: AYBFou0ZYyjw02dFprpLAvH5yHg0ROmii2PPAxpgCyM2wdzq6nRkZD237ibrvcjwyvx
	ctSFbOwnlG1KcuK6F/MFYfJJTIZsACCLVsdho2czkK2x8gvESkVGcULAnRI+RVZkrKArd3hVr1g
	3EcPqXyXrOluaCEPoXEktOrij+jm8tqopwkEB92o/uPqrZTYKkfUZBSWhIs2qSXejBfg3ri6F31
	cxNy3PTESVNVFqR2QxB4JBV2FLzsRb2mYZUaLjJRS/CvfkTgIm16NY6h6JIVv3HhMi2pcdCM98y
	Seno6+H0F9FHgvTZo6J26FaKZ/xu6pKrusX+hRm8UvmRSBaBY2D/3TxA6S9vsSU1yQF1BgXB7JY
	iQExM3pdON5x/T6iEmEeorgM7WXwqPYyHXreVCpGAD06aeTkjxZGOEJhJNfu1z0nB7+LbG1BTDL
	AZFO+uSV7xKHZX6wLiR4ztcLQ01vpbpF8BTbWjj+MSw7MR2AkWRODyWJOS9rTy7uGUztRiRzhp9
	EoQn6xWVmEdfnWqST/R0nkwXaHxFtucJafQXLnRbA6PJJIvaRbb3TOlKhtngdkgaARZ0AUevorS
	sKJC9riVTs8aV106GqPq4A==
X-Received: by 2002:a05:7022:3f0d:b0:18a:8164:ce4 with SMTP id a92af1059eb24-1ac4fb0c60amr26641057c88.0.1793833149938;
        Wed, 04 Nov 2026 14:59:09 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2c2ddsm10446932c88.10.2026.11.04.14.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:59:09 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)Error in
 /tmp/kci/kernel_build/tools/bpf/resolve_btfids/libbpf/stat...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 04 Nov 2026 22:59:09 -0000
Message-ID: <179383314867.333747.13851639069793568592@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
Error in /tmp/kci/kernel_build/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o (/tmp/kci/linux/tools/build/Makefile.build:97) [logspec:kbuild,kbuild.compiler]
---

Log excerpt:
=====================================================

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:a73de78c5fb458e0343bb3c2bc750de889e19361
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  7bb6899c97e42d33cd49ada817664841dc972f3d

# Builds where the incident occurred:

## allnoconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb1a25b429d354eef1cac

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb11a5b429d354eef1a50

## tinyconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb1ab5b429d354eef1cb9

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb0ff5b429d354eef1a36

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb1a75b429d354eef1caf

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb1915b429d354eef1c9a

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb1955b429d354eef1ca2

#kernelci issue maestro:a73de78c5fb458e0343bb3c2bc750de889e19361

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
