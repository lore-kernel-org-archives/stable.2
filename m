Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68DF3D1CB0
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124104; cv=none; b=dcbz+X+zAEsTKSVu6IS5Z76deQ0uUQWmzlqJuzDumpG+x1HOrXZBQIpr+aZRXeOxQbb1v+wDZFPbqsj34MNsjFj5seiIkj2Wl6xVn7tKqioHHO0hr3dgZA3UfxW/UIWN8SFglzmLZaE07AZSTv7iN7KeVJuADpF7MNjxB5X/qW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124104; c=relaxed/simple;
	bh=JTyrG4j8qDauzeyqwlulE6O+F2ehz5Kb6JZbJ/V5ufI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Di3IuM39dYnMDoedjkoNMLTbZLdV5BtQiUzlDHeHxyF0ecln5s84SY1o0BcCfCEDRm84c/ba0VV48Qvx2UPWv2wCDb2d6aVah4H2A6Mxv5Qvhh85p5CJs5wpSiZ9vwHz4bxf4ye6hXYTD6z1JdMsxodPsbkdM1r5WQZZyEGHfNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWi4YsTg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWi4YsTg"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso7666275ad.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 00:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787124102; x=1787728902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VzLCXVO5UW9Tfo0S7uiC3iQSuu1VloWuki4PFlncfmI=;
        b=dWi4YsTgK/ybqamly+1Sl/rlo6id+AoVCEC8Lh6vC4TvMjQiCTw4Hg2szY765Wm/io
         pfjPxlR7tCYVymWwI9ftBKAJ0VuE/BQF5RLSAhlkCmPga5FY0/V+P661YFCUZ9FGn7qP
         VuxeFVaSuSqywuKuzJ7eXEvEVL/ZArUHYgF2qAQHDTcEU527GJRkgavxpSrWlB9FaOiL
         XLdtFIQrlDHzncx3VNjek/xHMeq+uBvi5NvN8MFJfKCwYHoOACM3+3bA6wn+dpxJFyC4
         bNdZCXF+sLSOeoEklaHYpZcSdEd/57xOsT/YdH4CY77aTakPA8B/KyXs0EYXC86u+CfH
         PiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787124102; x=1787728902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VzLCXVO5UW9Tfo0S7uiC3iQSuu1VloWuki4PFlncfmI=;
        b=P786j1oFSc+PKT7cwaz07SWQ7tkeS3Yluk8TDqYoLWXs3nrriCJFLHIWWfyJHjq1sE
         wxwcDdZe1r6Ns1ulOlhbm7kPA3E464gcXzaIHo71cjflwx833fhoZVjuplR4krWChYsp
         tCAz0LL1MKZy68eGk6DuRBc5rBas+ho+lleYeXCwYJfKg6zT4zEtlq8BRSm63+PqU/I/
         RpbRZNravWJghDIdv30FWKU3d0GBpllxIVb1RIRQDqR4uF5TvjEkm6IDffy6FfF+9gQF
         U97kz7NMTZa+dSJLs0tpzi5gvgNoFLD5rrX9fhV6Ts2AhIGvfkH0upllw462rviMAu+d
         xWfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrde+IBqHOSxovg9gHcCTGkDvD4KnxbDaW6Sj8KwuHe/dTrvkHhJi3iEU2gH4S4fatYAbw1JSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCIO4nYh/NYdUoyj1GiiFGYuPbaGaDRNnKFuGSrA8GBVluPDX6
	ReguxuDDxxFucE6s8zzLho2/D2cZW6mpszx4zXW8C4gjTPL3gSOxXM7W
X-Gm-Gg: AR+sD12axyQoYOtDAAnuMHfIq3XQLcDVfQ/TH1ogZ6OxgB+qCyjiFkG28HEIceBXkC3
	n0Eia/Q1oNRcrL5VUSBJxSrI1gik903TTh9/WutyQ4EqkxuCTwfea4rGgO3ZcxCXXETeEOYuHHY
	pzAFYU0vn/m3OkqdgGIMm6+3wurm2P8HeL+4dS2JDsC1hRgjiEcxdPAeZdFKutVVT3dxmYneIId
	k2+JTXGMiowaIiWB4khekQtVlCdYk7kqlpMfrQviOXpAcIkpChLD/QH09Vq2K18G3FMf3dfSvjE
	1O7hSEB60p7EGxpQ8v2O7lOXSGAZh/FcN9L3qF2qZo/DH7g1qyC2/W5RAClGXNe5LhqUCf8teON
	ICaVBen/C9wRjD9ne+ovIU6y503JITrfZ66NrjeOaRw269YpuJo3MN2YCHxvhOJYuqs8x9Ak5V6
	PugqkPt5SHEHXr6d+moWBEXBPh2G7XrTibq3v3rW8VL3bceIXimSZG0TVDP1MV0adhn1t1JXBaU
	nnK3vJSAg==
X-Received: by 2002:a17:902:e80d:b0:2d3:a6db:299 with SMTP id d9443c01a7336-2d5fd703145mr44749815ad.6.1787124101760;
        Wed, 19 Aug 2026 00:21:41 -0700 (PDT)
Received: from DESKTOP-SWORD.taile2ffa1.ts.net ([240d:f:771:4e00:f0ff:edd1:42d5:8f3f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1ecb179sm21372035ad.68.2026.08.19.00.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 00:21:41 -0700 (PDT)
From: Tien Phan <tienpp@gmail.com>
To: security@kernel.org
Cc: Greg KH <greg@kroah.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	stable@vger.kernel.org,
	Tien Phan <tienpp@gmail.com>
Subject: [PATCH v2] nfsd: fix use-after-free of DRC slot in nfsd4_sequence()
Date: Wed, 19 Aug 2026 16:21:24 +0900
Message-Id: <20260819072124.1306664-1-tienpp@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819054326.1265334-1-tienpp@gmail.com>
References: <20260819054326.1265334-1-tienpp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfsd4_sequence() loads the slot addressed by the client-supplied
seq->slotid, bounded only against se_fchannel.maxreqs:

	if (seq->slotid >= session->se_fchannel.maxreqs)
		goto out_put_session;
	slot = xa_load(&session->se_slots, seq->slotid);

When the client acknowledges a slot-count reduction, the handler frees
every slot in [se_target_maxslots, maxreqs):

	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
	    slot->sl_generation == session->se_slot_gen &&
	    seq->maxslots <= session->se_target_maxslots)
		free_session_slots(session, session->se_target_maxslots);

but never checks that the slot it just loaded lies outside that range.
A malicious NFSv4.1 client can pick seq->slotid >= se_target_maxslots
(still < maxreqs, so the bound above passes) and, once the DRC slot
shrinker has lowered se_target_maxslots below maxreqs, issue two SEQUENCE
calls on that high slot: the first aligns slot->sl_generation with
se_slot_gen, the second satisfies the reduce-ack condition and calls
free_session_slots(), which kfree()s the very slot still referenced by
the handler.  The slot is then written (slot->sl_seqid = seq->seqid,
slot->sl_flags, cstate->slot = slot) and used for DRC caching -- a
use-after-free write.

Reject a slotid that falls within the range about to be freed before
freeing it, so the handler never operates on a freed slot.

This bug was found by Sentinel, an automated vulnerability-analysis
agent, and reproduced with an in-tree KASAN harness driving the real
free_session_slots() on a live slot xarray (KASAN: slab-use-after-free,
write of size 4).  The analysis and fix were prepared with AI assistance.

Fixes: fc8738c68d0b ("nfsd: add support for freeing unused session-DRC slots")
Cc: stable@vger.kernel.org # 6.14+
Reported-by: Sentinel (automated vulnerability-analysis agent)
Assisted-by: Claude (Anthropic)
Signed-off-by: Tien Phan <tienpp@gmail.com>
---
v2:
 - Add Reported-by: (Sentinel, the automated analysis agent that found this)
   and Assisted-by: (AI assistance) trailers, per Greg KH's request.
 - Correct NeilBrown's address to neil@brown.name (v1 bounced at suse.de).
 - No code changes since v1.
v1: https://lore.kernel.org/all/20260819054326.1265334-1-tienpp@gmail.com/
 fs/nfsd/nfs4state.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a42f34842d77..f737b841b5a2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4575,9 +4575,19 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
 	    slot->sl_generation == session->se_slot_gen &&
-	    seq->maxslots <= session->se_target_maxslots)
+	    seq->maxslots <= session->se_target_maxslots) {
 		/* Client acknowledged our reduce maxreqs */
+		if (seq->slotid >= session->se_target_maxslots) {
+			/*
+			 * ... but is using a slot from the range we are
+			 * about to free.  Proceeding would leave the code
+			 * below dereferencing a freed slot (use-after-free).
+			 */
+			status = nfserr_badslot;
+			goto out_put_session;
+		}
 		free_session_slots(session, session->se_target_maxslots);
+	}
 
 	buflen = (seq->cachethis) ?
 			session->se_fchannel.maxresp_cached :
-- 
2.34.1

