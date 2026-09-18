Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810951DB1B
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760760; cv=none; b=tSYiYeETEHr29mOuuaaBQnGG3wwWY7Izg5fmzWxEMXY8IyoqOWjhIEvXe7oRdWpuSizAdbJL37kJxws/iHum1M5pnSvYBmPmQGTzlkm62PlzA8uVYGMHjly6i0Q/7eOeUZhxz8NRbpGHQqUenNtjbSBPIpplTjiblWf4Q0zdqW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760760; c=relaxed/simple;
	bh=kdNIu8vOSUt1bKY6zuJU98bzes5lsTfpm11B0Ro2IdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPDl5k9lRNJGLynR81IQAAMgxRK8edoIBGeikd9vMfqun4oFx7ERMtmKRqU55fq+HKKodYE7agRqKAgUybPLUCUcHwPolEFMq9jl9FoA4U63oe5VbGbpevTbZYrKIKiyQGbZVuOkNCthJxk15iUJvkWdFVaNjUyT1KT+tr+BLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/cZoEDw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/cZoEDw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CD81F0089D;
	Fri, 18 Sep 2026 19:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789760758;
	bh=smTPn2bLioUIjb3DI6IYWqCfV2up9/hhZwEl0pFEHAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d/cZoEDwdvEUoGMmg7BCIExulkfY65t8nniuA6+9MN5oRvJkcBWwNDWHSVcJPmfT/
	 SY/jzmTzq0h3i5YXBphENQuiQHsRpOQut63HWhOrIhizz8uc/RdXfziDJvkmZMYC42
	 LUpNCeirCZ/so68th61N4rISwLdSGNKZMcAhP0oPxPqGG+sDG7y0c8O0FqjUDPPfFR
	 NlA9tRXpfQ8hbI3Z8zF268WEediBCDZnwzXyt9l2HeEzS3uwGkQ2yf81BHsLjW2IfG
	 tegVvVfbv3qiV5ha6ji1izo1oq66vrA4/n1M2boODijByiME4Kh3skXMONxRDVvFNg
	 K3Kuif7ZKs1Ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Rounak Das <rounakdas2025@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH 7.2.y] EDAC/altera: Use ECC manager compatible to select A10/S10 IRQ layout
Date: Fri, 18 Sep 2026 15:45:38 -0400
Message-ID: <2026-09-18-daily-reply-0011-re-edac-altera-irq-layout@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918142944.595568-1-dinguyen@kernel.org>
References: <20260918142944.595568-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Stable-dep-of: 9868f5c077df ("EDAC/altera: Use parent device for devres in altr_portb_setup()")

7.2 does not need this one. 9868f5c077df ("EDAC/altera: Use parent device for
devres in altr_portb_setup()") is already queued for 7.2 as the adapted
backport you sent on 2026-09-16, which sits on the CONFIG_64BIT shape 7.2 has
and needs no dependency.

This patch conflicts with it in altr_portb_setup(), and forcing it through
would put &altdev->ddev back on the PortB double-bit-error IRQ path and
partially undo the queued fix, so nothing further is owed on 7.2.

-- 
Thanks,
Sasha
