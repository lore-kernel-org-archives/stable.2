Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546B1560AB8;
	Thu, 15 Oct 2026 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093000; cv=none; b=D6yc1+aYUC2EMcDgQLdBtx8Ss+1bxobMngsJ1b5/vMRKOstROf/4iEadrNfKJmDa2mS4WNCL+3nqWhOZuld/pTPTnAtAHXPqecjva20P4kMF+Fq4tskBP7/79RMV9aaYBBOA71OUzz/G/DvMN9Vz6ugcsL/L00WbyWqOnAcpyo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093000; c=relaxed/simple;
	bh=Z8GRxfhJ6JaZAhAjNWFpUtay6LE4bVlW9mrw8E6uiAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkJaOH6Ls26eemFXu3JEj3HyloZ+KW8rmhgUMU1p94QhfjwoyIIA1OPlxIGtleWCbbW1C2LnimJQd19doAm/Br3fqRaEdnlkBiAR22qEqqyza4c8DkJG118Bp461rdPR7jjkde4uhKKm40aK6YpChMGmM/SUFkTqTA6vb25ePOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7etl7zt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7etl7zt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A7C1F000C4;
	Thu, 15 Oct 2026 19:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092999;
	bh=zvoALj8GkR8kkROdh3GweM0NBMfMApyyeG+/qXzasiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W7etl7zttIJXqcWRZ4s9B1ZxWfLrWtxNPWvW8Ezar6e7fZd+ik2pDAAHt5FotcKNf
	 ZFX9JvjZBTjqAN5k6x9Stk3T95wT2TP6b7XbPchc/TxjUtH/OcC6tu9xad+YCZerRt
	 NjCsm87DBXYCRgHb+0YhGoWAU5C8yURvnNfJxXV2rYbKRkEYCjRnZJRnaHjzbdWs/I
	 4cnzOkvaVUE6ZhZIf/i5zP2mEYkha98M2Vp4izICQDObH7R+A/tZc17Hm6H0GVpdRX
	 RaMHwc6lNioIBjCnaVAsFRoLwkMRUdU7OZXgBoTbu1l2KCjm0wN4oAaIOnF+y61nzx
	 s2xEvxW6jpZaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	lihuisong@huawei.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lirongqing@baidu.com,
	rafael.j.wysocki@intel.com,
	rafael@kernel.org,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y] ACPI: processor_idle: Mark LPI enter functions as __cpuidle
Date: Thu, 15 Oct 2026 15:35:57 -0400
Message-ID: <2026-10-15-1-daily-reply-0014-acpi-lpi-cpuidle-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014191932.24129-1-artem@trailofbits.com>
References: <20261014191932.24129-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When function tracing or Kprobes is enabled, entering an ACPI Low
> Power Idle (LPI) state triggers the following RCU splat:

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
