Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672528;
	b=T9pRaXRg2Yf1g4+2WuzDIq1dwHccDlFd2RcBMFTncWouQexg3JhO9r3IDeT99U3dAUAP
	 eN5yPqlWyYYXWP/KHz3NlX0OL4bXivfpeJlvIeHYT3rroXN/KWsM7M9J21eNXPMsX8HGE
	 lKNG+1WBqKCLIpvU07aMUmJIStM8GIcuIbPeWpIB0BV+ObpQUxcPu0+H1nSGqurZEhp2c
	 3kosQe7s6q+quypUitGa0orEEZQvuHMgGUtnh/ly2L3LZO5+Y3gGgCk+1WwG8Ym2LJ1eO
	 xG0yQtZ4fcma96Y4z13xEHdZtmrGkOeHFE2fcextCMFCuQJh3AmD2tOhZrbexqOh5Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672528;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q6S+zrIdHrAY+6a+homiES8yAuIzXefM0rL2yhQ5jjU=;
	b=h2vlwKVT7I0gujaP7xhife5YXr8tehTw1+Deak9vsjDPQRbNzG56czr/QfgtIZSW1vAA
	 i+o5l5Q3XR1xdxJzB6xgFUaViZR6aLWlzf1IpUf4EnzOtphEFYQ1RPyG/+PyFZbDhPC/i
	 LBrxI9C64gW3Sv1X9fai9uiWkl37WI7d0bta386Hmqovhs+dvU38tH7Zv9/mDHygKIdky
	 ZlB9aTkS+El8j01SygGAv9bugwJvEtNmN7UOli5HMfGHK6fTakiS/rIWJed7THKOg+dTc
	 +QJURYboxQe9fnJTnLmJdd7JEPEfcqmfyE1lLKSmmaeUNrwOX+v5Mb6loQMOsyukdww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOFSpmNU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ECD606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOFSpmNU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE881F000C7;
	Sat, 14 Nov 2026 16:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794672527;
	bh=q6S+zrIdHrAY+6a+homiES8yAuIzXefM0rL2yhQ5jjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OOFSpmNU52uLggEoXzNEPaH46fR/wYieBzhrfKo6pa7Nk4Puqx1BwfRTUP5lclr0q
	 2p+8X+DarlTeIwTCAGXU9GmvMIiLFuWheKuBv+h0hiEd2cxye7a1t1Gxv4spNh5Pu+
	 /wg2XvcUvIIWcmjhWWIg0hLMl4GKLF69eUV505bpMIPiCWeCWi6xXvoWu/iBuM6Glt
	 q0DDj+5DltUTRryaZ9m+vCsO09/fvGyYloxqSuPI0Lb+O1z3nqrR8+DJvLVcqw5xDi
	 ZdBo7GKZ3+7cYhB4wunAuXpZkcIMizASOpF2b9L2e98HKe04p2ux007jbU5W6+2FSB
	 RfZcVU34G66Kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/cma: accept memory of CMA areas reserved at a fixed address
Date: Sat, 14 Nov 2026 11:08:44 -0500
Message-ID: <20261114160743.3915557-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200812-failed-6.12-f8f9cbc34a30@kernel.org>
References: <20261109200812-failed-6.12-f8f9cbc34a30@kernel.org>
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

[ Upstream commit f8f9cbc34a309a388c052706f3329d1b52985aa3 ]

CMA areas allocated from memblock have their memory accepted by
memblock_alloc_range_nid(), but areas reserved at a fixed address with
memblock_reserve() are not.

If a fixed CMA area is requested by the cma=<size>@<base> command line
parameter, it may be in regular RAM and on TDX and SEV-SNP guests it
must be accepted.

Accept the memory of fixed CMA areas as well, so that all CMA areas are
accepted regardless of how they were reserved.

Link: https://lore.kernel.org/20261029-cma-multi-v1-2-2cbced8b5cb7@kernel.org
Fixes: 75d090fd167a ("x86/tdx: Add unaccepted memory support")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: placed accept_memory() directly in cma_declare_contiguous_nid() because cma_fixed_reserve() is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 2d9fae9392835..4a0616bb12b77 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -313,6 +313,8 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 			ret = -EBUSY;
 			goto err;
 		}
+
+		accept_memory(base, size);
 	} else {
 		phys_addr_t addr = 0;
 
-- 
2.53.0

