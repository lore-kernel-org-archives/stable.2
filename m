Received: from mta0.migadu.com (out-159.mta0.migadu.com [91.218.175.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75185356770
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585371; cv=none; b=HbGo1nLnqhJhLS+u9OCsfESrnbltvieaWDllyYHKHDAYG5cKkwqn/Ce5tQ5jAcIjOmuxX/+qaeQM/Qx08Z3d2PREdQ86KUfGOX0CGLY2GKU5niKodXYDXwG26eU7/rZ1q6YtQ75eXFucEiOE+ljzjSkyV3Ar/qlS4jI9foPw3X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585371; c=relaxed/simple;
	bh=TQM9PhntWAt2lt8k5M4COgt8bAYljmeqxXab3pR2gKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eb+Qn6dcmndXIs7zvTOmlnURvbixdDZv6/4p5oTgOjKhpiXUA26hKF0FRQSF0a9lYM5wAFj00cH+rJkNd2NilTmLXHTpEFJFR4k/QtyLUhKOvUnEJQAU92HRfXIbgKVkn4Psj2SqOT/N3Y6ge+NuGPU/G1FFiPMYazlpB/jNI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=Mzc9KSv1; arc=none smtp.client-ip=91.218.175.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="Mzc9KSv1"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TQM9PhntWAt2lt8k5M4COgt8bAYljmeqxXab3pR2gKM=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787585366; v=1; x=1788190166;
 b=Mzc9KSv1VfILqHx514JQz3jdmGroENQ1JGup43sLcf3smmh/iZvr9M3ItDWHU1/fJuTl/gGo
 P7mUsO0BCmmkpBxYnelnWLQUkB+1qzl3o6wnYo5yrP0lOF3HyMomfJBJkT4Y9fpLCKTYqIsy1zw
 LOuI6sEyPIOwu8vP4H+RvqaFhl1SGoZ/R9tlEHbbYiUFKfyTCJ1zUtaBAxqBudRgmFCx0q7TzK+
 nZTa6wYK9TKZvGB7bR9ARv25oWlzrD54uU0p1Pk8WGWpYQCGMD7oQe2oPXjEkkZF7+9xSnb26/I
 76m1r5qRE5ThQbbiidpNqqGxLnHUZkYyUTyOpbfBjqItg==
X-Envelope-To: stable@vger.kernel.org
Received: from fedora (2001:569:be59:c500:b340:3f2c:4486:21c1)
	by smtp.migadu.com with ESMTPS id abc171f7b01dda4c;
	Mon, 24 Aug 2026 15:29:25 +0000
X-Mizu-Trace-ID: abc171f7b01dda4c
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Eason Lai <eason.lai@mediatek.com>
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	kun.wu@mediatek.com,
	deren.wu@mediatek.com,
	sean.wang@mediatek.com,
	quan.zhou@mediatek.com,
	ryder.lee@mediatek.com,
	leon.yen@mediatek.com,
	litien.chang@mediatek.com,
	jb.tsai@mediatek.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/2] wifi: mt76: refine USB/SDIO TX path error handling
Date: Mon, 24 Aug 2026 08:29:18 -0700
Message-ID: <20260824152918.11268-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819082129.1062282-1-eason.lai@mediatek.com>
References: <20260819082129.1062282-1-eason.lai@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2026-08-19 at 16:21 +0800, Eason Lai wrote:
> This series fixes a UAF in the SDIO TX path when out of memory and
> a memory leak in the USB TX path.

Thanks for turning that around so fast, and for taking all of it. The
code reads right to me now.

One thing to sort out before it lands. 2/2 is marked for stable and 1/2
is not, but the two only work together. The padding helper frees the skb
itself when it fails, which is fine today because the caller returns
without touching it. 2/2 changes that, and starts reporting the prepare
failure with a skb that is already gone. 1/2 is what stops the helper
freeing. So a stable tree that takes 2/2 on its own gets a use after
free where there is no bug today.

It will not get caught on the way through, either. 2/2 applies and
passes without 1/2, because the frame returns before the padding runs.

Marking 1/2 for stable is all it takes. The stable rules say you do not
have to list a prerequisite that is already in the same series, but only
if that patch is itself marked for stable.

The Closes line did not make it onto either patch:

https://github.com/morrownr/mt76/issues/83

Devin
