Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C765477E
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791107165; cv=none; b=T/fyOP0mzWv7VcZorWX9l1px3YGaBeqSoLBX/I04lgTTP4r8Z9323uZmFVqTZb5PjF7VzpDwq05ffJBYxlFCZEVLqiUbJDCnty2iCULNHT1sRS9SHaRSO11IcUKmkIgaByAn3Tzce2/5VMyqvJNz6FVIO4xwXTYNo8ayl02GHw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791107165; c=relaxed/simple;
	bh=u+vYm56YwNMck27Per+ZsEAji+EkicSsZhqAv5T9Xcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeiXMseFjas5quVCDPNBGW0pdI7cfFKojEIklV4+0u4C4WrcuKKaxre/pPR0Kjg6/5HbrDJb5yW6OcOhnAIMOR6IzcwHb28JIe3HgWPPaxziTbxLqvuZoB+03xYtKqzKWvBC1+MGZD7U5n+ATRbwLnlM2+5yFsu1+xZd7pKeZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G8ke1yEF; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G8ke1yEF"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3a0af54af74so216156a91.3
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 02:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791107154; x=1791711954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PyyofAU4SJtVBmzx571gZStp+YRjOTEqsRVPq36CL2U=;
        b=2hhwymbP4z/bTkk36krBl00MDgv8UImFqDw/9ceO9oaWHkyDaXiddyWz93MfsT7fId
         o3BZ/K5cZ2SRMW36A9rCJxwe6eUTGgd9Z7+Lbhv3O6ZM/E/zxCBAg+8Sbo2CWtNWHAca
         qZxmHdbKAqjjstKiIFsCTf/vtDMJHZ24oFaJxowmN8wRJxdSGvwSDlhxydL9z9EcuIB9
         1AbzZkU3hVWHqMEXgJhtfpTMYoaaILQ6ucvJ7lpFtR+lXzwWo9fwrZnRnA4Aq4tkPQOO
         ZatH/W3NEh1KX3WYZn1vMQ/0hMXLA4ci6vTj4Rkh2LRufDbRz7khl3B7EbM6kU2Wmbku
         hsEg==
X-Forwarded-Encrypted: i=1; AKwUvBzpwmwZlSXRj0ajZd2keQml33wMiSF6U5xwGM/IMhRZhube/xymPY19Bfu+PxVJCkXULeLaTtw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkCyh0pWwvOtWsJECg8LgNfm7kzBT38v62c9ykTgffnyBAPuyc
	MY6OtO44o2Xcm7oR/Xfpna9R5UX0nX6qsmI6QZVTrM/C4cNuooDYYAMG4Ce/Q4507AvMZJSiAv/
	fB5CbQJZjKBUaCsqfEAj+DZ7oGPYRntZkGEMg3VrdCZOBKdFKIzhsGpLkN9LHuX5AgRDaYWEQWg
	Uo1vWO4Ira4++U/7LEsSkkhAZx/mezMCpSJIvCBoY82kLEwX6dloNEE1A4tPGZJ6r9HpCot1C/P
	BeTX7TYd3HNhJ9lqA==
X-Gm-Gg: AYBFou1GXwuwdCiBajijkN831LLDfpFjExsAGNCt6JEik7ruwyJ6uwenRiXqfLTbDf+
	tGE+eFWtujy+dMPYd03C6jFJw+7oy0jk07Oz9FUBxgVA9Qj6eL7gkLZbVZ7O3Vz7t4Ckc/rDu0P
	Cq49gM/GmM28dwpXQr+5s4FtXv3E1xu23kTommV/gaZxsJF1HxL+1WJNd9pEG8HqYxHCBMpEMc7
	OzO8ce4YKUjgOx7F6FAnP5LFyWNXiW+ww6uTAEHrWpHQhKa4ieWBK6ic4T7dSCfR7Bp71dsJE5S
	M0GXE3vdrgdyvyxOza7L1TaL+jeYwMw674/zHMWl46WarjsbkCYIT5WXPuZ2q12XnD8+/GGVJNg
	h5if4cN9WHfZEBRL85m6E+26NCAJn3I8ZxVJ9iJtfepH3nfnJxQAvBxhr2UzkibOD9mcAMRQdZs
	AbzlggxOXdi+HtMOz4VD7j4aAd4Zknz3mICyWOS8MBRg==
X-Received: by 2002:a17:90a:c886:b0:3a0:9aa4:f9bf with SMTP id 98e67ed59e1d1-3a6cec13ae6mr6307358a91.12.1791107154230;
        Sun, 04 Oct 2026 02:45:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a78d4dd2c0sm2479974a91.1.2026.10.04.02.45.52
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2026 02:45:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so1648235eec.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 02:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791107151; x=1791711951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PyyofAU4SJtVBmzx571gZStp+YRjOTEqsRVPq36CL2U=;
        b=G8ke1yEFREXyWRwnfYmsdve3/1ZWIWZOYELE6RkNsNtdEDdawXK4oZIq8bLkzrjon/
         JC45idp792Hs4yj0TXJH+Fnqg+KlxntFc0gusOkqN6Dbs3TXx+TSUUoQsk9lWbOSeS2Y
         qAmiByC5Xgz4Xur60bKf93OqlAi/QT1yXl5wo=
X-Forwarded-Encrypted: i=1; AKwUvBw+K+AQLvWc2P4UDkeD67QfU/ddtKR7DRca4jM0HUXmzHDcBlHxMYnXrlkC7sfw8y6lajBfNK8=@vger.kernel.org
X-Received: by 2002:a05:7300:80c4:b0:328:3542:b73e with SMTP id 5a478bee46e88-34f150c28eamr12941731eec.15.1791107150933;
        Sun, 04 Oct 2026 02:45:50 -0700 (PDT)
X-Received: by 2002:a05:7300:80c4:b0:328:3542:b73e with SMTP id 5a478bee46e88-34f150c28eamr12941692eec.15.1791107150271;
        Sun, 04 Oct 2026 02:45:50 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351272d5103sm3595747eec.27.2026.10.04.02.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 02:45:49 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Pengpeng Hou <hppiscas@163.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH v2] wifi: brcmfmac: bound NVRAM comment parsing
Date: Sun,  4 Oct 2026 02:45:45 -0700
Message-ID: <20261004094545.1324258-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260920034414.16948-1-hppiscas@163.com>
References: <20260920034414.16948-1-hppiscas@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Sun, 20 Sep 2026 11:44:14 +0800, Pengpeng Hou wrote:
> The NVRAM comment handler searches for a newline with strchr() even
> though its input is a firmware buffer with an explicit length. A comment
> at the end of an unterminated buffer can make the search read past that
> input.
> 
> Keep the input extent in the parser and use bounded searches for newline
> and NUL. Preserve the full input length: the capped size used to
> allocate the output is not a bound on the input, which may contain more
> than 64KiB of comments. Leave the outer parsing limit unchanged.
> 
> The issue was found by our static-analysis tool.
> 
> Fixes: 3e99b08ab53c ("brcmfmac: enhance nvram processing")
> Cc: stable@vger.kernel.org
> Assisted-by: gpt 5

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Pengpeng Hou <hppiscas@163.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/firmware.c         |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
