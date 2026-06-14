Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125E39D3C0;
	Sun, 14 Jun 2026 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781447065; cv=none; b=oqpBrq6CYRn3CFgp1gP7FhZiuh3jUmbhhpWKCcvyf6Y98Ec/6Gn8kXPN+QPQSDgZxstav10r4DQrKm8wDyb3Jd4PKqgd6L73I9bq+A2bJoB/nvAgCIorMNEyIyW1TrlKFfeYyuyyA0HWIJVRpD8bGHMUajTOppU8HPvTvs1+Cuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781447065; c=relaxed/simple;
	bh=snD3V6hpHN72HjYbqTmiGvKtA0J3xAZ2znA1CV42hbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVoL8fd8Of+QyB8tb7rc8NhzRQWRhvV9KXNd4K+Hmlymf1QYN2rbtQ8+zJD6OGt3AMj/Cfc/nOSwCfHk4vw/e0G5snmByGZ4SLKK7Y87U8X8rVosnNTWmuowAsX8zuZ+xLW4W4csftZDTXw+Wvc2UViw3aS+gyXbe3PXXwe/VCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hdpIUGhP; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hdpIUGhP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781447061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XqWPcBKIxm+6NGwzWSu2glLIgf4cePonbI2GNDG/mss=;
	b=hdpIUGhPeL6MJSvX4DcbFF5ZC3OJoYFvSbJHB2JJHNC7iZ2uVFWezHp/sX62wLyqrUrzs6
	7H8UlX0FQLeWkw3rQNfOT/px7kG0n8aC8FvPJA8U2t+GfDSE8DlVoo0Tgy/8Y1FfWpMmsS
	UrG61GJ0BsbpeQRUE1HdBeJN51IB3vI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Pratik R. Sampat" <psampat@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pseries: fix memory leak on krealloc failure in papr_init
Date: Sun, 14 Jun 2026 16:23:56 +0200
Message-ID: <20260614142356.658212-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=thorsten.blum@linux.dev; h=from:subject; bh=snD3V6hpHN72HjYbqTmiGvKtA0J3xAZ2znA1CV42hbc=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl6O2vEdIOL/m/wNnfeHz1F9Ou+1emSVsuNPO/8qMrND VjLc9O8o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACbyZA3DX4F5QsyLAi8K62yo 6XvFZhTxY6H4fhsfw4LbjFHeV99rXGb4H3bppvRzwxuz+0LerDA8v3jNh8mTXnz7K3f+r88Hf/5 Ydh4A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When krealloc() fails, free the original esi_buf before returning to
avoid a memory leak.

Fixes: 3c14b73454cf ("powerpc/pseries: Interface to represent PAPR firmware attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/pseries/papr_platform_attributes.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_platform_attributes.c b/arch/powerpc/platforms/pseries/papr_platform_attributes.c
index ff8adda02341..aacdaa1ebf63 100644
--- a/arch/powerpc/platforms/pseries/papr_platform_attributes.c
+++ b/arch/powerpc/platforms/pseries/papr_platform_attributes.c
@@ -271,11 +271,9 @@ static int __init papr_init(void)
 		esi_buf_size = ESI_HDR_SIZE + (CURR_MAX_ESI_ATTRS * max_esi_attrs);
 
 		temp_esi_buf = krealloc(esi_buf, esi_buf_size, GFP_KERNEL);
-		if (temp_esi_buf)
-			esi_buf = temp_esi_buf;
-		else
-			return -ENOMEM;
-
+		if (!temp_esi_buf)
+			goto out_free_esi_buf;
+		esi_buf = temp_esi_buf;
 		goto retry;
 	}
 
