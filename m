Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856222;
	b=oE/x1zSiHg6OuNOYnwoFRW8DB/Cgld+vQNmWSxnLTO41d6x6D/P6O084BAHfdzj8IiWH
	 faC2vT8WsbobH9aAgOqzgABnKut3ptGR4ehv1+BAq5pPFGqVqbnvrLazcwNmhRjKipPoz
	 m6xE77eqlqnB7G5fVMeFMX/m/r2cHkzuH1HW6+4BC+XIwsjIhOaLBQA2ma2I6e5kMSs8k
	 WsI1JJx9oyYhJm7xxAv7h3HnINDO2FZHipgkxglAOuUBjKs7Y+XuXKSQD0FDBv0NRzFsl
	 B7z9kErvhpYzlteucRkrCz5PJpAB8rGVbuInxEceWhurdA9VtSS73WXQk5wUTys1A6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856222;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=q7quJQjbcEgSpq/gyke/IOIgp9N/Q4BRoTwu35LYo2s=;
	b=zGicu+rlUZ/MDfMOEm2MZDtBjqdQYhtsQajtcz8Uyae9lb+bvv/BxgmTIb6o3BwuSvNU
	 Gry72hXEru5ZSHtOuJ1bHxhBaU3/iDr3G+orJd9Ysb8s1RBTZc9Pb313xCawLF1bx32gk
	 77lW7DKwscKyp/ZNoPACmqh0ya/7La+n+28NhgkRoSCDq+z1iR0WhPzWxzDPGBQYScP/a
	 drc6ebsWRqqaKZYbhbNdgG2s5Z9w+KQLctP3AXniyaVmtzNy2OD/+LWrTskj67AjXUPmP
	 4rRNXCegGr0DsXUc3mwBoF48PA8ghADKPlJsdeHr00RnsN+1sJXh45EF8KjDsyYUN8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjXEw6dy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E658606A339;
	Mon, 16 Nov 2026 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjXEw6dy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365DE1F000CA;
	Mon, 16 Nov 2026 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794856222;
	bh=q7quJQjbcEgSpq/gyke/IOIgp9N/Q4BRoTwu35LYo2s=;
	h=From:To:Cc:Subject:Date;
	b=NjXEw6dynfrJiPnrW7Ks/SDiKl+pIdmUj6KjrQq/q+I2K8m04tv1VG9m5pN+v8+zW
	 kjGiyPfAmdFFz/X/T3mtRqWFAILtMUGsDBLjTLxqto62BfPLANbqULpwGndN2EjXLK
	 56WE/IlYb0dCqzMtEP6GMJZJC1M6kIrj72Tntw1J54JXknsbWMV2ShK57krRlWbnZt
	 NYPyhKLr9LW2/ljPmTQPtgJNvjlj+2oGxN7dPJbH99XoKrwFsJtMCd6WC+dIlrZR3I
	 1DcyF6D6Z3lAX4JZhS5i+Myrb7nCzhtuw9oN29yhnNICB3qAfMxP2551x0tpjAV4xf
	 aKAA/zj+aH3Yg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] ata: libata-scsi: fix the INC_512 bit test for SECURITY PROTOCOL IN/OUT
Date: Mon, 16 Nov 2026 20:10:09 +0100
Message-ID: <20261116191008.2954277-2-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=cassel@kernel.org; h=from:subject; bh=FaDfy+ak9rML5XSD+O0Yx7Udd0jX3OPr4XpvP0nGEzE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJ+hwq4TRfs0pQ+deHHtcUT/0kbKhb9832vvVTNqSpo7 hfhYL6IjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExk2zOG/+FzNUtsnaJuZWt7 HHxnKHTXUYeZm+V1R8ZjXwYfMT3m1wz/PXi0649Ku6+1rxRmdNV+5ehhvuU32+slWQ7/ttf/vzy VCQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_scsi_security_inout_xlat() tests the INC_512 bit with cdb[4] & 7.
INC_512 is bit 7 of byte 4 of the SECURITY PROTOCOL IN and SECURITY
PROTOCOL OUT CDBs (SPC-6, tables 280 and 282), and bits 6:0 of that
byte are reserved.

Test bit 7 instead.

Fixes: 818831c8b22f ("libata: implement SECURITY PROTOCOL IN/OUT")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 87a57495d2e4..ae062fd23684 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4812,7 +4812,7 @@ static unsigned int ata_scsi_security_inout_xlat(struct ata_queued_cmd *qc)
 		return 1;
 	}
 
-	if (cdb[4] & 7) { /* INC_512 */
+	if (cdb[4] & 0x80) { /* INC_512 */
 		if (len > 0xffff) {
 			ata_scsi_set_invalid_field(qc->dev, scmd, 6, 0);
 			return 1;
-- 
2.56.1

