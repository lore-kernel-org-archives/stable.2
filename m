Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4937267E
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565860; cv=none; b=uvFiXTb1Ki4qY08YxR3zUde3KOPM6kX5JZXNnRMSh+en3D07eTcK0e0BpCtDM7F/4cnB6oecQ6ersoI0nWshK4LYYpLh/70VzDyKTZQSbQzhcc485XQrcUw6el1IUvuI6GvAsx1TW7xI8HAVjUukeTQCtptzbPNXbFU+SoFQVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565860; c=relaxed/simple;
	bh=ZNXFj+lBY/ZA+sd78CU6mFu0Q19wS9znQBroSrv1/OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6ldgi3h9phVxsXYsX+suy8QkMZmzupw9nskzU/OhoViPxoCb6GHZ2pL8PQjc97zukt4xf8+I+QbNMFlMMANMj0DZbALigBNXWT+TSpB/pSjTMl+LgOXiUMvLAKe/fuA4fWcKRL6XUsYbjWHRFsMjAAKWCxtLkXFHq3OkuS89Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYpDv2vX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYpDv2vX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780565858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGvMDGbkUWB6PfoK/qtXuxYDjah0KrGjD6R1mURW5f0=;
	b=NYpDv2vXUj5860QaUZNGnI9mHiD0ACZRITR+6P2YX0EHn/AuUPHwUjqVxx6AVUL7jsmdjn
	kxvzd1LfORdTwrk5wsbjDcqkKDGox1X7hnY2Mksiii5hybB4A14sZQnX7A6RJhOQ97TpXS
	EBrSyYvGru/NaNsQDYTp2Qy4t3KZa7U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-f3yYyOMsO6u66abMkbOj8w-1; Thu,
 04 Jun 2026 05:37:32 -0400
X-MC-Unique: f3yYyOMsO6u66abMkbOj8w-1
X-Mimecast-MFC-AGG-ID: f3yYyOMsO6u66abMkbOj8w_1780565850
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F52B180048E;
	Thu,  4 Jun 2026 09:37:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7FB930001A1;
	Thu,  4 Jun 2026 09:37:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: moonafterrain@outlook.com
Cc: sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	danisjiang@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] octeontx2-af: cn10k: restrict VF LMTLINE sharing to its own PF
Date: Thu,  4 Jun 2026 11:37:21 +0200
Message-ID: <20260604093721.110635-1-pabeni@redhat.com>
In-Reply-To: <SYBPR01MB788101745A9E36F6FD81CD7AAF152@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB788101745A9E36F6FD81CD7AAF152@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
octeontx2-af: cn10k: restrict VF LMTLINE sharing to its own PF

This patch tries to plug a privilege boundary in the LMTLINE setup
mailbox by rejecting -EPERM when a VF caller's parent PF differs from
the parent PF of req->base_pcifunc. It carries Fixes: 893ae97214c3
and Cc: stable@vger.kernel.org.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> index d2163da28d18..33f25e2fc262 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> @@ -178,6 +178,14 @@ int rvu_mbox_handler_lmtst_tbl_setup(struct rvu *rvu,
>  	 * pcifunc (will be the one who is calling this mailbox).
>  	 */
>  	if (req->base_pcifunc) {
> +		/* A VF is untrusted and must not redirect its LMTLINE to
> +		 * another PF's region, so confine VF callers to their own PF.
> +		 */
> +		if (is_vf(req->hdr.pcifunc) &&
> +		    rvu_get_pf(rvu->pdev, req->hdr.pcifunc) !=
> +		    rvu_get_pf(rvu->pdev, req->base_pcifunc))
> +			return -EPERM;
> +

[Critical]
Can this check still be bypassed via the FUNC bits of base_pcifunc?

rvu_get_pf() only inspects the upper PF bits of the pcifunc (shift 10
on OTX2, shift 9 on CN20K), but RVU_PFVF_FUNC_MASK is 0x3FF, so the
FUNC field a VF can set in req->base_pcifunc spans 0..1023:

  static inline int rvu_get_pf(struct pci_dev *pdev, u16 pcifunc)
  {
          if (is_cn20k(pdev))
                  return (pcifunc >> RVU_CN20K_PFVF_PF_SHIFT) &
                          RVU_CN20K_PFVF_PF_MASK;
          else
                  return (pcifunc >> RVU_OTX2_PFVF_PF_SHIFT) &
                          RVU_OTX2_PFVF_PF_MASK;
  }

After the new check passes, base_pcifunc is fed straight into
rvu_get_lmtst_tbl_index(), where the index is computed from the full
FUNC field and LMT_MAX_VFS = 256:

  #define LMT_MAX_VFS             256

  static u32 rvu_get_lmtst_tbl_index(struct rvu *rvu, u16 pcifunc)
  {
          return ((rvu_get_pf(rvu->pdev, pcifunc) * LMT_MAX_VFS) +
                  (pcifunc & RVU_PFVF_FUNC_MASK)) * LMT_MAPTBL_ENTRY_SIZE;
  }

So a FUNC value >= 256 wraps into the next PF's slot range. Worked
example on OTX2: a VF on PF=0 (req->hdr.pcifunc = 0x0001) sets
req->base_pcifunc = 0x012C (300). is_vf() is true, and
rvu_get_pf(0x012C) = (300 >> 10) & PF_MASK = 0, equal to the caller's
PF, so the new -EPERM path is not taken.

rvu_get_lmtst_tbl_index() then yields (0 * 256 + 300) * 16 = 4800,
which is the slot for PF=1 FUNC=44 (1 * 256 + 44 = 300).

  pri_tbl_idx = rvu_get_lmtst_tbl_index(rvu, req->base_pcifunc);
  err = lmtst_map_table_ops(rvu, pri_tbl_idx, &val, LMT_TBL_OP_READ);
  ...
  err = rvu_update_lmtaddr(rvu, req->hdr.pcifunc, val);

That reads PF=1's physical LMT base address and copies it into the
attacker VF's own LMT map entry, which is the cross-PF redirection the
patch is intended to prevent.

The same wrap is reachable on CN20K, e.g. base_pcifunc = 511 lands in
PF=1 FUNC=255's slot since PF_SHIFT is 9 there.

Would it make sense to also reject base_pcifunc whose FUNC field is
out of range, for example by additionally requiring
(req->base_pcifunc & RVU_PFVF_FUNC_MASK) < LMT_MAX_VFS, or by looking
base_pcifunc up via rvu_get_pfvf() / is_pffunc_map_valid() and
confirming it is a real attached function under the same parent PF?

