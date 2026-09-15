Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA83B3B47F9;
	Tue, 15 Sep 2026 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437826; cv=none; b=RokoyfS7qPNCxSSURlm4GoLR1Vr54s3pvybMlpDTZegTVGgI4hdbIoKlGB6tDQq/BwbePyJSghiKHhVTKi0MEYWBggDZNHQpfCu5x5wFTk53wsFGYrsiwdjrii+TLTRyzdDF+7U99FKMnlBYVG4qOrUqLsGjnX+E5POukjPMPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437826; c=relaxed/simple;
	bh=ARPdD6jzXyD68nnDCytZZ4lQuExUHU2X5Mv8/74aIKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmygpEk+vO7If0tCS+8Wvb4ehYw5bi738UIXuCLZ+LilBm1hdgXW4032SmjkugrCcAU3k1yoZIhvUHL5g71UXRHQZ9w7lIYZyNUGAxzjwSamKuP6P4MSVbTJ5AxTdDQRm6s06ePLyJyCYb8ZYEPIi4Qo6SAqpmoM8/wBFMDtHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLKDX8F4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLKDX8F4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10DE1F00899;
	Tue, 15 Sep 2026 02:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437825;
	bh=UNOHjiPcNsc80Nsl2qAOyLD5hrfkaVWOAAQI1V04SOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BLKDX8F4FaRUtxZxbxPptOUqOE3yw2MM8JrHFCS1j4cKV1dcoabPOLazyk4kqNPdT
	 A1riH2O0989lwY4IgiAIfTxRDUPncvka4SHw3Qn7N8uZ+GYPUEYh8haUsWWXR8vHES
	 k1hfvHM9MEPz/cImXlvgOkDv6ggfOEXYHbdtlfp/PeWHODPCEKHm0irUVajIonpoPV
	 1QX20QQpkQ5agtmZYQc71PqKEZzmt6UUh87y/jVFOT6VqN36gSjpNlJvXMEFW1XoNO
	 ZX64SN9JOgfECls9bPrwy0/4LHGUTqC/O3SwDYE4L5VDd/EQEgYxCH2zZb0LjIJEuA
	 WwLpdJeydM6ng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	David Matlack <dmatlack@google.com>,
	Kenta Akagi <k@mgml.me>
Subject: Re: [PATCH 5.15.y v3 3/7] KVM: x86/mmu: Derive shadow MMU page role from parent
Date: Mon, 14 Sep 2026 22:03:22 -0400
Message-ID: <daily-reply-0006-re-kvm-mmu-derive-child-role-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913155523.7423-4-k@mgml.me>
References: <20260913155523.7423-4-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> -	role.direct = direct;
> -	if (role.direct)
> -		role.gpte_is_8_bytes = true;
> [...]
> +	if (!role.gpte_is_8_bytes) {
> +		struct kvm_mmu_page *parent_sp = sptep_to_sp(sptep);
> +		role.quadrant = (sptep - parent_sp->spt) % 2;

The "if (role.direct) role.gpte_is_8_bytes = true;" that kvm_mmu_get_page()
used to do is removed here, and kvm_mmu_child_role() does not put it back.

That works upstream because the field there is has_4_byte_gpte, which
defaults to 0. On 5.15 the field is gpte_is_8_bytes, the inverse, so the
translation flips: for a non-paging guest
kvm_calc_shadow_root_page_role_common() leaves gpte_is_8_bytes at 0 while
kvm_calc_shadow_mmu_root_page_role() sets direct to 1, and a direct shadow
page ends up with a quadrant stamped onto it.

Keeping "if (role.direct) role.gpte_is_8_bytes = true;" in
kvm_mmu_child_role() preserves the upstream behaviour. The alternative is to
backport the upstream role-computation change first so the field carries the
mainline sense.

-- 
Thanks,
Sasha
