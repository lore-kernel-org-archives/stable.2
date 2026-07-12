Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D8E37A823
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783893448; cv=none; b=cvCgEDtOLS4Xam7BIh80/iyfLsjd0pdxIhPVVgXzxr4Gh00cLyLcW3G6jT4sW1GHWLrQNCu5TEjLHWxJzYJNo+OMvdsEHPJLslce4VnuWOFAOm08/tc80SleOgM8wz3rAPm8MHsCwkaKslNzurBf9W4Rjpj1MJm3kiddU/BK5gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783893448; c=relaxed/simple;
	bh=K4mSZwTp/u7hydGX0B9HMeu+jFvEsCWuLWVpwuqs11k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKmQrHsY+4mknEH/er8Pf1I9Q7t0GPc/CP4jrhNl9fsGe2eXjomkOwOnbwvDnjkuOanOJtBefrNTq+UqzFMbTQMVW36nCQWt2DlB7V5Aix0RkNmpjAov6hQiUlFeHrtbPTqJl0/gtcChrR/6iwoihrrBgxrMznFppwVsZ8Wwjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RZHLJiM+; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RZHLJiM+"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2ceaf8a1265so10310515ad.2
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 14:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783893446; x=1784498246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zyr6YBFmBRz4cpGfkF4vKmM2rz6RRnkLotsCwCyQb3w=;
        b=IRdoEyv2UbUSVqOLH8z7Enqv3CWnHC/eWFG+NHWeP6hEaBrXVnt1G7h+ZFQHtfWHiH
         QJjVZ/xabJ/RUWVoStRtBAzpmSK69mdwzqK5A228HOz/QAXrI7/ghmB2KqBYmNNHwY9y
         MkC8ft5oAWTFXcg8aoXRtoiZgTknlC83QAjIPa8gGITJsPuYo+v0sVNGCmmbUzomwHha
         a0Dc4Xe4BNi5csV3Nq3Y+5FnSxoS+6XEo0g48WTFwF6qnjIRx+XE6BDovGY16pZLzUhQ
         6xDSV+/LW4q50HjivErqo9YOiS3BZZrGuVZSk9BjMQDCa1h+Kl7C55zW2/VoaIZv8xi2
         eQvg==
X-Forwarded-Encrypted: i=1; AHgh+RqYTu2+vxA6OYx3of/dCR0hBJuFVJJmteOFqL/CzzciZJVOD64+1S719ttriYaaNLEOtn43D1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymhon6Jo6RZEiqnc8OKYOhJaNBicDfBi53nF2SNtWuSSSOxdbA
	Ew0/kYIq+SnyJTn/qhDcSYekloVrNg+NfLiLe16eDBQ8wKdjdJtBBkh49xiUA73fHe+GMsLFx0J
	qOLx3FiBAvPyY4391o5F0vB+Q0uQrfjM94xqFIhsDtdvOhq1ZCIDne5Ma4s+AsSWNJKxYN18miO
	LaOULJLILB5bOSRaBfH7hUm43AmGOEPG227mqtRWMAwnZl1sWrnrw6GoCI7s8mhRnl7S3sY4oGV
	shL2w4BACa87opDQQ==
X-Gm-Gg: AfdE7cly1HoOVHlCbQN6Joyiw5KTJPWRCvpcKCu6idGon0BS93BraE2sNZlGQ3Cwmy3
	iG0IgI3hobKVECR3/Ao//jOepkTwA6zEQJsMlOq7KI42IjoNpVwJ09y62vCfBuMBjWZlfdIs3g9
	MWPjfBFBx2w3fCdu1fiJNh/FEbl7R19nEMSqUJBiH55JEKvXPOhM1Ei6uPMxOVfh2dKVdnMOgzb
	HelaGX1qpBj9DYSF/CcSM657U94YjW/Gtv2gHWoTb4qbiv9ActoS8VUEb7uPOhreWx8CsFFGHwa
	R/H5z6h+xZUwgKqUa9xrNJ7XaNcrVXwjmNMW4HSFxYnuCvTzafanKI1y+uhOgNMcQvofNb/LJwi
	6rcUa6NkC7tidPUNJ1q8P7EheoW4ykgmGJcBt7H4gXjdvlz0OlbXkTvAij3N+RHUSZ2ZxY2QaLw
	eB3H98B7dWl8n+adKs+qEPaP9fuo8YjpwX3NJeE5L0LzpQQBq/95YW
X-Received: by 2002:a17:902:f64a:b0:2c9:97a8:8c19 with SMTP id d9443c01a7336-2ce9f2882b4mr77194105ad.44.1783893445824;
        Sun, 12 Jul 2026 14:57:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ccc9ccc34asm17755455ad.25.2026.07.12.14.57.25
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2026 14:57:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so3701788a91.2
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783893444; x=1784498244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zyr6YBFmBRz4cpGfkF4vKmM2rz6RRnkLotsCwCyQb3w=;
        b=RZHLJiM+z1ARcnvgMk2ZB+irb4SSQLgf/7cyDkG+r3gBG4FP3hMgEeFlKvYlrwb4Cr
         zdT1HNVLczw8yg2YU5/rTvpWFxf5P1IPslYZCZpdN2agIjBGh19awqHVI0Y7+kZM8Fg1
         Y83Cqb1X5doxo3kv2JR8r6umCaYIU3mU8FNMY=
X-Forwarded-Encrypted: i=1; AHgh+Rqk6/PCC+k0zpN4FIzhT1PE+y7B93pwWqX1MkPtcK//J+gwL437RsckY/La34fSI3R5Aw9JmQE=@vger.kernel.org
X-Received: by 2002:a17:90b:58ce:b0:37f:9ce3:ca96 with SMTP id 98e67ed59e1d1-38dc777c50emr6691031a91.31.1783893443862;
        Sun, 12 Jul 2026 14:57:23 -0700 (PDT)
X-Received: by 2002:a17:90b:58ce:b0:37f:9ce3:ca96 with SMTP id 98e67ed59e1d1-38dc777c50emr6691003a91.31.1783893443371;
        Sun, 12 Jul 2026 14:57:23 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4b97661sm29930583eec.7.2026.07.12.14.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 14:57:22 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>,
	Arend van Spriel <aspriel@gmail.com>,
	Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
	Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	SHA-cyfmac-dev-list@infineon.com,
	Wright Feng <wright.feng@infineon.com>,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: drain bus_reset work on device removal
Date: Sun, 12 Jul 2026 23:57:16 +0200
Message-ID: <20260712215716.2170806-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709101635.103005-1-fanwu01@zju.edu.cn>
References: <20260709101635.103005-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Thu,  9 Jul 2026 10:16:35 +0000, Fan Wu wrote:
> brcmf_fw_crashed() and the debugfs "reset" entry both schedule
> drvr->bus_reset, whose callback recovers drvr through container_of()
> and dereferences it.

[...]

The patch does not apply cleanly on wl-next/main -- a rebase is needed.

I looked more carefully at the cancel_work_sync-under-lock concern that was
raised in the thread. brcmf_core_bus_reset() never acquires bus_reset_lock,
so there is no deadlock. If the work has already started when
brcmf_bus_cancel_reset_work() is called, cancel_work_sync() waits for it to
finish; by then the reset op (brcmf_pcie_reset) has completed its own
teardown and reinitialized the device, so the subsequent remove teardown acts
on a clean device. The design is correct as submitted; only the rebase is
needed.

Regards,
Arend
