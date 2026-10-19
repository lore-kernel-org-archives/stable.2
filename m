Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792453624;
	b=VKVblhwY51CqoFczoKFWeWdlVMrIUIEOYW31ouxhqbg4TvdBg2HiVoCvodRkkGRNilFH
	 ZgYFTY5VCOKwuP+q0NUupgfsqYy23UOTHFAazoqEvENCDhyi6gJn4eCKIEAAAkku+cDSH
	 wWclJHoxy+w8ZsefHmvMAGRDdiC2mVtZ69CRtYwVwKVsT0maR/e+xmMSfIYeaUIqcXsHb
	 m147W0W7u4DpY+KcRBppbI/EYknOnhr3EAHAjVH0endZ0UgJPWwMs/cq7VU3X0SVimo8f
	 Z9DeMXDCrRYufDbJ5MiVm6oFGiNib4Q8zuZQ4Viez1/N3Qa8bbHGJ6FnBN+VjS4dygw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ypCU1E5MKpp7DyfKc2E/egobrXvy2R64su9DcxdosVA=;
	b=qddTjguDInTiNXqjXE4u/8dgOwC7nMTHOmeMf5nMMvJ+V5Wj7uWBMcvaIuJbfqORZ30t
	 NJqpIZ7ewfiDE2h+19YYX8E3PKK8QviXg2l/qfRfDLgnxUsb8N7fVtrBCbpmZ5C25Xx+6
	 A0KJqiQ7oQU15ow1V7WL8GMZan1FJllWkKiuhZnnvRg46eNkPpNo4O8V9KoIi3jIuWOSE
	 48O8iCeZZdUVW0WXefi/g6E2XHv2YMl1O/FRLvW60S5i/KMEGUhpHbJ4dbt/gTp7Am9c7
	 6BwNN3u7oXQeoPKyMfttgXTgjudrhrlOA2lPy6yya4rIu1rDkWC3uAsW/cQfN0lJjqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lgkpddl2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2B0606A31A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 23:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E2B0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lgkpddl2
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ab3b29a1d4so11942911fa.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 16:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792453622; cv=none;
        d=google.com; s=arc-20260327;
        b=fbKTzDytFmG0swJTMH6hMEUvgA0q2TtK0dw1EYWOevUbSc9WRUE1Uk+RywSrfRUEPv
         HovVnPOD/+qHcV2pswHeNRf+VtYEkjfazelOpny/jOc7MMamjiOn1dkb3xHDgonmmyYL
         i6goiImuBYRrBkoRWkEdd7QTmqPxDkrNX9a2gS6788ue+pm+6anTVfsSK9AEf77bqk1n
         UTWk2J+aYfJPWPI7SZU0OI4oZhn9u6os6LQOjI3mKEnnNqM0xAZybvMVWq0roJQ2amC5
         9C4uNihVkYJbLO0ANRV0F536f6Ijv1hjn14J+9L4CV3fOYCL5vjRdi9L4wzU/DOzcx/o
         sfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ypCU1E5MKpp7DyfKc2E/egobrXvy2R64su9DcxdosVA=;
        fh=yXX18BOQK+tM/wmWObJ9AIPAc7Ve2Com2ck3J35b08k=;
        b=st1SkCFgQ9beLK41qk87c7FN6ftVoDQ8DtRqqCEfE2GPQuhAYWB+mv66yMdX/GPR/b
         Acv3xVVmqet1OnY2GvN7U3nIxs166dE+UPRNUYSeAnC5zg6c0jiYXlESipjQPJZRee4/
         8ilQ7KhBre/PcVLa9qKFhu2Pz19Go/WY1BYDf5qqPBni1yfZ6sOpPiQLwpUGVaCi0lQc
         bqypQazY4aGu0poShMv2Dp9YJNxSHILvDpKoYnaOSKWC/+3XhzWtmUvaa8pMNrHj5eHy
         3Pzr4c931ylcR3XpHEnv66tfJejCq+UeGNgKQKEjWYULSKurdIxtaQ+rKbyBpmUIU9uJ
         755w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792453622; x=1793058422; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ypCU1E5MKpp7DyfKc2E/egobrXvy2R64su9DcxdosVA=;
        b=Lgkpddl2TvvCEoP9iVOQkoChp1KC29S+ddjoSUXUlTzd1BTVP6lz/tJ1HwEGS/F/A8
         /OSHUEs5EcXL83QlbmGhryu9bdgy0Pnu8QxPCvd4c+Unk4Y3rI3UyTm0qqeBASX/5Uou
         w6tENwv1hm6FZy44zEVf17LfBo25esknPgdZ7gs2Wq3phxLdFCr9aUNhPXe0OyzygCxJ
         6v1OtRUjnSerusS0ldpWeaxMKtogm9r0GVelfeA+y9tJdqm0MBXTcPQjJtPkagnT2zUZ
         grHA621VmUi+mG0NhI0VVKH4QKYQVpz9ADfebjH5jT6A864uxZTTn0Q4fUm4Dx2AHXg/
         CJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792453622; x=1793058422;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ypCU1E5MKpp7DyfKc2E/egobrXvy2R64su9DcxdosVA=;
        b=GW+3/jFAIIa5/CPFIUXH2ANSKe3BUHhHz9bcGUgWgUz3I9vHjMGtk03cYNi2WS92pa
         InwV1AjaCqrkt9Eq4dWbmeUomNLLcLjONG9wP7FI+Uc/+44cYjGPC4B1WBqpkeaKOeH0
         rKv3e+Vl9PRRdr+8gLxJCzMZa+PxlEIBOvX86oidkuhOzr8dDfgMUp/sQWbBDESoHVf/
         mFIMPWbl+iQwy5KBahux36Te6oWIG6vDCO8BPhz4qu/bzuuLkZgFtOp2XEMoyLUOH4nZ
         7UHhvbyKi10sud1z6bFkCWASE8/qDcs53j82y4nRfhkrBFupUEF2l+FRPnAPDEXlgH/E
         opdg==
X-Forwarded-Encrypted: i=1; AKwUvBwkXUQhB06JrmD5pCCDv4Z70z/K6kRWoNakaWUQq84joPDnFPKtFqJSrpzvVeIW8nE4yJegEnA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/v74w5baxBmW4mhFyNIHhiku33KZtStCI3FD5Q8x/2PDpkg0e
	Yi9muggqOLumA1zebxdqDftRki9sP4z0LsyFI3L1q7WpGcCmMpPiVu7Ogy5F4BqPYTn+eAiNq4A
	lFLJAysN8kYWZa0QUvVimd1ckHGjQo18=
X-Gm-Gg: AYBFou0j7fKIhCn5bifVmCTYC7nb6xZhbyxX11KT4Cf2RxD10Gk+ZtaTiByI6Vn31o+
	w1j3WvdhO68WahKPh8nVNhlHetej6Cr7uLLVz7DvR5ltpNA+vdAASUCM36DFV5Xae5Rw/hD4NCr
	bepdr2WD2ZecNtJAiMgUOvibpHfgKHF0IyOs3y4AZPSwT3pI81bO3slMJd9VO327sMm4Hn56lUJ
	I8nmOQ3M7tvrIfL/rO4aa4qyAC3HIyMzD0XI7hnm3QGuUvIwVT47jYQvKCU2InMZshGbX1XbLPX
	skqhbzSgPuffXaiBQr9GrozgEhJ8L/PySEOFpawhIy6fzcxPnozCkQ==
X-Received: by 2002:a05:651c:510:b0:3ab:2d74:71e with SMTP id
 38308e7fff4ca-3ab2d742b84mr17797071fa.10.1792453621900; Mon, 19 Oct 2026
 16:47:01 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016023521.747447-1-oss.patchbox@gmail.com> <25a35fa8-9540-4892-8375-1788e6795dfb@kernel.org>
In-Reply-To: <25a35fa8-9540-4892-8375-1788e6795dfb@kernel.org>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Mon, 19 Oct 2026 19:46:50 -0400
X-Gm-Features: AclHuK-d2lDGIbO0nMDnG4pSmt2gfW-rFmLHGdUc2vgLpFp-z405iCYiTrPxDos
Message-ID: <CAGG=RgDUFpDqtbws4YO4T8A3pS4Dr9twVqP9hSD3J_zP5Dc_mQ@mail.gmail.com>
Subject: Re: [PATCH v1] virtio-mem: only mark the device ready in kdump mode
 with vmcore support
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 09:05, David Hildenbrand (Arm) <david@kernel.org> wrote:
>
> Which kdump kernel exists that does not enable CONFIG_PROC_VMCORE?
>
> IOW, why should this be stable material?

I tagged it because a9403425b3cf has been in releases since v6.14 and
PROC_VMCORE can still be turned off with CRASH_DUMP enabled, so the
-EBUSY path is reachable in a valid configuration. But as no practical
kdump kernel disables it, I'll drop the Cc: stable in v2.

> LGTM, but I am pretty sure it does not make any difference in practice?

Right, nothing is queued on that path, so the device has nothing to
access.
