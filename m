Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C5412C06
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527785; cv=pass; b=D6DpbdciwxRbTL++hQytnol6WlPgXwxLq1dRfo+l6i4a8B5njrUDvqcK8T7qyqF0a/ZtaH/O/KWtIdrRjK5dMHbBy6jpAQwDqL+FOjmKB8SBMOcROWW56nk2LrjtqMSOqSajEhecDsJYVXiR4q+/5zY86rA+Zhr1LGegB4IeOQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527785; c=relaxed/simple;
	bh=ve7aPJXVQM2J1syEL+rOQPP0Q7Xevv01p4RL8g43uNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCsE+ekyWMa9GtGwYXF3xQNbohxjx/TwVAS54EWbUyRWW7rEzQ3oeCF3ssogpQF3t5tdoKBNpywYV3T9csmWgUSJlbZvEeFhRtruYA6rLXna0PLGdBufL3/6rWMfViDbTbkLZaJfimtiBHNkOgke3F9TSvWOcGAqCwMB0iCht98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1DOGXQz; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1DOGXQz"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15c42a45adso278856266b.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 02:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786527781; cv=none;
        d=google.com; s=arc-20260327;
        b=IT4QKr9/ml9sodKEtl85cWaZNuiDdK2zIQS9aW7VLdxBi+MTRObXGlwinc2DMdRfZz
         lM7QPfuWCwBwdPV1JqdyIQaJGjUyAE/CtJWuh8KhDGWB2z16wzj0CL8QQAnNcrk3xrGM
         +Sy06vseZBYXbmN1Bv2h/y7MxlSVByfJe34bmMSoWmXvh7sj39hRYL5hZUZzSyssnAlm
         VuVxBriCKM59dsh1s3OyvzavJuT9zaQQcKXbB9lWmzd4LEyXhAQDsHgYGjtz4FlZhfN1
         6EPtDGoC0MqUQ++I4zTwHt/FWiL1WhcBPjSHRqhSqU/yrFoUPJ2Y3krbCnmeDjSUhGkC
         rjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zEhZ73/l3LW0qrfWxddjxawqzrlD2pI0x8CKLdSZgZM=;
        fh=YuVS/vNLNO5PnRPzTvxZZe+B/6D7j1LfRk4t3i3epHQ=;
        b=bb2PQEcrkyk/ULNhHUOJXOKh//LUvk0X2DD0/kET4KruVPY7gPgKOnxDcd1/eHiN6w
         Lxk3FLptQMfVwu8kazjAK7NryauFeRwqE9ffVYuaHLvEIjXMg0w+Ju25Nhf8+pakW6h8
         5XZec1CUCwDmkVafFdltLsqNaYK4ehTBpnzq3fNHe0EPCUgQNCXVRCrnSlfo3yjyyj5K
         wQbE68E7hT2xBZeh3edR7lEOvuA+wh3JMHjQ7GiANsS6gjddGGuADqPsXhDkcpJMfTZK
         Bfi6UW9L+SnyJSqLUyDa1JSQ661S/Xq1AWBGuQ0UVl8P9WWDz16CSTsYWMYXYreTku0y
         dqhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786527781; x=1787132581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zEhZ73/l3LW0qrfWxddjxawqzrlD2pI0x8CKLdSZgZM=;
        b=A1DOGXQzE7oi3kAokfhPR8NcwBT4q5JdvhsyA3ztJlrgdRGVNgPFuDHjHwKYXzLj7h
         23syhrQjICO89kp3dpYKOVJM01lJQYKUz257tbZktZqNYRSrB3emAwYIZMWyACp+ov/n
         D5ggNqfvE3/p8DijJ3jNxWR4VlF75tARY1e7Y6Z7UeeEgdNAUFX0tgl2j3WGBhWVXMNt
         MbZxqwEqTaCeZol5ijS4ukB/+7RirpUBjupT1P1rlT2NMuavIS9ZXJh0CfG5L9M/Bp8K
         j4pOPw7/UVkpIaH+BYdKzB86ZXhWg956LTXBXGaI6DDee7WotBP9nghaqjvgvF+GTReU
         DtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786527781; x=1787132581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zEhZ73/l3LW0qrfWxddjxawqzrlD2pI0x8CKLdSZgZM=;
        b=VS++decF0j3X3xoO1Kw87V/ab4DFjmUzhl/10oF/TbRCEPpU/3wg9jgZ25DMc3eAhc
         Z+CFw2wIMhJ2LcJ0LemJOc+54lTwrVh4o3zMuYQi+D84hntv8uQh9EL3QZtJJPUBD+Bz
         rmz5Wzl5fD+ndksNxyCq+M1UZjuy1wBy42I7zs+jdGNbEENKBda5/avpmDYMwstyXEJg
         PrbIX/9kN60IszFFrQHWglRtVpKgx2P2pw17INRBIbZfPBqY5j1NlzEPP2Q5jq6U+S90
         oFfVov/semcFXqCToZ4RlDbBGDQ9iBGqZA8OEdHF61A4ldwVE4NYiRQHwJOEs9Mw0R5J
         LkOw==
X-Forwarded-Encrypted: i=1; AHgh+RqZhqD4G4ynAyqwioeQJhjbGMepxB/NhI5RC0Tntx/T8PACrHZqdh+sATDSSO8+XfNIrYrILvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCqqiO5tO0EGwW0AP70sWjml5PVvhvMxUQWETvpA7P5ck1lRDw
	SL1p2gJsbmgTyoNLN1MvjbLsfUNSxhetpfhwxuLOW0pfgLXr7j4WipSCEpRgbUhVbvGKT3j4BFh
	fWLIM5fzXTcRAUDxxVitm3hfNFxL4eXY=
X-Gm-Gg: AR+sD13nyRS/NaGG/tpQCPU4WMElcicJ2taT5Zgrz6tExzNeWiAuo10+thneCaU93oU
	PlWMy28LrgjW6roisOrJMmmjlnWZXPcT1HejJ+sBqtpmdpJL/ErrNVu8FnBUi+OdgjR/RHMA4KG
	iZGhVDCSslb132UIXen+5cv8wm5ey12CzdSJlTAUTeEEsJ0jqdhlxxBq7y/gU8iwa/7FXsHNqlQ
	zo3yF9Ct+pyOk7ehhoHHwCEOlc3DeOXSmaCM3aYX6hudyhMyMCmN6srtC8WU2B/I8xwSuva1gj5
	VnnAwExsHrVfJke9ZFQ1GGOjrkz/MN7ZLt6n81FNscgBhpEiddaywvQEwL4ALI8sK0lT/dWSopZ
	SJ0jz6RzGnzVakwrWb9q+LtdouGnG
X-Received: by 2002:a17:907:c510:b0:c15:f55d:f0d8 with SMTP id
 a640c23a62f3a-c20f5080248mr160120966b.4.1786527781423; Wed, 12 Aug 2026
 02:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728132836.41868-1-meatuni001@gmail.com> <28b1e429-39ad-4bc1-aea5-a17def952da3@ixit.cz>
In-Reply-To: <28b1e429-39ad-4bc1-aea5-a17def952da3@ixit.cz>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Wed, 12 Aug 2026 14:42:49 +0500
X-Gm-Features: AUfX_mw2IGBLs-IZzYD31HN-o5sEleYCRUJ5A0oB8oqNnldsCzCKU1VQwAdzs-o
Message-ID: <CADqcGBmqXjyb1PJH=bBZAtuMLM9+GMehtPCGbQ-PNLHZ6VEQ+g@mail.gmail.com>
Subject: Re: [PATCH net v3] nfc: nci: fix use of uninitialized memory in
 NFC-DEP general bytes
To: David Heidelberg <david@ixit.cz>
Cc: =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David, Lek=C3=AB,

After analyzing the caller execution paths and commit history, here are
two technical details worth noting:

1. Fixes tags:
   - 767f19ae698e ("NFC: Implement NCI dep_link_up and dep_link_down")
     introduced the POLL-mode atr_res_len subtraction (2012).
   - a99903ec4566 ("NFC: NCI: Handle Target mode activation")
     refactored the code into nci_store_general_bytes_nfc_dep() and
     added the LISTEN-mode atr_req_len branch (2014).
   Since the fix addresses both branches, including both Fixes tags is
   necessary for proper stable backporting.

2. Return status:
   Returning NCI_STATUS_RF_PROTOCOL_ERROR (as proposed by Lek=C3=AB) is the
   correct behavior. In nci_rf_intf_activated_ntf_packet(), a non-OK
   return value properly skips nci_target_auto_activated(), propagates
   the error via nci_req_complete(), and prevents nfc_tm_activated()
   from firing. Falling through with NCI_STATUS_OK would incorrectly
   treat a malformed ATR as a successful activation.

I have submitted v4 [1], which incorporates the NCI_STATUS_RF_PROTOCOL_ERRO=
R
return value, includes both Fixes tags, and credits Lek=C3=AB with a
Suggested-by tag.

[1] https://lore.kernel.org/all/20260812092423.161497-1-meatuni001@gmail.co=
m/

Thanks,
Muhammad
