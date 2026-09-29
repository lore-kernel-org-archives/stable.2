Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2238355D87F;
	Tue, 29 Sep 2026 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707883; cv=none; b=RKFk+NSjFHc8+Xkq74HsT/w/hwILoUq22DesRsPRAUc2mzTK7Ezr5iQ2xAr30A+Tjazhp6RvX5RCvZbWZL03aaAMXBD1M7lucKXDwA90rRfJO12yLy20FhoyngUrK7UNDRi97ZocAS3fGUlvRXpz15HDc+qrGHxyN+NwATEGQAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707883; c=relaxed/simple;
	bh=6ZifDTw6ayL+JxLL/VQDz46WjKx+ugscDCGsU6V904o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1fWL+PGm7lhaA0DGcubtZd4wnPs64HFFjhhfKCk8wNn95M3EuboeYuQM2DU9x8j5hLqVWiosAaAp1hdSOFRX56HN2OhQDV816QQ9I8KvIMMw9+dlQ5dFZYIwPN+q/EXhLieUGew614NQN87jET5Tdo0Ey+KaxK74Qd7Cn95Fqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIHKfoEv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIHKfoEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1BC1F00898;
	Tue, 29 Sep 2026 18:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707882;
	bh=qPNs7Rgi+Iv3ryAPWPYU9WVflP8sBYe+8hX6x7y4Bo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SIHKfoEvzuctZnvv9mDmYJc0pCuYcsAe2Ht2WOOohi8uqg3n0XbHXKmWMLp3drukx
	 UhQ8pXixl2GFHMVdMrCjl0X0L/rlc/KFtJP0e9V9LXpTF3ShqK+h58Ve9VTjJj2M3M
	 6vkpQGTnrzlY0xsAWICEKq7LsumTU9LHaWyzozbzFOXteWRo8o8bS4mhR37uL2YbiQ
	 eMZnI0g5x1cxvktvllb+x7FAHL61elLMzweaLNHK8BSKwzpb4bdqAJCRMTRjI3bijE
	 vbV6gAJbamEU0kmexn5ftc3p5ftQsb+ZHBPAs5GGbyLs743nCm1EyqkTWeKnG5QOtR
	 JF5R0N23WWzfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org
Subject: Re: [PATCH 6.6.y] drm/i915/hdcp: Add encoder check in intel_hdcp_get_capability
Date: Tue, 29 Sep 2026 14:50:55 -0400
Message-ID: <2026-09-29-daily-reply-0012-re-i915-hdcp-encoder-check-v2-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929031728.88004-1-artem@trailofbits.com>
References: <20260929031728.88004-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  bool intel_hdcp_capable(struct intel_connector *connector)
>  {
> -	struct intel_digital_port *dig_port = intel_attached_dig_port(connector);
> +	struct intel_digital_port *dig_port;
[...]
> +	if (!intel_attached_encoder(connector))
> +		return capable;

On 6.6 this doesn't stop the oops. The debugfs intel_hdcp_info() calls
intel_hdcp2_capable() right after intel_hdcp_capable(), and
intel_hdcp2_capable() still starts with intel_attached_dig_port(connector)
without an encoder check, so the NULL deref just moves one call later.

Upstream fixed that half in d34f4f058edf ("drm/i915/hdcp: Add encoder
check in hdcp2_get_capability"), CVE-2024-53050. Its CVE record says the
bug arrived in 6.7, but 130849f8ec14 ("drm/i915/hdcp: Use intel_connector
as argument for hdcp_2_2_capable") only moved the deref into the DP/HDMI
shims. 6.6 still has it in intel_hdcp2_capable() itself.

Could you resend this as a 2-patch 6.6.y series: this backport plus a 6.6
adaptation of the hdcp2 fix that guards intel_hdcp2_capable()?

-- 
Thanks,
Sasha
