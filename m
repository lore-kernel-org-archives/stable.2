Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690813;
	b=1KThRHTpOGS1Q1bd/c0AOgmtFVNrk+1mCHDlZ7pdBYwNevf0lWa4k3G2yZJ7AlQCmGto
	 Y8vDtbn7ew+uoLqFuw6aE3u9D3zzDJ44/yF/WRwTKDzwhtOc25vrSlV2CsIXZIUsolQ43
	 ksdZIiC7aEUoudKVslkjaOdXxiAovpHm3UVnXdkOuaXMC1YQj+rGDAVi1QT4IBaoeELRN
	 eaRX6/JOANpK2rZ1seiFjc8K9kYVOP/H4J0D4cVdFLzv9uwobZwkV67lb6PlUmbWW1cPB
	 iP3RyTgVRpSAgPxw4IVGqW0c8qjVzeNsQntCSOtOU0XWH7qNDYPYgxDpOhORSk0NOkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690813;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hkQTxC/NFuAwVmMKQPX/llja7JxOh4icS3qa3sFNnfk=;
	b=clNm2UtWCYoBynZhgwNtJH00GNsbw31RtBNXw4REUI6GhUlRljcROgPlTnskJPEHl7L5
	 410g2L7T6z6Y7YQrl68EWxZ2jgbi2+/E2MgcMIUXvejme40KQ1/ELz3OQYVKhl7YurUie
	 /snZ5DE+US6GW/quxqvoUN8n/8ZRERh7iujRNfV9+d1gjLc3wleavdLPj07xCwrwGrRxj
	 3YtahyAHxluUlrWc+AkL/FGuYHBAGRwcs1khg35+AGvpE7aIHAbQwMvVSwhWT0SZsjwER
	 +rOEx7wXJAAIe5gSgppHb+/62vHO0ZsRK5rML0Fc3Qdc2qPJBPtuQKwG1CbOh3T63gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IGtN3pf/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E2606A32D;
	Tue,  3 Nov 2026 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IGtN3pf/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC44B1F00919;
	Tue,  3 Nov 2026 07:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793690812;
	bh=hkQTxC/NFuAwVmMKQPX/llja7JxOh4icS3qa3sFNnfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IGtN3pf/FUSc4/tUq2TglSKRRpn52Gyek9Lz7MTay8j766ilA4K9zx4YdCenVxN0b
	 NRh4CKZuin3iE74oGa0DZ3g+mKoLYic12vVD6kYlqFrwqNCiJnyNGPIyDgz4W9Std2
	 Vl7nxE3MQfpSbj7HqVRJkUZLXTqvNH4oL7zeYnoI8QYPV7uuYSdjMpc961EfJ2jYK0
	 XrA/7IOg9dFZ6H9pa7qe6VytbdXO/aUeH1g1Q/k4Wz2tU2TAQmjuopIz6vYgY9WpsF
	 +9r7UXsFJ3rl6vsfVLFNs3SqQYZX7/Zf7iu0Wel1j+Fmdh/h551mBmgNDc3HA2463F
	 O+t8Mn9DlE3SQ==
Date: Tue, 3 Nov 2026 08:26:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu/jpeg: Unwind late software init failures in
 v2-v4
Message-ID: <20261103-pretty-impala-from-ganymede-aa050c@quoll>
References: <20261103070629.1083890-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103070629.1083890-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 07:06:29 +0000, Wentao Liang wrote:
> The JPEG 2.0, 3.0 and 4.0 software initialization callbacks create their
> rings before allocating register dump storage and creating the reset
> mask sysfs file. If either of the latter steps fails, the callbacks
> return without releasing the initialized JPEG resources, including the
> ring buffers and vmid_wait fence reference. The IP block's status.sw flag
> has not been set, so the common error cleanup skips its sw_fini callback.
> 
> Suspend the JPEG work and release the JPEG software resources on these
> late failures. amdgpu_jpeg_sw_fini() also releases the register dump
> storage if it was successfully allocated before sysfs creation failed.
> 
> Fixes: 63d5f8db5313 ("drm/amdgpu: Enable devcoredump for JPEG2_0_0")
> Fixes: d949e91b42f2 ("drm/amdgpu: Enable devcoredump for JPEG3_0_0")
> Fixes: c3dddd602967 ("drm/amdgpu: Enable devcoredump for JPEG4_0_0")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 9 ++++++++-
>  3 files changed, 24 insertions(+), 3 deletions(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email, thus I doubt
   that we speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document usage of LLM and what you should not do
if this was posted in a good faith.

Best regards,
Krzysztof




