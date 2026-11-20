Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196654;
	b=VwF/EEC611NwW+/Znc+04U2p8pT98j/GbBZ5zPv87Anyg1NApqSDkaM1gmsd7913ardz
	 ulrcJIL9rLy/2Jdnf9lYt9TekmreFzj5oGxP6JAqtG/pFtQbxC86xg18QBOUvGxQFjzCO
	 tCV8b1TcOu/IFAlwOoBwFYyy8XcZCkr7o4nxW8rtc/BcacXkM5h2QGPlSuC+n95MPrYqs
	 id42iPlbBH9D6xQzA0d29W3wWpeNiP3VWRWLLAyIBto3zMTGXmloEuHGrIeJ9klDex5ot
	 Lh2yoW8U+FuWpglaeFa1YMZ1nFkaUhO+z2DrGf0uc6y+AsZNO5iLkvZGu8ddfpMiO3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NOescnIEQw0JH0XXrCH8rbyYGWVbTRD7Kto+EbMNh0Y=;
	b=MmcF/fAlis7u1AzBCrffXPYU0BLKnchkM/DcOUuJSl6xxfXmyXM6wOMv6KwtURFwWUwq
	 kckaLXsiP3Ng2LpxGbOXA33/cy6b5UtwtEeDgeE0o5rVTepopIICGZoAKxXTw6ygRpn7N
	 93QcwVdAde1gwkWdzvUGBIzVDz0yEZUznhUhHHsJZCq5kjXDzkymTIjoqUqNUW0e6nT31
	 2stJj1V20j4uV987yG6BGwBoT+4ypkbSzghrx2ejV96bNa3qFKD3lSGE4bTgLhbIx5Mrl
	 Y+UTHQNMUBWZ1kqzAUJrf+HcpvTTXCbp0yUq8wV1DLY91MVo7zESTK6mSfAuWLfRBZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=HOCfRnHx;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F136606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F136606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=HOCfRnHx
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so10309855e9.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795196651; x=1795801451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NOescnIEQw0JH0XXrCH8rbyYGWVbTRD7Kto+EbMNh0Y=;
        b=HOCfRnHx1QqdFApmPSh/EyMoN+bokzFVzjd2pHAM2WfRbl5+Sm8ryNhO6VM8Soinc7
         CYkAw7pPAATHTeRkrVVNgdqvWdjHnofe6Jk56aFfMbMcNFdan4ZGGn89uLD9MqAoGBT7
         FyoV/OfQT2k/u58e3qtSxEWUFKpk+b2NofLNPK3TkqSlwXMFbEike0s4tu/mDvFfDuT2
         1TajoLuD8PMpl3Pyzyc9YAR86K9DmNg3x2J5HadV9l+K4t9/R2sgHMT8YeQ/P25RJktK
         FETXa8HBBE7F4TYl+NpP3S2Rvjd+ldYpjFXaNdQcn30nKNyyjPamrxz/dFyJfhHcMX+C
         Umqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795196651; x=1795801451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NOescnIEQw0JH0XXrCH8rbyYGWVbTRD7Kto+EbMNh0Y=;
        b=0IJgsEvpgOMs2ARHpEf2CiPNFjlJo6ZW0BpH+C3aZ7pJ01CDP3b2G4WESe53eBBhPj
         fUnBS7uhS+C9IRrXg5CfqBtggOJBciSb2ZViewfl4o4BoAyApA1ILnnXS3K/q0HzXqTw
         gK7vheB4SqMKjZg08RLCfSkAeqz8PoBW/7w9L0b92+NO9wQbMvFfY54f35ZrcyM5JIos
         2/XtkzGqSsYBB9F2aWXR9dFk4T/ltA81VEmli8XJZItNl3s2nwXsjFi0zfzNEDMrSVCq
         nNhBGd/dCIt15eIYECXSVaBxb99gfL+IcPAC8I5aN8z78yWBT8acVfcIbg0vcxGMiLC9
         RB0A==
X-Forwarded-Encrypted: i=1; AL+hErF0M/UjqkIuaZoIIku8aHaUwp3giCP4GKgUG+ZNk1kLfZuIRDqB2+uSBg4O8DciFGPthgfagxo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/l886Cn9UqLYTmP/SGhEv5O2q4P3EXmcv7M8rQJl+jtWp7BUJO
	aWWy0MPukDtnRkFul7S0uxatoZGQxhq+aAHRctGSANJwnJH9zzn0iS7jEGvJ5KbcSoc=
X-Gm-Gg: AYBFou31YSOoZ6QwOmrESWRmtqWUR/wLpgwgFRURuHUStxQCeeZteqFwoXZJna7+AnT
	ANgC3wPVAPyEl7doM71DvcDk7PeFY9VLc2yCp/K/Aj/sf/m499fVtL1bUUwTCA4Hmm6XuHwHHJc
	fkHKkWplHmDzzIiCv71RUuvwmhhVjOG9OQyUf9MJxtshCqx4FmlLBsUOyVK3V/+qIDtfBmN+hF5
	Q2xeDVqX/bSJmF3pOh1ubKMY3DVrqB/jnAlCWzJGcPPlKQJiqV6c8G0NVSJcUm6lYmGIni1c06u
	qvmqKTqBYIV0dmyyGO9eaHDekePp+DUlSdGWdWyBWh317nBA+usKblAHagsCSDynhJ+J9sLWmh/
	89b1uuDS12vEOQHut2hSzPhylWxBLhQfNwmPa17I1vggh9jWz9Uqb8SsuVFN+LV51RfIDg1xTTI
	uJT7qsnQ6AfntWvO47g3PmWxrX+Z04f3zfIFIPtmP1URuaNu/tg13KSfVgRP4ixjXSh0XNKnmvu
	VoorZuW+S+J2Lo06Pap8oiURiDbw8HQ7MKGQcHhWBGxGLfTQF+9SUdN47pJaGc+XrPK5XpH/j4Q
	43TVjfKJloWCDncGnn0YAhLO6g==
X-Received: by 2002:a05:600c:3ba5:b0:4b0:a307:46f8 with SMTP id 5b1f17b1804b1-4bb8880f29bmr98567105e9.10.1795196650660;
        Fri, 20 Nov 2026 09:44:10 -0800 (PST)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm90605215e9.9.2026.11.20.09.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:44:09 -0800 (PST)
From: Andrey Misiurov <amisiurov@cloudlinux.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	Quanye Yang <quanyeyang@proton.me>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	amisiurov@cloudlinux.com
Subject: [PATCH v2] RDMA/ucma: reject a second join of the same multicast address
Date: Fri, 20 Nov 2026 18:44:05 +0100
Message-ID: <20261120174405.2761262-1-amisiurov@cloudlinux.com>
X-Mailer: git-send-email 2.43.7
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

ucma_process_join() permits multiple joins of the same address on one
cm_id. Each join has its own ucma_multicast, but rdma_leave_multicast()
searches by address and removes the first match. A leave can therefore
destroy another join's cma_multicast and free the requested ucma_multicast
while its cma_multicast still refers to it. A later event then accesses
freed memory.

Reject duplicate addresses with -EADDRINUSE. Hold ctx->mutex across the
duplicate check, mc_list insertion and rdma_join_multicast(). Use
xa_alloc() to reserve the multicast ID; dropping the XArray lock during
allocation cannot let another join bypass the check while the mutex is
held.

On leave, erase the handle under the XArray lock to claim the multicast
object, but keep it on mc_list until ctx->mutex is acquired. Hold the
mutex continuously from list removal through rdma_leave_multicast(),
event cleanup and freeing the object. Otherwise a rejoin after unlinking
could create a new membership before the old address-only leave, which
would destroy the new membership and leave the old one referencing freed
memory.

Fixes: c8f6a362bf3e ("RDMA/cma: Add multicast communication support")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <amisiurov@cloudlinux.com>
---
Changes in v2:
- Serialize duplicate detection, insertion and join with ctx->mutex.
- Keep leave's unlink, RDMA teardown, event cleanup and free under the
  same mutex; drop the XArray lock before acquiring the mutex.
- Keep join error unwinding serialized and use the normal XArray API.
- Correct the Fixes tag to c8f6a362bf3e, where the duplicate join and the
  address-only leave were introduced.

 drivers/infiniband/core/ucma.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index a15182f..9d94d19 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1509,7 +1509,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 {
 	struct rdma_ucm_create_id_resp resp;
 	struct ucma_context *ctx;
-	struct ucma_multicast *mc;
+	struct ucma_multicast *mc, *tmp;
 	struct sockaddr *addr;
 	int ret;
 	u8 join_state;
@@ -1543,23 +1543,25 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	mc->uid = cmd->uid;
 	memcpy(&mc->addr, addr, cmd->addr_size);
 
-	xa_lock(&multicast_table);
-	if (__xa_alloc(&multicast_table, &mc->id, NULL, xa_limit_32b,
+	mutex_lock(&ctx->mutex);
+	list_for_each_entry(tmp, &ctx->mc_list, list)
+		if (!memcmp(&tmp->addr, addr, cmd->addr_size)) {
+			ret = -EADDRINUSE;
+			goto err_free_mc;
+		}
+
+	if (xa_alloc(&multicast_table, &mc->id, NULL, xa_limit_32b,
 		     GFP_KERNEL)) {
 		ret = -ENOMEM;
 		goto err_free_mc;
 	}
 
 	list_add_tail(&mc->list, &ctx->mc_list);
-	xa_unlock(&multicast_table);
 
-	mutex_lock(&ctx->mutex);
 	ret = rdma_join_multicast(ctx->cm_id, (struct sockaddr *)&mc->addr,
 				  join_state, mc);
-	if (ret) {
-		mutex_unlock(&ctx->mutex);
+	if (ret)
 		goto err_xa_erase;
-	}
 
 	resp.id = mc->id;
 	if (copy_to_user(u64_to_user_ptr(cmd->response),
@@ -1567,24 +1570,22 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 		ret = -EFAULT;
 		goto err_leave_multicast;
 	}
-	mutex_unlock(&ctx->mutex);
 
 	xa_store(&multicast_table, mc->id, mc, 0);
+	mutex_unlock(&ctx->mutex);
 
 	ucma_put_ctx(ctx);
 	return 0;
 
 err_leave_multicast:
 	rdma_leave_multicast(ctx->cm_id, (struct sockaddr *) &mc->addr);
-	mutex_unlock(&ctx->mutex);
 	ucma_cleanup_mc_events(mc);
 err_xa_erase:
-	xa_lock(&multicast_table);
 	list_del(&mc->list);
-	__xa_erase(&multicast_table, mc->id);
+	xa_erase(&multicast_table, mc->id);
 err_free_mc:
-	xa_unlock(&multicast_table);
 	kfree(mc);
+	mutex_unlock(&ctx->mutex);
 err_put_ctx:
 	ucma_put_ctx(ctx);
 	return ret;
@@ -1634,6 +1635,7 @@ static ssize_t ucma_leave_multicast(struct ucma_file *file,
 {
 	struct rdma_ucm_destroy_id cmd;
 	struct rdma_ucm_destroy_id_resp resp;
+	struct ucma_context *ctx;
 	struct ucma_multicast *mc;
 	int ret = 0;
 
@@ -1658,19 +1660,20 @@ static ssize_t ucma_leave_multicast(struct ucma_file *file,
 		goto out;
 	}
 
-	list_del(&mc->list);
+	ctx = mc->ctx;
 	__xa_erase(&multicast_table, mc->id);
 	xa_unlock(&multicast_table);
 
-	mutex_lock(&mc->ctx->mutex);
-	rdma_leave_multicast(mc->ctx->cm_id, (struct sockaddr *) &mc->addr);
-	mutex_unlock(&mc->ctx->mutex);
+	mutex_lock(&ctx->mutex);
+	list_del(&mc->list);
+	rdma_leave_multicast(ctx->cm_id, (struct sockaddr *)&mc->addr);
 
 	ucma_cleanup_mc_events(mc);
 
-	ucma_put_ctx(mc->ctx);
 	resp.events_reported = mc->events_reported;
 	kfree(mc);
+	mutex_unlock(&ctx->mutex);
+	ucma_put_ctx(ctx);
 
 	if (copy_to_user(u64_to_user_ptr(cmd.response),
 			 &resp, sizeof(resp)))
