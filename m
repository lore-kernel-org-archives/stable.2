Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F1466B1E
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738619; cv=none; b=aHgZCUqmZEOFabPGaOu1U2+Au8/ChC4rcs02BPUu/ZotXvA96WqlQ3INzQ6Fag+65NgbgcsMp1GoXrJhiBgOKRl+PyB5StmDqsn7KQB6DpPWF4PYHu33G0aM8YQOShLZxqqtTMVM1cfDJ6mWd51WIV6Xfi0n7IZWnY0Ls/51zMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738619; c=relaxed/simple;
	bh=bT7dhMRYglh9RjvSfADrpOt8Y8bEwXzzNeDPHXb6s+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMhZ0LvcLXQgssxMNyhvQa55PuQifsyi/LXq+w362+64cpObpFoBd8+NPm+dxUJ4Qn6ivusc5ftQPF80CwRFMsRhk0uBXgOKTPiwJ8qMcQDB3zdvylRKVQJvV8H+DFL6vnzwcDUSM4Cw/GZOw3GvKkxTgME97EjzbvTgARAUEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtvHzHtO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtvHzHtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F4B1F00A3F;
	Wed, 22 Jul 2026 16:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784738605;
	bh=B98EqkCq+D17Ftyj3st3mlInGbQpARP8gkQJZQhsL2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TtvHzHtOH6Q/SElGa9byhZ1wPZLbiI1eSy1i6RiEO6qK2rk4c9GuSYcG9fcKuQL1b
	 7h5MXqyKCyKB/F3Uwne2r1c6UP76zOB4bSFp6r/4Ta4CzEUxHiia2WYtbwD9Mpp7na
	 VFP6ZJ4dLDPHGETvOE6I73FXiNiop2jpjKVL39+S7CVR0iCxUiWyav+UUae81458F+
	 /ztwAV2Eor2HZIi6IdOhAhf/lf9/IbNxmoipykSfift1iGnVQYzybTMFFu6unj2MmW
	 Gn1f0q6G+pD+a1NE4foYoEO3whugEn0fcNODak8b6iP4743VFTAA8DWNo1l3RtTyKT
	 7Idi9V0aijP1g==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] stable-rc/linux-5.15.y: (build) mixing declarations and code is a C99 extension [-Werror,-Wdeclara...
Date: Wed, 22 Jul 2026 12:43:15 -0400
Message-ID: <20260722113505.rc-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178467474395.1334.6033734617150761914@kernelci.org>
References: <178467474395.1334.6033734617150761914@kernelci.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 21, 2026 at 10:59:04PM -0000, KernelCI bot wrote:
> New build issue found on stable-rc/linux-5.15.y:
>
> /tmp/kci/linux/arch/arm64/kvm/vgic/vgic-its.c:716:2: error: mixing declarations and code is a C99 extension [-Werror,-Wdeclaration-after-statement]
>   716 |         guard(srcu)(&kvm->srcu);

The 5.15 backport of 3a0724998162 ("KVM: Move kvm_io_bus_get_dev()
locking responsibilities to callers") placed guard(srcu) after a
statement, which 5.15.y still rejects with
-Wdeclaration-after-statement.

Fixed by replacing the 5.15 backport with the 5.10 backport of the
same upstream commit, which uses explicit
srcu_read_lock()/srcu_read_unlock() instead of guard() - the affected
functions are identical between the two trees. The next -rc should
build cleanly.

Thanks for the report.

-- 
Thanks,
Sasha
