Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1D4B95B3
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824509; cv=none; b=apWVv+gVceN0c9WzRNVxnFQblbDsdXwTy58tReYzwGXE0QueK6stE4KXg6dcQM1BoDXgjppeQEYaU2gWZih4vd5fmjqf0NkVe3Fw9OdYS9QitFQ1XTNjsYwjj5+rrFksavXEnOraQK5XIgWiT5I5mRGoJA3ozRGrY24uavUQYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824509; c=relaxed/simple;
	bh=mk8XDZoJLrnz28nCgNWfaXENJFPufAikspSQ2eN5odI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoj0aU9Xpf1OhUb7oQogpT88uXEhble+g/VcIYolb7hsCQAhlTqbfwSnA9LHP5XCI/LWGEAZBhaWeZDIK8EcOH48oc4rUji2VqDl9rmdDPLYQQZYoV+ebP95wZGwqpdZ3JvhLxrJGEd6bgzdHU34QqGKiLEVS1VxX8vikv2lIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxnZ/1hr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxnZ/1hr"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6af9a90e4bbso2156703a12.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791824505; x=1792429305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mk8XDZoJLrnz28nCgNWfaXENJFPufAikspSQ2eN5odI=;
        b=XxnZ/1hrslvw2d5+up2S+1Kgq7Ul+LVtCS5ifOO5lXEDhBOIDITrmmkYigNNSC0sDA
         SPZ+FYWiDa2u8FW9ptsZMZ+hduGBIsi1nN5XcvNQKx3N8xBZIHC2AQqcCgAk8FpWVPpe
         PbhVEfjtGPLB+hMOVSOCYN125JmvTzC99UDOUWB4yBdW7kT5c/VCAgUd+/BzvKg8XPJG
         rAL8TBv7EBF0a77YMQIOulgBKsOKt+clz8C92SkNK2FSFwWGMLcQFQ0lCpaRqDa843Qp
         b7vV7QvCaddmcVhquGtiMc99EsLQb8r63FyTy663udcBmZPFVbp8dcFWgYQEUWCYhHXE
         pE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824505; x=1792429305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mk8XDZoJLrnz28nCgNWfaXENJFPufAikspSQ2eN5odI=;
        b=RhyrQgJnplP+Rv8pf9iGpHGNrC/irLJksO6WUm4MuBPi4S5PkG6Ww72GrLvr8ABbyJ
         l0zqPUsfP7ed80pHQ0VAVBI9blpsaknpCciOgQYdqSnxmuWcesSfXQU9EreDGhb3gd3M
         qeWST9jYQtEQzHcau6SFcTiZKCIhCBLYH/iguUHEfp5GYGuPYaAqAYdmU7OKcLhxMSQM
         DZfHF4BxIczVtkRtCLNTaroVxcrxx66CPdcpPeOl5Z3X1NwVTToNRRzIXTy9mkUIPS9a
         qG+DSihnoL8YlD9htY0e7DMRRfn4LwnmPOaCZ8e0y8DSR59RUEG4sdsJZR91wdnGHIE6
         F7Zw==
X-Forwarded-Encrypted: i=1; AKwUvBzNv5brOwCh3706g5ywwRomHC8tV6HGfMIEErW4AoR8P8Rr3u5jW5o4QgLvoEGOkhm49Fvt/ik=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHuyL50onRCfZw7SP+5Uj68d3IWkyZQXnjtjTMgEcju8Ly+YWi
	y51F+38bKmy/1wo4GDXwdnAyrb5v6wALOBzKW7OQi8M8ykDAGfC/+GWG
X-Gm-Gg: AYBFou0enNoTgwZFIMAiXTDsCPcUTuY5nav5etOXaJCFvop7PFyDfk6ue8UNflGFpb5
	2rv2//xt8oqapb2tEAfgqJ8SBcQTZSKJRVdxUY7eJgsGEy1IJIfHcp6V6Ptwaa7wd/blH8bjwHW
	5lbf7KT6Ka3ZdfsROls9YsLM2Tj/zlNGhkm1Jp+ySlmOJ1PgcVbzRaRe25Ssi8TiGIsczjXsk+2
	RnWpupv6vgr2iHNfWYJWb6DHkydKOmVAmlEcz6rubIFucQxem6TI/5v3w3sQfvF7oPLpxzI9iDY
	AzriYDKu6H6BdGJeeES1ziES3F1yteHoQor3pdnNviHJiCmUqcZLQArbrHR5WapKQMjan9KF8M5
	d8x7yNsm+9R57WQIicUMNbwnPYaF55oRSnpqky5dMCRbgVJ3MhCvHvIHk/UIn4oBabssrFxcVKm
	lTFnGMUFzVDD7J20zwCJpCD4UqDstYRMaCsXmY6nSTMWSacKmIQpSzffjzYvuls9+3c0X73sDuX
	7+UVJbNyv7NYeFSfiF+1jFih1koJXoDIQptp9/o
X-Received: by 2002:a05:6402:218d:20b0:6b1:827c:af27 with SMTP id 4fb4d7f45d1cf-6b1827cb0ccmr6636473a12.14.1791824505098;
        Mon, 12 Oct 2026 10:01:45 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b179dfff40sm5093730a12.34.2026.10.12.10.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:01:44 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: Imre Kaloz <kaloz@kernel.org>
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: Re: [PATCH] PCI: Avoid D3 on PLX PEX 8532/8533/8548 downstream ports
Date: Mon, 12 Oct 2026 19:00:57 +0200
Message-ID: <20261012170113.985649-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927105609.8813-1-kaloz@kernel.org>
References: <20260927105609.8813-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Imre,

Tested this on a Sun Ultra 45 with PLX PEX8532 downstream ports and an
LSI SAS1064 controller.

Without the patch, enabling CONFIG_PCIEPORTBUS reproducibly causes a
Cheetah bus-error panic when mptbase probes the controller. The kernel
boots with pcie_port_pm=off.

With this patch, the same kernel and config boot successfully without
pcie_port_pm=off or pcie_ports=compat. The quirk is applied to all five
PEX8532 downstream ports, the LSISAS1064 initializes, and the modular
mptsas/ext4 setup boots through the initramfs normally.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
