Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968643;
	b=kMgKhLqnsn9Ie26rQmBWDH9WRXrONB2tX8+GjwFQflzIdFlCAR7KBkWSZCTQ22+JPIaS
	 5YeKYM0H0N0Cs/BnVSr6hl6SJnD7yQ5i1PYUkseXE2WS3pX7StsJGWT9iV/1diTN4OuxS
	 rkV+EubVxxJzff1tXlHu8v8OoKnhTzm9tVvkkCzUpg2xwN6GCSCEG6J6vEozgKeOdEGdd
	 n3YUH2dcPpc8n786zsxpkAMHKiQDmdJFMiE4SgqNJ0poG2fOmA/s1Z9WfyHpKkeVJKKx8
	 5PHa03+AuQDvLvW0WBvwBM3wOXH7J9q8W+KC94/IEKeTp7FkrZ3ztNkLXQOJhvWT3Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968643;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Mwn54BdFHM91O+po8g3imp5xzGdZxh4HR8sU8pG4Cy8=;
	b=ytC/IqdT1VohAA+NnaP4LtmI36izoupI9C5KiSbdZW4M+1QHJhmXoTXHD3ZKkVtJ7Crw
	 mX+/dKjhupLDqp+k+1Rh0nbOuqyPpPL/Yx8SuTpxUdqoebzEH0YdVjMqOySoS/eMQMLOO
	 lBHaEVfwwXsTL3Bs+Ww6/5LdF+85SE98UIeGRWcOyUPC6UDNf2kdP8VMiItyhQpxOspfk
	 0uVT6lT6FW509CFpWcqwNBkZqN5hGLacIZ8AZgOW4c/NR5BC0CVw/DqejE2SZ10LjHfs0
	 uVpvmz3UCu5CNC2Fj056RInFNMV0nQ54Snqu1zsI7ScQk0j/SNLCX27d0ouC+FKLNJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+q+Eoq7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B3606A334
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+q+Eoq7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0081F008A1;
	Fri,  6 Nov 2026 12:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968643;
	bh=Mwn54BdFHM91O+po8g3imp5xzGdZxh4HR8sU8pG4Cy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e+q+Eoq7dHGcoRUrKV7dzUsjijnEKQuhBis3YkgNSX5MyUIAhrxE9OqOVmsxFABdy
	 J6Bhs/1LCLuQwUfunxNK32etfzbRaoCxOpsHdUOkNW9iqGSe7VEnSuD0iIJ2fr6OKo
	 HfdZZao+UVQtj5cD/1LuKrInEvttSFq0iqkJte0V7x5GtiSwITaMic9xAGmzuVl91t
	 QtGniLcbExWw0Rdvh+Pa3TEbMG0MmxEapX182VqfXhhLpLW6pjWeT6e/ebND5c0oH/
	 IEdyo5WaE3a0d4gNUTd9G3afk8rmjU+VwZ6VDQddrzK/hq6qsEYvqTtNE2INUjfP6F
	 rw2h3kFRcibaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	VEGA <vega@nebusec.ai>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] SUNRPC: trace an accepted transport before publishing it
Date: Fri,  6 Nov 2026 07:37:21 -0500
Message-ID: <20261106123631.4004730-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110436-footnote-extrovert-e489@gregkh>
References: <2026110436-footnote-extrovert-e489@gregkh>
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

From: Zhiling Zou <zhilinz@nebusec.ai>

[ Upstream commit 06f90cf104fc21ee01e7ef1eb80e092173089b9f ]

svc_handle_xprt() publishes a newly accepted transport before tracing
it. svc_add_new_temp_xprt() places the transport on sv_tempsocks and
clears XPT_BUSY, so another nfsd thread can dequeue it at once. If the
peer has already closed the connection, that thread runs
svc_delete_xprt(), which drops the list reference, the only reference
the new transport holds. trace_svc_xprt_accept() then reads the
transport's addresses and network namespace from freed memory.

Before publication the accepting thread owns the transport
exclusively: XPT_BUSY is still set from svc_xprt_init() and the
transport is on no list. Emit the tracepoint there.

Fixes: 11bbb0f76e99 ("SUNRPC: Trace a few more generic svc_xprt events")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Link: https://patch.msgid.link/d15495bff2247e3f9d4f9ef36df8e246a3898380.1789220778.git.zhilinz@nebusec.ai
[ cel: trace before publication instead of taking an extra reference ]
Signed-off-by: Chuck Lever <cel@kernel.org>
[ sashal: Adjusted context to preserve the existing unbraced else clause. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/svc_xprt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 60782504ad3e7..db1f565cc8ec0 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -811,8 +811,8 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 		newxpt = xprt->xpt_ops->xpo_accept(xprt);
 		if (newxpt) {
 			newxpt->xpt_cred = get_cred(xprt->xpt_cred);
-			svc_add_new_temp_xprt(serv, newxpt);
 			trace_svc_xprt_accept(newxpt, serv->sv_name);
+			svc_add_new_temp_xprt(serv, newxpt);
 		} else
 			module_put(xprt->xpt_class->xcl_owner);
 	} else if (svc_xprt_reserve_slot(rqstp, xprt)) {
-- 
2.53.0

