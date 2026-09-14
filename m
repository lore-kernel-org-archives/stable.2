Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0531B389107
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789416298; cv=none; b=DiZYTj2zf/kXHMbCZnoX9+6rJFpNysYzodgd8nooF2AWhhYrCFER9MXJJyM5DxZJDVUBkpf+nfaqwAeHa2uLK7/XcydPnXhgi5m+4Z1ByIeEmQqLtLoAfxuBtLEkIfGQGx5KdBi/OCcK8TPBb9eMe06M/7AS54QMga9Dm52BLak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789416298; c=relaxed/simple;
	bh=vQ5BcgY5sdG1CQBpmPGsw0919m9BDRY1Jb3LHemijU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeUo5UaRv0hLAOjszeLuYdOFX7mdlGtHLG4sXosjJyFFbp24GJl38tDd0flZbEMy0ccDbw5B8ZA6E2clsVhFGSJYPsCpDeLpsRs7DS9gXvj+v/fuDjx4SdcYjb21csDQxhJPpdK1CuJFd0ffLnJNoX4RFHd4pPFNCvX9X+wOE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G9FE+5/o; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G9FE+5/o"
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso576533e0c.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 13:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789416296; x=1790021096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5HCcEwGsZkXP6qM0+jBu8phPLOnSGjxwqZlmClhGp2w=;
        b=PeSCW46bdZGiNFkF0SnkTr5Tv8W01kW2Nipv1waDi+JORnuF0JjK32/Ct/2+AhcFUZ
         v2ZKQceu/01uCLEhyG86oGZ7+qCWnODlFRsOwdylOW/GliSaOB2rSfRE0XpmFhjAALrv
         Scg30rYjqp42s4z06gyhuBdCLayOMVOCrskiAZFVONop+vEH23n5S7/Re9SCdjXKfM3C
         NtAWzTebaxVIYFWVSnvdx5YYUyRkeOH6lZIDuB5P6Gq9B28kbed3vcE6MpejuVKekrzW
         40YrgDt5eXUDTVahunNeLnZ4n24uyNGxG+wj+lwYlctYkZbo0Bd+NacytxhKT/QCZENt
         03zg==
X-Forwarded-Encrypted: i=1; AKwUvBxC63utDRkHJ39RxbDgWBy6OHYsPezBCMSx4q7dQ7M84eBHGDn5o1PJcIzBWAUiBBktEHcFVGo=@vger.kernel.org
X-Gm-Message-State: AFuF++mSyKpxuwgsk8wFhH7gVoxvzyXVm+WUzwbyJcCDIPAxnOzSfAUD
	GYNujCfUNQU1AJy3HF1+bUld/y7Q6cqoCSftPGb6tTv9GaDPeJVEO1hq/eDzNh4Hi6ZQ4GtCCZh
	ibHwBnGitNWULHBAbEmXDVAYxGBog1IuN0J/dGXVMsJ4TLovD5WLYKY7V/lFvkYLwimvbdRuIJA
	aOTQQ+WyFG7/HZw+Zdh4cA+MtaLPjd4zNv1g6YpBkN9y2VN1d7NLCjDXQXD8i6wBVRozqtWJuSX
	mQD3VTpaOXju1n97Q==
X-Gm-Gg: AYBFou1y3eLvJAhAOxJIVY02h3eT6ffF3fxOtyr3anH96GQmBMoeUamoHG30AY7wEhk
	Jc3vjf7RaH6xbf/8qJDs54qNsxJgguiQdyG6KCt4QfAjgbBzTEZFZ71r0RnwWqo0NLYPbrps9ht
	/L8gn/1A2FqcqErElWcNAKb83q1Ru9er7rbvE6DJqYlZhCQlgaR4poBhNS6w3B12LAuKeRWNqpK
	b62kOzKcW7ilG+Wab80NXuE/w6czqRJsypMsl0m5OFoBUzDaoTnIe7ENMqkEY39C84G1vQisuMH
	SWIz3ORSNJC4oxZYYx2lNgerzD0pQ6FxX+hPCSOtrvjJ1QCt8n3FABscxMI0PHE1HjVeJN0PZW4
	NJLyyiT7W/tbj+5Y9Civ8Kdt6dX03G/YRlgQ45gz4q/eUXUSG8aF5ZDCqH8nhzdo=
X-Received: by 2002:a05:6102:510b:b0:778:5369:763d with SMTP id ada2fe7eead31-79b56aec243mr4577266137.1.1789416295714;
        Mon, 14 Sep 2026 13:04:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-7927cadb7b4sm205078137.9.2026.09.14.13.04.55
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2026 13:04:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a0050a554so638040985a.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789416295; x=1790021095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5HCcEwGsZkXP6qM0+jBu8phPLOnSGjxwqZlmClhGp2w=;
        b=G9FE+5/o4+KH2sgkVN1PeyWDIrP3CR6pEHfkcIwxF0GUyYZnwnZVP2y4/UbpoiA8Jm
         1X9sXNanTetdDD/MEmWaVRdC7hukyc8V3y+Fjk5qzE01LZkjuDElnLVazsARWeFILjEe
         PueyHMHulQfXvjmP+u+nq0ax3yVORpPwjrMOo=
X-Forwarded-Encrypted: i=1; AKwUvBxGS+wKNnSVowBJscWCjbZMmXhG87/73Dz9Y0pRnA3ceWB+PL+tqJhsMPbytPjMyAQ+/Q825ow=@vger.kernel.org
X-Received: by 2002:a05:620a:2590:b0:93a:14c:3296 with SMTP id af79cd13be357-93a2985552emr600514185a.15.1789416294918;
        Mon, 14 Sep 2026 13:04:54 -0700 (PDT)
X-Received: by 2002:a05:620a:2590:b0:93a:14c:3296 with SMTP id af79cd13be357-93a2985552emr600505585a.15.1789416294251;
        Mon, 14 Sep 2026 13:04:54 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ebda519bsm1038790085a.26.2026.09.14.13.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:04:53 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Janne Grunau <j@jannau.net>
Cc: Hante Meuleman <meuleman@broadcom.com>,
	Gautam Shukla <gautams@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Pieter-Paul Giesberts <pieterpg@broadcom.com>,
	Jason Huang <jason.huang2@infineon.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload
Date: Mon, 14 Sep 2026 22:04:49 +0200
Message-ID: <20260914200449.1747117-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260912-brcmfmac-4way-handshake-offload-authenticated-event-v1-1-e41a6a8281a2@jannau.net>
References: <20260912-brcmfmac-4way-handshake-offload-authenticated-event-v1-1-e41a6a8281a2@jannau.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Sat, 12 Sep 2026 11:40:51 +0200, Janne Grunau wrote:
> Since commit 416386060 ("Mark authorization completed on driver
> indication during 4-way HS offload") [0] wpa_supplicant expects
> NL80211_CMD_PORT_AUTHORIZED to complete the authentication when the
> driver supports 4-way handshake offload.

In brcmfmac for 4way offload the driver waits for two dongle events before brcmf_is_linkup()
returns true and subsequently brcmf_bss_connect_done() is called to inform wpa_supplicant. At
that time the supplicant did not rely on NL80211_CMD_PORT_AUTHORIZED.

[...]

> Link: https://github.com/zephyrproject-rtos/hostap/commit/41638606054a09867fe3f9a2b5523aa4678cbfa5 [0]
> Link: https://lists.infradead.org/pipermail/hostap/2024-August/042893.html [1]
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2302577 [2]
> Link: https://lore.kernel.org/linux-wireless/20260911065656.1269623-5-Jason.Huang2@infineon.com/ [3]
> Cc: stable@vger.kernel.org
> Fixes: b8a64f0e96c2 ("brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK")

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
