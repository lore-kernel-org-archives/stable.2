Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345536F8F5
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785295223; cv=none; b=jN6l/Qoa83O/cOc7sHbESazzMD77AA98rL1/kG+UdGSNg0BobWG95t2nJZKFPQsKTwY1RBe6pDDKHONC7iAcsuD9zSI7nyVe3O7Vdsga47hUJvMGSVXyYm+CsnExXLOCqxNWmz63pSoiEB5FP1j15ncm/j5ymnE7TjbVyTm0D5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785295223; c=relaxed/simple;
	bh=ATA3YWjSdmR41r1wug9OcPT2u3mMSEF1lmSrqN8DHOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8mgCXVAHU7Ng4EWmXqtyNtfM1rQlk0uIBarfOAjZ3Ya7gCrdxRBv2/6Nn1KeyQpsPpq44n11NtTS5U//OLe0w2cpFzxQ3m+tqdovODPnLTgxlObEpuPd4DZ9qLwCvcHNuwcvfZIqzpOPzddDUbOQF2g+CRUfyNBIJZrkUXJjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfakrsgH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfakrsgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7D61F00A3D;
	Wed, 29 Jul 2026 03:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785295221;
	bh=+TXyuQjvDiZNxdoSat9qkW8jz0RgSA5nz1rh8tAw06g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hfakrsgHrrl15X0og0CuhyAn4RL6VcXdhYpWJic967h0OAYDJgohzZSlCQ+GiFEOD
	 uD1BaFMACb6Ikb+PLqxApSvsSdWE84CrHirHHt5pMDaZbqRupxjfEJm+GoS4X/i87h
	 fSQ3kYnbeyFrE4Cueoy7VE96LLNV5CJ3KVy40DhtldYxMLgD0MfA/5hy+HVNb4i4jB
	 VZJhecWAxJUStkyhRL7CL5149t2LaeLngNjwfA8V4emRvhPz1QDAUH0/gQq+H6sMr9
	 zQXnP15Lyyo0JoEWMC02tGvbL5Cj0t/jUl2rod7Q/0nIIExU5YsidArbhbAbrRqM9O
	 C+HIgJujKjsiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Crystal Wood <crwood@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] tracing/osnoise: Call synchronize_rcu() when unregistering
Date: Tue, 28 Jul 2026 23:20:18 -0400
Message-ID: <20260729032018.1223942-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729032018.1223942-1-sashal@kernel.org>
References: <2026072147-clang-iguana-51e4@gregkh>
 <20260729032018.1223942-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Crystal Wood <crwood@redhat.com>

[ Upstream commit fe58f457ad8d0a2bef4e053cfecca4b5cd266b1a ]

This ensures that any RCU readers traversing the instance list
have finished, before releasing the reference on the tracer that
the instance points to.

Cc: stable@vger.kernel.org
Fixes: a6ed2aee54644 ("tracing: Switch to kvfree_rcu() API")
Link: https://patch.msgid.link/20260609045430.1589786-1-crwood@redhat.com
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_osnoise.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 417b62f7550978..3b3f31ca45831b 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -137,7 +137,9 @@ static void osnoise_unregister_instance(struct trace_array *tr)
 	if (!found)
 		return;
 
-	kvfree_rcu_mightsleep(inst);
+	/* Do a full sync to ensure that tr remains valid, not just inst */
+	synchronize_rcu();
+	kvfree(inst);
 }
 
 /*
-- 
2.53.0

