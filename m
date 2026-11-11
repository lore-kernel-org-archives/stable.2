Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378756;
	b=Xz23DIuKUb105nIYi17h1965xtZcTQLJmha5aiCtV91zaoXoErYw7MrkwBs/7Y5epk0y
	 sA5rdhiwnEflUamSqmfb2t/rTBqssOeyDyVkGV+GnIujewaRJjcK0Ax4PPe2iVTRejYdJ
	 75OmGhlYTpYxAQfrZ7+p6PREeTtc3JwkTy8qkkT0fQYToFwgH2GUu6nKaPQnVqcgz4fxO
	 YiXUa02fw3qnmTdPCPhtviUYQQnQZTOU26wr0NMQS7S9cM62UJ599mTuswHq7wl148Pag
	 UE3wvG6HSo5V49vccwWxajKFi+qp9AbSbafOLOHFb5y80Ouptkmiv3EKroOmFJdOk4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iG+inULdiX/9F1jgHvoIofo1nPKwdx5Mas8WwwOmeh8=;
	b=Q4LtR6pqOdC09Mdn410UoPrDRmfLGRvWmbVaelV+tdNEDUhYk2DMlJnIjZe0EysVmKPl
	 gwtU/ELNUDLjnJcHpqrusDOsGa7ZBU3vus+seMdt01Wx6gkKzMFAWmVb8PrVxiJidAaeh
	 WP2snS8dFqoivRKuSSQcZQqgX4uD79U2dX/YR8QVRulYIHNmRuaWu0XHdxpc2FKMrsu5h
	 6hcXDgNXSJpAD+xC1VWuP7biqcprlL1eEmH1+qNQSjnedzRl6nKqcGXzw+gB64YYcM4Si
	 Yjn2+JUGgFJJztVXbuN+wnVPSUFZ6q1KzOeX852nfl0IdCWqLtJQVsi6CcWUodO1Sog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tHlREPoq;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2E606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13C2E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tHlREPoq
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so29707605e9.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794378754; x=1794983554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iG+inULdiX/9F1jgHvoIofo1nPKwdx5Mas8WwwOmeh8=;
        b=tHlREPoqa3VREtd/3FqXEUOQP7wEvLpOjRoM9iujAcGnu2x208KdouZARqXfWc8LUp
         xQPFMmdwxe0xffIOTCemDQi04ZE3O+U7kC7Az5oHwzwHT0Kb/PNDdI8MkPRuIC165xZi
         J9LjxfJQyt7jUVlixwSoVo4Au61L8iJDi0e7wUe4P5RENdlkHX28QizsvyhSScqj7GLA
         9uTuUbaAnv7tzNWvwEHBoa9OD9fTDDsYS71kqMeeJ5Z3BL5Sq6qoectk/JdgJLn9+rnC
         iiHX7XhC2ap7sdO9RGcsPVuCZ+FTEamoYDxeG8NQ80Ij2fqXLNBF/mvJnCFJybSK73Rb
         FWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794378754; x=1794983554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iG+inULdiX/9F1jgHvoIofo1nPKwdx5Mas8WwwOmeh8=;
        b=jqjHXD0SWu5uEToA+XyBLWcLhqZFSkNeA/DialV6AquNsc83kTjbG6xhbLWCpgFrOw
         hK/Y0xWEy1qDhYOHVI7vGX4veysXOfxxADqkeb4nkOWlhInlKDieb2dgssHRWApHjvR1
         TC54t3JkugfX0z+v+GFnVjyjDbQZGiC/878aN8O05DTGHZdScsWRzBLvER4z+teCrfBz
         bchKyRuI0Yty/fUVSASkTTdSLYPNJ3kU4/nkiIQk87H30w67nRuBz5Q/YxhDZNKQNcQD
         9aexxGrAig/SPEHFMSHtkrmtb7g8d+GI13Vx2CXbsN8KqZVoC7hzcnpzd3dI+BtcrjhP
         5oRw==
X-Forwarded-Encrypted: i=1; AL+hErEc6OOzcFqumzqMdogQRysglW3KTpvtUmaFBimOtHqvPPtWn5g4gRy+VgNobhiPdmz5pw5i/Xw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8y0L/wCSdeJn/xJJRFWUQq/O7dnQ6I4orjiTu67VvWgDniB/Ev
	zmVxU9hQORCf4EpAywU8cHsQ0ie7zNqkCOJcujAiz2H326xyo5acAa6r
X-Gm-Gg: AYBFou25/kPb0Uwg30g7xY0EkgizdUu3gTLCT1rwcguOiQ8s1Km9149HhL2Pwg9Fdxw
	5uQWodTZPrmrQPy1B/NHks6WxEG8ocZhHytx7vqtGr2ooyQOErhMLkYrjm97UpDEp4XkHV+gFej
	GNao2wBLSnhkX4ajPCw1tRMTDlLXgw1wRHU5wcghAjAS6m9B/Fq61yYeYRvsf/tpwmO468HTueY
	Wq2hO2i8eMLtht4ouNSkJObDKIyGT4TGVBjG+Y0wjlf3QdCkU0aU303dY/7ICxy5IkiNw9IAioV
	l4Q2tK5Pt1q2t1oKFXyjehDDJh62bCycs9emaETB5oE/FxJRS/tFOv+2d6t+iijCQ9XjtpBNZVR
	4fstvST5uQMgogozN4X5/2ADk3gHR+ZumT5KmBkeGErwUMtXbo+HR1A9H4/llfQoCryMocW05fA
	b5iTcApCwVAM5TRks1lQqhY3Haygps9fU8wnx8XEY80t8LZOxple0KkuCzU13/eMnOrDqAi4C8b
	5yqV+TJ1uhdI4vSZt7KVSf4BSNHSRhjw8dS7Ef34Tzq7I9o8MSZsRDO8Rl8//+/2/8ZjX/aMUpz
	LZnioqrjFC5NHGiajfjGOdLd2ZxLwIOAzOovhHCX1bcGqzYhXNq5Ga6+iBKhZQuiubzmSpubUA=
	=
X-Received: by 2002:a5d:64e3:0:b0:48d:ff71:dd9d with SMTP id ffacd0b85a97d-499c903d741mr1957954f8f.23.1794378754237;
        Tue, 10 Nov 2026 22:32:34 -0800 (PST)
Received: from Sheldon ([185.4.35.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835d2c027sm8981259f8f.24.2026.11.10.22.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:32:33 -0800 (PST)
From: Victor Carreras <vicajilau@gmail.com>
To: rafael@kernel.org,
	hdegoede@redhat.com,
	bhelgaas@google.com,
	lukas@wunner.de
Cc: mika.westerberg@linux.intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: x86: Disable wakeup on MSI MS-1592 and MS-1594 dGPU root port
Date: Wed, 11 Nov 2026 07:32:27 +0100
Message-ID: <20261111063227.14511-1-vicajilau@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAJZ5v0iqOoS8t-5PFeLPuaJrpeByx2Yr-dnpYU2fT6yTb6-7=A@mail.gmail.com>
References: <CAJZ5v0iqOoS8t-5PFeLPuaJrpeByx2Yr-dnpYU2fT6yTb6-7=A@mail.gmail.com>
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

On Mon, Nov 9, 2026 at 8:32 PM Rafael J. Wysocki wrote:
> Please see Sashiko's feedback on this one and let me know what you
> think about it:

Hi Rafael,

Sashiko is right, v2 does not work as intended. Clearing can_wakeup in a
final fixup is undone by pcie_pme_can_wakeup() when the PME service
binds, and in any case acpi_pci_wakeup() and acpi_pci_propagate_wakeup()
only look at adev->wakeup.flags.valid, so _DSW on PEG0 still gets
evaluated, both for the root port itself and when wakeup is propagated
from the dGPU below it.

v3 follows the suggestion: it clears adev->wakeup.flags.valid from a
DECLARE_PCI_FIXUP_EARLY quirk, which runs in pci_setup_device() after
pci_set_acpi_fwnode() and before device_add() calls pci_acpi_setup(),
so pci_acpi_setup() and pci_acpi_cleanup() stay balanced and both
paths skip PEG0. With v3 and the SSDT workaround removed, the root port
and the dGPU reach D3cold on my MS-1594 and the touchpad keeps working
across repeated D3cold cycles. I'm sending it as a reply to this thread.

Thanks,
Victor
