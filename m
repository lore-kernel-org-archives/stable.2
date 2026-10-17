Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985252D1913;
	Sat, 17 Oct 2026 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792272895; cv=none; b=dmFQCM2m2xweLlH3UeU2KumcV7l1GRjV42MfDOmlsoBFgL/sNbYp9rX83EjSkqxtd2px2Kf8mCS5vJh8khe2wofl5VBLPAnLVQvfn/3JhP3ZwRhJBbzy1gPnSjNFD/81pTE06w+o8ArE/LV+F7MzxsJg7G4oPeLTIv4qrsJBAhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792272895; c=relaxed/simple;
	bh=Jjg7lhbjyF47ucAWQBQcuupb/fYAHDw06nKAquS39TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiSz7PzigaR4oxU5DFBo13q/Vo9MeJAGuC5Xy2Ezly3XeEmPaVq8tiSLYiieLII3d7VgMGo0N+wtZc87guNe3EpToBPWHg7pWbMaNRyoeEYgyqT4YqH7v/3CWEAMdwZtsBX65kAGyKIKB0A1RXeEY38H/UV0JWq36l3RjtH2XfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR8+RvZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR8+RvZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1361F000C4;
	Sat, 17 Oct 2026 21:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792272894;
	bh=b3tNsw/rufkVw2FNUIlrH38fofVkuarcnlw5luS4Mz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OR8+RvZxJHGOW7Sd3HpJ2zdw8XaPtmekJ9tzoawMjzBEe8DIjfp3YXmsAcsdFnirS
	 kjHS/rcg9SGvv1BPOn6Ev3Z91kzQDq6f5tZyRgw4E0IlJWWtH0o3DyrtMJOowYYlYZ
	 StzWP+/CnFTCqC3d/A4rF62S5AZ5PhsYk1dDXudr0rc5CkZWkLuFtsfew4zmFQn4j3
	 zrR8ilD7oKlLLZogh4JPruSiIwbKTbGxSMKobAkJu5+bIG3YAHqC3i/xIcSObyg/NJ
	 ccLoi4qHA+mtUPMzWKxwW7rd+4d/Uy6BZxv5E1E19TQClqf7ok7TCUWGqhL204aNUg
	 oDvqrPSnMoxHQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/gpuvm: skip setting kernel_alloc_node range on overflow
Date: Sat, 17 Oct 2026 23:34:47 +0200
Message-ID: <20261017213447.12656-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261012-gpuvm-reserve-overflow-v2-1-519ef15e2172@google.com>
References: <20261012-gpuvm-reserve-overflow-v2-1-519ef15e2172@google.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 12 Oct 2026 09:22:05 +0000, Alice Ryhl wrote:
> [PATCH v2] drm/gpuvm: skip setting kernel_alloc_node range on overflow

Applied, thanks!

  Branch: drm-misc-next
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/1] drm/gpuvm: skip setting kernel_alloc_node range on overflow
      commit: 5780281c4588

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
