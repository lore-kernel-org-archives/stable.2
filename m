Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792900993;
	b=pN8JtRJWPuzz39OiQr+DV5oO2Y1JR/Z/cNYU2fCraKWiJJXuzcOgYbY2SXiQVccmu+rJ
	 NSr62eiJyp41uICoACnkQ9Cn8d0/JnBFcOeCwxWMqYrHvlydJxi7gJEYb6bu1IwIF0GZE
	 rY0FGjoB2rMYf5KDFSyhFiJVJnmyWtUY3VmWFjKv3kho6OGYCCA8iN2K4dTfQL74WytF5
	 3wvQ7R514l452jBWlmvCbDs2iwVuazqF8iSPkkC2rbQq94swOPfaO4NaITNGVsV7cH2vr
	 PVg+i6BIKaXLF6etDlEWxCKNtIkS7cgOzNQb6V5vOs/oe8cl7p15h5U3vO/dAWpnvUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792900993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bXXWN0U2LwSgs5yFSiYomIOkF6F+3ijFGiBpJE+lZgY=;
	b=dVeCc27tR/yUI6Vocc7AC3X43X3/yPUsgFMRYUUQyilDhygdc+8f0j3cENL95WLbvrbW
	 EP7JgwmxNzjAtFO3iosHxrniX6NJjDnlGF5kwktN7r1P7qNEx8SaSv7ahdUPmY8UMsJ0I
	 7iZdwRwzK9b/TrRv3gj6Ry7sMpaRCrfd9Vu7VCauleCBWq5DOEqD/dxE5KhICSQo3OYb3
	 piHVsnn4o+RUIo+uX0BP2R4si2u8GqP3kARpIg6l2JTAS/ccwLJpQkAw6xEDnNxOED7WL
	 jATSYWOWhUa5WFwmnCRyfn5I0HdDPsYlGiRd6JrNoRRNPDX00dkcLrQNdiNiG89EKVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DNKNW9T7;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BA5606A322
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 04:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3BA5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DNKNW9T7
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d01548ac96so2494435ad.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 21:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792900992; x=1793505792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXXWN0U2LwSgs5yFSiYomIOkF6F+3ijFGiBpJE+lZgY=;
        b=DNKNW9T7kGfS78TEh9BVgxXbbjDsK7FmBqAhYSl/KQ+eTH7raGVvtdvg1NUc98VoRU
         K+t6Nc6VFF63JU0nm30Oaoo7PWDuZqaJa/VGdjf1oEl1vKQws6xUEHvpigr1aU8XJKW9
         ARzBEbRowo/1PB62yadC/gAYjKkjUksvUtAWL5KNMcmW0it4u1TdjgS9IKYCVSUT/B4B
         5LmSmhiSWh9nYee/Q8xH/mbjnKv05BsnHAXumcfsZ1MU10WIv7HErjsSADO0LjhEhqVG
         kuOy2JsugMVzT+/xQMFxDhtCn1QSY8Ludbs8xew8apip8FeKjXp7edLasQnaxkyYNus2
         mgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792900992; x=1793505792;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bXXWN0U2LwSgs5yFSiYomIOkF6F+3ijFGiBpJE+lZgY=;
        b=RBvr68tBOiv0Vu4ixu5lg4veXfgEdxZAXudXAEOPEDqJLLfLd4iKJfwfUGL3Vufp+h
         VqxgRxjuGtXgUS/hokGtPD6cpqVZYIqsHHWV1uavmcXG3K6N28OpUzfeDW1KcnKAIxjC
         qNiC7f8XuzKvDpq4oCSu7zIo1BAQuHKA3PhgYPRUREnWzJVFhSbPcn5QzxGuwCPrAd+a
         tRBHn6zD4scVmSqsNOqCXLrJK9QaYJM1NUvhMPKFtJHVoY/ZPSNY8CdEfNra4f5oGd77
         5BsyMnqoNXGX9j0KrVlzSt7QuxOktXA/8OKLQvQ8f5bQGjLTRS5TfePZMVL5h/0Kiisg
         JAWQ==
X-Forwarded-Encrypted: i=1; AKwUvByTxQsSzSGDpGMTv1N6gL+PItj8vnPcbievPxyOYFO1WdKYAmqI3rwx/ypDGIBOKft1hCyZFUM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIA9imtfX0ukavvECpd53voRQNKYNERt0X1k83QiNRIEckkVdk8
	ObPahRDQXXUBs5RDpvwJwI7btb7/8SAGNgaEch08gikjGlpyzPlJsVMm
X-Gm-Gg: AYBFou3R9zUE0HFvdsxXcuYKi1MP8B3n6nkp0vWgdt+lvoVpHveEipGhidrvkU08Aij
	XDomh2OYoM+7oOm4/jKAqIIsqEvsIjbCOJKWtM4om87TJhCrZrs2jmXdpLhQgbJ/OCAJK0RKfjE
	gtX7Apxbgr/aK7i2zJcZJJSCqlFEuzjR4SDsTPXede/pcRuoCefvRJRVqtQ6UElUTQopEd6PLrS
	Rhf0qQGvMRn9NZFM0jmgD4D2A6kwvr7VQdnBg8Ayfxp/83pQs48FzMq6vGAs770CgGc3uOEZncr
	z2NnlaeojmviwRO4LedU/Ksxf3a+c1FCHxiMAXeV2c7g5YU58eKu+FIoPuPfaXHsDv+BazpuCEi
	LmZJCPL3r9UTgXknWeWlKNHnHvw4GAQ0auMclUtX10cT/S2qP/9PRYzeJ5WWam3sWtJ3GmfUNmf
	ftzf+zACwS/i71K63IrQLN+wLE4ZzhmiM5ILm0lSHZ15e1TzSs7fgos01t7JxLnoYCpFoDnceQs
	CdXWcdjdTCYB/jUuLO9b4PsR97vQR6U4cuv0M2H7+w1HSmF6kU8ZRHc3rIseIJMNwskyBo81/6r
	/3pg
X-Received: by 2002:a17:90b:3c0d:b0:3ac:a7ee:6785 with SMTP id 98e67ed59e1d1-3ade9b35f05mr4994498a91.1.1792900992309;
        Sat, 24 Oct 2026 21:03:12 -0700 (PDT)
Received: from melokc-laptop ([101.90.152.206])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb82761esm2921587a91.0.2026.10.24.21.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:03:10 -0700 (PDT)
From: Anfernee Cao <anferneemelokc5@gmail.com>
To: D. Wythe <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] net/smc: fix possible recursive locking in
 __smc_lgr_terminate()
Date: Sun, 25 Oct 2026 11:53:35 +0800
Message-ID: <179290097759.51540.15412712294727302463@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

syzbot reports a possible recursive locking in the SMC listen path:

  WARNING: possible recursive locking detected
    kworker/0:2 is trying to acquire lock: sk_lock-AF_SMC
      at __smc_lgr_terminate() (net/smc/smc_core.c:1580)
    but task is already holding lock: sk_lock-AF_SMC
      at smc_listen_work() (net/smc/af_smc.c:2463)

smc_listen_work() holds new_smc->sk while calling
smc_listen_decline() -> smc_conn_abort() -> smc_lgr_cleanup_early().
smc_conn_free() unregisters new_smc from lgr->conns_all before the
early cleanup, so __smc_lgr_terminate() walks the remaining
connections and locks another socket, not the one already held.

All sockets use the same sk_lock class, so lockdep cannot tell the
two instances apart and reports a possible recursive acquisition.
Annotate the per-connection lock as a nested acquisition, as
smc_listen_out() already does for the listener socket.

Reported-by: syzbot+7ea1f5efd5de7e24f1de@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7ea1f5efd5de7e24f1de
Fixes: 2c7f14ed9c19 ("net/smc: fix LGR and link use-after-free issue")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>
---
 net/smc/smc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 9974149659c2..5911368ae520 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1577,7 +1577,7 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 		smc = container_of(conn, struct smc_sock, conn);
 		sock_hold(&smc->sk); /* sock_put below */
 		read_unlock_bh(&lgr->conns_lock);
-		lock_sock(&smc->sk);
+		lock_sock_nested(&smc->sk, SINGLE_DEPTH_NESTING);
 		smc_conn_kill(conn, soft);
 		release_sock(&smc->sk);
 		sock_put(&smc->sk); /* sock_hold above */
-- 
2.54.0.windows.1


