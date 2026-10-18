Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02DD4D0A1D
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340618; cv=none; b=a00bwYzxrt/mwPKp5+iZP2ZgTw9M5oCluDwjsZh2dqh7Sk/zGexCSOGYQjVfUwhhZHzNlP0OaFMRcRdVt7/zXhBwWRgB2z0HBZYEQxoFSBRIpl2dWjko6Wiig1PeBU5Mo6Jh2EHoAp+fcd68HjfQmTr9EqQ0geCTk58D65V9S58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340618; c=relaxed/simple;
	bh=ACJTAtu7mJj/qHLG8YMgtJMB+SSR4aYM27NlxUW9dns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7zbELk4UNrOjnXLb3w4YAYGC2a2ShWS3UiTE0RFHWmd8qPBLJ4gQxdtRCy7Hfs2jEiC9PFmaRSG5AZkyHa6BTIpb61keWmhwbAAW1x2ZsxK1AWGVYVwZES/sGOATCfcqWX41oRVm1yltgApTPMOYds+CRz+W6FHFi5ViB+vt7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7Aqgeyv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7Aqgeyv"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-886e61fa30fso404840b3a.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792340617; x=1792945417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LsdC1ntDUFxSCa8DHZFb/rWt1can9hw1VcMUAe2mXgA=;
        b=G7AqgeyvMXaa+Uj8AtLb+xEPjlZvBNRbO1yAIMVDO5o7miQeIWyiNxSt4vdjwSTjIs
         obGffdts6sizIcfz8U10DjCRHGpxlbUw4SnG76fpHrgRb2iSaf3qKEutnocpWdYi3qw6
         gP3zQjpYqCwU8+qkILovYS9z2t2C8ldozvXpHB8CE2RoivqAJxTtq9CcCMPlhE+Nxhor
         Udz4B67nPX943myk6qJzB3YyuTknZVCjptrMStIRsNi2mQZ60x45DkChOXjgk76eGsDU
         PCsz4egxxd0OaiX0NYBiSKuYbM4k19qyantSIfTVQYiERZImFXcGjtoCkH01Azt4XpvT
         xJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792340617; x=1792945417;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LsdC1ntDUFxSCa8DHZFb/rWt1can9hw1VcMUAe2mXgA=;
        b=RQ+JWJQ5YAO5It9ep02s/eNWbnwfojXPcl9NEucHzPHv616E82hSWY/RjoLM7FxvsG
         NcGAoonhLDtRjiU0ds4uhVIKWCgSiKD/j4KpWmEt5DRqCd0W3n4TYqN1ih/4Sy4fveXe
         Qv/dzC/uPXGGqC0nBh8iTNzdo/ZTpRer/8FoFCjeXGAHV/wJpEgNT4AgJ+Ilm4vA/COs
         SoxqizaW0YQf7imAldzV6/Mqqa9vK4/VreenWEPjZmkpzlQUQheLkG97h1vRUyUY/I5w
         /ainZE3GOW9Wx2WkvObgstPhD5C8YjniYB7BtZ9osoqeokCGjX1/fI97bpdCytwXzAO2
         OJUg==
X-Forwarded-Encrypted: i=1; AKwUvByx88ti7l3RQSwsgJv9IHX8V/3QibUSqRNYmf8xmuUF2bZXaCKSuCZMTPSVA2eE5hLv04iqCQc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAL0JFeplhBtrZ8mUXs3SXgTr7sl5m6urlcnJQMOe8Jov1nPDx
	pt/+yhMuDASwVLwDF0ukofrDNJ/MkJMN+iPSx3+sQK2snD3/B/CigAhzoVkCHA==
X-Gm-Gg: AYBFou2Cswpdq505f0s8LjXminkL1Xhd73Z9XDWbHBBJEuRk28vVyXWtwsyFS50bDk7
	+9s0bQKa1K+m3CGuqTVaKIWJCBfWhBMPZOAs+yrWi+PgFqSPbMBXOPDpH1tEokfBl1T9qTQ5mxg
	qSx0U0dCTMLmDGUZMmeJJInTVct0Lk/whqhKsWVNeoC2a56N2SrnCiy1ifCIMwbdIb3ldT7EQdJ
	aWCO4siiP3qE57PRedFnE/ktUZw9rcmgXZ0JYikXbDfP5cifMlyDdAOtuCCV3ZIgSfFoE142SOH
	4jw7skxzxUsPStxFBaUkKCQL/jXKDV7rugtCvCuCj5FSNM24eOm2zX/H1guTTrNwMMy6LsTovbS
	xwdo2hXv2DFrGCOH1xAsWqx3nhvbLYRqLAIbVPN4NMD1FJHqGkYcGs6OeJXBuA3Utj0qErYoe+s
	4FD0lIFYyeCkt9HofVJp8XpAPfqA66k1PoNTaEjCxN+m4Dek4V+tEWUIDT1eLMhfvcl4IidjNuU
	yXjf5xcedrCZJIYNBKA4+c=
X-Received: by 2002:a05:6a00:4c92:b0:89f:3c81:e733 with SMTP id d2e1a72fcca58-8a04ba3bf1emr3895108b3a.25.1792340616855;
        Sun, 18 Oct 2026 09:23:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89fcd67cf30sm2498542b3a.17.2026.10.18.09.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:23:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 18 Oct 2026 09:23:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tom Verdonck <tom.verdonck@inspiral.be>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (sht4x) Fix torn read of heating_complete in
 heater_enable_show()
Message-ID: <26a02aca-2067-48f8-a26d-2edef878751f@roeck-us.net>
References: <7b2087ccb963e097cf3f6333efaec0c46549003b.1790358356.git.tom.verdonck@inspiral.be>
 <20260928062238.67746-1-tom.verdonck@inspiral.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928062238.67746-1-tom.verdonck@inspiral.be>

On Mon, Sep 28, 2026 at 08:22:38AM +0200, Tom Verdonck wrote:
> Commit 61406e9cac69 ("hwmon: (sht4x) Fix jiffies wraparound in
> heater-ready check") widened ->heating_complete from unsigned long to
> u64. On 32-bit architectures a u64 is no longer loaded and stored
> atomically, so heater_enable_show(), which reads ->heating_complete
> without any locking, can race heater_enable_store() and observe a torn
> value, reporting a wrong heater state.
> 
> Take the hwmon lock in heater_enable_show(), as heater_enable_store()
> already does when it updates ->heating_complete. The other reader,
> sht4x_read_values(), is only reached through the hwmon read callback,
> which the hwmon core already serializes with the same lock.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/cover.1790358356.git.tom.verdonck@inspiral.be?part=3
> Fixes: 61406e9cac69 ("hwmon: (sht4x) Fix jiffies wraparound in heater-ready check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tom Verdonck <tom.verdonck@inspiral.be>
> ---
> Guenter, if the hwmon branch has not gone to Linus yet, feel free to
> squash this into commit 61406e9cac69 ("hwmon: (sht4x) Fix jiffies
> wraparound in heater-ready check") instead.

I'll do that.

Thanks,
Guenter

> 
>  drivers/hwmon/sht4x.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
> index da2b6130fca7..27fddff70354 100644
> --- a/drivers/hwmon/sht4x.c
> +++ b/drivers/hwmon/sht4x.c
> @@ -237,6 +237,8 @@ static ssize_t heater_enable_show(struct device *dev,
>  {
>  	struct sht4x_data *data = dev_get_drvdata(dev);
>  
> +	guard(hwmon_lock)(dev);
> +
>  	return sysfs_emit(buf, "%u\n", time_before64(get_jiffies_64(), data->heating_complete));
>  }
>  
