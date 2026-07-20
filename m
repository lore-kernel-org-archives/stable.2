Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620DE400967
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563618; cv=none; b=cJ97REFquIw9QxVhZCe+QRkbAAlsCiFXZiytwAfo3NUI9N6ii+/NVCW4r3NTuimKW1rIHFCCFJJtM6hGoSSOMho6GGuS4NgKHCaJmSraz/F+ODMxV/pfKgVmqK4gEtMG6MyucitQdmPrf0pn8hGJPNVPX7mHletF7whADaTo38I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563618; c=relaxed/simple;
	bh=uBKOtoSytIa87hb6P4JZ8OQ+rSgfkcaH5ESrlGek8bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J6Bh/LliIsxBp8JRQJs5pPrwni5Pu4Ha/n+vclWwLNFI+7GkYzjEY0O1pg+d25dAdE+xKplzbJeuH+wYAU3zQjOu4nr0B+Q2/V2bmEknmUaaoppb9jMg+nRcvE8nkxqDyPwTLPWOM2TTGDTz86E3M9NM+zHg9Em01/SOZtUERng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5ROvZjv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5ROvZjv"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cca0c5799eso79671585ad.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784563617; x=1785168417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o1b/iXtthE0NdNXxVcrsPqsvYfRN7KhJFOgx8+/tTAY=;
        b=N5ROvZjvLUG+mxv4q9w/WkYq5UYoiKm6vAD3xeToGIyIAinjJHV+B2shXH/E5hNB7b
         aKTSdbd8b7AiJQD6yTnAsyUY3LXoiNSvYMw1Gqe9wTrn6sPbjVixth1OXYToAQqiUXmG
         rCjQ7+TxuekQf+og+JGB60xYqPATzwev8efupdwxv1oC2RKeg/NdtpiXOkhoHdeeSV9s
         TyNf/X/JthoZgjjQ5w9ZnmNlCfkEyx+PzIPN/ikDUnZ6rncXvPZ8wkPUBaycyroi2ZXl
         M6VMlrymOMbKGhG8lmbHl5bTnOOfqg71VrRNWAiOPlIih1WyiCSHY6LD4knppw+lEbgK
         odtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784563617; x=1785168417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1b/iXtthE0NdNXxVcrsPqsvYfRN7KhJFOgx8+/tTAY=;
        b=dqw4yGQN3AE9X/eKNUeUyAPMBRUJ/AbyOogo1e/W/+3d+Q/fxOGVN/6c5gDjyuuIkp
         RP7aVRCJ730p/T/Dr7lvR04e7q+vniUUZAfiUh6JR77F+LbCZuEt/uDo5Jpyz1gVt4kY
         kAu3RtJmR8YwDt5kUXUE2tX2xm/ri7zUVcnpFykPVspPQpSsmFJ4aK9mQ6uQ35g49b2w
         2SKpBj0BPzCvCLY1wcpnafPX16ToZhab4ZHt1vte4Ey71kYHgt6ing58g2z93V+ytwoQ
         DtNA+owwDQvIrllyVCUf3fvTar5YqqqpKPC4n1MLclHsL0bDmt/CnNBfFT73/1Blp4qL
         iHDA==
X-Forwarded-Encrypted: i=1; AHgh+RqROPanZTcbVITjg3e8k1SDu1SGg7ARnjW14V0qUs1Ww7uo8YcVo2hGyPfIUvHL3x/mN5x0Bks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVx9XZb9bVtAI7cISBA1CiYDx6mKJpPxG+6tO2xC8TAPUsnMBd
	/9rhfkjDZCVNlfastMpZ/90iThzeG5adLXhYu4wUMS2Izvg7JTONDcjT
X-Gm-Gg: AR+sD13x332YRH9FAq9F/CfhL2k+IBfK1WZLOW6d+akwhzazAuV4sIps55KniX/pDZP
	r43KEBVDfL7NSnYUnl0aQsCHvdTCyh483ftvculq3feYVwAwSfuhY9lgeGn81ImumWagmbPML5R
	2OMOr2ia3fr5w+UQohkSD+jfm1jQ7uwuyt+12uRUnUd/GXQTik8FZ/a//tGNw3qrdC9C8GhzwRR
	SolgeqitlV4kPPhYWI0+/tB2KGMXO8EzTeq7dmFXWvd6Ya/RcZkhpmu2NtpLyLhE58bAhQx4zWF
	oyTOIsuVFSbVX5Y4uCUtXp53J4T/3zK2KJvUJKgxCsSh+bOdkBaGT2QoHG9H+V1k+z6Oo9uUU+p
	dcHm3uNUuuSou4jq/g+WI1UgwN++mCECuGRt78nZm62gfB+dC9BdSSANowQOu6hwxCt5gNHC0Ep
	WahQMFdEUSr6n5pFl0tY8pw8fidlYHISZYBRPDcQ==
X-Received: by 2002:a17:902:ebcb:b0:2c9:b48c:fdde with SMTP id d9443c01a7336-2cf3496cb62mr160713345ad.26.1784563616336;
        Mon, 20 Jul 2026 09:06:56 -0700 (PDT)
Received: from JRT-PC.. (bb116-15-8-251.singnet.com.sg. [116.15.8.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344b16d4sm59389985ad.20.2026.07.20.09.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:06:55 -0700 (PDT)
From: James Raphael Tiovalen <jamestiotio@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: James Raphael Tiovalen <jamestiotio@gmail.com>,
	stable@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] vxlan: mdb: Fix source list corruption on a failed replace
Date: Tue, 21 Jul 2026 00:04:24 +0800
Message-ID: <20260720160428.249356-1-jamestiotio@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When replacing the source list of an MDB remote entry, all existing
sources are first marked for deletion and vxlan_mdb_remote_srcs_add()
is then called to add the new source list. Sources present in the new
list have their deletion mark cleared, and any sources left marked
afterwards are removed.

If vxlan_mdb_remote_srcs_add() fails partway through, its error path
deletes all entries on the remote's source list. That rollback is only
correct for its other caller, vxlan_mdb_remote_add(), where the remote
was just allocated and the list contains solely entries added during
the call. On the replace path the list also holds pre-existing sources,
so a failed replace tears them down together with their (S, G)
forwarding entries instead of leaving the entry unchanged.

This is reachable from an existing (*, G) remote. An EXCLUDE filter
that loses sources starts forwarding traffic that should be blocked,
while an INCLUDE filter that loses sources drops traffic that should be
forwarded.

Mark entries created during the current pass with a new
VXLAN_SGRP_F_NEW flag. On failure, delete only those entries and clear
the deletion mark on the pre-existing ones, so a failed replace leaves
the source list untouched. Retain the flag until the whole operation
succeeds and then clear it. Also stop vxlan_mdb_remote_src_add() from
deleting a pre-existing entry it only looked up when adding that
entry's forwarding entry fails.

Fixes: a3a48de5eade ("vxlan: mdb: Add MDB control path support")
Cc: stable@vger.kernel.org
Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
---
 drivers/net/vxlan/vxlan_mdb.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 055a4969f593..af7a0d7f95a5 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -42,6 +42,7 @@ struct vxlan_mdb_remote {
 };
 
 #define VXLAN_SGRP_F_DELETE	BIT(0)
+#define VXLAN_SGRP_F_NEW	BIT(1)
 
 struct vxlan_mdb_src_entry {
 	struct hlist_node node;
@@ -844,6 +845,7 @@ vxlan_mdb_remote_src_add(const struct vxlan_mdb_config *cfg,
 		ent = vxlan_mdb_remote_src_entry_add(remote, &src->addr);
 		if (!ent)
 			return -ENOMEM;
+		ent->flags |= VXLAN_SGRP_F_NEW;
 	} else if (!(cfg->nlflags & NLM_F_REPLACE)) {
 		NL_SET_ERR_MSG_MOD(extack, "Source entry already exists");
 		return -EEXIST;
@@ -853,15 +855,16 @@ vxlan_mdb_remote_src_add(const struct vxlan_mdb_config *cfg,
 	if (err)
 		goto err_src_del;
 
-	/* Clear flags in case source entry was marked for deletion as part of
-	 * replace flow.
+	/* Clear the deletion mark so the entry survives the replace sweep.
+	 * The new mark is retained until the whole operation succeeds.
 	 */
-	ent->flags = 0;
+	ent->flags &= ~VXLAN_SGRP_F_DELETE;
 
 	return 0;
 
 err_src_del:
-	vxlan_mdb_remote_src_entry_del(ent);
+	if (ent->flags & VXLAN_SGRP_F_NEW)
+		vxlan_mdb_remote_src_entry_del(ent);
 	return err;
 }
 
@@ -889,11 +892,19 @@ static int vxlan_mdb_remote_srcs_add(const struct vxlan_mdb_config *cfg,
 			goto err_src_del;
 	}
 
+	hlist_for_each_entry(ent, &remote->src_list, node)
+		ent->flags &= ~VXLAN_SGRP_F_NEW;
+
 	return 0;
 
 err_src_del:
-	hlist_for_each_entry_safe(ent, tmp, &remote->src_list, node)
-		vxlan_mdb_remote_src_del(cfg->vxlan, &cfg->group, remote, ent);
+	hlist_for_each_entry_safe(ent, tmp, &remote->src_list, node) {
+		if (ent->flags & VXLAN_SGRP_F_NEW)
+			vxlan_mdb_remote_src_del(cfg->vxlan, &cfg->group, remote,
+						 ent);
+		else
+			ent->flags &= ~VXLAN_SGRP_F_DELETE;
+	}
 	return err;
 }
 
@@ -1069,7 +1080,7 @@ vxlan_mdb_remote_srcs_replace(const struct vxlan_mdb_config *cfg,
 
 	err = vxlan_mdb_remote_srcs_add(cfg, remote, extack);
 	if (err)
-		goto err_clear_delete;
+		return err;
 
 	hlist_for_each_entry_safe(ent, tmp, &remote->src_list, node) {
 		if (ent->flags & VXLAN_SGRP_F_DELETE)
@@ -1078,11 +1089,6 @@ vxlan_mdb_remote_srcs_replace(const struct vxlan_mdb_config *cfg,
 	}
 
 	return 0;
-
-err_clear_delete:
-	hlist_for_each_entry(ent, &remote->src_list, node)
-		ent->flags &= ~VXLAN_SGRP_F_DELETE;
-	return err;
 }
 
 static int vxlan_mdb_remote_replace(const struct vxlan_mdb_config *cfg,
-- 
2.43.0

