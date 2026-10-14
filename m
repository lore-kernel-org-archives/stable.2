Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C02EEE75;
	Wed, 14 Oct 2026 01:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941265; cv=none; b=fVjdkwYHXBdWpYeN0n6KsfOALFFO3Rhh7ZBkm8kUwD/9fVWAQcnmmecdueMl+gtI+EL2ZluMiufDC69BosXtO78IE/7yZyHDJTj6yfnsVzNDPPDcHNSKheyJWPnhCiaSwiz/8VrjJb+f/RBIhdVTxGlVkRDBx0vOELanC7HGakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941265; c=relaxed/simple;
	bh=DDODb8L9vExy+gESUK9lMiTfPlQfxXisU4hAA4oT2S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJHdIghEenYKqKn2oBs2MgbHBlm+/ECAkANpeiCLT4XErTI9UPQzxfGT03BronJzXX4VSoZ6p6Rs6xZkAz3ULn8gorPJZm0Mey9WkBFlXZe0iADQsUc2FWihYOCFjZ11m+xmxN/g2631dItJiM8oAs91CRoeE9SUeGx4Z5+zfRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEidWyfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEidWyfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B291F00893;
	Wed, 14 Oct 2026 01:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941263;
	bh=CnvCQKb/Fl89d0FC9NpXpZbzIMX73JQDMnMO+GLMxxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OEidWyfGo3yio8aoR7s1A/hPv3O5CjxScN7ahHERWZZw6yQm+dvsUsxc3mRvcDojA
	 rkKFQk8U8HVKVZH4LICRNBS4zLvReip2Lh9lZLW7cGzzBTB4wFq7dkAiaQdTjV1l1x
	 hAJzf6Jd9gnenpSuskBZcFk/xmx9whVZz6dSa3gsJUgX4lQG2Ct0NjGEtu6I/sOxY/
	 Yrndu9hBvxVO3EYinxh6d8Fm831Gy01t/Of3ntv2ckW/NKZK9599V2k4sLo3iqeLMJ
	 uSQVttM3U8cFOy/ikcp2egtvn4hGJqR9ikeFp/1RIRL8y0AVYxdTNvrRyYy/hhYdUT
	 EhoOoCArib8vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y 2/2] wifi: ath12k: copy M3 firmware when reusing the buffer
Date: Tue, 13 Oct 2026 21:27:13 -0400
Message-ID: <2026-10-13-1-daily-reply-0023-ath12k-m3-reuse-2of2-hold@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012165925.32575-3-artem@trailofbits.com>
References: <20261012165925.32575-3-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This fixes my 6.6.y backport of upstream commit 05090ae82f44 ("wifi:
> ath12k: check M3 buffer size as well whey trying to reuse it"). There is
> no corresponding upstream commit, because upstream never had this bug.

Holding this series until we have an Acked-by or Reviewed-by on 2/2 from
Baochen Qiang or Jeff Johnson. It is a stable-only fix with no upstream
equivalent, so I'd like an ath12k maintainer to look at it first.

-- 
Thanks,
Sasha
