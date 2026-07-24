Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259E7431E63;
	Fri, 24 Jul 2026 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892174; cv=none; b=H4PknNkn6PxO4sfE1ZPBOAB5t1H3vZLQAnf5Sf8FzJpEhFdq5ShGjNA39pgq+MLoaLOvB5ncygikX4Zy0SU10DgL17yEVaYShCmm0yzbvj1yp/fRBvwCpGZqz10nzUr92gxdpLDa2nuRk4G6+lezHpPGjXAl4Ixlri0U4hrhiD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892174; c=relaxed/simple;
	bh=4fXa5NVx47dZPoKWB0pPpxGxl4aXhkbXiNMMjEDHYHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmxxIqFiiBRpDM4Ew59BKXseAGnpdeuX5eJLPGgELYv3fZJMKWnW8FqK+XnlvKoN6sZvpcuLmsdQViAfhi5bxYQJiikFLqc/YkuphkklZ4HJgmn5TweTzuZI0DOzWslQE7NmlhKr631Lsc5qUW4qSMy765cNI2ZyJv7iQL3f5G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Seykrs2/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Seykrs2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334281F00A3F;
	Fri, 24 Jul 2026 11:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784892172;
	bh=sWCCRM4J8I7KfSWb+7oVbvu9o7dlKIooBgBdGopm9g8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Seykrs2/91wL1u9XhvrYkhTI9GuHYdY2YGYVaL9ZMm9spbswVt548OSAROAzSWjTd
	 WNPxl1s0wD7yXO+TZSgpLwd0CSQlFdqjAgm65YmXAkT9PikfepkSblCdadbEmXs19R
	 2o9aYLyBftaWkpFXKoSYt21WPS6mmEmuVlet3SyKkYOK8CJvj+5TPpsxHm3jYrdOA0
	 8BD4aBzL+W0W1CiqgzcZHAXBqBzEQYRO/clDNu9jesxdoUeId95OQGpYuWvpWmyKwJ
	 6AsqWTRzqIgpIISiHCSMK6JsYtVHO4FnvGXh6A40sd22CqVN+5vzN/ass8Ud7Ilhvj
	 VUDzG5NTWotHw==
From: Sasha Levin <sashal@kernel.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: Re: [PATCH v2] drm/virtio: fix deadlock in display_info_cb by removing hotplug from dequeue worker
Date: Fri, 24 Jul 2026 07:22:36 -0400
Message-ID: <20260724105500.stable-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <amG_T7Kb7DW3VTxm@nuoska>
References: <amG_T7Kb7DW3VTxm@nuoska>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> In Yocto distro, this change released in v7.2-rc4 seems to fix quite severe qemu
> boot hangs seen with 6.18 stable kernels. Details in
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=16217
>
> Please apply this to to 6.18 and other stable trees.

Queued for 6.6, 6.12, 6.18, and 7.1, thanks.

-- 
Thanks,
Sasha
