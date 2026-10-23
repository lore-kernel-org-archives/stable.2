Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785207;
	b=pUWiiHPOC03RiWxgNadsmKgk98AXbqgFR0FQhRJdhYsvbQ4mN/TbR466+TuQ9+a6QYUk
	 IeYevUPxFsLFSoEQn5Y0O/uIKUErxfJ4jbS+aTjRVnBJumid3K88+AF5ViXAy3PG1Pw0j
	 DM+myTMPt2YC36O4HKRwfit/aBpHmm3XVJkUWIsucSl/EnSQrNzunyJ1dY+m+tlAbuKXs
	 6PcSa+rrEE8BvndewGRn9nW44WPETbCUcJltWmsuEMNsReblHRXkOfbp6FPAEH2jG2CRc
	 BudRoyzBZRcWuzPgqqhXyRjbh8zVb8bkaO6x1fHR8j44cylM67A4QokijZYKsxSJT5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WhO3eiwpVjlpu/pA/NW1sjxZDrXxSK1K3FnCPXrmtt4=;
	b=ny3a/4klFhmNT4RcOaZ90hZzZkgjDlD5v2mo8Xl1he9d3+2FJk9scfwrYNlxqp3+jIaE
	 UwECcFhcpP3NzV+wU83JqMZLphyJrqzXEUDyxjOUZB+Snz/80uWwsmgP4Lv3d0wt9SK8H
	 yVMc2lFDi3d4gWmQv8/Tb0vc8DO8A350p04rU5kNDY46nWZenycReFEUe7mUyuOhmfHK6
	 udakcOOgdDt8MFRucSKD9Prwn/hkg5PMo9qxEGMvujto8OgF34yuhMlginkc3IyiyvXGM
	 kB2xIVY9YPzHrksngQGO+nekNejLpSQqEsDjaD2KosvT55epI6HI+8ZV+oFkfVXSGbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LyMNcric;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69F8606A327
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E69F8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LyMNcric
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a214af2076so7504765e9.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785205; x=1793390005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WhO3eiwpVjlpu/pA/NW1sjxZDrXxSK1K3FnCPXrmtt4=;
        b=LyMNcrichdsAfJMln78ddsIOmImAHXNWLeOIXtCVEUuIF9LazYd+tN/CYghvWTCrm/
         NuBmZQrhQMzU7BIdPm04SXCUUJUMuBc1KMKYJeluLgffxQnPSlqsdhD8RfPpEXvrvzTq
         vYaK58Wkbbuk4h8XQgud5V+0UJa9Qo9pFUhVLu6TAIIGdXvhnoz76lE/K07/2SGOXW+g
         W/kFt4YXAVdWJBHqteKlDFGn1zL4dXjgvDxCAmNScrbCwvTerOHy3AvO0IZQw5+3GZ6n
         xE7YHrpkRdyEMixIi+pDOCWYZ+kGHxSyJ45b/mN2/EySiIjQPsj1IBisP8VOkfa8bU5L
         AJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785205; x=1793390005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WhO3eiwpVjlpu/pA/NW1sjxZDrXxSK1K3FnCPXrmtt4=;
        b=sfS7e/j8SVO543850RgulWy3ilntI1KpJKM2Y6ThFHxb3kBBfHTHe6BLFXa/OxEFLr
         c687cXBx6mv711Njp7D6omi8FheKz1Y0fZpxLW21hfxI6BaQ6ljiM66PZsImsozYXZwF
         Jb9ocTUqiKkRvdgEEbRhIlPC81rY1XJzc9JYaRie/yN2zhTv9np3L7PBJpBgP8ukjDfU
         GgeleJKvhHJg9R0+2tbRZ2de3eggRW2gGUa0Qt7Kozc9uYJ0562b3waBDuhQRH2OamCB
         zFARKeZpaOjnjq2ED6K4x9HsjLaYbCh6h0Qw/wPTPa9h4QPQejhGbOKR/zvnBcXibc/D
         H9Qg==
X-Forwarded-Encrypted: i=1; AKwUvBxxpeOp2c81Ix+pcKQl2sAWuYdw5jsr55T8vqmEma8xWqaodZsMiSkpNU9BK20O3iD/weP5gHQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJobrWTCF/Tdkz9IOLLZb18vaTd5VTRxoHoWWbBHsnz+wq+MrKa
	yq1sJ9Fs1s/XO6wgJc04V3jKCiT4gdDqg03G0Rvh4pQMFgYzU98DueI=
X-Gm-Gg: AYBFou3kk2RrApH533Yvs4SfcPpIKLtrUeHxrj2fjQo4JAlT9QeUhztNY8Cgug6zmUt
	ypjGYMlzai6grjJGZo3S9FFdQJrQVeOGv9IydwR1ndbP5Epe3WCSwnxpQS1APc0oligBACxbtHk
	WIjXukEq9QA5JpNWAzWAUpMo1M0K4VMpWISHdCdSU9Q/n62Zs2JMZ5Jh582+jtMNu7RLqb/PmFO
	7cGNNV/jBuETfTgzKNGbNZXFUYNxvYyML99lA1hziRTKQCgsvAtShb1xTot0ZqArDkylMLPmMx6
	1hljqjbN7AjLuarntHQ8oN/WGYfvh+m8GfEmYqY3BS8m903ocxjWwlN6otmvu35JIjCWVEf7Zue
	1TDI/iwgCCO4W4rZyOr450spZ4AVH/MLdai3jM3TwrUWE2h5V3vL6r3xXlqdaCd4K22Lf9qh1MG
	8AMn9i9bqAXTZzmYC50fT4kUIIiymQHcBcoD6NmXmyJK3hFKBfYwA/dubEbVHoP7tNks6oQhW+f
	yqqpywqmGbmt9IPVUxdGM3I
X-Received: by 2002:a05:600c:e555:10b0:4a1:d992:9476 with SMTP id 5b1f17b1804b1-4a211ee0060mr36703095e9.23.1792785205270;
        Fri, 23 Oct 2026 12:53:25 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a06da5fsm3299225e9.3.2026.10.23.12.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:53:24 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH ipsec] xfrm: fix output state cache TOCTOU in xfrm_state_find()
Date: Fri, 23 Oct 2026 19:53:23 +0000
Message-ID: <20261023195323.3528192-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

xfrm_state_find() checks x->km.state outside the xfrm_state_lock before
inserting the state into the policy output state cache. Between the check
and the lock acquisition, __xfrm_state_delete() can transition the state
to XFRM_STATE_DEAD. The dead state is then inserted into the cache
because the stale validity result is trusted after the lock is acquired.

A subsequent call traversing the cache can then access a freed state,
since xfrm_state_gc_destroy() does not unlink from state_cache_list.

This is the output state cache counterpart of the input cache race
fixed by commit ddd3d01329203 ("xfrm: Fix xfrm state cache insertion
race"). Apply the same pattern: move the km.state validity check inside
the lock so the check and the insertion are atomic with respect to
__xfrm_state_delete().

Fixes: 0045e3d80613 ("xfrm: Cache used outbound xfrm states at the policy.")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/xfrm/xfrm_state.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index e45aa1ed5b965..03baa50f0df7c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1632,10 +1632,11 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		*err = acquire_in_progress ? -EAGAIN : error;
 	}
 
-	if (x && x->km.state == XFRM_STATE_VALID && !cached &&
+	if (x && !cached &&
 	    (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) || x->pcpu_num == pcpu_id)) {
 		spin_lock_bh(&net->xfrm.xfrm_state_lock);
-		if (hlist_unhashed(&x->state_cache))
+		if (x->km.state == XFRM_STATE_VALID &&
+		    hlist_unhashed(&x->state_cache))
 			hlist_add_head_rcu(&x->state_cache, &pol->state_cache_list);
 		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 	}
-- 
2.47.3

