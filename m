Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCCC41A559
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365954; cv=none; b=HPOuu0wHJN2FF6lwPo/mGe253734Xv7Qf5dbuVPX6nQynYAylvebuIxuZasV4QwHdSFX4F3RWsfDQ07N0sc/RFSAEk+cziJB+ZSry8JRGg310RvicBBzHsVk0UVlRsV9KmAHTagKlQVcljmHJCcqa3j/OBIuTcRzHcfVZROwSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365954; c=relaxed/simple;
	bh=ltIY9uBE6y8MfuJYlvojnTbjdBIXZTNaDFDXcw7XK4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0STTMcVzBahMXs+0WhFGSAGdlbaTCzsMixFHyocelVkAf+anRMxwW/U9+2LFJybotUgFf1HhaVibV/q4GTskAEHL6Wh4Gqenc4ZFvUJglj1nhF+cJlxeJf4Q2AHIra1DUxNiWlwPB4hBCRq5wDKnxoF4j9p/hrsnyRt2667/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q12y5hh+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q12y5hh+"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38f57e312ecso242294a91.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 09:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788365952; x=1788970752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lzfX9o1vZqX/GQxyo2tpdqzQmgLiqfjFpA7wcygJbw=;
        b=q12y5hh+v0vcenlpn/MMSmojux/kLg0airTtvUoA+CwU7t1I4DydOOxm2wr+amWhCU
         Q8W/9abskVcuvd9lzHxYAZ4Q70BNQ806guntjUnFwi/d3G+OMfB5YqsDRUwPHptnvtfV
         yEKSc4Co4MgcWyBXsKkUMUQxHix9M6CmqmRSsv3swDD9XQC0kMaqNBBWpfZZIpBT+ZFg
         3yHUJrNMVwY9zMCjkVEDRqCUzz0L7a1sYBKVAvnKk0IQfIIXx1ckYe2xkKHSyT+oGpfW
         KhcCbHiB+KCXWSi5q1GTU2/ZvYzSGJfBDV+kcBtaDPXDnmRe7JvaI3bxBblBPPhRSi+I
         kIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365952; x=1788970752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3lzfX9o1vZqX/GQxyo2tpdqzQmgLiqfjFpA7wcygJbw=;
        b=igvLVw2G9FVu6cy/RQRMe+B8L7b1QNJUoAjbi07G/TB2sxOvVffXT2It1uLpO9xqrh
         uFi93Vb/Ca8KSx+SGIKz6tvS/TPb3lNijm6JXjPU8y89Nsvw87s5cQBjEEeDVCmB5Y2X
         8qU4QSNHyHsYJ5tWn5BHRN0qqTDEaumm941tsw9u8TqYvaMkmHY42CpseLXwL9IPclsZ
         8b7e7hICJbETTS5TK678ChfSuWKWKWGNMOtFQbDedG4oojfc3VztCWTS30lQNZ44gfv1
         fzsw9pdsobe2eVlICB1eEvh+0nvI+GxEs9CSx1zqlm8hXVxeF9dzYO0YU82aT2BX8GsY
         JHUw==
X-Forwarded-Encrypted: i=1; AKwUvBzcNw+dVESVlOKyrp5X4VPyt/byexnDl9SGKVvdYe6YUMgCg6X8OBpbWBZO56jjTxVT4aX04X4=@vger.kernel.org
X-Gm-Message-State: AFuF++mmUX4pLv2433DzhlZ72o9klVznxBCprFhUNtV+hIVfAs9GfG+d
	McYyxfs+rAVJiAwJakbr/BNEEQ6EVttenv0GWMtwcfz1eW+p1hhuw91D
X-Gm-Gg: AYBFou3j181EZByI1XbN1VaaewNDkRO+cDQjC/FwvDoPLu7LlVOIEEk+x7E3PTURaRy
	Le0GtdcrjmqGRoKWw91E+0MOdKdmKc9p7kllcDLRvHBpHwnZGZ+lA3xKtcg844yCTAk+S5BnxH2
	d1XRznReO8n/+SY6IusEQWFp2sfmddfIAUL9fOEn3KImgmNCIbMfrB/wx/SeP9Y5PAXgFrZUFo8
	VEkHK2LmpBAa+Okoj8NscfgDz4uevjlFqRBgBC8QTsZ3BTp1h0j/rlecVUQFHw9qr/G2i5vVhWC
	w8GlnhuYe78zx3OEk7euy1KOSpyY9HZLkoL15MFznTyHOPcqUgtSs5Z+APN0/wiNGtkNLOnTlNc
	yBZb52b7l5dFuQtyj3PHHGBNuWLdShFw4BadDMSEuqyf3rBqVm5KLfOr1pRCWdQ9pR3leDDmLIe
	uERUCjwZnasB2cc6HIZdG+LJWnCorfb20oaRsO5DcFPm2DE5xgGsW9jjgtiUqtrA0BsNZOQby8c
	PgfZM/Tt/q4nvwqAQ5WjfnURB7Wf1htPqc9TmnO/T3tkcs7nPFrIa4E6w==
X-Received: by 2002:a17:90b:1d0d:b0:38e:c140:2a0b with SMTP id 98e67ed59e1d1-39aee0e6ed8mr6182969a91.3.1788365952381;
        Wed, 02 Sep 2026 09:19:12 -0700 (PDT)
Received: from localhost.localdomain ([119.127.198.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b087b59a0sm148569a91.17.2026.09.02.09.19.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Sep 2026 09:19:11 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: john.johansen@canonical.com,
	georgia.garcia@canonical.com
Cc: security@kernel.org,
	Qihang <q.h.hack.winter@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] apparmor: bounds-check the OWNER companion perms entry at load time
Date: Thu,  3 Sep 2026 00:18:40 +0800
Message-ID: <20260902161840.75210-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAH78Gvtz15Q1icWZFpB68CY3xhdyddw41XCDR8BRS9zwA8EyWw@mail.gmail.com>
References: <CAH78Gvtz15Q1icWZFpB68CY3xhdyddw41XCDR8BRS9zwA8EyWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For OWNER-flagged DFA states, aa_lookup_condperms() may access
perms[index + 1] for non-owner lookups. verify_dfa_accept_index()
only checks that index is within the perms table, allowing the
companion entry to be read past the end.

Reject OWNER states whose companion perms entry is out of bounds.

Fixes: 6f442d42c0d89 ("apparmor: fix profile verification and enable it")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 security/apparmor/policy_unpack.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index d9dcff167c480..e53f92b34725f 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1485,8 +1485,24 @@ static int verify_header(struct aa_ext *e, int required, const char **ns)
 static bool verify_dfa_accept_index(struct aa_dfa *dfa, int table_size)
 {
 	int i;
+
+	/* the OWNER companion entry needs one extra table slot */
+	if (table_size <= 0)
+		return false;
+
 	for (i = 0; i < dfa->tables[YYTD_ID_ACCEPT]->td_lolen; i++) {
-		if (ACCEPT_TABLE(dfa)[i] >= table_size)
+		int limit = table_size;
+
+		/*
+		 * OWNER-flagged states are indexed as perms pairs:
+		 * aa_lookup_condperms() returns &perms[index + 1]
+		 * for non-owner lookups, so the companion entry must
+		 * stay in bounds too.
+		 */
+		if (dfa->tables[YYTD_ID_ACCEPT2] &&
+		    (ACCEPT_TABLE2(dfa)[i] & ACCEPT_FLAG_OWNER))
+			limit--;
+		if (ACCEPT_TABLE(dfa)[i] >= limit)
 			return false;
 	}
 	return true;
-- 
2.50.1 (Apple Git-155)

