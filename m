Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F247AC15C
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047122; cv=none; b=G6K/BAROp4ykttBtxUebWJBfedN2PS6XKwdtMgaZ8XJ5RAf8bsf6GcH0wjTQlcdBUnyt5+O/cl4/3rKA1qQC+q2+w9EmdTUVAFzRDuEd7TErkX23arqdnzQ1PgwXXySdVunI/8ZwD5Dvd+8XCwyMSsFODJwSuSCH3+0RGwu1DIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047122; c=relaxed/simple;
	bh=Hszg99Fhnt/WRuDbGMmPk8WSIMvY26tREE486XMnpmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FaJdJ+vWeevYeVp1yWNBIrKHi+4WrrFkdvuS0OTOnQQQcNStvxd4W6P4hjYqYqxAH8fTv+ioJIeJZLyotoGn9xzM9AoavIdCd/kWpfc8XFTru7+43uW0q5oadK35G2TKyaQ0AAePMxgIvTUy8QA8KklfImMNwK/ww7zWNQESwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=QZ1kpC72; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="QZ1kpC72"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84a652535dcso920740b3a.3
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785047120; x=1785651920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8eyy01gUZcTypOwXF2vr3vGTrQtX1X17k4pOsofiCGY=;
        b=QZ1kpC722EVZFG0/AWQbNnb9tbfSYtiZ8Il1avooyCNydGPXn45jo9i+HSiljCOeK9
         FihD6kRr68xLC+lyxW9h+wr5q1k3otBdjvEDXVUpXnerF/BAJjOlJMFP0V40NTIhui7y
         zrKXrO99Koh+CRr86sya4+hY41yfto3IsgaLbeMklZIMKEuWScRInsyIkNCL86264s18
         zwDxBJ8/mLxZhNQ29xUfDadxc241+pItcHZYw5Qlf8UDvAOWXA3ATQu177Xt+YB1y68o
         zjY4EygESmlep36ISa99Xthi5Jg67ZkndQ+QBprIbQi7R3M8Z3BS6u7NRMuWuFAbtmkm
         NUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785047120; x=1785651920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8eyy01gUZcTypOwXF2vr3vGTrQtX1X17k4pOsofiCGY=;
        b=OPmDWZKWqdz7+EObnP4q8in27p8grUqZu9O5rdLV5dGTTU8LhFN4CCr7Fyq3JUrujb
         JRurZYRUuyM8U/MW1sKEhHjbuLt2GRTpoJKfz9qc1aMXnEss2GgF6jj4gXWi89I0aX2L
         AwoGskAb/ZNtHomKwNATfvQda3hkpX+v9q4A+55+ieM+JiSt06O9eDtXlfGpytfNWiV5
         VlrxVn12mgRhkgqNt/4DoMRW7TDEEy8dOW50SVbTL7kPMvytayx/tSn+ZyJQVHLh3Crt
         rRnLWp2qe3aGUvA9thd9KqPDKCD0uOfUOgG6b7j632swiW5fExgmeoBdn0SqZXiD412W
         c44A==
X-Forwarded-Encrypted: i=1; AHgh+RonU/JTNWR5lFQ2Jqls4PZktIAEzhdPbmOSLeQ4PMgTlSZRTd0Xqpn4luOKltVeEZoNi19NRps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAseVD9CpgHmdcY/Ox095q47b922sYX7snT+B1tM2sgKGaXhk0
	HM2VoOVQITP5HDOGex6inUPc8+X5wFlGXDbhDR4aEzdkcV+1L6joUm07yMbDuGwAd7UZtPmeA75
	4f0jlDgA=
X-Gm-Gg: AR+sD11eLKnXSlGr0imOqpUFN2hxQN9LCFrZz65lkYvN713/Bpnimb7NHVH5Y1wxCE9
	spt1gbq7XjxktqBOTnruO5tH5DBfxtvlM+LNo3LnoV+X5kjYeJNmeHjB77/ta5g8Lgoq7vN01oS
	ZW02jo6qn6vya5BNB31ZfiFIEYTLv845RLwpYsmlWOqk1edPUHQ5MeIWHJwfN0McAOZFlAQIDBu
	QKgh2Q2e5r6z0IKDeshosjr0Kw6tb08y4saTiupE/AYaEV49z8h0cnMWQNHx1F3tO73gMDEJGpm
	Xdpbr9by3ekUcAfsI6r4AIup+r62+TZHVoV0iC1vk6GJ9PY5gUlAmc8Ae/eZ50zusl2l4TcUXYf
	1+b7ixQc0SI2at4fC7+ZR99MTHipbm+B52IuVRlWcON6/LOc2QZ7efGz+tv0bx32xm8eWFkBk/C
	6aSM8Rm494S4UZEcqMDfdKW3jz7WenNoeTrt/tRDSIVuH+3dn2ywuTTHN4J0tW
X-Received: by 2002:a05:6a00:4c9a:b0:845:dbdc:8652 with SMTP id d2e1a72fcca58-84e5942bcacmr3501122b3a.2.1785047120125;
        Sat, 25 Jul 2026 23:25:20 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66dcd38sm1841236a12.29.2026.07.25.23.25.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 23:25:19 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: hch@infradead.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH] freevxfs: fix off-page read on a crafted dirblock
Date: Sun, 26 Jul 2026 15:25:14 +0900
Message-ID: <20260726062514.43756-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxfs_readdir() and vxfs_find_entry() both advance the intra-page offset
pg_ofs by VXFS_DIRBLKOV(sbi, dbp) at each dirblock boundary and then
dereference

	de = (struct vxfs_direct *)(kaddr + pg_ofs);

without re-checking pg_ofs against PAGE_SIZE in between.  The enclosing
while (pg_ofs < PAGE_SIZE && pos < limit) test only gates loop
re-entry, not the deref that follows the addition in the same
iteration.

VXFS_DIRBLKOV() is 2 * d_nhash + 4, and d_nhash is an unvalidated
on-disk __fs16, so the overhead is attacker arithmetic of up to roughly
32 pages.  kaddr is page_address() of the single order-0 page-cache
page returned by vxfs_get_page(), so nothing else bounds the addition
and the de->d_reclen load lands off the mapped page.  Directory pages
are consumed unvalidated: vxfs_check_page() was never implemented, only
a commented-out call survives.

Both sites are reachable on any mounted crafted freevxfs image, the
vxfs_readdir() one from an unprivileged getdents64(2) and the
vxfs_find_entry() one from any path walk into the directory.  When
d_ino is non-zero vxfs_readdir() also feeds the off-page bytes to
dir_emit(), so they reach userspace.  KASAN reports a 2-byte
out-of-bounds read in vxfs_readdir().

Re-check pg_ofs against PAGE_SIZE right after the addition and before
the deref in both loops, restoring the invariant they already assume.
The added break leaves the page the same way the existing zero-d_reclen
break does.  Well-formed directories, whose overhead never pushes
pg_ofs past a single dirblock, are unaffected.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 12495ea3ac47 ("freevxfs: refactor readdir and lookup code")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 fs/freevxfs/vxfs_lookup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
index 138e08de976e..b068f93359fb 100644
--- a/fs/freevxfs/vxfs_lookup.c
+++ b/fs/freevxfs/vxfs_lookup.c
@@ -87,6 +87,8 @@ vxfs_find_entry(struct inode *ip, struct dentry *dp, struct page **ppp)
 
 				pos += overhead;
 				pg_ofs += overhead;
+				if (pg_ofs >= PAGE_SIZE)
+					break;
 			}
 			de = (struct vxfs_direct *)(kaddr + pg_ofs);
 
@@ -237,6 +239,8 @@ vxfs_readdir(struct file *fp, struct dir_context *ctx)
 
 				pos += overhead;
 				pg_ofs += overhead;
+				if (pg_ofs >= PAGE_SIZE)
+					break;
 			}
 			de = (struct vxfs_direct *)(kaddr + pg_ofs);
 
-- 
2.50.1 (Apple Git-155)

