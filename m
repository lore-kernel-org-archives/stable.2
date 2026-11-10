Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283094;
	b=MKkQF6k0jMebnE22jmeAK4rO8UtL97TDn5astCH7ZZjs9yXAwczJH0zJvV0HEep4oYGc
	 77n4dq/GDaPPjfWxYrf0vUA3fH+RjGPVoGk5njJwg2MsB2wvZ0rsk2xKbBPCGAK8nPb1K
	 f33tFKvUOlNVkvaG8Tt5NN4V7ssrj/mIEoZNZzmo9sRa6nohOVqlXicHxyqouzs9Vz/Uv
	 E80PDRl7Oyuoia9nfBrIKnoYjGjAsHpitpg3Tm4f5oQlHD2Sn6XQkASbafRIeCE/hlsJq
	 WM7+3aU4L/Bb73Nsccgz9LmAYhbSQkQxPP+Faz0dp0os3wcAhrxWU6K38FoHDBM3z3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283094;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HAJEXfY8xu59bhojy0hgs8rebxFw7MJ9wq5Cx00wOZE=;
	b=xJSZjTn6D3pK5E1xJ8rxJnWkG5hEz1jUtY7Z1ulgbG56sdkkV36BiEyuU45M7+DiYDXj
	 2Zvcmk2XuYmqr5I5KMp2g7gmqnnr0kTOyk9PwukXuVdr8jWv2PQE0ADwUKuErPMrEewfr
	 LSeKybJPpZFy7bbTZ/JOsZdqg2UAEiK9zWb47l14IxkbK3SmaLVmi4HFc6ne3NlCBu2x5
	 oLey650bNtsFBxnhay66K7snysDPnRBKL/rZr+EoERnTjHt+oPU67MctKO9v9Cn0f8/II
	 4trdKWrGc1nGlpoDc5lDXTRbJmIHxCzAD+iBbRDkwN2T+ZDDMXZBp/Ai7PNTYp4WmRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDYv5ETL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B36460A2610
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDYv5ETL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E2A1F00926;
	Tue, 10 Nov 2026 03:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283094;
	bh=HAJEXfY8xu59bhojy0hgs8rebxFw7MJ9wq5Cx00wOZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FDYv5ETLKSnsnMzKa9jeDvt8fMpCSUbDW/3P40ceNeCUk7HJ3w2lPO/kiGqb7nZvx
	 MxWaKCMpHEyY2BTUmj8o/VFXSKr5ILbEF0EUFeEMJx4Wrt3yVzKjkCpStvjComMHDc
	 l7eQtbezqy70FdiXiXT3Xjd4Zz6ptdKu1TVWuMrq8ekk4+gHtVccn72yHDdlgPTnG3
	 /6WHgPTdt794cug4shZraCWiIaZnUBUZCI4HMtp/x6dfHlqrxkGqLjyaPr4ZO36JDp
	 M25jqAblWsfNzIKS5eQpIqK37hI4eUPLhPgc0mfSAKcf70nBI50o/eCYJfxyTX7OYk
	 afcWTCi1Uphig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] mtd: rawnand: ndfc: fix gcc uninitialized var
Date: Mon,  9 Nov 2026 22:58:10 -0500
Message-ID: <20261110035754.265724-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061443-failed-5.10-0d66f9895f28@kernel.org>
References: <20261107061443-failed-5.10-0d66f9895f28@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit cceca8cb776b03e83985578f84bd730c30d57f70 ]

Now that this can be built with COMPILE_TEST, an unassigned variable was
found. Set to 0 to fix the W=1 error under GCC.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606141301.iyVdFgl7-lkp@intel.com/
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Stable-dep-of: 0d66f9895f28 ("mtd: rawnand: ndfc: use devm_platform_ioremap_resource()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/ndfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index 0fb4ba93c41e0..b9223cdaa8e34 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -188,7 +188,7 @@ static int ndfc_probe(struct platform_device *ofdev)
 	const __be32 *reg;
 	u32 ccr;
 	u32 cs;
-	int err, len;
+	int err, len = 0;
 
 	/* Read the reg property to get the chip select */
 	reg = of_get_property(ofdev->dev.of_node, "reg", &len);
-- 
2.53.0

