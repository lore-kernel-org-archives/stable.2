Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678157;
	b=jR+r9aNJpVH+Fj0tdZnVSzB611/lki+Y5zzpC2Baa0zaO97UEHfsCiH5eyFjWj379gV+
	 Cr+8Uwd/Tnkwn9aJucW3YKBhsucXhm4cQdFjMDg/0Rw7KWaIjgvnmP+wqKI8HTUHBO6tX
	 GvgmBBPhTkxV8PiTT7XQpML6bXe4JcL9/I/nXfO6I71Jaq+o1X5jtxVXwicOp3shcQ/I1
	 1wWqouWVO9WAdp+SuTJ0stikjj0Fds8Xy3IEFIIqMJ4am463kZRXSS0L1behhSAbWoM9a
	 y+ZUCncHfrH2Go1yIiBRSQnn2UUn9VCpeDVvgvER1Z2Amg9hAAvcsPqXTlK9Lxxaifw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678157;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x+KwjuM9oXdXeCX2RZOIg2om2H3cbDlZOxXqnHIexEc=;
	b=dTuK09nw5H6HLzxR6ida8g4WlveshJl+ANWIN54mf69xANNZ3mrhRKjUforuR2Z0m8GN
	 Z2RNL4DgAMSQC/sL2nsK5v6Y3JHDllrNXz3EKdLU5MGRSUT0opMu8sOtx9namPcUI0P5G
	 KqHzPa/fnnmzNYsHL0qJPb6Uz46N+qcTobaslDn2f4zo31mxxqXEqEhP6YBRMWZ0uJDHb
	 9/jLinYfNZZAQ1ov/ykBsFUFKObTGbD8FXagnsGzwQm936SB4+OqI3LQVmEtzudxrTr5u
	 6aZj0BCJg+tgv2JJM91Kmq37fGf89ERKg2o/1f30NRWgSbxd2y02LPsWEzNeGGMXWBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQTQ8jvD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9330606A8A3
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQTQ8jvD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DFF1F000CB;
	Sat, 14 Nov 2026 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794678156;
	bh=x+KwjuM9oXdXeCX2RZOIg2om2H3cbDlZOxXqnHIexEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fQTQ8jvDY2hvr8np4dozSP1NJmVOt3scUsA1fEBrCTtAluFtj4PRYLI/qae/vW2c/
	 qrf1tmA63rqRdtLVx9rINVlwdyRjNmuw+ON6t0Q86ITAyo8bzylK+kswIQh9hGjYtU
	 mWQj3vBMy956FXQdogAV9N/powB7k2c9xGf1SyqIrQZV/qtQxkmWuHHB3xzqdZsMqm
	 XWR5WOy3TtBmE1Z+2s3dFPvq0sjdnlk2hDNLt+p+XSmvfWCBOkqVjxfBTB+6vBvYLc
	 CwfhV2zZM4FKZJr7tQl5YXXb/3bcU5bLJlBpg7aCEKcvYe9QLoqNytKR57LPrsTjRp
	 CPiebwddbCT8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joerg Roedel <jroedel@suse.de>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 5.10.y 1/2] iommu/virtio: Clean up bus_set_iommu()
Date: Sat, 14 Nov 2026 12:42:20 -0500
Message-ID: <draft-agent5-0009-re-iommu-virtio-510-bus-set-iommu@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <e2158cb0-e8e3-4dba-9015-51e4cd47f57a@arm.com>
References: <e2158cb0-e8e3-4dba-9015-51e4cd47f57a@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-13, Robin Murphy <robin.murphy@arm.com> wrote:
> Wait, no - that "now unnecessary" is only in the context of that entire
> patch series (in the link), which was a fairly significant
> subsystem-level redesign not suitable for backporting. Applying this
> patch on its own will just completely break this driver.

You are right, sorry about that. I dropped this patch. Only the fix,
1f8efac19a08 ("iommu/virtio: Reset device before deleting virtqueues on probe
failure"), is queued for 5.10 (and 5.15), without the bus_set_iommu() cleanup.

-- 
Thanks,
Sasha
