Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136697;
	b=Tj87rX31tqN3mINt8KtuTI9q6nFW8IFDdckywruXwDkyUO6+FsDYH9VxnTlFpJKL1QQI
	 t70iMBPWlILiGU3B/Hzu37HH9LlROG9myO+c+VGpoHpjn1+38JGLdFvTcHbWw7BeZCvkv
	 6RSfwiSH4aAImfiXYxFy1uBt7sRCROcf+yDFVTApDnbTDJG7ibxL5zavEH/ThNoZR/fwe
	 paCaOe72SpfnYipQvku5E5NUyaOsmwAWFraJDvKTgBuh9YNSttMfALCXWwXC5IvM5URQi
	 1mRvySY4dj9VD5TB02og2N8rdafV1aVBkd858hbJt+82bI/SiXYVenIDAZGCLVoU9Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=14zjSChbGtPtuIEC/eCtCmUR3/Z1H0ubiZMVkNUw7Yg=;
	b=c192uBPW93WM6C27zWhACsqX3OMOpbERgzlcp8x6j0wGExeyC8zCk+KM8gSjZITraR7u
	 D/xarJvLnx2+1rwVi9gJAaKpRVuvKVO7KLWd/LoOA3G8GBNHa1MX58YJA3ijb75Evzfue
	 XBPAkOCmgj3m85s1bfREKAyKbqsVh+LTTeB2bcSqcpzjCldXnXR+s6wl0mtZmj9hdV9bN
	 ltmVFIpV9XW/0knLJLWvc/6maomyXuqfIalwiePxAXe7xAxs9bLHKHP7qq8lihmqXBxl9
	 bzLDO68NcauSGDbvHPvSYiWJ8vAav0z+Ho5D44Q64Ad56DJD50pj1uk/lv9Xdn/j06w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=everpuredata.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=i1o4eelO;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA612606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA612606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=i1o4eelO
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso167320a12.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 17:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1795136696; x=1795741496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=14zjSChbGtPtuIEC/eCtCmUR3/Z1H0ubiZMVkNUw7Yg=;
        b=i1o4eelOcxxhAremUNpz1jVTTkbHb9fjYyAAI1GwOBG80DImiTshgnqTEGaWDDvPju
         KVcRJf2HM16eIKYbsplf4q/pLBqBzwIPc406R8rsw3kAaDn/CCtvU3o7ymbdVvBfQ9UE
         UsjqIvYPJARjRdN6mR9S8kkw9kmNNUBbiz2DxhVeBAzOj4t/tSRuaP2k4S1Q/phBRzin
         s2vrTvlriAymj5jAuAUARck6dKaC8KMKVLJp+RpFa1X4IOLTY+2YcdpaZmhtWsBULYSq
         qZBDzvqFk9mJ3jKkBAlxqC5+8+DvaqPSOM0Z6sARqyVJhRL1FH6CNwxZjYN0Bmm9Ubxe
         R99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136696; x=1795741496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=14zjSChbGtPtuIEC/eCtCmUR3/Z1H0ubiZMVkNUw7Yg=;
        b=Tr/PADIL3BGHH8tDqhYlXxeLaoJumQUgZ/rGaSxUhimqFLXdfd4VAF/bLFjX28HBj3
         vM/9JC2l0TeBBqYH9bGQiWe5EQ+yi+owkNP2ufiJ4YxpFlOsJsVplAfous3sOIhx41zt
         DCKvMQjEkAbr54VDTqu0/NIHcgjM3gKOjfFuCDjhROHq03dsh6lrT3SV5Wtq8o+NF5B2
         AJoAC+dh5r8t8x0+pD/ko1UYNo+y4U2hKotBiOJcHpFz2BqWRRAl87tmtDZUVG+qa6vr
         1UC142RQHHClcgcc8PLBDl6XopL+K0N5g+lZaE/Lf56hSU2XxLTF6VmAQDvv5H/v0kpB
         wfNA==
X-Forwarded-Encrypted: i=1; AL+hErEM+hQoIsOry2Wg8KoyIhS+/JdhMD/zeZ7MLr9hwUwF2Z8hTDbsosN1+pwS3sh8eEDi76crnuM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FWZl8gZYTQN8NmudhYTs3G7fD7kdUwomyBnPMZnULe5pMPrrb
	E1ZV77jq4LCVP/gAWL3G0tDJIHUyluILS9I3f57i+NHQ36oJaK+d8uafDY6dvtpDLLNbTBpfsHW
	15TYpHwAlsemgjNST1r01Kwo3J/ocxl+zy4N8
X-Gm-Gg: AZFdTZfrJhvln6ohaFLv69OlDtoFjKm7zyR0kEi6sLc1A2jt6odbhMvpQBMJJEcnP7L
	p/V2yJoVFiPYgGlmCO4agntpSocpTfbmXVqU4WXx3E32EcExENYGyWJWNE9ONvL8aCpVSoLraEa
	G0Fm/d/VEsN5EHYsBd42PfyTsjSmI8VZsmTsX3W6tmfe96yndXZ8oLEhXF0wcyutAtwLMmU+hH7
	QsWeNErJECiQPSv36vsx6/BpXQiRDYyBtKZVQa3R7j2DYxVABs4sWp9ajKp1JB4PzGlvuF7tIFD
	X+HzJ3MQWv4F0vKI2a9OXn8V971blGoB7Fix+3Riv8ksfJIUskyfq/Ya002FgrpBdJw3Pt9jnlD
	tiKnoaSeNnLirNFzVh092qfsnojkEheIB6FSQYyg=
X-Received: by 2002:a17:90b:4ec4:b0:3b3:bf8f:9ccb with SMTP id 98e67ed59e1d1-3b41c8ffa94mr1008239a91.18.1795136696119;
        Thu, 19 Nov 2026 17:04:56 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b41ae59fa2sm822937a91.8.2026.11.19.17.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:04:56 -0800 (PST)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id E95133400BB;
	Thu, 19 Nov 2026 17:04:54 -0800 (PST)
From: Tim Menninger <tmenninger@everpuredata.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jon Curley <jcurley@everpuredata.com>,
	Eric Badger <ebadger@everpuredata.com>,
	Shiva Lingappa <slingappa@everpuredata.com>,
	stable@vger.kernel.org
Subject: [PATCH] NFSv4/pNFS: Don't cancel I/O when re-checking a deferred layoutreturn
Date: Fri, 20 Nov 2026 01:04:54 +0000
Message-ID: <20261120010454.2153387-1-tmenninger@everpuredata.com>
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

pnfs_layout_need_return() runs whenever a reference to a layout header
is put while a return is pending. It marks the segments covered by the
pending return and, if none of them is still in use, lets the caller
send the LAYOUTRETURN; otherwise the return stays deferred until they
drain.

Since commit b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if the layout
is recalled or revoked"), this re-check also requests cancellation of
I/O on matching segments still in use. Changed-layout recalls,
error-driven returns, and file bulk returns already request cancellation
when initiating the return.

As segments drain, the pending return's sequence cutoff can advance,
so a later re-check can also cover newly acquired segments. Cancelling
their I/O can perpetuate a cancellation and retry cycle.

Disable cancellation in the deferred re-check, while retaining segment
invalidation and waiting for outstanding references to drain. Explicit
cancellation by the initiating paths is unchanged.

This was observed on 7.4-rc3 on a one-client one-DS system under
sustained direct-read I/O over pNFS/RDMA after restarting the nfs
service on the DS, with "NFS/flexfiles: Don't treat a locally aborted
read as a DS failure" applied. Once LAYOUTRETURNs were being sent again,
the re-check kept cancelling the reads of freshly obtained segments, at
about ten transport reconnects per second. With this change, once the DS
was back no reads were cancelled and no transports were reconnected.

Fixes: b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if the layout is recalled or revoked")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
---
 fs/nfs/pnfs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 14f4a4b12ffd3..a60df3bdab921 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -480,15 +480,16 @@ pnfs_mark_layout_stateid_invalid(struct pnfs_layout_hdr *lo,
 
 static int pnfs_mark_layout_stateid_return(struct pnfs_layout_hdr *lo,
 					   struct list_head *lseg_list,
-					   enum pnfs_iomode iomode, u32 seq)
+					   enum pnfs_iomode iomode, u32 seq,
+					   bool cancel_io)
 {
 	struct pnfs_layout_range range = {
 		.iomode = iomode,
 		.length = NFS4_MAX_UINT64,
 	};
 
-	return pnfs_mark_matching_lsegs_return(lo, lseg_list, &range, seq, true,
-					       NULL);
+	return pnfs_mark_matching_lsegs_return(lo, lseg_list, &range, seq,
+					       cancel_io, NULL);
 }
 
 static int
@@ -903,7 +904,7 @@ pnfs_layout_free_bulk_destroy_list(struct list_head *layout_list,
 		list_del_init(&lo->plh_bulk_destroy);
 		if (mode == PNFS_LAYOUT_FILE_BULK_RETURN) {
 			pnfs_mark_layout_stateid_return(lo, &lseg_list,
-							IOMODE_ANY, 0);
+							IOMODE_ANY, 0, true);
 		} else if (pnfs_mark_layout_stateid_invalid(lo, &lseg_list)) {
 			if (mode == PNFS_LAYOUT_BULK_RETURN)
 				set_bit(NFS_LAYOUT_BULK_RECALL, &lo->plh_flags);
@@ -1405,7 +1406,8 @@ pnfs_layout_need_return(struct pnfs_layout_hdr *lo)
 		return false;
 	return pnfs_mark_layout_stateid_return(lo, &lo->plh_return_segs,
 					       lo->plh_return_iomode,
-					       lo->plh_return_seq) != -EBUSY;
+					       lo->plh_return_seq,
+					       false) != -EBUSY;
 }
 
 static void pnfs_layoutreturn_before_put_layout_hdr(struct pnfs_layout_hdr *lo)

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.53.0

