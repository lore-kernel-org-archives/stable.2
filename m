Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA306503BD4;
	Mon, 28 Sep 2026 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635162; cv=none; b=XiNTSWhjNttFDHuW4aRKbln09IuO9o3JBbtcSyP2c1h0NxjN4xyAfcwz18YOB1df7nSKAuozRFfu9vcJxH3u6rWe0oe+FxPUhTGNBmrcEYK3CN87ODHPai4wdSI5rPrYbpJo+eOWITDN7fghcyyRnV6xi/vGuORC705PbPa4+xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635162; c=relaxed/simple;
	bh=7XXB+VWSyp4Wuy6xs2/YWSd/JTefhdW27v0SoTJTzak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a++pKV12ZvxuMEHZt8FDv9pcWkA8BIC1WQCvFgzm3iOA3vhHfN2Dhy/Hzeb9bBE4COnpJWRyg2Yhr6sWQ2AXwkl1kSVLMgxuLu2t5WgoKqWS8xiVT4PuTq6xQZl2IC8OweB2AlTxenU606zcJD49v7FKko2vSDE6mnIyLLenlXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyKwLPXm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyKwLPXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA841F00893;
	Mon, 28 Sep 2026 22:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635160;
	bh=yECMVpm6aMrRRgb4i1PJTGXAUbugl9+MAA5x6Za5tPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JyKwLPXmWuolFPUDIhs6kOkpRNAttXcMLscY3JDbRF6vSzSS/JdUigMzSyzPJWrIu
	 55tUYhh49d656eBVA55jkdp2uzNnEOwtKfrJ7wKHo1JlhwIcR9WSF62jixdGpzybfO
	 28LVEppFpzhZPFBmAtuxY6x9glkZcJMcHemXzTu408tQ6MyOhDMXyupYN0UbqRHdm3
	 /e0q7jTvwozJAhql1UoOo17dDoDSMH7VPb1NOD662dCdHT1zzhuQRExnZ7EgDw3ABF
	 CW1zrpnpY5a7s4m26QGBcdu1M6ATM5zdvN++mmK05kNzr9RfGmAfEgjCFNfFgKcG+p
	 0/6pA3knQiV9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	rppt@kernel.org,
	sayalip@linux.ibm.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Luiz Capitulino <luizcap@redhat.com>
Subject: Re: [PATCH v6.18.y v2] selftests/mm: hugepage-mremap: fix mapping alignment
Date: Mon, 28 Sep 2026 18:39:10 -0400
Message-ID: <2026-09-28-2-daily-reply-0006-re-hugepage-mremap-alignment-6-18-v3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928130916.231112-1-luizcap@redhat.com>
References: <20260928130916.231112-1-luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit a914785f6349da754e1226420bf4e51961956769 upstream.

a914785f6349 ("selftests/mm: hugetlb-mremap: add setup of HugeTLB pages") is
Mike's commit, but this patch has you as the author with only your
Signed-off-by. Could you send a v3 that keeps Mike as the author with his
Signed-off-by, followed by yours, or otherwise makes the provenance explicit?

The same applies to the 6.12.y posting.

-- 
Thanks,
Sasha
