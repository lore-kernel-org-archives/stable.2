Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.92.40.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880567;
	b=qHZ+7TrdU50e3cva8MgaYEqe9wFcf5HcKa+cW3TiGH5iuQNzT7EXQmQiMFWY1xOkQVGl
	 Jp84CvDZyUWm9311ha4uMj0gRYPtBgG0WmBvo88p96QP4kFZ0LgXRmVSuCZYdi1oV5dWy
	 v5Bmdbl6mltVSY4RMXOpyWYY/RdvLm9gLfbvQljqsFOhn4jSwFvTrZadzDNibzANFAhAJ
	 meZ0GAagryVJAHg/Eh+zpmg8hAxIcB9F86Tgr0Q3H+lkRki6CVisHVUanfqx9qYYlhqvH
	 k8EEQIgqSMumDuh647zL35rkQbWgkIU0WBtde7I+HQQFv3gbIOgevTK40NTrknGofEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880567;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=IE2EXi4hrSJEGdlIas7SFiNTlxXFjX2s+WzRPhDdqpU=;
	b=FFum5TEAi80ZFfocEf4Cf/cLLfR59LmYBrmCtLPfnvEAMBaQ2LAS1+VC0BpQijNvmBGs
	 1TLy2uIrgTyaBBvssPje61M74DCeVXY8F64GtQ4FDBAUUNc+5OmzazbljH3c4g1l6sEie
	 +i3PZk1x/EoD9OpCY++ja+DOv4cEPnspH04LHj/i33cJxO2oOUimLpyV6uxzh5NkfbB6s
	 Ziqt/1QLDyTVHk5U3Y+IPJbqeEklTaRKVhp3ii3ElshWjGsr7jlOjlRtzpr9GKxzEUMXD
	 vc25BeRF/4LIr5vMb35iokIN8FfM3vtc8Vc/JDm63C44WXUdE0JruXQtXHpVcLfNpPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=thorsis.com;
	spf=pass smtp.mailfrom=thorsis.com;
	dkim=pass header.d=thorsis.com header.i=@thorsis.com header.a=rsa-sha256 header.s=dkim header.b=J6FeY78Q;
	arc=none smtp.remote-ip=217.92.40.78
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD158606D80E;
	Thu,  5 Nov 2026 12:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD158606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=thorsis.com header.i=@thorsis.com header.a=rsa-sha256 header.s=dkim header.b=J6FeY78Q
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3502C14966AF;
	Thu, 05 Nov 2026 13:10:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1793880600; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=IE2EXi4hrSJEGdlIas7SFiNTlxXFjX2s+WzRPhDdqpU=;
	b=J6FeY78Q2ba31pSIw6qKhpyrjCakNjNJzkJfrYFrhUxJqjPSv8B1VDnUJv9KC54lLQvbla
	K9FwHqSUC8tlFsJRVUQOM5xp9QFDiJi/NCiewYku358Az/ISg/qFN5nylbheEoxnb/r722
	HY+6/M60GT8th85mMR6zMO5d8GV1whVWi0iBYezTE+TXWzOvUTTPOyFQsylDCThgtBJFyn
	yccaEFII3MkGoT+FYpnkjbElGYaRaMcBPllZ2NNVn4FeefmOC0X+tB50l1YyC8mlTDgUFC
	PQl/fFJj2leHMwTV0WEhVybilgOgXdLAnnEIezT/rsfNXEUjZFBdqUvOQ73csA==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 09/16] nvmem: microchip-otpc: Fix swapped 'sleep' and 'timeout' parameters
Date: Thu,  5 Nov 2026 12:06:45 +0100
Message-ID: <20261105110715.2486432-10-ada@thorsis.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105110715.2486432-1-ada@thorsis.com>
References: <20261105110715.2486432-1-ada@thorsis.com>
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
X-Last-TLS-Session-Version: TLSv1.3

Makes no sense to have a timeout shorter than the sleep time, it would
run into timeout right after the first sleep already.
While at it, use a more specific macro instead of the generic one, which
does exactly the same, but needs less parameters.

Fixes: 98830350d3fc ("nvmem: microchip-otpc: add support")
Cc: stable@vger.kernel.org
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    v4:
    - Add Reviewed-by tag (thanks Claudiu)
    
    v3:
    - Reorder tags
    - Add stable tag
    
    v2:
    - Add Fixes tag

 drivers/nvmem/microchip-otpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index e2851c63cc0b4..bf7e5167152cb 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -85,8 +85,8 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
 	writel_relaxed(MCHP_OTPC_CR_READ, otpc->base + MCHP_OTPC_CR);
 
 	/* Wait for packet to be transferred into temporary buffers. */
-	return read_poll_timeout(readl_relaxed, tmp, !(tmp & MCHP_OTPC_SR_READ),
-				 10000, 2000, false, otpc->base + MCHP_OTPC_SR);
+	return readl_relaxed_poll_timeout(otpc->base + MCHP_OTPC_SR, tmp,
+					  !(tmp & MCHP_OTPC_SR_READ), 2000, 10000);
 }
 
 /*
-- 
2.47.3

