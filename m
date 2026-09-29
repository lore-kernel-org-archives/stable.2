Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3F36B932
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 02:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650020; cv=pass; b=esV2BXnE8QQe0vEs0uDiT7ThVKoz05+rDeZI/v7vL9BOC93mVe4EAQR7m0tCy0xHmTt5sf8wKl6mkfZNLk1olZLzJZ2STjAF2nMp06Fufq3IMHwkoj5b9bsQTBEkc5PcVbrnzMEB85QNjmtU4sc5+/Jtg52il+SkK7KMtSh3C/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650020; c=relaxed/simple;
	bh=+JMu39k8t90lMml2PTuqt/SuNIgtnLZvu803sFgpUCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgBCXCVNQzcA5OFNIOgo/vzROJ6QdjuJnBv/zIOMcZaN3eQdpTxewWR2qEAxNhhU3+R2kSqqr5dRlPCCq50O1gl9c6v5Nie338sT/yXhWuckTiUZyz+nqlR9gqZNNxiLtqzyOZnMmzgebdw9OQ+I3el7YwAQ8a0AjFOXeo5MjDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzBAyVhw; arc=pass smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzBAyVhw"
Received: by mail-oo2-f36.google.com with SMTP id 46e09a7af769-81a8d9a166fso1325578a34.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 19:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790650018; cv=none;
        d=google.com; s=arc-20260327;
        b=WBh0ipSrV4w+ZqkKqWGwEE9MebmCIjZgfbaxvTCjRRatCbovId2a4FSFG2/eiRxzEo
         RNZ9TqGwq+9qSNKR/98j96kuJRhgssbrf/kSzq9jjMPHzda9tM5JWraCeqZzxAiC4Q4o
         tQVyNz0RejMZumSxMZUxvDhcD/Nx3AvEiLvCYpl5FoAthPLKv0+35km4zGSzRjfDjDni
         eOT0VCIh/CeLPYSOBRdLFQ1o6sdUDyBsrfmv7EM87kFn/aXhtmqCDfCHqbkNqdF1AXb7
         36xnkCtnwkd3iiKc2HQ897URuYeee0ahh2PKHn3skn9zoLhO8O9iOKHWehgRQ5nviaFH
         FL5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0GLky+zMwV+lXLc5wxi80Ewpo+ygveBV5zL10ZyTdtk=;
        fh=PQJJH9z19+hj4nSvTKBDj+osIefvIDJNaJMnvTVDhvU=;
        b=ZmkOCIKCmWZMssCOTt20T3x5tr0y8IVxnxSU9YabNXsvt25KXxhNuvwhG/NykNjbVM
         +o4HEDZ2+1u8mjwDGMMM2mrrHFqVHm5QLY86wfIPn4KAGTgdH+ynrrr9IUA2ePqbthpq
         +6ADBFqTKpD8dI9t9j8DDPc2i+Mg1NoY8ZfCxFxu2VhAZQLRee0C2Mgx+f0DK0pC88yJ
         3xocQvHSIDqql8hkn2XhN6yPLU88ieqlo64mBfbwCfOmlRO3ViB9ACn/ui6dQrazxoa1
         pbZKTU3EP38MyZWWsq7rHJAIqL8cke2AvQrmodm/BrQbdtAvcYWLg6cxXAHCrM3m40F7
         WIiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790650018; x=1791254818; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0GLky+zMwV+lXLc5wxi80Ewpo+ygveBV5zL10ZyTdtk=;
        b=VzBAyVhw9SwP1TgQ4tHJ3WPOIPefHO1HSpIIF+x2Wf0Sn4CUv2snLPi1oFw8pIrb9X
         q4nDbjtaU1h32kpL/7nNAuRnFWxc70yZmRa/PiCLgiHWe7ULKzzPfRuwh6Z0nToxYIX2
         Ks9OxCPv9tVKTsdAzMA2xczlV8u5M3rzc1SOmq4jdSHVelPt9p15CMEpm1ZenwypzO25
         v2xJcfbcf3RZIYmFwwLUz3g69AUttvKqvPV3+MgqBLMNR9XVuf9otucDLSevY/EMM1rj
         x5Uz+wzO3mW1CeqmgPzpnx4nCV8+qrV/5Euqp1Ae8VvzZcJRF8a0C7AwmIj1GdapkEGQ
         K8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790650018; x=1791254818;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0GLky+zMwV+lXLc5wxi80Ewpo+ygveBV5zL10ZyTdtk=;
        b=1emVTELgmutvzyICRUapxZsXfxJQ7ewrCO4+yiXGldfrAVZgGdAPiENacBYUSHXJj8
         6qNmvIzr84OAEQ4ULch8/BsmEt4km9wFmAr0qk/I2dItK1iHSgxM5KLvuTNI9uVWaSfI
         UPbwWXep6w3heZovaC9+iVLNTnW2qizcrd+mTJuvqipUDAKpVz/mxS9QkqDF478Vwg+T
         sgphk6/dGkqu7fNgLAYU6heT8NA+KiuXoW4gr8m4xTBkLfLoMfYqPNNEDjda2vkKuQQZ
         ASotjD51aknUgtrmNdP34a0eZw3VHkj+w//xJbB6DV2/yEtPG/5bT1pnGqRcKbm9+xjr
         lGOg==
X-Forwarded-Encrypted: i=1; AKwUvBzBupHj/z7XBaCz07jRPgqRX2byols+Ql+MxZL2Ot+HbaKzZhm26IPquT+712yI8bRNLN0CmJg=@vger.kernel.org
X-Gm-Message-State: AFuF++n6V99/1Ztid3GCCAvDT2FehQkcEs2MgnzXx3w9x9Asgdpm8RsV
	BNIgJ4bb18XCrMGCW+GcQNBF2aZvYvpGST7i6TkdVLkD0e3Lklvz9kXmDpYJSs1Z3nA+Eh81tFj
	4gq4gqV25oiXEMO2jtWr/dQ7da3/nCvk=
X-Gm-Gg: AYBFou1lJBr21zcyznV+VeQkeAzxzfY9fIMhqKyt8J4qbaw7Akvas5Chz+MafA+w+eW
	B+R/LJ84ZaWy8mxMNlBebtUN4q836PMSHbNr2SbgF91hP96P0RwgR8srFOhjOXd3oDl2nC6rZwH
	0RPxMQpkgwP9MNZ1MUUX3T/4Td/CBZDVCIp5+8UqGnPXbD0yg9YrPaAOuvPp5Lj7A9iFKvFXZ4G
	gUi/YOcxELtYr4GCOI8igAFfVyrnSagKJZWUHU3khkxNhRIEqeOrB7WzZoyDTRxDpIoP2JR5QIm
	bR7Kq2DT6+kJa2Dc6mXujd2uV6EtQGrkPHSVZeNVw4PQQ0iLlxV82Rmx/Lx+fB4VbQ==
X-Received: by 2002:a05:6808:1495:b0:4cb:f21c:a7a0 with SMTP id
 5614622812f47-4d72ac548c1mr17435493b6e.40.1790650018230; Mon, 28 Sep 2026
 19:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820123512.87236-1-duankeqiangcym@gmail.com> <arrwQKQJpFZtARmN@google.com>
In-Reply-To: <arrwQKQJpFZtARmN@google.com>
From: Keqiang Duan <duankeqiangcym@gmail.com>
Date: Tue, 29 Sep 2026 10:46:46 +0800
X-Gm-Features: AclHuK8mMnu4MvWcyqvFMSXacZLsQfPg_SuyLmkpDnlhsh7cHQGVbBVXMe35tyo
Message-ID: <CAMd06Xdgp3y36msuro8W+X9eLwXDR29KLADtTObN+41bRr78MA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Clear hardware HLT state when userspace
 makes a vCPU not-halted
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Qinguang Chen <chenqinguang@kuaishou.com>, 
	Zhiping Du <duzhiping@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"

> Anyways, unless someone cares enough to want to back up the claim that spurious
> wakeups are ok, I'll just drop that line when applying.  I don't see any reason
> to mention spurious wakes: the vCPU is clearly being moved out of HALTED state,
> it's on userspace not to screw up (for this particular case; there are other live
> migration issues that userspace can't solve).

You're right, I was conflating the software convention (every HLT is
inside a loop) with
an architectural guarantee.  The SDM and APM are clear on what
actually wakes HLT,
and neither mentions spurious wakeups.

Please go ahead and drop that line.  Thanks for catching it.
