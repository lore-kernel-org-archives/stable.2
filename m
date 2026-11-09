Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.99.196.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210623;
	b=paWHMHFJWE5/EkyluiTYE2Ag9mCK3ollAtfpYukh0mQZbWTQtlt7r2UvtVn/PXpBXcre
	 2oneBW1wZh+dHWWIgSZKIeR2b5WkGhkjoy2P53TmUROlrvkQK6V0Kfpqv61eyb2UAB7yK
	 8ZYmfAwTxizh/V2o3AAdfpfQOG7THbdCdCzUa8FehtavdEuJUIrsjRJCqDkJEAGo2HU8e
	 9/V284Lfj/jc3RnUlignBk/4uM51Pg5zx9hqwwVWYWWc0uKGflYsFbkvkvveiLRlUOK08
	 UTweZpgWYzmTjZ+NKk2cc7AVz6ndRrbQrV6I52Kv5La53gEUr+/l3OVZGccbjBdgNLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210623;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=FfVfXKB4UwJOvTzIpoGIW/5MDy7wdA8hCv+2HC7E7rM=;
	b=aV/deBSqsMvT9WsLXOFV7vkD98BzVbTqqHul9DHOgpP7CoczV11b88n+09HPDudL/IlO
	 PveHV+w33kNvjAEdVv9DjSVZImOdM+G/ljwmYPlQRbj34VH7qxlKYp7nqtEe3s3ukFW9U
	 BkyuBEXxs2/315hyX32l7eHM002TP4JrRtQm4M4Viubq4xI8lE2unschREgwvkDHCjIKT
	 dMc3QlGuF66hVcGgbUCpT/DRAjRNo3x2263QNZ2nMh0vZ0tttqd1XqDWFYBK0wsdHnWRw
	 U8VdgCf/s6cVSWrexO2qgMfPZ+xOWy97kvdXBFPA4x/+q8zPSoEnEeoSgnChcyBgcTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=namei.org;
	spf=pass smtp.mailfrom=namei.org;
	dkim=pass header.d=namei.org header.i=@namei.org header.a=rsa-sha256 header.s=2 header.b=llOAJIgb;
	arc=none smtp.remote-ip=65.99.196.166
Received: from mail.namei.org (namei.org [65.99.196.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B31606A321;
	Mon,  9 Nov 2026 07:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1B31606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=namei.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=namei.org header.i=@namei.org header.a=rsa-sha256 header.s=2 header.b=llOAJIgb
Received: from localhost (localhost [127.0.0.1])
	by mail.namei.org (Postfix) with ESMTPS id 44C982FD;
	Mon,  9 Nov 2026 07:50:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 44C982FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
	t=1794210616; bh=FfVfXKB4UwJOvTzIpoGIW/5MDy7wdA8hCv+2HC7E7rM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=llOAJIgbI3V5UyyycoFhCmxQwROPVnsbKhAaikUS7I/FEelUeLEtTUriwPopJdlWO
	 bxO/T9JQ8KcBuXGr9I34nfDaWkQ5DRmMpwn2Sdsgv9Rj/eL/UVmFwavcoRqf1WYtqe
	 /eyrqPFCRJD3pL1Owdm8AZ21dBX3PYMCKXjpmAjo=
Date: Sun, 8 Nov 2026 23:50:16 -0800 (PST)
From: James Morris <jmorris@namei.org>
To: Yangyu Chen <cyy@cyyself.name>
cc: anup@brainfault.org, atish.patra@linux.dev, pjw@kernel.org, 
    palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
    kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org, Jason Montleon <jmontleo@redhat.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix G-stage page table memory leak on VM
 destroy
In-Reply-To: <tencent_C8B170AF63DC42F81A47F9EA044BB4B11C09@qq.com>
Message-ID: <81ddd9e-791-9ca-3f3-f8381c785cd@namei.org>
References: <tencent_C8B170AF63DC42F81A47F9EA044BB4B11C09@qq.com>
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

On Sat, 31 Oct 2026, Yangyu Chen wrote:

> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Tested-by: James Morris <jmorris@namei.org>

Assisted by an LLM.

On a SpacemiT K3 CoM260 host (Sv39x4), a native port of your reproducer 
showed about 16 MiB lost per VM on Fedora's 7.3.1 kernel. With the same 
source rebuilt with this patch, each run averaged under 0.1 MiB lost per 
VM (130 measured VMs total), consistent with noise. Both figures count 
free pages held on the per-CPU lists as free.


-- 
James Morris
<jmorris@namei.org>

