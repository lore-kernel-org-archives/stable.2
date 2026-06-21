Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2590184540;
	Sun, 21 Jun 2026 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049675; cv=none; b=hpj6kZvLeCqEZ5Vlvok0gK0q2qMNUFP79NrKrlqd/CsiDlO/EiX80w+BPHwBa1Wfa/G0U33CBUuiDXfig0ZkwYGvBgKPTw+eqgOZhagbqAglTXUwh+FeXMgMWAApewp2CWFTjC/58g0eY6RV910zDf/xDuuViURu3xGHyeImgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049675; c=relaxed/simple;
	bh=2bYUY4z5FOHm6jVp6AJgQDWZjpwmNfPFoX7kbxFp2Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFwa+5ejrNRs2MNGrfpUTZDrhjTMK1/Er4kkCusnLHQuSQObp+Vb11t8/oD9cHa3Tx2SOOaL4HmBKM5qLUXbzqoW39Nf8YMxvN/wTEt0AhdWVQfUIqyD36Nw1T/25P9IAkRqHBA3On+DLDEACB0X2NPDFwEo6+x8KepqpqAkIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXrJACOy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXrJACOy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608E91F000E9;
	Sun, 21 Jun 2026 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782049674;
	bh=/GqOw75AVOZJedE0B+pdnEgrqK9BJ1jbeHdjPtzwYPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DXrJACOy4IvzlKvzKXWZt4IYSap9i6KBIeGEp5SEp/st92saZUVXraxtoTqEZrpFD
	 S1I9kp5QxV8qzgkXGjkT8O8SCti3e1Mc/6YNrbJLxlLxHhHd4iChlCOfV3dR5H2Qic
	 Rn1sdq5PaPfYPTuuEESZ9N4nwJ/KrZDV+dwhVJZANHrKFSwp86W60/Eb3IW7IsOX0z
	 4La1TT9zMFxe1IRwRel9OjVfXtcLqKSOdJXr576rkouofcneJ6NF62ZAomHDa5bVqv
	 af2CRW9uEUhd2KIftMj4XyvkdQBtV+/s1++hJ1tD334FNElqdpzeVzHFUtDmKqkNci
	 Jy3+hymhTmFDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	seanjc@google.com,
	pbonzini@redhat.com,
	gregkh@linuxfoundation.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	0wn@theori.io,
	mlevitsk@redhat.com,
	jmattson@google.com,
	Nicholas Dudar <main.kalliope@gmail.com>
Subject: Re: [PATCH v2 6.1.y 0/3] KVM: nVMX: backport virtual-APIC host NULL-deref fix
Date: Sun, 21 Jun 2026 09:47:41 -0400
Message-ID: <20260621133722.0003.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619203107.2752678-1-main.kalliope@gmail.com>
References: <20260619203107.2752678-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This series backports the fix for a guest-triggerable host NULL pointer
> dereference in nested-VMX virtual-APIC handling. The bug is present in
> 6.1.y and fixed in 6.6.y and later.

Queued the 3-patch series for 6.1, thanks.

-- 
Thanks,
Sasha
