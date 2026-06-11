Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2C38D3F1
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217666; cv=none; b=MdFXlFzdUEstlT0iC+hVknqIJovYuz/+yRi/Nue0K8Mi5EEoSEKsX7OG3GME/HF9awr74RUlDVM6J81OvJOzpk2RFnsmHdm+tnsCjgO0pf3pNp0XAaPBoKYV1FY8phqJX7o6/hCFjWuGbS+QG0c4zeMBBKXnm1DZ/TDZREwHAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217666; c=relaxed/simple;
	bh=c8+5gsDcbu85UlXQBPGgv2ThaqMzxsz1J3fkg3m5+7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LUriMiKrHxCFWJDoEBlD3wdUljmWb6igDN1s8wgtUxdqOV41G64oL2+xj/NQX4csI/TKsszOTxeK0uGqlYNbeaeajkPK0kuDcMLPvOb9zBmJBpJXLOgqDYtCvbxcXC1VWlSJnrEOIph/t81hNB2B8KVWINYw28VtxUbdK8e4gjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=LpTyqhPK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="LpTyqhPK"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-91578122305so57507485a.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 15:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781217664; x=1781822464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+oAze3O4D+kWXYDV0GKpNw5gMSt74lXkoTZLWlVoQKY=;
        b=LpTyqhPK1RGlCIkBGgZWvk+kWK5MCfJKo7N52jWb2T8T5NTKegE5bXeUcJ78KLHw5E
         IZMUzJS29WAeCl0mYLInpmppY7SE2solEZHgxEG01K9sSSR+wNkfINapbxP3YTkag+rG
         O+QmwMwBllcCcwLqL1UZDIDC/g8tOIXT0QEII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217664; x=1781822464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oAze3O4D+kWXYDV0GKpNw5gMSt74lXkoTZLWlVoQKY=;
        b=lYH/w5raeWOXTr1EsNCS9zE46cxBZuBTlHI6ajAAVSrpUFBFizPxgnk+as8o0XZfFz
         cvd9sD7D4XhQ486WDxPpMGfiZS5+TOr6Pqn8bG2nN1l7+V8+oqEPVOEDT1QDr1YASeLD
         EgQcsQYqskkCg7mGaZFAMqVwIvAigrTTw6MH23bZp/J0JUPuLW6/LaKsnyHF/NXedrQI
         UJcRjw7ncmD3E5fqI+9F98Ymw2fBxiFY7hzkB90k/OxSF/P1A1Dqwkz6314F9KxxYGRz
         kgjDca7OfDZshEtXEQfOLSGrQShxU3VycV7VO799oRtk3UoaLN0lZi/mKrqCHBAuWpef
         29FQ==
X-Gm-Message-State: AOJu0Yxpz4wE/Inpb5zOUqG/kKYt7+maMZjqJNhTePA+HbazUNYk7K5c
	eQrUy7++KBUWOVV6MkBCvr5sb8ZQ5PzcddEBcbJSLNA32vYJw1k8aVNRtg7SW1Udd5RG8xlRxVe
	izFi+u+g=
X-Gm-Gg: Acq92OEnHsN/kxZIvzH0sUiCy8iZ19RtfqZauuwmN1CruWVJOOq1m6g/cEUQVXWV0i4
	36eFWbOJ7E5KHjO2GmIZHdi0/mHe28yGWEvDPCzHhP518OEO7ileXKrpFGozL2VaemhCXPcjpud
	d9mtO6ru3PuKWi4q02NEq8+ZnqMuxyiDo0Au0BvR9w/aOoFkC6H+Cv8XdtnLP/dDYJczkDvqXyK
	Ycl4RTzZPBSOi3OpmpVtY+MJ2/zLykC9AEYJt4pfTyA/whKHSD+FXKua/kA9jRfejkgk39TMP4C
	trIDrxLL4Q//ftvyIp6YqCiG3AoccoUfxebZU3io5d/voS/cf0/Rwrml1y6WBgxMyWQuNfdszaI
	Fw2Tp64lO5zQbD0qqWFfUa/BYLSXGSx1d0uDjo3OIJLB2PeqbTnNddSsPkmF89mBx9Y8u7UOeO9
	inDa9zLuHDlAY1SeYzVBef4oLISH4UgUfZlcp51us2AxKcmrTbhifnoMn0zKRn2Uv81AT3fJv1r
	Re5qRwnJWb6FlPu+rvqEa1l0csu8nHXJz0=
X-Received: by 2002:a05:620a:c4a:b0:915:9e84:85df with SMTP id af79cd13be357-9161bc547d7mr11408585a.17.1781217663830;
        Thu, 11 Jun 2026 15:41:03 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a069389sm39280985a.45.2026.06.11.15.41.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 15:41:03 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: stable@vger.kernel.org
Cc: outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH] reiserfs: continue checking leaf items after directories
Date: Thu, 11 Jun 2026 15:40:59 -0700
Message-ID: <20260611224059.76010-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_leaf() validates each item header in a leaf before the leaf is
trusted by search_by_key().  The directory-item case currently returns
the result of has_valid_deh_location() directly from inside that loop.
If the first directory item is valid, the whole leaf is accepted and any
later item headers are never checked.

A crafted leaf can put a valid directory item before a malformed later
stat-data, direct, indirect, or directory item.  search_by_key() can then
select the unchecked item and consumers use ih_item_body() on attacker
controlled ih_location/ih_item_len values.

Keep the directory-entry validation, but only fail the leaf when that
validation fails.  If it succeeds, continue the item-header loop so the
remaining headers are checked.

Fixes: 13d257503c09 ("reiserfs: check directory items on read from disk")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/reiserfs/stree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index 5faf702f8d15..0f4eb9627a39 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -479,7 +479,8 @@ static int is_leaf(char *buf, int blocksize, struct buffer_head *bh)
 						 ih);
 				return 0;
 			}
-			return has_valid_deh_location(bh, ih);
+			if (!has_valid_deh_location(bh, ih))
+				return 0;
 		}
 		prev_location = ih_location(ih);
 	}
-- 
2.43.0
