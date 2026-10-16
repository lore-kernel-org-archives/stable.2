Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88625650E2
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171321; cv=none; b=WjnCZZ99+UXX3jm7fThpgJ8nollYpJTP+Pd2DDj/EmzZF7tpRiCYU6rtO0CvwECl1FDMrPrNFky8s65QVTtf6OgcAhW79EfzF8F9l5vA3Zc3GPTPmhoqLVCjmw7lrx+qfx7cNXvIgqPzIb6ecXMVsNID5IIB8qRxkE4FmK5yvKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171321; c=relaxed/simple;
	bh=zLf4n78l1h3bFu2neIcXuiZTO4IVRDeWTVRUwmBGKyI=;
	h=To:Subject:References:In-Reply-To:Message-Id:Date:From; b=Wl9FQzTVmNmnPuyE1sBurBifqFr+4soQoz9K7gXdu0GIwaNTw6QGFCvojNovrHXtuOCLuiToDG4jRqrxQtF6VNKdniv1IZJBNSuTr4trgskcoZ/+M5PAvmD9PnAKOZ+8iIxUzoTVJah4nrg1DsuiKQSQItMc4uaBHtjEdCxjcos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=J/L/wdnD; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="J/L/wdnD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1792171320;
	bh=zLf4n78l1h3bFu2neIcXuiZTO4IVRDeWTVRUwmBGKyI=;
	h=To:Subject:References:In-Reply-To:Date:From:From;
	b=J/L/wdnDF4yyaB8nQwZlY7AGb1aI9oIj8fqFedpI4M4o80uiGiQMShHEvzqUDBiks
	 FOWcf/Lvo4fprIWUWfdpE4YXLdj+lASahASMXYa0OdUQ8SG+Md2BncCS32/AGL13qg
	 9WGcDKHuSa6LQzfyUmO80evpyer49wYXSa7R4/n0=
Received: by gentwo.org (Postfix, from userid 1006)
	id 45C0240B13; Fri, 16 Oct 2026 10:22:00 -0700 (PDT)
To: stable@vger.kernel.org
Subject: Re: Patch "mm, slub: avoid zeroing kmalloc redzone" has been added to the 6.6-stable tree
References: <20261016172155.3999523-1-sashal@kernel.org>
In-Reply-To: <20261016172155.3999523-1-sashal@kernel.org>
X-Loop: christoph@linux.com
Message-Id: <20261016172200.45C0240B13@gentwo.org>
Date: Fri, 16 Oct 2026 10:22:00 -0700 (PDT)
From: Christopher <cllinux@gentwo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Christoph Lameter <christoph@linux.com>
Subject: Email address change

My email address has changed to christoph@gentwo.org. The email at linux.com will be decommissioned on May, 1st 2026.

Regards,

   Christoph


