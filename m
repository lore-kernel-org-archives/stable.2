Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0D399365;
	Tue,  1 Sep 2026 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273061; cv=none; b=V5jr5OrJi2fq+L+msdJwe4u1RNZ029IQzVF0G8jv0htuzmAYoXWBAdzeTqIv/kwwyThEQICLjXZjPw+y+3Ud41q9YuS1AQSj0+t0HCoGtk03XXO0f+YTj5K5DEQZkCwh4N/fDMUX+I4b7SK6mML+z+P7JPLrDwWLyrJsnO5/mPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273061; c=relaxed/simple;
	bh=TcHeTAMyL2pLTb7rK7VxmOZdEXeTFU2zzVZy1DOaX2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+BOIig3Fey8CDV7l9RgJfHQFw0QxXlv6NBFibLv4oRFezuK6s4PiBxnFAs57WUnrMnj3RWr34234Nc2igvVkwDyzO72PTVl1fy5mQI3hUiSsxcMmMHOtVcjLHuicETf4aaFztEe2paA9uXjhvrGUEBncoeHxSNas5ZX7lZ2FfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzZP5Qky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzZP5Qky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427F11F000E9;
	Tue,  1 Sep 2026 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788273060;
	bh=zPIRT1eDM3lMbQhKVz12Hh9ErNZglXURkwle2X65Z6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RzZP5Qkye+TEPQgaY/tN0jMWyT7LGaDsLqJ9Tr36PoeeG7oxxYlw0aM9c0DYPIrxj
	 t1SJrCeGUhXt5LcO77+u5dYOBdos91jotme1/vqxbKobvCAd3JrcxJ1sFuyI2WcbFT
	 agQc9UxGsk39+1P6cZ0pVmsd68eGEGB/ZMutc/6GslXELwUQq5FqIDhBfphhnkdGla
	 csyDOpJvxBOhV6oxtfSgLeOoD+3AI462ZWbUiBGRK6Nmr5toULI58spGcnZ22lnc98
	 j88tA1CQWE8c2CKfzpcshfQlTIBLwBp2oAMYtJ0tdQqYJgz5bF1zjV/PgO+3ZUtgdN
	 T0mTNwaMl8E8g==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Usama Arif <usamaarif642@gmail.com>,
	Yueyang Pan <pyyjason@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/8] mm/damon: fix DAMOS bugs in core, paddr and vaddr
Date: Tue,  1 Sep 2026 07:30:52 -0700
Message-ID: <20260901143053.101196-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901131850.98037-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 06:18:41 -0700 SJ Park <sj@kernel.org> wrote:

> Fix misc bugs of DAMOS.  Patch 1 makes DAMOS less stress memory
> allocator under extreme situation.  Patches 2 and 3 fix wrong folios
> walking in DAMON_PADDR.  Patches 4 and 5 fix wrong folios walking in
> DAMON_VADDR.  Patches 6-8 handle extreme and unlikely memory situations
> that can cause divide by zero and underflow.

Sashiko found no blocker for this series.  Sashiko sent findings to damon@
mailing list [1], and I replied to all the comments.  Please read those for
details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
