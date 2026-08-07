Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9502D7D47
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121532; cv=none; b=X7A2KBicCPZd9MLZyeFBCiRGYDj/aRmpMxLmsLG2l0TrQ9dODVhh+p5JhPdCmfW2MP1CWux+7zCqz5rKRF5aq8xw0qVTeyjXFhZIgI0zvh5hv20hxMlYPvvNGiVWYJLtrJySsuBJTGx7SHi8bPMi2++8lPx4xYZFEMhUDbo3lGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121532; c=relaxed/simple;
	bh=O58BTvrNM2aC7RLe/NA9M4KfX96TgIfxhat39lMlpy0=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mLFh9UIcXX9PZLg8VuJWc/cvUVPneV2Ssbn36RRm9fEJ2nux3+k/tDHKimfyyeTotCK8fLhoUc4s5a7BGtFUXJjNFXxCHi++TVzHlaOSY0GUCUo37k2LoIGrocS6bdQCYU2ESaYZn2So6uQ5liKUJMZR+xiq0Z6o86ARZXKZpI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e4hUl3Fe; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e4hUl3Fe"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2cc61541f8cso26371335ad.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 09:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786121531; x=1786726331;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sK4XYhySCSAmfEvjmTkEI+hN3CX6qZ07+OcZw718arQ=;
        b=SOCmlyDmDlf68Bbp23Boa5j2u7NMmv/N/ZVMKhWDP9rDCUKeedDwk2Ke5O1Vx5KBqb
         7BtMHBFltfsBvA5PtKakuD2Y2/yZZ1vEBWuLdS4Gm5FmBXqIU9lDudA5Rw3IHrI3HXI+
         u6dI3svbWj4I47fS0MiQK37qpgRLRq82mey8/H3U8gZRCFn5kWwb4Mxl3SHdSRyHNXLD
         QDZOfpt1PgJUPvrzWZ2LnfUGCkH646p6ze0YPfS9/8NHvT8d2kiYL8twrFVSkkjqSkWq
         J35lZTaju8hUFdpEccTSZLK5yY6S7lDjq4WHp3cbHjsq7+DkzdEdEZTwDZN2p+ca4QHt
         OqYw==
X-Forwarded-Encrypted: i=1; AHgh+RrZjSk6TqzarcJ6KXhH7ybD5L8MKFnaNBjK+m/UcN2h2J3vfIZyHOzAbCu93BXyzy5Jo83G7zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4O8F8S/P0XSmZt7y5BTSHKXcIqNjjsVZNwl4gGogU8iV+syUN
	4TEtdpeCbQhulz9WOyPCEQ5d5zOBqBRBHdgeTlr8jSt3qITYlnaUjOYUJ9sfIZr526ClkXlwkgk
	SSM3q7xv2mrrh2QnSBYodeyWPxeiyiX3kcnBFBx5vvebWNc2TLNOhnRkdrrESmvSCpODU01TcN5
	oODIxQk0pObvnHVtuM8gC82QAjr9JYJvEOIlVOXp8FKcJTtQc1nujRaMRCIHPK2fKkeuw88zSvq
	IVG0RJGvzsq579LkQ==
X-Gm-Gg: AR+sD10+ODKtelSsXJ/61P6ZrSev7mT9cnbGktSoGAjSyYAtrqEu85tICHgMmdMRRCD
	eOXanwN4JtO0FVZ4XD5C78+sx7EQB8cr5c41/YkmpbhFtX/IyJ0owvbDf6J29LeV2nmXl6+1n8C
	A7y6eF50AHaUuDmam746W/KiHiP5bCcTUbtkbWaVbVQVLPqIcfVSrBeqkWcHCqTooeGITvxBmug
	Dgl4VvQYM1F/WSik0grsAHSNv+RZEqh+91SaePNxTvv0XmXI8unylbm3vC3oczaBEDWO+oN3Ufj
	xCQhZBWLYH7BBap69IOTHm4P5ftHjBCEt2PXr1WdEVXw+gAmJa+HtYyhedi9OZNWokJ2B34Ac/5
	Mi98z16UWy/UVJ4IWLOQMftZ+Gt7GvMahCclyoXq/2VQVYkXiYpgzA5VvdrRebfdzpLNwdsJi7+
	+JjIE0KiP3ygl8PRxRfqF0f8u1fARQ+HczzlG9
X-Received: by 2002:a17:90b:2791:b0:38e:7297:a92e with SMTP id 98e67ed59e1d1-3928465bb5dmr19080a91.9.1786121530395;
        Fri, 07 Aug 2026 09:52:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3925fe8ee28sm1066717a91.3.2026.08.07.09.52.09
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2026 09:52:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cce14a21faso32858275ad.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786121528; x=1786726328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sK4XYhySCSAmfEvjmTkEI+hN3CX6qZ07+OcZw718arQ=;
        b=e4hUl3FejJZoFo0SiVH25+eT/u0KfMe4x9RBNhPQc078ZfBxgf60PXCGQku5zhmH7c
         8vSUiezD4MKui6jx8D9M6LIKNLGCrjQ8rz9CRXhbQ/rThUnUNyES8DP8VsVSMn//iT9a
         htNC9K8z1SF/UeAEmE7VyRAozGq2K0LT5XYVs=
X-Forwarded-Encrypted: i=1; AHgh+Rp9es180abnGsCDA8SJ5qDjD/mNCu6MKGWXcgFLE+zpYS84xwupppVQXp+wj6s0YppxdhrzLc4=@vger.kernel.org
X-Received: by 2002:a17:903:2289:b0:2d2:72b6:556b with SMTP id d9443c01a7336-2d2b2e9258fmr175705ad.13.1786121528498;
        Fri, 07 Aug 2026 09:52:08 -0700 (PDT)
X-Received: by 2002:a17:903:2289:b0:2d2:72b6:556b with SMTP id d9443c01a7336-2d2b2e9258fmr175115ad.13.1786121528066;
        Fri, 07 Aug 2026 09:52:08 -0700 (PDT)
Received: from [10.229.40.14] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm10580276eec.28.2026.08.07.09.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 09:52:07 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Bogdan Nicolae <bogdan.nicolae@gmail.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Date: Fri, 07 Aug 2026 18:52:03 +0200
Message-ID: <19fdd238f38.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20260807163418.487508-1-bogdan.nicolae@gmail.com>
References: <20260807163418.487508-1-bogdan.nicolae@gmail.com>
User-Agent: AquaMail/2.6.0 (build: 200600043)
Subject: Re: [PATCH v6] wifi: brcmfmac: cyw: pass PMKID to firmware if present
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Op 7 augustus 2026 18:37:48 schreef Bogdan Nicolae <bogdan.nicolae@gmail.com>:

> Zero out auth_status on initialization. Otherwise, garbage will
> leak from the stack to the firmware (when ssid is less than 32 bytes
> and/or when params->pmkid is set). Then, pass the params->pmkid to the
> firmware (without it, the firmware caches a garbage PMKID on successful
> authentication and denies a subsequent association request that includes
> the PMKID).
>
> Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE 
> authentication in station mode")
> Signed-off-by: Bogdan Nicolae <bogdan.nicolae@gmail.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Hi Bogdan,

Looks good so my Acked-by: still stands. Thanks for going with the flow.

Regards,
Arend

> ---
> v6: Fixed diff line number
> v5: Fixed line length > 80 chars
> v4: Fixed indentation
> v3: Added Fixes, Cc: stable, and Acked-by tags
> v2: Split into a separate patch
>
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)



