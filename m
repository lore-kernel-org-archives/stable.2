Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71152566D3
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 03:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783395979; cv=none; b=jrQ8quiAEoNfrjMxQfvIQHDl7ERxyKgmDiHBT5WaKmHI9D4F2hd+Nbtt7CxO4i4FWlbW9klIcLSkvL841P/gLRghyUyXxMSKE+SNx9rKzu2HpEaS0+vCeZR5x0ta26tZjsTSYbqF0d3uvFhMQ85cxgYSBjv9tq5llTaNWG4GBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783395979; c=relaxed/simple;
	bh=3/wwhEu28nkdVTDD/T5U9vZxv0p8SIblnza4bO+PVno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bGdvbkDHPTU+yM5i76dbVMMPj0KV0WbnFWh9GQj49TreeWKMdkpY8FpvQhwFxJzbPn4R6ri20t7VTFfE0FfdaOiCld7Dq84ikh51Fr8eax9cJ6tzUGwwdwnMYpXDJqy4Ys0qY+ftnNiKK78ye2DHHM4nn8vvkRWM/LBr7xoSbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUKUEzps; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUKUEzps"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8453427d3f4so3435881b3a.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 20:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783395976; x=1784000776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jxoBHu26cugQjl6s+Ybwegp6gdyBHcQpjlaT1Gt5g40=;
        b=AUKUEzpsiYBIVbLhgnYEGc7NA6UPhCae6ujSflNTHOYzY0/PHNsEKrGxgxcPqirj7f
         5Cv/LyD1FYVnfZGCVLop9NZ97Uy/X4aStTFHH6u87R73YtVL7D7hiKlrzjyT9HquD4pD
         3phbx9Jc+uXgTkhJZKqtvJocYo4V/3wzg7Si1O1NMWwhNiakkYeTbB80DmaYfrFG1stn
         CQGImk6ShtFqSNYBetzTwcpXv+98v2NPydMB6M7khzr5UnAttaPfuQ6moZwguiFn754U
         CNsKird+wfMskdthpj4Vl8rjD1AY9t7FIsdTMFDECMW6+ZhtEpFuPFLQc1DK/v8xmCNQ
         l+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783395976; x=1784000776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxoBHu26cugQjl6s+Ybwegp6gdyBHcQpjlaT1Gt5g40=;
        b=IWZqQ7Jb7NZPdUgW4SPFigoDBy0bsEF+gRzdqh5x+kw+sf097/TxJISYErjasrenc0
         42Z1PzSzBiLwWQuP/H1YaeOYSwpHNip4tVNPwklnkdNs0NjyFx/8FjLUhR8G8T6aOZsZ
         2P5b3++uNg6czOJgSvGV0rnOvnSKE5oouVYWDKkewhMyaqQpOo3/+c+HsUsgJBR3EbGf
         qD80ifB2qZDaLBJH1hh8DMRCeOBmzeTdhP2p9ANwwJp2hv7x4Pq7KZ9Rl7wY9kqFTHml
         JJi8f3fGJqP5LAxgS4Vmt9aG9oYdME5eLzEmNgMEazQuJiFTXntZPupUj8/ssfv+wZlh
         H63A==
X-Forwarded-Encrypted: i=1; AHgh+RoGTGfDeps0XsgG39Kkf+2Dbz6yRYIn6g7y63l7iSZsu6ff7p4/wAk4VSFqQmYp8qB6OGstVCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMc3rdo0Dkg4oXNRaJ2PECRSlfNaapw+9EMeU1hgfSgIWevPvF
	NfdbF6kA7669OPV810ETTIwMy3Xv0DEaoqQ08W4acz0Ra1t9IFyKOKEy
X-Gm-Gg: AfdE7cnhLSbDp5kLi4pqedqiH4gIWfD6gZQNCCf27QgkvNt87KCc8Qv75Gsrkh0CEG1
	48HqYfNx2URf1moKSdOONUMzeMZNrnfXcYrptvSYB0y0UzeOhOXL6Wk0tz52HIwLHvnZbLQuhTD
	JtVYFimEuN5XNTQRPh7omB865k0uXT7GYB40R1mBcVpG7zWoeDWUxUttTz1ELJ6RVPXgHj3Oa8O
	GqWEHEZOcw42Yign+V+IrGRdVSZi8HwuSU9m0dczldxBF0c5no2pgVfRBR4ZO2mLy9hEjwJ4VyR
	vUbcJKR0eODuxNUUdDWrxtqOY406lyisNSxyfXkBrmbF975Vth+t3abW1gpn9U5HfjzTcHJukZt
	BXvsTg3TRb+7pag1Iw7gQtE+Z5PjdfyXeMHnxXDpK9tO2Vyf/nkKW8KToBk4YDqq6ncvQm9aQYf
	fTjvj0pd56
X-Received: by 2002:a05:6a00:951c:b0:848:2f7a:2e5d with SMTP id d2e1a72fcca58-8482f7a378cmr909241b3a.76.1783395975991;
        Mon, 06 Jul 2026 20:46:15 -0700 (PDT)
Received: from localhost ([218.76.62.144])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af6e04fcsm306097a12.4.2026.07.06.20.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 20:46:15 -0700 (PDT)
From: Qian Zuo <zuoqian113@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: gregkh@linuxfoundation.org,
	oleg@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Qian Zuo <zuoqian113@gmail.com>
Subject: [PATCH 6.6.y] coredump: fix pidfs file refcount leak in umh_coredump_setup
Date: Tue,  7 Jul 2026 03:46:08 +0000
Message-ID: <20260707034608.912-1-zuoqian113@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The backport of upstream commit b5325b2a270f introduced a reference
count leak for pidfs_file.

In the upstream implementation, pidfs_file is declared with
__free(fput), which automatically drops the initial file reference when
leaving the scope. During the backport, the code was rewritten to manage
the file pointer manually, but after a successful replace_fd(),
pidfs_file was simply cleared without dropping the initial reference.

As a result, the pidfs file keeps an extra reference and is never
released after the usermode helper exits, leaving associated objects,
such as struct pid, permanently allocated and triggering kmemleak
reports.

Fix this by explicitly calling fput(pidfs_file) after replace_fd().

Fixes: cdb61a705f5f ("coredump: hand a pidfd to the usermode coredump helper")
Signed-off-by: Qian Zuo <zuoqian113@gmail.com>
---
 fs/coredump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index d3a4f5dc2..2f1f66f42 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -560,6 +560,7 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 		if (err < 0)
 			goto out_fail;
 
+		fput(pidfs_file);
 		pidfs_file = NULL;
 	}
 
-- 
2.43.0

