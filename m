Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D313C98A2
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 05:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118252; cv=none; b=ZQqVGNw2PtV6rtZdT302Na2dKbMicdDyD0h7pG/7DdDZmuo2VX5gscUXu1+94ABZwk269C4juZ/o6oGcgQD2BEDd8ZgLa8vPtI9L1/TS4/y8FTgrMnHbwWAuaTYe9XcN5wA2X3gV0Kjvne15y6vXz8NQndyks7sZyPYT0HUk8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118252; c=relaxed/simple;
	bh=Z152ptEZ7SJrWqLBYlwuecVORDo5mwxrQmEr4NXJ8oI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U+2b0OGmVbpLFV7COvncpowA+FV8mJmnwUC57ARuuA2TnOvY+lb91cuDSORgrruVjvRYHBjf6PQpKEXCxaTzZbITC61snEfVeAe+SfGQXTHFx1Eg8LLOcFb+HCZES4uoX4DleRwkJ7vokv3WoV0g+IJH9aZ5//NNytBG/TNk5cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHfKxRwl; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHfKxRwl"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84830c774a0so739793b3a.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 22:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787118250; x=1787723050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V7O85/Xe8nufj7K36RavbWHRtCEPUVUnRToFJmlUzW4=;
        b=dHfKxRwlNTGWSxivckcnRu8+aPiNRcg0yKURuFZU9xT5wyA9SZ88wmIXBKvzg6AVVU
         miU02ucI/EfqGtCZSgVY7RkcG+0k88DZlfkr3iQhA7ciCOR1T5PAwBwbsFIQYErOiPp4
         mPYWGmc5WRb/nGHq9cwRzMgRV/E0gmdP0y2l9LRpTJg4i6nFHRQEuEpUddpgq9VYpUU3
         JPnuIQLhkGzhnYOx5Qv7zxUrE0/CVjnH7pFx0E/jgPzM0dFg/Yr34Xe79vvYrl39qmtF
         SqXxJkefvo545HmBgJ7z0Xt9fMlk69q7iK9YhoHP18SKv+iac27f7KB1EoI65IW0XIB9
         otUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787118250; x=1787723050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V7O85/Xe8nufj7K36RavbWHRtCEPUVUnRToFJmlUzW4=;
        b=cOmYbTQCvnQp1sZrIExVFHsY29Ib3IBPkam+BcXcR8hDMhD9ZI400D/x26IU3y9uar
         2+2yUJCUQ9iowUyBUczT2eh8qgWZ72nPFrj4X0sLdSW6MNYfwrf0naZLmmE2M5iWzivt
         UkWfXiFhHm5wYbEMXHR+fPjabaqvy0BfIWgB0pvB9bKJO4ZXyPrK6PbM4TsJB3mmyX1H
         p4Qi1SmvcTNOWhl2Ps3t/mb0gbJv0wRcRqnyPieBlIXkFg4hhghTT0gPzPOS4aj5iluF
         9gebd95SOiyKYN47xt8ydAAQw486gCjYPYyiWzOMYG/LEGdFqfalhvyUFbGGosrmux4d
         +r3A==
X-Forwarded-Encrypted: i=1; AHgh+RpBeyF5RB4KeW0q0FWOGJCxolo9gZ47tV+4SewAEkI/TSywbymEQNFelRkjw885cvbIWkREdk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkmM9ib3smQBIH2RPyzJIN9qbvEoMzuZrWfWGyrZkBNUh+b8oe
	zfPg+MXsXHcovb9ulBXwS9LmFh+Gr5HIus3jWE++9ll6/0vElKLFbr2s
X-Gm-Gg: AR+sD11Kn863XNQW9coxTUxY9WFQECYuB6Cq8bN1xgosU3BW8hFU1UNM8U2Wqv+ydy3
	g7QMY1oZELyB9UWOyzKZ8JJrXIFz0/0bNHsjJ6N5RxZ21pnJnSbkwVaYx51cwnpQI0UIQLw7k6L
	IVnHLq5fDg3qTDYSKuhYBTas5+A6KMzilK6llGjmTml7LsI2iMzQU5tqRqMaIIvjq32Y2Ig1dDS
	YuZnP2Jnpa+Ssp8WxVcgVB0DEjJB6526Y+KggFf/GiEsrgWWyv8DHE8HdwTE5ns9i3N/ADs/bd1
	z7gccnoHJ+W4hboor/tjxF/MLIejyZKVY21/g8Qk+hRnQdrYlGdK4Ke0VOLTRZMUP3BfoLrDAzg
	mW5dJsRBK+knPDP4/sFHS2J8NGhgeKdvigSlS137eY9vEGIcqU7nKNnnFA86lhyuh+ZQWFdg8eH
	9KAm32ohRDTGpwWtrDW63SkILUQu+yvoHFuPXa9wetUc3ww8yJzPEwLeGJ5bb4chY3uLkkMHzqP
	x6NefbjFWZRtfxHA32Fb3LyL1U/0QcY
X-Received: by 2002:a05:6a00:4c0c:b0:845:e7ee:eae7 with SMTP id d2e1a72fcca58-851d387dc0cmr3531323b3a.5.1787118250439;
        Tue, 18 Aug 2026 22:44:10 -0700 (PDT)
Received: from DESKTOP-SWORD.taile2ffa1.ts.net ([240d:f:771:4e00:29a1:c865:d2b3:3847])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3640a4bsm218820b3a.42.2026.08.18.22.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 22:44:09 -0700 (PDT)
From: Tien Phan <tienpp@gmail.com>
To: security@kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Tien Phan <tienpp@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nfsd: fix use-after-free of DRC slot in nfsd4_sequence()
Date: Wed, 19 Aug 2026 14:43:26 +0900
Message-Id: <20260819054326.1265334-1-tienpp@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Found with an in-tree KASAN harness driving the real free_session_slots()
on a live slot xarray (KASAN: slab-use-after-free, write of size 4).

Fixes: fc8738c68d0b ("nfsd: add support for freeing unused session-DRC slots")
Cc: stable@vger.kernel.org # 6.14+
Signed-off-by: Tien Phan <tienpp@gmail.com>
---
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

