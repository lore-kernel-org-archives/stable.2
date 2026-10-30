Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352108;
	b=u41BirjzJWr/X47T+MGbrzm+5sdTOR2KPr9yjdwsKR82mndv5+jGr279z0RiykvTVAMD
	 SeKioqZn7vJbm3UAnKKaDh0L/8hMHK55DJ+gZnnyFHM75va9Ia7xFM2XclPsA6N8tiWpL
	 YfDcUEvAeNOmppdzLVjRtOAktgViGqjL7A6ydxeeWX21L21mB3EB2zj5wWoAQY5/b1TUi
	 2oLJi7m6i6VClQ2JbbF+zgxqF8SK4wfztQPNmROw9Zi4KcCZ7PyJ7eNbOt4HM8O+FAoFU
	 NFiFSSX8e8nJKH0coto9zi50oEWH9TO4cteRRl1EF99HvAGPLsvsNIEhqME3b9L4i7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352108;
	h=DMARC-Filter:DKIM-Signature:X-Mailer:Content-Type:References:
	 X-Original-From:Date:Message-Id:Mime-Version:Received:In-Reply-To:
	 Content-Transfer-Encoding:From:Subject:X-Lms-Return-Path:To:Cc;
	bh=lDH6CZonHxdY1g1ae5yoOdLp2lZlZBIVpWVUaxg2sgg=;
	b=L0B0P/lYv/ODZtz2yeHnUDOmvkxqIfKOu5D3xOXU7pHrtFt9k/hRF0OM8RKZ3Rr9KTLh
	 uAwI/XtNP9vKBs2a62Ngwafdi3oZYlKlccBtorh121uZA2cvpEHPsWxSdaOBiTzLM3KHx
	 GoDDr/WV1riJfgXrnK4xqK4GBMHEAcP6hr0E7CrTHI4CCwbrm5mtitvm7hDZAQkem7Ix1
	 HCTExES3s1jpfRR5I9UEd/QJBKook7CZJlESLBbGpYEBqm7oQLcGLw3EFRrjKCBEAB6BS
	 amQ9lQqGkwQplKNsnbEEAmGNDmrW2itfxLig2IDBFSlfYTqRHyhtU87qHiB2qD9BivA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=fnnas.com;
	spf=pass smtp.mailfrom=fnnas.com;
	dkim=pass header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=3I4EWibn;
	arc=none smtp.remote-ip=209.127.231.56
Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD1A606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DD1A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=3I4EWibn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1793352101;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=lDH6CZonHxdY1g1ae5yoOdLp2lZlZBIVpWVUaxg2sgg=;
 b=3I4EWibnsDdyssBoESwria4Bhkgal1tNmdbWs65gdtJDBrHP2RUbxtvhFple4e6dW8BsTM
 YUKLgrWLg2K6xV0L7F9hhKYdQndA2Qe9HUFnaCJn6zkKIj/v42flWFchpNlrRHfivVYeJF
 MwKq2oVYnIjmx3NVe7547wIlTQ3yY2M71egHh6dE4uh1jfX8T3rLg+RY0TkUNxd2SDwDso
 DBAYKgSdFq5TB0G/kLQnpezQrVOwyMfp5aiBmJSamaEYwXspc+AXhfbI4AcutBsXSZEZ16
 89lq41dhnn2oqFeYOqQB5kIa1FT2meOhAoKclra4dk75VUTbNM0NzgGMB5rX9A==
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset=UTF-8
References: <20261030092129.1671254-1-chencheng@fnnas.com>
X-Original-From: chencheng@fnnas.com
Date: Fri, 30 Oct 2026 17:21:28 +0800
Message-Id: <20261030092129.1671254-2-chencheng@fnnas.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Received: from fedora ([183.34.162.132]) by smtp.feishu.cn with ESMTPS; Fri, 30 Oct 2026 17:21:38 +0800
In-Reply-To: <20261030092129.1671254-1-chencheng@fnnas.com>
Content-Transfer-Encoding: 7bit
From: "Chen Cheng" <chencheng@fnnas.com>
Subject: [PATCH 1/2] dm snapshot: split discards on chunk boundaries
X-Lms-Return-Path: <lba+26ae461a3+5fc9b5+vger.kernel.org+chencheng@fnnas.com>
To: <dm-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>, 
	<agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>, 
	<bmarzins@redhat.com>
Cc: <stable@vger.kernel.org>, <yukuai@fygo.io>, <chencheng@fnnas.com>

From: Chen Cheng <chencheng@fnnas.com>

dm-snapshot did not set ti->max_discard_granularity when it allows
discards, so a discard could reach the target unaligned, or spanning
several chunks.  Set the flag, so dm splits discards on chunk
boundaries.

Fixes: 2e6023850e17 ("dm snapshot: add optional discard support features")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Cheng <chencheng@fnnas.com>
---
 drivers/md/dm-snap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 31676ee05514..e49427bdbeef 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1356,12 +1356,14 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	spin_lock_init(&s->tracked_chunk_lock);
 
 	ti->private = s;
 	ti->num_flush_bios = num_flush_bios;
-	if (s->discard_zeroes_cow)
+	if (s->discard_zeroes_cow) {
 		ti->num_discard_bios = (s->discard_passdown_origin ? 2 : 1);
+		ti->max_discard_granularity = true;
+	}
 	ti->per_io_data_size = sizeof(struct dm_snap_tracked_chunk);
 
 	/* Add snapshot to the list of snapshots for this origin */
 	/* Exceptions aren't triggered till snapshot_resume() is called */
 	r = register_snapshot(s);
-- 
2.56.0
