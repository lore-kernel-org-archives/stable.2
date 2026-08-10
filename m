Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E730C147;
	Mon, 10 Aug 2026 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377420; cv=none; b=MWlv6M2eMaGlY11xDFsvX5vMXI3OP3DmD43pQnxQ5w8JMezstdCWmhgRkIRv7TKhF9z97CkKhdB8JjtvuBgV/WrH2Psq6HXeVj+JK91MgCepxqCkvL7B0PFjzOSXiEfBdPWqf08kIJzXot9sNbG8scdpPok/9SN03PY7Ai7i54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377420; c=relaxed/simple;
	bh=z5OORnIDELNNkyizfQhY3mn0neHYy19nLAXtSsKg6Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PRo3iimmMyDVA+tpH3hAcjwF27DLLaLyNx7GLf63abU7nNM+OdxvTkNFeGTRybZ51dSbKhOZg2FDIDpfml4Elx4QTJtCvxpj30sK5eQ/DXl5iAGIjWMkK3GD+VCOonx38iEV9y3cEHe9d8BrYDBtzLBc37cBjQmLiiHCS11s78g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=cG83vF4u; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="cG83vF4u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BNodjtQH7IlveO3WSomvbpCtk9E9m0/5G10f1oMrYyA=; b=cG83vF4u0AROlOz7+89wosLB+U
	h7DV7vxjKYDZdgTvQuZE1YFuVFORjozgGlexDirSpgiwQDNoQcxfPVZMeRmzpT8xmpt7qqvc9vc5Z
	QqiCpLp8h7QuoIY/nykACk9L147iH6FhQSg0YtS9YKVQQqS9W8Vke1Lo6OUDhru2f+Jf5lO6EnLZ6
	sxh/LECMdM+xjmzwq34Qx89hPzx34+uFkWyRfMVToHLQavgTawqHlbOdAxn73aIpec7bo9ESejeFr
	BXNiSPl2TvStYv2AoezY27SCbHlNEM5yyI29RBiXBJYCSCwX9Rgv6/8Q8hz0qr9amm4lEhZ0Y/XAn
	MrHHgM/A==;
Received: from [151.115.150.205] (port=47312 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wtSMx-0000000F8nT-24hW;
	Mon, 10 Aug 2026 17:56:55 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-auth: reject overlong negotiate identifier lists
Date: Mon, 10 Aug 2026 15:56:15 +0000
Message-ID: <20260810155615.3269409-1-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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

The DH-HMAC-CHAP NEGOTIATE descriptor carries separate lengths for the
hash and DH identifier lists, but each list occupies a fixed 30-byte half
of idlist[]. nvmet_auth_negotiate() uses halen and dhlen from the wire as
loop bounds without validating them, so a remote initiator can make the
target read past the 72-byte request buffer. KASAN reports a 
slab-out-of-bounds read in nvmet_execute_auth_send().

Reject list lengths above the protocol maxima before either loop
indexes idlist[].

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 45820a12750d..8679d5db4f86 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -71,6 +71,12 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	    NVME_AUTH_DHCHAP_AUTH_ID)
 		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 
+	if (data->auth_protocol[0].dhchap.halen >
+	    NVME_AUTH_DHCHAP_MAX_HASH_IDS ||
+	    data->auth_protocol[0].dhchap.dhlen >
+	    NVME_AUTH_DHCHAP_MAX_DH_IDS)
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
 	for (i = 0; i < data->auth_protocol[0].dhchap.halen; i++) {
 		u8 host_hmac_id = data->auth_protocol[0].dhchap.idlist[i];
 
-- 
2.47.3

