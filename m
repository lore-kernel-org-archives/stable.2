Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D943849F
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407055; cv=none; b=pGLQDeYIB8ZsbZUFHSEU3PqVucLmilr0gprAonKZ886G+1m7FCkDaeaZRJjs3VpPFnogAYMB1f+6iLmTWsIePidvVDy4r9V/4u7Uz1eLOFwpLS1SP8yNqjsnnUwORWDCYzr8KbNWlJKCmEfCJsPyzLYCrWfFEzJTkKYFJphMarY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407055; c=relaxed/simple;
	bh=1lQ7bKvtpsByFoYEDR9/FhKWgR1fbe9IA9zgS/lCe1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5dPbT8F9lkTWZNND0TFnAXXe4e9d5Ma0v1k5hgpNRudv2JBDhD7yp6Tyec0ft/tTMg1bnXIku9He2NUdLOInzeU4wHXCSQsf0/9c8W9s8pW97/dxFFVFWP5GdM3jCFgfdpe/8A1f1FKIoKrYq973yAIK9JtaVcX/0aiq5+kk6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf2lBy6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf2lBy6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5FA1F000FF;
	Wed,  7 Oct 2026 21:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407054;
	bh=VaXCCvHxaR9d2s5P4ks+3HDL7Fwgn4/Wdtje4f0zz7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cf2lBy6UVpzxn/fRR1taIBnc9Jfc4DJZIr7i6vhKivYjeYB8o26QKFYjqtKgA1j1x
	 LXyNQREZTrTUNJ0XzvQNi0a39FYKpKTi/Kzsvb/rs8BQrJ/bDZMDITxBqSTRlAh9Vf
	 bA3BGMj1F5j5mrh9451vtjCuk8wMX44Uk86G2ZsO43f0G/ow22gc7AkrE18tiVPghG
	 lnZnumGUfINFXU+cBAVEAI6ELNMrlqGDmihXht3Wqh5sSN+qtU/M+Da+Xj1w5vEold
	 xpRL+e7/qLvdYvHVzPvGFiycXcAmx1HYBUpzWSgrwes7wMzIsFVOg2yuKFRuF4OTMl
	 qUklwty1R5mtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH 5.15.y] KVM: arm64: Don't use the VMA to size stage-2 block mappings for VM_PFNMAP
Date: Wed,  7 Oct 2026 17:03:34 -0400
Message-ID: <2026-10-07-1-daily-reply-0017-kvm-arm64-pfnmap-block-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006132513.3041062-1-smostafa@google.com>
References: <20261006132513.3041062-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> get_vma_page_shift() derives the stage-2 block size for VM_PFNMAP VMAs
> from the VMA layout alone, which does not necessarily match what
> stage-1 maps for that VMA.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
