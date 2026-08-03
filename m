Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012529B228
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749727; cv=none; b=ePHvzsir2fKa3JRj/h+E5IIA07iZnwrLcIJPxd6su/ZSfg5h0ci/8MTV7m/yb7U20KQqtOXApb7FEqkic+a7aUOrLdxlODQI4ta0dcpv1MXBqOTXXaRCWR8hgns/49rKESJv+kqYElrqi4SzkN7NEWwurkGLDMnHIAuPfA/LRvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749727; c=relaxed/simple;
	bh=DoBL7Qly3tk+RGTMaFUJMUuVsP34uQLJMhuVsoEjrbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WeZnVHTIDVyTMzIa1SBs77r23ZgZBFyM7BE3Z5hwGXaZNv3fWQWsUWPnA5v/fiSKg/7acS6aFBbJw0ThizcQA4b4QIMD9OJQSabVG2TA+T3LhWxOsoZzbfbYmcspzKDHnlYIN0BCkpFtS5zI4WNp4lzeRKmifDPWantVRF9W6BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XZJoJzZw; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XZJoJzZw"
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-529a1ee0e62so16547751cf.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 02:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785749718; x=1786354518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EE8QIzp2YaXHpPmzLAzL2tRMNu4U4ZZi0jVVWshr8xY=;
        b=fVa2zUfFXXQYlk2e2dRIaSCH6W+ASh2KjQXj7LtvXVIkGOuV3XbkYuKnAKYfGMzxYp
         6MbV/ikgBMqOEeJPH20fa9upv9ti4G1D3m45aYTrkl38dVsKjdGjYkJHjyIrs11p/ikb
         EQPKoqi7qu6IKRchoBxi/38fg4pcqizOdR5pDG5XzNjoL6ykgXuNZvs7YyQQwMn+DtMZ
         ALEeZL87QtEp7u8Q6e+3fYxTjX5B+SxbtARSgjrlEiSibY+HBkiiZBfQ4DklGoyzzwTP
         70FFXcygttw5AaY53EJ6nmBieU3b68l0/6rLGY7/266RW7m0GLj4U0Ro9Y5Sxs75LxwD
         HAVw==
X-Forwarded-Encrypted: i=1; AHgh+Rol93jwaoAe3ariLUkuGsXooF1NtbJ+TfvW9dnByP1gx4b+up47N+0/YPKUnPzPVRdpGtqZgmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKECEDskIdYFrF0oYDSXjXxrLsE0hOOtOO3QnS/DaKH4KQLTeU
	r1LTlo4m33i+mmM1a1kfjW56WirRjU5j2i7r8VGYoLpXAPn0SrT35EqBn3rdOsyBXrZL9rE7hNg
	UWVH+aBjOpP6R1ito7NifRnLhGQ64T8MC09oQ/5sBq0jRBgRDX9Flt1iMy9shlQPg3K/XqVK7vZ
	gHRVUHnJog4LsEx4Q9oCd+l9NhDfYo+B2MxvD4PBrxdTmnQsv9GwKgTjB5x61EEopxWIl9xH7an
	8jQaUaGlqb9PGK22Q==
X-Gm-Gg: AR+sD10ztarJdjxiX//V0/i9zXSqdTM6LwYk730cYmOK88GQrndvKD2Xr+VZIK82x/j
	JWOxI64TCbbI+i+Ns8kEn3G9/6pt6dBI+LGAtJIA5tcpVQpdWCzoTJ2C2tULVhbdx6LJOeACtPK
	r8wvD3JguArpGDF+h/ZGmZmWvX8iL4NcJh4rrInA0f+/vSuXFp2XJ6f3spFPaZWgB0I40BwRwd2
	T8vBiZdgcLDPmPDdvK32/7xHt+vMPYti/X6bEUisUZ9E3WcijAvGOPCfUHri+0XsdkUenohzPOU
	WtT4X4qjHpvOW48ebGOtuEt4OzGUcp10T9e4wU6QFJ+goNFUjgF/pLPQEyWgLdxEL8fnnkCoH8c
	n2ZAt9BpnAyIBT61sK+A2a7zctGyh9IxQKRULXRZ0jUEux7vqtafooUv91gDviD17Ofx3A7rsuy
	F3Zvh0xmGi9hlJNXUyA/33ZU1JE6KT2BmHc2mQJnQ=
X-Received: by 2002:a05:622a:1b07:b0:51c:6e:ef23 with SMTP id d75a77b69052e-52b5680e85amr179769341cf.32.1785749717547;
        Mon, 03 Aug 2026 02:35:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-9085703f7a4sm2769336d6.12.2026.08.03.02.35.16
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2026 02:35:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb6433e9d4so4311627a12.3
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 02:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785749715; x=1786354515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EE8QIzp2YaXHpPmzLAzL2tRMNu4U4ZZi0jVVWshr8xY=;
        b=XZJoJzZwSnkZiPW/IVnAl9+6UzPkZNcvJYSs2w1Gz07rssVZT9S1yXwKBHeqTSDs3k
         el8/QNkpKXKyojmFyYSUsN++RWXNgFcw8n9Lv+GFIfnlpc3BH4AIq6sp0+lL7st5NlCl
         pn1oxfk2InhrcOXJdBDITTGF0R+o7kvhsmVdA=
X-Forwarded-Encrypted: i=1; AHgh+RrbyWVcmnOj6TrHuX1Lyj3lcxRafVG/kyr/6j1OiTu8fWNwGZSZjSJwBOkO9ZqchPpBMvP6yPU=@vger.kernel.org
X-Received: by 2002:a05:6a21:3390:b0:3c4:3ada:384d with SMTP id adf61e73a8af0-3c92a57baf2mr8170847637.30.1785749715388;
        Mon, 03 Aug 2026 02:35:15 -0700 (PDT)
X-Received: by 2002:a05:6a21:3390:b0:3c4:3ada:384d with SMTP id adf61e73a8af0-3c92a57baf2mr8170813637.30.1785749714734;
        Mon, 03 Aug 2026 02:35:14 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab2530c0sm29343644c88.8.2026.08.03.02.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:35:14 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wireless-next] wifi: brcmfmac: Fix memory leak in brcmf_sdio_read_control()
Date: Mon,  3 Aug 2026 11:35:06 +0200
Message-ID: <20260803093506.1647790-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Abdun Nihaal <nihaal@cse.iitm.ac.in>

The memory allocated for buf is not freed in some of the error paths in
brcmf_sdio_read_control(). Fix that by adding vfree() calls.

Cc: stable@vger.kernel.org
Fixes: dd43a01c5cdb ("brcmfmac: use dynamically allocated control frame buffer")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
[arend: rework as suggested by Johannes]
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 9f7ed1d293a0..381801af3ac9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -1827,17 +1827,18 @@ brcmf_sdio_read_control(struct brcmf_sdio *bus, u8 *hdr, uint len, uint doff)
 	if (bus->rxctl) {
 		brcmf_err("last control frame is being processed.\n");
 		spin_unlock_bh(&bus->rxctl_lock);
-		vfree(buf);
 		goto done;
 	}
 	bus->rxctl = buf + doff;
 	bus->rxctl_orig = buf;
 	bus->rxlen = len - doff;
 	spin_unlock_bh(&bus->rxctl_lock);
+	buf = NULL;
 
 done:
 	/* Awake any waiters */
 	brcmf_sdio_dcmd_resp_wake(bus);
+	vfree(buf);
 }
 
 /* Pad read to blocksize for efficiency */

base-commit: 4a0bd262df757b25fc4e2a53c947317c119ced4e
-- 
2.54.0

