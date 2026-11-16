Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824417;
	b=hl/5uKcr6SMTXfaZsZZ1gmntupRfxza8/jTlVvTUhNgIlabcyZtv5C34T6R1yt1FmEmI
	 rGK2WXfLnle/b0rBBHzhI63vp4hzCuUocs2HXovqrjolK5FuKwjbKFbBCCXZsMwpHZRQi
	 SMrcDMKZxqt6rz9UibbOA1yukulN1ueL1JBOl3sE44ZwqRb+v+uUiJFs2COmAXulNc44d
	 A5ZLNCPBmKHlapqcNSAcs8GJRqXnD+lvn1BIq6rPGqTtDgFG6k5Tix0qU6nvRK/b8DkfY
	 gtnwVQ1U8FnYAqto5sLU5mNrfbqdot1JnHAX23G3E0z7G/1pT8MEtnneigXHx4/HS7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824417;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Vb4TTKfYqIZTN5fiptU5W4ujJwX93XnLUqZt87e8R20=;
	b=rpgC0UaduFLo7TJlQhsrjyC9ryDzpJgOTKpnkrOH8tBBVv/1DaCttNPK+kFDX/gdLNV8
	 lJpdrHvkLWt2eGMyYw52mvoUi0qAunnldDnQtm03m6VyDCI64nHsfI5Mp/r2XqkjKsDW4
	 TIWsMG4n/IJo5c/MgJPGQZAy1UKZj8v5tuCtE/RMzHWDW0v84lmxzGJsacBDOtw3Lc8Qs
	 nliNHv5mqQmKABwId+LsfDhUh3QO2aPI3sR03wZ9/eq79eMe+4lj7qdPg2GNLskyXM/H/
	 sdxGOdTp4zBXwvHIBudbbEhagF3D3g/06zT9lSlnO1O89zjXxCp1Nh9f83VCWcglJeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGhOvMqG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC2606A32C;
	Mon, 16 Nov 2026 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGhOvMqG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C331F02828;
	Mon, 16 Nov 2026 10:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824417;
	bh=Vb4TTKfYqIZTN5fiptU5W4ujJwX93XnLUqZt87e8R20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VGhOvMqG8pJN3LVjErtGjUZUjRNRUvhkegPXckP4ZDMvLqJcfCZn4iwnlJicd1WnU
	 LgWVlAt6y42O/NXch/rwOhM4RrqTqXuNNqnKbPODH2vsuhKXqqoT5ktOPSGW/e3/JM
	 LH6RBHPSKGhNTNEXvrV+0QPeOk/dIIVlSMnd6n0J7CNKLR9hVMZILPjMYhIMn0xzXw
	 xMF0utsRhnY2Mt84K15qVsGkl6IX12MEodyjYGeaEi7rnPe6EFbL3+P81kLL7XMPKb
	 qO6fZ7qz027mVrgAPY6/NhaaM2r7lWO0TRG/hcyn6VhuGWIVk0VAFTWoo6c7hm+s8+
	 qhxCe5WzrR5Xg==
Message-ID: <6648f693-ca76-4edd-99ff-9fd60e71fd15@kernel.org>
Date: Mon, 16 Nov 2026 10:20:10 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] fastrpc: fix probe-time races between rpmsg and
 userspace
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
From: Srinivas Kandagatla <srini@kernel.org>
Content-Language: en-US
In-Reply-To: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/26 10:08 AM, Vinayak Katoch wrote:
> ---
> base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
> change-id: 20260923-fastrpc-probe-fixes-30c1980b50e6
> prerequisite-change-id: 20260609-dup-sessions-ea2acaac1994:v6
> prerequisite-patch-id: c8b4a3873f9cf0d69beff0f608933ae83faa4c47
> prerequisite-patch-id: 05d9299adf4184e0e56d97dc063ab5bf227cc5a5
> prerequisite-patch-id: da0a3d55397a522ea4b77769e387df9faea8e024
This series is fixes and why is depending on enhacement patches? It
makes it very hard to pull fixes when you add dependencies to new
features or enhancement, Fixes should be independent and cleanly apply
on linux0-next

--srini

