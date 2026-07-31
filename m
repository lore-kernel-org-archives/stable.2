Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3EB381AFB
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528714; cv=none; b=AcpWMqWmJ+0V47LozNo0icVCT4J1MgTOsvD1ewasIIYtnj+8BkeqcaSz97sddPcrV+diM/m/hziUYqTmitN9Hx2goOkyxS9G1VaDvd/XNf3GSjCSnj3axFpUeEJI3IySZMkuLPossukmsbaKxSA4hJcKn/HF8mB5KQ0zicJ/pb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528714; c=relaxed/simple;
	bh=Db3mdvMaHRUiMUCFH7rsGHgUlVEuwPKkCSHT2bSVqos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hBeeGwLz2IwPxtgy2lx25cCtQIgGd7KKWqxBJNrNyP5ouVlHE9RPxpv17l+KFrDiTHBt1GRxTpk6P5ogNADQMLYr9OYWIoDmdFitDNYUuFqgO6SkVfSA9eLXx9FsXpcHv0nJILwYkRI3IrpFEQJ4PTajEykIoYkT8F2msp2pF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ivUGsgkX; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivUGsgkX"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848662cd2a1so1735520b3a.2
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528712; x=1786133512; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KwciVqmU1E+FOM/kcV3bDOj/AK72EAiYVE9xetCtvi4=;
        b=ivUGsgkX/attFUqbZENaSA/Y2cIYvR/NRj7byxCvUeE6VRjjAkQR9yaUVV3EkkgQWz
         39GtJizsF2UI7I5CG5H3NJEbJ18qng7WQBGnj+woSXWxoW4ypJJ/81RMquDhx7K913TK
         WL4E/T3D4AvF7594dgbxJsJOc89tDHnTmAn3yQ3xM5w2NyBteKhaEe2TTiSSxCL6xwP8
         j7pl29rEoVuCRSS43ly9b2gxAZHGyz96CSfznPcB2pzobLIEYGDjwT22fNMBtZLM2suM
         LbgXhb/UQEOv3uyaLlnG3Ijli3xZXVLkKP3ZHPkXFpng9e7zRTdksUsui4H93UYG9Fj0
         YGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528712; x=1786133512;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KwciVqmU1E+FOM/kcV3bDOj/AK72EAiYVE9xetCtvi4=;
        b=sPNlyPHtl4yV16v9kYvoKo41BcC8TQUUoTDtlxV2QdpXve9n+k655i1OPx3fo5q/mw
         gzRJKySdf283XyDfj4aFlfNc0l3iPqlrkNNM7/NRZOWGzN+himJPwZcVjXc40sMiVgFi
         LT0MsK+PeMltT0Q2IwgQEwkrLPwED2natpgJrAv/ayT+IE9Dxw6UDALkJSPtf+J0u4uW
         +19qHbYt2SV7TA7XZjnvcAnro0tp1gKxT2X1AwaiJWvfSgygJlmKDaA1swZgTgNyPItJ
         NJpsRKcZCi7KIo2U4ijETIImA2wfe0Jm7xL8ts/VzDYdPtMxjRLR/0zuFZ/bYR+ddyOz
         Yz5Q==
X-Forwarded-Encrypted: i=1; AHgh+RqM8CaPiF4Af4X45ouyx3pyKAjctvm7Ip8BXmYJXrEs2gGgyiQKCAIMbDGnHJAio3wAOyzsUSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQVpE/jMhmEJEfjmIG1/BEKY9tiVM3q+bBV+7Via2xEMhFCQFL
	KOhVdt/qOGYgdiTuKOcwVynGfqAmoDFOgfMA6KKfdZ0Bcs08YyPHHCoFSqmoWoEUeVSwuOlKHdH
	HkcVp1g==
X-Received: from pfblg20.prod.google.com ([2002:a05:6a00:7094:b0:84a:3b69:a287])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b51:b0:848:438d:3665
 with SMTP id d2e1a72fcca58-84ee48bcd15mr763440b3a.41.1785528711875; Fri, 31
 Jul 2026 13:11:51 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:10:13 -0700
In-Reply-To: <20260715063626.65899-1-pankaj.gupta@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715063626.65899-1-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552837642.2712144.16765082260306461300.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: SEV: drop FOLL_WRITE for encrypted region registration
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, tglx@kernel.org, bp@alien8.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, 
	Pankaj Gupta <pankaj.gupta@amd.com>
Cc: x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com, david@kernel.org, 
	yangge1116@126.com, ljs@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 15 Jul 2026 01:36:26 -0500, Pankaj Gupta wrote:
> Commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering
> encrypted memory regions") added FOLL_LONGTERM to
> sev_mem_enc_register_region() so anonymous guest RAM is migrated out of
> MIGRATE_CMA/ZONE_MOVABLE before a long term pin. It also kept
> FOLL_WRITE on the pin.
> 
> Combining FOLL_WRITE with FOLL_LONGTERM breaks registration of file-backed
> guest memory, such as virtio-pmem host memory-backend-file mappings
> (MAP_SHARED). GUP rejects long-term writable pins on dirty tracked file
> mappings since:
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SEV: drop FOLL_WRITE for encrypted region registration
      https://github.com/kvm-x86/linux/commit/ee1a586dd1fa

--
https://github.com/kvm-x86/linux/tree/next
