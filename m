Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A03368A3
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785620261; cv=none; b=Ut8CZrXT9r2gxXTHrhudH4BNm7zWQWDytfEi0fj7jjgFseH91LD4JPbmBG1+YLrhT0cQgmex2eyHKKMf/ebJX/+e5HR6DG5YOgD4DWqG2LFL6LkLqkEmYJSaheEfutzpXbd4oHqh0BEbYYRs07HGa+IJwNh/nDjun7jvHgrTfQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785620261; c=relaxed/simple;
	bh=PdcrG7GkMxlOZ4eaudUMpHVF5woUKkG1xAqvC1xgXnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXWWaHFo73VSoVCDa6sBaYheZQXFYWsJHBsJvxstjI+JRheiC90MZMKp6gxHZ0gqkDk8CHqNWNQoPcVAezc02+uY0vEDSg3NvEgmuuvzWTulxeLVeFbf8vGAEfxWkTIdByZ7dnb1iUiwmkJfhSi/q9QHilhzvZsNTJnlUbf5hiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BigswsHj; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BigswsHj"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-930c0f9c1b1so125508985a.1
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785620258; x=1786225058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G6Et0NhWmlhqF6H6Esm0lrRD3CSb6Cqp9D32iHCNdQ4=;
        b=BigswsHjpvhURs2nEr5x3PDY7BtwS+iHViS80ZctZEbwla7nmXh7wK0yfcC60pJ8EP
         Vw8/UQOsncG5We2H4lF0l1mEY2lDV5svCTCj7aJGHYmWdwQ/AFbE0MIBq7HkpWXijzYV
         Kj5k1ttu4EoAwp1nuRsxYhis+ewC3uaXSwNVAw3b+/VKPSnxEI+4VYtQ+9nRQUIQa26u
         dIKmV+BilrVMbnHpK+LKqMF1Babz0D8zz+XMdZyh5JJZh/hNcDE4RFZgwIF8IIF1nJN/
         +LxbsuiDfPHI5JqwAshctdtkJkMOhCGPu/r9ex+7u8U1UdGWZY5UARFSAGsfWNxoba5c
         O5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785620258; x=1786225058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G6Et0NhWmlhqF6H6Esm0lrRD3CSb6Cqp9D32iHCNdQ4=;
        b=NFDQssqbvFgBbtwUANrV8X6Uo0vo5TzYYNkRI1FHrR38DjikUlCywxHiDEb16RJKlK
         xcgFJaLFPCmwjXWZRjvtcs7asKZBD4VoUvaNPGO+iasd1FDSZ+BOHvGS+8UXfYk1Ql9+
         KDR1boDK+H5zWmwW8vq4FhJGPnWUx7QLGoyuM9M1wk9NTzt1c/eoG88XU+hFDXpAUe2c
         vSvd8VUgK4Ru3X8X94rHTXO8aFkI1VUq5uEJd7Al5DiWPqIn70OHHw2E3A3DnB8PasrC
         NBt/3om+8io4D2+8WBgtnVmOPAeLQZPHo6WKpIhWjk5KDaTVC7VS5yjFynZoh3AppnA6
         QsHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkUFWoGppjvcyCXNbsV/VoOU669aakM0sn/Jhkckxsvr4ckAnDhDoCa0GOdM53OhJLvDd1aUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztMvQjDZQaHq0V5OU+jgF5bfAODnzCrpsVzskb657G6w82tFp0
	QDoHP4TbasS3hC39oVywswyOQcXV8J9tyf2b+WEy9R/AFOr0L7/MBH8H
X-Gm-Gg: AR+sD11IAWXPOlhy1zCix2at38S4eTZMZPpW7vFMqf9wOVl4nDXsbv8UwrA0Gh2R3Yy
	j0VxaMt/CecumP4JJDUkWnLdPkPh0vOMSzAFOQz6UL3yv5nQDkjRd1Edj+FUAtbBR+6uldZOCSs
	I6tpapru9v23dlbliss/2cchPVknve8z9AU5uTFdOqAAwDmAeqsk0TMWRoAi9Dr2GeyR6qGtS5B
	Q+TgeGShkASs00rdZd7l6G9aa4J9gJSNVEpQh2svqFJpFzi5wsM1uOnb9QILXVlNZ+7egMBl72P
	IcEDPO79kxe7xXdDMF/WshPNhPb51W+6hCxDToWgAGGmFJQd6ZovBppsJqYYHIpaB9ErkaYEd2/
	CXzy2fo5CnS+n2/i96x297jobMEc11GDSbjp3kvt/+1K5crgApsBC4VCYMLqKLzpT9uncCVGL9P
	YXPINBAljLxuHS2x7C15l9PtntbEjroz4vbSK366+v/l/pdoX/gGmUb9duit0inwPfDvnvI0Bc0
	2ji6T2vT3iNHK//VQ==
X-Received: by 2002:a05:622a:22a2:b0:519:e020:6087 with SMTP id d75a77b69052e-52b5679fb54mr98575971cf.11.1785620258384;
        Sat, 01 Aug 2026 14:37:38 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435b6adesm40376256d6.24.2026.08.01.14.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 14:37:38 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: bernard.metzler@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/siw: Fix use-after-free in siw_accept()
Date: Sat,  1 Aug 2026 17:36:32 -0400
Message-ID: <20260801213632.1086548-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

siw_accept() looks up the QP supplied by userspace. If that QP is
already in RTS, the function jumps to error cleanup before associating
the incoming CEP with it.

The cleanup tests whether qp->cep is non-NULL and assumes the current
call installed the association. However, qp->cep can point to the CEP
of an existing connection. The cleanup then drops a reference from the
incoming cep, not qp->cep. Once the incoming endpoint loses its
remaining references, this can free it before the subsequent cep->qp
store, causing a use-after-free. It also clears the existing QP
association.

Only release the association reference when qp->cep is the incoming
CEP. This preserves an existing association and avoids accessing the
freed endpoint.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/infiniband/sw/siw/siw_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 87c79527ac09..0245b25e7271 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1751,7 +1751,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	cep->state = SIW_EPSTATE_CLOSED;
 
 	siw_free_cm_id(cep);
-	if (qp->cep) {
+	if (qp->cep == cep) {
 		siw_cep_put(cep);
 		qp->cep = NULL;
 	}
-- 
2.43.0

