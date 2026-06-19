Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1CF3B95EC
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901119; cv=none; b=rr15DbuSebXtBXxoreA5TEjAxBg6wzRkVQ0EPDERX5ydY88FU62q48DwhEzDvfSMQUV2z8gdcWjhVe0XTpSDIgeY7gRmsil+LmoSipm+UsYfyt7c9F6W6K8YQp7DkSVVv1k1zPE5mISEKtGg6qphUOr1V7q79ow87UPUICX4vrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901119; c=relaxed/simple;
	bh=/E8mnLJj+epl51cgxm9LLIajhOl8c3FpUCtgX8rsvr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r34sJ9auKV5GXXHkzrqIS/B8HC7yPSFiE/wXBThpZqY8dgQZ3KRTkqmaoUa3hyaaG8dVW6m1um/OaCjnvS7nfhjRuHrO15vF6JzfdLKfBmbkEAsjEVsffOlBAUNRtpHAZa6A0++6MpqCnaVHaSYgTMteLZ+Y7F1ELyjFs/9xkiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3D1LZ9i; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3D1LZ9i"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8dd3fe9cf10so20302146d6.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 13:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781901113; x=1782505913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=izLjqw/INKe5R0s/VDFVyTgV/leWjpu/ky1a2+ufVt0=;
        b=g3D1LZ9ivgMH6fOJAX9xq+Y80kPJKqGw1FWrPjJXgMuxl+EoOmFRKi6yOqWQYwm+H8
         +aFzBW7jhL85OWl7gxKr18141VpS1sJhFJsITN/EmUjdSDjM56gl24ULOUv0Lj03Ywg1
         x7bot0pT1clTjBjA5UHzMa8QqFmTiLw2y9dT7QGY2bztftF13HERJYHaue/1csRZFT9w
         9m6RM+8dTmoWYemwgSidHVLdgJ1CVgiluFj0XIN+PQHZepaC1OzUFixCWY+DHrvceIXx
         qjdMGj1ik4PPXiGfSgJuLbXK1jeqKzudOgRZyKUYo8sT/bkaNTLBxWBlnRXIX0F+AzX1
         WElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781901113; x=1782505913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izLjqw/INKe5R0s/VDFVyTgV/leWjpu/ky1a2+ufVt0=;
        b=CJng3ozFEbgDGaOiOzxi464uv/y0N3eVBCys4uK0ASwOOSQA/RnaOQ5e2kaP4EMrnj
         z9LAgtn7xnFpwnXMuUdUkkLsDFz9ZCtxXksr7N6yuWh4nkWbGeMYG/r1SHAPrt26OiVa
         vhdFR+r1rlzkbnbf9LYVWXCkfWhbTpFDFYoe/QfMiGHNrwF+A/PJE/wUqNiyu5AcmhTm
         wf1ueWZMfAi8FAEDu3nTJnFipqJOvuvrXmVRXU9V6GU/Be9g0FMHNzGsk/zeroT654dY
         SobqFhjLSHimw+u11oh+aK6TixgJQmFCEfc5/E9TqexzQ40qIc+eLDjtZrj8UnfQfxeX
         5xjg==
X-Gm-Message-State: AOJu0YyWqtAYQe1oL7brwy9gGHom97oTrx35Ypna3xg9Ml0whEnoRSDB
	9Qv5zuNsuElLzceNH7+o+BKhNFLh1LI1qSR2t1sDov44OCPSaH1c1hdVCreqSP0b7Yg=
X-Gm-Gg: AfdE7ckTHGwqm+b5ihPMVW4odJG6N4oa7o2+Q0ay4+2uLaksfrO+Z46bUvKam/FchqG
	i04AY79bjltB2MxwrFLsMzuANj6QbDmCg0mgsEdpfPBOV400zEG9AdKgpNrv4VtcqthuHn4BII+
	FcQtjALm4nn8Omct7UnL+ZKKQVfWtvAgd6rQWxBvaD+NuJtJaKx0IfdwU/Yz54GsAWB8JMvc60V
	nA9O6AWouz54XaEMHOdVjk8VMdgETPOZW7m4+Mlv+bQOm88g/gK9c0hjD3W37G+WJcomtDRwblp
	MoI3j9VYi9xHNX7IadQWB9GsyJGsjqdSCYusHU3wQgiU1rbw4Xd3YctVlIXrcDqIY+l9O8065g9
	wfFDJK61n/o4+bqRVwg29n3VvFMgDlQDMZIaPcib/2BTt6fu7Dlai71KcJmMdqzEND6H/gF1KYS
	IjsxZl4iS6bQULDUM=
X-Received: by 2002:a0c:e00a:0:b0:8ce:cada:9ce9 with SMTP id 6a1803df08f44-8de40dfe555mr76250166d6.21.1781901113220;
        Fri, 19 Jun 2026 13:31:53 -0700 (PDT)
Received: from TurinLinux.. ([37.19.212.13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f015805sm11106986d6.1.2026.06.19.13.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:31:52 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: stable@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	gregkh@linuxfoundation.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	0wn@theori.io,
	mlevitsk@redhat.com,
	jmattson@google.com,
	Nicholas Dudar <main.kalliope@gmail.com>
Subject: [PATCH v2 6.1.y 0/3] KVM: nVMX: backport virtual-APIC host NULL-deref fix
Date: Fri, 19 Jun 2026 16:31:04 -0400
Message-Id: <20260619203107.2752678-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series backports the fix for a guest-triggerable host NULL pointer
dereference in nested-VMX virtual-APIC handling. The bug is present in 6.1.y
and fixed in 6.6.y and later.

vmx_guest_apic_has_interrupt() tests vmx->nested.virtual_apic_map.gfn to
decide the virtual-APIC page is mapped, then reads through
vmx->nested.virtual_apic_map.hva. kvm_vcpu_unmap() clears .hva but not .gfn,
so after the page is unmapped an L1 guest using virtual-interrupt delivery
passes the .gfn check with .hva == NULL and the host faults reading
NULL + APIC_PROCPRI (CR2 = 0xa0). 96c66e87deee introduced the .gfn check.
The function is still present at 6.1.176.

The upstream fix, 321ef62b0c5f, deletes the function. It carries a stable tag
but did not apply to 6.1.y. The failed-apply notice [1] lists the SEV-SNP
series as a dependency, but that series is not required, and the backport builds
fine without it.

321ef62b0c5f edits the vmx_has_nested_events() body that 27c4fa42b11a adds,
and 27c4fa42b11a calls pi_find_highest_vector() from d83c36d822be. The series
is those three commits in that order. The rest of the June 2024 series is
already in 6.1.y.

Sean asked for the series to be backported rather than kvm_vcpu_unmap()
patched [2].

6.1.y predates the vmx main.c / x86_ops.h split, so patch 3 removes the hook
from vmx_x86_ops in vmx.c. The resulting vmx_has_nested_events() matches
6.6.y. The injection path is unchanged; only the wake path that reached the
dereference changes.

Reported by Taeyang Lee.

[1] https://lore.kernel.org/all/2024072925-straw-mashing-54f6@gregkh
[2] https://lore.kernel.org/all/CAH-2XvJo_JiyAnb21_LYxSz8xZ96oUVF25eTnDyALF+wnZw8ww@mail.gmail.com/

Changes since v1:
- v1 reached stable@ without this cover letter and with an incomplete Cc,
  due to a git send-email error on my end. No code changed.

Sean Christopherson (3):
  KVM: nVMX: Add a helper to get highest pending from Posted Interrupt
    vector
  KVM: nVMX: Check for pending posted interrupts when looking for nested
    events
  KVM: nVMX: Fold requested virtual interrupt check into
    has_nested_events()

 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  1 -
 arch/x86/kvm/vmx/nested.c          | 45 +++++++++++++++++++++++++++---
 arch/x86/kvm/vmx/posted_intr.h     | 10 +++++++
 arch/x86/kvm/vmx/vmx.c             | 21 --------------
 arch/x86/kvm/x86.c                 | 10 +------
 6 files changed, 52 insertions(+), 36 deletions(-)

--
2.34.1
