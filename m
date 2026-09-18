Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05653370ACE
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789770573; cv=none; b=gd838Qc226F4es2zuecyn2D4m4H6SZPyN7agf35bLWf10L8PwCVkvn8uu6jxGt5we492GNnIDFCZX+vwEBWgPqxob1v8yZnWEzIoDMIag15JrKfsAC2T/lcZAPmq0yZc/5JEawuwtggESto5qYaLJoLwWE1dIqpCEqP1N9syKQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789770573; c=relaxed/simple;
	bh=qJfvIkWQLChcJURKBe1+9TQo1Vq/0W077vbNcPpsImo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mUASKKUWGYsuuoo7CgClSv7qeowys2u5WdK3NPPiurd3v8Ge5u7t+WyRY3KmvHpWzSGtLbRPql6sl2Pa58fhmoJff7/2Ze4LPzzwuM3OSjAPTdhG4o8KCyHq4dUaGPQICqWBG7jnWVHV4sHPZ5CZzmytRXYMHkbxv2rYfJq/Aks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6pEu83f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q9Wd90Ys; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6pEu83f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q9Wd90Ys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789770570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p32LQHLzzMSNCQDrCQVRbQJDsxmVl9uccGFGyZXBagg=;
	b=M6pEu83fRCIQ//8AFNjDsjLI5Juh+vy42LmOsPVEVON9SbLC43G/lIMaliKXbZKSFJTbVR
	6X1Sv6E/C6GbBrF8oYp2StTYkMx0y1syBGV2v1ytnudOQ26/Xd5aE8lU513TAZ52TPe2nT
	WyGSWmCvSCI0kITCZoOqJ1aKd8rVWto=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-JBduspysPpaN9gPQUiwkOQ-1; Fri, 18 Sep 2026 18:29:29 -0400
X-MC-Unique: JBduspysPpaN9gPQUiwkOQ-1
X-Mimecast-MFC-AGG-ID: JBduspysPpaN9gPQUiwkOQ_1789770569
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52dcf1bb6e9so48645971cf.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789770569; x=1790375369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p32LQHLzzMSNCQDrCQVRbQJDsxmVl9uccGFGyZXBagg=;
        b=q9Wd90YsCrPSKBVhyijmaFSfZAHkzSpI+1krsOFFUejQqUreZFEo43pqiCHSmELpP5
         f41Mt2nE7DAzRKKmUb2woGdjAndq1qFE0S7jOaCPGMpzUonU2GdSJISZ6MYNxjN++cK7
         w9OGbr0gHefj6ENmMXWj4eB6dVImN5bA3n0LjoGU34P4yXq0w1nJeimbUeFs8xlUMLRO
         bWs1gjqYQojtuZz8+rAvjBBVrKbB8bDd5oii4hevyAppDWrk68UitZ79Fh9vguxK/FCw
         GnAZC4i7kSlooetYGaIJAZ5nWc7CRbJ55e5NGQjZ1eeJ9CurEYvx4zKzby1XZ8Nuswuj
         oeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789770569; x=1790375369;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p32LQHLzzMSNCQDrCQVRbQJDsxmVl9uccGFGyZXBagg=;
        b=S6CuCHtlo0QYrOSYnXc3097DjVQK/adS3ocHUW+6GUfv13xCRq+zneZ3hKqXZ+ZO9c
         kPBwOmOj/h/+e+WlD6uLNmYgMuUKNUK2RO+TRfc1WXfTBHTL+A+UlUbUxPZYvzTLndvd
         icnESOA2020UuuUziECzdW/B4SgQnmD6aV+EZpNGJL7abo/8tphP9b5IWLyPBkCMjeEP
         5ZrveZu4UgXqWzMPXO368WCg3mRlD0Z1md1d8RjaYlUpH4OzsW5mTwjKW25gnBtGvINE
         zpSomq0Kdyhl/HW2vYdPRfTflgvwGxx0lyqusv4TZ9BH8tS+Zu7Epua6nguqU4eERusH
         wgMw==
X-Forwarded-Encrypted: i=1; AKwUvBxuqHBWYZWgXFMOb4EIa04Qys3Lcezqcb5f2gODE01cTCFL3lHBHELR2Xx6AOlGDfVci9JDFzo=@vger.kernel.org
X-Gm-Message-State: AFuF++mXBuI84gA8lmLtWxfZW+smgsgd7o5gG9qPPyzz63hNSQUjEB9Q
	EA0IHlWEXF7gZA1YAw9GGNaX1E3qhjH1XU63RztFkkKdh3NXyuuLLD2g8BlBVz/vE/9u3BFZDAM
	H/QGQVZ+eTpW6Fp52KJqtwSiKAo4OSjaKs+7mlQAi+D/8wVvJxR77KzU6aw==
X-Gm-Gg: AYBFou297jx5Fy069iQT/no5Wz3XFTb3CXvCr/TUPxIn7U2HzlFxWet9M9caolsBI03
	m6YpLNA3RP7U9Fr6ngoXOEWtmjtSy3fAgmqk6Rvx2v6oCYzrQ8aMykubhwr5FKO3p5ewFT/sCvn
	X3il8+Z+yVEWzb+vxBTRDa1xzFVJs+naOr/INkloRG8bx/nmudXeTUWT7pvc/MpmAI+Sm1D9BsM
	0aveUg7XO9Etqjuyeg6gn22uLJftlo+XiKPW73yKZI2o7naXSIxtnaBP1+RXmchfj4jcF5bHy5t
	R8q4P++Uj8mEVh4TZL8Be6qenQXYZp7Of0kIPSg4bKOP4hyc/7kdua7u/1SgPUcaMYiW0W62nuu
	S/A==
X-Received: by 2002:a05:622a:1115:b0:531:1e4a:8eea with SMTP id d75a77b69052e-5328d0015d9mr129233931cf.32.1789770569018;
        Fri, 18 Sep 2026 15:29:29 -0700 (PDT)
X-Received: by 2002:a05:622a:1115:b0:531:1e4a:8eea with SMTP id d75a77b69052e-5328d0015d9mr129233621cf.32.1789770568655;
        Fri, 18 Sep 2026 15:29:28 -0700 (PDT)
Received: from [10.239.101.46] ([69.43.42.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ae758a61sm7260371cf.26.2026.09.18.15.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 15:29:28 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linusw@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mturquette@baylibre.com, sboyd@kernel.org, stable@vger.kernel.org
In-Reply-To: <20260915070103.1733176-1-vulab@iscas.ac.cn>
References: <20260915070103.1733176-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] clk: versatile: clk-icst: Fix node reference leak in
 of_syscon_icst_setup()
Message-Id: <178977052357.517928.2775331133276610419.b4-ty@b4>
Date: Fri, 18 Sep 2026 18:28:43 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=354; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=C+KFUpRy04Zo8PlhMyOdpcWavq81OHmCgPld83aOHow=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLW7na5kVq75sCanhIhw7Zm1+124rpM7lUH3BpVzy1c5
 HziXGV5RykLgxgXg6yYIsuSXKOCiNRVtvfuaLLAzGFlAhnCwMUpABOx/cPwV0rousCtVRntK5yW
 Ty8slf/jddblmuDt7MiJ7kyz/zOuk2P4X6H1c6ea39vL0XltLBNCmUP3SSqX8tmKqZbd+60afJe
 NGQA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087


On Tue, 15 Sep 2026 07:01:03 +0000, Wentao Liang wrote:
> clk: versatile: clk-icst: Fix node reference leak in of_syscon_icst_setup()

Applied, thanks!

[1/1] clk: versatile: clk-icst: Fix node reference leak in of_syscon_icst_setup()
      commit: c90a50d07f0c38c62ce13a60806ab5e3b841f70f

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

