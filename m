Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E63B5314
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784838169; cv=none; b=IAhkNsv361iPaGO/yQQZQw32pI05POMVmPKdvW9tRxPWZItONkjsxrVNlslBlSgCZy3E6VepiIi6TyV2cqU/THHOtb1wYTO2F2+ZQy2ZqoJrqkCi8zmmFV6ZrGpUDRPQ21Xkyeq9c9aw1IqL7ec2cQxA7yggK9MOUCrrHfnrTF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784838169; c=relaxed/simple;
	bh=V1hSLIbjJIafMetq/iu7GVV4opdCYHpidy44iIwNch8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISWWVcG42rlLCPnkXIaaIuIuljqLV0+OJec32Eppn4XwRS8JkCG/zSQ6Nb3zE2XxYj/OSnKX/UD/LLthEdn5udJf8awVLp9kV3rSfrEhY6BT1zeHTc1cDUQvEze/royW7OqbRhGl4XfvOEIAGec7hwZTBoHc8XOS9hkX2YTJJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TilODulu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TilODulu"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so885562a91.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 13:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784838168; x=1785442968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RH1XbIQ8E22rKZgx9gpnUFs1WJC3giaIlWrSChX8/Ts=;
        b=TilODulueoL/PJBkHi8xBYdEPsnMCNT50kBf3ENkkPC/+yKfM74WUpIqb1so5fSe0L
         BfflNomGSL0KdJf7B3EvrnuQi4pL02NW2J/x4ONUqibxRoMEoj8QaIgG2qV3VAfdcIse
         Pmy6pPOhFfw/W3vc5j1/OXy9D6LqzpsKNHApmM+HqvEHwYcXNQ5RiUtsUyoDPeyL1ovg
         a9ADAyu5UrbMKg6kOdc2L3fJf6ScvlN4ez//IMr6Thuh9H80Zvd3U2TcirVNVO7E0w6z
         85toKncOq/KSvl1DKYcudcwWWpvdeM+0oE8C+1xxbd4kt7xagBzwq7d/EzS2NqB7EwGE
         UMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784838168; x=1785442968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RH1XbIQ8E22rKZgx9gpnUFs1WJC3giaIlWrSChX8/Ts=;
        b=VFwRJs/NeukYxZVpGesDmdIr7iqvGQy0L0DvmpXhdtMX1VEvnmfU+vvla38b7FT/LP
         e+q64Cp1y83UEAkPw0ReyYCrCHgQTW5Lw1kaybI4xHHk4mvvnBcInREmCxTwETC/aWUb
         A2FwzwUGkR8WdRsmqMMcDFxY8YgLZgWJ7pvmv32R1GC3ip1OK98wI1KQ3IBqpkhsQ+kD
         s6+l3C6Bf5aOCIsI+SVNBBogJPHdh4Sl9bNOhYsYVns1BKA1spdrB8YR/h0R7dRzQB06
         6sjMDF/gwsnKQv22NSj0KKBRfRONJ+bul9jvrAkH4CwjMXhkg3ZFFoJwMuSg9SmLXov0
         y64Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq97mE3H5aXjDVBtLvIHqoRtktg6HvZ2TCpciAVIdK+PlHzbMdcF2A8dgOtGahSrokJG+TeA/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9RofvkmMqn0ahWQ0/DLzbxeiNS2NDNKEACOooJaUNX2l6UpLJ
	1tB3gy+/+DYMQsRIfyr71X8q53OJ4jajb/75RWX263+xh9ec4x9US3ZUIWbLvoCSLqWuZQ==
X-Gm-Gg: AR+sD13VfN/z5DwwFfVKlp4CBm3JTJ+KrO1KQQA1NNrlnuJmIZlAnRs1oifnFDtBFgK
	LtRAIBvUq+JJlorPLPFrELjrwp9Yw/91pFuHxDA3qB6yL0F9SDC/gvt1ilMjFPff1HdmNYwfOL4
	CySB/LNaWPX+1Y96jGW3Qa9zgg2NJZPP2txF+OLsQh/Gk5YjFgiw/1ny8cZyu25ppWO3FWzmQv1
	i8viTF3EbXRvnsoP0RFh2+s9QhSEaqmxClSzbPh76tj4BcsiDcYU4XJX8jR2aKVGJLBMfbyzPfB
	3rgQexyzeRG9FJc6wPwbt+X9DVj1wTtwjkhkwLRTeWHZ0vrFMhGqS1xUzKIK4BN8fon6tSsBeXt
	arrnF9dJBDeS6MftAgIzuchDraWhGEC/kNYv49KBnpuAnIVnWcSN+TGTQn+SdmpUAqfeWWpCP0f
	+U2mIt+F6PazXQ+M96MmUh10xI+x2puSRvhyEEDCUa
X-Received: by 2002:a17:90b:5588:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-38ec6281ddemr4527010a91.0.1784838168031;
        Thu, 23 Jul 2026 13:22:48 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([61.141.241.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f058118f2sm140429a91.1.2026.07.23.13.22.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jul 2026 13:22:47 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Brian Norris <briannorris@chromium.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mwifiex: validate action frame fixed fields
Date: Fri, 24 Jul 2026 04:22:39 +0800
Message-ID: <20260723202239.158-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260723144127.GA234631@francesco-nb>
References: <20260723144127.GA234631@francesco-nb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 23 Jul 2026 at 16:41:27 +0200, Francesco Dolcini wrote:
> I am confused, why is this check needed here, and not done in
> mwifiex_process_mgmt_packet()?

I double-checked the arithmetic and, yes, I made a mistake. The header
check is redundant while the other two checks are needed.

mwifiex_process_mgmt_packet() already validates:

	if (pkt_len < sizeof(struct ieee80211_hdr) + sizeof(pkt_len)) {

After subtracting sizeof(pkt_len), the len passed into
mwifiex_parse_mgmt_packet() is at least sizeof(struct ieee80211_hdr).
So the if (len < sizeof(*ieee_hdr)) guard is redundant.

The remaining two guards check that the category and action_code bytes
are present beyond the header. Keeping these subtype-specific checks in
the parser places them next to the corresponding reads.

I will drop the redundant header check and resend as v3.

Thanks,
Zhao
