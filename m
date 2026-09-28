Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2863019D6
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600195; cv=none; b=fM/budWIP/GyFCU+3Fk91guOfdk/VMHLAg7Y742xCfO/rPh6/g+wUtkEGLCrUnGadhKMwtPHR2zNZcwimd9j2WRRv3J6eUAaAPOZz6sig62ShiDAjfJV5Hpz0c3Ll96OZmXM8W0ypHrAk3DS/rH+fivnFxveskhMuOjsrVHY/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600195; c=relaxed/simple;
	bh=KUBocqw5cboHcSNnT0W6/Ucblbw9xsAcwi4MHpF6L5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0mwwqIPnueAOryo6ngEtNWyIHCMeYLV9ryQwrnKbXBeEAaP/PfLONO9nM29wqToFpKooXoy2M5LxOpAvKUFohvyOoiAryeLp+VIaqqCCgJF9VqP3A05ETkFF0FDasY76qbb/vPvxKdRZ+1cj6DpeEh6CSMibIARV3yOrJbzipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjbO2WPe; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjbO2WPe"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f05ffcso13526995ad.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 05:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790600193; x=1791204993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X3V0idLX7JfHuxhG0y/iym7zpN4jxFLNmH6tSltjyP4=;
        b=TjbO2WPevBTVpzzxyLIPoV1W55y5TvLr8aAEbMHHdAW1vyjhoVdVt9X5gm9m575NDZ
         HqGeTa8m3zJPoFMzFegAgJm+tBYYJOD4lfGJpGVEsRfzaG1d1UtiYc72HUAoYvdh5tFR
         pSskuYKreDcIVQL+1LeETC2TJ2KHpLYzGkVcEpbnpOtbIwIJlheruzOzPkRYxBhjN5HV
         cwiPMUakS366KyMg3pss4mK/IDukJbHCiQCTZNd3LFNrPRY3yuTdIJgQjhRCGJamzRYG
         yRUEnQZqBocbyQr8RW5dejErU5wG5Bg7fDzpMhl07BGeXyAkQlfyIfd4Dr/TYa9WlhmX
         z0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790600193; x=1791204993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X3V0idLX7JfHuxhG0y/iym7zpN4jxFLNmH6tSltjyP4=;
        b=0ybCMeEUvzoBeP69JNRMDVUXeWk67nwO1IEl8WjLXiErzaF96xrFVRGG8QMRAQLAyR
         COKTTfP7rATYqSDgBzJHpaa8qUgVTJMlkOZk+/8F6owbDLd2K/MyckFTIF8EoR/9MLhl
         +6Jmp8U/YHOtZPyqZMusF4cm9gS0Ckh5yyS+YWh6iFa1D0clvk9o9pluh02gkHy0Ypyo
         nAY5E/8IOt336PJHw2YIaMMnOm+CnkQUrrjlM2Bpt/8VjG33ALa8C2ZLMCvH9DfPIe8E
         y26F79NXYWNdM1NsurXfz3mLWNskbHo9zcKg37N5BahmWREYEuScIb8V3XXqtfXj4M+h
         CHnA==
X-Forwarded-Encrypted: i=1; AKwUvBywW3PnHt6VYHs8TkLSnxHrcbntaK52PyyPCTHK7IyIl2pPY4Fm/9krkPLubjRfJqQImkBb9FA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJg498JAni0NeCq+ffYrzaXPBRGfW+5TlJPdFFtGTMegpQWDj3Q
	d/zba3NPyNJWREnegdeYz3J64T3QCiLrrVEnqtpscaTJy/HUsxIWz3Vc
X-Gm-Gg: AYBFou2ei88WSNQqPbxNtMA/I/rEjwfkjKjeQocYRFHFD6pvcQq1m7Mstq2EY1Unpm1
	UC3cXrQNlEd7i7PyGjnEhE+Dk1v3pvKDxykDng5WrLpNIeDPe8I6y9EJBOzCE/HQn3R74NZSWvA
	rtI5nPpcPSwZlswNpKv2y21/UWv+cFTZbtB+1NgihnjE+/FdRSroxMrUku4ct3wDunjsqqcKjcv
	OehVh8g1n3roBeke15JSKSldVaqS4KFIcPC6EDOMEBNuDncvtff3hH0g2IWKBQIWx7j1umGZJ16
	ALaVCroEjwpB1IWQ7j/Goa+88nBwmUlVDZ2NEQ55ICOWdTBQlPH1jgMJlpCWNXGqD+YwobV/0Jb
	Pauy7GuL1gwLat8QrR/Yyls47rkbKx50AV91qQPQhOyT1CLjA4I7dAHj3Mqiw2+LjwXYWzcG+Ux
	tdwJu2lnvY6zuAoKAB8yMFTZN1WkxIr9ZPO2EFkEQ+m7asNT8ZQCNfGRZgb3D/ygE4Vsu7k0g=
X-Received: by 2002:a17:902:fc45:b0:2df:5f25:67a1 with SMTP id d9443c01a7336-2df7e2a4598mr103235655ad.23.1790600192500;
        Mon, 28 Sep 2026 05:56:32 -0700 (PDT)
Received: from localhost ([125.16.97.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2b4bc736fsm7609655ad.74.2026.09.28.05.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 05:56:32 -0700 (PDT)
From: Vaibhav Nagare <nagarevaibhav@gmail.com>
X-Google-Original-From: Vaibhav Nagare <vnagare@redhat.com>
To: nagarevaibhav@gmail.com
Cc: Vaibhav Nagare <vnagare@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net] bnxt_en: don't leave an XDP program installed when the open fails
Date: Mon, 28 Sep 2026 18:26:27 +0530
Message-ID: <20260928125627.1005385-1-vnagare@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_xdp_set() stores the new program and drops the reference on the old
one before reopening the NIC.  If bnxt_open_nic() then fails, ndo_bpf()
returns an error with the new program still in bp->xdp_prog.  The caller
treats the error as "nothing was installed" and drops its own reference,
so bp->xdp_prog is left pointing at a freed program and the next XDP
update dereferences it:

  BUG: unable to handle page fault for address: ff78ecc80ddd1038
  RIP: 0010:__bpf_prog_put+0x5/0x80
  Call Trace:
   bnxt_xdp_set+0xad/0x1b0 [bnxt_en]
   dev_xdp_propagate+0x36/0xa0
   bond_xdp_set+0xeb/0x2d0 [bonding]
   dev_xdp_install+0x1b1/0x350
   bpf_xdp_link_update+0xc5/0x1b0
   link_update+0x104/0x1e0
   __sys_bpf+0x662/0xcf0

Seen on a 6.12 based kernel after bnxt_alloc_mem() failed an order-4
allocation on a fragmented host:

  bnxt_en 0000:a0:00.1 ens4f1np1: nic open fail (rc: fffffff4)
  bond1: (slave ens4f1np1): Error -12 calling ndo_bpf

Bonding is not required to hit this; a plain XDP attach on a bnxt
interface takes the same path.

Restore the previous program when the open fails and release it only
once the change has been committed.  The ring and feature configuration
is left as computed for the rejected program; the device stays down on
this path, and reconciling it is left for a separate change.

Fixes: c6d30e8391b8 ("bnxt_en: Add basic XDP support.")
Cc: stable@vger.kernel.org
Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 9e5009be8e98..f30ce644e377 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -419,8 +419,6 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 		bnxt_close_nic(bp, true, false);
 
 	old = xchg(&bp->xdp_prog, prog);
-	if (old)
-		bpf_prog_put(old);
 
 	if (prog) {
 		bnxt_set_rx_skb_mode(bp, true);
@@ -435,8 +433,16 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	bnxt_set_tpa_flags(bp);
 	bnxt_set_ring_params(bp);
 
-	if (netif_running(dev))
-		return bnxt_open_nic(bp, true, false);
+	if (netif_running(dev)) {
+		rc = bnxt_open_nic(bp, true, false);
+		if (rc) {
+			WRITE_ONCE(bp->xdp_prog, old);
+			return rc;
+		}
+	}
+
+	if (old)
+		bpf_prog_put(old);
 
 	return 0;
 }
-- 
2.55.0

