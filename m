Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D026AF4
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786794745; cv=none; b=eDInyMcquSpqDx+2thdN2vuP/KGllmopDNjFjRBnZWpHoJQklx6rFVkVVIHtKk0eQeCe2aqXZa1O1nhJ3wCEmM0YFRCj5Aqhp9COPM27Exb3R9sKprboVNJycEbv1MERCFp8fg8mZoPYnQAk4YF86uRwGL6J/3WD2BxnlGxf724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786794745; c=relaxed/simple;
	bh=Azo2sCiZllD4H75gWaBzm5I3JqLlnW6xlX7nRXQnSss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+InlKri/wH44a4EUxk8sBsCX+SePTSGl1c0ZUV//OumdfDv4TSqnKR44ChsM1bndKGlTr5neujIsJCi6ICMjHmoWN2wZ8I8gnGEVpxqyITEif4QPDUZnavWoDlBvQeVPeKofnpUzyA4VDEIZjTIuYOy7aXkAt9sdqhLNqTURmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hn2voB3B; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn2voB3B"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbf0dc8c871so1122745a12.1
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 04:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786794743; x=1787399543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DKboDhjvAevX2LxnuClRbMjZPu76/sbW2vcejkifeck=;
        b=Hn2voB3BhyHsXAAks8i4fzAfA7rR97NnSlZCgtz3PbCIihHVvzY9laYt/MqVfN+v0t
         hcampbC60yG3TnKyQKYjnOWVLKAZZEuBj/9amt4SiGQDtGvTGRfl27cSvja45iEsKPuz
         afIeWlko5rFD7MkFiaEi7VnN9cmZBlJ5UtoJ0w4ZUKN7CE2m+LX9Q+KyPB9T7dUEmE2e
         6jlmwp5w4CPrt3VhmhcQY127aMCR7mUloSEmWsPjvDgeT2aDul/JdN/KRddxJqZ5U5ve
         VP8a1U0Knw37i2YV/w+gfldcsmS+Y1GskQ62umAeHZDbFtRU+8SXS/L/LNtXdjgjlN8X
         BqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786794743; x=1787399543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DKboDhjvAevX2LxnuClRbMjZPu76/sbW2vcejkifeck=;
        b=J1Dqv5VSmSSr0WgrbcWpdQurAtzj8PI+GL3afmfALBqYk94QQ1poqthskm+wenxH5Z
         Fyy4TJS1++BdELdEtdA8eO/VfztxteCLc4buzwdakiRmToeQXVcxISlyLbvINPkrP96b
         n286HiETi8LpKmU1gcTWVbssIiWoYKIUqISFIe7b5d7OAw81Xu8ZNdr3s2jvdQlV5xWV
         Q/5eSNEnSru/q20aPCrVHQh68mjAdtypcolQ33gqkIydhZFFczZNaVfoIs+mawv7yzi5
         oTkwL6H+Z4vT3AW/SvH1IGi5Zh9ZU+Sem4P6CPufDF0oQiNBpjzMlWuxUrrgs2+F6kDo
         uMOA==
X-Forwarded-Encrypted: i=1; AHgh+Rqe9kc3j7numpVizW+/ehuDOS80W1R+9r1mPGa3Klwkh8nnQ1jYaxovmYV6YFtIip/sD2LoncY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy60I7YZBPEsRXU/6V6XTo691hZTPc85ZQMyEtT+ucOvSAV9dST
	UC3e07AlKXR7m93icEXVYHllA4FBLaxwQvHHqRFzLXSNsFgIMZRDI4Eu
X-Gm-Gg: AR+sD12lpiZDcasc89shi4fQ+5YFy16GMI3fzyC8XXxKzwobX00MjXtnT/+zZu5FOqb
	YlaAP+T/z4nRGkJi1JGobFXKfYUp1HSHH0l6lAXQeje2JOT07WP09ze/Xt0i6nBcvj7p6T5NMAN
	dl1JYpPTvVZHVr41c7hDT9FmLnnwQgZS2ffAG1GaRjU4Je7o4EwirpqEAZOERpiCk7OFRns48Xd
	M4V49s0bc9A8qTMVn6dRbFp6Hheb9qWwQS+aRSBM24KIjPYmrPjoNYYBczw27+iZh9O6LlUvx2F
	iRJRRNLVl40/FSjGaN0NYhsv6smb1CQSWzLlvH9cqjwMpjRA4OtEpwigzlAzuGSlEkmadt7v1ak
	8BSby7azv6u/N7gU2DEvIGJVlTKUQUr6qkl5sbBa3vHsVoMvX5pa3uqAwSBbUMovA+n4zHxbTvT
	idC8fjAcPap39btLoYPOhaItexxQQlRq0HDJI4lCkR4D2QCGWCzdUDdG7GOzPvn7MTQydcWZiFF
	xL/sup68lyGaGrCubBVnXYcBPwMzqczhPbC60dir9xlBp4h
X-Received: by 2002:a05:6a20:7346:b0:3bf:6ac8:8d29 with SMTP id adf61e73a8af0-3cc71c95248mr13675074637.21.1786794743413;
        Sat, 15 Aug 2026 04:52:23 -0700 (PDT)
Received: from LAPTOP-N5EO9J2L.localdomain ([106.205.255.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5bd9fe0sm23884947eec.1.2026.08.15.04.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:52:22 -0700 (PDT)
From: Harshit Varu <harshitvaru666@gmail.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	Harshit Varu <harshitvaru666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] mptcp: fix uninitialized local_id in syncookie MP_JOIN reconstruction
Date: Sat, 15 Aug 2026 17:22:05 +0530
Message-ID: <20260815115205.197151-1-harshitvaru666@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_token_join_cookie_init_state() restores remote_nonce, local_nonce,
backup, join_id, token and msk from the saved cookie entry when rebuilding
the request socket for a MP_JOIN 4th-ACK handled under SYN cookies, but it
does not restore local_id, even though the SYN path saved it.
subflow_ulp_clone() then reads that uninitialized field and stores it as
the joined subflow's address-ID. Because the request-sock slab is
SLAB_TYPESAFE_BY_RCU and not zeroed on allocation, the value is the stale
byte of a previously freed request socket, which an off-path peer can
influence by sending concurrent MP_JOIN SYNs. This corrupts the path
manager's id-based subflow bookkeeping for the connection.

Restore subflow_req->local_id from the cookie entry, as done for the other
fields.

Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
Cc: stable@vger.kernel.org
Assisted-by: opencode:deepseek-v4-flash
Signed-off-by: Harshit Varu <harshitvaru666@gmail.com>
---
 net/mptcp/syncookies.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
index 7f2252634..b5cac5701 100644
--- a/net/mptcp/syncookies.c
+++ b/net/mptcp/syncookies.c
@@ -118,6 +118,7 @@ bool mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subfl
 	subflow_req->local_nonce = e->local_nonce;
 	subflow_req->backup = e->backup;
 	subflow_req->remote_id = e->join_id;
+	subflow_req->local_id = e->local_id;
 	subflow_req->token = e->token;
 	subflow_req->msk = msk;
 	spin_unlock_bh(&join_entry_locks[i]);
-- 
2.53.0

