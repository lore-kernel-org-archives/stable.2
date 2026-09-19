Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7871547055;
	Sat, 19 Sep 2026 05:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789796843; cv=none; b=BzLSiI2Lhzg89YJf5ZIrM0vSdWa3h9P01EPJudc1vz9rtKrXfcBGfty+3kwdt8vW4x7JpP1iWsQ9Bc817FkeU0UxFgVwi0I/UWrbrItvfZq/fYjh5Dc4zuIjGK9u4HF0gcmrGbSzsX7j3r0w5V0oiuHhBOZVrP8yWJ3aKtW5PMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789796843; c=relaxed/simple;
	bh=RRIl8sMQlRfyu8YbG566xd7xhFA9ef6gL5NMFdV0Zkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRZlqcotZ1RGRtgi/rF0qKp6eDVnMmOpJdmwSjrgMe4TJ5UJT96wfAxWj56v+bJr/gsmO2+qOGr0LVVncFtwx9w+6Nm6ABHEEzpyCyDUjrsPqcCJR2vDsKrBa4T9CBok9z66eu4sbSpvEF8QecyBZlOPpiiDxNHTL7TYlAzkgcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hUuLDpVN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hUuLDpVN"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9217240E015B;
	Sat, 19 Sep 2026 05:47:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 83_6iID6HQ9m; Sat, 19 Sep 2026 05:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789796828; bh=IW3Y7rhrODpufhyVRDMLa+KK+0Ki2euZiglo3ZIp4mI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUuLDpVN7QcPVGINbV2ILrhrpsy/jJVbkt9g9EPd44Mv2w65/D8OyS00KSjvWFOzy
	 9mj9fEGMWBZ70AQYfBWbmtpcvrZ2+vHtMqcoA5gjkmqLtXE6DeIpOfSpAYMITNSq98
	 nZ7E/V9J+AMsKPFzCGomwuN+ykEN0TnBFlFADu/HcfsGm7GiAwz9efl/JfuWGvSe4V
	 66F883bjqUs2qeXjTyB5kM49GoT0ocq/gD2A0aiVuhcGDobQ0CYkgNTGOFBDYINTSK
	 M1tz1LPoPqubQdsrtArojBNmIZ8Pqqi8rxvkWJJ9ydZVxCRX/r0ljg5eY8jEyBhEhM
	 H6YvEf6jm4+NgiHkCEw8Q0L9/xAD9zMFodC8TrnY5Uhb3nmnXZBEO6mLAVXnD5JBPw
	 5QpWTcYFSl7UX6SHlVJsDGx66rXVqbrwKEwrQBggjvXxgBZ+B29HBDPrfQiSVFjhmD
	 sBYwPuvGs8s/03zBeZv1tbvQIpEZwLCu1ofOuUVoHl/mlfBuggylcDAO6bpChnAxSt
	 K6P8TUNhlhAFPwnA5nmLUX1SRSlE0hgPQZVOQV+oDHkAznlh0UFmXej5Tds7VALQO/
	 ihQXi6nxyw09aUimqQTXcv+qLwcRYWEBiLcfughcPvqt02nL/r+hdVg6SzZCH7rigk
	 GPD9/Q32DVfzhvR8O1M3r1Og=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3916740E00B9;
	Sat, 19 Sep 2026 05:47:00 +0000 (UTC)
Date: Fri, 18 Sep 2026 22:46:56 -0700
From: Borislav Petkov <bp@alien8.de>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: akpm@linux-foundation.org, dougthompson@xmission.com,
	juhlenko@akamai.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	stable@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Orphan drivers/edac/i3200_edac.c
Message-ID: <20260919054656.GGaq4h0KqIx5E0tne3@fat_crate.local>
References: <20260916091554.1998750-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916091554.1998750-1-vulab@iscas.ac.cn>

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Fri, 18 Sep 2026 22:43:31 -0700

It hasn't received any care and testing for a looong time now, and it
doesn't look like it would anymore. Orphan it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1461ac362c6b..b00c20ade1eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9447,6 +9447,11 @@ L:	linux-edac@vger.kernel.org
 S:	Orphan
 F:	drivers/edac/i3000_edac.c
 
+EDAC-I3200
+L:	linux-edac@vger.kernel.org
+S:	Orphan
+F:	drivers/edac/i3200_edac.c
+
 EDAC-I5000
 L:	linux-edac@vger.kernel.org
 S:	Maintained
-- 
2.53.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
