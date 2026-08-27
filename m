Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C30E23E334;
	Thu, 27 Aug 2026 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852638; cv=none; b=r3vou7A382zISGwh5ZJhwfMA6KOsVgM1BSXtsaHAAnXjWIoB1QX9v8WIr8DExg7noFzjjH787ndHJ/a4p+4YCSdCteaslQnZ7ORg+zXlqBhpM6TkFIfe7QQ+P9c4zV9LHQh5Z/ajgMS8xrYS5xsBDHsitING0KjtVF75nyEjQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852638; c=relaxed/simple;
	bh=5mRXSQ+a87YtlJ6UtHzXO4UFEtS28CTeQ+vXCkYcGPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sx37jcfspn+rctBKYBGLvnvrP9RsqV4qIqfVxLyHYjp3MhgyQodQsi2NvSoCsVa2gqCAAzMpjiJ1KAMZgDgLoWhgOL4AefRiMiN98f9vZrCFbWTLKwRvbhzFybbuCn+dXVFIGYaHD+4dyZU9MukM5EiVbkKjbvs/7E9BXiYRy7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ejFXhYtp; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=HLM1QfNj; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ejFXhYtp";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="HLM1QfNj"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1787852620; bh=YB79QfroFRVBxYJA1d72Jo/
	dU55gRVR2euQiCawh/dk=; b=ejFXhYtp3oyFqnP2IIusctEG/iz3BqbpmsFfvBYHceqFDMgthD
	Iu5iAEBcMAZ40g7ivdWxtQZtVQ26Z0nbEV1ctCIqX9iG3HWK78LZ5OsgEZHMmnhvbfYufbP9FUW
	m6OxBJqxiDJmcad3Us/ZLvB0SKAxNd5JjTD+zD9HA+w+RjxuopJqeZB6CSUDdbwSFNCWEfQiQ4s
	uTPX7bL9p+P+wW/a9piWw18C7PPV1T21npsZz/jMwzbubGWrbTxNBzT0P7jB/grPBoFV9JRwvib
	vdGfKEUVCIORBNKfBl3RB556cSz1DTLEbg1nJWwXDr0/CiINiQEu7iDDa7b8+C8Xhxw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1787852620; bh=YB79QfroFRVBxYJA1d72Jo/
	dU55gRVR2euQiCawh/dk=; b=HLM1QfNjTzNsCMBihdlWbDxHGXhnpSi0plQdeibij2eljAPpuY
	jOCbRbP5XRitLZl2I9ftUXurnPQ6BIbjCkBg==;
From: Bradley Morgan <brads@mainlining.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brads@mainlining.org,
	stable@vger.kernel.org,
	syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com
Subject: [PATCH] ima: Check for ERR_PTR from dentry_path() in validate_hash_algo()
Date: Thu, 27 Aug 2026 17:43:38 +0000
Message-ID: <20260827174339.1729-1-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dentry_path() returns ERR_PTR(-ENAMETOOLONG) when the path exceeds the
buffer. validate_hash_algo() passes the result straight to
integrity_audit_msg() without checking. ERR_PTR is not NULL, so
integrity_audit_message() sees a valid pointer and calls strlen() on
it, which faults:

    BUG: unable to handle page fault for address: ffffffffffffffdc
    RIP: 0010:strlen+0x30/0xa0
    Call Trace:
     audit_log_untrustedstring+0x19/0x30
     integrity_audit_message+0x366/0x4f0
     ima_inode_setxattr+0x512/0x5f0

Check for IS_ERR() and use NULL instead, which makes the audit message
skip the name= field instead of crashing.

Fixes: 4f2946aa0c45 ("IMA: introduce a new policy option func=SETXATTR_CHECK")
Cc: stable@vger.kernel.org
Reported-by: syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/6a8f89e5.1d9ded08.62e62.00bf.GAE@google.com/
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 security/integrity/ima/ima_appraise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index ced2e131b061..b280488e15fc 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -748,6 +748,8 @@ static int validate_hash_algo(struct dentry *dentry,
 		return -EACCES;
 
 	path = dentry_path(dentry, pathbuf, PATH_MAX);
+	if (IS_ERR(path))
+		path = NULL;
 
 	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
 			    "set_data", errmsg, -EACCES, 0);
-- 
2.47.3

