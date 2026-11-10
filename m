Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321277;
	b=Qv40rffbpDaTi/Rk3YETGdIF7QoaqhYjGykM66GhFyGa6g/cmw0aWxwyaUOBfQ3Ayt4T
	 opT9PUgmzfD0qzNCiEqeqQ1udsM7AdCFQ4iI8DHjiVDH0rm/h1NVHhXp41ZQujjOBaJt6
	 bSl1rLH1VvgPsPZm6pKqrvifOK4ITOhUnS1DHJqmVBZOmr6nBxapXS1ZuHqspq/ek4pIP
	 fAT3BOzWY5CEV3dppod+rOBdYtr6fFlo9By+RBQ2l/JqeVuAyoH7bTJ3jD5d5vGEja+q1
	 yAASvi2qWmYuaFVUvCOXYgxQWm+/KOH9/ctzikdfdpaOqYmwQ4bT73OykZH83UMJszg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321277;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9J9Tz6aao9tjU/4BmQ0pXrC2CaQBRw8uAzmWwNTSaSM=;
	b=QID2WpXhXBXMmwLcFtkwuIvDmiUIG57JK3l0KSjjog6x7QG6L7EG8czRKZ/hRZZdyFWN
	 V79sKMcR/P1vyOTeyxmeJYbJ4XCI5W4Xig2Xp1GX9q9vyEAtfpaI551ZUS/83+FVgwKJg
	 n+pHZIbDPcZHOsqEc3OlmQtqzJ6c6iPemg6AsFkn5Xs0U+tEKuCjZ7X3t5OGp9k9LP0Y0
	 mcyS5CeHycADfu8SqDVyxuNL8iIucTq9gn7qH9ttdvVLqAOalKxLIyhJRKzvQOHlcwVLN
	 d+iYytwmbKa3ZvV+YxI4MEHbWoqK+vH7DvHZpXcOsVtRCMu/cGRO4RpSpVUlJzXs1gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hrVEDm+W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BBC60A260A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hrVEDm+W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C881F0089F;
	Tue, 10 Nov 2026 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321277;
	bh=9J9Tz6aao9tjU/4BmQ0pXrC2CaQBRw8uAzmWwNTSaSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hrVEDm+WGpACtHcDwTjJlqn6IBmwlXD8P6F39tjZ9cle2DSO4yUDD3Wn5OUS1O4ZE
	 a+3VW9RV/IB+l2wVw7kbNwbjS6JcGUBhW4beavU0K1GY3RTuLYItnvgdnEDq8ZzRL5
	 BJ6KsyL6MHCdPskI3XU4C/7KvA00s3iqv/XvJ0bcmK72wDkMRq3ExdzsXfRHepei7d
	 8rnKZhtd8qHB3G6Je12GRxoh3/SEo1bPsv5gWPvy7LHvdFr3vXufVVh2Pk/5oYQqwS
	 3j5qtyzv4gPuWww/Szr1t8OyogyLFUu/yQ6HTIWjeVhKiy4q6OL2w7mXIUk4eTgcRF
	 ivKaqb85Pl/EQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ata: libata: Add an argument to ata_eh_reset()
Date: Tue, 10 Nov 2026 09:34:34 -0500
Message-ID: <20261110143354.1881074-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050648-failed-6.18-96fdeb7e3fd8@kernel.org>
References: <20261107050648-failed-6.18-96fdeb7e3fd8@kernel.org>
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
index f21efb0f6419f..9d35b4f8d3929 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2812,10 +2812,9 @@ static bool ata_eh_followup_srst_needed(struct ata_link *link, int rc)
 	return false;
 }
 
-int ata_eh_reset(struct ata_link *link, int classify,
+int ata_eh_reset(struct ata_port *ap, struct ata_link *link, int classify,
 		 struct ata_reset_operations *reset_ops)
 {
-	struct ata_port *ap = link->ap;
 	struct ata_link *slave = ap->slave_link;
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_eh_context *sehc = slave ? &slave->eh_context : NULL;
@@ -3863,7 +3862,8 @@ int ata_eh_recover(struct ata_port *ap, struct ata_reset_operations *reset_ops,
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
index 9f96ca2acfd90..506a649b73d58 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -192,8 +192,8 @@ extern void ata_eh_done(struct ata_link *link, struct ata_device *dev,
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

