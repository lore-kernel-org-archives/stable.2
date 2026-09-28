Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38749DB9B
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601306; cv=none; b=oQMu1w6TjUdAV7rjtyC65Bp3NX2C5N8girZ1/FXsaA0tBSJa40cCSC4ovQ+DJnjXjnJh2pq6wWA5xlJWnwDhEVxPIYDiCRb9UF8d8Zcr/rR4WLW75nuZKNqou6zStncaNxQyk6esTL+Q5aYTAKaUTfZ2B6ZiRHC2NDY4sbEfZqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601306; c=relaxed/simple;
	bh=KUBocqw5cboHcSNnT0W6/Ucblbw9xsAcwi4MHpF6L5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxfqN1+A7/dHQ5xwzMstJsqov081bkrYY2GykHsW0w28uVil6uQqhMcPSyf4TXjAkREljMj14JpAtCSRKQ1EhBaSNm3VqtSjh/L2PaOuVYRVTl87DWvmYcPVrePKpP2mBWcLJvWJ1gljBlxSSe23qjhfFtNUID7Dqke+EdVEaNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozQjR7wM; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozQjR7wM"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5bda9b8aso80301685a.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790601304; x=1791206104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X3V0idLX7JfHuxhG0y/iym7zpN4jxFLNmH6tSltjyP4=;
        b=ozQjR7wM1LJZEEDbuWhxCOptxQgXiGL6lG8Y4t81jqdi7boHroPmYTz84pDw6BaybV
         hQojzTMafsD5jVkKNwZao6NFvKvqXTcbDks3YnWZnDTR4TAgY7ExMda10LSOlTwZBJqz
         hwazNE6T+N7g/TLd0YyWaZkFjm+Ar1lr0SPjI9xKMQ1eqYzsYlOCOJtoxerDdApwCdlv
         YBM8nCqkcaKSlSU2ZtAaZVei2GMj1XnMoYkgLSMb7zIdhJ6GM4jcCrmE0zD4TCVQHBkO
         9W3KGzmdglSOfYdCqMriqzWj7auL/VL9AF0d+Jjq8+KaVEaHPoQpGiKq6FoU84Edht2p
         d3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790601304; x=1791206104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X3V0idLX7JfHuxhG0y/iym7zpN4jxFLNmH6tSltjyP4=;
        b=hwtomJ5/i7go02yScvZD63/qYEIU7oX9e59l9ltisGzrbuGQ8RDPJEE5MSfNxtJoPH
         Fq9Y4PrQyMvXh3nX1Pd1UJgWeYYRCz+F+NbNlCozQjG9nSL+2H1U8pET4xgczaJilkl/
         xCc0FWBS7f0XMTEFqxK3JuSmcKV0zkM2qKv5FXYLSLvbOQOgTt1lsY+VJ6pIJEeL2O6x
         D+m5hV9Dgt6UQwoQy9ULbHhOeVP16HjOzughG15xp9DF3lmr5x7WQSgZn3pB6RSMtAXM
         BoKwr+er7QNPjHCTtpG70K/Ms2tSqXkHm369L4jzR1RzkmgJ1I+jUHoyKLdRyFLHXBLD
         PblA==
X-Forwarded-Encrypted: i=1; AKwUvBzl9N8darCazArsFfNon9oW57GQujFZTJ2dgBnK7NiovwAO9ivu6wYmpsmU6kr5nJVGio4Ae2I=@vger.kernel.org
X-Gm-Message-State: AFuF++nER7AW2i3CBkW7vh/xBfzOmyVIkHe8s9sBExIqn5IWv3/K4iYS
	R3VbVHcnKiXhzyX82hB6Qm/yJtFBs03Rmkdhet97Dz8/vo0jLrhAm20W
X-Gm-Gg: AYBFou0EBsKCrzCTP+e7oeCyKnM2X1Obt3FiAa+AwVp/stMbHbxvMARlWu4sd/n/QoW
	Bs4u70T9LHcUn9E9D6WW7Ci3hlAyZiGctlg9LJMzbqeRgViQ/jzyfHUDQmFnrxIRcxzqbSDFrH6
	Z+hE+/T1XnkldA55cv8I+O6BQptKGBgkXJPstl813YOIC7Hsa5bGy5R+Jl/H1S47XiD8tERcD9Z
	NuGeWlTkq2Jw/TYUT9AacHr4dLTKnhvSb90kmy3kFA2WuflE3zG/u9wo0T7X3VLJiRQRj0JoOKu
	qxIkBnBMCiNhyQmCA3dDzcSrmIfOc1EpHWg4xVsPfYB5K5QZATWEsv2rmSOLrp05BYxftvDxfV5
	kwgE1I20b3u2DdhWvws9MJgbjXsJh0+SVAFXEeHgCVKLrdK7akPbz71oW09oyoNOywO5dbuq4Zf
	41zD02BctyCgCra5zS1PtuLc1/hAYBvjJnyY2pVAJCn4dkzBRf1n2W9YEZQGz57Lrg6vG0LbRv
X-Received: by 2002:a05:620a:31a9:b0:93b:d7a4:9d4b with SMTP id af79cd13be357-93c43db7b1amr2012446885a.30.1790601303558;
        Mon, 28 Sep 2026 06:15:03 -0700 (PDT)
Received: from localhost ([125.16.97.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813a5ae6sm145555985a.13.2026.09.28.06.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:15:02 -0700 (PDT)
From: Vaibhav Nagare <nagarevaibhav@gmail.com>
X-Google-Original-From: Vaibhav Nagare <vnagare@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vaibhav Nagare <vnagare@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net] bnxt_en: don't leave an XDP program installed when the open fails
Date: Mon, 28 Sep 2026 18:44:58 +0530
Message-ID: <20260928131458.1012180-1-vnagare@redhat.com>
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

