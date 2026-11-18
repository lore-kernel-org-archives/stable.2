Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005659;
	b=vMGj22EMu9Z20PnB0Hfl8pO3a4w7tsquQuTdMiHPLh2wVtZ63uxozJDNL9Wm8IWE/0e8
	 G3Q3AXwtcdbedHks3/qgAil6zE7Nl4FKjJerju76/ATxqqaTiCzeX2ZEb+g87ZuEHIj/C
	 nGTfrx0OHkXuyA/3ombVMFHBhY2HazQbWudr2abWdZXcYIcx7A/Jyd+9peaWjnXpqphVP
	 cPZbnvtQAXk64uan81R3IPye7jBfTwu9OWJ/i7XR76NFuApzf2J/Rv9YiZ5pTo1KpNKfl
	 zKWMKSjOB40KeBCZ7GbG5wormhf8ACtSYx34Azk3/TLfIf/FRRqj4kzQOgcuBJWJcDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005659;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=VZ51au4RonPigHEfbkNsWVqDM0KTWvC8Bkvcgfsi/r0=;
	b=clsD18tApKSbxnlXCnjeYRQhHhN0v8HyADgiFSsZA/dWQoHKLK+yZs595GvOOjrvUZDr
	 V4dsc3afkWRbu162h0demvlGoOQNDwMNjVziW1qTQg1PKWR6MnaTWL6SqqbpDwA0G9i78
	 xAHYFSOsSNc0P2j+2DP3swM3Q2eEpMLK5cDHSkIKkmtRPnZJro+ROEG5s4JcLpAzNeXSu
	 b18TJFq0+NZPwkzTkMRjUiXMmGDYlJUFHgeUj/UTgdfyS1A2O3+N+ERt/0uuvi41cshWA
	 PUrsiKkBg+9yOs+jCiO7W2rtH24Ph8XimrpYYc1kLN90e69RjWvalfuzfqpgh/AO3YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ex/cmMe5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056DA606A320;
	Wed, 18 Nov 2026 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ex/cmMe5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814C31F000C9;
	Wed, 18 Nov 2026 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005658;
	bh=VZ51au4RonPigHEfbkNsWVqDM0KTWvC8Bkvcgfsi/r0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ex/cmMe5bYC5eWxfcXVWKFzUvQ2k36gWLlFLC48Ih3lpzVF5Ayu9dEH49FU0xpudu
	 Tn0tK2Z1zqowhfaQUWqEN9dc9ah01Y0LqldcJJl3hyq4v4MMrN1Crr+FTdN57Rx3Lj
	 Ku5kaZ2V/QpI20q4HTqUMqKeWvLM+9HJWlCDlsD1nz3T6cKz8+nNYXhtRF8qS2XnmW
	 w2SHyoo/J7v7i977B9NqcFIk/mA98C5Z/8nvlo5QnLEs6WJEfCA4nmshFIz2zEX2tf
	 GXqbsXkS0aMEdM/gvSITQa2L1u9JqOQ1bQXhBqCYnsVD0V/mRXfAIr917xWR23pLPI
	 5X863xrPlShsw==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>, Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261112064009.2313455-1-joseph.qi@linux.alibaba.com>
References: <20261112064009.2313455-1-joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] ufs: free cylinder group structures on late mount
 failure
Message-Id: <20261118-pfeifen-reift-heimfahren-8a2f3de7729c@brauner>
Date: Wed, 18 Nov 2026 13:40:55 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-04696

On Thu, 12 Nov 2026 14:40:09 +0800, Joseph Qi wrote:
> ufs_fill_super() reads the cylinder group structures before it creates
> the root dentry, and the two failures that remain after the read, a
> failed ufs_iget() and a failed d_make_root(), jump to a label that only
> frees the in-core superblock information.  generic_shutdown_super()
> calls put_super only inside its if (sb->s_root) block, so with s_root
> left NULL the s_csp allocation, the s_ncg buffer heads behind s_ucg[]
> and the UFS_MAX_GROUP_LOADED s_ucpi[] entries are leaked, once per
> mount attempt.  Neither failure needs an I/O error: ufs_iget() rejects
> a root inode number outside the s_ncg * s_ipg range the image claims,
> and s_ipg is not validated.
> 
> [...]

Applied to the vfs-7.5.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.misc

[1/1] ufs: free cylinder group structures on late mount failure
      https://git.kernel.org/vfs/vfs/c/0f97da93e617

