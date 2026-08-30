Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614133939A4;
	Sun, 30 Aug 2026 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788113967; cv=none; b=BqKKB3DxMl42r3jNMOM8D+Ce4kpXkEnOPI54HM5Af9TI8sV9vssU9dbcBbnR2zsaQdmCalrvU++m4PEC9tLsn0S4685HKDGSm8nNA89B8XUXokEQZnasSxQELhhE2p3E6OZa6glA7GNi4XLwcEGMNcGk3T90yvhmC6o8T4Hm3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788113967; c=relaxed/simple;
	bh=WDnh9FKBT/dxqfhYuDlsJYFUrYvT7Sk75XTmpnN4oMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewdpyVPul8iz0gutxMjd9Y5JwQQHCquE5wx4SWibtEurJd/XMamdCbNx0XhMTkHJ+CP8ylWMT24tKsJBTrrgIHRTibx1FRFAFECyBbJ5uR44EH6F7Zwk0oi4YnvKmjP3QQ8J7VeaKmrGtTL/9Mk3Um9m4O3CyadNR0iADSZt/BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9J6Lw8P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9J6Lw8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01B61F000E9;
	Sun, 30 Aug 2026 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788113966;
	bh=7jy1ZWnPaxiHrahLaXjgCWS5cxp3bEGhVPgp+yEdgqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l9J6Lw8PFf0Qbwatxu+AJWYvWKkEtVP5XYWvNymlcl8IwFuA2UcGFVLwvH1EKR+VZ
	 F5qknpWvt/3eXbHDXbH+R2eSXv0QQffh9mm/DV/E5/QPbTaX+Td/P7D0a8Fx4XEwvV
	 pZPfMxM7QstlHKnPyFIyWUFEQIwz+RYp17E3XvG2sOsLyOWcsBPF+cagHo9rvsvDgi
	 9Jec2A0StZgJH8A0iDTCzb4WpLs4dFOGBR++W1mEXXoXnfAWZgTSokf/zXBOQsMYgP
	 l2AXGAQr83dV13fdpHw4lxaYPMaffvfqIgYGSB1WrQGzrUCrjN8ycffAmIA2u2mwzl
	 LuFlt/DPYR91Q==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: fix unconditionally skip last region
Date: Sun, 30 Aug 2026 11:19:18 -0700
Message-ID: <20260830181918.105052-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830181445.104859-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 11:14:52 -0700 SJ Park <sj@kernel.org> wrote:

> On Sun, 30 Aug 2026 14:31:50 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Once quota set, the charge_{target,addr}_from unconditionally skips and
> > resets at the last region of the tracked target, so the last region can
> > be skipped even when it has not been processed.
> > 
> > Example:
> > 
> >     1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
> >     2. Quota is configured to process only 100 bytes per window.
> >     3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
> >        addr}_from is saved at (Target, 100).
> >     4. Window 2: The loop reaches R2.  Because R2 is
> >        damon_last_region(t), the old code unconditionally returns true,
> >        skipping R2 entirely and resetting the charge_{target,addr}_from.
> > 
> >     Result: R2 is permanently skipped even though it has never been
> >     processed.
> > 
> > However, it is important to note that this is a very minor issue.  This
> > is because it is triggered only when the previous window saved/kept
> > charge_{target,addr}_from, and in the next window, all regions except
> > the last region were skipped by damos_skip_charged_region().
> > 
> > Fix this by only resets the charge_{target,addr}_from when last region
> > is reached, only skips when it applied or cannot split.
> 
> Looks good to me!
> 
> > 
> > Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
> > Cc: <stable@vger.kernel.org> # v5.16.x
> > Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> 
> Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
