Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4E635B650
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851216; cv=pass; b=t7lKepWpipjc0AktJFRsQ7Y6PATJFaqsWfQsFiW3hPb3J/iW2ivAn5hG0/BIzjbQLxTLdNw2XJDJfILxekl9L1YvMtHKDi0/CI6aO7JSHUwNGjzzskQ+fYm07JE8SLkcP6asubKepaqKp5mfKohBKuPYqUkZzDtfTng49Jn9krc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851216; c=relaxed/simple;
	bh=1yDDpGk7UlB1XRm2igJPt/Nd5az01ELMWZVQ62sfJZk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ed0aqAlMc+38QgJjxtytCAkWcjtnY8WddsU2ag3a8AoMu/P3WvLA7mbVG6Ns0IEmL42O6F7o7dkgckoEY0uvZgvpzT4RIhB65HqOxuVxRfvM76Afo+cgN8qKA8uRuDusLWrEJoCDZuLdKH9MmJoJVeHiqybmQxISGY0pAr3uq24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCYdMdaE; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCYdMdaE"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86e6d007703so1587823b3a.0
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 13:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789851214; cv=none;
        d=google.com; s=arc-20260327;
        b=eDv5huBCtghK0do69EIRuByfiPteU2YDQhJepE7LS+xy2HhO7qdaLvLbN43L1eHrKW
         Gf6YU6Ogj+OQBZ09XTosYGWoEInv9mRbVAjuKaJ0RweYFkMf95yAnrxvLe55lJ4POCfW
         u3L9+yl80jw7pcStaUJdrRAIa/++Guew/3rtY5dUA0yGngK/pRKS9u+0QWDyoBTrFSKw
         pYT+bEkY5CoUMdreSFpKsfk656dwstJh9MLZweNC6tc3HfIP42/MqvpqLVL5fLwiNS4j
         w+T+iam5kbiX1322lxqjjPVZKTogzr3c/SLZcLkU1oUcXUWtxUvDEhgKBwunwggr6oRZ
         F3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1yDDpGk7UlB1XRm2igJPt/Nd5az01ELMWZVQ62sfJZk=;
        fh=9H0MxoXjUnjH+8HJa6bHJIjRodspSaoM5uaQct8xP9o=;
        b=PK/dd3CZgGW6YLlBt1Ddd8INpaRwkDE2g8JHkQbAPHMSE1JqNK+OwLfRGWNRCZ3XL3
         551s7OLvvs8J92lrDvmH43/MnPNQTkuikNcqi1jlASlu1zdrP7iQfamQzo41H+7Jp7mx
         cur/F/ECDXzGaI0g0b2xWlQA92uCR5BXWtmRUI3vxD/qPomB4V+b0xjWp3zhA4hJ7ugl
         Rr7hW1+S3ELfjbCPoqFES6JnPOTif51krcNlvKHz7fZXDPR2FBSTg36AHUORhSMO37jM
         bvzjJf/anybWUjY7B/oCBNxbxN3Xc5DcJuzrpXHz5JK2g1XUs3TdRgpUMSnTa4ber5sk
         Zo0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789851214; x=1790456014; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1yDDpGk7UlB1XRm2igJPt/Nd5az01ELMWZVQ62sfJZk=;
        b=GCYdMdaElAFUrge1m5HEc8Lsu8lsI7i/hXDOVxq0k79HW/RA1H1dCkUTqX/7LSZ6qg
         bC965UsWeFUaAlFRZoe7MhFiNEykjJsrFzhnceCz5bN5tDCiye4IrA1cw0/A+FWRBdgA
         +zOx6CfPhnXATZq/EyxutbO+gt2q7RA6rNBifo+LlCYnyMvDKLiSTGMXud9DfNSDxuKN
         S32uRQ+HtMUQgclb3FPmJsc7L2J83JRX6KU4qJaJLbMreU/A4koMYHIZ/oy0EN6tQum4
         Vf1IHvkOqFQyDRKoAXk8kXd5tD49zouDa+yfUmtNhscW4Wa1sC/goQJjLasKiLgOu3Cv
         xsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789851214; x=1790456014;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1yDDpGk7UlB1XRm2igJPt/Nd5az01ELMWZVQ62sfJZk=;
        b=X+ndiWZRxJJ8hnPINSD6e+9rsOVuZ1DmmQDXMui6IZK0oFqMnSvjymnyYchmtks5Vt
         OBQp1rh/MqgDe7tMwDeeDu0mkfBK2bm3LfRkua42AEkcpKzUlStfxq1/s0SZR+mGsT5+
         qCL6LMwLOL63XxjNlEp2GTXU8xR49YU5ycmbY5OZu+K/ZKUKL6WHKhQ7Jsl/AgATBisK
         XyhGEiwwJuRDXb1budhRzVPZv4LAVsJaPg87bHI6JvHfxLke5++Z7I5J52HBVVodYws9
         CHzqXDBdX2ATLJgyezpUenJSN7Yij0QLwAnEbmSshYMBagiiGHQe5RrUku6B3JJMHXrS
         ramA==
X-Forwarded-Encrypted: i=1; AKwUvBzKWO8cJGhAA7zng+R2tkE5NX+R25WUsn1sOClE4PA4WIpVrIVS9JL3bhMB2T6yf9KupPq1mp4=@vger.kernel.org
X-Gm-Message-State: AFuF++nXqsz73p+que73+Z9apJFZ8xzCmjV/HHxijJRDUxmgezw9nTYC
	JY0rE+hy/56mlnuLAO2PZMcTDNfKOyw1ReH6n/QxXEcXsPVo3Adt08gPmxOnNdoLr0hOaoI4Ssq
	ilw86+7/LTdOrTfgUocJ/RaIytKLie98=
X-Gm-Gg: AYBFou2BDobW7buND/2RynwyTO76gb/yAiYG7kF5ioJY8qogJ3spYc1cWuZCwWbKIJL
	TJOTpI1SWzLFCR6AftQOcskQKLJhRn2A8tn3miF9LCqO0LjMLD3kUOhxfh1Pkshg11xfxds98zG
	YsyajwUS7dcE65G8NIy1n0R7CntaZ8I7tEN/std5JlC9Q7zO8NRb5HUq/AvePD5OPPURseGzc3y
	rE49uDBT54qV+jDuON9hL7Ml47/eqDNWDbvpqQnUpEkkGL8yLWy0CVlAvAsOHVO2aJEGBeVzS0t
	kKYjadZxa9WRN7um3bmbeoIbXhYjtqBx8lWW2KwiewyJ3N03AvcnBp4d+2jpcOVcMCc/rk0OPQH
	EAjV9ZkxVJOUC0V76QwowQX9ypIlwBFOyHU3ZuKx3KfnfQ7TfTpabARxYSWZ0tZ2Yh4Yp8Z1P
X-Received: by 2002:a05:6a21:6b01:b0:3da:b089:dba4 with SMTP id
 adf61e73a8af0-3dd8c3fc826mr11732141637.2.1789851214024; Sat, 19 Sep 2026
 13:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Lomas <david.s.lomas@gmail.com>
Date: Sat, 19 Sep 2026 21:52:57 +0100
X-Gm-Features: AcwNN1VByzJrKqU7LMzWxWek7XyZ9CB60Q9hWtTQdOYL4Vi6JhYXo8yhZonG_r8
Message-ID: <CALjEBWT9wyBYtWPgtg8Xd_FxRU_XnatzQMcwMB9_P2Fdj83+cQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 0167/1250] PM: hibernate: call preallocate_image()
 after freeze prepare
To: h.haechoc+kernel@gmail.com
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, 
	matthew.leach@collabora.com, gregkh@linuxfoundation.org, 
	stable@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Same commit, same symptom: my report with the blocked-task backtrace
is at https://lore.kernel.org/all/CALjEBWQo0-Sdimo+aRNKUQvgDGw=jBFCcfwCXaqVdtoPrHLAQA@mail.gmail.com/
(XPS 13 9360, 8 GB, zswap). The hibernating task sits in
throttle_direct_reclaim() waiting for kswapd, which
freeze_kernel_threads() froze just before
hibernate_preallocate_memory() ran.

#regzbot introduced: 783c8109844503bd1c35dab41b6d5fd074a9f131

David
