Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618763;
	b=1UBlO90474Zs3aU6X1RLvdk2jcf2iK/P68UisQQ691eXIW3/sEH7M4sZwZZzVaEbEZs9
	 /heebGZQlWeJ3jioWP+B3SBOOndbDhNV65RRmwseZyuM94PHc35v+D5iWR4UNR2wRM9w4
	 UN0H9LWkaw9Qai6yF5XznoEgtcwXqx52hvUytemjeiVG4sYosQsIbAO2scaCvjI6m0iYq
	 ooR6wzZf4a3/6c1wW2TfCUuoNNFGcUzoKF+lmDumOn8koMm5aAhvcaIJ2oegXb7FSM5w7
	 thXBp76KoFyAu3a3nCZSsbiUCStDcRth+Kvq+sfjQ+tO9yqCphdSFQftk1kQqc3KLZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=g63YXZJKd+GYWMKphlLDpbRMeHw6PEdOteIjYUIcr/g=;
	b=C/bWfteDhvqQF96IzFFZmLdyh/Oh9U+/2CS6lXBp6ymzX7Rb9WhncAw6kQpDEABcxdOG
	 kMNRNJBsQli2+p/6E2hgAdofq3tfXCJknSlNo8D223RcnGdqtnDYYTzV3L1I0Q7vKfK/L
	 3tTJLKwbyZyz25nCzo6fzAdBFYPP6+CXYi9TDdAKUTKOTGQNOYcRYGX6CGqNBZGuN959a
	 JtUj6Kyxbbtune/1d9oWNRBRAFJ0Wj8jYE0eGFJ8HTVEn0YQX3bwUprEgQVQyui/A4YPX
	 vDRONteD7TTcAXo/6iMDKJ4UEGPaL58hAF88HuMDj1qlxK+SkcMvvS+27wq9MuJA/Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=XwrRQVhJ;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE99606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEE99606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=XwrRQVhJ
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3863db981d4so8199320eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618762; x=1796223562; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g63YXZJKd+GYWMKphlLDpbRMeHw6PEdOteIjYUIcr/g=;
        b=XwrRQVhJrbq7KzRuEFnpAvEMuuKvdVb5+5RebDrCoLK3Zb7ZUK04yQDAqfFEcK2h5F
         8LRTpzWitu3iRq8cakya1wwnJF75id/A/LCZS0i4a+RiE5VQPtt87Wrg1eNb/0bI8bLq
         Ku+qwZnF7JJBcMtlzlwbLu86L559KpuhrLT7m1xLzZEKeeIhe0ZJ5x9Pa83Ydhf3thQ/
         bPSjuoWjG0iQTVrvtsBKiqoEh+HNWMyhoDz1m8nRtkSynZtDq6Sma4horkuX9TOrQ6TH
         ZB0uUtZWvjSLB+YHLkKw854GXnbIna/L+wzoBN3eBTSa6sTu0Pac2nt7VLeL0TFvkj0M
         OCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618762; x=1796223562;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g63YXZJKd+GYWMKphlLDpbRMeHw6PEdOteIjYUIcr/g=;
        b=gm7Ux3ozwzxXwox2JwpTFYSTtGCHMPd17U7XUmrfA+e7AMmnswg92hCOZ+WQOpNBnv
         IEGxsmghTAZUiEfFCFMLwp5wYl/aisnmpqjt4PoMZjMGCzVmeYZPRFeWreaadoGcd1PM
         NChCpkLhyl5oIiBW6kulsBBzuFfAsVV8YNgMc/6xFo1x3qc5mbbIiiCSv48Ac6690Pu+
         7dyAaIk10Shf90TQ4OB7kAFevuCI0Jq8nhfkk0cDizeFbpk/MNrjjJwXCCn6BHURJuC/
         tc76ZTbMIa3NT3Zhx+7h+0cq/lohc+4UtnckmvHscc2glt7Co1ThcbUZapp0ms/4QXPk
         eJ/Q==
X-Gm-Message-State: APuU4Z8AHc051DjoYEs+M+T4dRuJnA035nWBdfmFoyJW3E4y0EpTOhxP
	ZiTQVGNCujjnOZOJqRhlnHhh1fWl1bGWIN+sGsswRjW2gxHV9Io7YIBG0hJ3XAZMIsw=
X-Gm-Gg: AZFdTZfz7k9QkWCDIK9HVg3ijsvj1plOwwe5duJ6qju+/K/0BTqJMGRjcs2k//osyQh
	5HNVBe8IkTDwFUF38lFjrKRonDmkmKQu7YYQXjwregdB38AlPjo0+jmhCjt8bHeG3rRPjUScaVt
	XHLlIi5J5bvPoOPA22+Fvhsnk+mXrSfiTlZr9u+hesAZO/10dsFP8wViuEBRD+ikGG2vNFk0T4+
	JRBMJ43B4/6fEdGcUYkC6LLFot5ZWvpXWaGJ6GmaVmhk5k0JINK20bGxBYX4XIqtuE7dtmdl7pk
	j8xAC9iGjii/HhkL28f0tDDUg4GSTKj/xrkh2fd0Yee9qyJaAj/kSReUOivmGjMwzT9imL/ULAS
	yq2Va3q0Ka4RXBlzNRYiOHNYKPMEW1L1VG/9Vi+Mc+h6Ko8iU0wUWDre6XTF5ojuoWXxfatl8FX
	xtofY9yMO4mzdAGSfo9Y/6zyqVthXmA80FVEWFdN//efyss8E64/Ag0ncWRIBI7RP9++6UQGwmN
	pTw3UKhppp9vKG3+sIR6J5SocXOwiPhTVGW3EaM0ZZ4kgMWI4xc5dLMtr3NiPAuab7eXAz4IESN
	nL2N6YOBXsPvFbhQSYGPe7sQiPdvl8urjL95loVFGjQ=
X-Received: by 2002:a05:7300:1c1b:b0:386:9d31:2d18 with SMTP id 5a478bee46e88-3869d313208mr13256948eec.0.1795618761696;
        Wed, 25 Nov 2026 06:59:21 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm49162216eec.20.2026.11.25.06.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:21 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)variable has incomplete
 type
 'struct cb_notify_lock_args' in fs/nfs...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:20 -0000
Message-ID: <179561876062.101431.9174804913227045551@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.1.y:

---
variable has incomplete type 'struct cb_notify_lock_args' in fs/nfs/nfs4proc.o (fs/nfs/nfs4proc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/fs/nfs/nfs4proc.c:7113:30: error: variable has incomplete type 'struct cb_notify_lock_args'
 7113 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^
/tmp/kci/linux/fs/nfs/nfs4proc.c:7113:10: note: forward declaration of 'struct cb_notify_lock_args'
 7113 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                        ^
/tmp/kci/linux/fs/nfs/nfs4proc.c:7117:19: error: no member named 'cl_lock_waitq' in 'struct nfs_client'
 7117 |                 __wake_up(&clp->cl_lock_waitq, TASK_NORMAL, 0, &cbnl);
      |                            ~~~  ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:007286aad686824b461d401bffea148838dc317a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  1c9c007d0246db7a5d04105e86069fe5ba06e01a

# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06efd4286e1965ecb36338

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06efde286e1965ecb36346

#kernelci issue maestro:007286aad686824b461d401bffea148838dc317a

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
