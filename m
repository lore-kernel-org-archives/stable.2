Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998BD291864;
	Thu,  4 Jun 2026 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564582; cv=none; b=O2G5Zel0Pf3umdtvXU4SeQ5GX7JrJ+wp7ZR1Us7LnOsoNGNxB2BoPwc8213efm+eOJVChixTnST1kIbT9xvHVIn/CaJBSscinMqC4Q+Unfn5AcecrWij7cyTShO0CoRCNgWnx+Kc4AE1b5eHPGL0ErmlnqKyOBTglUPemFlymp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564582; c=relaxed/simple;
	bh=UbeNZZKEbzzG2XLW8mNJxTdKUKbKMzxs10KksnUNRiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsJ5/krbmnc5D1dYFk/RUN+CDAtjNZH8aJbfC0uil+8w5LlreiJ6FHuu/w99JE4kN24No6oHjDewa+oZGF9SdHk+W2vM6i3XVLNYuwtEpwUqHePot/zI59P3ObD5xMY/D53lSl/xNkAM73fE3xuzN1sUaDYhbg0RhEzL/r+JFnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O6nAgWtE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O6nAgWtE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82C833297;
	Thu,  4 Jun 2026 02:16:09 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 611223F632;
	Thu,  4 Jun 2026 02:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780564574; bh=UbeNZZKEbzzG2XLW8mNJxTdKUKbKMzxs10KksnUNRiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6nAgWtETCjYKUzMZpKubmd9PTOnvbycuarRvsUBe3IaeNz9aX5EFVeOGYOiXLAeY
	 7zZ3tfffVI78TMFAJ45m+vixxUhAJyWTL4JOPlej/zxBr8pU6sGE3F12YYiHw1mOfJ
	 oo6T5yAtF68FbWTsRCqymXT86+QI3QrkaxVA1Lec=
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Qi Liu <liuqi115@huawei.com>,
	Junhao He <hejunhao3@huawei.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junrui Luo <moonafterrain@outlook.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] coresight: ultrasoc-smb: Fix OOB write in smb_sync_perf_buffer()
Date: Thu,  4 Jun 2026 10:16:04 +0100
Message-ID: <178056454302.143850.17233470851882854989.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <SYBPR01MB788156B3380A36835DB22290AF102@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB788156B3380A36835DB22290AF102@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 04 Jun 2026 15:34:25 +0800, Junrui Luo wrote:
> When the SMB sink is used as a perf AUX sink, smb_update_buffer() calls
> smb_sync_perf_buffer() to copy hardware trace data into the perf AUX ring
> buffer pages. It derives pg_idx = head >> PAGE_SHIFT from @head, which is
> handle->head, and indexes dst_pages[pg_idx]. The pg_idx %= nr_pages
> normalization is only applied after the first loop iteration.
> 
> This leaves the initial page index underived from the buffer size, which
> can result in an out-of-bounds write past dst_pages[] when head exceeds
> the AUX buffer size.
> 
> [...]

Applied, thanks!

[1/1] coresight: ultrasoc-smb: Fix OOB write in smb_sync_perf_buffer()
      https://git.kernel.org/coresight/c/98495b5a4d77

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
