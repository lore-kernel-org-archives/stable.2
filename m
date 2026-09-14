Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BFD39F165
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411406; cv=none; b=XcUxKiKJ4LHqqUgbZFJzhwPNK1ntYw0W4zIwumE4ZeE+TO0xNr5xAqXfcceZe9RgPRSjapkcr+mvsvK3z0KUbEbnldt+qkIK7DustTeNOk9+XvyTuD8rZgm1fjISurbVIJoY0sofloscBpq6ntlJw6H9m6LA3UcOFZ5PKowkulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411406; c=relaxed/simple;
	bh=mtWjlL6opbGn5Z01q2KziQo4eyqJ4qENxxukKPKDwso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etXjKo5QOze/EYp2xlBcMsNmkmPHGpb2S5V6uDB86IonhaFWTcAc/C4rv3sf5dh4YBDadeUDLBdOPqCBaxjpMJUvFVCEAj4S2FpCKB41wns65pVOy4c/zXNviKDxka2ihhwB3uiaBuVy5C9YECvZh91fgstsVxmq5QDrHHuCnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TootGZae; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TootGZae"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-86a1aeec07aso417263b3a.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789411399; x=1790016199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TRYv25iRu9fFTWg27vlxcds24V+T7PCoVZa9yNuXC2A=;
        b=UBSh8IRuneWTUk7VF/tJTkZkdGvDQl/B4SIzGKeAl0BOJfoMG2n4SAJaQz4aLOYvOH
         pJi5QrHVeunHGKf5sttrwtOkczP1PbRkvjeCgpakTHLdNKFBsRC+jRVaq1w1RuJ6z85A
         4oW96q14736GgDxLs0zr40S9GoEvSnWuhNDHZlSVcRXFDLQ/FbLl87H9yS00tavpVkIc
         30Y+e7KFURdBYDA6V/XTmUeL803ujo6bivd9FtfmSm53VoVuf2pjOe8mFLcaCoxdlt9B
         R1T1DBrHPgd9YUu9LFmhAse6VuQLQxUlytFAlUNQAEnalfmblN71BMiRRm5oFrQYWZbG
         AilQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDGh2cJKgxdAIg68G3cbOwuSZms5EKiTswl+ZURgSjZUj8QBSecvS7zuWN7Kmegy+Qi2Vjryo=@vger.kernel.org
X-Gm-Message-State: AFuF++m/umOOJFR3CqYlO5GKn9SB43toRtVZ4AWacEPZnK7SZNBBEFSw
	DHmwJRUuaJI27CwJmPTo4R0Lj840/FfJ25latW5wpW3tfl6+ZOLBbjDmlOnB/6cEX/BfKZOSp+W
	oj37a7SKVpZsHldj8j8Vfg2QqZQ5ocYxxX04lg/san+93ACph+cgyQFsthyz10G2g9DWMzcCgG4
	3NUVKLSdxwjgr0WjJkk+EnyALsyIlRFp3CyMIOwv8SRqRlEMVMzB+yKDyHOHYZ6eZ0GR6Fbg3gh
	o7wjbNG6YPiKqM9CjpD
X-Gm-Gg: AYBFou20/UstJy+xka94OnSbZCA63I4vws97CAi6loWowhZlZ9Cib8KuzT59j2eqBjr
	M0N8be4Oiiwfc8TxKGIu2fMNohVW/5OfwYUVG2JH8d/ZfE/NKn2I49n99ou2FKPh2ys0txH7dAV
	WoKt6PXb20TI4mdJXlOvnRMjIvpPtHrsdiiEnAzRimL7lLxiomEa9Q5oRCupG3fG7OT5P2JPhWn
	oTM6rIrAJZ8dq9I6quLAUXLqTTcshArNFYLy3Jfv1ukHOiKTPhMtTsJ/o8k2QuhbfSHtdt2YSQx
	Mwv98bA1g5cd4UgcEoLYBYSR2/eA5YDOC1YliQuBilrIrZ8EPVa49D2a/fRuNVI73PHX9XK2WEo
	dtcu3uhe5T8e/AkVshTzN3sPLFe64SyNUcwzvS9iuiLpovW4SfMX4Z44sx2GJjRQ/KP7x6Xhn6Q
	hXUAaJUOrpOPwD7ouxhuHMaZg6JKhWkk5IDXNcajk=
X-Received: by 2002:a05:6a00:6017:b0:86e:9f:fd0a with SMTP id d2e1a72fcca58-86f804ca252mr8538544b3a.0.1789411398900;
        Mon, 14 Sep 2026 11:43:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc4d618e52fsm3713248a12.0.2026.09.14.11.43.18
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2026 11:43:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso2822368a12.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789411397; x=1790016197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TRYv25iRu9fFTWg27vlxcds24V+T7PCoVZa9yNuXC2A=;
        b=TootGZae418iEWKwoGbK1fPI2ZYlJkNzuAhVdImGQwg1LnzMnWlXCwsrYJqpl9l4Uz
         wIXLzwJXdfeNqX22NnS/omHPJvj8SDiK9X8S4gNVWqzCaH4cx9ZwX0F32FW7tWmXeg19
         9UzCS6M8MXXj8QoI0GfMDFdJjJeHZx4nGkueo=
X-Forwarded-Encrypted: i=1; AKwUvBzya8CMcXODJBCDoinJ/NLxDcsNjsmgnofhsilBIHuDXwR6OIsdiy7Af7/e/gs/BCCeWIb74SQ=@vger.kernel.org
X-Received: by 2002:a05:6a20:a11d:b0:3d3:adbf:7783 with SMTP id adf61e73a8af0-3db40672d49mr8756118637.24.1789411396993;
        Mon, 14 Sep 2026 11:43:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11d:b0:3d3:adbf:7783 with SMTP id adf61e73a8af0-3db40672d49mr8756051637.24.1789411396577;
        Mon, 14 Sep 2026 11:43:16 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b347e6sm24621139c88.4.2026.09.14.11.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 11:43:16 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org,
	kees@kernel.org,
	linville@tuxdriver.com,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmsmac: fix UAF in brcms_free_timer()
Date: Mon, 14 Sep 2026 20:43:11 +0200
Message-ID: <20260914184311.1477250-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260815121043.938414-1-yijiangshan@kylinos.cn>
References: <20260815121043.938414-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Sat, 15 Aug 2026 20:10:43 +0800, Jiangshan Yi wrote:
> brcms_free_timer() calls brcms_del_timer() which uses the non-synchronous
> cancel_delayed_work() to cancel the timer's underlying delayed work.  If
> the work callback (_brcms_timer) is already running, cancel_delayed_work()
> returns false without waiting, and brcms_free_timer() proceeds to kfree(t)
> while the callback still accesses t through container_of().
>
> Add an explicit cancel_delayed_work_sync() after brcms_del_timer() to
> guarantee that any in-flight callback has completed before the timer
> structure is freed.
>
> Fixes: 5b435de0d786 ("net: wireless: add brcm80211 drivers")
> Cc: stable@vger.kernel.org


Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  .../net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c    | 4 ++++
>  1 file changed, 4 insertions(+)
