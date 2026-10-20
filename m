Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792467847;
	b=0B+rlfTTZUNoCXHEjzBsFrc9BVHKWGM8EE03MDjLM+36zt90INg1u/Bspz+X+s8yW+xt
	 xrWAK0tj/YYpkHZqJ/JPcI7/hmgVdfn4Y1DfqUdJUUmBISaNtDc9n2KufC2VBw9CSBg92
	 1CwAfLUKlMyrNTso8DWlifq3GVDWtYcv8Cwow9HwF0YjxLHvJpz1XKualiJgu2BoNuK6T
	 /i12xfzFmxzxjFLRWP33IB5K+eadCGSWvqe171lLsIhlpbUrzxDBi/PUdLqAdBe81Af3e
	 W4lVmKE2Cc6//94I7lRSKRk9xygbohB6jXMsKo+QVTxsWCwhYGHnDaE43n4zfVJsXrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792467847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=w90pHw3fGNmejRxHV3IQ5d0u+flhYgOFmkRKLGlwKUY=;
	b=lskzrYgJPGhDDB0TsbOpX8EXaC3SnWB4LypWKmfjZVozYmJPI/Csoy2/tKWsW33qTRgB
	 4+NNIK+kA03oc3//rk5G26hQxDSt7Wc9W4jwLQ6uU2RJdGrQtn3+zw10i98LU2ZEEs3IO
	 bQAPefsaT6lW+rNURAHV2II/TNUoPi0DUeiYT+gbYqJ65XmxV9Geiy9N8deIW/0EUk96h
	 UQIqjlWGHWTteIRv2xO+14qoIPOyjJg9yJ5Gdy4t4oNJBjFBlkDHlzfHGH+02HicpkkOD
	 tBPl7AF/QZNBsgZgLqpO6FtqG11vMbPBAiPvtVLL6tK62g3cby2gTvsFWGL4+ntasqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jKYUKJe1;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB694606A338
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB694606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jKYUKJe1
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8b20a899fso13717945ad.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792467846; x=1793072646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w90pHw3fGNmejRxHV3IQ5d0u+flhYgOFmkRKLGlwKUY=;
        b=jKYUKJe1Qxu3OEvXl+CyKhrb1gysrHVihdVulnoLL39qaO9RJmO6ZZGFSWsNpJ9tTp
         q3MGx3yk/C4W/loq3ecbZZa8SBnRpMnqya2hLCJfkvHFRPKA9jFh8ul7rl6OrO/llfLW
         i1RcjOxJjGUhWkgCETfb7uab1oKAcCTft7lettkw2I29eXYLuMMyJTYwSqJJAgmQN2xI
         1mu2kNuhujB/uPJTp+pns+aCp24ExiXR0JITQJ3MLoxttWpVHcwmzsJsbqw/SmnM+Ytc
         3KvMeCRJkBXFfMWgWtLkB72qUOGzXzStX0WqbCYzXaKpYnNtRdO0DSnVAYCoN6dMs9ex
         llZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792467846; x=1793072646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w90pHw3fGNmejRxHV3IQ5d0u+flhYgOFmkRKLGlwKUY=;
        b=wnBREloZ30I/+Iskz0sbRCsXXb1Xvx3UeByfSe81waWUPZPFAeQL5R112rfTnmuBqh
         u1BiFKlffU0yAFVpOguwux16K1zZ04faZ5HOFNpIMuYsg0CH1OisqBQbsmgkyOdY2QsY
         l11xPJe9JcEACMfoPB5gS/cEk30Kt7QqmcJFDMMhn1NfW7hmsSkAE9+aVU1gmDVCDDh7
         vXhIpOWR8rhkFJE20z6t7G4AOitbqa9YsQCkwDYyzXn+f20vs3aQSYmyAQkpPg+G1jX5
         X/+jgMBD4qbgJTuICKItG4/Mq+pNS4aKw+7tdubOqDM57uQibw4fQHaVlfGyqXsiiR5E
         DuGw==
X-Forwarded-Encrypted: i=1; AKwUvBxz0q1RikwNNEPiHBkGfhfPhkxwCSJbqC251KIFIkPGla+mXx52Ti5TABdEBK8bhqamCyUDcDY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKf2vEr6P0NW7MZYSJXu67urWZ+H4ONeCgYXlpU5+uRYHvrUCkm
	rW36z2EIJ9mwYvWJVXC+zE6N36Z6ChkNs8PQRKatJk36u73NDJTT4irv
X-Gm-Gg: AYBFou0FPAtIO9Z0U1zslb49Skp7+/haquMPAt/NgoTjKjPm/2+9JmdAmDLtxU9KJRJ
	wBshMCie8Tzd90MxLzQypddRAcTHSROHomDtHq3qPoPZTG0jGoRxsVzHJlkoiYRilBM1yyU1+Td
	VosDs6UKaDIwLqVkCHUwfnQW+3GFOImKiGpNRgXinJJMssZqPxH9DdKnX9WHxoOuWr2L1v2+j8Z
	Yil1FXrnHChl+epsA3sw7K7AiSQnbx665VIa5eFtL5dM/kJAs57LI0Ky9ICV6noKggCaKIAGrrs
	CY+wtsJ9L/vVUc6P0cDpv8rqcO3lOs1sBuF0wme/OEeqEwDtvKjqFEIcUIgCni1xwqiYNmMZVNu
	JyqXr35z6wZ2ZElEyIPxGn7A9vQbQfmmraGthDzLcc5gYqHJbbx+E5n3G9ofuHT1JR2puUjJ9G8
	brEgd6xoKekRS9I9dbxPSA09q0p6LkxGBl9G150LsOTktpIR9+/MKjHOiQXwXMEpPxHQ==
X-Received: by 2002:a17:902:c40a:b0:2e5:e1de:9c3c with SMTP id d9443c01a7336-2e9a6d2b9b3mr84139745ad.47.1792467846122;
        Mon, 19 Oct 2026 20:44:06 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea14caa857sm8143885ad.12.2026.10.19.20.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:44:05 -0700 (PDT)
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
Subject: [PATCH v3 2/2] ocfs2: snapshot the dentry name while tracing file release
Date: Tue, 20 Oct 2026 11:43:52 +0800
Message-Id: <pm-ocfs2-objects-candidate-0088-v6-d3056754af7e660155d9-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-ocfs2-objects-candidate-0088-v6-d3056754af7e660155d9-0@gmail.com>
References: <pm-ocfs2-objects-candidate-0088-v6-d3056754af7e660155d9-0@gmail.com>
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

ocfs2_file_release() passes the live dentry name and length to a
trace event while holding oi->ip_lock. That lock protects the open
count, but it does not serialize dentry name changes during rename.
The ocfs2__file_ops event sizes and copies its __string separately,
so a concurrently rewritten inline name need not remain consistent
between those operations. The separately loaded length may also
describe a different name.

  Release trace                        Renamer
  -------------                        -------
  hold oi->ip_lock
  size the inline name
                                       rewrite the inline name
                                       under dentry->d_lock
  copy the changed name

Take a name snapshot before acquiring oi->ip_lock and release it
after dropping the lock. Keep the trace call and open-count argument
inside the original critical section. Cache the event-enabled check
so the snapshot is paired even if tracing is toggled meanwhile.
The snapshot keeps the trace name stable without extending the
inode lock over snapshot acquisition.

Fixes: 468eedde23d6 ("ocfs2: Remove mlog(0) from fs/ocfs2/file.c")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/ocfs2/file.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 3c4637b32c09..8da73d0707ce 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -141,18 +141,26 @@ static int ocfs2_file_open(struct inode *inode, struct file *file)
 static int ocfs2_file_release(struct inode *inode, struct file *file)
 {
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
+	struct dentry *dentry = file->f_path.dentry;
+	struct name_snapshot name;
+	bool trace_enabled = trace_ocfs2_file_release_enabled();
+
+	if (trace_enabled)
+		take_dentry_name_snapshot(&name, dentry);
 
 	spin_lock(&oi->ip_lock);
 	if (!--oi->ip_open_count)
 		oi->ip_flags &= ~OCFS2_INODE_OPEN_DIRECT;
 
-	trace_ocfs2_file_release(inode, file, file->f_path.dentry,
-				 oi->ip_blkno,
-				 file->f_path.dentry->d_name.len,
-				 file->f_path.dentry->d_name.name,
-				 oi->ip_open_count);
+	if (trace_enabled)
+		trace_ocfs2_file_release(inode, file, dentry,
+					 oi->ip_blkno, name.name.len,
+					 name.name.name, oi->ip_open_count);
 	spin_unlock(&oi->ip_lock);
 
+	if (trace_enabled)
+		release_dentry_name_snapshot(&name);
+
 	ocfs2_free_file_private(inode, file);
 
 	return 0;
