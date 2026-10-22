Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675792;
	b=xI66mHqtK0bFbzM32Jv22zZlOTXiga/pKMsQKl0nR+LEeue529kkUXsD9zbE8FQjNOkK
	 2sJ4ynTl0mYJAE/K/nrFlLGluvarJyOL9P9K0blWYiEWO+pLEqjHdMHWhwCb/UycEHDjh
	 Jg0oXlSekcwwywX1SS2t2IydHFEZrj/fHMpAOaMuu0Y8yX/14Y6dKpL2Y86A4lWi4Aadd
	 VdG4iQ/OQGCSORrOs+d3x0IhhKnZIuYhw72M8g8WA8VzkQq/SeEj/MEM46Xa2AubMHeon
	 GISvi5Vg0VrPOZklw7IsQ9aecTSQ/nCdSOkrjajXBUfJinM58KsTVIflf/3oJtjB/nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Uw/cd/kzkyBkXI5zP9mLCKnmK/pe1xDS1i27lZNCuU8=;
	b=1WaPxGVbo2aqnfsqfDHOBEvTTOKrSIS7zGoddNe2P08ie6V+5AWI17wMApRpCpjwJWzL
	 /v0xB69krXe2eDp2WxyXDkq81Zgw+LeZ9/Jzi3OHPh3yHuxW5tUKIsmC3Nrb8HaW0sko5
	 oW2WfF+46IwDHCCrO/LrkjS8yTZ74FqaaQFD1rob1pmcNDZXcv9XRNJbTFiTDD3EpKZyX
	 nXQPrZCD4wfXlV9tpxvfYAyp/SEVVTwTJK575nhv9vms5MbuIvZJevJv9J/7TXgqi10nZ
	 NMPVit4V21Rl1aHbpAmIggdtZ/l9mqHrKvIAjGK/M+EAhenmfP26kJelAF/chHDYySw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ipuvz17g;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6989D60A2602
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6989D60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ipuvz17g
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a20803a757so3482325e9.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792675790; x=1793280590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uw/cd/kzkyBkXI5zP9mLCKnmK/pe1xDS1i27lZNCuU8=;
        b=ipuvz17gBC95kOVuKeV8CG7qMCObc3Hv1GIQOefBpcMEVvP4wpYsinPtkcTf4+f+7S
         BEE25OFnwn9cTYD5nNdaqMtgURwb3KzTwOoOfkaVgoQmIRT4ERTSynpfQ7mhk/abx0m+
         uxWHmYgUhiFFmJ0RRZyDqj6G2i2GN6pFcxIT+gyZARSS69l9bEpF5lsKra3+949ENMwE
         uovnljcGIsQzsCfzBqW39f0L2w/XuLGdfdedtfm5bYHSnBF2VsvTfXc9VcUST94fHUhU
         CzRrP6hUqxm5Ksc0gXan5enk+8cdHBFLmHufmuJxqOeBf+i/ui7b+BR5xklFQ3GEVOq5
         C8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792675790; x=1793280590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uw/cd/kzkyBkXI5zP9mLCKnmK/pe1xDS1i27lZNCuU8=;
        b=FKtE/OyzeYk14DDrCtDhVlwsxwOek45v1OyieT+Npxy8ZccRxGsvlkjzEAG7n/vYwT
         S05KwOVTeL3OIZF/ICcsamOIzMEzxgg4deW9cle6Q3ly6nmPQTg+wl5/SLpshq7ynA6Z
         dEWReD8AZWqC7QRDXR5wxhpCfbgbQgclnI0/5SBuLUyXGoZFN8Ff/V/3CaYKh6i7Aude
         qj5AEYdAB5pxCBW9YGPn3Hw8RSSUsQ45PdeY3t4FiiskHhokPoWuYfyf8bZU4QF/8CPS
         6vwbshBRLwz5NmgY50r8qMMwoGWApWUoNIFbWGGpcZyMYARXtR7v2gPdi0Of1qvuGAVv
         5tCw==
X-Forwarded-Encrypted: i=1; AKwUvBxoYWnyFIDxTt2mkwm8rxZQdZ72UouGewPz1eQyuKj8GnEqD76K2KavGz1yF7dHfH3nEbb4LjQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrbfMEN3/JsAfq+XQe90xVZzQOCobuefr58ZMzwn/y9g8Je9ML
	VCh5gU/CLZ2v+8QElQ7TeIL8E20m5IPA8y+jaCEfveBvRs6ds9XvZO29
X-Gm-Gg: AYBFou3MpDaV+qf+ZGIP3K83yMMDERZv//iF/dnT+0xvZZbMl2MHfOge64/vyDOqkn5
	iciZzGQJZ5qjPGBpRfhNO5yzougt9Y83jeFwc/fjpSCLwJcaRoPkdUauFvhpR9pnrG4bLLLoFbm
	BJyGVOQbegPWnSZYSNouiJ/BrGwp2GcaU+j7pVB+N0zxMQJ7Xdmll1sx/YGEdnxWjgHsXy50LnF
	QBuC6IvsJ1Anvi+MkmNqBYpQJ5BQXw+outKsIlgaz30zKiJE8dJrEqv/kYvTEwvIKf4DXTDLmbp
	TlxIWW+UnAPp3nJy704jPszyrWuYORZ49WsG61MZRk3q4VDvdplSSZ43iUdKp/WDSKVwc+W5LDW
	d52jEDahr+HaF7pmpQFaHiVvSbEwKi/+BXgpOYgsm06SC4s3jtC+7fI9gt0hfzN22iUc4bYV0Jj
	Pfow0xS4VZfJvYO6HqLiNOs93+HJT6Y6Wcamm/xQLKep7n8GaMMeHQwbJpS5Z7XNdlBTrIbQBoc
	8/3uMxMGnJMer6R3HNrZaAZESz9bDLmE75SFHn69TuROHU2W4Uwy2PvdjzwvjluiDLK6tmJ9wWj
	f2ELTiJaFHeruvlPsAyzy/K/mg==
X-Received: by 2002:a05:600c:46d3:b0:4a1:80d8:aed0 with SMTP id 5b1f17b1804b1-4a1fdd15be9mr114440055e9.15.1792675789631;
        Thu, 22 Oct 2026 06:29:49 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd629bbsm108832715e9.5.2026.10.22.06.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:29:48 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Justin Tee <justintee8345@gmail.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	James Smart <jsmart833426@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] nvmet-fc: only send read data for successful commands
Date: Thu, 22 Oct 2026 15:29:30 +0200
Message-ID: <20261022132934.3592924-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022132934.3592924-1-parri.andrea@gmail.com>
References: <20261022132934.3592924-1-parri.andrea@gmail.com>
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
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/nvme/target/fc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index eecdffefa24fa..b95893adae36c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2487,11 +2487,11 @@ __nvmet_fc_fcp_nvme_cmd_done(struct nvmet_fc_tgtport *tgtport,
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

