Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703052;
	b=Hht+nGccFPt1hIIi66c2AnYQB5G/ztbZAkrXsUHT7AKkaqeoO8mbBvoiII/LIT26Q1H7
	 G8m1qLoKdagqncm/q5CvrDxFpX3KWK+iQyRwLDf/8chw3lsKi1DFrgNjMxZwUdH6bfHZr
	 j14bVxAcpDXA3335t0fseoKtaNhNwJjSzvdCiFLh4qDkN9UC3dtP40avK/31wA5TAGUBQ
	 eKGSyHt6zRc+hAHyggoN34x0SVJEHgsVe+FCtetVq86CQMFzqEbIK7SdDOJZl/LofYKXt
	 XtvBYt40TVgAZVorKoJ4Ls3D9vukdGyM4dt3FcbjWQBPPfOWzIYQkkJzT2NEewPF2pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703052;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=SArX9XVqloIYHWw6ONOSTBfOAA3vGsK89GBFMyWKyoU=;
	b=IcaQZx9SDnGU0kSFIS48LalUSvFs5G96bH9nmXLlYt+6DUAeoPfFxsx5/drjkR5q3fAT
	 NrSwiYOGi8Uvqx33TV0ASLUg9d/UEry4qgeg2KA0nL4uJERrIDqlqFzSd+njQUOHIC6tT
	 BOrpOkbsGrTIiSQJLV8d6KQpmmrQ7C70sO6HEvPep/34K4MTJEptkp2GzUAChOxdP3TZg
	 ETsF6xgYnmxhi2NrXFbjZxqxLAhduH4T02384RWYOP2DTq9/E1FQtGQIjGsZVQlPpwoXt
	 3tRyefLJ7cpl2tcpIeh8HJQdbp+NAgzWp5yoxIXQsvmLyfqB3FseK3ozhqcU4ulVaTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laOsEpoH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60753606A31E;
	Thu, 26 Nov 2026 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laOsEpoH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7379F1F000C6;
	Thu, 26 Nov 2026 14:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703051;
	bh=SArX9XVqloIYHWw6ONOSTBfOAA3vGsK89GBFMyWKyoU=;
	h=From:To:Cc:Subject:Date;
	b=laOsEpoHZorQqq6k8gihrUT7wXes/JcWfpXet5cCfVyb9mPRNZbSZbTm7At5QqvGj
	 qqOeBrFboJVcZgVItsn+QjuFO9618YHfsTGd/eo6HY/+wWu3rDIsK0dFeKnO+7eOXQ
	 ZSBx93uTaeZeQQpccc/GnBNzwMfVbeV5JUARF8x1nonn6TZq3Owb3eLV4FM6crkTJr
	 AMCvJh+WRbhS8rOvgTqZsdW6ZNhExmdbnLR7+5Vw0Vuq9mRg7aOt+b7Q7huOaAdAJ2
	 xXppaOYD1C1cyk7LttXlNFxLqxIZOPqj/cA7nuIMVOEhGB46b3N3ank+TjfxnDKwxM
	 gDr5h3ODDwj7g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mohammad Harsij Sani <mohammadsaniac@gmail.com>,
	stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-core: Disable LPM on ADATA SU650 with firmware XD0R3C0F
Date: Thu, 26 Nov 2026 15:24:07 +0100
Message-ID: <20261126142406.2753290-2-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186; i=cassel@kernel.org; h=from:subject; bh=TB6y6btYn6kAJ9iIKpDD21WRYysuUToBajcCZalWPNE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLI5HNnETk9ObjIV/d1hrvSq49Pf5ws1502a65v1KfnNB pmZz/+WdJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAitesZ/tlUtzl/YPoc9XMm y/OHtZpVjx6dS+j57Vk5R76n+VbAP1uG//kLfuxneBK7vD36dduljNfbpp3u+B24t9NzcfBC/Vq Z9WwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ADATA SU650 SSDs with firmware XD0R3C0F drop off the bus with NCQ command
timeouts when LPM is enabled. Disable LPM for this firmware only, as the
SU650 has shipped with several different controllers.

Reported-by: Mohammad Harsij Sani <mohammadsaniac@gmail.com>
Closes: https://lore.kernel.org/linux-ide/CACeOiPg=3_wY40upkFVkWQvJouomoTF6Ro+eL_DimkunYVSUFQ@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Mohammad, could you please test this patch and reply with your Tested-by
tag if it fixes the problem?

 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2a5ca1b9ee5c..d234c83e0463 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4305,6 +4305,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 						ATA_QUIRK_FIRMWARE_WARN },
 
 	/* ADATA devices with LPM issues. */
+	{ "ADATA SU650",	"XD0R3C0F",	ATA_QUIRK_NOLPM },
 	{ "ADATA SU680",	NULL,		ATA_QUIRK_NOLPM },
 
 	/* Seagate disks with LPM issues */

base-commit: a12cc63129380a5364e787d92b30a3257f66c250
-- 
2.56.1

