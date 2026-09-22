Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344F503BC4;
	Tue, 22 Sep 2026 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071566; cv=none; b=kCOgPVYVikZBm1obzD+1OfCHWtwtMdilo+OZlWWtgnDqxqJQtQf1e9/kO50eHh4vOtITf6K/sCvDlWohHsmunSrZbDnB5b0A/YFZxLhGqwAXo+qVfBlApgGm197aw/QH2tEQpaVYy0brX/U4DQ/FDrM1Q7yV1mS60l9rKpsjJ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071566; c=relaxed/simple;
	bh=W4nSWtq0rCx2aXdYYlhzNnRlElDXfo22KeIxkEuVqDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwI5Xv7H8lgqoL/hz6SM4trUtuRDMYQwSc6DSGnucWAUPsHLWnLaHlHcf+lm3lznJkc2qqnApqTVnf6rnNj9e8hzFzrT9fS7sMSAdxrjIUgKCCUcFdiCDpCC5l8HpVpgTzoVgSpXTfuWdr9mfdoPa2qJdbkVC3ROm9rqRCRy4Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=eobpKmKk; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="eobpKmKk"
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 7FF85534096D;
	Tue, 22 Sep 2026 12:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1790071553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vYjbKYQm+3MirI28Nbxa57oqPw0EyhcQBOTmEe/lJi0=;
	b=eobpKmKkZJR896nYq1Y2ltBucdT5SJy00Xv7LHr1iectgFlYqUuZchSjKoJJASq8MR23sT
	lKM1bAEplJtA4GtKFnwKf07xm/q1+Y4L+i6CtF6Cn/CYe0lP0NcJcniaig9xVH4j79uAKo
	felpxt3PQDwACXABtD2Iqg9B9llTaiQ=
Message-ID: <049e03e2-3648-4a8a-8959-d88a56545f4d@ixit.cz>
Date: Tue, 22 Sep 2026 12:05:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfc: nci: ignore unexpected CORE_RESET_NTF and
 CORE_RESET_RSP
To: Yuchao Zhang <ndaugoing@gmail.com>, Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260921125805.224979-1-horms@kernel.org>
 <20260922080750.35929-1-ndaugoing@gmail.com>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 xsFNBF5v1x4BEADS3EddwsNsvVAI1XF8uQKbdYPY/GhjaSLziwVnbwv5BGwqB1tfXoHnccoA
 9kTgKAbiXG/CiZFhD6l4WCIskQDKzyQN3JhCUIxh16Xyw0lECI7iqoW9LmMoN1dNKcUmCO9g
 lZxQaOl+1bY/7ttd7DapLh9rmBXJ2lKiMEaIpUwb/Nw0d7Enp4Jy2TpkhPywIpUn8CoJCv3/
 61qbvI9y5utB/UhfMAUXsaAgwEJyGPAqHlC0YZjaTwOu+YQUE3AFzhCbksq95CwDz4U4gdls
 dmv9tkATfu2OmzERZQ6vJTehK0Pu4l5KmCAzYg42I9Dy4E6b17x6NncKbcByQFOXMtG0qVUk
 F1yeeOQUHwu+8t3ZDMBUhCkRL/juuoqLmyDWKMc0hKNNeZ9BNXgB8fXkRLWEUfgDXsFyEkKp
 NxUy5bDRlivf6XfExnikk5kj9l2gGlNQwqROti/46bfbmlmc/a2GM4k8ZyalHNEAdwtXYSpP
 8JJmlbQ7hNTLkc3HQLRsIocN5th/ur7pPMz1Beyp0gbE9GcOceqmdZQB80vJ01XDyCAihf6l
 AMnzwpXZsjqIqH9r7T7tM6tVEVbPSwPt4eZYXSoJijEBC/43TBbmxDX+5+3txRaSCRQrG9dY
 k3mMGM3xJLCps2KnaqMcgUnvb1KdTgEFUZQaItw7HyRd6RppewARAQABzSBEYXZpZCBIZWlk
 ZWxiZXJnIDxkYXZpZEBpeGl0LmN6PsLBlAQTAQgAPgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
 AQIXgBYhBNd6Cc/u3Cu9U6cEdGACP8TTSSByBQJl+KksBQkPDaAOAAoJEGACP8TTSSBy6IAQ
 AMqFqVi9LLxCEcUWBn82ssQGiVSDniKpFE/tp7lMXflwhjD5xoftoWOmMYkiWE86t5x5Fsp7
 afALx7SEDz599F1K1bLnaga+budu55JEAYGudD2WwpLJ0kPzRhqBwGFIx8k6F+goZJzxPDsf
 loAtXQE62UvEKa4KRRcZmF0GGoRsgA7vE7OnV8LMeocdD3eb2CuXLzauHAfdvqF50IfPH/sE
 jbzROiAZU+WgrwU946aOzrN8jVU+Cy8XAccGAZxsmPBfhTY5f2VN1IqvfaRdkKKlmWVJWGw+
 ycFpAEJKFRdfcc5PSjUJcALn5C+hxzL2hBpIZJdfdfStn+DWHXNgBeRDiZj1x6vvyaC43RAb
 VXvRzOQfG4EaMVMIOvBjBA/FtIpb1gtXA42ewhvPnd5RVCqD9YYUxsVpJ9d+XsAy7uib3BsV
 W2idAEsPtoqhVhq8bCUs/G4sC2DdyGZK8MRFDJqciJSUbqA+5z1ZCuE8UOPDpZKiW6H/OuOM
 zDcjh0lOzr4p+/1TSg1PbUh7fQ+nbMuiT044sC1lLtJK0+Zyn0GwhR82oNM4fldNsaHRW42w
 QGD35+eNo5Pvb3We5XRMlBdhFnj7Siggp4J8/PJ6MJvRyC+RIJPGtbdMB2/RxWunFLn87e5w
 UgwR9jPMHAstuTR1yR23c4SIYoQ2fzkrRzuazsFNBF5v1x4BEADnlrbta2WL87BlEOotZUh0
 zXANMrNV15WxexsirLetfqbs0AGCaTRNj+uWlTUDJRXOVIwzmF76Us3I2796+Od2ocNpLheZ
 7EIkq8budtLVd1c06qJ+GMraz51zfgSIazVInNMPk9T6fz0lembji5yEcNPNNBA4sHiFmXfo
 IhepHFOBApjS0CiOPqowYxSTPe/DLcJ/LDwWpTi37doKPhBwlHev1BwVCbrLEIFjY0MLM0aT
 jiBBlyLJaTqvE48gblonu2SGaNmGtkC3VoQUQFcVYDXtlL9CVbNo7BAt5gwPcNqEqkUL60Jh
 FtvVSKyQh6gn7HHsyMtgltjZ3NKjv8S3yQd7zxvCn79tCKwoeNevsvoMq/bzlKxc9QiKaRPO
 aDj3FtW7R/3XoKJBY8Hckyug6uc2qYWRpnuXc0as6S0wfek6gauExUttBKrtSbPPHiuTeNHt
 NsT4+dyvaJtQKPBTbPHkXpTO8e1+YAg7kPj3aKFToE/dakIh8iqUHLNxywDAamRVn8Ha67WO
 AEAA3iklJ49QQk2ZyS1RJ2Ul28ePFDZ3QSr9LoJiOBZv9XkbhXS164iRB7rBZk6ZRVgCz3V6
 hhhjkipYvpJ/fpjXNsVL8jvel1mYNf0a46T4QQDQx4KQj0zXJbC2fFikAtu1AULktF4iEXEI
 rSjFoqhd4euZ+QARAQABwsF8BBgBCAAmAhsMFiEE13oJz+7cK71TpwR0YAI/xNNJIHIFAmX4
 qVAFCQ8NoDIACgkQYAI/xNNJIHKN4A/+Ine2Ii7JiuGITjJkcV6pgKlfwYdEs4eFD1pTRb/K
 5dprUz3QSLP41u9OJQ23HnESMvn31UENk9ffebNoW7WxZ/8cTQY0JY/cgTTrlNXtyAlGbR3/
 3Q/VBJptf04Er7I6TaKAmqWzdVeKTw33LljpkHp02vrbOdylb4JQG/SginLV9purGAFptYRO
 8JNa2J4FAQtQTrfOUjulOWMxy7XRkqK3QqLcPW79/CFn7q1yxamPkpoXUJq9/fVjlhk7P+da
 NYQpe4WQQnktBY29SkFnvfIAwqIVU8ix5Oz8rghuCcAdR7lEJ7hCX9bR0EE05FOXdZy5FWL9
 GHvFa/Opkq3DPmFl/0nt4HJqq1Nwrr+WR6d0414oo1n2hPEllge/6iD3ZYwptTvOFKEw/v0A
 yqOoYSiKX9F7Ko7QO+VnYeVDsDDevKic2T/4GDpcSVd9ipiKxCQvUAzKUH7RUpqDTa+rYurm
 zRKcgRumz2Tc1ouHj6qINlzEe3a5ldctIn/dvR1l2Ko7GBTG+VGp9U5NOAEkGpxHG9yg6eeY
 fFYnMme51H/HKiyUlFiE3yd5LSmv8Dhbf+vsI4x6BOOOq4Iyop/Exavj1owGxW0hpdUGcCl1
 ovlwVPO/6l/XLAmSGwdnGqok5eGZQzSst0tj9RC9O0dXO1TZocOsf0tJ8dR2egX4kxM=
In-Reply-To: <20260922080750.35929-1-ndaugoing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/09/2026 10:07, Yuchao Zhang wrote:
> Commit bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
> added handling of CORE_RESET_NTF in nci_core_reset_ntf_packet(). When
> received, it updates ndev->nci_ver, ndev->manufact_id, and
> ndev->manufact_specific_info, and calls nci_req_complete(ndev,
> NCI_STATUS_OK) to finish the pending reset request.
> 
> However, unlike other notification handlers in ntf.c (which validate
> ndev->state before completing requests), nci_core_reset_ntf_packet()
> does not check whether a core reset request is actually pending.
> If an unsolicited or delayed CORE_RESET_NTF arrives (e.g. after a reset
> command times out or from a misbehaving NFCC), it unconditionally:
> 1. Completes whatever request is currently in-flight (such as CORE_INIT,
>     RF_DISCOVER, or CONN_CREATE) with NCI_STATUS_OK, leading to kernel
>     state desynchronization.
> 2. Overwrites ndev->nci_ver and manufacturer info. Because
>     ndev->nci_ver is used as a selector for subsequent packet formats
>     and parsers (e.g., in nci_open_device() and nci_core_init_rsp_packet()),
>     unexpectedly modifying it can cause protocol format confusion.
> 
> A similar issue exists in nci_core_reset_rsp_packet(): an unexpected or
> delayed response packet can prematurely complete an unrelated in-flight
> request.
> 
> Fix this by ensuring CORE_RESET_NTF and CORE_RESET_RSP are only processed
> by the core layer when a reset command is actively awaiting them:
> - Set NCI_RESET_PENDING in nci_reset_req() when sending CORE_RESET_CMD.
> - In nci_core_reset_rsp_packet(), ignore the response if NCI_RESET_PENDING
>    is not set. If set, clear the flag and complete the request on failure
>    or for NCI 1.x (checking skb->len >= sizeof(*rsp)).
> - In __nci_request(), ensure NCI_RESET_PENDING is cleared upon request
>    completion, cancellation, or timeout.
> - In nci_core_reset_ntf_packet(), skip power-on notifications (trigger
>    0x01, identical in NCI 1.0 and 2.0), then check and clear
>    NCI_RESET_PENDING before updating device fields and completing the
>    request. The CORE_RESET_CMD trigger value is revision-dependent
>    (0x00 in NCI 1.0, 0x02 in NCI 2.0), so both are accepted and gated
>    on NCI_RESET_PENDING alone. If unexpected, log a warning and return
>    0 so driver-specific handlers (such as fdp firmware patch handling)
>    still receive the notification.
> 
> Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
> ---
> v2:
>   - Do not abort the notification pipeline on unexpected CORE_RESET_NTF (return 0
>     instead of -EINVAL), preserving driver-level hooks (e.g. fdp firmware
>     patching) per Simon Horman.
>   - Skip power-on notifications (trigger 0x01, identical in NCI 1.0 and 2.0)
>     while gating both NCI 1.0 (0x00) and NCI 2.0 (0x02) command-triggered resets
>     on NCI_RESET_PENDING alone.
>   - Check NCI_RESET_PENDING in nci_core_reset_rsp_packet() to avoid completing
>     unrelated requests on unexpected responses.
>   - Explicitly check skb->len >= sizeof(*rsp) in nci_core_reset_rsp_packet()
>     for NCI 1.x handling.
Hello Yuchao,

please never send follow-ups as part of the thread. Always send them as a 
separate message (otherwise they may get lost and we already have patchwork wich 
can track the submissions.

Even better, try to use tools such as b4 to submit patches (easier for you, sent 
in expected format for us).

Thanks
David
