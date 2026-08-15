Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D323D7C2;
	Sat, 15 Aug 2026 02:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761218; cv=none; b=kjAXQ9hp4r0J6VROXtpy3FhX3VqeVEZxvmHgNWv/Pt4OlGQMViWYLgG+z5UCIIjkN+tn9M/YqQqvhVLQWqdN66RxQYlq68TlRXtYfFT87BFBTAaavL2YrPrEil7TgZMJD3G6l7G+R55sqMmiadnhSX4ukKyRC15mgJrf5/0/hA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761218; c=relaxed/simple;
	bh=02kJz8V/CO54sN2DuazRqAYLDGDGNu1yAZPBR8A/QtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ot0uhNZZhFb+bw3ZSYXIf52CO3wNwg221pCdQ6tL9F2ZVhaB+lM3t8ymHOeKyqWrxk1Q/grNO2pKngAkL5YAbbl/E8Z8f4rDSxr+P/BgA6L8DDfaYT7uN1ybFDpg19iM1if/uHf/lOvP9aOXW2U97BJxR87Z13Gu3tqomlZVxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcMCjFNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcMCjFNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2121F00A3A;
	Sat, 15 Aug 2026 02:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761217;
	bh=IfMu7Qfa/gP6aCQg18CzMGWOWMBK+bEM5h31AxSnIAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HcMCjFNiJlpn8jcEnvTTE2Xv6G1ZjwnESxdv61hCgJADaGz+qaWBjpmyPg1d6DR9S
	 kpD99DRpTEIqXoB9iaJmmaWJM3mGbjpfthluwLmBkIyeK6Cy17lChHhiZFTpDV4oW0
	 7WLGy2o13nuHXk/lhTtLJFfvak8ci7jAYArYRBeBjsZLooiEUmRmdV4mfRnfbFmqRa
	 qhlzIRFFbLVAkZUOaxOaQHIeMI9iV3RP6EbUp319djtQ+IvsGqKvPk3TnJ3x3DVP3H
	 8nwDDEI2R53n2VfbjD1csoGEuROmsrtpV6eiao6WtAiMgnDSUsn5Nu9rhh0h23GBbi
	 TNQEacwo6JW9w==
From: Sasha Levin <sashal@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Murphy <murphyt7@tcd.ie>
Cc: Sasha Levin <sashal@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mohammed Almaroof <moh@anthropic.com>,
	Ben Cressey <ben@cressey.dev>,
	"Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Subject: Re: [PATCH 6.18.y] iommu/vt-d: Gather the unmapped range before freeing its page tables
Date: Fri, 14 Aug 2026 22:33:11 -0400
Message-ID: <20260814193000.11@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813-b4-vtd-unmap-gather-v1-1-4c52f4a7a1ac@linux.dev>
References: <20260813-b4-vtd-unmap-gather-v1-1-4c52f4a7a1ac@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> In the 6.12 and 6.18 stable trees, when an unmapped range covers a
> whole page table, intel_iommu_unmap() can free that table before the
> range has been invalidated.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
