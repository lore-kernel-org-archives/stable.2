Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810355;
	b=imAWA8lqDcdlZBckVPbQpegu87O6yi61etANtVtEndMOZtCHP7nMekvMIIr0pKmMCed8
	 jG4kqO0nxEFeidP1u7UDvfAbUNgoRFH8M+OvESNXCvN3usDcUwNv6tLc8bX/vjwVgLKr6
	 aQEysUhvFA57qxNktoL+Yx9tMGZFipOWrtxJ8VklOl6cNVaetA/jyCKNF0ZUkqFkZmWHW
	 Kyz9RQ29OnoWVEtptgIZmxRn17dlaVl+ELB/r3B6K2JhTsr0cU038KZ4mc4P0WWFEO2V8
	 1ebCIbYE50MicUlN6wmQUd+Sng5RX2qrrikeJGJIdsCq0ccjaGda0etAzLdsPqhpYYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810355;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=owWnceecot/leeD8xyntjFXOFZg34asqokQMnfZ8Nmw=;
	b=eVORglObqvVGckizXWa8f7Ew281OWubdZQKLFBDaTNGPJcufVJ9nMIxDz/qVlEqlyoqk
	 DBI1wc3/KVrzscv3Wf+GRRjOdelzchnIU3JXiQsiApmM8/838BdGC01uFopGM1HTISzbg
	 ogn8FUDbaZ2OfppzUBG/0RmeReYH8rsiv4qlEsrs69kC3rd3lT8NGBBDOPyl7YOJ9DXtf
	 5cy6faDatpGsf9GpV8nfmRkFINESNjexpJFJ/1DWqmrBss5rw4M451dOqtlVuxJXUuCc2
	 7Ik95n6y+iyhnoKPDJ6whiGRJRUTNScOyF8dvWrcQjNH3MjgYOdekNKdZ2UkJiWr9dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQbw9xb+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84309606A31C;
	Fri, 27 Nov 2026 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQbw9xb+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9C71F00899;
	Fri, 27 Nov 2026 20:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810355;
	bh=owWnceecot/leeD8xyntjFXOFZg34asqokQMnfZ8Nmw=;
	h=From:Subject:Date:To:Cc;
	b=fQbw9xb+H3tdLoEd1DWy69WaURUuMmezidR/1lE1/0x48NkmIDYusYvGv5LtXa4F8
	 jKlRspjdtlEK/VX91eccVbUFARsDzho2jUdpGous0/5yMRjrGlbBrfWrcp4kQioTVi
	 tHQlZpLzBrXtpbI+2pwfa8hWPI7r0Sx59HHmwfvg2a+8uAVLnI3Zud2Ls68mLWdExS
	 84kgx/4xq/8tMQkQu+korTw63b/K8PsF1bWHfEX1IPLJtFO2ASE/yGJz/K2ljKYKZ9
	 sQYA8G64zU0ncWu1hT4WDYlzQ42kxeiJAmVvocr3LFU5y5ZogRvV6ow/euJ3ivIT1Q
	 fEQrEG2pKfOMw==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: [PATCH 0/4] slab AI fixes
Date: Fri, 27 Nov 2026 21:12:29 +0100
Message-Id: <20261127-slab-ai-fixes-v1-0-cf13b6be6692@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC3kCWsC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNz3eKcxCTdxEzdtMyK1GLdRIMkA5MUczPzZMskJaCegqJUsARQS3Q
 shF9cmpSVmlwCMkSpthYAfc43anEAAAA=
X-Change-ID: 20261127-slab-ai-fixes-a0b04d767c9b
To: Harry Yoo <harry@kernel.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 stable@vger.kernel.orG
X-Mailer: b4 0.16.0

A bunch of fixes that are marked for stable but not really urgent, based
on patches from Chris Mason, dispatched to slab maintainers by David.

This batch is based on (and intended for) slab/for-7.5/misc

Two fixes for sheaf refill with __GFP_NOFAIL allocations and sheaf
preallocation. Those I've rewritten completely compared to the original
proposals. May improve slab behavior a bit under low memory conditions.

Two fixes related to the rather obscure slub_debug=O boot option, which
can in theory negatively suprise someone trying to use that mode.

Nothing of this should be an exploitable vulnerability, really.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
Chris Mason (2):
      mm/slab: keep caches that drop debug flags unmergeable
      mm/slab: clear stale layout values in calculate_sizes()

Vlastimil Babka (SUSE) (2):
      mm/slab: drop __GFP_NOFAIL when refilling sheaves
      mm/slab: handle __GFP_NOFAIL better with prefilled sheaves

 mm/slub.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)
---
base-commit: 152bb61a6134d1d2b736cead67f653ce57ba559b
change-id: 20261127-slab-ai-fixes-a0b04d767c9b

