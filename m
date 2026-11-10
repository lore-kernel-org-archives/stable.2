Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323549;
	b=WgC00M42BQTpTE+kJrO7No94yS+o0Zlupte/MMmZSQJUgD7FpZVVTU+ITTX/dY8WOer7
	 0pJpuGEitO3aZ0xm/qSe5gGqrKE7G+EoStouAb+7X9DaKewmBU3ImY6CTpSOJR8z8kgWE
	 37KOcCbqOi0osWN4RiPfVSAJNBaUqtwjRQEGdek0AbtFygl8mpxBrGDeWfgBH7iislYHd
	 fhnptsqn4pqFHGLtlWmIUv1tWfpDkXOoMbghhdh/IxJzo+ox35M38pECXORT8R4Z2f1dw
	 EQ1BDQx2VWHn0vC9fzd9p8kW2gPy+gyYUbEtwX2QRbwYLBZ1/JoJnyWUZL1TsylqKdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323549;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mjj9M4amjf5DuX2ApUozXABsYyfEFFhblKaUuots6Fk=;
	b=bTtV0D/Ds180//H9NpzcKPsPb6R5zeBoEJBjjXntn+KOOGmAlV0r0Z2BAYYbdIKLnljv
	 OnoEKnDTO0cCr8HaTX55gV4MkGCBJP4hVMqVuwjnaf0I9u10tFVQBg5rQkDs/xZWfg06F
	 j3hHRkXHIlimL6R5WUVWOPSW870J3cNbP94q7HzVFG/iN1ynn2ZdpBmp/tlhZkiBgecMr
	 u2djOwSh88p7w0m+Hjbo8oBOpX0ix2fPMinZKc0oJH/99lSWpZaLC7X4JkJDlUINmKOjv
	 DpGWiqGX7TOvs4xja2Uz3J8vjVPo65pEzVRB14dRYmAkKSHErA4LkrtpfA4z+g8ixsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vv9KJRoI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33BF60A263B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vv9KJRoI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CBD1F008A5;
	Tue, 10 Nov 2026 15:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323548;
	bh=mjj9M4amjf5DuX2ApUozXABsYyfEFFhblKaUuots6Fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vv9KJRoIOPx4/GijgCHFQoY9foAXAE9yeOYed1ldCMckrAmY8wct+XwN0uSoYOuG2
	 1n27se03KXHCDlHedIZTmvyFQLsGwuRwhXs8hXXJNLko0+oEB/HgKMNgsd78opz2Lt
	 U8tHLB3JU8GNMYWlIFGrvF/N7VOHoH/Pk64QKzMTTfiQ/A+wnZvROwzgebKeiJueNQ
	 haCtezDgofvwbN65XV+B5lZ+oOzD4JreEfL6my7HhKX0z9hziOtXDCye8MNu85MLeX
	 Avz+lvu1z3x7eH7/HVS2e6kfJiARk4ZwOH1nbJIWncl+L9Xq7CNKgF4UjX1bcBkTih
	 VB5th3lXSt+5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] ata: libata: Add an argument to ata_eh_reset()
Date: Tue, 10 Nov 2026 10:12:22 -0500
Message-ID: <20261110150946.1943054-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110150946.1943054-1-sashal@kernel.org>
References: <20261107051701-failed-6.12-96fdeb7e3fd8@kernel.org>
 <20261110150946.1943054-1-sashal@kernel.org>
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

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 4b3c2ca268b0a66093793466e02d8566d642f19c ]

Pass the ATA port pointer as first argument to ata_eh_reset(). No
functionality has been changed. This patch prepares for enabling lock
context analysis. Without this patch, lockdep_assert_held() statements
would have to be added before each ata_eh_reset() call because the
compiler doesn't know that ap->link.p == ap. See also ata_link_init().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Stable-dep-of: 96fdeb7e3fd8 ("ata: sata_inic162x: remove dangerous broken driver")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-eh.c  | 6 +++---
 drivers/ata/libata-pmp.c | 2 +-
 drivers/ata/libata.h     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 366b7d2a10e5d..b78aa5371c14c 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2632,10 +2632,9 @@ static int ata_eh_followup_srst_needed(struct ata_link *link, int rc)
 	return 0;
 }
 
-int ata_eh_reset(struct ata_link *link, int classify,
+int ata_eh_reset(struct ata_port *ap, struct ata_link *link, int classify,
 		 struct ata_reset_operations *reset_ops)
 {
-	struct ata_port *ap = link->ap;
 	struct ata_link *slave = ap->slave_link;
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_eh_context *sehc = slave ? &slave->eh_context : NULL;
@@ -3817,7 +3816,8 @@ int ata_eh_recover(struct ata_port *ap, struct ata_reset_operations *reset_ops,
 		if (!(ehc->i.action & ATA_EH_RESET))
 			continue;
 
-		rc = ata_eh_reset(link, ata_link_nr_vacant(link), reset_ops);
+		rc = ata_eh_reset(ap, link, ata_link_nr_vacant(link),
+				  reset_ops);
 		if (rc) {
 			ata_link_err(link, "reset failed, giving up\n");
 			goto out;
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 99c67dbfb7536..c3b3af28d17c9 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -796,7 +796,7 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 		struct ata_link *tlink;
 
 		/* reset */
-		rc = ata_eh_reset(link, 0, reset_ops);
+		rc = ata_eh_reset(ap, link, 0, reset_ops);
 		if (rc) {
 			ata_link_err(link, "failed to reset PMP, giving up\n");
 			goto fail;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 0a5f9a4fa906f..f98a3eb5d51e0 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -196,8 +196,8 @@ extern void ata_eh_done(struct ata_link *link, struct ata_device *dev,
 extern void ata_eh_autopsy(struct ata_port *ap);
 const char *ata_get_cmd_name(u8 command);
 extern void ata_eh_report(struct ata_port *ap);
-extern int ata_eh_reset(struct ata_link *link, int classify,
-			struct ata_reset_operations *reset_ops);
+extern int ata_eh_reset(struct ata_port *ap, struct ata_link *link,
+			int classify, struct ata_reset_operations *reset_ops);
 extern int ata_eh_recover(struct ata_port *ap,
 			  struct ata_reset_operations *reset_ops,
 			  struct ata_link **r_failed_disk);
-- 
2.53.0

