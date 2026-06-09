Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB03F0A96
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016884; cv=none; b=Fp77q4pZeCntr7iQQKuEwFr/5Drbnpx7+05GFNq4U6watcBERJgq+uws8sAJM4tSi3Wr1LZLIvlfNv3Acdomj8VVTe2kI2ptVdYdeUyy1kNazV4ejoHaVbhh8aAAACsLFpRr6/yXYw/dxidZEicVonrSf2rSVi+pV0dMCXL1Mqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016884; c=relaxed/simple;
	bh=qgv+wZWNK0Mz6GS1G2Fzoaat4uwNiLXjksBqYIHiD9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZfdOKJ8hOYjyrnYI2sXrUulO/LnGv8Gx/gL6KoDgqWEGoN6hMrZLbrJLbGPrjbVXr2Hx0mubjHSYDwQRQyIeUXdysUiwJg9dBV2QmbNOPLHxFLt9Zcj3rAuh4BE9GLr/V9+LxEAtu6ay4Q3bBpjz5vglPdmwTaPZFI8KC9ZIGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldR2+xig; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldR2+xig"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa5be9ab1aso5315061e87.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781016881; x=1781621681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvVZVpbZQ11FZGvsMbCfSWDPxvbVcumrUGTwFQKsLlw=;
        b=ldR2+xigwPJxfJ4NxPTy2V0Iouo7vJk5LJg1fLUww6Qn+hZR7eY10tYqvYae+1blmF
         UJkKDLmvVTdapqmurt5Hir+6Ef6Whh543baonrNbX6hM+XBT3irtEMiTK/uqJtqEkd9h
         fMC/RfCmhAfF4i1rm5qsk3odcEsJ466i0hrbV5NyQ9vIGPChpdoqYw8MIORj9MkvkGFt
         Dw6Zmd81Z7Yz6fa1EA8PkIMRZemfD2uXvaBEg2oxPWkS2Qkl26xWX8PPDN2bD2jrad/4
         czkDKJSpDyxkv9HO0eZxGcRXHA7AT9MbsDrlIW7Hgd3cl97OSWl0lQoeDluwkO6UGv5s
         MG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016881; x=1781621681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YvVZVpbZQ11FZGvsMbCfSWDPxvbVcumrUGTwFQKsLlw=;
        b=mb6Y5lFzlzCT4Fp/WRV1fTk2Hs1dTUVHy7scNL7Iu+zr2QnAfd7MpHpNYZCJ40IQc+
         F4O6g8h/MsVy1n4rwep3FmPg9ARBzBo0g2iwCPYaugCzz0Qp7P5lC2omU8AuBT4+A2LZ
         nb9VJKnxzJ95TK1hJWgPLK4nEffKcc0jyfHtDbJzBG6GE+1RdBGUlFPiCZR24uKPmtN7
         yKI2s09I2Sbus2yK1CwN22fNTLS+nWbp2dO1oNBNWA/esI90M3DBAaWZgvFJWliTz53H
         Fxpxa1N/z/rSM9gPVSOruK9LUPksGTMtMuEsaWBcsDUiPZe54jiYeArGM1T/9I8k9iO3
         0XQA==
X-Forwarded-Encrypted: i=1; AFNElJ/nXTmTHSTMwbP5TLoXdpgN3WPWsT4K6+svJnuG85MMIKzn32sdkT/E3yrGp3sKJtKa/JnNXI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsl2GgWY/9Q94GZEiiaVOtQIg7QN40Ik5Tqu+uvTOv21HlptHJ
	y81d6+wbjgATlNRPAxJVYyRjowLZB3Y4nE3etyByYYZboqQkypWSIc1J
X-Gm-Gg: Acq92OFysmFWddp5TNW0SqfRPR1lz/5BbSnd4wSRb72ecCdzKY4rinUL34RG4Tu9mtm
	7wN74mctWQPg/56QocPmCpi1IniOUWmodJ6grg3pnLn0OywjEhQDv3rkgZxCTueejeZLA5sumUx
	PCCSqvu4tLulcdTwaSeDkvX0iI97BezDInORhxsi5WojQTYYW/EW7MEa92Je020yda/dn66TF8B
	Xyr+Q3OzcJ5cO2UW7/ci9o/+pvdYaPyDdnS2ZCl827GJy5auGksgqSyCXQxKbSogfU6wKI6XbtD
	EnAkLPMYF7sBbXmXROIFVK/UJOUBqnH5SiQM6gQmKkLI2WxWPYKX1bvqN4eWhuPwNpLst9C2bA+
	USwZGiyYYlRvavFXZaFL3RKZ6aTN6PRt4Bk6bVCSVXetsXLU0utkr22OFusqkjntsrd/5d/UhD9
	FN7zmAjtnbkFWpQhQgTrU+4UM0QeS4kI43Yblqr5O4VphA79tjWpnnsS/MDb9HIJwa0JGj
X-Received: by 2002:a05:6512:3503:b0:5aa:6c7c:65e8 with SMTP id 2adb3069b0e04-5aa87bdd028mr5627091e87.23.1781016880741;
        Tue, 09 Jun 2026 07:54:40 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed2d3sm4652172e87.5.2026.06.09.07.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:54:40 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: 
Date: Tue,  9 Jun 2026 17:54:31 +0300
Message-ID: <20260609145437.1837-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605-stable-reply-0021@kernel.org>
References: <20260605-stable-reply-0021@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: Re: [PATCH v2 5.10/5.15] RDMA/rxe: Fix the error "trying to register
 non-static key in rxe_cleanup_task"

In-Reply-To: <20260605-stable-reply-0021@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

On Fri, Jun 05, 2026 at 03:37:28PM -0400, Sasha Levin wrote:
> I'm dropping this for now; it isn't right for either branch as submitted:
>
>  - 5.15.y: the bug doesn't exist there -- the task locks are already
>    spin_lock_init()'d on the QP-create error path.
>  - 5.10.y: mis-targeted -- it patches rxe_qp_do_cleanup(), but the 5.10
>    error-unwind path doesn't call rxe_cleanup_task() there.

Thanks for checking this.

I rechecked the 5.10.y and 5.15.y code paths, and I agree with your
assessment. This is not a correct backport for these branches.

Sorry for the noise.
