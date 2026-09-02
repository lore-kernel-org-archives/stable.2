Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B06390C8E
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788376798; cv=none; b=Fc9nC8CONe/pLjJYyaApVT/KZpoT+kgC+8Uihb79d0Mt5TOvYNXbBal+LhjW+JRYTriCTAC8OJNlA9OfleRwzr7AoX9Xh5yjgjqtnrIGPTf/42Q3tKQ25QCaEF4aDCnPKNVfhoDgiaAUl1X5/1fxLjuxBkGWKUSmlKwEZe9hSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788376798; c=relaxed/simple;
	bh=nJM813bTC7dIK3gmCYeblNkULx7TOwQ661mJ4a1QEY8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r8Zld0LLgbBRTUpG0ow8vErKdqu50lGVByoW4V8FKKZ5bIGdPAa+/Hmfx4UsC8cFDHacov7EtzKv56SQEYHHnFvLFOFUCBxsFXNjXlqEKkTG6drCXBnR/CSS7rjnQwhb8w8SKQXX+0R7OPX1OaL4GzTrWYHMI7CZ6kw7bnu3jp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujhwxzbh; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujhwxzbh"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84f0d3ab2f4so598972b3a.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 12:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788376794; x=1788981594; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JJm04W74S4Wb9QlOAVLdeVQ4Bthix7lPuSs6v2SGIe0=;
        b=ujhwxzbhzz8FAi76Q9uM54rpVLgOO4HVRhF21r91JbrqAB7r3dZOn/AN5AkVxylj0K
         AGdnUHpT6WG6XDiHNfqG6yWlJMI0THpXGQ5EHfjLiHD1zLXCuwcv5VA3xfKiM7up4NMu
         8GZCHO7Szj7S5GHzmQ1o4YRiVt68rm3YAkbYxKvqFxuPgJz0q36Af9ENVXywsEbfGOYC
         J5wp2IeDciFBVp6RtKvGimRfypVEJM6J3dv/7+iiaYYECeVh2o4sEaybXUtVGBovxO2x
         wC9ShMfZvTZffwPJaLzvw8ty09Cig8j8c14zL9EynEQNsftq63VgOfMGPkv9k8dNZ91A
         TpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788376794; x=1788981594;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JJm04W74S4Wb9QlOAVLdeVQ4Bthix7lPuSs6v2SGIe0=;
        b=eXUbGbpp6IM5/l1+UrPdUzkkeEwRFDgpng1wevm5GaONhwi/mzATtyCAdJR7Qe/qaJ
         TfQQ25JQRYNHO7UpTKIJSfnJ8EwtIdgvLLmPJ7SIx4kmIyCOwqEIS7Ahi41Dj2kcMHhq
         D7p+EomSGq3Paop5LgrYX9eBVvxy9HwOibi/xgWa+WBuBoYY9i7vsnJH1YCNBQUo72yB
         sC5X0g9+t8DenMCqN0n05XZctyrLb3pOp5powSJKVaSWBsSCqlt7wQgmP6p2xWidbsiW
         UloT5uV9kJQ5fxFChNL+TkaPNkYv8Owe44q+mOZk1P8uZOxAgFMCqWkuUWG6dmoqz20J
         WW3w==
X-Gm-Message-State: AFuF++lQqYH/1gfxWiO5C0Z6UMBITb+vYRAsGPfkR9rbGSnxPzt1xFFD
	eyTXgbUFXqsVYK7runLuuRk/9WbrWgbwDd70p/Yv9AtI1wndOYv9KsGbWN0iChadositmBFxzyh
	I35xUaXcQ0eMCbVFRY+tv3IvnwE0s8GfEVTA5oVnvOMXubpXJ0fhnKAXCq5re2NtEoRzTbpCFkD
	SsfKYupR2gP/7Z/k2pGA9E6YmTduf6phDDgEsu
X-Received: from pfbft4.prod.google.com ([2002:a05:6a00:81c4:b0:845:4da8:56a5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac86:b0:857:73e2:9106
 with SMTP id d2e1a72fcca58-85ed98ba685mr11520767b3a.22.1788376793928; Wed, 02
 Sep 2026 12:19:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 12:19:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902191950.2647091-1-seanjc@google.com>
Subject: [PATCH 6.12.y] KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA
 call in SEV-ES migrate test
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Drop the explicit KVM_SEV_LAUNCH_UPDATE_VMSA call when creating an SEV-ES
VM in the SEV migration test, as sev_vm_create() automatically updates the
VMSA pages for SEV-ES guests.  The only reason the duplicate call doesn't
cause visible problems is because the test doesn't actually try to run the
vCPUs.  That will change when KVM adds a check to prevent userspace from
re-launching a VMSA (which corrupts the VMSA page due to KVM writing
encrypted private memory).

Fixes: 69f8e15ab61f ("KVM: selftests: Use the SEV library APIs in the intra-host migration test")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260310234829.2608037-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
index 0a6dfba3905b..6b0928e69051 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
@@ -36,8 +36,6 @@ static struct kvm_vm *sev_vm_create(bool es)
 
 	sev_vm_launch(vm, es ? SEV_POLICY_ES : 0);
 
-	if (es)
-		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 	return vm;
 }
 

base-commit: f717995cb7dcd8998ab15516b8006aea09cfde0d
-- 
2.55.0.970.g62bdec98f9-goog

