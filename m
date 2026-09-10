Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB1A453A5E
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040548; cv=none; b=eGJekZWRX+5rF3KY9iYU+nteGpgmo0SGT3ChT2YJGundcU8DNwNFjJt+NF/W1sIUY8CkTHeuLPFMjuOdtpIhTFOMcGrYVR19K7wrbGxyGlpoMUB6X/qZf3geUkJszVgUWsEGyGP+n15D+ibHUSXwidFQn79zdMGHuWa4R0FvDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040548; c=relaxed/simple;
	bh=oyFYVUiW3C49W/cchJDjtaa4+k23NlulnxRzDX5GVac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmhY1J5ic0+GWV/IH0Zuz03rG/5WhkcqasRzWAv6f75FCtYEjqo/dn0yuexywAJeUNMdP8bhuHcqWoplbgA+sjiVEZ64PWL+/q69W+kIBInqu+ZtzRtkfwuPTrV2nG/b9GnYUxf0jeAfe64ov2LGHeaDoAIsnwch/g7+6iaNj4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3/7tt6X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3/7tt6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13B11F00898;
	Thu, 10 Sep 2026 11:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789040546;
	bh=K6y5aBk5W+Byp+a/aucrpqNYMOg/gQ3zyOicp3/oZ18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K3/7tt6XEQX2DEOPmA5+PcBS7SlxO6sauXdFKl5moR+u/bjNIZ9IdElmk6f8z2O70
	 tgEPqcuyb7WFyGZCcmL0OC9DV17p9+N5PTAEkP83bUujRw4VieQRNNtJvUbIZVYp0y
	 LnNAY2CniPNEH2JzeluoBktL4bYdX4Nos1p9tJKmGnj+6hcVq7bZF1p3il4e2bc3JZ
	 BNFAQ9oPNCQP8wh+LY1kT77RVmTFR8BE/LuWFaw6KRqO3bN9/eieRpKY84vXcwXj/5
	 6SPFmg+2oN3hI9XZzFvMM5V3wiMiBYns0ROCbvcQQb7Cqktku9cR5S/OdNENaWNDVm
	 J6LNll8KAFilA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muhammad Bilal <meatuni001@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()
Date: Thu, 10 Sep 2026 07:42:23 -0400
Message-ID: <20260910114223.89615-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910114223.89615-1-sashal@kernel.org>
References: <2026090823-contour-casket-b871@gregkh>
 <20260910114223.89615-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammad Bilal <meatuni001@gmail.com>

[ Upstream commit 28a289beaf226b30b1e6e7d7b1a2946fe2d6e852 ]

rtw_restruct_wmm_ie() scans in_ie for a WMM IE with:

	while (i < in_len) {
		...
		if (i + 5 < in_len && in_ie[i] == 0xDD && ...) {
			...
			break;
		}
		i += (in_ie[i + 1] + 2); /* to the next IE element */
	}

When the "i + 5 < in_len" match check fails simply because i is
within 5 bytes of the end of the buffer (i.e. no WMM IE was found
near the tail of in_ie), execution falls through to
"i += (in_ie[i + 1] + 2)", which reads in_ie[i + 1]. If i == in_len
- 1 at that point, this is a 1-byte out-of-bounds read of an
attacker-influenced IE buffer built from association/scan data.

Commit a75281626fc8f ("staging: rtl8723bs: fix potential
out-of-bounds read in rtw_restruct_wmm_ie") added the "i + 5 <
in_len" guard to the match condition itself, but did not add an
equivalent guard before the fallthrough advance, so the same class
of OOB read remained reachable through the non-matching path.

Add an explicit bounds check before advancing to the next IE.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Link: https://patch.msgid.link/20260728125456.32359-4-meatuni001@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index b08186a2af5fa..c7fab90550f01 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2274,6 +2274,9 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
+		if (i + 1 >= in_len)
+			break;
+
 		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
-- 
2.53.0

