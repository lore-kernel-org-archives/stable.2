Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779906;
	b=Uf6GeQVHIDM2GYKgrmiNzdPuOJWUl6vww+jkGcxt8vCQsOzOS6ekbLduXgnC5VoIq/7N
	 vEmS/kkMnmv38Rs57fgibqHQ6k5wB0fwLvJpuZqM5PjT7z34a2DhNyxfvsBftDpyd8KCa
	 t7htJZirVcjC/1ZbFAzI1aW8IQOIxB64JTkEJYHLJ0Kqz2RML3763WtvcHzgntUoPt/4R
	 BVdKjcXq68tHxYGutWBi1sf05yaZZegbK573LZcE9XYtWPBPx1YxIB3RF0jhd18iDH35k
	 0EHSS8pUgu4QFlCMgU0q0CW5VRplFB4DF/R7vKuKZX1GN73usYAqzVRhr6N+V/5dfhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779906;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=IM/zWShc0hYOKqUKcrt/IAaGmyLjPyaK1b5adG9uu4c=;
	b=hUe/RHgrVzwfWEpG8LV+B6jDkr5laDZOHAJzSPM1aDRCiLZaGiWozUtMmiEGWj7H4gme
	 w/lIQpf8le2KFG5hk8gkV+utW+1kBf1vbmd3vSm1HXjyTDDtRcIVp0eeV/EqvCkCn/vWe
	 jiWOV1PfxewGah62XzKBfKiqmn5KxtNeIp8gwf0p33bfB0jWOfTxEYGY8qB+FUaBuSeVk
	 zsP9QIYE4EhY8AOexwmH+kNi4JzORXzGjF+/ASj9oR1Piy5nyjWWV0ziYqlGcteahjhqx
	 iDRFc/GZuLpaFer6lRqQCIk3R7yblety9T3mF+4bchc0yQDFUm2v7aseR1EbL1mNxhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5NSuymV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B7606A31C;
	Fri, 27 Nov 2026 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5NSuymV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941A21F00893;
	Fri, 27 Nov 2026 11:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795779906;
	bh=IM/zWShc0hYOKqUKcrt/IAaGmyLjPyaK1b5adG9uu4c=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=Z5NSuymVw5Gx0vQuodvEF+/eMvg4ArrUnitEiUYv6xsS9yL3d2UC29zzE7ZA3oTXe
	 l4gui5m3Nq813ghQl5Z7lj/4pblaO/FWce9LvKE74JCZY4sX+F61eWCy5HtTkCQ39d
	 o2SWbHE1YGK5QQGhn0ecF8tqXkEF3aOm2JQO/VMzFF4eAdjkV9oJq+VY6VUOW1hmgS
	 rDp7qKwjl+moi668DGx1JMVBIjqFCEEF2ZtbXgdmUXsAIfBscPFMko1+XsWEdpvCF+
	 KGQr3k0MdJHySAnLWbRyK5JIW3wtQdvv4B5Q87drvODspN/u8xaKPQ4Vg3JBCXtnp8
	 Tg6IM3979dcrA==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 12:45:00 +0100
Message-Id: <DN5YUHBCE0HD.NVOQNS6BD9WQ@kernel.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: Hot-fix timestamp misordering
Cc: <phasta@kernel.org>, "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Alex Deucher" <alexander.deucher@amd.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Matthew Brost" <matthew.brost@intel.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Mario Limonciello (AMD)"
 <superm1@kernel.org>, "Aurabindo Pillai" <aurabindo.pillai@amd.com>,
 "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>, "Gustavo
 Padovan" <gustavo.padovan@collabora.com>, "Chris Wilson"
 <chris@chris-wilson.co.uk>, "Luben Tuikov" <ltuikov89@gmail.com>, "Shashank
 Sharma" <shashank.sharma@amd.com>, "Paul E . McKenney"
 <paulmck@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <stable@vger.kernel.org>
To: "Philipp Stanner" <phasta@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261126172046.2473303-2-phasta@kernel.org>
 <20261126172046.2473303-5-phasta@kernel.org>
 <71b2506f-8534-468e-881d-1abf8f8224d9@igalia.com>
 <69845631bb184d86b4af8b4143b3b7adf726e0ca.camel@mailbox.org>
In-Reply-To: <69845631bb184d86b4af8b4143b3b7adf726e0ca.camel@mailbox.org>

On Fri Nov 27, 2026 at 11:30 AM CET, Philipp Stanner wrote:
> Reason would be that amdgpu only ever runs on x86

I think nothing prevents plugging an AMD card into a system with a weakly
ordered architecture using amdgpu.
