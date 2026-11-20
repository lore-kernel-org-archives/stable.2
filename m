Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136820;
	b=GT11tIpvSKsg3d3MY+77V1+7FGekEPpvZBSdRQAopFMSXOdyGfwC6bf6DkmJy1En4Liq
	 hCYYuejDi1sGpOMbAffxmfDhDDBbjIBTksGn8r9NTVHT4heagZrgzXfSw7TmIm2qJs562
	 PNe+TP6Q3rPY5HCtysAt1Yh6QXpFvJbyX+9hneQoYUVo2FuBUEDAumaexkxV7CCmCaCIV
	 nBwyhSFrkIiDXiAcpi6sNtDDm2bTM6pWEyn64XVwAWZffoW6z9sHO+/lTRQsCfhWnZdCf
	 WBeSHHjrLmKCk7I64ANiVBGdScwr5r2um5+6wpqMS8TQLpDGNLeNguYz8rcvaR52MUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=azpbeeR0UmmXKlAwsDU3rTomTiwLhVswnIguSA8HmN4=;
	b=m+69zSWqxEBYuTrxIbNIQKZvVVXjqlBelAyMi+cd2Yy0Dp/lntfe7B7qWPEOVPQgnbmt
	 0oikh8uPr6bg7wSzd5vwwpBSHcyVjakj04GOOOXSgxxvd7WOR2dptYu7bNM1+M8DR6hZK
	 ntOOsK1WxCGwpo5NmjXHWLnDRV1glDFMtqJgUq+KsYqv3yQLn82CHqyblOYrMeksQRqRg
	 Lvk0ZYnNsTBdi/OlEobTqXF0LNrbBLScj91L/MvwpZzOwk7TPzqgunps/S8wzugWr/fwK
	 Il9Zotr4FBaN8vwXgdv1Y6A4a0dwMIM/0DKa6CadRkxGyDv5fviG1BiykZSZ4vVWHVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=everpuredata.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=sNHCMxoK;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D7606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C7D7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=sNHCMxoK
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso149317a91.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 17:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1795136819; x=1795741619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=azpbeeR0UmmXKlAwsDU3rTomTiwLhVswnIguSA8HmN4=;
        b=sNHCMxoKSWnMHqi2heurqFOoJmbYTUZ1ydPiN/uY6pu66Ialos12XUTZNoCNtwVkXq
         JuZqkFQovQyKNnqtxI6NqsCbkXV29sURHtqFrJpwh6I340bRFH3YlLbSDOwLaSXaZGIi
         Hug0FY0uPk9Q3ZuXh5MDVtcLu1BdTi78gRSTl8ulOewYo0mj+ja9m1EUFV9WsEleVbbG
         1f1z0VcRmou3jfj5k39rfexokdBaFu9AmKBhesyPjJ6x/xoX/aVcpeiq5TXxFUwAAHFy
         B4Yyc3hU5ALZ8tID/p65P/uPpYIYVYD4b0ORWNDdL8I3HWNtp8IfR10LuqpX2tmk81BB
         UfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136819; x=1795741619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=azpbeeR0UmmXKlAwsDU3rTomTiwLhVswnIguSA8HmN4=;
        b=CTcEe8Y3ywfz2CWFbi70KXNM1A8drFZFr384DGrBw8KYU1PqNrgP8wrc/zxwv/5RH6
         1+i2L7ZEfs1qo1JQbduLMnE74Dxvh9mNZBuewn2SozN6QReH8udnji189fA/NLv/odX3
         Xr7WXdiAgmthHR/iRp1nQ1XM0dOH/r/taRVuYp0iz7noheZXg+r2HR4ubFnx2cscy5Xy
         NYHox1q5H8nh3wAQhS9t60vWexT5634KUf42ig+119i5/CC4SOqjm1XDMDnFTiVYJPFf
         /t6gCHjCIwVxGTnXMap5fXG+34rM1UYmXNtPyppfoesbOQjyD0CDFnYjt6MipEjwyBoJ
         r4Bg==
X-Forwarded-Encrypted: i=1; AL+hErHTAvk50a59Lk4hWMitcmHotLSkbD0LjAlnwGNAQ2EPVzy5GhaRMmaUXbtZADwRuNG2NQErae0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CueHQrnhba0ehJ7ske/gXNbufwj1g3xcYG1Zg545X/BuiZizV
	VTVGlQgXcXJzGY+cvsQ+Ix9z/TTNMUrN2aCtNOIh6dQvaSf4an/o5qcQCcSmSqAIU/VaQR944GC
	VuLdr3JTpHOkGtZR+uSkw2JxkESujQO57HAwM
X-Gm-Gg: AZFdTZd8KDidM0Md5yLa3cIt91P0q0ZrnW1mEyvfFO9EDsJL2aOPbpC0F6in3t7sasO
	4FW6YOs1ktVErc7kQHu1FIdAW/xlw5h+Hzbx+ZTSmYQy1QKXvp786OIqlJEWlWDqiKMZ0mdCHc/
	gtxWiGlYs0TfCqJ4cgM04eBoQVzdHyyR7o/SodwIV34Y3+XMdjF0UWySbrDzwCMEgHOO+WqAFuJ
	oC3xuIHKucfGnnXzb1JHjH0LGXYr+c253X8T9KwNZS+negU/nevUeulBios3V+yy8WR20UNgQJf
	phQH964EOmpfmQF+q8IveX8wXrhD+ywhBaLT/IkiJOddBgb49nCau5yTi3aH5pAyCC6Qk8OjVD8
	Zh3hXje1qF1J+5uwK+9ozibJQ7vrp1XMYP4+tLOE=
X-Received: by 2002:a17:90b:5546:b0:3b0:a1c6:95ae with SMTP id 98e67ed59e1d1-3b41c941f9amr621799a91.31.1795136819434;
        Thu, 19 Nov 2026 17:06:59 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b41cfc5245sm238009a91.0.2026.11.19.17.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:06:59 -0800 (PST)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id C9314340382;
	Thu, 19 Nov 2026 17:06:24 -0800 (PST)
From: Tim Menninger <tmenninger@everpuredata.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Benjamin Coddington <bcodding@hammerspace.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	Jon Curley <jcurley@everpuredata.com>,
	Eric Badger <ebadger@everpuredata.com>,
	Shiva Lingappa <slingappa@everpuredata.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] NFS/flexfiles: Don't treat a locally aborted read as a DS failure
Date: Fri, 20 Nov 2026 01:06:24 +0000
Message-ID: <20261120010624.2154348-1-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.53.0
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

When a flexfiles read asks for a pNFS resend, ff_layout_resend_pnfs_read()
treats the failure as a DS problem. It moves to the next mirror and sends
LAYOUTERROR, or, if no other mirror is usable, marks the layout for
return.

That is the wrong response when the client aborted the read itself.
Relevant cases which don't establish a new DS failure, and therefore no
longer drive another layout return:

    ECANCELED
        pnfs_lseg_cancel_io() cancelled the I/O because its layout
        segment was being returned or invalidated.

    EAGAIN with the current RPC attempt unsent and hdr->lseg invalid
        ff_layout_read_prepare_common() found the segment already
        invalidated and exited the task before transmission.

This was observed on 7.4-rc3 on a one-client one-DS system under
sustained direct-read I/O over pNFS/RDMA after restarting the nfs
service on the DS. Marking the layout for return cancels the reads of
the segments obtained in the meantime, which then fail the same way. The
client marked the layout for return from this path about 8,000 times a
second and reconnected transports about 300 times a second. With this
change, the layout was no longer marked for return from this path and
transports reconnected about 10 times a second.

Detect these local aborts before attempting DS failover and resend
through pNFS using the current mirror index as the starting point.
Skip the explicit LAYOUTERROR and layout-return requests in this
resend handler, leaving existing error recording unchanged.

Fixes: b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if the layout is recalled or revoked")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 5c289737366f2..31f17d79b270a 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1313,6 +1313,16 @@ static void ff_layout_reset_write(struct nfs_pgio_header *hdr, bool retry_pnfs)
 	}
 }
 
+static bool ff_layout_read_aborted_locally(const struct nfs_pgio_header *hdr)
+{
+	const struct rpc_task *task = &hdr->task;
+
+	return task->tk_status == -ECANCELED ||
+	       (task->tk_status == -EAGAIN &&
+		!RPC_WAS_SENT(task) &&
+		!pnfs_is_valid_lseg(hdr->lseg));
+}
+
 static void ff_layout_resend_pnfs_read(struct nfs_pgio_header *hdr)
 {
 	u32 idx = hdr->pgio_mirror_idx + 1;
@@ -1320,6 +1330,15 @@ static void ff_layout_resend_pnfs_read(struct nfs_pgio_header *hdr)
 	u32 dss_id = 0;
 	struct nfs4_ff_layout_ds *mirror_ds;
 
+	/*
+	 * A local abort is no evidence against the DS, so skip DS failover
+	 * and don't request another layout return.
+	 */
+	if (ff_layout_read_aborted_locally(hdr)) {
+		pnfs_read_resend_pnfs(hdr, hdr->pgio_mirror_idx);
+		return;
+	}
+
 	mirror_ds = ff_layout_choose_any_ds_for_read(hdr->lseg, idx, &new_idx,
 						     hdr->args.offset, &dss_id);
 	if (IS_ERR(mirror_ds)) {

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.53.0

