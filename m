Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C019A28690;
	Sat, 11 Jul 2026 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783729297; cv=none; b=bGmIorZ3avl6UJ6NdmN8uw0wfdOHkcW0lljPKDIRyHUdKdhnKc59DctK1OGv4m0eTzmSpGeWylItG8V66vhI2yN7F6AmTMEtNLX9z/A1YCSoa0F/uBF3npwo/hS8w3yLWqSAtoKtY4lCdntiKCHS6/KAOoPvW6Or/WLm/16DdtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783729297; c=relaxed/simple;
	bh=D7VyiBOjfB0A60fOGI2EO26B+4QUF/FQHYmA/XvB7q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVNZ6whRPavBWl2lk3y0OcD+261QxYyRfw/AxpA4SDbXNr0DE1gbeFHYP0H0QjjbfWLCjcFuj0vHrD53W/XPP6set6HiFyoja5WZyJCRuSjbk8HFfTUuCtmgM2v4c8qSvlHvDNA/OVU1SfsG9CwXe+QEBEWwpEExXmnXVldU6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMvgPx/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMvgPx/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DB61F000E9;
	Sat, 11 Jul 2026 00:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783729296;
	bh=qYQiKMWE2mmb3f7us04De1XfSFWoZkhtk35nJAydwh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NMvgPx/TkwCOIr++tPwvI0CK5E/8JaJb/sCrDwY1I1e59hVNcVC3opeHoSr1r16OL
	 x/lEfLU0OGBCWQRNv6grEMOW6nTr97oPM12vARSoKVuU55utoMo9QIXF29ExTrU+4U
	 tD5EPWjwihpruiQknt6yh4rERnpCsjmYL048IaUIPBAyMCsASVpWbGR/boEY12ZKNA
	 cAlQOiDUHPfleNw3cHK/KiZpqp+okxYqOG/sfTarvsU4q+NkIeTCxLvivq0IO1rvgE
	 7xKwJtVrFuHcYvS+UQzktIFMrPE6HkSt2+5dE7kbtXH0l3bt/3aq4UIcnJbWsO38au
	 vTzzGpJ1EsrdQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Song Hu <husong@kylinos.cn>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] Docs/ABI/damon: fix typo in intervals_goal sysfs path
Date: Fri, 10 Jul 2026 17:21:25 -0700
Message-ID: <20260711002127.32005-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710141738.24789-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 07:17:37 -0700 SJ Park <sj@kernel.org> wrote:

> On Fri, 10 Jul 2026 12:47:34 +0800 Song Hu <husong@kylinos.cn> wrote:
> 
> > The ABI document spells the DAMON sysfs directory as "intrvals_goal"
> > (missing 'e') in four What: entries, but the kernel creates it as
> > "intervals_goal" (mm/damon/sysfs.c).  Following the documented path
> > therefore yields a non-existent directory.
> 
> Nice catch!
> 
> > 
> > Fixes: e2b23dc62369 ("Docs/ABI/damon: document intervals auto-tuning ABI")
> > Cc: stable@vger.kernel.org

By the way, hotfixes and non-hotfixes usually take different trains to the
mainline.  Having those in single series therefore makes maintainer works
difficult.  I understand this is not a hotfix but just somewhat worthy to
eventually be backported to stable kernels.  So no problem for this.

But, from the next time, please clarify or use different series for Cc: stable@
patches.


Thanks,
SJ

[...]
