Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731C52FE41
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951548; cv=none; b=XAAcPVxnfJ8gWY9g5wyZNJMPUlZAYBF2f0eqh4RreXMTATM9qszLY467yzV3uX6x2QlZEYtFdmXOTQXoBcLrjxDg4lZbaaRr/g6uVRxQrxaJR3KkcKJovbQ5KFi2iUQLOLdBhWUGQManPBywrrc8uO+E4n9qfVBh615Qk8Ymg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951548; c=relaxed/simple;
	bh=4Vy7iCU1CgqFSSdv1w1DyOsEsjJTdKZdwzEZqZ/Sd9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CV958GRILxiXscQMCbKVDmJQkmrQ2pYeS1tnB6ZQwk6oFut1GgJGHkAc2FdHXvHnD85gnmiblVwS124Jzvm1AIIvygVZGNrkDgOBxbxTE8D4nRL4EIo1bUHxSQI06zOD9dvMYmSHnwS2QHdfLDt2vcKR28+dr/1aK3doUKkJUaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q07HEbkR; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q07HEbkR"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso455325ad.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 03:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788951543; x=1789556343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w5NEHCHglzkgR6my1ufRSHRRxBZJOd3es2NtylTtqCw=;
        b=Q07HEbkRr2O1iblXqHRLuGt11dsz83/dDkZJqgi0UXap4pgsclwIR5ABzjLq+9Uuok
         4jTBNKKs7EOXjAeGbEf+Z8ZHx54qpzM/gq7gzWhSV2JyFEA7+rWxH9KJCW2pSDIr9Jgg
         XYz/xaR9PLJwjbOEceDss3JwzogI9Diggirs85bjKBT1sb/2LbWePJyycZXkPk/B21tE
         WFx/7Na0mAZ7Cfp5ptefG97iSsG9PkLfQqTw9q0qxk4afKK6Z9odIRo1nWMA/XfXxWZR
         7unSSKwTKDK4KnfsaHJmmemJl+LNaC3D6MihH2fgK86dyyykFgPHRuz7FDX8sqD368sL
         bjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788951543; x=1789556343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w5NEHCHglzkgR6my1ufRSHRRxBZJOd3es2NtylTtqCw=;
        b=NhLiXkaBluFIDHwDH0vTEqbGIzaaRAXU4cUD9I58UJt09G2LjgwtanQ6lKd4elu63n
         ha6Onwqden+smyKpEX6t6eZmvHW8B5xd4t20NNKUeDdo9MxfSLJfy8hSoMXgRmEd6v63
         ApuW7lJpWiph0X30XGkLZtmlNyGR2wNnt7dR3tuY1UMg3M6Bg2uozSFfbU4A8I37xCF5
         NsKxXEiyDtmolVnyjQ5jAGyUtETN6Lt8NrlFar+ti8AhOezCblqFmfKFm9NelqGhkQmS
         mMmebHnUj/ZMbmlU9wIQh7GZ5q00OB48H1FyEfzS0sr0PbWXRfSMF7kveHSeKW19UtGB
         f9Fw==
X-Forwarded-Encrypted: i=1; AKwUvBx9CyWGCAbBnsu1FwqoesaixdYPQ005CpcXA5QfinOAjx4Y/8X6EqtIjNHJZ8lTSpjSkmk1hX4=@vger.kernel.org
X-Gm-Message-State: AFuF++kkao8vDoLWpA6B/uK+8jgNC5gWjmVJNiPL0gNeevrqSllY7W+e
	3lm7n0JwbpNn+/UQlPWJI/3W6aHf2R+YnIGj4uDbDuWtVdoYZShgcw+9
X-Gm-Gg: AYBFou0olG5qCua0Af670QsAHEYtUJIu2wDXfGjq8h+nSriZrcOlCOn3S92GBHQp2rm
	0VyuASe86qIjyIYKVUHQgKbTiGqaN+rr0gkfNc8wbbg2x6+EKksxoc7IoXQZEK3F+j3092q+CHz
	/AjHMcEeaGnPJSdPGz92cxPuO5wCJpYV/xz+SV8JpXwhHAXXv8bDwn7e+QtmpQbGth715WlyopG
	xVe5eshyJUkHF6MnjVPEmaYAfPb/Ayv/6R8HNEZf8095lf3QTfMEI4xT9sab29wG7ZzJ3t+qU+U
	2TtS2r3Fd6TkYrUKvY7BdnPhmJG3fmc4gx/mn93WClcPWjXfVTDsNTBSjZYJzIqj7joJzWdmuo5
	Ef+4SU/sjcx1QHEGqhDqkKB3+6rSHCjsyu3TZcmFEjtiAvJV8syXINb8lqwek8umizTr00FGzzN
	5+/g4NJOaB3Hh6CHqT4ULxIA4jsM00tonKR7iwyJiHcAQ/JmVQqAxnfH85qCQTLxsq6yqVB2dxo
	w==
X-Received: by 2002:a17:903:174e:b0:2d8:d4d1:313d with SMTP id d9443c01a7336-2dd07cae8afmr7110755ad.20.1788951543301;
        Wed, 09 Sep 2026 03:59:03 -0700 (PDT)
Received: from adriano.lan ([2803:9810:3d22:1608:e46d:9e65:1b2a:35eb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm68395973eec.16.2026.09.09.03.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:59:02 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] mmc: vub300: fix use-after-free in vub300 teardown
Date: Wed,  9 Sep 2026 07:58:55 -0300
Message-ID: <20260909105856.129733-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The request-completion paths call the final kref_put() before
mmc_request_done(). Dropping the last reference can free the host via
vub300_delete() -> mmc_free_host(), and mmc_request_done() then reads
the freed host.

Call mmc_request_done() before the final kref_put() so the host is
still valid.

Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Assisted-by: opencode: deepseek v4 flash
Cc: stable@vger.kernel.org
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes since v1:
  - Added Assisted-by tag
Changes since v2:
  - Split patch into two logical patches
  - Corrected the Fixes: tag

 drivers/mmc/host/vub300.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 2dae474dcd06..c87c54aa0e99 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -1794,8 +1794,8 @@ static void vub300_cmndwork_thread(struct work_struct *work)
 			construct_request_response(vub300, cmd);
 			vub300->resp_len = 0;
 			mutex_unlock(&vub300->cmd_mutex);
-			kref_put(&vub300->kref, vub300_delete);
 			mmc_request_done(vub300->mmc, req);
+			kref_put(&vub300->kref, vub300_delete);
 			return;
 		}
 	}
@@ -1946,8 +1946,8 @@ static void vub300_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 		    satisfy_request_from_offloaded_data(vub300, cmd)) {
 			cmd->error = 0;
 			mutex_unlock(&vub300->cmd_mutex);
-			kref_put(&vub300->kref, vub300_delete);
 			mmc_request_done(mmc, req);
+			kref_put(&vub300->kref, vub300_delete);
 			return;
 		} else {
 			vub300->cmd = cmd;
-- 
2.51.0

