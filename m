Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D822E06ED
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125641; cv=none; b=cTGci+kzMKmMBzrNvIRiV3jWQIFAIdaSPVwMw/H3ROUsvjtwdPxrVdav6Yf0DgY2RWm9Gq0K3+RictfdLfG3HO1dZaX9GI81UNI1WaVxPX6oJ0EkPSRuuzkWzSmJb90+5dUzcKYm9+InQCLAl8V08/CmLHqA9pQ6A82imZ+ntMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125641; c=relaxed/simple;
	bh=//EXAfp3i+kQ/jKN8wDzvz/IYi7mnsdrIjYMRGRHySU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NoBBZfX3CKJtLxyp8YO5nqqn0o2aD/ZfNXZiOHtl+0fvQ6THtgg/YzdgA1K1IFp5TI8JsI2vo4zrldqGd1OukbiE5WEwtpXon9EyVpYX2mWiEQ3PU6TdXNp7wemx2PgCt+P5Bm7CovN3OKM1W2pxSKQ7Bnsn8vFo7vBA/Dk8uUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNIpqqMS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNIpqqMS"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso693465a91.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 00:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787125639; x=1787730439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hGC3VW1w2On4iBJIoAiFEhqx16sfxNjUYYtbVUVIBwg=;
        b=MNIpqqMSBykFIVrfaYNGNdwOecA6WvAwQL2X3EUBHr8EiHAIRqv3rtEDeFGlfjVYnJ
         NuHiECYdcOVJI0brl7s3xK6HfoFKQxwnKcLLPheNUZeT4n378LXtkAxQ78n9fQm09UPr
         CeXvjwaTjeUAGHYtnz8rh3fY1NhKH26E9mByHMMgapTQlNZ3p6pD0R6PpawvYglbKXLN
         dgBQqej7ws6TochMPk+jXfcpZejq+mWgHjp3Om+JxToTk0v+GT1kALSo3Ni3IUYyjJps
         /Y06Gv8v4t/dnZ/+Jjah/MjunYkMf+lST6ORE61Zt8hoARx1U7WZMgMW1KI0UxlZFMax
         /OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787125639; x=1787730439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hGC3VW1w2On4iBJIoAiFEhqx16sfxNjUYYtbVUVIBwg=;
        b=gNjth3+94d07/pK9J5R9LLdU7wuiK11uTRHwwVOa/0L01fhe8V515MjEjkFdbuLzH7
         h25yPPE/9semvUWbjNi7lN1+BWN+jDNXyvrscqTU2+7HH9rlKSYvFG9H7sBETJJF+biF
         3eJXy7v0LDgy8tsDeE4p3OiW9PpJRZCwVzWQ6uDegORedzvlAnlsgxTHhs+zmFJJICj/
         g0u9RgT3uCMlMN74y1qUlroBvmLXXkbJTDlqGbii08PY+whfXU97VG30OPXjmpFkvEBl
         Ggp4pPQbPTujC3Tx6xxHPCNF3dLKMMoWpuvehQAzwtfWPmnS06MuCaPTH2fWVnnbiNS2
         LGMg==
X-Forwarded-Encrypted: i=1; AHgh+RpGckKuwSxPQBHVy9iOfY0PBSFAkH80b+tvzgoziAozIS+zD+FmAIU7fcSn6vceayj1SPrxrFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Max9nRRf45V6nMws1BiBmuximsp4B+SJ9b+bdiJ6NKRUpwaZ
	nE1jISchnlagOdo6Ef+MyX6mFqtLh0PGjrSnx3duPMC1QamJlaHfrovB
X-Gm-Gg: AR+sD1214GLzENvkkq84New8N6Kw1s99RlE7x1DtcI2lVVCufx7ZkXChfVMtbgFE69k
	ntZkoSOnpyHKnuWiz8NYZ02+ksA44YuU2CiiwgLGmna8m88FOgen8yKuHWXgfCokKP+vupJLqLJ
	iNRhcm30ygJJQJ05xKTpKaFeZsc5m74qbrz/6kWTDtnmfedE5AmCiOPD1gxOeWIRh1+DPSRiNuH
	V1YXAQMx09qEDXStRLXz5uzdu5PrCLKbiE+WCWHASQBw4UQDlJx9cUfxSFjDFmekVIScGpph/mX
	qgpgFTFZ5RKbDx+14iND3YmouFHze5UIGPRMHcsxxpour8tPwppmE9Gw+AMXGvrJtfePpG4l2cH
	jQp63kz0ZGUtSUVft09JfJMThw533OBXzTYvKMHuGF4F9x3RONxAP4GnOCMlKpTQyqHcsYLjOJj
	jck5/5EsPaFmwoMFJQKAotQC3pFfIc7YCreBgeRU7pZnxqB5Gn+AM45b/UK/0GE9vfIt6Hqd7Cq
	3tsbZRd7w==
X-Received: by 2002:a17:90b:164c:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-3958107fcd8mr4799653a91.9.1787125639535;
        Wed, 19 Aug 2026 00:47:19 -0700 (PDT)
Received: from DESKTOP-SWORD.taile2ffa1.ts.net ([240d:f:771:4e00:f0ff:edd1:42d5:8f3f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f9aaa12sm1701170a91.5.2026.08.19.00.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 00:47:19 -0700 (PDT)
From: Tien Phan <tienpp@gmail.com>
To: security@kernel.org
Cc: Greg KH <greg@kroah.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	stable@vger.kernel.org,
	Tien Phan <tienpp@gmail.com>
Subject: [PATCH v3] nfsd: fix use-after-free of DRC slot in nfsd4_sequence()
Date: Wed, 19 Aug 2026 16:47:01 +0900
Message-Id: <20260819074701.1312702-1-tienpp@gmail.com>
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

nfsd4_sequence() loads the slot for the client-supplied seq->slotid
(bounded only by se_fchannel.maxreqs), then on the reduce-ack path frees
every slot in [se_target_maxslots, maxreqs) with free_session_slots()
without checking that the loaded slot is outside that range.

Once the DRC shrinker has lowered se_target_maxslots below maxreqs, a
client using seq->slotid >= se_target_maxslots has its own slot freed and
then dereferenced and written (slot->sl_seqid, cstate->slot): a
use-after-free.

Reject such a slotid before freeing the slots.

Fixes: fc8738c68d0b ("nfsd: add support for freeing unused session-DRC slots")
Cc: stable@vger.kernel.org # 6.14+
Reported-by: Sentinel (automated analysis agent)
Assisted-by: Claude (Anthropic)
Signed-off-by: Tien Phan <tienpp@gmail.com>
---
v3: trim commit message; drop the added in-code comment (Greg KH).
v2: add Reported-by:/Assisted-by: trailers (Greg KH); fix NeilBrown address.
v1: https://lore.kernel.org/all/20260819054326.1265334-1-tienpp@gmail.com/
 fs/nfsd/nfs4state.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a42f34842d77..def1ea534e18 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4575,9 +4575,14 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
 	    slot->sl_generation == session->se_slot_gen &&
-	    seq->maxslots <= session->se_target_maxslots)
+	    seq->maxslots <= session->se_target_maxslots) {
 		/* Client acknowledged our reduce maxreqs */
+		if (seq->slotid >= session->se_target_maxslots) {
+			status = nfserr_badslot;
+			goto out_put_session;
+		}
 		free_session_slots(session, session->se_target_maxslots);
+	}
 
 	buflen = (seq->cachethis) ?
 			session->se_fchannel.maxresp_cached :
-- 
2.34.1

