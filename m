Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794776587;
	b=2N2bDW0vWHieEYqN+5jN327NDJ6KpRs13w/OV5PbE23M096tigyhPnsVxJuRMZEy4rmK
	 QejbMJBeD5Pfp6xNPD5uywis+j6BiYURQUb59iDVfDLBajbPiICsYIoX4gN64hajl77k3
	 rrbyKSAonEqp5pU/mli2YWMWPadsMdIHJSFNwfN3vmEMwzaq5DNdpHYMtd2XUnzi8BJ4u
	 JQ8DPVwMDaT7BizDYiLLTelQtGNxbkAwWjT0YoHTANzf71TnNnEeOLFalkOHsyQtDO1yh
	 w5diStpiaCOGNArfwawFbeyEH8BxH2iV0kA8dyTgk3thyOn5gOXSAk1nPafCqyVmn7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794776587;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=UWIlSlhDqIZVJylV02U3W5JWNr4VF81Iz41rAjFMs+U=;
	b=02blz5/5XQQywEAQBuN493/JDNS5R9eKNNtxVOza/+cIv0sYtdxKO5ITDlY5NmMqxhC4
	 wZ8H1jDZrZhXX20N0lue5K2+T5pis1s04R+zAcGiM3Fp47DaqCzxsUXVKvaO2ctCS6O9o
	 VJsV6HsTyovkF1qAs9YY11CISBO3UilhRbEOV6md/vLSH5PlpxWHFwv1owsRSuJwgR5hZ
	 jKyVxryTCWzk4FqusfOAO7vke02Wkgileoj86W4E2/nMkFc20IopT9yVfv2jFS1Arzal5
	 Dacb+W7KUj07DAUDoXMTISCSefnXNk1vRLiY3RkMtVH3pYXpb74fFHvpvqQhdLqAYKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=P+YkhPYS;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A457606A329
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 21:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A457606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=P+YkhPYS
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cdb628232d2so2368918a12.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 13:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794776587; x=1795381387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWIlSlhDqIZVJylV02U3W5JWNr4VF81Iz41rAjFMs+U=;
        b=ttOpDKZIeKKRpYTYc43LfN7kyARSUq11C1HvG02ujztUbO9HOVuub7ZkEi0yTqjCQX
         XaFz+t2xUGI86zuPPyp+vDWCFMsKQdy6zlg0PXRF6ow0ezSUNJl1F+bg7xVz/rKe+na0
         c9l5aFaIcO1QaX2jNE3e4DYp96FvH5FNm+Hv6fXzO+GChDdLDS9fqxUUd6GPnu3rV9WE
         rwLKhe3nbmkcIIsKILM+xH451Tjg6s0yX9/6yyQBRAqdETREzB/YLqqiQ2rxmM4/G3a2
         7Oq/IMkU1SIIHgIdPQBjI13cHr3CrObNOULaP68Jy1hxRYxDfyYNsorB+/2llSxLq82j
         Ia/g==
X-Forwarded-Encrypted: i=1; AL+hErExMtsGOMaJMlzGwE4nhQ/1+9JoQvn89/cLhCjoYWfAkqpi0ZcV96U2qu1mE2dYah81ugBEj7c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2XBrCQ58TcceP2HApIQB3ftBxs8zSZ/pt35UT6JGzNeD1beCI
	2rW21Rg/u24BLZuYhvZNRyDkQQyi+0cmh+Z9+OP+7WRQ6KJlLRSQBN8tKWN16/JhgaHA60BkK3R
	RA7+Yd5v/+yR+V5Cla9dc/2CmvHcxrKmWDk5hmjo/UM0uSYgBtoRvuS4d6Vt3Oh8y0RxVmhpERc
	uWb97i0LpTzFtHgvZwMoQEsrZcCF2W2s/Aw6zBwoay30CYOKh+p7NRirIhZHCN7n4/zhIlRYpub
	sIUwm0+Z42o2NYVqQ==
X-Gm-Gg: AYBFou29CkTRwB4hn7C5KOdmsLyNSiFMEK34L81rSWYk8N5Hq8lcJu5XLtuJbCM8ts4
	qAECERRKVgLOiWTPWMJOoqlhj77319EDgncIza4vGaRgKRka55Q9i05zBScpTboeRY4HDKCzmU5
	00908q1ytzsfBkTjkKCoDk19R9aQIM76aru26HmY1FOHqiNFy21dPmoyhNbaKxc+hHoA/GX+NPK
	m66CgQ6/t2W9b5IJYYYxTW6MyAObz0yV/CVzlczPc4VLl2dp229HbBFv9saCH8bMnvtanIwzwh5
	kh4WUaTU7uYcACN5Qx0e/XF1ywHy9qFIXwhL2+DjyMepKqK9niH23Qt8J4qu07yyTS6GStghtah
	HIohGs8qbWREZ+QHWXseCHWYoyvHqwE0dcUOJxj3/IzlfyXlRwdhThGeCLkwmcWjPFqbKGtBXuc
	rVg404nAij/JjstgvhMJGICqPtTA2xYzPiPwlWkFnYRg==
X-Received: by 2002:a17:90b:3808:b0:3a0:ca1d:b40d with SMTP id 98e67ed59e1d1-3b1b0d08ec9mr9881824a91.55.1794776586618;
        Sun, 15 Nov 2026 13:03:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1b3a71eb9sm5140932a91.4.2026.11.15.13.03.04
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Nov 2026 13:03:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36d1353fdcdso623958eec.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 13:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794776583; x=1795381383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UWIlSlhDqIZVJylV02U3W5JWNr4VF81Iz41rAjFMs+U=;
        b=P+YkhPYSzjgtIYqyhXYvAz/rsuK2NUWUM/uibW8+kKIILJa7otHrwhb67uVjZymHUH
         h27G9DUzAuoh43yxm6770OxgT97MZ+ll5/Svyfk8Qi6EQN3Q9U1PgXlcaetHjrEfIr2W
         brWj2nYan2HrFcq+OkM/qMjyRV7kkhM5vpIhI=
X-Forwarded-Encrypted: i=1; AL+hErH18ymYDYm9VXp4hVfd91lcg4yoeL346BkdBKEqZRzG4J0F/N39prWzT4lpUkqKtwESD/uxMuE=@vger.kernel.org
X-Received: by 2002:a05:7300:dd03:b0:36a:437a:4c00 with SMTP id 5a478bee46e88-37967314a08mr7970683eec.24.1794776583529;
        Sun, 15 Nov 2026 13:03:03 -0800 (PST)
X-Received: by 2002:a05:7300:dd03:b0:36a:437a:4c00 with SMTP id 5a478bee46e88-37967314a08mr7970660eec.24.1794776582638;
        Sun, 15 Nov 2026 13:03:02 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d3e37sm31068797eec.24.2026.11.15.13.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 13:03:01 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Vitor Soares <ivitro@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH v1] wifi: brcmfmac: skip bus_reset cancel when the work was never initialized
Date: Sun, 15 Nov 2026 22:02:50 +0100
Message-ID: <20261115210253.883721-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020203916.381637-2-ivitro@gmail.com>
References: <20261020203916.381637-2-ivitro@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, 20 Oct 2026 21:39:13 +0100, Vitor Soares <ivitro@gmail.com> wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>
> When the firmware request fails, brcmf_pcie_setup() releases its own
> driver, which runs brcmf_pcie_remove() -> brcmf_bus_cancel_reset_work().
> At that point brcmf_alloc() has set bus_if->drvr, but brcmf_attach() has
> not run, so drvr->bus_reset was never INIT_WORK()ed. cancel_work_sync()
> on the zeroed work then trips WARN_ON(!work->func) in __flush_work():

[...]

> brcmf_bus_schedule_reset() already gates on bus_reset.func for this
> reason. Apply the same check on the cancel side.
>
> Reproduced on a BCM43752 PCIe module with the firmware file absent.
> With this change the same failure path completes without the warning.
>
> Fixes: 43b25879f004 ("wifi: brcmfmac: drain bus_reset work on device removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
