Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com [74.125.230.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E7429037
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203869; cv=none; b=rBgCq6ciayEKNr8XBxPSNHO0I9SSco1D9TEOMrGhwu8xaYvsizWf1QWwee66J8HHeFIe3i0oIw23t/LsKr/aoCZxsbolSou40dFn3Zck9Jwfg2xWJZE5MLV5OYdY3MBGvMQm7AXBmNnUWtjsb0S4FO1kMVE49Wrz5Vtx5XO7sIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203869; c=relaxed/simple;
	bh=WznUrqowx7pqS0je/qrzTF9QX6muzU1oPBAfrPoo47Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTL24MUNb04C3j5l7g3SG1P+CIK4+D4xtdle73bX+YwYweQVk9fwQY3m8o3kOMGfwwm4Yg6Nak84Ne/33ZkXTyPcBCn3sOKFhKdFmESqy3VVB65u/NH/U63T/263jDZ8Vs0mlFGhBIxkeDKyRbKVOXI1qK+p9QtRzWd4T9Cjmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJKRh5ko; arc=none smtp.client-ip=74.125.230.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJKRh5ko"
Received: by mail-lr2-f10.google.com with SMTP id 38308e7fff4ca-3a88780168dso12286661fa.1
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 05:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791203866; x=1791808666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MxIknM10jxHR7Ff/pID+idHLGqI71Opd6kPGDGqz4Vs=;
        b=LJKRh5koEgrIc16QTIArECJJCcBpocNhffVn+S6m9ix/Ee/Ak7ImArFmgv+hORuXzy
         AbHptF112fagphWYlXid9055Jr6zHDMPl4WipCWaae+R6YPzILAxTMOftp492txwwUPk
         0iNhAoe+/Q46vDyZ/crOtnwBI6GfDQlyvfrni4BOUBVH7elhTRgH+1DD2N5aF22f0+LC
         WvtO417YYkNkcj1USOxY5WJPukIO46XijdCIPtyCSNoZwPPF+AfOuj0NNdjvTwzlg+F4
         dhVeS1tDIGUHv1LYCffCM0FgaLqrxRpm4Qa8UY3S+MJIEulOe61rzIUic/py5i489Swf
         1HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791203866; x=1791808666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MxIknM10jxHR7Ff/pID+idHLGqI71Opd6kPGDGqz4Vs=;
        b=mVriOFqXA72chE+fRAqWJRCrCnl2sON23XxAgu52hrfrtf3GkIdbNDo6QZbrXqroH7
         MajLbMTD//mEdzwIN44oo1r/4HlWeYMixh7m9QkDaiq6Zb8tiAIc3iRyIR/N4kbUpR84
         pNTC3RjXLhmNzkndjuOYDJz/r/WsP7NIwQ6HPSAKOSQCjwTj/mv9gQkHH+6RY4Rj0PK/
         o3doGIpU4GRsqCAeBCtK8q3+IHSbhin3/vfkhsReQq9ZnHomvPtH6QxkGaJjM4N8QIfe
         sqjuZCNZJYcm3hEEyLtF5IO+MZlXD9GeX9Ygl7CLmRweUHqXpqfM745NNT5NBWWMQ1lq
         4UZA==
X-Gm-Message-State: AFq9FYKhzIX4fJseEPFPssC9ImaVvzhtSlEjx7akgvmYLzB+q8arodTu
	uxMtZysmUfaFBGvCgs/DqqllkPXuM6cDzFlVKHZllja9KUpaMeO+JZokPtMkHLrZ
X-Gm-Gg: AYBFou0bcX9GFiwFuebpBujSYgyaQTBKXujN76fb0hQsFPZhsVw8aNUHHc03mk1lBDa
	GNLLxWpHcbiYp5epEDzy0edwMk63y+Jw7nwOhmNUZpp2Gl9MoThg79n+hFoSG2LjN+7UWuM77HI
	yxO6cTKT1IGsErMlFNvoLB9mqHoN8iHkqwq2E6Ao30WbJtdAje63YKAn+zQN8VXBNMCzro/ppRx
	9w/YcojRJoGxfjx1Kc2JbuktGfIBj/Zir9ZwWhOUwPEe2+8mANa0UTmYDUbSC+zP5WRuT2+h4fd
	gwk6f/3DjdmiSU8dwxHP9wYcs/5ZGncmRs4xuxgSDWqoHXKgpzC2uRT0Y0qauLjxLHV7MZSO4y1
	9QhYdB5WN/BhQEp9d3ovEFpD3Z8TdM0lt5/j7Hlz/vzRYO7oyjKjQi1hJmtTenlq0Dw2eTwFUZP
	nwDUvo4fhb1eYe1mLzYx7YHPw81ibdcYEq+F8DZAgSpn3dmvHzPK/V8Vge2VGQRqgsuylZ3M23b
	J4u2OmgYCnO++NPfcWoBYhj/pM=
X-Received: by 2002:a05:6512:b2a:b0:5ba:3797:ba with SMTP id 2adb3069b0e04-5bb9bc41740mr4179902e87.53.1791203865574;
        Mon, 05 Oct 2026 05:37:45 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c718f62sm3228393e87.12.2026.10.05.05.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:37:45 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Jim Mattson <jmattson@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10 3/3] KVM: LAPIC: Also cancel preemption timer during SET_LAPIC
Date: Mon,  5 Oct 2026 15:37:00 +0300
Message-ID: <20261005123705.137028-3-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005123705.137028-1-roman.demidov.nn@gmail.com>
References: <20261005123705.137028-1-roman.demidov.nn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wanpeng Li <wanpengli@tencent.com>

commit 35fe7cfbab2e81f1afb23fc4212210b1de6d9633 upstream.

The below warning is splatting during guest reboot.

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1931 at arch/x86/kvm/x86.c:10322 kvm_arch_vcpu_ioctl_run+0x874/0x880 [kvm]
  CPU: 0 PID: 1931 Comm: qemu-system-x86 Tainted: G          I       5.17.0-rc1+ #5
  RIP: 0010:kvm_arch_vcpu_ioctl_run+0x874/0x880 [kvm]
  Call Trace:
   <TASK>
   kvm_vcpu_ioctl+0x279/0x710 [kvm]
   __x64_sys_ioctl+0x83/0xb0
   do_syscall_64+0x3b/0xc0
   entry_SYSCALL_64_after_hwframe+0x44/0xae
  RIP: 0033:0x7fd39797350b

This can be triggered by not exposing tsc-deadline mode and doing a reboot in
the guest. The lapic_shutdown() function which is called in sys_reboot path
will not disarm the flying timer, it just masks LVTT. lapic_shutdown() clears
APIC state w/ LVT_MASKED and timer-mode bit is 0, this can trigger timer-mode
switch between tsc-deadline and oneshot/periodic, which can result in preemption
timer be cancelled in apic_update_lvtt(). However, We can't depend on this when
not exposing tsc-deadline mode and oneshot/periodic modes emulated by preemption
timer. Qemu will synchronise states around reset, let's cancel preemption timer
under KVM_SET_LAPIC.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Message-Id: <1643102220-35667-1-git-send-email-wanpengli@tencent.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2022-48765

 arch/x86/kvm/lapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0b6fc5395798..8f41a5ecea22 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2628,7 +2628,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 	kvm_apic_set_version(vcpu);
 
 	apic_update_ppr(apic);
-	hrtimer_cancel(&apic->lapic_timer.timer);
+	cancel_apic_timer(apic);
 	apic->lapic_timer.expired_tscdeadline = 0;
 	apic_update_lvtt(apic);
 	apic_manage_nmi_watchdog(apic, kvm_lapic_get_reg(apic, APIC_LVT0));
-- 
2.53.0

