Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9340DB59
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278547; cv=none; b=gGjdMuOsUs+E9EpuYzPayaFMgxcwc5tmPF9Pjram8ys9Gs5xzPDsZ3H100/FnWH3U0l/3Cgvf3QkrDRbTHQkNxHCb/whgS4sANX4WtN8UR9VPfLIgSxRzRo5S7aC5QKYs8R1t/lXNW8v02ypKXu9yFN79p82GMSTKKREEooPLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278547; c=relaxed/simple;
	bh=Q9V/OyxnzpEXhb1+HiEXe9l33vd3hEia2l4gk0QcaEc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OYDuEQzeHo+0GCL1y3fGcesqiCLN6IDRa+c/BMo5ybGFq+9S0AVByTuhskFBtGO0Zkl0AvBbCswAtpGIlEdHT7TdOzmNWb8X+Nlwp2KjuuwE3M/n8nKyjNF6SyFv2/RppDc8Z3wOzAPw68876gI+Sxqt+LdwfVSVP31/QWwRfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyxDHMEw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyRZePYn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyxDHMEw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyRZePYn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790278541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faoj1Myu+9icVQdUpGQqIdpGYG/tK6O2kdZEgu4Y+4w=;
	b=GyxDHMEw9Ice88SdB3avp+QzveJ3pGOAyczCrL8fZYS1/Dq97t5ivMapi+8TW3nZRq6VyW
	5FNLy9PT+NNFpH2cTpWvUYxvaSYgpbBfzMIVjCF6cb7AsQIJxMd5W2fXLSvPAO7jJFj13X
	6/DHU7iyl5eSj33XW/vXNRP2Ik+cPpI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-YHLLZVziPEy2aN-Vb0osrQ-1; Thu, 24 Sep 2026 15:35:39 -0400
X-MC-Unique: YHLLZVziPEy2aN-Vb0osrQ-1
X-Mimecast-MFC-AGG-ID: YHLLZVziPEy2aN-Vb0osrQ_1790278539
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-836caf085e0so2995267b3.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790278539; x=1790883339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=faoj1Myu+9icVQdUpGQqIdpGYG/tK6O2kdZEgu4Y+4w=;
        b=VyRZePYn25jjRwexYbALRmCNDrC9GHE35CcaCAgLOlZW+7zLrq5pMTg0fQFqnnwV6o
         S1Ib5l/u42gL3DK5W3YHUOQcElC844LABzbEdVekhyGlLt79G0WluxQH2KKtCQYqbAbU
         4ljI7FOoVkUAD15VgkXbRHTDh4erudX4Xu9uaP7mHJ4EIQW9zjIkmLn/+sY4koA0quPB
         pSeNpXH29yJjioN+Jllzk42XP9/axysho0IbQ0xjk/IFnYekoMuS7hrO/AdjNZg7o1lP
         f+K8qM6wT//g6iK89IR/LRpDLHrK8C9a5nkFu3YB28R7t2dA17516KYFUHJLjdgmhhgP
         XPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790278539; x=1790883339;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=faoj1Myu+9icVQdUpGQqIdpGYG/tK6O2kdZEgu4Y+4w=;
        b=RJ+qRBUNSuMsBDOMZT0EGSIEw/PB3EHCukZkFZmyvm7s+onP/6LjRm29OsoWq4QpJr
         vzQmTS3OzQjJnb9Se2qbt3ACOh9UbtbyNxmUb/5c5Ql+oxn+vElVMLRLKbaQVxGGRbue
         DKz1wC8h31sV8AW2NgeBmFJ0dhaloHYZrOcdZ+SgjOABW4Gi5lat+HdkdoYS0YlmCAOG
         myFsDrU1LVq5z4yyIOFl4KGILnlOcetD5AJQeI7KPpoYCGY3sETN9jxa1jAKDVrj9qMq
         csqoP2F6Es6pG8DCqRgXscMCcCgOgHD/rgHXE0kuSyvGfdwiBfn9yLRmgqstr235vF2P
         XKAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcLQ+CgBqOv7+YF6uHz0XNu3AMJGNp5KgcnNio+0/A3Lyh0EsJgw2QX6/f3X4fpsr2PR1bFAI=@vger.kernel.org
X-Gm-Message-State: AFuF++ly4INdOb5QEriBVxAU23LWeYbCIO+OSIm26NmAmsKhFfaabVzf
	h/OxNF5fyrg24s7g347fDGwkVQtDeN2CsmIS17LbkWU2MG/+BoSy6Kb2wf9hGIqeXhP8+HtwDJJ
	tntl+9S+6ZK6Q7RrGXoAfefYfVx862az3UmRenwoRJE5c+dl7sAN8nkeQyA==
X-Gm-Gg: AYBFou351eUIOho5/F9Akohk0V+AtJgPHcLfwQdJk9LEFiT7JacB7pznoRSFlzsx75r
	Bz7mo1kawL4D8uLYfcnn23dlYCuk9ZcOuNj6zcaTiO/Rqkc/7X7ntmrHjMJ20HqUloAOnV3mT28
	9TQh0KR0dcYR72iTP2tTn5qgQ1+QBJ6/xPCJuNwXV6KxCG240xcyt56dWGj7LFCJBrmftEw+Hn/
	DJ+kQ2ZhSv72FBzt8OK6yZIXkFcUxqXnmund/Tz+uxCvuCgs2MEqsuN6QVREgIOiKESfjr/XWXT
	5OAV9jjjzEbRMSRRSduC1K8BAFDI7VbffiIvyNrx/SQ82x0MvAHxkDp8OMI+36i7BGMxWBq+uYz
	z75CjJHE=
X-Received: by 2002:a05:690c:e21a:10b0:89b:689d:3a73 with SMTP id 00721157ae682-8a64968736bmr19121817b3.42.1790278539148;
        Thu, 24 Sep 2026 12:35:39 -0700 (PDT)
X-Received: by 2002:a05:690c:e21a:10b0:89b:689d:3a73 with SMTP id 00721157ae682-8a64968736bmr19121737b3.42.1790278538479;
        Thu, 24 Sep 2026 12:35:38 -0700 (PDT)
Received: from [192.168.134.224] ([2600:382:8501:4f43:e566:7498:c7c8:a7ec])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860fbcb2csm997117b3.25.2026.09.24.12.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:35:37 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: Gregory Clement <gregory.clement@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
 linux-hardening@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <AS8P251MB000199E5C86A0447B3FC48EDC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
References: <AS8P251MB000199E5C86A0447B3FC48EDC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] clk: mvebu: ap-cpu-clk: Assign .num before accessing
 .hws
Message-Id: <179027850326.211017.6896107198657392154.b4-ty@b4>
Date: Thu, 24 Sep 2026 15:35:03 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=317; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=90S9+JQ9kh2224ZVg9ldJrz1f/1vkihNmKSNrXDf66s=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLK2Vrf4iC9aYqXVz71kbdH+Ov1saU+nCVp74zj/zdWyX
 mEz/UV/RykLgxgXg6yYIsuSXKOCiNRVtvfuaLLAzGFlAhnCwMUpABO5x8HwP+Xe94k/F3Qz7le/
 aWa/fb275ucvfCwNMmdm2e078PxT8TyG//k/v/++Pquid3fu0QMaWlpS1TdcLl8o4LMx/e64uC9
 zATMA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087


On Sat, 05 Sep 2026 21:48:07 +0100, Aamir Ahmed wrote:
> clk: mvebu: ap-cpu-clk: Assign .num before accessing .hws

Applied, thanks!

[1/1] clk: mvebu: ap-cpu-clk: Assign .num before accessing .hws
      commit: b4243850393f2f24e21b9f4b2c56233e60c904b4

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

