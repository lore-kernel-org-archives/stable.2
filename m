Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A2646EF64;
	Tue,  1 Sep 2026 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253195; cv=none; b=LCMNM+c0Q/HhbRCu5XqGK0Y59+YjqCiBx0y1fI7orhT3NBApkO6bqDWMvP+ahKhGib+X40JEFkbfJHKMgeAp/q9wnDIRxCIk+LBwPiOrSPawJivXlgzI/eFicY/eeSdqv8e9S72RdmeU7Gt1/9dVhoLPgeV9xOiUizLJqQMTmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253195; c=relaxed/simple;
	bh=bnyuPg/Ty1U72DMypXFTbbpj4WL9CAEQSzCfmEC0+ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clczlgWuY9FouKAqq5Owujj9vQXPtpn7dboQAcg/6ajFFfxs+svk1IeNAZAhi7TqwQkFguZkSPpFPxepRA8h+5YUVMe6CYvn2y6adtVhtbVakQ1gbKjU54ci85aIWipw1e5NU4nFV1F6Ez6PGS37orm3gd9lxaJdSIeBORGDTXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji8DgA39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji8DgA39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D681F000E9;
	Tue,  1 Sep 2026 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788253194;
	bh=I4tVjKFRMCMBEBYtZ/jvpvYXOEsbsYRbHOBLaaKAGe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ji8DgA394Ucs/DIGdUZvv+n72muWpoqGsh5/E3KwLC2BwopSMEKjDkoZ6/keUiJbk
	 ejJGVXlbeSrcUilODOlkpuMRCqeuNR8JM0Xkiy3IDpVCsH4kmRrh9v4IY+9NRMwL/Q
	 hlFxEfKaMBeFZwq6oh9qdzOAMiaECP3vNfBxWi61NXMz1UYI6em/b7dxl//4oZAfgf
	 O1y/UFAt6WrPOb2xg8V/CjHcsz5PtPcjFqBSh2bdmTPuMj6lmGg9ZyarQoJBnZQ0cg
	 h9VOhtMw4kyjex0MhMtmu2bYQYXZTWK93ZstVzxI1L0spDrSHjUO3GbfAl4XQY4GHp
	 FP32OZZU9rsnw==
From: Danilo Krummrich <dakr@kernel.org>
To: Zhenhao Wan <whi4ed0g@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm/nouveau/uvmm: fix VM_BIND submit/unwind error-path bugs
Date: Tue,  1 Sep 2026 10:59:43 +0200
Message-ID: <20260901085943.4360-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 11 Aug 2026 16:46:27 +0800, Zhenhao Wan wrote:
> [PATCH v2 0/3] drm/nouveau/uvmm: fix VM_BIND submit/unwind error-path bugs

Applied, thanks!

  Branch: drm-misc-fixes
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/3] drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_SPARSE op
      commit: 412a6ceb56d5
[2/3] drm/nouveau/uvmm: fix premature region free on failed OP_UNMAP_SPARSE
      commit: ccf930812f23
[3/3] drm/nouveau/uvmm: clear the dirty flag when unwinding an OP_UNMAP_SPARSE
      commit: 38a62306c426

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for Linus's tree and should land in the next -rc
release.
