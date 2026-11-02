Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634837;
	b=4f4zAjNMJIEe+39y6m3/OAUzhztgk7JhRQBkrB0U8x3I3HgCrjKW9Z2/zkkvNuTuwHHz
	 4Rnprfydow+k3nsD0qW4SPipnxWCvxEkfxeVmGz42H01R4rhfRCmRdkXn9eXyWYYlCOkt
	 q3HV0WKS03KqBecIuTFaRvuVPGNRpk/n2nVaOC5+KISbRNgvwnIXTglPJaqO/T6isV3xk
	 fIw756AxwPCELQO6JJgIpWwEV10WQdV6poktvUeKYsCYJukhmmF6WqqMkPGSZKWWEDy6U
	 I+Up2A7L5Wu5wuRVn+XpyqEUOi9EA2WFqNFmfqSd8ySjEm91n5x8qnZ0Qont22gbhOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=73DR8o62Fs8K8T2lKj1AIW1Z0OeA4tbHKQ/fX8k3s30=;
	b=xuVOv/8JKiIqx2ObZ9w+yjYFRho++mAk2+TEpUIyS+NeOO05wzC7hLQIV6lm6krVJb0t
	 IWsnYN9hwNooOLLaIVL9LZ66kIi0cIhpTitV4oV0KN4W1pdKpuoWtjrND3BeJzC3CtCQh
	 a/A4KA4FCajh3BU2ewYO4EeWr270yHDC4uiuPP9m1nxRYs0H60FEwUG9ZGQXoJb/wjhVQ
	 YA4/GRmu0FuuwBV1eeIuWTkpH6O5/N+Z5anmYSIeK5bl3ueEvm6ZR8OdKN5Wg5gH7/fn1
	 BIdatdLjvDaLwjOEGd7lT91bc1OEMpp74HCGIXe/bLZpmCSf8GhhlkbDbnXvFuNyiaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GSTzNnTp;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13D607B791
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB13D607B791
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GSTzNnTp
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c4649b35bso3064261f8f.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 07:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793634835; x=1794239635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=73DR8o62Fs8K8T2lKj1AIW1Z0OeA4tbHKQ/fX8k3s30=;
        b=GSTzNnTpuWGoXoGwURiFUC+RcXlSjBM2byaI+KR0CSGw+H/KFBUlBesE+xenaYscIB
         k9GXHRknAoBNiRKs+8i4IeB8dHdxSgdTDVPDk79Ktc17BWcLA99KuIOdGOF38WxFFpbZ
         ZWqIiya+OOtDEjXCswiSRcmaJ3QgwmjDpfVA9bnJp+DjgnPuu/GbfpbbzuIlhMpXxBdG
         rJc+cmAmHOTLh8h/sk35iHv2Ml5TB+sdYeDpBoV2NSTsXzSbHhz7WVGvpI6qiv0wsRwM
         3xZauCPTaOBYo2/eXXNSxiQ1qDolSe78LZwAI8cqy7giQvyF9yCXt7pQVYmaF8Ct1Sn4
         6kPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634835; x=1794239635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=73DR8o62Fs8K8T2lKj1AIW1Z0OeA4tbHKQ/fX8k3s30=;
        b=CDENYJGN5oO0EDUPRMWan4biQwZi7gvJgGCigC2dA4d8acAwbcf+aPJ2DYEoKpjLQh
         B1Ynq695KsOuRA++9YfbryYstTIcrpjkpCoSy86J4OZa5M1efXfrejMCYdOeKH0AcAxK
         0yakY+NKtqXPdWPjHaxbrMoiSZYVwhtIL1S2BCXRdAdzEAtR2QaHWuA+eChPAk296wrR
         gFZyncJ7WlTXQo/Aqvw7nP/vCs12xBDqDiaiFoH0+m1hyG4bgmzWvx3oyi7cna1fOXB6
         Ijaz3IIwUZJflC/R8RtZWJ20nyZ9Yg4xmx5Atf1zlZ6N6cKytvPvAHYddf1Wq7vxmXc8
         bbBA==
X-Forwarded-Encrypted: i=1; AKwUvBy6rRG6+QHnCqKeS/6IKHM9IqmhLFY5Rl1p2p0yOWtaMy3vXHr1sYNFDQKIZQL+3WGuFo8CQLA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pa069Fi+DJzd9R+kTUJ1dW421J95LEQMtZLeW+RmRWhzSl3rc
	ynQ604IWwWae38n14h2nGVp8646rR3urIFUynt54YSNYbI6bRND6HMA=
X-Gm-Gg: AYBFou22lvKDScM//+G3qfCg/F0HP83R9lpOoc/H/3n8J34BbDg1GM9B0rnoY708a2h
	+fnKnpuqA6qxkt9S21nmK60BGmxWSBsUa6OIGhTC5g2aqTFCMZtCXyd57CSk4zaM2ugqib5OwlH
	wl+3gekHMNwWz2GF3AzNao/X9BYyTqf5BhNRJRHF8xN9rDb404hzNHU+XNBrzAKmwjoRkey0OZ3
	VTnjQ/mJ3ID62UKaY8j7fsVBSlD7CmwDovt0khPJvWIWymCLloOobz1IEGT3WEJ1Rb74QuYuZVP
	ysS6bYw7AqfZ3bDsy4GSCF7k2IWRaDEcg99Mdpu0nM3c1lAehg02JL6m5VU+oCfB3JXJ6BdjNeQ
	aH7Z80ITxKxgk0FJcdCdhcZWskq9XXvvf54ezyMKbQuesIFY6GnXaup78ge03ag3dZ5hFwBhyGZ
	rRxefLHhRDTditRfK3OwJKgoq7vTO13Z9Bs8p63Io0BqWLZ9t1eup3pC9vDcqpby6O5MogYH1Nt
	TqziS5F4k7lFKo7aMnSZoEy4h6JhMI+b0EpWXrc/RaeejV7pfGs8ZHvR4SUWBORNKYTHJyx2eSV
	dlBfFTnZ3s4=
X-Received: by 2002:a05:6000:26c1:b0:48e:870:7791 with SMTP id ffacd0b85a97d-48e6e30b824mr21941019f8f.26.1793634834903;
        Mon, 02 Nov 2026 07:53:54 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80eb1sm22010082f8f.34.2026.11.02.07.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:53:54 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: steffen.klassert@secunet.com,
	daniel.m.jordan@oracle.com
Cc: herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] padata: fix lockdep warning in padata_find_next()
Date: Mon,  2 Nov 2026 15:53:53 +0000
Message-ID: <20261102155353.1268322-1-tristan@talencesecurity.com>
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

padata_find_next() acquires reorder->lock while the caller
padata_reorder() already holds squeue->serial.lock. Both locks are of
type struct padata_list and thus share the same lockdep class, which
triggers a false positive recursive locking warning even though the two
instances always protect different data.

Annotate the inner lock with spin_lock_nested() to tell lockdep about
the valid nesting.

Fixes: 16295bec6398 ("padata: Generic parallelization/serialization interface")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 kernel/padata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 0d3ea1b68b1f7..2f769ba7dfa99 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -253,7 +253,7 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd, int cpu,
 
 	reorder = per_cpu_ptr(pd->reorder_list, cpu);
 
-	spin_lock(&reorder->lock);
+	spin_lock_nested(&reorder->lock, SINGLE_DEPTH_NESTING);
 	if (list_empty(&reorder->list))
 		goto notfound;
 
-- 
2.47.3

