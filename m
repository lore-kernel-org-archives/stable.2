Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D04F93C0
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840869; cv=none; b=TEKEZJKOqtN0j12WB4rsnxvnK7mtO71LH8mIsmSmsfdVISGaB2w8FR0oDlNQ4mRyMLf+3XzWQ09tblmF7e5Vt48S5+CjbthTPV75Bem/pO/g+7xJcaWW7ESBiWbZjWfkrUrnNaTpgeMNU+gtjRNbM8LSrp1HycazidbQPhittc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840869; c=relaxed/simple;
	bh=bQJ7byitQ7uLeLakzHjLkOo0YXoj7NBAHcR5KWxOKOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPvuiem9YXS18KmDrc7IAZb2edJhKfaEivssLziCNa60bsdJw8m7h9BLAurdG1mLnmfPTuNqb8bQMGqH5m3NGsvY1LN3USYiy2cSx8Pak9/YZBN/iBvB54kMwpMRNm6DN5Fv7Qg4UkTFm3tENR5fLZpdYYDVPEWKi7HxEgyrnno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMkLFwWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMkLFwWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41FA1F008A1;
	Mon, 12 Oct 2026 21:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791840867;
	bh=7O6JiaLQdN6ZqCfoJ2Vl/aQCquFpiV84FAbfWKpuEi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iMkLFwWIP3sp26/UmhT+n2gArwI15Ansfo11XVOdGGG3AvVZ6T1YyvGfWWgH8HG6G
	 jHfbtwHdrGcSSiOs0t3dlIXXitZnXsBLpYZ9HYy5TtXUdVGyN7oPb1SMPauwsSf+D8
	 6AxG+B2evukb7gESV1l8IcJYrEU8tKWyC/yeXXopNTzZQhQEVNit9Zjfmp06K3NVaL
	 m/t2WgH3F5ktJ//0q5LaICZSZmYpAJMRkWuh/+KB49AENxEcd80ZIDj/15AUVHILeD
	 VVQQ59YpHXmLEd41Hsg/OXvFTXC0oKIADf7OZCYE+1bazJZv1YG45CbfZrhqNUgcUO
	 47sOltLfUtCIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishal Badole <Vishal.Badole@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] EDAC/amd64: Mask UMC chip select to the four implemented selects
Date: Mon, 12 Oct 2026 17:34:25 -0400
Message-ID: <20261012213356.1592197-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101212-ascension-flavorful-abed@gregkh>
References: <2026101212-ascension-flavorful-abed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vishal Badole <Vishal.Badole@amd.com>

[ Upstream commit 7484bc43ba6b8e189b482db5b75e7842890a82b1 ]

For DRAM ECC errors, the chip select value can be found in the
MCA_SYND[ErrorInformation] field.

ErrorInformation[2:0] was first documented in Zen1. The 3 bit field
implied that up to 8 chip selects may be used.

However, all Zen-based systems have only ever had up to 4 chip selects.
So only bits [1:0] would contain a valid chip select value.

Future systems are redefining the field to ErrorInformation[1:0]. This
matches the existing 'up to 4 chip selects' implementations. And it
frees up the extra bit for other decoding.

Change the current chip select mask from 0x7 to 0x3 to prepare for the
decode change.

Fixes: 713ad54675fd ("EDAC, amd64: Define and register UMC error decode function")
Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20261002113204.3358815-2-Vishal.Badole@amd.com
[ sashal: adapted the change from umc_get_err_info() to the inline assignment in decode_umc_error() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f5635dfa9acf6..dea7df975948b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2669,7 +2669,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 			err.err_code = ERR_CHANNEL;
 	}
 
-	err.csrow = m->synd & 0x7;
+	err.csrow = m->synd & 0x3;
 
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
-- 
2.53.0

