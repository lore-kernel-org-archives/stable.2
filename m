Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7794F382287
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364780; cv=none; b=bxHZ6h7h6bzbfuIjD9wx7QiOo0iBl2w38JC/iAbYBuJ04GLd+gkHK8XFKDThhK4m94nlORlLYJuIHyhK9GKjowvfPoir57CnH/fg6HIaZ7bxKB0qHL3UhlJXOecSP8SWNNU/Ba0J32xsxfo7BUBO2c8VWR2etCcyAIMuB1PHjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364780; c=relaxed/simple;
	bh=KvPjYSetF/yUEo5b4twvRTste5FXr5R4057h569+x1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwYvj9TDRRgRzNwNVBpDroZgptdntZCF6OVtdf9sYC25IuYrCDixjOZAVPO39lhLtZndn8YGDf/sCGAfKE5wuiKo6alRPlE0/O+G0IgEyZFhOgp48i5urYlq5c300JsHLI4Y4zjxvmys4DI4SOLB10yiiF9ET3fiJVP2tSwlnCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SJd/NXAJ; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SJd/NXAJ"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2cacf197759so53769725ad.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 12:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783364779; x=1783969579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ic1Z9t9IaQ7A2sjcuIlUdtXhSR+9iAL555xfaUA/Ru0=;
        b=abJ3R/eW5cg9ZcyPbFFQXP0Xp6Ekk5c7p+eO0Rm0g+gL7Bj2wAgy5orIPDubZtSsbH
         5lDSq+knPke0aYCVS+5/Wq26rNR786OFQG7uYzg8QKBPiGgQzm2J0sbGHTtqQrIBqzIq
         m0HQ1WFwVsHZJJtgXoRumo0o+EuogMlKmI9c6BWuu0jfmiNXFfak4TJm20Za9nNCQMJ6
         e3O0Mk/1um7qV/MIcax7dXlQqY+DCLnmHBcAW0mWTuWzdeD6bciHfa/540VGFAcJQTWP
         0b8CHJzcEQ9H7l8/5h7ilSNb2Zfp6XkhFA8XDLXys7CvXxvjwt5XZARhrGp5aSfaw3Xt
         dzFQ==
X-Forwarded-Encrypted: i=1; AHgh+RrShIidPVvfuJVLgzSBRtNG06yrH2pjhhyujDlKJUKqjsGn9P+F3tq94p0+T74q1d/7/m5bLyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO04h4mFA9QLur15OcvMPHVCx9eRWGG+2a/kca+7HGivuch1Z0
	cZJ1EMXfgvpRlwQlp/fZ7uIq8RYe1Y7UEFXkpj2OrrNtGWQcHdGnwn7ISkO68YOly0mdpb1qdB4
	G7Lp68bu/25QMbhW8Qd82pJOkccKXRzlhlXGgj2DS9540NoObI1QJqpEGqeA9EGMReDEOzPjn9K
	EG69SUhL7jS8qQo9/vL2pSkbzzRVR8MbIptmr5uMXBHa1kDYgJTwm8DkG+tPhfDPY1mkmXBwAOS
	GJrq8PjfODdI+dP/w==
X-Gm-Gg: AfdE7cndXUn78MiMInURHY0f0WhmrzOjfDH5Ts7dDtOuxwT3cQvSERQ1/t9NaXnL7YO
	h3K3eiB1zMTfkyEqn7v95DW3y0F3GB0SdRglnelXaSchjvar4warFoCMZSNR3ODA1+bdAIgSh9w
	fJ+QxvI1llX9VlMGg7N6dZhGuXINMTHjEpnrWdEcLoDHnlwNLs+Dnjx/n0RpSouPEnv++i70qwE
	/r14McqVU+Zr0oAm19KBLvBkI9F/aIpHrLZHOx74W74bQXnBxfqsxdGjKBJcGD0gmqz67A855kR
	HF+GOpdRai5zuvkzfZ3HwZfUGweS7p2qxhzNOXEMdnW2RpmLqKBJnOqjqhK2ESWyfLxQHfTl31w
	OwPQHDF3AW9Zz4xEkLsYTdIktcePAfMv72edLDDSJ3sYwdK+A25wzjhNjqeMnCIbuaMrTMhGoZ5
	Fu6valxiy5isH3wseaGrxliQ2R/bGR934WyNtFfTPVQ4ZRFoabMu7l
X-Received: by 2002:a17:903:2f84:b0:2ca:d31e:ac50 with SMTP id d9443c01a7336-2ccbe72a00emr20395585ad.17.1783364778594;
        Mon, 06 Jul 2026 12:06:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2cad6efd79fsm9495455ad.12.2026.07.06.12.06.18
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 12:06:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92158791d14so349676585a.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783364777; x=1783969577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ic1Z9t9IaQ7A2sjcuIlUdtXhSR+9iAL555xfaUA/Ru0=;
        b=SJd/NXAJQyWCkIpOY8pniZlFffEYwzHmfin8Usp0mN/dQIwmhV7wF6ScyZKTdaRqlv
         C0Bu/rx1FMmz0Qyw2OE+ZPfAngP67uptUfuZPAZVkhanQjWsZepYGdl3UTHOls2nF7Zb
         xppKglO81COn6ggBgoawCY4hWgIYSYYv0mfkw=
X-Forwarded-Encrypted: i=1; AHgh+Rq7K3CDE02KzRw9mLCRm8g9/rH5YZElPUo/hRJE3MCDJUCqJIyvtjvudoTspNFr+bXs6bykwGc=@vger.kernel.org
X-Received: by 2002:a05:620a:2908:b0:92e:6430:3c73 with SMTP id af79cd13be357-92ebb566320mr270472785a.21.1783364777309;
        Mon, 06 Jul 2026 12:06:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2908:b0:92e:6430:3c73 with SMTP id af79cd13be357-92ebb566320mr270466385a.21.1783364776661;
        Mon, 06 Jul 2026 12:06:16 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b800efsm964890985a.4.2026.07.06.12.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:06:16 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Kalle Valo <kvalo@kernel.org>,
	Pieter-Paul Giesberts <pieterpg@broadcom.com>,
	Hante Meuleman <meuleman@broadcom.com>,
	Daniel Kim <dekim@broadcom.com>,
	Franky Lin <frankyl@broadcom.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH wireless] wifi: brcmfmac: initialize SDIO data work before cleanup
Date: Mon,  6 Jul 2026 21:06:10 +0200
Message-ID: <20260706190612.708609-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619064401.1048976-1-runyu.xiao@seu.edu.cn>
References: <20260619064401.1048976-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Fri, 19 Jun 2026 14:44:01 +0800, Runyu Xiao wrote:
> brcmf_sdio_probe() stores the newly allocated bus in sdiodev->bus before
> allocating the ordered workqueue. If that allocation fails, the function
> jumps to fail and calls brcmf_sdio_remove().
>
> brcmf_sdio_remove() unconditionally cancels bus->datawork. Initialize the
> work item before the first failure path that can reach brcmf_sdio_remove(),
> so the cleanup path always observes a valid work object.

[...]

> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
