Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D11FB1;
	Tue, 15 Sep 2026 02:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437828; cv=none; b=JdmHRJUuXNL+PKoKQDqHWp0/xz0Na8lGJ2KH5Hy5zJPNVhcfF7/YICfczK8e5aHbjRvFX03d8ZeOWlMkfJ00nGYPMkj5VfulqgNzol/l1n7SmLJEYfcatXhNxp81c4Mp82nuFyuR1TThO3v4hxCm5HUDLUkUIaG7QZQn+fAVFLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437828; c=relaxed/simple;
	bh=8Nb/TuUKf0ErkklUDHBoE8v6d9dN44X4ce2TBRqCEPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAFSe7wKnf1OJygrTht7Y4w+naIYfK/GnQtDrUGMeLntdcn8Yfl2C1qcLrnVAZP5TrBF6ADhCK6sJjdzNokTOmA/JZiLIrnpAZOppxqcl21uYMJmQT80qF/nFIkkhm53cEYoorbixzl3DApEI/SfddS9q+4W4mGHgb6LrDf9r30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiMI521/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiMI521/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01171F000FF;
	Tue, 15 Sep 2026 02:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437826;
	bh=vFXX3vE5kKNE5Fr20YNEvPom49fPVRpjU9VLLkmmAng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZiMI521/Rm+nwsNoY8Kr34DHorboLabrkX1lA8QEEUTayE8Hk0PywXZFkMTM/asE2
	 nTw9AUU65UhTKDs/B6aj0QRQkSdtVKuC2RuCI9qExTM+ZeSGg7CzphcPu6ENehxc1M
	 +aD1PCMdf4uLI/eE8tgbf9bOfC9VpbJDzQILeeIkX3nKSgI33qXjfGd6XjX8tFV1bH
	 XUeHiWd3qR9ldxPrto4OanSA2T1GeZikk0/A9qcJVQvx+1aPRlJrIdY3GgHl9AIsRi
	 TizWTV9DH8AN/eCm488luGo610g3ZCro/ZXN7ptZcSHjXjQP0XEn+FbQGGCuJjiy9F
	 lAK5sDehLW2ig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Matlack <dmatlack@google.com>,
	Kenta Akagi <k@mgml.me>
Subject: Re: [PATCH 5.15.y v3 4/7] KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
Date: Mon, 14 Sep 2026 22:03:23 -0400
Message-ID: <daily-reply-0007-re-kvm-mmu-quadrant-warn-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913155523.7423-5-k@mgml.me>
References: <20260913155523.7423-5-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> +	WARN_ON_ONCE(quadrant && role.gpte_is_8_bytes);
> +	WARN_ON_ONCE(role.direct && !role.gpte_is_8_bytes);

The second WARN is guest triggerable on 5.15 on any host running with ept=0 or
npt=0. For a non-paging guest kvm_calc_shadow_mmu_root_page_role() yields
direct=1 while kvm_calc_shadow_root_page_role_common() leaves gpte_is_8_bytes
at 0, so mmu_alloc_root() hits it on an ordinary guest entry. Under
panic_on_warn that is a host DoS.

It has the same root as the 3/7 comment: 5.15 spells the field gpte_is_8_bytes
rather than has_4_byte_gpte, so the upstream logic inverts when it is carried
over as-is. Keeping "if (role.direct) role.gpte_is_8_bytes = true;" in
mmu_alloc_root() and kvm_mmu_child_role() covers both, or backport the upstream
role-computation change first.

Patches 1, 2, 5, 6 and 7 look good. Could you respin as v4 with those two
addressed?

-- 
Thanks,
Sasha
