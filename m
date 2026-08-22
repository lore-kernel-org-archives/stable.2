Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F8388E4D
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787387072; cv=none; b=flznX3ujslO6uYnpJb/Gxkod/pSb7dAf80zWQRaqcy+uqJBFVkdvfyXzIU2CXS9E3QGQXGKY5jc6fvIr9ND8vqqReFPalK9l2duFK7dc+b1GhKxmuUYIIdT/HLNhRyk9/iirfNiz4EzsxQlXUEXs0U88m+SK+hnB5nD0x00ak80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787387072; c=relaxed/simple;
	bh=Z0kL/ypFJ2FGHLorOtaZ+IeJE911meCgAVCtAPqReXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzjxJDLohqNSawUvDe0EBKShErtNMjo77yC9RI7ctV05P9cctYUFspH2HNxyW8iPB0nA755XEiSSs7LK59R4afj7xUHeThO3UAC5L6XRc0kbhBtxqu3oY3v+rWDYZVd60tV9TRkQG9puLuAfZzE8N2v+2CcL4aHBAIbs6aorf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=kYKuvPpv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="kYKuvPpv"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cacf197759so24654135ad.2
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 01:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787387069; x=1787991869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7IdaOGAe0h00In+Evgr9XH1YvrseI2U04raVO4/5oDc=;
        b=kYKuvPpvWogCiJnFyiXjwFCI+/5nbBbRl3WS5NbQnilK6FkJ5vEkdjV8NWyQZzkezg
         lhGjTwcnYKEC5JsKxPlej5UWOBDQwAwN+JaSa7i7RDaJcx6HFE7o4zULKuGbceNOceYY
         BUNBRozlmThxVk1AjT+mj7J5adxKcMJF+L2gq2kJQCTFeqYcAFB/sBtthoQ14uq1xvXg
         7OvPI+/GYqY/7yAS52Y+KNzP5ULC7bGQaibt1IX1IBkhTp/alJQ1K16X8WvP5eBOyH2B
         NonD/tbOsiETGf31RVQLmF0qg4g4oxKDRGLQUop9IiR8I7GoqPHwFdtEnG8xGIr1+eSo
         Eq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787387069; x=1787991869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7IdaOGAe0h00In+Evgr9XH1YvrseI2U04raVO4/5oDc=;
        b=KqE0E218vqRakcPeb4jgnRbjO8xVYu+FiY+XyPZf28tJM2NOj1X4pGJdgOC71ji4vC
         5vR2zA3TvR2p9OOWESJTx6gi/pHQVZ3O9mtSJOjlTPSgIt7Xa34Fzcs7qUu7jpcqE3hC
         jtbrMYI2pic8zKcxIUi4j3HBs/O+tDQ8beQRY2K8eYKz5CgXfggKIgaxmPkC2C7Q8Gq0
         DG3xz2Mo0Bhix9oLSMwjM0RJGneLZ3ERQZ3P5YxCibiQ6qqjuCx3rpM58fzhS+vXCimF
         +mafNR10V2+sGWOJwmbPtzXADvafv9vKQp+YRnJzJziQQLyc/JrpUb9euvyzX1LQSTR+
         XQVg==
X-Forwarded-Encrypted: i=1; AHgh+Roh7zth6FB5QC23WR7XenggnCPrek2PPD9lKmYIqtK8/7+b3YligYTk+oADbxV0wKJX7kAYljE=@vger.kernel.org
X-Gm-Message-State: AFuF++lFT7dUGiwdYkT0Febs2QB7tlmieagW0vhLBB4DepejHdPzXzPR
	Ui30h/7PJ+70akPcTkkNoPkRqVRVO7J3gStoN2CY7tynqZDv5MW2yE80iT2/0GHmlS0I
X-Gm-Gg: AR+sD136TrOY1DR3pNCmfCT8uN9dkG/S83c14TBsOhSaAKj/PK4gMGqUZdXfY1eErww
	goiGP6MJKy8Ts11hgcV0qw/JPIrwaPPKCtPpTfn7A8HYtVtHi9UPdbdTcfx7OtnPUa4rQtFRThV
	bXCuHEmnow8pmtMNKbEyUaL5NPsAsgWOGvdKgJm7X0FVoulxiW+fkr7ZazMss4skmANXbQB2Ngz
	WlyMg5ej4XcHKm7ulb4IC7u1dZlQwLoc+5K4sTPO0ua2BcZTrKFjt6UgRpTw3meUYhRJG5kbkJw
	yTuTgg5P5RAaMRPFnXlyPqa5cGEtqofurgcWWiMvafWZntHP3+ZGkU5BXkvFc3cn9BPz6Gf/bKl
	AzA02sEdZz1ZGYgEXNgERM9GaOR5HgZGfOBOuo9Ms6avs2Tpp+Lx04+BooeLAEBc/IdNZ8FSEfY
	MOSlI3nwv2snDJUPOJ8+9x+sWA+TnfrQgOP0voOHw1dGua0X6z/8/0pq2EwU6+/So2bKIhradeC
	h7CHGo0zIh4JyY=
X-Received: by 2002:a17:902:e78e:b0:2d3:7887:7e7f with SMTP id d9443c01a7336-2d64b0c6fe8mr243979635ad.11.1787387069109;
        Sat, 22 Aug 2026 01:24:29 -0700 (PDT)
Received: from gmail.com ([115.192.250.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768f1379sm2647875ad.82.2026.08.22.01.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:24:28 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v5 2/2] llc: reject out-of-service state before state lookup
Date: Sat, 22 Aug 2026 08:23:54 +0000
Message-ID: <20260822082354.3109-3-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260822082354.3109-1-zihanx@nebusec.ai>
References: <20260822082354.3109-1-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llc_conn_service() checks only the upper bound of the connection state
before llc_qualify_conn_ev() indexes the state table. A socket in
LLC_CONN_OUT_OF_SVC therefore reaches llc_conn_state_table[state - 1]
with a negative index and can read and call data outside the table.

Reject states below LLC_CONN_STATE_ADM before the state-table lookup.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---

Notes (llc-reroll-v5):
    changes in v5:
      - Make listener child cleanup unconditional so queued children are also
        released if the socket leaves TCP_LISTEN before close.
      - Serialize process-context child cleanup and backlog dispatch with bottom
        halves disabled, avoiding child-lock acquisition races with LLC receive
        and timer paths.
      - Drop packets redirected through a pending child after its listener is no
        longer listening, and release children left out of service instead of
        dispatching them.
      - Split the LLC_CONN_OUT_OF_SVC lower-bound check into a separate patch.
      - v4 Link: https://lore.kernel.org/all/20260814185843.4748-1-zihanx@nebusec.ai/
    changes in v4:
      - Create a passive-open child only for SABME and generate listener-side DM
        replies directly for non-SABME commands.
      - Use an atomic incoming-child lifecycle and serialize pending-child lookup,
        backlog processing, rollback, and listener close with the child lock.
      - Keep immediate SAP publication for passive-open tuple matching, but release
        unaccepted children on direct and backlog failures and on listener close.
      - Defer final incoming-child cleanup to workqueue context so timer
        synchronization does not run in the receive softirq path.
      - Add an LLC state lower-bound check before state-table dispatch.
      - v3 Link: https://lore.kernel.org/all/20260805175945.10698-1-zihanx@nebusec.ai/
    changes in v3:
      - Drop the unused llc_conn_handler() local rc variable reported in review.
      - Rebase the numbered patch and cover onto commit
        ede76849012e45ffb2193ad110b42027eec02c5c.
      - v2 Link: https://lore.kernel.org/all/cover.1785386749.git.zihanx@nebusec.ai/
    changes in v2:
      - Rework the fix to preserve the existing passive-open tuple matching
        semantics instead of deferring child publication until LLC_CONN_PRIM.
      - Track listener-created children pending publication to accept(), and roll
        them back on every earlier failure or drop path.
      - Cover the original non-SABME leak and SABME paths which fail before
        LLC_CONN_PRIM, including backlog enqueue and backlog drop failures.
      - Correct Fixes to 1da177e4c3f4 ("Linux-2.6.12-rc2") based on the earliest
        locally visible root-cause fact.
      - Clarify panic_on_oom crash evidence and packetdrill selection.
      - v1 Link: https://lore.kernel.org/all/cover.1784725007.git.zihanx@nebusec.ai/

 net/llc/llc_conn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 8120ecd46ace..4272ce4d4a1c 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -360,7 +360,8 @@ static int llc_conn_service(struct sock *sk, struct sk_buff *skb)
 	struct llc_sock *llc = llc_sk(sk);
 	int rc = 1;
 
-	if (llc->state > NBR_CONN_STATES)
+	if (llc->state < LLC_CONN_STATE_ADM ||
+	    llc->state > NBR_CONN_STATES)
 		goto out;
 	rc = 0;
 	trans = llc_qualify_conn_ev(sk, skb);
-- 
2.43.0

