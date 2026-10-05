Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6065547DD50
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203855; cv=none; b=MxqXkN4cit8dGoCnwJA3FLjXJJYJVPd3xgAka+XVqZTGgGGwBQ+BvJoAvQuHwopGDFPo0VMEdI58fFVPKdvA9TVzOj/e80dGtNBmpBevsx5ECXmUy4ffai82pgYEir2XL/J6xoPSWIczCwlvKYjUOSP2WAaVc/Q0vHpQCB135Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203855; c=relaxed/simple;
	bh=kBexbWtC4+MyoxidFkM/IIOP2Geigs/tBXSpL3HrsRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MgnL1IQNqhz9/o28fRhKlyc7e1KpM872dGVigamCNajrb0byms1TY8OayioALWHgCa+KG+X1pFXe2pvM7VN0RbS8IJQApW9dU5pbjpXPDUrlEWUNVJgwiCJ9WzYf8I2srT2viJCBDgOMV+3EKArOVC5MOiBeV/yEInS3mysufjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvzL1VD6; arc=none smtp.client-ip=74.125.230.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvzL1VD6"
Received: by mail-lr2-f3.google.com with SMTP id 38308e7fff4ca-3a77df9781eso11734521fa.1
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 05:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791203851; x=1791808651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gt2QZueXCtMYUg/+LdAV+X7CcqwaR0yZcibIjcXuM5k=;
        b=qvzL1VD6uM0sytgBhyC3jR+W1WlZGDTYiTyunLh2P3wWkp2PzcE4RdfxVwpXld/zLd
         SoQfOa71Netzo04XfJTOw2ZKUUoO9iX3hJcqNZY0Uq1kOknVYkSoeJs+CyTCw72rIQKJ
         oynUVidqYa7k+vnuY0eAbd1GcCtlYDPOHD2TJq0d+YSe8NaCLo2zW60+/cvMQAwia7cp
         2JyiK+M/GJwZU2sGcqUZHDlWtAVPbk+pkBRWUtqytKp+UCI/wwGUtM0sS+Rijxn71pla
         UQQyIulaUsNADU1RWpxUbWVUQ1YQXsLWnSaFnKMvRWMWErQP1QrHFhi/wTiuQRpQf943
         kReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791203851; x=1791808651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gt2QZueXCtMYUg/+LdAV+X7CcqwaR0yZcibIjcXuM5k=;
        b=MAEJqsTkXNJs9JKgysd77zTrUhFbvw5/oQXQkQRflV2TwEIXrAOm8oopPlakZgrcrz
         9P1gF7oisDFw3sPXg/qAnrxtrxNOisOimOrRPoz9yfX+0zQzNdsyfA1TNV6yJ7PkCi33
         /hYrcXL6sKm/GYYWRp7n62A5fFKYOH/jpS0iTA9Wr1/ACtAbxr2OkMGwvQh2O59Gy95a
         eAGo+M0Fme/ysDFGuSo1CPvcBnbhxlHfnBHq+pc65eW0/qtIwFesYJDNjWTublqjqa9Z
         wgkhjUXN9s2Kibp83zKfDBC+o5fRgHCPiEvEEUOOM2xq3bDN4J4BYAW9nXAKuVAz9Kqt
         UhKw==
X-Gm-Message-State: AFq9FYLlbQKTunFM4OoWGDYF2AcyhCv6Rhy6XczdY5JbZWOe9/epWTJf
	fQ8ACFEoMVP+ATyMLoEiff2OGUZ3cTKlQH/aMk2+8eWeL6FYaNS/5sZYQezfWNmt
X-Gm-Gg: AYBFou1FrM/MsTUtLSTNXBZPKhTD81jtHzY5y5f0utrlnANwzMwotCbrhEqhk16dn9z
	uCtPzYcA0NBHPBvaGuYAh2zP2NM4m/S/ebElQH2EbbmtqXMVVoZfrGhZ5QgTLTBj38dVtB1fX1+
	+iSwyxvAM6RQq6umc53mN6TnpQDLYNYW4+9htBOuS4Y3M/WdjREwHqGqFNxol7fCEWnpH1fJd2z
	CYDvD7+cNn2+1Y1rDBOA+Y3OOSBToD+HEZ7jn/1bxXXB6oBW4excyFkiGXMoETJxlx15bI8HbS5
	ZjBUvrKdWWcOOY25ybx3n6lCWh8F2YH9by8S7ZYaQkP6lGF4VGLThMdpht8jl+2apfyQsPQJLq8
	ncQwMhdGN6T1FbkmLE2rPMY8cYwSRF8btGQmf5XG4jy1b1/ONBBRsYkwm5O+WWAgkFtmodLLLRm
	IZ/UlVcJJO/VsIFW/dzhJw6Ymp9yM394A9W9D9B/5Z2+zmYB/kYvUOfW4AXSbQChZEwuF0H/EiC
	VKphYpNNYnKQxAe
X-Received: by 2002:a05:6512:688d:20b0:5b8:bc5e:d118 with SMTP id 2adb3069b0e04-5bb9bc2ba85mr2534588e87.66.1791203851108;
        Mon, 05 Oct 2026 05:37:31 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c718f62sm3228393e87.12.2026.10.05.05.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:37:30 -0700 (PDT)
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
Subject: [PATCH 5.10 1/3] KVM: LAPIC: Advancing the timer expiration on guest initiated write
Date: Mon,  5 Oct 2026 15:36:58 +0300
Message-ID: <20261005123705.137028-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wanpeng Li <wanpengli@tencent.com>

commit 35737d2db2f4567106c90060ad110b27cb354fa4 upstream.

Advancing the timer expiration should only be necessary on guest initiated
writes. When we cancel the timer and clear .pending during state restore,
clear expired_tscdeadline as well.

Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Message-Id: <1614818118-965-1-git-send-email-wanpengli@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 54b3439c8e70 ("KVM: LAPIC: Also cancel preemption timer during SET_LAPIC")
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
 arch/x86/kvm/lapic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 8b7c3f773d70..0b6fc5395798 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2629,6 +2629,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 
 	apic_update_ppr(apic);
 	hrtimer_cancel(&apic->lapic_timer.timer);
+	apic->lapic_timer.expired_tscdeadline = 0;
 	apic_update_lvtt(apic);
 	apic_manage_nmi_watchdog(apic, kvm_lapic_get_reg(apic, APIC_LVT0));
 	update_divide_count(apic);
-- 
2.53.0

