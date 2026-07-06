Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1775399D0B
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364783; cv=none; b=J30Y0PBb7uEBzt2TVqQLDIPJ1TAba6AorkGucOIh38pTBUzEIfLSuhEJmVLHPkLembq/05A4yKqMPWqnZjtb0hZLh2IKQtLpckRRP9BqBXtCaG09do7iS+4h2b8rwrcK/J8i2gxt7P+NK2RY5wFYafHJQw62I9FBHATqBE06wMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364783; c=relaxed/simple;
	bh=LrCPJ/QtDYKjWEr9SURf8YATGWYUuKmjnMwYpwXzMCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khjvRdcb5YNN4AWjSXOICWn4cSygW12RupJ6AefxYC9fOHN9q8enANt7UwhWlJN7RIgFnEF+gU+NSyqq7hjTXYGbiumlfdBGoxr7gKkH4jifo3sJMfzYCyDNbS/UEpvQl9PUz08WKbZycrXQpN+lY15msvj6FBZ/fBgO7nns61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NlfB6i22; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NlfB6i22"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-5bef75a83e4so160188e0c.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 12:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783364781; x=1783969581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUr9XqAW3S0CTUcmm68ll/Tep0fc/YKhDOl7KqLiXcE=;
        b=WXAwVLnfO4MCLK63FdN6VsLPm+NMMfDx42JjLhIho09MUvqqvjBPN5O3ISvM6Q/QMU
         M7BBzkU+XFiFn6u3agR5FfioBDXQ1gXrCXNTPJ/LeKquRBoDNwYoYcoKWeTifcQfaqy+
         nL9JZjWNkqUkIkfDeuUQww77orrAea8YzNe47AQRYHfG8k7JfuKz9y32+ljoimhxOcNT
         axuPB0SHAODEXTJLSSKMgwYCiV7ka1w5rcKDEwnMVLMKpjH3pH1hn1LQqmkOvEWQg9lO
         lIQbhB9T+NPPcG2KXU4KMQg0VsgGYqcXN7eHZI8lShWCSgAfwR9tw7HU9C3OCI7S1e3j
         61gQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnR/tUGzgD+jW/9cX0K/NGft2vvMD+bpveZRSyCORlOeMwMIYDJ0nrsALMAbzcoAlNhKBtahY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydu1lU7jHRV+S9d4IjflIWrsLeI7WfuPm0WHayD0wOlR8fvx3P
	GVUkdB+cbDYOg0HH/enX76HZGkI2YXsNhM/ECQDNloQcoWnUofg1ZSybhVZ9e4/pBRISJl1PDbI
	xtR+wSJA2v/0vCKKXJiWXrA7ufurt+zCBu6VC1IsDgpyfCRgUgdfy4gNfRyI3I1nwOHYYNswixl
	u3G+Qrg00oxPx2SkKE47ITN8bF+Q90nmKgAODSv5em04CzbohwSoowQ8NOcA+pW0UNF/nkArFq1
	nfbgE0FII+nKhRggg==
X-Gm-Gg: AfdE7cnfpK+/OG7m8iZOcEG85TNB6HLKo9giE8jmvwjDafF79erY5XLSmNF+k2StuVh
	XZ6oAbapiUdxmZIhvJcpNaSFvH55n4eey/SPY5L37qpIkhcUK7z3lN8uzAXXj542snJHnpNBftK
	67S7gLU1aCjIZck9uZzQpXbiPLqs5QjneFIfIAb7PawdAiTr66KtetdBvSLUzoVKuw6g5BAHCsB
	LJ51YaJe8+SG69GRIMxJEt2V1AMO9IsIQemlTlmU5uyQsRUGOc2m3ST/1qzbcC6Pv1P14hIAiWO
	s3wKWygefjjMHO9X1EK3Ykk2S19pNS8IwawfxEtHgFU4JkiwlVXaPm27xzWOesGXQpsRAIK2L4U
	MR3j0R9cTPRwF19XV4og5uFMT7A+51pvuZvWv3HpBKMmqhJR23uctsPnUdjEz9zYPSW1lj+4eR5
	stdOCpqHiUdR7mqJ+B868vQg+QZGHClIapb7e2gmOnStMsu86GeQ==
X-Received: by 2002:a05:6122:17a3:b0:5bd:aa13:c992 with SMTP id 71dfb90a1353d-5be90903014mr932637e0c.12.1783364780610;
        Mon, 06 Jul 2026 12:06:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5be02b4f050sm1539046e0c.4.2026.07.06.12.06.20
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 12:06:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e4f946461so352640785a.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783364780; x=1783969580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUr9XqAW3S0CTUcmm68ll/Tep0fc/YKhDOl7KqLiXcE=;
        b=NlfB6i22NWKIeCJ1hDH9oUVUoP2qA8CuRnNUkI4mtMewvFei/+bX9WRf0bBioLP/hY
         pxxqgHRQ+ZehoPmRaIgGuUiXhbapIR2ul9cNysMgJvBSikaS7ajtV8E0T1kS8uqxVCRx
         NQe/fMrkyiUQqOsKxsxlfcqsRvWfYC6ab6cQU=
X-Forwarded-Encrypted: i=1; AHgh+RpjKJ0G5hSqloq7yYYwXzJjl3JKvigSUnqyVlfSz4baCb5R4Y4Hg0EX7COJ7S8CNB4YwQCyeKA=@vger.kernel.org
X-Received: by 2002:a05:620a:688a:b0:915:cf88:1e26 with SMTP id af79cd13be357-92ebb5680f7mr255496385a.48.1783364779757;
        Mon, 06 Jul 2026 12:06:19 -0700 (PDT)
X-Received: by 2002:a05:620a:688a:b0:915:cf88:1e26 with SMTP id af79cd13be357-92ebb5680f7mr255489785a.48.1783364779082;
        Mon, 06 Jul 2026 12:06:19 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b800efsm964890985a.4.2026.07.06.12.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:06:18 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Kaixuan Li <kaixuan.li@ntu.edu.sg>,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] wifi: brcmfmac: cyw: fix heap overflow on a short auth frame
Date: Mon,  6 Jul 2026 21:06:11 +0200
Message-ID: <20260706190612.708609-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627131313.3878893-1-maoyixie.tju@gmail.com>
References: <20260627131313.3878893-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Sat, 27 Jun 2026 21:13:13 +0800, Maoyi Xie wrote:
> brcmf_notify_auth_frame_rx() takes the frame length from the firmware
> event and copies the frame body with the management header offset
> subtracted:

[...]

> Reject frames shorter than the management header offset before the copy.
>
> Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")
> Link: https://lore.kernel.org/r/178214417708.2368577.16740907093694208834@maoyixie.com
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/cyw/core.c   | 6 ++++++
>  1 file changed, 6 insertions(+)

Nit: the Link: tag in the commit message is normally added by the
maintainer at apply time, not by the submitter. Please drop it.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
