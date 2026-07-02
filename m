Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF09242925;
	Thu,  2 Jul 2026 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952730; cv=none; b=GGpcph2XfG4kidhydQIrzl91kZCby3vIJzs0qWcDSCv0riF0g+YXLvOUi6R7y68MN65XdmS3zy+XB1Er8mgg5ywkJBgChzTxV9wO1PlDJG5+aLTUGs+xn2FqTCgxzemFjthbGFg6T+X39dwJpkjTvZJACmvLYVPF5dxxJysE6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952730; c=relaxed/simple;
	bh=3eaoi2HWX1iTWgJk0njPWCSzkD74duN7e42CgIopuWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sF70m6cJtZj+Peg8MlCGpsZSFTefTQPurTIfYYNrANn/+iR80UjT8smi+rIBquDBpz1/Xl7q7NqhcLG4EQj2N+FbaC3CFQbjT+6GeYMfqIZgZFVSxxg9xJzQA7gM/lo4Wa+1YjjHhVqvAFpm3xDcYWpvsWd6ZxOUEgjkoKT2eK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl4ToLj8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl4ToLj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391D01F00A3E;
	Thu,  2 Jul 2026 00:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952726;
	bh=owwG2+p5ORursGxn/KUTmZwkVJhRYTch8Poq60cJ/cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dl4ToLj8kzu9RWIiAaWrdGkE5aZimpeMQ7Ja6hj7La6jUUhK5zHwW0GzTKWsgbcxZ
	 KDaWq1oZVpALPZWxMSfFodwb/cbPRMtIf8OnOgf+zMdLvl3VtsfGqQT/cPJSBdW6a/
	 oo+FaIX8dt80Hafwvq+JPytvY86DS4PtDCvUAh4j9z2brySB7gUsxFN69CNRpYJH+1
	 Z4L4MPfkAoYcNA99btVS0Oo+lkmpCo79Mok/eXTpMdL6UsmUALM7TkOTLR6sjVbXbZ
	 o+UciDuQ7JSJmHvGOz5WMlQ+FFxQqHLRuk8AbNFjNXCmCKHmDFfDTzFFVinTbbWJ0c
	 qNFxlfErhH5aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.12.y 0/2] KVM: SEV: Backports for GHCB leak fix
Date: Wed,  1 Jul 2026 20:38:29 -0400
Message-ID: <stable-reply-kvm-sev-ghcb-612-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630172204.279784-1-seanjc@google.com>
References: <20260630172204.279784-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Backports for what are effectively patches 2/4 and 4/4 from this chunk of
> commits (1/4 and 3/4 are already in 6.12.y).
>
>   8618004d3e89 KVM: Don't WARN if memory is dirtied without a vCPU when the VM is dying
>   08385c5e1814 KVM: SEV: Move sev_free_vcpu() down below sev_es_unmap_ghcb()
>   f041dc80de4a KVM: SEV: Decouple the need to sync the GHCB SA from the need to free the SA
>   db38bcb33110 KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free

Both queued for 6.12.y, thanks.

-- 
Thanks,
Sasha
