Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135876;
	b=XiWweTkMCYlknt+5QDQo4HB+JjnPoM3nRIuPYBTB7e+1T6OHhke6oA/afdhduRDglxhB
	 Qyh/KjOErBquEvc959Y/accUu6cb0WEN2/iE6rF3aoR3w4w1l6JARs1wPF/tSGz8rNUJd
	 zfZwYycQUdOGI+Mbz3oWRoNfgfsrJ5O4pd7YLTM6heFHuiqYZiD9IEt+pSsUduoExq2/a
	 frbpdK9AiwPabovflN3IqJxKNJ70r9KaL7le3mLarWCUgFdJXxUPJImuaOBjrAJjy5XUb
	 a9awzf1V4dqi3IKYIAw9FcXeCqHmi4fLZ3iB2+qZioFpxowmbSdQpiEx50u6xTtvgmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135876;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=zsNgHJ8iAmtzJGTNqienx9MClbhu9el8HYv2/8DaD5k=;
	b=rakoCcnvRcxh1Z0Ofg8tJU1URic2wgx/P4yuk3itRdBbFBKu7aCGThocI7PXtdDoQajG
	 jq4l4pFy1chriSjAIR9trTGcP3vF6r31sVXxm9vOvjDDuQEsL3i1s6ApfDA/KKdmBMMZX
	 v0HmmYqEf8ElwrwVlcD3hx4TQln5wGFASmEQDizLgkByOHAyvpWLhwyxChvMWpjGCqU+4
	 XW2KH3hPnW+b6W28tT1k64uImzARZCZH0EcU/RY8vDYR3T7dq14/p1iMClwJwbqRC6ZZN
	 wgGeN7jq/jXm2+nXihUoijA4dH07jdgM2fq9B+CAgs1RcQfeArLS0gM44X3V9ywp+XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=c2vKylU0;
	arc=none smtp.remote-ip=209.85.214.225
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69720606A31F
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 21:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69720606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=c2vKylU0
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2e9eb579c0eso1539755ad.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135876; x=1793740676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zsNgHJ8iAmtzJGTNqienx9MClbhu9el8HYv2/8DaD5k=;
        b=i4o+sb/5UlELpwyt49j2IRKVqmbtsFyUy9JA6uJcnKZxZQIFZeKsEqhpwbXzGjmNCW
         57otlM29PgIHpk9XfsTlsir5xqX40NjugJk+3MbhAtfGhQEhRgEL3vdyndyZuq4GOfCd
         0jlxIOUIRB6tc6ZfVPQgyku7IWLMu6ni1xk6dst8IJCHhQaytoFgTMv1x4F8MANgk8RM
         QvGWRnE1XY5JCxh8L28fWVt//+753AtAgFYlAh+xgGFEJ9sSlkHr7v+VILogc24hv87w
         QuSanhiu8+gKp85LPqBQsT4wfjKMB0LcttzBo4Gcw3pzdwgiLEScwspta3cw8Xv/7JcD
         Mz2w==
X-Forwarded-Encrypted: i=1; AKwUvBw8XYwcWMPoQNyTc9XCXyuLb6329E/MaNKvqzJYUI5DiH7HfgyFMevyhOPV+SPDTVCFxkVDCpU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAQSdE7R0briGL+THJrhZb8JYaYIlu9vYG66bNAf6v+rvDZNoo
	G3+xTmA1az+Z7iUI6iRG5dpcmQBlCO1FTEFqEhIHgNITckVPVHU7H0ER9JOtkpQj2JGoZ+OEADj
	uLJ4dBZUOjmfbiKhfWh3b7Ndpa4Ah/CzsGQ3+FXIUd/wpeJDeQBImH81eCXz19mfHc7GKgAYT2Y
	sgVH5Ma9TghWXW57fJDNrzD4hRSkgelxJlnRmECH4fMlSvnm+E86UDcijgJjpr/L4+98yqIhp7E
	tzei8vC
X-Gm-Gg: AYBFou1Hzka0eaRTdItESaytrz1U738vo872Q5/pExaBuUPzE8In89h0qrJYF/QP+Mv
	V7bT2hsWpxQNPCFaLGjApVvMr5DKsLwsBJIahpJMSx1VDuEdQ/tcTJjCBwLEU84qqSgW7QCi4fh
	JoY1P4gm/B9ioqkawkLW6CSaXISZ6gXYg4qRcz0ELmaUviT9WOgMNAzy5RdibjUOZpfMwExiSEW
	TNdy/qKfkDMklnxS/QnOnhHex6RWPWUDu1GXYkB9msGtYEdJjGRLhPssK1blLy3BHYRKR+GZmdc
	PHSlI4fGWAwaruxmeCPH0NtEQnTkG+EoSUbEKNJYkHf9u810oAtuBdfTXob/TqP6q5si+/dacnr
	WHmqFv44WnlyNtY9DC8jX+jW2Pcw4zYFMDO4pBfwfnymDIDbDwLW7NF+atq29xg0oQV2g6Lcgj/
	+dAjM3Xvnj51TtIa2OdzCTSpqkwS9QGtIcnU8=
X-Received: by 2002:a17:903:fa4:b0:2e2:cebe:d811 with SMTP id d9443c01a7336-2eb0051cf4cmr4339985ad.46.1793135875639;
        Tue, 27 Oct 2026 14:17:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2eae6c03f4esm759645ad.35.2026.10.27.14.17.55
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 14:17:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so499092eec.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793135874; x=1793740674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zsNgHJ8iAmtzJGTNqienx9MClbhu9el8HYv2/8DaD5k=;
        b=c2vKylU09T5x2mmQq0OjTzbnZkwvfbOBzTB05YPUsAi2b5d38T+W3pFoDbGBzbGnTp
         XY3RNV7q7SAdf/VQ+bOugWcipf0b9N274NNccZwRhOJgXXuFqEWtGAvQHtqONGo+4Fpu
         A2yHea36FeQ85DkbO/dR0MI+TWowpoDMsh4kA=
X-Forwarded-Encrypted: i=1; AKwUvBzVJbN6FnXuf1fDFDUzhFD1IKdQnYxR8saJdIf5JTb0e7aGaDUDEyNZHKb71jW4e/OCWpscico=@vger.kernel.org
X-Received: by 2002:a05:693c:6010:b0:35d:8c3a:38a8 with SMTP id 5a478bee46e88-36a20404e36mr915134eec.39.1793135873695;
        Tue, 27 Oct 2026 14:17:53 -0700 (PDT)
X-Received: by 2002:a05:693c:6010:b0:35d:8c3a:38a8 with SMTP id 5a478bee46e88-36a20404e36mr915043eec.39.1793135872129;
        Tue, 27 Oct 2026 14:17:52 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8c576ebsm35760859eec.3.2026.10.27.14.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:17:51 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	yunfeng.li.nb@gmail.com,
	tomas@slax.org,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 6/6] drm/vmwgfx: reserve cursor MOBs before unpinning them
Date: Tue, 27 Oct 2026 17:17:29 -0400
Message-ID: <20261027211729.646988-7-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027211729.646988-1-zack.rusin@broadcom.com>
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

vmw_cursor_mob_destroy() unpins cursor MOBs when discarding an image from
the plane's cache or destroying the cursor plane. It calls ttm_bo_unpin()
without reserving the BO, although TTM requires its reservation to be held
when changing pin counts and LRU membership.

KMS clients issuing repeated nonblocking cursor updates can exhaust the
cache and reach this path. On a lockdep-enabled kernel this triggers
reservation assertions in ttm_bo_unpin() and ttm_resource_unevictable().

Reserve the MOB around ttm_bo_unpin(), then release the reservation before
dropping the BO reference.

Fixes: 485d98d472d5 ("drm/vmwgfx: Add support for CursorMob and CursorBypass 4")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index 9e8ea9e07f40..b678e5b68db7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -166,10 +166,17 @@ static u32 vmw_cursor_mob_size(enum vmw_cursor_update_type update_type,
 
 static void vmw_cursor_mob_destroy(struct vmw_bo **vbo)
 {
+	int ret;
+
 	if (!(*vbo))
 		return;
 
+	ret = ttm_bo_reserve(&(*vbo)->tbo, false, false, NULL);
+	if (WARN_ON_ONCE(ret))
+		return;
+
 	ttm_bo_unpin(&(*vbo)->tbo);
+	ttm_bo_unreserve(&(*vbo)->tbo);
 	vmw_bo_unreference(vbo);
 }
 
-- 
2.53.0

