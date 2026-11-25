Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597937;
	b=0eGmTt0Clfuc3u956kGntzjyDX6hQzaYuB/qTtX0yl/FCyyyUUsZS7ywN6qtlqBlWYUX
	 29ddRKIHkWOCihl8yNxKaCXZTqGaA65K6S8+a3Qjwnmy/PBifjGpsRHbGv5wVAjE6hllE
	 TsR2oOMuZq/qWjCF24we2x5vITTRSyX9wGW3zQ5780v3A+DO3L8TTr8t8UjWrgZY5koq2
	 Fazwz7YhbpiRyBWHCq7vaP8rYwXrLDpGYny828QhDC16agI133LkYVILjbXp840TnOyTn
	 eFRugjeRAGYLKoGP+af4/nO8U9mAe/Zr/gHKoRcxMAkK3gYfTSOywLKolELPJy5TF2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597937;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X1ZqySHtnjxludZgvu6I0X8CfoCIITQ2WGO4oo5fE64=;
	b=pvwGStP7QbZLUOaAnkEc2422GnxLerciabL/g643gs+Vft/Vr8Bd9L8CAqnbkpM7GTzq
	 QV4Jxp4S/29Yh37hqF/vSyiPn6Ql1D3mP1/oSQZio/LVoAxTyenEFineGgJ/9Ht7sNA1z
	 2QhySZEUOQFaZE32bATO9zPQFUXJLobih7o6uDb2eeII+R/E4k/jnThZhAIdk/MeVotla
	 iFgCr954fbZN0CrASBfFaoIFjZ+f/2eK4ROhZE367xyfEBzOpCb7tQip2di5qFIW77gGS
	 M3CP+H2sphdQw6hKev0J3jK8YQpAxMPdhihifJ/wJVesq5EYKXb7fXeEgjxUxkdW5lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="WtXkL/P8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D025606A32D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WtXkL/P8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A7E1F000CA;
	Wed, 25 Nov 2026 09:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795597936;
	bh=X1ZqySHtnjxludZgvu6I0X8CfoCIITQ2WGO4oo5fE64=;
	h=Subject:To:Cc:From:Date;
	b=WtXkL/P8pGmD0Z2dZTTpuxkG9pFj0vhllxjOyFQHEVSR48eM+qoSoN2r9YFjgnvNM
	 XW7PcMVuaZ4zehAVlFBKfErqJrZj52g7LCjfMqnbOW7WSZXZTANLaXck45uW844+do
	 p3SX5oX79PCdtIieGLLzWK/OKsooRFMctE/kQsAY=
Subject: FAILED: patch "[PATCH] hv_netvsc: Stop PPI parsing on invalid metadata" failed to apply to 5.10-stable tree
To: ernis@linux.microsoft.com,davem@davem-thinkpadp1gen8.ibmlond.csb,haiyangz@microsoft.com,horms@kernel.org,liuwe@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:00:17 +0100
Message-ID: <2026112517-devotion-snack-1302@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 19a227903e65c7a9c179156485660a4e017575fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112517-devotion-snack-1302@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 19a227903e65c7a9c179156485660a4e017575fe Mon Sep 17 00:00:00 2001
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Date: Fri, 30 Oct 2026 02:34:59 -0700
Subject: [PATCH] hv_netvsc: Stop PPI parsing on invalid metadata

rndis_get_ppi() uses continue when a per-packet information entry has an
invalid size or offset, or cannot hold the requested metadata. However,
the remaining length and entry pointer are only updated at the bottom
of the loop. Each error path therefore retries the same invalid entry
indefinitely, repeatedly logging the error and preventing receive
processing from completing.

Return NULL on these validation failures instead of continuing. This
terminates the lookup when malformed metadata is encountered while
preserving the existing behavior for valid entries.

The issue was reported through an internal bug-tracking system and
confirmed by manual code inspection. The pre-fix hang has not been
reproduced locally.

Fixes: 44144185951a ("hv_netvsc: Add validation for untrusted Hyper-V values")
Cc: stable@vger.kernel.org
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Wei Liu <liuwe@microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>

diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 9b6c44979b4e..2c30abf9faf8 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -401,12 +401,12 @@ static inline void *rndis_get_ppi(struct net_device *ndev,
 		/* Validate ppi_offset and ppi_size */
 		if (ppi->size > len) {
 			netdev_err(ndev, "Invalid ppi size: %u\n", ppi->size);
-			continue;
+			return NULL;
 		}
 
 		if (ppi->ppi_offset >= ppi->size) {
 			netdev_err(ndev, "Invalid ppi_offset: %u\n", ppi->ppi_offset);
-			continue;
+			return NULL;
 		}
 
 		if (ppi->type == type && ppi->internal == internal) {
@@ -414,7 +414,7 @@ static inline void *rndis_get_ppi(struct net_device *ndev,
 			if (ppi->size - ppi->ppi_offset < ppi_size) {
 				netdev_err(ndev, "Invalid ppi: size %u ppi_offset %u\n",
 					   ppi->size, ppi->ppi_offset);
-				continue;
+				return NULL;
 			}
 			return (void *)((ulong)ppi + ppi->ppi_offset);
 		}

