Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7A3FC5A4
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760082; cv=none; b=kHC+tRCDL+9Zwb/4nnSp59ZstksCkaEuTnSblRdskD6X5RjMmiVier02QsHxMEVdILDODupnCPRnstDX24vQTogD3Jrp1H1jW0KNAbXFtK6ijhNtdZ4In4RonDoHM8kn7UdgZQ/lgGhpHwM89bgvkTPzOwhZcgmDQOewYJ71ryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760082; c=relaxed/simple;
	bh=5/7hj4hoEQjCkOnCixcXYimdh7QE4er4nfDyqMofnAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saiWuJZxuyHscrDZWqWYnEftPtSmBsyNB+Mi4CZa1hzNFiFMRjFM7EUUr7KTr6Q6C12MKtIOBcjBMc8uOV5r/VupRqWVcBpa18lt2DXOwTAi+ucFveNkkObDJEjS8PqFzJYAu5AtnFvb0EFdqtZhwE+xjrOK1bysecSLnMHG5/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=OuL4Pukw; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="OuL4Pukw"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9063b380982so32447686d6.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 05:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785760080; x=1786364880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cIGzOSmfX5U9v0HP7D+OfyZu9svWo+sYZ2GuaxYoJbk=;
        b=OuL4PukwXtEnGhIgL39HTIn92V4eq/mwUvXuVPuduihmtZL5Dm9207ixXl0J3lwyp9
         WX2GYg/q4p1SvNxa4kudwAgHGHuutfmCDZSgonhp6MCk5XGS63uf1CMxsr4CbjQyWIFj
         y2nMvJWdPfLKPhHafUM8HUyg9KRxJ+Eor0cIPPP0M+sr7R01sxCDxw09Vpd3S/tLkT46
         NxI9qEwgA1YraimMg+BB8V6iwUHASz8USgk0DjE7wHDtD8cjApDzIejTSnBdPZbXrHZk
         8YSBGe6/nBWwTd8Ddxg0wVzD6bwHaBfM54eG8RNtZymp86zXmJvatZt1Uod3moDwwPhn
         63Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785760080; x=1786364880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cIGzOSmfX5U9v0HP7D+OfyZu9svWo+sYZ2GuaxYoJbk=;
        b=r7w4fo9QAQPxYAXEUukPZXLFifbw+jfv0cTjoPVyzY9ZE3qozS/KfA3ylJEzVa73cQ
         wkV2k0g3U6MHIwyF6nhlHJZwUntPRER0oXaLPAvPNxE3U9daEHY9W5gWFTCOU9PPaT+/
         T/t0P7M/+26fBrutFg4FlEWcm8Z+vULTT1UGY5svNkYwLdzRb2GKiz4g+QyM80gjCS9R
         VJCYVuu57q5Izs/ekZeCMtk7v5Fh/63IfGCHA3WbmlGFuMhyzjtyvO5NGlHzIjYM14P8
         mi7PUmB7h+fi9h5DUMU1p6HZRWMiRe1bHl4T0fT67xKLddukKXTM+YMoxZrAbKWmFJiC
         xGaw==
X-Forwarded-Encrypted: i=1; AHgh+RpdkoCJloaPD9NGF+Wk6Wuq2C9TsL8+L6PHcw9i5tIEV6l+L8xT8UVEX5k3kXr0wbImEBASiw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyforupK8EKD92HWnizEtpbtTxKoRAG3Z2JhlS698kyGUhj+c/s
	7vPYNBjZLGrudrv6WuHB0gkCmBNZ+J8GOYTQf3bCBTaYT3l7KJorXaKJkx75c+iOjYY=
X-Gm-Gg: AR+sD13Lb/48VjTYT3fELtk5UAqqFw1nisBB3b7jsdcp70MkATyet5//uw9h60fq/Py
	FUfwqICfsZmaH5WazkJsYnZiZdXggPZiRH+KmiQmov22EnQD+vap7HBw8OvWFcoq1ExTM0KyN4b
	mk5ddVCxiysQmkIYTpcrpuyeIQmFGqQyoIqFQRpopPw4f6mQFcC4uaeAWTR19IdlRt7ZRlLEfis
	jZFOh8hA2Yde3VolvNtBi1Lmg0keRY+qPzRQt7zptS4hYI7iPCU6XEcLTifI8lBRug06nu2XFzJ
	v/zBIHA/e8Z9laXHlrBp/OAsCdyntQWX72EMETiY6jr3J8tMJw1M7KqvOlmWLRgriDI1VIMpN+k
	X1H3fz6uxJdfgINMBTIv1FlU/LkVAA5TUR87lL6W9mLpbpUVfAIoTOtWYoZrPWJdz7uMeIAlX6S
	a+EREyc+i3zV05VtVcbwYApQ6QVVYa6RqjNwF9bs0UqvzkGMXLudfwmPh2CrlmiktcAg==
X-Received: by 2002:a05:6214:29c5:b0:8f3:1770:f731 with SMTP id 6a1803df08f44-9084966cfb4mr210247346d6.15.1785760079795;
        Mon, 03 Aug 2026 05:27:59 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-9084a8386a3sm59397846d6.15.2026.08.03.05.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 05:27:59 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Sven Eckelmann <sven@narfation.org>,
	horms@kernel.org,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net v2] ipv6: prevent in6_dev_get() from resurrecting inet6_dev
Date: Mon,  3 Aug 2026 12:27:57 +0000
Message-ID: <20260803122758.666112-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

in6_dev_get() reads dev->ip6_ptr under RCU and then unconditionally
increments its refcount. Device teardown can clear the pointer and drop
the last reference between these operations. The increment then
resurrects an object whose RCU free has already been queued, so callers
can use it after it is freed.

Use refcount_inc_not_zero() and return NULL when the object has already
reached zero. RCU keeps the memory accessible through the attempted
reference acquisition, and a successful increment pins the object for
the caller.

An independent run on the exact unpatched 6f5156d7a31a (v7.2-rc3)
kernel reproduced the invalid reference acquisition as UID 1000:

  refcount_t: addition on 0; use-after-free.
  ip6_mc_source+0xef4/0x17e0

It was followed by the corresponding reference underflow in
ip6_mc_source(). The supplied trace from the same unpatched revision
additionally shows the access after the RCU read-side section ends:

  BUG: KASAN: slab-use-after-free in mutex_lock+0x76/0xe0
  Write of size 8 at addr ffff888015b50240 by task poc/1219

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Fixes: 8814c4b53381 ("[IPV6] ADDRCONF: Convert addrconf_lock to RCU.")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v2:
- Use the net tree and v2 subject prefixes.
- Preserve Kyle as the author and add David's co-development and
  submission trailers.
- Include the initial refcount warning and identify the unpatched test
  revision.

Ido flagged the corresponding IPv4 issue, which turned out to have a
similar refcount race. in_dev_get() performs a zero-to-one refcount
increment that can be reached through RTM_GETNETCONF.

I reproduced it on an unpatched v7.2-rc5 kernel. It first produced a
refcount warning, followed by a KASAN slab-use-after-free in
inet_netconf_fill_devconf().

I will send a separate patch for IPv4 because this bug was introduced
by a different commit.

Link: https://lore.kernel.org/netdev/20260731135202.566337-1-david.lee@trailofbits.com/

 include/net/addrconf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 8ced27a82..e67642459 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -405,8 +405,8 @@ static inline struct inet6_dev *in6_dev_get(const struct net_device *dev)
 
 	rcu_read_lock();
 	idev = rcu_dereference(dev->ip6_ptr);
-	if (idev)
-		refcount_inc(&idev->refcnt);
+	if (idev && !refcount_inc_not_zero(&idev->refcnt))
+		idev = NULL;
 	rcu_read_unlock();
 	return idev;
 }
