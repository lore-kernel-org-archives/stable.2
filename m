Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585C485926
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996803; cv=none; b=D2B8WhC951uY47SMjLKCRp7VBeYZikjGwut6bxn7U6AWYprzvJpqOIG7XTrALgbz6htHhXMgn5uP6tRQsFzkwGGhV95VJsb6q9+wToZJ12KIKGv9SgwZkMpg1mGoiLusXufoAJ/bXXYwYQNSzBUamv9M7Twu+h5ZDRPJ3LxYbkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996803; c=relaxed/simple;
	bh=25yZpwDldmQXudZtnEpEY29tAweMqzqYod3g5ItYonc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gw9xtLtn00HZBgzeUzVrUtEZtUoaSMnrVDAP2DVs4A6yDXBO9fqkMJ66Rh+gKHPkG+f/7uYTpMQHwh2sEOEF/3cMK0AqSROcZC6HzNG82VEoBJ3FT7KCAi63vmJ5nwLQOuKibt8sVqIyhDlusVlmz/I4H9jELMWF/GCEnlgGab8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcBhfY+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcBhfY+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE9D1F000C4;
	Wed, 14 Oct 2026 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996801;
	bh=MsKdmB4JonhpHAvMWz+/JWMsq1vhbpD7PDe1wHoAGA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PcBhfY+fiN4MdCf8wJYOY2C2W6mZRGPASso7QosnmXxE70r0RYku5A/Qnkei69d1v
	 rnuwypH2jbHJO7xBD9nn2vK/7Pl09r4lUyTjIyOwPSGm7M0E6k+BlZZXGma4PRvElZ
	 Afb282r5HTMaJr7/4B9MyYewhy3wgISG69Uv9hXwYYn7kWViUfmkmgQisiuLi353sm
	 Bo8znFhYurOmMAvgrOAuPxXr2o0yF0u+XEE+Lscb/0yEtH2uaJg2plrSqdY/9eQGrz
	 LQJS08YV037YC5jg/KlMGQE8W8k4X6oOdQHOdzh21m44K/7uMIP2Rz4bcxD12N5gRP
	 5FsbvyYyUwV+Q==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] stable-rc/linux-6.18.y: (build)implicit declaration of function 'bpf_atomic_load_reg'; did you mea...
Date: Wed, 14 Oct 2026 12:53:04 -0400
Message-ID: <2026-10-14-1-daily-reply-0001-kernelci-6-18-s390-bpf-atomic-load-reg@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179189994404.261652.13159578693708911661@kernelci.org>
References: <179189994404.261652.13159578693708911661@kernelci.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> /tmp/kci/linux/arch/s390/net/bpf_jit_comp.c:790:20: error: implicit declaration of function 'bpf_atomic_load_reg'; did you mean 'bpf_atomic_is_load_acq'? [-Wimplicit-function-declaration]
>   790 |         load_reg = bpf_atomic_load_reg(insn);

This comes from the 6.18 queue copy of cc3e12330599 ("bpf, s390: Clear fetch
destination on faulting arena atomic"), which needs bpf_atomic_load_reg() from
41c5dbb4be3c ("bpf: Derive the atomic load register in one place"). 6.18 does
not have that helper.

The patch has been dropped from the 6.18 queue.

-- 
Thanks,
Sasha
