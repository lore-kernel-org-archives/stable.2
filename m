Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794802577;
	b=5C4pqOq9fAByrV+Ja0zke3mLJVNjP+ta++bW+TNIxnI6YtM7wFiLgQE/LHUMiipxw/aT
	 /+3IqHK5rpmTwytnYmqG/WbCLRDh1xIH8+Uq+Na4QAxDA6ZyNO/ZXmh1w8JIU9641BG9Q
	 NLyo71/4/a4k/sn8XrF5y9OdrKv2pCYP+aEcfE5mzKhThae+60k6XAf5wFXyxtD1QPVSM
	 Cno0E0jUqwO9mTR3abjW2BHX5vdK7ezouVdIarMf2L77t9nUNj3oH0KMRrRf/+bwjkk/6
	 mMy29PuP5aTiA8Cuxm+cj3kyw5iFE0IN5TRFg+R4AS42S4Dh43SMDxg469Ma4WSHlSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794802577;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=pjmbWb2Lje8tGPxgjuae32cwUfNa7HeNQCPIdazfluI=;
	b=A67+mxKXLWN1iKY+WUfqN7X51Elg21ru7e0p087Bd8khiwPwNqKuj28//lTX5/nUS3jS
	 EnqIvOlfKwLCMf/hSuvlKkQvMK2DGklIX8lBLurh1xr6rWY1sV/cq7w6s+bjNhMJuE5GB
	 RV+U5yiSqcoz+fQbQCxpy4fEko81CpafDcjJUO6lM28NpNry61XezU3zmbyd24QQOwz1X
	 r/sdwKJVh6ZEshOVOCxZL+cS8KKGeQVBr4rcl4ixa9T3o8hM1ZbvCRgmSvq7a9arKPdsR
	 +IgEU5y0vQJgAWH4XAY8uechOpMOF8L09IMF3hLxeqDDXqZNMbNFWIxWiYdLM6yikCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Mu48bp44;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91DC606A31F;
	Mon, 16 Nov 2026 04:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B91DC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Mu48bp44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=pj
	mbWb2Lje8tGPxgjuae32cwUfNa7HeNQCPIdazfluI=; b=Mu48bp44yXnW2arbmH
	olSwt92HnUyG67sWgxVf2s9ynhCCHI+NlSS7IKQlYmkJRkirs7TDb8lOqPhVjlX+
	ahMvtGOq6HeAUQKYDnld7VhhpROm5Pw4EWgV1OAcKI9O5s+5kbR+I6ZMG+mgcApp
	DqB5HZszm0/iF6PWJ2kHhZtSk=
Received: from WIN-TOG0NDEIICD.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXP_Nng_pq40UOIg--.4498S2;
	Mon, 16 Nov 2026 12:15:36 +0800 (CST)
From: Shirong Zhao <shxzhaosr@163.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] wifi: brcmfmac: drop glom superframe on header parse failure
Date: Mon, 16 Nov 2026 12:15:34 +0800
Message-ID: <20261116041534.24-1-shxzhaosr@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009072232.18-1-shxzhaosr@163.com>
References: <20261009072232.18-1-shxzhaosr@163.com>
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
X-CM-TRANSID:_____wDXP_Nng_pq40UOIg--.4498S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF43ur4ftw17uryUZry5Jwb_yoW8KF45p3
	y0gFWYkr4DAr4rCrWxAF1IkFyFqa1jya4UKFW8Wa4fuF4rArn3tr409Fy2gr1jyr4qk3sF
	qFWSvFnxJr9FgFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4zuAUUUUU=
X-CM-SenderInfo: hvk06xhdrv2qqrwthudrp/xtbC7QhUkmr6g2igjgAA32

brcmf_sdio_rxglom() uses rd_new.len_nxtfrm and rd_new.dat_offset
right after the superframe brcmf_sdio_hdparse() without checking
errcode.  On parse failure those fields are either uninitialized
(the early -ENODATA/-EIO/-EPROTO returns) or hold a rejected value
(the -ENXIO bad-offset return), so bus->cur_read.len gets garbage
and skb_pull() runs with a garbage length.

Check errcode first and drop the superframe with the same cleanup
used for a bad subframe below.

Fixes: 9d7d6f95bda1 ("brcmfmac: streamline header parse code of sdio glom read")
Cc: stable@vger.kernel.org
Signed-off-by: Shirong Zhao <shxzhaosr@163.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---

Changes in v3: add the Fixes tag and Cc: stable as requested by
Arend van Spriel.  Re-verified against current wireless.git main and
wireless-next main: applies with no offset and no fuzz, and
build-tested with CONFIG_BRCMUTIL=m CONFIG_BRCMFMAC=m
CONFIG_BRCMFMAC_SDIO=y (baseline and patched both compile clean,
0 warnings, including a W=1 pass).  No code change.

Changes in v2: check errcode before sdio_release_host() so the
cleanup runs under the already-claimed host, avoiding the extra
release/claim cycle (suggested by Arend van Spriel).

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index cea52d4..d30468c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -1649,6 +1649,17 @@ static u8 brcmf_sdio_rxglom(struct brcmf_sdio *bus, u8 rxseq)
 		sdio_claim_host(bus->sdiodev->func1);
 		errcode = brcmf_sdio_hdparse(bus, pfirst->data, &rd_new,
 					     BRCMF_SDIO_FT_SUPER);
+		if (errcode) {
+			/* Superframe header is bad; rd_new fields are not
+			 * valid here. Drop it like a bad subframe below.
+			 */
+			brcmf_sdio_rxfail(bus, true, false);
+			bus->sdcnt.rxglomfail++;
+			brcmf_sdio_free_glom(bus);
+			sdio_release_host(bus->sdiodev->func1);
+			bus->cur_read.len = 0;
+			return 0;
+		}
 		sdio_release_host(bus->sdiodev->func1);
 		bus->cur_read.len = rd_new.len_nxtfrm << 4;
 

