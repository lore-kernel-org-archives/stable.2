Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011951;
	b=gF2AlLQ1nGxuJlSKAvDcFfKva2Ejzcqz9AH3JJczfyEbCcxBR3L16MSij0pi/3tAt0QO
	 H2lrhuiqDQJK1HUQS7sb6iqPJDD6nz705klb0XP/4F4vyE9zlCCvwGP9MypqiQC3XxSSg
	 cxfDpKLbY6ZEAs46Bku4M5h7H6LPPcouvy1fd4luL5Pc80YC5J9UwaAlwmNypz5N/pMkQ
	 BoDy7+ekUsB6AgRaVvT1x8FCmD4tbrGxVQbgb2PzZwnRqsUghNyUD4zTL7L3aUrHEMIWt
	 LqQUjc3ToBX/ADK3zCcbsRY/WiHuqDrf36wOdd/6+RPJNpSeYOQH09xB6d7sRZHjofA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=owqMREQTLT+Zo8QWHeU7T7LGj9Otntmb2TJUoLFPRXc=;
	b=s/8tH02NRSDyD0eWVrmYYmxm8UhTRExNQMlDjbQ8rqQT5ROdriserIxByphhvztJxkb4
	 LPbYLiZ25D+p5Z72yupFuoeuGB7fHsRRLCFFaSRSer3ctbTeGs8egYow54+xM630tDVqw
	 jnHiE9BkIwRSVuvbQ7povnv2D8eUpfOvNayZgDMgP6pmlviAZMQjXNfzs8S1S2hOFvJOQ
	 I2MoM5fCwdmfi9jL5ir9Yy3fbn5TCeG8D7RaHxbJFmDjD1SJIlX1mS6XMdjFfVLhA5oVk
	 EGlaqORHrIYTzjkjEgfHdQHJgzsm/Vvqz78LomzB4LpJFyGLxFMfEv8rmtQE0qU3zog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r5er5cJS;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D59B606A323
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D59B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r5er5cJS
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-19305bcb72cso1892841c88.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793011950; x=1793616750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owqMREQTLT+Zo8QWHeU7T7LGj9Otntmb2TJUoLFPRXc=;
        b=r5er5cJSvzXwn7jDrT11oN01E/bRxlwHFle/7BGfEoBV8tSk6Mw3V+nk81Dhd3GQcT
         MCb/IWLYqiCEnymZ4eyPewC5XV4shu2wdobqXW5U0EjqcNw3rmrStXNvSd+cIsJvMF8b
         xn8E2S3A48PMPAJiBrLWHScTUHV0+joxI8xRgKSwF3bwzE2cYwDh96mt6JE4hO3jbaRR
         +wN0dXxYi42CtRUROnKsQaT2w5NK2RCLZrAM+dNkkXhXCgWMkMFxrCAK2rgz2K2cMG7R
         WEV0IdW+MdsFj+95Mf/lrGhYZlFcC6qv4+L5c1aE2TnUHbZr9BzlhYSZ6/cBXKhAdfX7
         lYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011950; x=1793616750;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=owqMREQTLT+Zo8QWHeU7T7LGj9Otntmb2TJUoLFPRXc=;
        b=Jr+8+JE0shf+OgB67P+I7OyP3j107pfWoGrwZtYY1yKLip6JFSMDw9ZeAfN8ag42Hk
         iBRAdCzRXsJsl4ZxHaLrWo+DBx3Om6t9R6pEeSp+PiE60tBWNsL+EwxErVNU0RRVDjdh
         UvzGG8FB5IC1sk9hTTmWBmUJ8l9nNA7Ehwhr8yGjFDtGL6qzD0bl2vDB9ZFNhrhSHWBV
         jETxkjR9BXCl9IQmnnSqKh8RUWeuYtJuWdPXF8nwM9jM7C8F7ew2ZSOiwYDOOkaYaBys
         GH0ro/Za4H1EEV0z57nfgb4TfowdY1lBJCTKgaD0M+9V9CEHwfB8VR/xLAMmKmkaHO9W
         4cyQ==
X-Forwarded-Encrypted: i=1; AKwUvBybAVrLoOaKfzWKwj1qKBuBkzjiFkMs2awOV6y0I+89yZeud+meoHZKEvk8PZL33AXRVxexpQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPFW+TbCvJItWtDa0s3RZbh/zQ4OL1fe7s+9xxz+ZhFZZ+cExU
	lM8MwZvNNFMOscMQuNCa+PiF2XEM8bMYDl2vH5Rve7YALItuSGIHKEmb
X-Gm-Gg: AYBFou3mgih/2Q8bfjPPuh1y9oGODnY0quDrfBhdwOVE0azGwQilMEqjd5Bz5vCgTNN
	gjX0uisCYqzFF3Ns19VAStWN0cQypdrc1PgtUJ6ieSKp3FncsJByZykfD/u9hVfZcmqwLSM6iHp
	CKLVaPV6V4T4TjB5CU8QjFrVp3U+V0gAiuSt8TB7htTfOVA1rIIyRYiKjX1NE/TCTdXDuXAa8Y2
	3ytH4Qpp/NAOB4G3iLLDJRj32kHBMHYr6ApHqK99FoHMWfXpdsYSDwQ5X+ON9w2GnKuUH0kLH8w
	wr8eeRsLobDDcvEzUQhMFuPOn1sIvfOwFxLSa5TR6gr/vEiTDxM6TGqHUX4klL4rfCRiJ/1rFIl
	khojTI2cazQDhc0qTYynMjT9CqrqeYROe6YthY1STUy1MV4vVoMedhjHBzOU9LbdoC0zGM5s/2T
	f63B3z3Hg2ixerwvH5Rg7Fzy4A4W8yheIj69OwIp6xDnFFSP4i2IRMFuvUV8jItjuCFEt65smK3
	VAEeyatgxd3qQQ7pFkxSEnhherAlL12W41Z91Kkb+i5WPLvjSoNxEQkscTMFZBvH7QovQFYudVA
	Hjcx3GoYJfkg6vI5dksHx+xWil2ZY2CaP7Q97UfW
X-Received: by 2002:a05:701b:420d:10b0:169:bef5:f445 with SMTP id a92af1059eb24-19928f14c3emr10337456c88.4.1793011950077;
        Mon, 26 Oct 2026 03:52:30 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee69sm32439171c88.4.2026.10.26.03.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:52:29 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] NFS: pin the superblock across migration recovery
Date: Mon, 26 Oct 2026 03:52:22 -0700
Message-Id: <20261026105222.1150121-1-teel4res@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The NFSv4 state manager walks clp->cl_superblocks under RCU in
nfs4_handle_migration() and nfs4_handle_lease_moved(), then drops the
lock and calls nfs4_try_migration() without holding a reference on the
nfs_server or its superblock.  A concurrent umount can therefore run
nfs_kill_super() -> nfs_free_server() while migration recovery is still
inside nfs4_update_server(): the server is removed from cl_superblocks a
second time (DEBUG_LIST BUG), and once freed by call_rcu() the migration
path still writes server->mig_status and touches server->super->s_root.

Pin the superblock with nfs_sb_active() before dropping RCU, as
nfs_client_for_each_server() already does, and drop it again with
nfs_sb_deactive() on every path: umount then detaches the superblock but
cannot reach nfs_kill_super()/nfs_free_server() until migration recovery
has finished and restored the server's list membership.
nfs4_handle_migration() releases the pin after nfs4_try_migration();
nfs4_handle_lease_moved() releases it on both restart paths and before
its final return.

Umount may now wait for the migration attempt to finish, bounded by the
mount's RPC timeouts, the same trade-off as the other nfs_sb_active()
users.

Link: https://lore.kernel.org/all/20261025180323.349533-1-teel4res@gmail.com/
Fixes: c9fdeb280b8c ("NFS: Add basic migration support to state manager thread")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
v2: add Link, Fixes and stable tags, and remove local validation details from the
commit message.

 fs/nfs/nfs4state.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index a5dec04..ff866f6 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2169,8 +2169,12 @@ restart:
 						&server->mig_status))
 			continue;

+		if (!server->super || !nfs_sb_active(server->super))
+			continue;
+
 		rcu_read_unlock();
 		status = nfs4_try_migration(server, cred);
+		nfs_sb_deactive(server->super);
 		if (status < 0) {
 			put_cred(cred);
 			return status;
@@ -2212,13 +2216,20 @@ restart:
 			continue;
 		server->mig_gen = clp->cl_mig_gen;

+		if (!server->super || !nfs_sb_active(server->super))
+			continue;
+
 		rcu_read_unlock();

 		inode = d_inode(server->super->s_root);
 		status = nfs4_proc_fsid_present(inode, cred);
-		if (status != -NFS4ERR_MOVED)
+		if (status != -NFS4ERR_MOVED) {
+			nfs_sb_deactive(server->super);
 			goto restart;	/* wasn't this one */
-		if (nfs4_try_migration(server, cred) == -NFS4ERR_LEASE_MOVED)
+		}
+		status = nfs4_try_migration(server, cred);
+		nfs_sb_deactive(server->super);
+		if (status == -NFS4ERR_LEASE_MOVED)
 			goto restart;	/* there are more */
 		goto out;
 	}
