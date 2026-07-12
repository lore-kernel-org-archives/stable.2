Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBEC3B3BE5;
	Sun, 12 Jul 2026 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888066; cv=none; b=qUlauKminBwWld+u36Mh5WpLUZmYLU4kPNnzPUPS/T3eErWu7mb4X0s+MBpNAPeUICra7hWiUvtvJbXbavBSxOVhhGmLl120F16EleHuRr+L3vwOR/GHGULJm6L4brnifISEN3aytrogs4EnN8k/WLmwfUl98dLKww9XLVfSStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888066; c=relaxed/simple;
	bh=6dPdycQapETU/6FVZ4fM8K5f4LwmxSh3/NHEV6RVMsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCL0zWvJU9QJGWBUHZnAHxWKW7l1OVdlTXcv7YEXA1h4Cz7+SW9hBU85PoSCpkiB/tC7hGqtgOhmlwwdbkA74L7adtDy0R8uFKSr5Vw7XIGxD/uuL9wL9ENEP/GIQzhKeIwMgB3zjYsv10rfeFBMYu7kb2iyXViTLNCvpFpdtrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw8xIfP5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw8xIfP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360F11F00A3D;
	Sun, 12 Jul 2026 20:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783888064;
	bh=i6qM2ljPNBNtbIwvvR/qc0H9t7ATjbEWRi0LPPwUoqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mw8xIfP59+fjSKTkqX7mHUi+1ypyng9+KT0aKi+ftsEKwMtg9CdvtVWKhJtUuULLT
	 Zy1bkPIFNgl8/7RFClUBW5UKVjn8L4TYK8o3Ila13Z8gwr0HT6ylvIOK5OIcBStuLr
	 vBnA188h05vBLyc87asRmB0VXoGMrriFImXvdJcFRT2K1oFvTJ0DYzmaL4wgfLPWad
	 GBiX2k/owxbaiRINTtKvhmJTcUxIFksliGWQIDq/Wnyr9ioInfbDWPDBX2TQW7NWPJ
	 DuzVfrtAHWRAOx4ojDnTVNIq6o4yn1d8hZ7Ecr6HDMWVc1gWUVaVxcgNIsTEbP1EAv
	 az/SCGhxYZfIQ==
From: Sasha Levin <sashal@kernel.org>
To: "jose.souza@intel.com" <jose.souza@intel.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"Danyil Demchenko (student)" <DO.Demchenko@student.han.nl>
Subject: Re: [REGRESSION][BISECTED] drm/i915: GPU HANGs on v6.12.20+
Date: Sun, 12 Jul 2026 16:27:38 -0400
Message-ID: <20260712105304.agent5-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <MRWPR01MB12852A981954ABE86057B04AEBBFB2@MRWPR01MB12852.eurprd01.prod.exchangelabs.com>
References: <MRWPR01MB12852A981954ABE86057B04AEBBFB2@MRWPR01MB12852.eurprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> GPU hangs if i915_gem_mmap_gtt_version() returns 5. If set to return 4(as it was
>  in v6.12.19) no HANG occur. This happens on v6.12.20+ kernels ONLY, v6.6.x, v6.
> 18.x, v7.1.3 and v6.12.19 are unaffected.
>
> The actual commit introducing this is bfef148f3680e6b9d28e7fca46d9520f80c5e50e,
> but it doesn't seem to affect any other kernel tree.

Thanks for the report and the bisection. This looks like a missing
prerequisite rather than a bad commit: upstream merged the remap_io_sg()
fix 2e0438f9c3d25e ("drm/i915: ensure segment offset never exceeds
allowed max", v6.14-rc1) before it started advertising GTT mmap version
5, but 6.12.y picked up only the version bump. That leaves userspace
doing multiple partial mmaps against the unfixed remap path, which
matches the wrong-PFN page fault and GPU hangs you're seeing. It also
explains your version matrix: 6.6.x never got the bump, and 6.18.x/7.1.x
have both the bump and the fix in their base.

I've queued 2e0438f9c3d25e for 6.12, which keeps 6.12.y matching
upstream instead of diverging via a revert.

-- 
Thanks,
Sasha
