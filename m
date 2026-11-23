Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454529;
	b=roH16D5bGbf5KOVE7qeTbSygj5k4kwQqGkqFllQbNgXOkQKDNwfH13A4DMyYPqIubv/C
	 diisdVXwsE//r/kGGBHX5CPy6IvGsIzKLoFTnR/9Inr6U48eXc4xNySHBbXrHfjZeNMOq
	 Lj7U1Iv/kJWiDksTjaAoz10Jk1umwoBkJZ6DRzo+B6wAfJLJd6//JPshfiH6piPzSDCt/
	 b3HiouA+zBMngNwgOS90o06NCg9oVRytjBAdmDjJj+bqSTih2Mrt0Y/WM6lGnEjzx4jth
	 lhedRBn/HAMIBdmiNcG/favSZdGyw02P165bZMThn39IHPas1plAJeOEspiFKB4uvWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454529;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DNXEpr7RxMECQhPGN+nCpAWtYxByBcLCykFr/q1cyQQ=;
	b=OJHLvzsoo4+54QfrcsCAMxHh7MBOsnYC7zWFElbiF3KYAT9SHAUpunwrxR2dF+QSubiN
	 zYKWmehsUDbUHiY//+2pQhzILNOw7s5RC/zOe5IJs7FwcRoZYfhpeazDHEgE9EnXlfHpa
	 Svj3pNFOveDRdjUs5YFtX+w3U4VRpaKTjf6PFaRcIlYDEzhx7XjSwMcEYatubW4eazht3
	 WDtdy0iGQJR7HsTweNLqJU4xPwvFKW+eFvwe4Y7KaebiN8H65lrknPaboLEplBHp8mXWj
	 ZOrkakSqccAL02QEEKO8gHpAlpDuORx2/HW7LJNtg+to11v7CJ3L4A/FgIpe5mj3sEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDDy3Y9N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0D6606A31E;
	Mon, 23 Nov 2026 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDDy3Y9N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA4F1F000CF;
	Mon, 23 Nov 2026 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454529;
	bh=DNXEpr7RxMECQhPGN+nCpAWtYxByBcLCykFr/q1cyQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZDDy3Y9NPt5wQYKmkGzJ4JW7Ke/i0UTWifTi34BMQ26acAoqcjvg1M7SazovpnGTd
	 Suf+1J8RNg28UlJRutInlh/pwGXHfJ87zh8pDg5k483uHbm7TGSHj1BU+3SOC39fUF
	 bhcTFL8xsfoeVHg2N4WkziPcqGVMf/P5wZabWWx1nkCWkSK9lFM9HIGyw10+t9UpCm
	 kjMUORD4EPkfhStsSde5DIiOy8lGi51bqEvwGt0HmUP9bD49mSDqJxX3nyfCEnN0yz
	 1YbMngiWjFDvhwhsRmKrYdJACbOfrn9umgwMel6m0d9e/54u7zV9IvT868iFXn1Eex
	 a0Kj70izIfC7g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Andrew Davis <afd@ti.com>,
	Ohad Ben-Cohen <ohad@wizery.com>,
	Brian Swetland <swetland@google.com>,
	Guzman Lugo <fernando.lugo@ti.com>,
	Mark Grosen <mgrosen@ti.com>,
	Suman Anna <s-anna@ti.com>,
	Hari Kanigeri <h-kanigeri2@ti.com>,
	Tero Kristo <t-kristo@ti.com>,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/10] remoteproc: omap: Fix integer overflow in omap_rproc_da_to_va()
Date: Mon, 23 Nov 2026 17:20:47 +0000
Message-ID: <20261123172140.3547896-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261123172140.3547896-1-lee@kernel.org>
References: <20261123172140.3547896-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

omap_rproc_da_to_va() checks da + len <= dev_addr + size using 64-bit
unsigned addition and stores da - dev_addr in a 32-bit unsigned offset
variable.  A crafted firmware segment or resource entry with a large
da value can wrap da + len around 64 bits, bypassing the upper bound
check, while truncating da - dev_addr to 32 bits yields an
out-of-bounds pointer offset into kernel memory.

Widen offset to u64 and validate both offset <= size and
len <= size - offset without addition overflow.

Fixes: 530a1b57e859 ("remoteproc/omap: Add the rproc ops .da_to_va() implementation")
Closes: https://sashiko.dev/#/bug/linux-e1bfa1ec-93c7-47ac-aba5-bce08be0f756
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/remoteproc/omap_remoteproc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index f52a531877ae..573f8d9ae8eb 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -735,7 +735,7 @@ static void *omap_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *
 {
 	struct omap_rproc *oproc = rproc->priv;
 	int i;
-	u32 offset;
+	u64 offset;
 
 	if (len <= 0)
 		return NULL;
@@ -744,9 +744,12 @@ static void *omap_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *
 		return NULL;
 
 	for (i = 0; i < oproc->num_mems; i++) {
-		if (da >= oproc->mem[i].dev_addr && da + len <=
-		    oproc->mem[i].dev_addr + oproc->mem[i].size) {
-			offset = da - oproc->mem[i].dev_addr;
+		if (da < oproc->mem[i].dev_addr)
+			continue;
+
+		offset = da - oproc->mem[i].dev_addr;
+		if (offset <= oproc->mem[i].size &&
+		    len <= oproc->mem[i].size - offset) {
 			/* __force to make sparse happy with type conversion */
 			return (__force void *)(oproc->mem[i].cpu_addr +
 						offset);
-- 
2.56.1.750.gf70dc682cf-goog

