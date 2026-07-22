Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CE2471CE8
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738611; cv=none; b=ERAy48LnDQB/KSN2dVZtuQ8DeJ8JDkBquExezq4eVe9sj8x9IGO25Z2bhNNwratw8p997tHtaqXerAjdkPViM7a3jUCGHT/m4OybhYMvOHC0TWpNNNGpzh8l66qkzx6UKIjiPFiSobpVorFCFgOwB/IXBYOYi0UHcz3AadJ27Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738611; c=relaxed/simple;
	bh=7xualLeQGLjyLVtA5KG0xmJtRfswA56DiT8K8Ei5TEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcNwrq0He1fITFL7dDjnEQWxHA9fHyjXqwWXmgk+kolaebmECbjOP1lahif2Xrqx8lk+9NI7+E0wC3LNk2KZGuDNhbfSDkHKDmoWwgmhGGzuRkBJMSTvGUdYtdVyk5x5ElkYmLAQGA8yPSTQa5F3qyvyMaOe1XgLHkY4gDc6uLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUPyUIZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUPyUIZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F15E1F000E9;
	Wed, 22 Jul 2026 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784738601;
	bh=Hck/PxuqURCfL795f3ssPMc+OgmqE8ViBgiSysFBsi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PUPyUIZ1fPqHA5VkodbBa6JHdatD3H9dQYVIkXGz2ryRD5isc7xAco0H+xfk44qVD
	 YlBrB0tdVCGE6zEDIrW+iL5Wd368g71/5teIo4Hs84lv9ZduVhBU9Q92mm4K/bof2o
	 pyb5Vk4mju4BZx4OdiVbVWQkhl/PKExoJzewI3sYth46WqFlUfGZNQDHxmksT2hP5p
	 CZWf0XpOonXgM6uudq4HhkFXLUjOLmpdiRC7jbybmleehHhuw84NB8ZTzj20OWUa3q
	 RkyCyovDhWZJiNJTLUICx7hVa5T0SuUgU7Mn5/f6AUA1ak48kL5z0H0PyUlgLe5ZPt
	 Ji8QdPTodma5A==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] stable-rc/linux-6.6.y: (build) incompatible function pointer types initializing 'void (*)(struct ...
Date: Wed, 22 Jul 2026 12:43:11 -0400
Message-ID: <20260722113501.rc-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178467474625.1334.6331115540835663024@kernelci.org>
References: <178467474625.1334.6331115540835663024@kernelci.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 21, 2026 at 10:59:07PM -0000, KernelCI bot wrote:
> New build issue found on stable-rc/linux-6.6.y:
>
> drivers/cpufreq/cpufreq-nforce2.c:376:10: error: incompatible function pointer types initializing 'void (*)(struct cpufreq_policy *)' with an expression of type 'int (struct cpufreq_policy *)' [-Wincompatible-function-pointer-types]

This was caused by an incomplete backport of b4b1ddc9dfe9 ("cpufreq:
Make cpufreq_driver::exit() return void"): 6.6 still has drivers
(nforce2, loongson2, ia64-acpi-cpufreq) whose int-returning exit()
callbacks were removed upstream by prerequisite commits that were
never queued.

Dropped the offending patch from the 6.6 queue along with its
dependencies:
  - "cpufreq: pcc: Remove empty exit() callback"
  - "cpufreq: qcom-cpufreq-hw: Fix possible double free" (will be
    requeued separately as a context-adjusted backport)

Thanks for the report.

-- 
Thanks,
Sasha
