Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625994;
	b=Ye4K2Q+8/YRMB5AppaRKfO4ZV90HGhDZEOVqGOysgqgNYtO6jy2LsbOBxHOP+vezN3tU
	 qFbvaygekMfqL0nf9eJa8r4Sv4aqe6sT6hyd8YvoaiMhn00xIPbJECyqTRohUUfPIbLdf
	 Jj2R7k1K+MgEz7gxyRW+ImIoXhuYs/joEkNkDkEDQ5ZiymRN5+TS6b4BYKzuCjfBXxdcY
	 yamnwLtHukWS0bAl9kjtsIgLxfxROW7XDdv9lJYnELa6XeldSLN+smx9unC6+CDvAfjnC
	 AKgZkARGWtihWgWa4NUhPmNyLXDfUtnxc1A3/kR3elGtjFVefbjYfUgB7trqBFdz2Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625994;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=mtcJUjTnVp8qLLTt0jWUA+2q1Eivfu490RqFDvDWBiE=;
	b=CLa/lUZ4s+IfX31+6M7Boc5IpUpKNIC3CSGyf5B6GaReQ3NidbDcqN862aolKFgOeyzQ
	 nc7LHoHh9cGDY1Uvj+DhAaWU2YjRqxMfA4epOiNxEbjbJLGvlrqP9hElZod6McOoypsWk
	 5O+AirP9jtwNkU/2znDwnR1sR/XnRswSyaCDrJBpNta//hi0X3g0hzCngqSrHchyIx7UB
	 +pI1E9bZPtASHR8+NiB1T3PppFhW1IFtx6+poKxFOMSZTuTjpvEiu/HQAZLcfrvGAa70D
	 W7SAQREUbxOEY2DckBeyBCPCJBELHpMPWSsm3N2QaVjYoeuPyFTjhLcj7Qt+0eP2KPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=TOJj1CjD;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1746A606A327;
	Mon,  2 Nov 2026 13:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1746A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=TOJj1CjD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=mtcJUjTnVp8qLLTt0jWUA+2q1Eivfu490RqFDvDWBiE=; b=TOJj1CjDXnPSH+YSXHSMLwh7IF
	VdROMr8zYNIj9SorITCkbQTpbizvw9x8RyuXvtjx/S58FCyx5NArK1Vsy8hCnAFQeH55B3N58WBjN
	oG26zI9WVIr4gM7iPfpADkCY22wNdxKGNOF31MxIDRQN3S9xzGJYKZbLbJoYg+o+48tY/ROl1zaHu
	V2rac3bwd3ZFhIp4DK+xb4qZ4bT8ruRjPyMjNS6/yX0vVZnCHmKH1nOii4ki29cXO1p/gnfw8BbCG
	Dzui0t7mJJikG3J68M0zZxrZWoPil5DCw+BkHVsoA7vLNihie2sy05W/wLMaDnIzKu4xmUBh7Qlic
	No2vStsg==;
Received: from [151.115.150.205] (port=37584 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xNs3S-0000000BJOY-3mai;
	Mon, 02 Nov 2026 14:26:30 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v2] nvmet-auth: reject incomplete DHCHAP messages
Date: Mon,  2 Nov 2026 13:24:19 +0000
Message-ID: <20261102132419.2306396-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
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
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Commit c9359401036e ("nvmet-auth: reject undersized AUTH_SEND
payloads") only ensures that AUTH_SEND has auth_type and auth_id
before nvmet_execute_auth_send() starts parsing the payload, but the
DHCHAP path reads t_id before it verifies message lengths. A two-byte
DHCHAP NEGOTIATE payload can therefore still trigger an OOB read that
KASAN reports as:

  BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_send
  Read of size 2 at addr ffff8880030d8364

Require the payload to cover the minimum DHCHAP message length
before parsing it.

Fixes: c9359401036e ("nvmet-auth: reject undersized AUTH_SEND payloads")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---

Changes in v2:
- Check the minimum DHCHAP message length.

v1 (2026-08-11 18:03:35 +0000): https://lore.kernel.org/all/20260811180335.4161138-2-Jeremy.Jean@oss.cyber.gouv.fr/

 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 70136f6c22e8..a15f21fc41e4 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -301,7 +301,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		nvmet_check_transfer_len(req, tl);
 		return;
 	}
-	if (tl < offsetof(struct nvmf_auth_dhchap_success2_data, rsvd1)) {
+	if (tl < sizeof(struct nvmf_auth_dhchap_failure_data)) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		req->error_loc =
 			offsetof(struct nvmf_auth_send_command, tl);

-- 
2.47.3

