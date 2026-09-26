Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09736F90C
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790405441; cv=none; b=s2qy+XCUfJUYzNZcdYPVwcAHX9qwS4NSwgmsEVr4zWfsxMi+8yrk0F/3CFo/MrPLHPNF9gzz5vWdi/MZtXY/pZ3NEb5F1LX4YJcGtFL9zbhEAQMswUiC/oc07UxiqVN4o7xmM9TVlejwGj+WPsDi3JZS9sGV53TgZqf0DQ3h2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790405441; c=relaxed/simple;
	bh=mFXrpdHur6ulVZ7FvboHg5CLmQFWfcNDbSrvMkyHvmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKU3dzm61NFWxFJ6FeGF/pgc/loqo7YO2ZqrspUcQlaUqXdNPRpSHQ7Q14M6RjR+4bGeT9X/ovDWXgG2TVK7vzWH+EtQLtx0TzKkF4De6yGZ7Or0vdsCkb0vTSFkNPNOzl5XerV1yxqpALAFYmUz0RZW6RF5LMkRfU5FTnWGp+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Ru1lt7nS; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Ru1lt7nS"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so928513a91.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 23:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790405440; x=1791010240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8BskrzkXLwZJX8rcZQGp1wKf7XH5Yk+fLwNViAloYy8=;
        b=Ru1lt7nSkiIx3L3AdhhedyAfa+NZf2ZEffPDWUYttcVnKdoYcNlHFkV34W49/4mY8O
         4J5u5Jf4j5at8U2FwGMTgW5kx7dy0bOIb5AnryZz4o/E2S3QpPFC/pL6G7vJlZE+jqWW
         O/Czs7h4ta3xgNsPFPJsoUcLx6FdCmUVAozn9/fBhMlA/lOnVd0aykq7XXCNofTWHB8Y
         GZXmrKYFfcvx0U0dgPMeDmAhGpufIy+hFvbaDjwRcnd7cAaPWXgkIZUG4VwnEXZ1WFGB
         PRDLPIO9gYry/vhsKJcUUgtPR7veYjxE7uqycfRqbIj7R3nK3nuvR6xkOToWfeqQYXQd
         G7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790405440; x=1791010240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8BskrzkXLwZJX8rcZQGp1wKf7XH5Yk+fLwNViAloYy8=;
        b=Bh+TAa4asnvIA4DHssGyXXhCYScLT4KKsX2twscnVLsdC0PAhCaQyzbHFEy91CMkHJ
         ORdXrcK1GaGPUdDfX9noZ0xSG0J4SHzM95DKtbXsRALKHyd0hARHlwRqhc5PiydYvVPS
         fTlmHVeeXdZQ+JnaO8fb/OY3eyYoNi1mvqylSuNofoq9KI9vsKSMX382eFx6rpY+1CKO
         h0DKpLIZaBOIWibem992DpYy5iNebwz2+TuYWOdImYwzwIz6fULj4TDRni7DVuuTIs1f
         Jp4NRGe2kHs0xCTBniSWI4HCKTimRWRFbDvR4GQUvgBz5BPJGg9B0joHlF6hlFLKbeVc
         jkZg==
X-Forwarded-Encrypted: i=1; AKwUvBwYTGxxZvj9yiWplVZAevIezSzPG5r3rO+yoyqc8TVT48D1VfxrghetikRvJmSYukNaRSGbYtw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLApMWpZmUGgsJODvFWk0wyifcKSTO/cF0S9lp9NxiM5SZv33D6
	MiCXGLCNbdSDq6MSyBqrktgS8IwwpLlh77nTKDg8dGqx/2TqsdMuHbC1JIOZRg4bRLn1
X-Gm-Gg: AYBFou1J3pMJRO47wDH+5aFYSRsH8uliH3Hc8B9Z+Vnyl+li0ZOJGrjoBJZInJrEuS+
	Zz8ovChEnkHPveuZcUr+jVqnCm+GlH2OiITUPll7Z8cFTNrrkLFdV/+tGpoA/O1pY93EvS8LFUA
	aXZtxs/OZQmYmGVyg6RQWEHBJOHkU3ZCfAVrLSql5nvdqViy5DTGUXgsxMKDAqLJY3+cSUw1KCR
	1t9rELboFKtNMDWT57HgLr4pCyapwc/4Gom585f+aNeJsP/NJBv5LHezkD+HgM0Yur2gsD77TzY
	gJOFzlHdXMNVvzVqIs7mPr5Ut37IWM2VHD5PcZ/RuK+gdm68+/j+AUq3DDdVf41yDvIj8SX+7QM
	eCaF8F+ar1ILRj52h6Q6k/fqpJm2kP3CuPQ1ki2aqAsGlH3g3u3DIUTKYTqgqg1HTV8XZYQrORp
	sk6tFr4zyvKljOXlzjcbmnzxyrw/202OtPSpMaXyB9PD1k7u4pZIK7ffolcIuoCg542PnXl2isy
	StHRKbkGw11KOGIm4DfoYqEcJeNBA==
X-Received: by 2002:a17:90a:d883:b0:3a0:2900:f577 with SMTP id 98e67ed59e1d1-3a098dff5b4mr6227823a91.51.1790405439780;
        Fri, 25 Sep 2026 23:50:39 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b498fb12sm3447327a91.0.2026.09.25.23.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:50:39 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: sfrench@samba.org
Cc: zihanx@nebusec.ai,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	pshilovsky@samba.org,
	aaptel@suse.com,
	pali@kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 4/6] smb: client: clean up failed cached directory opens
Date: Sat, 26 Sep 2026 06:49:24 +0000
Message-ID: <4f216702a1f10927e20ed5295cd1a04a895978ea.1790398755.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790398755.git.zihanx@nebusec.ai>
References: <cover.1790398755.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

open_cached_dir() sends CREATE and QUERY_INFO as a compound request. If
the CREATE succeeds but a later command returns an error, the function
must retain the CREATE FID so common cleanup can issue SMB2_close(). It
also must not treat a response error as a valid CREATE.

Validate the CREATE response before using its fields, record the FIDs, and
mark the handle open before handling errors from later compound commands.
Move the -EREMCHG reconnect handling before response validation so a
missing response does not hide the reconnect request. Count the handle
when it is marked open; confirmed close responses decrement the counter,
while existing close retry behavior remains best effort on transport
failures.

Fixes: b0f6df737a1c ("cifs: cache FILE_ALL_INFO for the shared root handle")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v5:
  - Rerolled the series after fixing a NULL dereference reported by the
    kernel test robot Smatch analysis in patch 5:
    https://lore.kernel.org/r/202609241449.HlHmnZFZ-lkp@intel.com/
  - v4 Link: https://lore.kernel.org/all/cover.1789478666.git.zihanx@nebusec.ai/
changes in v4:
  - Validate CREATE status and FIDs before marking the cached-directory handle
    open, preserve reconnect handling, and balance cleanup accounting.
  - Keep the cached-directory Fixes attribution at b0f6df737a1c.
  - v3 Link: https://lore.kernel.org/all/cover.1788516372.git.zihanx@nebusec.ai/
changes in v3:
  - Split the POSIX handler check into a separate patch and corrected the
    parser Fixes history.
  - v2 Link: https://lore.kernel.org/all/cover.1787486936.git.zihanx@nebusec.ai/
changes in v2:
  - Add cached-directory cleanup for failed compound opens.
  - v1 Link: https://lore.kernel.org/all/eb1bc35611f91bd10a4772400b37fac26f660956.1782579150.git.xizh2024@lzu.edu.cn/

---
 fs/smb/client/cached_dir.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 88d5e9a32f28b..647fa26da4d24 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -8,6 +8,7 @@
 #include <linux/namei.h>
 #include "cifsglob.h"
 #include "cifsproto.h"
+#include "../common/smb2status.h"
 #include "cifs_debug.h"
 #include "smb2proto.h"
 #include "cached_dir.h"
@@ -323,25 +324,37 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	rc = compound_send_recv(xid, ses, server,
 				flags, 2, rqst,
 				resp_buftype, rsp_iov);
-	if (rc) {
-		if (rc == -EREMCHG) {
-			tcon->need_reconnect = true;
-			pr_warn_once("server share %s deleted\n",
-				     tcon->tree_name);
-		}
-		goto oshr_free;
+	if (rc == -EREMCHG) {
+		tcon->need_reconnect = true;
+		pr_warn_once("server share %s deleted\n",
+			     tcon->tree_name);
 	}
-	cfid->is_open = true;
 
-	spin_lock(&cfids->cfid_list_lock);
+	if (!rsp_iov[0].iov_base || rsp_iov[0].iov_len < sizeof(*o_rsp)) {
+		if (!rc)
+			rc = -EIO;
+		goto oshr_free;
+	}
 
 	o_rsp = (struct smb2_create_rsp *)rsp_iov[0].iov_base;
+	if (o_rsp->hdr.Status != STATUS_SUCCESS) {
+		if (!rc)
+			rc = -EIO;
+		goto oshr_free;
+	}
+
 	oparms.fid->persistent_fid = o_rsp->PersistentFileId;
 	oparms.fid->volatile_fid = o_rsp->VolatileFileId;
 #ifdef CONFIG_CIFS_DEBUG2
 	oparms.fid->mid = le64_to_cpu(o_rsp->hdr.MessageId);
 #endif /* CIFS_DEBUG2 */
+	cfid->is_open = true;
+	atomic_inc(&tcon->num_remote_opens);
 
+	if (rc)
+		goto oshr_free;
+
+	spin_lock(&cfids->cfid_list_lock);
 
 	if (o_rsp->OplockLevel != SMB2_OPLOCK_LEVEL_LEASE) {
 		spin_unlock(&cfids->cfid_list_lock);
@@ -408,7 +421,6 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		close_cached_dir(cfid);
 	} else {
 		*ret_cfid = cfid;
-		atomic_inc(&tcon->num_remote_opens);
 	}
 	kfree(utf16_path);
 
-- 
2.43.0

