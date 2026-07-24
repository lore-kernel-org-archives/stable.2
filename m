Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAD5374E55
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929625; cv=none; b=F6a3J/FaUMtlNOvlvQNR+1DAyw+iAf6a8TkqkyAbUGB+Tt+HwTlFnHcwlysq0WUVIciakgjejKCF7q37ak5dngD3Pdac1UNw80b43VDhJ7wQ5xNoA8b5FqI4cI2+4l/TKuSVIyxC29yZNEMFnmW7xD+HwjqA9ekTagF9iycYddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929625; c=relaxed/simple;
	bh=6pLnwWeKSASc1379eeY67KlKjOo0bUXxMmQCpFnyiD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/YK6iMbOVk9j8VWUTdBRblTQ9b/2OQTM693Cmmg49mSx16M85U/THK5bNepj6jq0pfjX6mUrUoSZknV+ZKjCzxUqUlkVOnx4VKYtZb8WgrJVPvTr74iqvZ5Wzpy1WAGFIubgxhNPmsYRSkrp8c82OfBHLiKlBJOJ9zTRucfL48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJXjEXcl; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJXjEXcl"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c01089e8aso6200071cf.2
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 14:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784929619; x=1785534419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=42dslX+jW/ktUVa63IhDYJMEcXLz+OxoplxTRWEwi+g=;
        b=SJXjEXclffkXoXLWEfAScrpc13XmmxUkYc7csfLUXnF1w07jp8aimF6kawcJyFN6Z2
         oSfbIWC7/y03QtjdCvUqyPMrQaa1+tIstqO58c7zzDlXhsusZtK7qgmilTOSpf0khG61
         Hw4oicFLUcPicA2f7LRDmDnEmftOqW2iNAZmJUPsAb3Sy8YTq7ll2nkFyoch2dPV0Ftx
         Z0D9v1K/FTNWEcms7QhX/gH6qaShe9qaohYYJ5vmKmpzpENt3qABHRA5W27V+mifGKwS
         kVhYcS+NJ+Y+SsSGSpqXq6Ybj1ddxZcIQjikQloUMXtuLMvpdiBu5+MWODAFjaQLXZ9F
         NI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784929619; x=1785534419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=42dslX+jW/ktUVa63IhDYJMEcXLz+OxoplxTRWEwi+g=;
        b=OPDUIonKJbi0F+L9hfwfR+fS82pBRe2U0oQBQF+WFjusn51W0MrEWIGH6qvLOPaxjS
         vupmR/lGFdsLE3YuEHJOEpskT3Df5tpwRjM7+iprQRqj4/sZrf6MkNhtXc7uuddyl6oF
         o8Ef5V5OLQlq2IKf7IIzdmIXWDCTEsy/KEN2QJP5577XHnb51McbqRh/3d/FdNiRWtOS
         EOqUEql4ym/TuUMdQHyTXwCL/APj7w2IkrWY05ala92jxRdCYBGDsTUho9q603tS3C9e
         Cr8d5k68EUUn+nhjPuZqs6S8E3uJHafjaJIcJbmxQWAS6fcId5MWTEy+p1ymFuw3Va42
         u0uw==
X-Forwarded-Encrypted: i=1; AHgh+Rq4Cahg/Evx+diYcc1dSuZnoq8MIpe079c++uLJ8UqhsTC0IMXhJQPIAgMpHfSbdOyC24leC0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL/svzTZSEEuCGrC+y9hjhZ4ns1EO6XOZJUimDyTQic7BDArQH
	x2gNRRNZyWsJ7GmWDXz2Lo3g38F50cHiw5RdhlC0JEC4enid2Lf2ipuO
X-Gm-Gg: AR+sD11HwxswCqB2fwqQ3v9txQ/edgHBXFxSgxQTMrLci9PZ0ZXvlH+7Mwzw3V2i/xF
	6go7J2AMQlkbWjn1F12Taox0uiTmOlCgCIYoKbJwldxTGYKMdTMCLQTVdfDBm4IsiFeWLExydtw
	H/EqJd1uZcXx863goOTyJTP54qwFtNzM2v/iL/XJmEK0IKWxyuKnf6KCEufpuBuIl/OqSjEkNfi
	+zTWQfZL9YKI/E0cvwKXCYRYfG96Y/UkXkPKHEhtVx7CmcCNO0BeukOVrBIwnc7MFmTmtchzqt/
	QCqc830lyGELKhUXFAc3ICLR7iK69+vulQoJzINR9d0RlvWnbdLflXwi4UfxRxvj425N/lBC9lF
	ctd0uS7CqYDjjvv0UY2k75yRO+6tixL5M6TA+6btAkq8/0AyUeaKopOBPl48wckdS/iImsChcS7
	oJh7ZdUyiWm0wjJzk=
X-Received: by 2002:ac8:7f15:0:b0:517:76b7:7b3e with SMTP id d75a77b69052e-529a862a750mr1298981cf.38.1784929618689;
        Fri, 24 Jul 2026 14:46:58 -0700 (PDT)
Received: from FredPC.lan ([2600:382:311b:26:c204:8bd0:9563:8b5f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a29cf785sm7916771cf.21.2026.07.24.14.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:46:58 -0700 (PDT)
From: Fredric Cover <fredric.cover.lkernel@gmail.com>
To: sfrench@samba.org
Cc: pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fredric Cover <fredric.cover.lkernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] smb: client: harden DFS cache against invalid target hints
Date: Fri, 24 Jul 2026 14:44:34 -0700
Message-ID: <20260724214435.1850384-2-fredric.cover.lkernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724214435.1850384-1-fredric.cover.lkernel@gmail.com>
References: <20260724023539.1596955-1-fredric.cover.lkernel@gmail.com>
 <20260724214435.1850384-1-fredric.cover.lkernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, get_tgt_name() returns ERR_PTR(-ENOENT) when ce->tgthint is
NULL, and dfs_cache_noreq_update_tgthint() assumes ce->tgthint is always
valid.

In preparation for clearing ce->tgthint in free_tgts(), harden callers
of get_tgt_name() against ERR_PTR results and harden
dfs_cache_noreq_update_tgthint() against NULL pointer dereferences.

Cc: stable@vger.kernel.org
Signed-off-by: Fredric Cover <fredric.cover.lkernel@gmail.com>
---
 fs/smb/client/dfs_cache.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/smb/client/dfs_cache.c b/fs/smb/client/dfs_cache.c
index 8cd93cd2f00f..c9ace4326a35 100644
--- a/fs/smb/client/dfs_cache.c
+++ b/fs/smb/client/dfs_cache.c
@@ -869,13 +869,22 @@ int dfs_cache_find(const unsigned int xid, struct cifs_ses *ses, const struct nl
 		goto out_free_path;
 	}
 
-	if (ref)
-		rc = setup_referral(path, ce, ref, get_tgt_name(ce));
-	else
+	if (ref) {
+		char *target = get_tgt_name(ce);
+
+		if (IS_ERR(target)) {
+			rc = PTR_ERR(target);
+			goto out_unlock;
+		}
+		rc = setup_referral(path, ce, ref, target);
+	} else {
 		rc = 0;
+	}
+
 	if (!rc && tgt_list)
 		rc = get_targets(ce, tgt_list);
 
+out_unlock:
 	up_read(&htable_rw_lock);
 
 out_free_path:
@@ -915,10 +924,17 @@ int dfs_cache_noreq_find(const char *path, struct dfs_info3_param *ref,
 		goto out_unlock;
 	}
 
-	if (ref)
-		rc = setup_referral(path, ce, ref, get_tgt_name(ce));
-	else
+	if (ref) {
+		char *target = get_tgt_name(ce);
+
+		if (IS_ERR(target)) {
+			rc = PTR_ERR(target);
+			goto out_unlock;
+		}
+		rc = setup_referral(path, ce, ref, target);
+	} else {
 		rc = 0;
+	}
 	if (!rc && tgt_list)
 		rc = get_targets(ce, tgt_list);
 
@@ -959,7 +975,8 @@ void dfs_cache_noreq_update_tgthint(const char *path, const struct dfs_cache_tgt
 
 	t = READ_ONCE(ce->tgthint);
 
-	if (unlikely(!strcasecmp(it->it_name, t->name)))
+	/* Check 't' in case ce->tgthint was cleared by free_tgts() */
+	if (t && unlikely(!strcasecmp(it->it_name, t->name)))
 		goto out_unlock;
 
 	list_for_each_entry(t, &ce->tlist, list) {
-- 
2.53.0

