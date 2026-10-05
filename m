Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585F214A84
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217926; cv=none; b=Y1w96h8R9hXtngmPVAN40DeuVNNVQq4uf9xlUPgnF+qXVSQU/1ynB0qAm5+6wYC/bHNrEdtL0HFBbACXkQh/Z7CTBheDzYymybEVTYQv5AOfDUN1nAOkS9MsAI9drrPSor9nD0fJN+qQfdl7nL/mllEwLjVdyQwsABM96Bdp5S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217926; c=relaxed/simple;
	bh=t1p8IXQWCe6JXrYhb1ZRToxX1eE/YXZFtPZX/xQ9J6g=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sqicLL6ZihmYSMYkOA1DwD98fCp9CPWeuzVYZeZu7qNDpS17xkkPwofKseMnHLUAjD0/lOjriOJy6OTBnA8TTLCSCdaIY0p2UPtNHEJ4n6GrXSLcAeN2IlPZc1ODGoG70epNYGZDy0Bv9PZUuQ7mt2DIz5hOFPEOIVRa5y6bIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eOYhOrQU; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eOYhOrQU"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3a7d9d9b67bso110958a91.2
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 09:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791217924; x=1791822724;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ajrYDjtgXCfiLi8lpPhx25OD/gxlpMH/zqd4lkGdZpI=;
        b=QyNFIAqiCGN4dZb3RDlNJlb/x3+TJHhzmi/uxta4Rpu17W7yAiM+tleYTUzggl3AFY
         ukanJxkElcfWtj6JGOGFFUzYvJvY5EwDsn1C9ykQhSqbzDZn4RMbzBOEft0ArNN0L1cS
         pUi5fsudeQe9FZu/B1w4hMUlQKrhXLjopP45Lhg22hrUNmWNwBVrTYAjNCv85b9iTgb9
         auwDJ3Nnd3t08pXFWHE+n3DT7CvrZx5bouXom4lhkfyDqaZg8MC5GkJ0yU6dBEmjiAY4
         nOBQyZndhFozinhTKkPQpWW3cg7q1j53G5X/L+nbAXZYIfq/uY/MYfXX79LWQlKIsSZe
         rYFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQlrCGGf0tDN1QL09krI0f2ZN1ZnzW5JhGWAqHiFMjtqV5MD9B48G53sbmpIl1ExKpqtRV1ZQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSOZ05zdPRdl93K7j87u4/rfmHpGnH6lW++v5plvcUPeqPBcr2
	5yG/BiY/lGUb6tRN1ISpIYFP0ok2zn95oBHmzkSxl+SZIommGnAetkTixl1kB+RGXnqbkSyZS5E
	x7xBJCFwnGX3srVrK1hs0v2KNLm5t+dWVQpKMmFfmP71JZ7LvbtQn/6U2HPx9uRfmi51TdxC0Fb
	b5IVO4gyBC9Q3VxXP4cHQySGmHja+LtJDjIO5DGepYyx8VVFfnxi94/CdCFpn6sx1jk8jE4qKSI
	+lSMOCfS91rUu4=
X-Gm-Gg: AYBFou2YF0lAK7ULfPRQd7aDJ9zEwotrn3mcGK80TrUPhiOwwpBtnUVp3BStVCRCLPb
	DIClwZde9sgoCcjZfY9pzJD80tQbfN8c+l1vkb3JNyxZwzBjCobE5KmnL21CHmB6+xrU1m+eJZ6
	8f7Z8NPPDuq9Su7qwOsC1NDG02Rt+H8uKmfhCA/xWFi0R94SO3CEhjC9HMbXw9Hm3LH+Laj0t1A
	QhI7g9t6cnsH9L9LNyIj8mAUwoM8f4KDlfHTzLrNBkV/941WtMTzoApul4w6pU235yr8sFhI0vk
	6QIUoQu+gZf7n+E6hrW7+5Th8HBXqYh/lSwTQRLyj0CDbq2/GlapBGl/f/xcdxqvNwsBHWuKJgq
	6y6G1t6VoYpY4wc7/tuCAE1+Vjm9pgE4WCNYWbOviLccfxyFFf0dtUjyC3bBL4RsMErv8n1mAlv
	X3qLm9CLYBIE+o1cgC6Y67O2+VJ7ONeYxWoVDnyGQ=
X-Received: by 2002:a17:90b:3ec6:b0:3a4:8c41:facf with SMTP id 98e67ed59e1d1-3a6ce7fe392mr5298041a91.41.1791217923727;
        Mon, 05 Oct 2026 09:32:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a853892b65sm51015a91.3.2026.10.05.09.32.03
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 09:32:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2e49c5ff09so224074766b.1
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791217922; x=1791822722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ajrYDjtgXCfiLi8lpPhx25OD/gxlpMH/zqd4lkGdZpI=;
        b=eOYhOrQUzuJhPoo5k+Uhvq0GfxxgINr6tX7GaKMRI6AASrtdaX9DhfngSgUEAX5Wtw
         YKqnDAcqgGqDD5lxQPSujjLPlc8tvwBfcYtI4uWchiUT7oQUDZUXNfxMou2CQSk40MlB
         ZctPJDvhbEi5fyz334aiR0sByNqERs4AkVng8=
X-Forwarded-Encrypted: i=1; AKwUvByTHXtPfwmo6c2dfHw55moJoSApsIdIvdaSRMuz62bidpo/i5lDGmQqE55Bs+SCSBO0CSeXKCU=@vger.kernel.org
X-Received: by 2002:a17:907:720d:b0:c2d:d202:d1ee with SMTP id a640c23a62f3a-c2e4adaee21mr972821166b.36.1791217921793;
        Mon, 05 Oct 2026 09:32:01 -0700 (PDT)
X-Received: by 2002:a17:907:720d:b0:c2d:d202:d1ee with SMTP id a640c23a62f3a-c2e4adaee21mr972819066b.36.1791217921362;
        Mon, 05 Oct 2026 09:32:01 -0700 (PDT)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31563018d8sm99716966b.51.2026.10.05.09.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 09:32:00 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Nathan Chancellor <nathan@kernel.org>, <linux-wireless@vger.kernel.org>
CC: <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>, <stable@vger.kernel.org>
Date: Mon, 05 Oct 2026 18:31:59 +0200
Message-ID: <1a10ce86418.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20261005-brcmsmac-clang-24-constant-conversion-v1-1-a30c5692d582@kernel.org>
References: <20261005-brcmsmac-clang-24-constant-conversion-v1-1-a30c5692d582@kernel.org>
User-Agent: AquaMail/2.7.0 (build: 200700061)
Subject: Re: [PATCH] wifi: brcmsmac: Adjust txpwrindex value in nphy_ipa_rxcal_gaintbl_2GHz
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Op 5 oktober 2026 12:33:07 schreef Nathan Chancellor <nathan@kernel.org>:

> After a recent change in clang to warn on signed char conversions within
> array initializers [1], there is a warning (or error with
> CONFIG_WERROR=y / W=e) from nphy_ipa_rxcal_gaintbl_2GHz:
>
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:224:18: error: 
>  implicit conversion from 'int' to 's8' (aka 'signed char') changes value 
>  from 128 to -128 [-Werror,-Wconstant-conversion]
>    224 |         {0, 0, 0, 0, 0, 128},
>        |         ~               ^~~
>  1 error generated.

[...]

> Cc: stable@vger.kernel.org
> Fixes: a9533e7ea3c4 ("Staging: Add initial release of brcm80211 - Broadcom 
> 802.11n wireless LAN driver.")
> Link: 
> https://github.com/llvm/llvm-project/commit/a5ef934a8d295dc03be3960f2b3744ec2e53238e 
> [1]
> Link: 
> https://lore.kernel.org/1a107e21b08.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com/ 
> [2]

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)



