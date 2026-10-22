Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660130;
	b=kUbuthJoaj/BvkMz5qkiUgYCKEFs5Odirp+2GEJLs0TgsWzsRSonufliO2t+9A6lEmbQ
	 poBqq2AzLIUbJFKS+sj4vluJotszhrYD2TKq4AamtQEG7HK+/Nb+B//lox4ne1s3s47Rw
	 jmREUJ6v0wEXE3P3P8WmFDDdysnKSVXKeNF86O8Tyz9OlcrSkGVTanR2T6z5+OCIYivMb
	 o9SSblPzFps9H1+ewmL0w+kJPJI9ri3gkB4D4C/OAPC8BxzLNVyvt/wDnHJudMpnNHtxf
	 qcab8L0uaHw+b+JSxzqjiWrzv9Vh58z8WI88FB3wKiUNDEGEZGlearDgQS/I0bzT3Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RLwjd0wA/MWjFh1zhTci1SLIdCeLzV5/hu4CPoq8FCY=;
	b=ZD7t+P+FSfP3q6Rs2NS+Upq/Fj8esWQh4RiuB6+p1s1Nq6RBtUWepxNauFVfy+dAo6Kx
	 c9Nbk8aKV1uWBQEg6MFAHjiQTLD8vC8io1t+ldfrmDHSr4wQRWJUGUcfkhgmS4+LRGXTe
	 slquKugeaL48wnjuwQcD0+npmdiWC82q+cqo0OrsbyqkiQAk04NhDgsH0pCQMUDRQrUOE
	 FADFN4igvx4E3FeAXZC4LZX9eVtTIIaPr40YG86JkBiRQDqjY5NCTBfyrOHvdcckOipGV
	 RoTa2Z6hyuSPuF3Rwqy2/JyszYzfW26+6kPiE6/bQp40COZ17tyQXHXcH9yTcdkYlgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CY3l8Psn;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34A606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA34A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CY3l8Psn
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so860972a91.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660129; x=1793264929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RLwjd0wA/MWjFh1zhTci1SLIdCeLzV5/hu4CPoq8FCY=;
        b=CY3l8PsndLAVHacYhXCYhzOUrOOdrTi1or1qcqw+YzmZNgjKYUWAcAcNGmqU5LYEmU
         ZcH1+K1aBDcpmAjpDG3BXowoh/Q9edg+xXhyGguR0BgETvAc86KrAC0zXKXWeNy66ZlF
         NCbwoFw0R4bBMiVqHXPj9ZlwQ9rhVdxiLy6qhqdwlQmOaxbjmwxw/PnBI+jqX2GH1gZZ
         Yh9MDtGxxr2iOP3yQsRqOI59TWfkePZ5MIti1xjENP9+HADypTubFicjA/DsaxZgBdAL
         Zy0o4O4PQobkISfVHa3X/puDHf9RndgeeddQzsfS5bcAb+r2FspTEKWKicE+eAuivIdz
         eD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660129; x=1793264929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLwjd0wA/MWjFh1zhTci1SLIdCeLzV5/hu4CPoq8FCY=;
        b=x3Y4lz3YzH6DaPPDZJv5AYkf2PdmdaxWPBF9470WZUL7R5YohTKOfQ4N8RyfreyiAZ
         tcEQPyM6iJ8otg9x8vDoEFuJoc7JhweCur2FpGL/E1I6JGvlKn/ran4fnEkPE9l6Uhhc
         6T2SzGXmWe45U5pABU9wnRl84AdJau7H0zt1q+W6vAhNLgsbQRuPSeIwJkQXRwlMfMDc
         ePTEGmAgO43srpA/osLdcm6Akahw6upuJT5+6e8GW/hFbhvynM5pLkjBFc8RS8aPfV78
         7oYN3Cnwrkf6t/wF35qzgLiiZdCyGrTtJ1/EHWLT4iIZbXPAdm7vKvZzU5eF2IN2W3/t
         i/Pg==
X-Forwarded-Encrypted: i=1; AKwUvBz4J8VcXwn9lJ2e24dXdrYyGtrBi3rxS23ySz9Bu+LdTAlcaBvDZ134aBFnxYL5kpmNU6U1zlw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMYbScZP/6ZS3e0WzABIhYOomgKCxXEpumDTBDDhQMMNNe7NPD
	FYwGXLj0lujCN3xZPXgfOwB+bfIUakVoqk1EgM+DK2yJNiDuXB1oaa/V
X-Gm-Gg: AYBFou3keYDi+dNwGB2V+qkPeUPBWCyoEmmIH8aLb3+oeCXcxoItVS77Cohqm6AduMD
	evZ1Gj+x9yOXb+ZbrOpDOwQ3VyYvGCmFrKc2uz67MPJyXpXCFgJy6UlBJdWuPTpE7yOR3cH+45K
	hYtSflA8+8Ds68MASa3Yzs0XpgInAGK3OLWtwtVV5K4O4UKTrTt7BkpOGj9uvuu9mXqXd24oPXa
	MyVBmXKICwtcy3GDBjsFKQ5bUKwnAJwFMK+vPPUgJRr8+fn/UpZUjjig1OpAoAhilOhI3SAI130
	me8epKRORA6jcZ/uZdNtyvY1I9fzy8/sXRZnWD+NPkyJkKiB6/Pcx7CTISBHjSDFB69aZJaHFaK
	X7Db5DMQgGa1X/ZsDTh3dMNJuejusZWThj2sOz/jmr8NZkq/D0qeff5VD+kjVbG3c4+6PG5RWPH
	S5SxXrvuQXPMWqp4rjUgqOPx6CbVuroydx1xbNKuibum1ST2hG1sGmXN0z1AjIvUx8sO6v/TPXY
	PeRZkXSuV2MAkZyT0KwujdTdU4WfgTlUb/S8Bf/eVWBYJZq6K8=
X-Received: by 2002:a17:90b:1b0e:b0:3ac:a993:5b5c with SMTP id 98e67ed59e1d1-3ad86afc038mr4100221a91.6.1792660129150;
        Thu, 22 Oct 2026 02:08:49 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490c096sm3325111a91.7.2026.10.22.02.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:08:48 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v4 0/2] ocfs2: stabilize dentry names in file and setattr traces
Date: Thu, 22 Oct 2026 17:08:40 +0800
Message-Id: <pm-ocfs2-objects-candidate-0088-v7-6324344256f0c3b1c3d8-0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Snapshot names at all six users of ocfs2__file_ops and at the separate
setattr event. Patch 1 handles the five ordinary file-operation callers
and setattr. Patch 2 handles release separately to preserve its locked
open-count sample and take the snapshot outside that critical section.

The release explanation distinguishes its existing RCU lifetime coverage
from name/length consistency. It does not claim that the ordinary
callers' external-name UAF interleaving crosses the held inode spinlock.
The release source change is unchanged from v3.

Patch 1 also removes the read callback's redundant NULL-inode check.
The two patches apply independently and leave trace formats unchanged.

Cen Zhang (2):
  ocfs2: snapshot dentry names in file and setattr traces
  ocfs2: snapshot the dentry name while tracing file release

 fs/ocfs2/file.c | 118 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 41 deletions(-)

---
Changes in v4:
- Add a name snapshot to the separate setattr event, including the
  same-directory source-directory rename case missed in v3.
- Remove the redundant NULL-inode check from ocfs2_file_read_iter().
- Clarify that release can select external names but its held spinlock
  already delays their RCU reclamation; retain the inline-name/name-length
  consistency rationale and the unchanged release source fix.

Changes in v3:
- Cover all six ocfs2__file_ops call sites with two patches, grouping open,
  fsync, read, write and splice-read and handling release separately.
- For release, keep the trace and open-count sample under oi->ip_lock while
  taking and releasing the snapshot outside that lock; cache the
  event-enabled check.

Changes in v2:
- Replace d_lock around the tracepoint with a dentry name snapshot so trace
  callbacks run without the caller holding the dentry lock.
- Pass both the name and its length from the snapshot; keep the event
  enabled check and release the snapshot after the trace call.

Link to v1: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0088-v3-d628f98bfcb6784a0bfb@gmail.com
Link to v2: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0088-v4-a9a0df898afb4fc65fa0@gmail.com
Link to v3: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0088-v6-d3056754af7e660155d9-0@gmail.com
