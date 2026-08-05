Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313A1A682E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948119; cv=none; b=u0Lc/7Sr5iRYH9N+kMBdp89y+xjA+kDifjOcDkcFvSB9Opf/rhC6fzhPCi+Pa29BDEhTzBObsfkEKr1d4P9v4lVJUTRcMIfi7Y1FTTNmpyni5yZCdUkC7JMOqGDWTGMJXP7IOxAK3XreHwFG68R+FUbKgXOzTS0tzQpHFhhafCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948119; c=relaxed/simple;
	bh=BLOVX5kxvOJWKWNRi8Gk4aEV4A8FV/eigiMY+uA5OI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uH7sNNa3RntGoXFGwv+bWNFeXlsxdqeGndQLd6AfL9yo5891WyVbm9IzAZmjjxfvgsOsaMAPh6bC862py4H2Y91JKdXFzq3Azj17AJUmBGeR1w9FIHAOfZUiaOIf7tDGpnLEnZNUNYG7XF5/6bS7+n4j2Z4bMMAlXumGLBRYKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIhUPfjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIhUPfjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029F01F00A3D;
	Wed,  5 Aug 2026 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948118;
	bh=dtPx0Ume3dICgs4sUSAQ5rN+VTVakJwrLZtkrM+jJQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JIhUPfjVfAvA+yidXeaDrnj1nvx2qDDtGAaOk+D2XCAdzCrs5EbJ58klxa3E1+He+
	 rG9WC//m3ylVkBgSlZYS5i0d6JYp5wqVngSO9nOZkRgdSNt9jZ7Kdwnq6vBPwv0iC9
	 f7le30xxwhU2Hl24Z6WZ4YxB5xt8RKuP3eEnDozQm1RAtyI/CfHpHUbtHEp/asGycK
	 khOM/y2fjgCJ+PnPhQp77LWVrkMiochUyUeUWZjGj0ft3prxd1o8shwG0nTw8I2pvG
	 BZRciL56bRMYe2Qh+fXcYre1ExFvzz+ObyQaRYKJaklfPwzOH+SSGeDDiBaBCcKgwX
	 caD6Qb77K5s/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: Re: [PATCH 6.18.y v2 00/10] drivers/gpu/drm/xe: Don't whitelist OA registers unconditionally
Date: Wed,  5 Aug 2026 12:41:48 -0400
Message-ID: <20260805164000.stable-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
References: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 04, 2026 at 07:46:04PM -0700, Ashutosh Dixit wrote:
> Backport of the following series to Linux 6.18.y:
>
> https://lore.kernel.org/intel-xe/20260615224227.34880-1-ashutosh.dixit@intel.com/
>
> v2: Fix upstream commit sha's (Sasha Levin)

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha
