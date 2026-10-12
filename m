Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F52F48D89C
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814381; cv=none; b=SpTfLJLSUU3jw3wwL5JxjA5E6h95KyFe9wrYi8A08Agyzs+VqtGSQO4SLZPgPcRMrEdayIBlhe8dPFwGIcsdloGKVuMv4guOuZqU/bAu4+RtOx33C1xLr3Mmhw+75hIx1u4GTH7JuQyl6cfJjZ6Wngya7f4FjAo+RHo1yVg96bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814381; c=relaxed/simple;
	bh=wrx+CrA4nefwJFZVO5mqtqhzKW6sZMVWT7xnGsdPGJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAgXEVBaRJs10zxVorX3eZtdQUfsXGjdzuORj8ztWM9L3c8/8Ma76VX5rt/TQvJbfs0BsBcazSz2GAPspmgcOGmI2dIamGwSoiBs4gjkPw/vKGgv8sJ1QL2Jdq5EAf5qGwe9iKKAHVrVDbxPfa1h1A4XcRBU2HIYWAOYptaQD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXJwsjkg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXJwsjkg"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afe75f055so1816356f8f.2
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791814378; x=1792419178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j1VyDhzJgUHMA7Wq9U/IKLESFKx2atIdhYsLlTj0K8E=;
        b=DXJwsjkgB9Ysd2X0hX4v+LMvBNo7lIepxckCGEQZebaw0ELDjX9eD4BLo1gWrre0E7
         FrXLtaAxfVRHCPeCd3cQdzRe15Lq7rMBsVLkS+eiCC+fsgI2gQcZvAM9kWN4dLPOujzc
         1NclSRYIWVPHpkBFIFqbxuds+i4SvaSmA0Lhh4eP7ZwVdZxjXEVZ1wDu8bacggxUQ8vh
         maFxY/Xj20dZ0QzYDja2RhmXQyPY5pmofKfP+NZo5HYj5cvJTDvavbf6xvyA316gCd/U
         4fEvaXs0x1wx3yHNxPgDTatf+Fqp6JqglsSf0ZZpkfUthbFXwvPBzWcsBngi00sMzsYt
         BuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814378; x=1792419178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j1VyDhzJgUHMA7Wq9U/IKLESFKx2atIdhYsLlTj0K8E=;
        b=SeaRZC0XN5EJvt7GXznXPPgcTr6wIvuy2HWqIAb2ci4Y2USx0mC8u3AAK5bxnpWeDJ
         eprpUj4npZlpS1GUhkw7sKJsiZ10jc/tOXXQmoy+WjCNpS5Kn3afo1r1St6EdK7kon5+
         KcN4Mi09o7zQdF+uQ8lrX1KKY1QHUeMSZYqlyhmpdg84XkxJV4v6jBXDTRyga2q3z+5U
         a3G+Z/fYnFx/b130YP4Bbotn+6K9vHdYJjBAqSm/p7sPLQKp8V6J8yDLx3YmXOIUIx6E
         ah3YFeKClpHVhAX+7wd+dLOdJZCQzmJhdqD47s4ATfLwYBZfwqgM2efQyPtWxHd5a8Nq
         2pwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYY0f0Oz3d97w95tXrWhbOKRneNg/MBeO6YEmGa/fqKvS5m4BhSlQNkwRya1BbOrKgC7XQ7PE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5fIRLdzdI30d+JLgcsw9S4vD4d7Q++J1qQu73BdlSTdyOHwrS
	bITpyAUgphzE8D1bqU5s+v9pZRpRV17Bn3Nn/vqgvkoz5OH8+FUHoV8igVXOEHJx
X-Gm-Gg: AYBFou3Wvfa4vZKT2eAidg0t2FswLPazlUoMHDEjXAbQ0WPUcRtRzBOO7Hcnggu/Hcv
	DZRoHc1SWFmvpEFyK2K0A2y32wV3zd+er3iFapz/TiLVp30njWek/74NZ86GlCJVTqhy2NFqTwt
	zCf6fRCmuANhv47S3IdI8HHarBFMTxh4Pi/Z60cnGONLL2bDjVsVosl6YnqrnwO0FP1dEjm4vGf
	Yd2ToUxlxgjqrIpN6baZHILM32uScHTtrRVhePMehKqX1V5xoXQnbtXrEARsQKpmwccqg+8zpCi
	HBDS+ieipIO9aZ3p8G+Hp+d58qulx+URn7OevNZ8lH9rLCoILX9K0g35zp+LOqz+iCdBX3kPB5L
	ReEflTOBtGRlZaEXVM8sTYf72pWywmvpkwbNXMnRMLPgknEqKC09JPKMoVnZI1/toyjAXtcvIXh
	VNivhh2vcbAkAQcoHkSMR/qt3XhNoMiv8hlr6VR0hrhl/ZvDL6zRwDqG78NOZpNpjwxP1mB4DjG
	yKdlT6bfDD4r3+q3OcRHDowKsHtcOhkjAVVP+djJJbF
X-Received: by 2002:a05:6000:389:b0:486:e707:42eb with SMTP id ffacd0b85a97d-48dbacd93dcmr18590413f8f.33.1791814377415;
        Mon, 12 Oct 2026 07:12:57 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.59.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ac02cfsm18703035f8f.39.2026.10.12.07.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:12:56 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	James Smart <jsmart833426@gmail.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/5] nvmet-fc: only send read data for successful commands
Date: Mon, 12 Oct 2026 16:12:28 +0200
Message-ID: <20261012141239.156408-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012141239.156408-1-parri.andrea@gmail.com>
References: <20261012141239.156408-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a read command completes with an error,
__nvmet_fc_fcp_nvme_cmd_done() still pushes the whole data buffer to
the host before the response. nvmet_fc_alloc_tgt_pgs() allocates that
buffer with sgl_alloc() and no __GFP_ZERO, and a command rejected by
nvmet_check_transfer_len() leaves it untouched, so the host receives
stale target memory.

The buffer is as large as the data length in the command IU, so the
amount of stale memory returned is up to the host.

The tcp and rdma targets send data only when cqe->status is zero (see
nvmet_tcp_need_data_out() and nvmet_rdma_need_data_out()), so no nvmet
command can rely on returning data with an error status. Do the same
for fc. The ERSP then reports a transferred length of fod->offset,
which is 0, matching what nvme_fc_fcpio_done() checks on the host.

Tested over nvme-fcloop: a failed read command no longer transfers
data and still completes with its error status, and successful reads
are unaffected.

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/nvme/target/fc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033a..44bbc7d26f07d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2484,11 +2484,11 @@ __nvmet_fc_fcp_nvme_cmd_done(struct nvmet_fc_tgtport *tgtport,
 	} else {
 
 		/*
-		 * try to push the data even if the SQE status is non-zero.
-		 * There may be a status where data still was intended to
-		 * be moved
+		 * A failed command may not have filled its read buffer, so
+		 * only push data for success, as the tcp and rdma targets do.
 		 */
-		if ((fod->io_dir == NVMET_FCP_READ) && (fod->data_sg_cnt)) {
+		if (fod->io_dir == NVMET_FCP_READ && fod->data_sg_cnt &&
+		    !cqe->status) {
 			/* push the data over before sending rsp */
 			nvmet_fc_transfer_fcp_data(tgtport, fod,
 						NVMET_FCOP_READDATA);
-- 
2.53.0

