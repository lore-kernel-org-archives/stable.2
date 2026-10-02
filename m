Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D54734F7;
	Fri,  2 Oct 2026 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936102; cv=none; b=JaQeFrJR7RzYuABmmurU9oYxPgAMIKsVBwwE8yzVT8WZjSmRcTghibxKV4DIKqeDfs1tmUs7eVbX8mn3TUM6ZISEuJ5lM+DjAnoQImPk+0z/61fe6cAoVWWabK7KczHYwIQtt0LPlpEntcG09zB3cieW4rrB9gX3V1Ic/evdqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936102; c=relaxed/simple;
	bh=H9a7IbbwOmtnxfhygIMQgvko3AdwZCqhKxjlC17d3zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udSzCRUeNeGclwAlB0NFOdZ6fMtBB6vdH2RM63sDycThM++Pk1Pzp0l6cqdtGXQvJRPNUvInukqjY6D9NOXQYUG5ATzdqLfkGRpstWB3Q7YrvhhH5syE7AUyu3byr8KLgiEJAjq8c1R/hHRB57MgGmmWHalIdBQaaHsMUfAGn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrRzHQYq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrRzHQYq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5AC1F00893;
	Fri,  2 Oct 2026 10:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936101;
	bh=hod6cMQdWlOqLvXs/VtbJryZcAuP/onmbfxyYY4UcUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WrRzHQYq23jYEx0RNyEjXyZE+5gPIESVLLC0OdCqJraX3fhyRvhoHXIB/+c5pyRVK
	 Z7YFjlfl0Yj5J/wMQSRa006lfd0Csim3OXUEAH0jfQRdE4vTOvS3v/o5llnPXXtbu8
	 dsx3bb+ohuI3FLUfrZb9LIEd5XOvvSTlgbTVMrYp8gs/7O2e4WoMyq3L0d8oxn+ws9
	 +DJfvHdIV9zcFOqRZ7Y8bM4mKURDbEnqT9NOBrF6znavc0VxK+jnCH67voffMBOsWN
	 HOVOGcCDqZN6fYjruWsPdhIxdnocA2Sf6X45Gp94NZZHm9JjOG1OBjCriTxIVtALMa
	 KcIw92V27p8AA==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/1] slimbus: messaging: fix leaked PM vote on tid allocation failure
Date: Fri,  2 Oct 2026 11:14:48 +0100
Message-ID: <20261002101448.1084691-2-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002101448.1084691-1-srini@kernel.org>
References: <20261002101448.1084691-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

In slim_do_transfer(), when a transaction needs a tid and
slim_alloc_txn_tid() fails, the function returns directly instead of
jumping to slim_xfer_err. The runtime PM vote taken earlier with
pm_runtime_get_sync() is then never released, leaving the controller
permanently powered up.

As txn->tid is still 0 at that point, jumping to slim_xfer_err drops
the vote exactly like it is done for other failed transactions.

Fixes: d3062a2109309 ("slimbus: messaging: add slim_alloc/free_txn_tid()")
Cc: stable@vger.kernel.org
Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index e2dbe4a66b70..ee127ef42046 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -139,7 +139,7 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	if (need_tid) {
 		ret = slim_alloc_txn_tid(ctrl, txn);
 		if (ret)
-			return ret;
+			goto slim_xfer_err;
 
 		if (!txn->msg->comp)
 			txn->comp = &done;
-- 
2.53.0

