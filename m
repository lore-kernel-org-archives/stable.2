Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B233B3BF5;
	Mon, 20 Jul 2026 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784531149; cv=none; b=fosiBfZ6pLALZq/oEihSZ6Z+l8cBADyDcBw+JicuyRBoeicYX2sjpI2qopxMWGHaLGvkgiNK8LoJJRcSa3BS0ZDs9yG2mFCINgNrn5eHveQGV5sk1d8NU+eRdUNpp5Tkh8iuQx1hjqauecT4VmsGem6RVTAfyUW8TC8pMN7ZrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784531149; c=relaxed/simple;
	bh=LTzi9Nz31z7XxJtZxC65NrPLVObf3I5lfNpwXzLA2gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKkLTYAJ8TPmG+iHLIz8P0OjbzJI2bQCl5kw/8/R6GJhgPlrDELMYc1qLuM+6M1UIgTkVk4GXhTF73Ajop6w/AH6eipjnyOLSriuGTsCYiXnrRegYG70hBmyyG3dgtynzlyaRBnhQJrbQbwk09bSQV8uN9pdFObDbrwJDqk8qGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=OapSPFGO; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="OapSPFGO"
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 73C7E1F8D6;
	Mon, 20 Jul 2026 09:05:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784531143;
	bh=LV2kqTHiOpXH1D/XFbAf5/rKpzHb9rX2QTZ5H/X/bcM=; h=From:To:Subject;
	b=OapSPFGOHGo23WZ6r7AuIQv7SYOnvNF+bpSREaW95oG304Cov7u1FXu0Xnkpwhe0L
	 j0+QUewMjLOs+NbcXrAJ4zdm/jXVns/eElXW0XC9zsnLnfny5HP2HmrJume5Mqc+/g
	 a0s/V/i2ohGIr2RtDdq+PNsO4D1HZzTymxtF/PGMOLWri2MmgOKxbrKGvX18lXE/4B
	 cw/PWoZeuKgezM6qWvdObKS5jxCB7CMhbbxNdEYyc9YcH7GuokpKKraqR61rPcHUaj
	 rfLBwd4djEI+7SrcwWhkkWlqFltFyKVpyls8f9aDSIUjZv69Nab1lJIu4BhxLgXGF/
	 l2P9NijZbDVHA==
Date: Mon, 20 Jul 2026 09:05:39 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: briannorris@chromium.org, francesco@dolcini.it,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: fix NULL dereference when the AP has
 HT-cap but no HT-oper
Message-ID: <20260720070539.GA25790@francesco-nb>
References: <20260716103042.88469-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716103042.88469-1-doruk@0sec.ai>

On Thu, Jul 16, 2026 at 12:30:42PM +0200, Doruk Tan Ozturk wrote:
> mwifiex_tdls_add_ht_oper() gates its follow-the-AP-bandwidth path on
> bss_desc->bcn_ht_cap being present, but then dereferences a different
> pointer, bss_desc->bcn_ht_oper:
> 
> 	if (ISSUPP_CHANWIDTH40(priv->adapter->hw_dot_11n_dev_cap) &&
> 	    bss_desc->bcn_ht_cap &&
> 	    ISALLOWED_CHANWIDTH40(bss_desc->bcn_ht_oper->ht_param))
> 
> bcn_ht_cap and bcn_ht_oper are populated independently while parsing the
> associated AP's beacon in mwifiex_update_bss_desc_with_ie(): an AP that
> advertises an HT Capabilities element but no HT Operation element leaves
> bcn_ht_cap non-NULL and bcn_ht_oper NULL. Setting up a TDLS link to a
> peer while associated to such an AP then dereferences the NULL
> bcn_ht_oper and crashes the kernel. Every other bcn_ht_oper user in the
> driver NULL-checks it first.
> 
> Guard on the pointer that is actually dereferenced.
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Fixes: 396939f94084 ("mwifiex: add HT operation IE in TDLS setup confirm")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

