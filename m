Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.99.196.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795300241;
	b=4vtLHfICE83433Dw2Z2ywHEYIIJRGWKnzs6G2exZshDnXGV9k+M9tTbBj7AhPjTefoC2
	 ztDQfaiP1XTw6t56CSTQ2bWXG4RbXtQeZkFp7DMmtDLsG4xYWSPAUCLY2tbFm0N/WvaOt
	 Ly4p7i7hoACg9nMRbeO1SLzarrx0JBA08LLYlKnRPwfSm+ms+oSf8lELWo2IQzLGk0uXc
	 IWc5vZardyNJ95kBlMUkpb18XBJcCZ3ciryuRqymhO8WsbWFG5m4E+nXJUuhdj/eSnljy
	 tfO1WigofDvKRejgcJZAlSlg52H7adu33tb4neVT3Ev/m9dfIhYIcakx9PeZeaW1hig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300241;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=JoGtzXNX8mE3lqvZL9nk/SscIkHaSe9K3EceYJcW6oU=;
	b=RWI7dC2BXM62DAg2huq7F3XK8Y4dMq1ETYwG+buj+1xCUgniib9agFrlOOuUzlCk1gSS
	 KmLQZD8Zn8gT1AHF+8A6EtgKjG1B0jhLmJBCgxHjh7zGGS30lPYA7DrcRIgNp0d2rua5g
	 BkvZTOk4sb7gCHxuhYnCN2HaIj9a7xqz1vUp7Bdpkzl4G4qqtqidau+hh54zmuVXP1M9v
	 CU/4qAFRLO0nxNznqKh05tgupxvLyFH8o5cgs65UdGXEYzordef1tIbjlW2hCndYZ/P8u
	 C7A28MKUHVLygBLLlWNU3Ld5MUsQ2PUklqE+3robTWFQYMyAPOCi6xOdtrpaQClfyUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=namei.org;
	spf=pass smtp.mailfrom=namei.org;
	dkim=pass header.d=namei.org header.i=@namei.org header.a=rsa-sha256 header.s=2 header.b=yo0oewSs;
	arc=none smtp.remote-ip=65.99.196.166
Received: from mail.namei.org (namei.org [65.99.196.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8698D606A32C;
	Sat, 21 Nov 2026 22:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8698D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=namei.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=namei.org header.i=@namei.org header.a=rsa-sha256 header.s=2 header.b=yo0oewSs
Received: from localhost (localhost [127.0.0.1])
	by mail.namei.org (Postfix) with ESMTPS id 49AFE171;
	Sat, 21 Nov 2026 22:30:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 49AFE171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
	t=1795300233; bh=JoGtzXNX8mE3lqvZL9nk/SscIkHaSe9K3EceYJcW6oU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=yo0oewSsZ6gAINhCLOn50OL4sTg/O66t7BlHx0hoHfqNlKfn5+EamjZvn7hCG5ttW
	 FCkDBTTYsgS8H/+UC37gDbV/fWxCejidMv8Q1T5KShZXFTYKmO0BXtN8FkcwBbQbzU
	 XA5Fp/P8l2Zh1NWesox0aS7dq7+2aieFMrfynyak=
Date: Sat, 21 Nov 2026 14:30:33 -0800 (PST)
From: James Morris <jmorris@namei.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: stable@vger.kernel.org, patches@lists.linux.dev, 
    linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
    akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
    patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
    jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
    rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
    achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.3 0000/2642] 7.3.6-rc2 review
In-Reply-To: <20261120055248.913352689@linuxfoundation.org>
Message-ID: <5154b570-ea6e-ef21-f0e9-cc54fc6bfc25@namei.org>
References: <20261120055248.913352689@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Tested-by: James Morris <jmorris@namei.org>

Assisted by an LLM.

Stock 7.3.6-rc2 (d6a022cc5dc8) boots on a SpacemiT K3 CoM260 IFX 
(riscv64). U-Boot loaded the kernel, DTB and initramfs from NVMe; Linux 
ran from RAM with clk_ignore_unused.

DLDO4 stayed enabled at 1.8 V after unused-regulator cleanup. All eight 
harts came online, timer interrupts advanced, and the supervisor IMSIC and 
KVM initialized. With QEMU 10.2.2, KVM guests on the PLIC booted and shut 
down with 1, 2 and 8 vCPUs, and the virtio block and network guests 
passed. I saw no lockups, RCU stalls, oopses or panics.

One problem: dtbs_check now warns on all three K3 DTBs. 7.3.5 is clean.

  /soc/interrupt-controller@f1810000: failed to match any schema with 
compatible: ['spacemit,k3-aclint-mswi']
  /soc/timer@f1814000: failed to match any schema with compatible: 
['spacemit,k3-aclint-mtimer']
  /soc/interrupt-controller@f181c000: failed to match any schema with 
compatible: ['spacemit,k3-aclint-sswi']

The queue has two patches from Junhui Liu's ACLINT series:

  5397ba147c28 ("dt-bindings: timer: sifive,clint: Remove 
spacemit,k3-clint")
  cc6371a7f519 ("riscv: dts: spacemit: k3: Replace incorrect CLINT node 
with ACLINT nodes")

It does not have the three that add the new compatibles:

  73329198cdc2 ("dt-bindings: timer: thead,c900-aclint-mtimer: Add 
SpacemiT K3")
  c9bae665035f ("dt-bindings: interrupt-controller: 
thead,c900-aclint-mswi: Add SpacemiT K3")
  08257b5b3d38 ("dt-bindings: interrupt-controller: 
thead,c900-aclint-sswi: Add SpacemiT K3")

Those three apply cleanly to 7.3.6-rc2, and the check is clean with
them. I saw no runtime effect.


-- 
James Morris
<jmorris@namei.org>

