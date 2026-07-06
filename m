Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569EC3BE178
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373566; cv=none; b=OLLFXhA/jcP2ZhwrAwmwneAW7N2J3nNYvoYastm/vDwNNW9404kvLA412gCtlwXNIE5+BOij+COF8pOrGD6BSwkfQHDV1Gbw2/AK0x/JSGgvr0Munj2DmDkBu3/JbzAVwwgt6TSRxTDAk8w5fHrqNenfVOYzGa7E504d5JbOCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373566; c=relaxed/simple;
	bh=5kGN5o/zEXQARF41Fe2bQKp8S/R/99G74XpkHYXo/DQ=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=rYErNo/mbBRELZGoQMNXjmlcPLJJGYG0K1IiEiWFTKUBSIy2u+Oe34n5fB7ypQSz/Ox1UD+aUh3o6Qj3R9QQcEev86FrDNprkhicDw1rlRi5TNvewnXZok8lQ/Dgg3R59iDaUV8gtTHzP+aGpX4g1TeT+HxsIaWGW1XRF4fnYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMo8rtQk; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMo8rtQk"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-495b8120909so4203220b6e.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 14:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783373564; x=1783978364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5kGN5o/zEXQARF41Fe2bQKp8S/R/99G74XpkHYXo/DQ=;
        b=YMo8rtQkizIwz6F0p8PsSfV4nRGHz7BGtx3TrW4I5c/2K3DhZ8ROKeksOnrS/7GCHp
         07ryGMRaYX9KOFd2KSNN6lr1229lxyqQdX513PbFCUVrLoYoYbz0iZehiY/a9yl7LprI
         HRPdn30wrCZNVvDmI/ZdlCn5zR7tf20CWC/jUIhNq1R7mbvOUgx4N6daHSJdieE857mC
         y/NzN+RyPyI7QkSXLgjemORPlqIA7OH+DScSDLaQSbB+4tJyKck+L3Cpz8czbIh++LMZ
         qNvQKPYqAEO7WmkS9nzpsehV90B8vTDF9+tovI56s0GtC3tu12qC3apVjTCR4m5eDfqt
         cNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373564; x=1783978364;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kGN5o/zEXQARF41Fe2bQKp8S/R/99G74XpkHYXo/DQ=;
        b=LODTU8vbW3pNul/NwXPM/OdajW7cm46lRNKYzRnbapnFi91RSzxEvX8TtPFQaUMY/g
         EGHvr8ohLLCrikf9xW5lTK5dQQhXcKXOfO22DUVL+i2oI0NchQLKUmIQ182A36esaYBz
         qomAJ07mzX7oHqI98cOUgdK4rC1Ks3C/h+HXpxOMCWRoMs17n4OvWxGw4T0uKBDoqtlm
         CjaKisWPFMhfHr5X9YdNqyOO0ymsxOXm5fuxeGOyor5dHwwwYhLOq1SvtBmmZDW7qO1A
         ddED73xClCsmUqXDqqwlRBy17twzBMgufROXcDkmacFfD4PIFRvUTIu1LUsnHL+sGZxG
         wgXQ==
X-Gm-Message-State: AOJu0YwNxs4P4v5QbJgYTPE3YKYa4vZvz4TLWoW3uj9REyKLIMko1jsj
	VImd1Wo30ntpQU8s08/Q9VXQ5ByFNpt/BMb5Rq/vcBQ3jDStN4InTQ+RNAet5V3PZrXojeRWkhv
	VriorZEkeZdUVzj9GbD+Ip//eKQ==
X-Received: from ilb17-n2.prod.google.com ([2002:a05:6e02:5311:20b0:503:5897:39ce])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4fea:b0:497:da7f:179e with SMTP id 5614622812f47-49fde9fed6amr1716488b6e.38.1783373564250;
 Mon, 06 Jul 2026 14:32:44 -0700 (PDT)
Date: Mon, 06 Jul 2026 21:32:43 +0000
In-Reply-To: <stable-reply-arm64-vhe-66-20260701193800@kernel.org> (message
 from Sasha Levin on Wed,  1 Jul 2026 20:38:35 -0400)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntmrw36byc.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 0/5] Backport ARM64 VHE boot fixes to 6.6.y
From: Colton Lewis <coltonlewis@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mizhang@google.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Sasha, thanks for reviewing.

Sasha Levin <sashal@kernel.org> writes:

>> This series backports VHE CPU boot fixes to the 6.6.y stable branch.

>> These fixes are already present in the 6.12.y stable branch (and
>> newer), but are missing in 6.6.y. They are required to enable booting
>> L1 guests with nested virtualization enabled (kvm-arm.mode=nested).

> Ugh, yes, the sha1s don't make sense.

> While respinning, please also consider whether upstream 3855a7b91d42
> ("KVM: arm64: Initialize SCTLR_EL1 in __kvm_hyp_init_cpu()") should
> join the series.

That's a small commit so it shouldn't be any trouble to add it.


> --
> Thanks,
> Sasha
