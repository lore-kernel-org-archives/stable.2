Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB95C3C9EC2
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787211862; cv=pass; b=e1w0w0ilGS/KOBqt9YCJsno4EU9aQ/Lg5+wSzoa7R6XcFUhU4IhXEvh0WEBR0EwbKFQyhHXWoZ6Wdebp6SsYbOBZbzjc1NBCfd7T+BaBpIQqMZIm3AjIWwBSSMEomy+IWib0fT2TvU7fD/RA4Wk0+5VbkhFVfUmucs4U63UJNTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787211862; c=relaxed/simple;
	bh=qblL5K7hDoy6z2OQB7G1qpmMIHaxIOhwHYlwWzA2++w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JJq7HRTcWf5hoy5zr4LVcpzVnfO1AOnJ4XnwG7Gn7eqWuHC6EUArsq1h3zNzIrlxmHAeuWG/lBzG6ByJGqoNDlmVINNTppV8jjYBZg/8UWO1VzJSVXeWpkFA1BRrm5lda4F964xoig8B0SWlnRNX6nsP7CeVIkVaK3wNQ0qiNZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=O32Bwevh; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="O32Bwevh"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15e592da74so264867166b.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 00:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787211858; cv=none;
        d=google.com; s=arc-20260327;
        b=dLKGz8b6+1IWIewtwJ2du9IY9DQn69h7qpE21IK3FARCiTaYgUvkbY0UnpEhNcMXqg
         O4l+yUXMKO2tTkeioeCR7O9fJAmtx26aZPLoQW5Iwp6AcnLusNlm++NKAkdKB8APLq0M
         gBMF3+o3ctpJ6eyBv2DtKQgJXBTp/AIxgGOjNOt/ClfWLlHgyl3tPACfAXdW7rNzj9eW
         hZ5AC2Y6wcoagBQJbFFpgN5yFHan36QWsMPnzwZ7QrgmzOG2TnCdD6E0JH3fZu12mgui
         UogVDEO0HMSjbWIHqAQlhwW3B+4NtLOq6OI1TJaNpZAkT6BO5rOq9v8OHtYzyMladqgC
         qjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=qblL5K7hDoy6z2OQB7G1qpmMIHaxIOhwHYlwWzA2++w=;
        fh=VYON2AchzTHgQKems9QnmXEk3H82yWNgNrU21PukfDA=;
        b=J9DU2jXU6FSgGFlaXUZNpamPb4i3DO+Qdq/oGC1mVmVztNE1m2D2LTRWEhbR7ilOvk
         SuApE/S4ijRiKV7fGVDDuGSzV6FuswOf2cWPC/l3UX8aga643sbkr408mZXxwEG7WgA7
         Hz6vaWY67khzsbxRWfl4LmxeM5fHH3H3Mb75NckTDfOJYcCYGq1p2raKAkcALZNdbJau
         LmMrr6CyDZXLe8QHKtYEFOVhF4LxRSbmhFpN8INCI6oZTX5FGZIMVFqyRmV1B2CeGvfh
         Ff4Gi2/5WfXDz/DUwfCixYOhUJbF4aJ8hXaXZczTrvOYVR9aHUqmZWpiGiV6CrdynoBP
         Npww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787211858; x=1787816658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qblL5K7hDoy6z2OQB7G1qpmMIHaxIOhwHYlwWzA2++w=;
        b=O32Bwevhzq1YbZr6suoVujv9j1kUgBusVkzqD51HXyGJ5SiFfNovf+Dneo42uRfN+a
         u+z8QzG2loXfNA8t4L6w/ApOiUGXwiFY4MmXjpI5d01z7hksreQx1EF6lUT6MgPDPkb4
         GtJfiLFSDyKMXaukevE3hIZbu99DbU6c88HrR/Oh5b0oA4UGgyuXRwEa3pO8aQ4vIOab
         5Lgdc6OQGyktqyDg8+uiNPCdF4GKWbdv+rZfK0Nv1W7jq18ZLvCVaj3Nq2P+NgBWIOWX
         sAoNgsWQKR2xcI5ldtImdKc9gLE161z31jyE33lcQ+mdPP/GFECL+Wwt7haM14Vp3cc3
         iyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787211858; x=1787816658;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qblL5K7hDoy6z2OQB7G1qpmMIHaxIOhwHYlwWzA2++w=;
        b=De+D1GqDYxNLj+7Fmr/Cwntkpmol0atxQBTzHEBDyJaw00/4M0X2c3Nbc6R0iA+MnO
         qtvz74q5zP6wb0TglJKDNmBhtgcOVv97zj9iphJX8fxLyQYcd7Rlpq6r8fH6q4VlmDI5
         5JnJH1IDjtnWPr0lOzsl7wwK5Y+0YVN5yzDWS+UUJBnD5Nc6LkiKHmFUC6qXVLyyaIIm
         4rfMOYf/5aE8SQ06d4tCgaSVsKmPZyBuBXwAiEuBpojQzZbQqwhA3/3hZFq2cXcnnVSy
         8qzQXEfjV0IFTM/ZHWWCUfAjtAtpMCNlvOUauFqbfz0uk38BelaUF3k0rS6TVQ4Gi0Rk
         c38g==
X-Gm-Message-State: AOJu0YwnS0euNVMg9cv9aN2bmsX+NZI8kJ8iNmto2nKYbMNFVt+Mp3ZI
	putQ2JJ+o11oa34j+dF/3vbUW7dUDUa3162pp1PAg2n36NQN7dW1Ih067R0/9lVQ11wDz7qUnS2
	obZA6BMWrZKfeFRlQJtABKYcY/qcyKxgu0RzJkYCUtYgViyyCxHp6uOw=
X-Gm-Gg: AR+sD11HlA4/mleWk+baHfND9RCeH3cIrUSJ7LUbx2wrZNACTyQvYbFbG54A8wXDapQ
	RTS/9GZxMnkdf9B4fAubtJx0WECidy+/uioa4JHWsC99xPCUnw5/I24G6u0cAilhq0YFhLmR72f
	suXo/XZsE7lt94JDNOxiIL9CsZUUmx2+0aTlh2Ul0QtnTMNYQmu3oJEYrHrQ7Si3gAuEJHlunFV
	UZGbcgk5xWWG1YopkLhGD8E5axd0wVR1LxF1VRJzHe+3fN0pysYZufFovxNSxOSKT6NUhKAgML6
	P6EiLx4nU+0tXxcugq9Hhntlj//AIwiUazBi/reVcsuBn+jJ/Ft5oTkUnSjLmHXok87uBWVKsA=
	=
X-Received: by 2002:a17:907:9307:b0:c21:450d:cd88 with SMTP id
 a640c23a62f3a-c23f936e874mr646819666b.6.1787211857891; Thu, 20 Aug 2026
 00:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 20 Aug 2026 09:44:06 +0200
X-Gm-Features: AcwNN1WYliKAFAcz8NUi8mIS6Z7tSILNli4M3PRUKj5FVlc4VYbogqNmwFk7o6s
Message-ID: <CAKPOu+-x_QPgp7gvApKNxd=aAONgNUmQQMbiLKwQghWd6u7Y=A@mail.gmail.com>
Subject: 6.18.45 regression with bnxt_en due to uninitialized RX page size
To: stable@vger.kernel.org, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

after updating our servers to 6.18.45, the bnxt_en NICs would fail to
initialize:

 page_pool_create_percpu() gave up with errno -22
 bnxt_en 0000:c4:00.0 eno12399np0: bnxt_alloc_mem err: ffffffea

The regression appears to have been introduced by the backport of
ad9ffc61fafeb ("eth: bnxt: support qcfg provided rx page size"). It
obtains rx_page_size from the per-queue configuration:

 rxr->rx_page_size =3D rxq->qcfg.rx_page_size;

The bnxt_en driver installs queue_mgmt_ops only when
BNXT_SUPPORTS_QUEUE_API() is true. On some NICs (like ours),
ndo_default_qcfg is never called and rxq->qcfg.rx_page_size remains
zero, leading to bnxt_alloc_rx_page_pool() failure with -EINVAL.

This was fixed in master by:

 1410c7416dc3 ("eth: bnxt: always set the queue mgmt ops")
 3cf48c04966e ("eth: bnxt: make sure we populate the qcfg defaults on
old FW/HW")

After cherry-picking these two commits on top of 6.18.45, the error
disappeared. I suggest backporting them.

--=20

Max Kellermann

Principal Software Engineer
Hosting Technology

cm4all GmbH | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
E-Mail: max.kellermann@ionos.com | Web: www.cm4all.com

General information about the company can be found here.

A member of the IONOS Group
