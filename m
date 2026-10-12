Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F23AF646
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830782; cv=none; b=C2e9bB/RGOFRzH15VrHQt6O1+aejirZBzNbR79WH/JrMc0i7WsRGfKoWhyPSFxqFISTIZhuwL5vwKkDnQhn7qc2dGtRc+0Fj/l0O7JAoc+YwKlTUC6jPQQhFMZToeRnTrzc5mBV52rCM+W1I4lpu1fg44BEVSIhH2UBXdDy26zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830782; c=relaxed/simple;
	bh=S3b/VRwDTUJ4s+twkMR3NC3mk+70FuYfQJceDvHhY9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ip/ItmxO7D+BTJ1YEdGbWxLk3katZ5ukZlIQ69XRW1hKaeTGCNSHLK7wXrDbVwNA8BIfQSBZ1lUkBTk4brK5Hp/Kj5qFWaECP5ReKKQyaabmVqtFYg1gXIjJKSqEQSudGQEhaO3zBQdXmyTqR28D57M/Oxbz4IHbjosRAdZFECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4+pq4ez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4+pq4ez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89D01F0089B;
	Mon, 12 Oct 2026 18:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830778;
	bh=Cqry1YQ5WFJDGp79qjYi/VO8TWrvKqGnNZEmkwr4hoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S4+pq4ezGwe0UIrVgOsXaFNUJEC1jeY8FCSNrGhTNOjHP/ZK/heH6on97JKfi9IBL
	 2kPdPMBsnFafKx7zJCmxReFkBPTZU3wXyWIVqmrYnPNnTRgkBwkhwhnwYzQPiWwpa2
	 Ku0ExH2eEcVrByG3avry1f9lubxpzADG/XdSaCgRAC9UYdW2lEMOHLbVpZxj/KBGch
	 p2URdTFu96wrbmmODb0tJFo0tIaYaJpn2/3dV5vARElrqMlE4wnWr50QAsBklNSXRm
	 /g1k3ZigzEXdsle/nO2+TDeDQxXv5rFcmv0m18shOEaTSLLTGeMP/TNRb5Tp7kQ7wF
	 U6V0UnCp2o7DA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishal Badole <Vishal.Badole@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] EDAC/amd64: Mask UMC chip select to the four implemented selects
Date: Mon, 12 Oct 2026 14:46:16 -0400
Message-ID: <20261012184548.1192314-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101211-revered-disinfect-7f73@gregkh>
References: <2026101211-revered-disinfect-7f73@gregkh>
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
[ sashal: adapted the change to decode_umc_error(), using err.csrow instead of err->csrow ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4fce75013674f..08cb7d68c160e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2940,7 +2940,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 			err.err_code = ERR_CHANNEL;
 	}
 
-	err.csrow = m->synd & 0x7;
+	err.csrow = m->synd & 0x3;
 
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
-- 
2.53.0

