Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B8A347535;
	Fri, 10 Jul 2026 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717412; cv=none; b=VgxiqsP8FjYUrIi9142UBk5MuBpNVZTvmaHCZgJ+YILrhfGZVKDLmTPvcVhviwOoTvXeRIyKCMSbUrfYiX/1dpH/IyvSA+YSUL/DlEVYmzp4N+MfwrGi3TqrLz6Sa1PYD4wgprcfvcMBkfykc8G+JSY+gdyKGIeWioh76Kf1oQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717412; c=relaxed/simple;
	bh=QblUx/ap3+o1+PyVsNXtmBYuaFLSHxR56lIoHGPqr4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlfXlLC7PKPxBxbzbQNehR5fZgdD9/fxCc7heLIF39UA74J0Gy23/PW9oJ91BxZa9d6lJyd04O5Mi3wS58SSGgavybmqI1q069n8NRYxTRVjdcH5BhIhKGXpF+YxB3WgnAIDT4Dlmog4rFZ4Z7PDE5wbsOmHIvAWzpEtwNUCEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uab5EaWf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uab5EaWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCBD1F00A3E;
	Fri, 10 Jul 2026 21:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717410;
	bh=EYazxkYQmUsgPzsmOv8+UJeTiBmiNuPQux5HbSSpMH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uab5EaWfGxTu8hvbuAHR74jr8kom6DNC6kz0GRJ9mgxa2uxvX01WUmvrMwZeE6p9Y
	 XQEGuccb95krqK5z3BHJ+11bMyqow7H7UvnLKUut/XnuU1BbjkkjHwOw8WUkqgcFvJ
	 0/JYMtOWQoZCGdBAGz3T6RrXZPh18tXl/ZZAbsmbU/vMcOAaQjow9NuznopKhnk8ZB
	 jeezivJ2vXimEHO6oYTJTPtORAvuJBitfWcN0QnTPMZSziiVuAJSuCpVMRjoSGxQOr
	 pAa1BDwkQJUiAcynu+QWgwoBSfvJnbpT8jWzWkZqkUlFegZGxxcnvZgLyh20tT3QJ1
	 WSnTP3dTxP8IQ==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH for 6.6] LoongArch: Add PIO for early access before ACPI PCI root register
Date: Fri, 10 Jul 2026 17:03:03 -0400
Message-ID: <20260710163023.agent5-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710122613.1596480-1-chenhuacai@loongson.cn>
References: <20260710122613.1596480-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 10, 2026 at 08:26:13PM +0800, Huacai Chen wrote:
> commit 6061e65f95713b01f4313cda6637dfe3aa5412b4 upstream.
>
> For ACPI system we suppose the ISA/LPC PIO range is registered together
> with PCI root bridge. But the fact is there may be some early access to
> the ISA/LPC PIO range before ACPI PCI root register (most of them are
> due to abnormal BIOS).

Queued for 6.6, thanks. I fixed up one context line in
arch/loongarch/kernel/acpi.c that didn't match the 6.6.y tree.

-- 
Thanks,
Sasha
