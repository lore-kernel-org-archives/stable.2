Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AEC4A8FC4
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821031; cv=none; b=lu9gPRlfoPtKQ7XSku1IYcQQEvSfIXHxgmm675O4x+rTbTNmHXS9USo5iuwNFO5JNFyAWruoZftys5hA2lScyv/5wUBBNZnxP1FiqvrwXab9xGiPwNDnnj0R4ogs5/3iV5oOWsIp2mQe4SjFQO3uTxp5fNVE7kfNwSHc+aRctWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821031; c=relaxed/simple;
	bh=DEGdPzUP6mda3i+YbH4+YSF39T6WpDFN1JGFcuZIVbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3qd3TNKMNU1qApwUS4P0IC2zAX8/ub761MJqzbHqR8ABIQPdunD4QR5j98rrdeWxkLo/mY7HML9o+W7mlIc+azov9fv0gStmEBdgYP6WkrdG3g3oAuJC6WCEZlf2tot4829bsz6jllcDkwXNkHwbK9dPw5gjDFKrbOpd7W+of4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP+NVN6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP+NVN6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB741F0089C;
	Mon, 12 Oct 2026 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791821030;
	bh=WzBHsiyiEbu9EUP7yzr/EDgv7/C3MCM4mNZAE5oBTgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aP+NVN6UQ1hKhml9JSOd/9NVtjruRbrbalwlPF7TiJ8cD9AkPTNMOgnO8axorknqK
	 x80a5JeCRddmtnstvxFG7wvIa4cLHABgtov2OY4Wbu5K3CPnEcSgQr0xXCqOEypepT
	 Y8WjpmIaFX6EOWYpOmlnjI8/OOxH5cRoaN4bGMobj9QOTlXtsH9pwckNb3qMiWJjpx
	 5g/KSK1fFq7WF79ZJo91WfGubuXF8XmxjUY/6ezembvSKqAP6EfrG4Nec2YE69BzIu
	 jWNZr+zHkMNkrJiqDjOCWKmtxNNnK8lbzMrIWWnW2LPS9jBXkJ70y2IAiuud1LOrLT
	 TRpyRRN4g3Hlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishal Badole <Vishal.Badole@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] EDAC/amd64: Mask UMC chip select to the four implemented selects
Date: Mon, 12 Oct 2026 12:03:48 -0400
Message-ID: <20261012160332.1110719-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101210-dugout-corny-e128@gregkh>
References: <2026101210-dugout-corny-e128@gregkh>
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
[ sashal: Applied the change in decode_umc_error() instead of the absent umc_get_err_info() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2f854feeeb237..7b3d3615de5cd 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3300,7 +3300,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 			err.err_code = ERR_CHANNEL;
 	}
 
-	err.csrow = m->synd & 0x7;
+	err.csrow = m->synd & 0x3;
 
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
-- 
2.53.0

