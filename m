Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618769;
	b=F0g+AneFahdiWElh39rRslURdMdblecisR9gqATF8gxmwmJ77Y5EnlkPwKRxeNJft1XU
	 H4h6wAaFEy+FHBJvTUWVCfRixRmsJIr4eqmkKyzNn1kJrORRAS2o5RUmBjjbaWCckaUOo
	 jrurTLHOWWfGgaGop7AyW472BL8OyqosARlaNcA4VtfWTLCIUpz6OZONNeTHFAmVzVnGs
	 PDmstJaECk3Cqg8/wXQjYYvxUrz1p9SW9QtwPlM2b0faRHXMSHj8icVW+07mWOzn2afRJ
	 /pTpShZDBYVyfKumIhrPCCDVT3prCPX4PPbtrafPzXBb6u619Ty9gSXrvzcXru0Uucw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=yftkYseYp+VHD+lINKhpQKV7OBmwQ6zQ+fwmCtC2Lyo=;
	b=2FJgpK2kshwInvOqlDrFKrYaCSC0szvnk64zmB1Xs4pEn4s1GrylhF2CEio3vWHU/rON
	 YIbw2/9P3HP5R9WQfbDS/HTR1vCKI0tVlfWwB9jp9yWIVP8WI52h80uPUvvNC/+z3rz3m
	 PxJoMp/AcWK8lF/nwDjI/R9h9rDwGYo09rJlkNCKSM0el31ftOZcEiNZNAO4MOW3WMspa
	 em42/VkWml1gIdMfiEtHyioXRHGNhaoejm91VRpJYBgExangUvR8cH4T8sZ0aSpdW94Aq
	 uOlhJlcxKGGMWmgMySeJDgxcf5LgnFFxBoemSz1Dx30pTS99LDv+sTRnpzQXflWpikg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=F9aYIsvt;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE7606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8CE7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=F9aYIsvt
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-38190551625so11620550eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618768; x=1796223568; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yftkYseYp+VHD+lINKhpQKV7OBmwQ6zQ+fwmCtC2Lyo=;
        b=F9aYIsvtO8clTN84qGUEOygxH36bANv+CuA5SlgOQo1dVP/7SNIgc1+Y+JdHkjMcAi
         jRwM4X3b3R4FhqtYyRPZZqTKmTS9fWAE5ukuFlSZ4gMTf5bQYPrfjbBJFzTsXU30yq5J
         EabCsYYm97cdbKySJcL3VL3Fquvb/5m0QECU9AEAwwLMIoMURlQyhGPU3ifKJjlDNrso
         1VqTCnJOGkWOH1O5G7SqVUrvKcFE3Y2GM81Jp5SPVIXMG9Qy5EApOQzYUnGu11HhhwBw
         nR3U5LtImsPuphZnnMVm9VUpTZmTe1H5hdiNwOSyjj2yJ4g9KGGu7saKLS7ZZh3auV/5
         A+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618768; x=1796223568;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yftkYseYp+VHD+lINKhpQKV7OBmwQ6zQ+fwmCtC2Lyo=;
        b=KB8e56TNC8z7wMPT60Wb5Qm1yGAl1Y6QqLL7vgB1aPZYNC6XLxjg5SYKwgRL8Mb2JM
         e1nWJWBdeoOQ1fbZTqb4LMPkA2g8WM/ebKU5D8DwyhcedXPaVigos0XDxMjqTbuNrXj4
         911aIljeGRyvmXdLfqeVOj4HUVLVKZsyYiKxUQK2mHoBmQUQX3hsIg50W01oK2Krg0t4
         shw2ysfCMJxSisUE8W3jAdf/WEJ3ui+172VXlDYIFsGeN2Jk1z1mPb1GDlhIubMWzFt2
         v7SFvxGLCz+wULFCihhfMZTVJ3ZuQpAefFjv+xJcj807/uJITkw1YvO/JUK/ap/URZj8
         b1vg==
X-Gm-Message-State: APuU4Z8Q2Z3CTVgycXUC4z5Z6RDZyiUNlV4GXf1w1Yy8AE4bX3uKGtkE
	OLygvhA91sUWKblaDpFC82dFQLEGJK400/V9I/WmCNJFeLFdW7rH0HPCDO0xHSfbayE=
X-Gm-Gg: AZFdTZfONE5aSFokQ8UEYa8dKnCZqxAyLNcbdHvr6QGp4vVUDmQ0QxPg7i+yRQs4VuE
	pH++woZjz2m+UojSN/5Q01zaTLuCFxoe15z1MokNZ8hQ+woJx2T8ytNupUbX466KGmfQOu2FACd
	AuuwBf/maZ7LKTlbrwPwkU3IcKl96crX5x1pJ3gMeuaFrd8eqkadkm1xhqMiacK71WI8NYJAczx
	RrqOio1xPMKxjxg+gYkD9BokG1tjrvjie08fh+t8Rri6VaqYVyKqAWiCst3Bsw7Es1MhDg2l9zZ
	qPALLRztutSBCyBL6nmJKRWYjU4Hz5I1Ht29masr0Peb3bpL+0mQZdJDpJM+/3sc4+Ruyf9GOZM
	WNc+U+OFOOiLZDy6dfrKFPY22RtbHvfZnz1Ygw+Odidk19EYwQ/pYANXbZi7xGSacp8ulcQaSbj
	LNUe/fPdlXHs6dbkG4uP4z8q7BHpp27vsPSaByzeqhcU96d+W7l5QzsUuBLxUTFHW1irADmuMlQ
	mcUpeYYKYgRagwNmpSUAIhEkjEimB2wxvKc+t+fRu1n/Eg9nkctSwp1386653a0ZCSCIEQmNYzb
	wmOiLTgCvxqFbHjRKTE/3g==
X-Received: by 2002:a05:7300:601e:b0:386:1e2e:ce0a with SMTP id 5a478bee46e88-3861e2ed1bcmr17629843eec.27.1795618767628;
        Wed, 25 Nov 2026 06:59:27 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b9bdafb5sm21975421eec.9.2026.11.25.06.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:26 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)variable has incomplete
 type
 'struct cb_notify_lock_args' in fs/nfs...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:26 -0000
Message-ID: <179561876633.101431.7087588197599331956@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.10.y:

---
variable has incomplete type 'struct cb_notify_lock_args' in fs/nfs/nfs4proc.o (fs/nfs/nfs4proc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/fs/nfs/nfs4proc.c:6941:30: error: variable has incomplete type 'struct cb_notify_lock_args'
 6941 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^
/tmp/kci/linux/fs/nfs/nfs4proc.c:6941:10: note: forward declaration of 'struct cb_notify_lock_args'
 6941 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                        ^
/tmp/kci/linux/fs/nfs/nfs4proc.c:6945:19: error: no member named 'cl_lock_waitq' in 'struct nfs_client'
 6945 |                 __wake_up(&clp->cl_lock_waitq, TASK_NORMAL, 0, &cbnl);
      |                            ~~~  ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:6e8540c3fe81cf83f523389d20b57875b70c699e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  8e2fb60ab96e45de1da9779df42907b2dd01b85f

# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06ee62286e1965ecb33018

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06ee6a286e1965ecb3301e

#kernelci issue maestro:6e8540c3fe81cf83f523389d20b57875b70c699e

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
