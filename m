Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085A46DFFC
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005173; cv=none; b=bj9GHoIY3TxPBvIHs2tCq5DYPFcyTcSXeKvfFZPqjoxl5t4/9hWl24vxQ5UmN5r6Q2wxznSD07A/PkLX5D9JFqS+qJX4Xi+xdtUGmrcPDs+bgkQfPNLJSoLP59n7a6hPzpI2cYAI5oI8lRJsi9fEjPR6U5lCaBGqFt5GZZhlBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005173; c=relaxed/simple;
	bh=8pbY2yocUMe4CVY4XHb7arbhkzDzJmAQEtZu7ABBWI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pk5P4lfOn4BCuyQiP1gn9qU5WE3S8RZBtxQSL9rbOXTYFBMp9xyGnNf8U+gawImbmbf9KN2HtO1Zn+wmbQ3rv8K3vouX7XiujIbtEs/wvYivSys/cnxcE4TF8cbB1miTYuTkqI5cpB29oF4t2JYP91569fPiIL3V2ZktraH+sXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=WSiw9eg2; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="WSiw9eg2"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35b2c599f43so5790251eec.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792005166; x=1792609966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZIwvec8ywWVSJmGxLO9s3tCy/XMVy8O1ZUKsdE77wh8=;
        b=WSiw9eg2etBwWCWMN00GON7MAHDDfG8EBX9b/WrkoPvCpi3T5qvwfNivKnLvlgAKdd
         cPCJSwZgM3U7gOJXukcRi0EEc9kakRS7hkmxkDmsqXPSf+xrLMbrQjZRDw2DMtHz3Fhe
         eWRNFLyPR1D8ParnuFnW5iXQ1j8U9GMZEkxHyDAyc9hG4ekn+EEEankcHCYSmOE9ALhv
         +6THwxMrawDk/Lms3NOXixemm29BPFyPMwDac0TvM5GxkG4FqxkIhj+gAOjqSsh2PmDs
         5WYsjDT906AbmpijcKUMHQFOxMysUSJVapIGwmbb6r8FnxWzzOEt6fwN7RT2CvXh+a9Z
         epXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792005166; x=1792609966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZIwvec8ywWVSJmGxLO9s3tCy/XMVy8O1ZUKsdE77wh8=;
        b=PnGRxMMhRBmkfR0bRINKx7v386nEX7ZQ6/8DXZ+K1WfZaQ90OZxmyeyAev6VzkZ91T
         qwcBlBGgvz1Cb3svsaNGeUfJKvKiB7JLm7UNg9KzD77xGRaCk0Hq3g5Rm/UWyPGkuuso
         Z5h3e7tDCB2ampmhX47KmPXu55BDgc4foS2n9zo5VKEfoemO9AeYf/tHSVSONsAqRRm8
         6z3THxJ55NN8Ag5gEkcgJHX8GNOvR0O98r9oBG1Xc5ZHp2tFcHdYYYotTvuA/YqJzay4
         QaJwMFwfqw4dBy+49z6ZF5Iga3aoWKmyeZc8PUmKiX0gag0Kw1VFNsdU0LD9fMyRPjmf
         xusQ==
X-Gm-Message-State: AFq9FYLf1Lcb93um5jpRgTWwfCqJMSTkJ3jqpDsYjv35zbJULo3Et7FK
	3EmjsGJpVYinK673fPEPWnkEQ1T1PI+UGoFPTlXVdzpTbaKYXhkI33Jumx88ZerXyIkzwFE2btm
	uC2JXx4edvw==
X-Gm-Gg: AYBFou28peZrhKf3552tWXaJ9nGUqs1rq42VZlKNmDMPesMuVwUZ+5VXDnIttyAOw4v
	CcbDwT2GJ+VljKKwltL+cYn19WL9t35wzgH8Sfv9DnRsMGd7APsDYovnSmnNX0+qIepPM+tZKYK
	y9I7XgYl6FvgwQ/BmR/PTsRJm99O/yLFQennOb66LCUl+w3gO0dKUNKi5WzId9txWvrzqB8NpLX
	wqvYhKwhDsSwOK9N52FcJD3+DApok+aS7M7zAhnGReFXVHOm5wwT84KE+hFniw58gwgCD17IRxZ
	vITwuQMNKapD/+HuABeddC8xJjSp5hV2wrB11uVsUi75pFyrgHRBq/Q+6JFum3f3R9U7278rclB
	7hSyY6F+f+eoC4i5tp+WobComL+HUja3dzIJODXIOx/TCHrdAAvwjXahN0JCsmqhIce2/TdBvsd
	rifIM6tMcNKl9FmaaGu2LqLUvO/prv/gSnK8fXfOW6NV101W/fLAhFH7KaQdj9dvq4NzWx+tlzs
	sz4Snm4bJfoREfVTfK5loJE4wT186+Xs+MRDGUy/qG5W0N3gclIfio5UZBaYBnvNg59uOc=
X-Received: by 2002:a05:693c:8642:20b0:358:d3d6:207e with SMTP id 5a478bee46e88-358d3d625b3mr19902741eec.11.1792005166088;
        Wed, 14 Oct 2026 12:12:46 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm54329888eec.28.2026.10.14.12.12.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:12:44 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	hare@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH 6.6.y 2/2] nvme-tcp: sanitize request list handling
Date: Wed, 14 Oct 2026 15:12:36 -0400
Message-ID: <20261014191236.23696-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014191236.23696-1-artem@trailofbits.com>
References: <20261014191236.23696-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 0bf04c874fcb1ae46a863034296e4b33d8fbd66c ]

Validate the request in nvme_tcp_handle_r2t() to ensure it's not part of
any list, otherwise a malicious R2T PDU might inject a loop in request
list processing.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2025-38264 to 6.6.y.

The code changes are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series: x86_64 objects
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 drivers/nvme/host/tcp.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 88489a787e677b142c3ce89db0ea06603c021bbd..e270024fe549096b8d8588e73b67cc2aed28d910 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -385,7 +385,8 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 			return NULL;
 	}
 
-	list_del(&req->entry);
+	list_del_init(&req->entry);
+	init_llist_node(&req->lentry);
 	return req;
 }
 
@@ -493,6 +494,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	req->queue = queue;
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	nvme_req(rq)->cmd = &pdu->cmd;
+	init_llist_node(&req->lentry);
+	INIT_LIST_HEAD(&req->entry);
 
 	return 0;
 }
@@ -739,6 +742,14 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
+	if (llist_on_list(&req->lentry) ||
+	    !list_empty(&req->entry)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t while processing request\n",
+			rq->tag);
+		return -EPROTO;
+	}
+
 	req->pdu_len = 0;
 	req->h2cdata_left = r2t_length;
 	req->h2cdata_offset = r2t_offset;
@@ -2374,6 +2385,8 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.offset = 0;
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
+	init_llist_node(&ctrl->async_req.lentry);
+	INIT_LIST_HEAD(&ctrl->async_req.entry);
 
 	nvme_tcp_queue_request(&ctrl->async_req, true, true);
 }
