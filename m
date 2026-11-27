Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798902;
	b=w4z4gRWDSPFgDwZoGo/GizWJ3pJVtEi1aTc0e2ACgALwusSROuJxVqujZx2NGGD1eYJR
	 e023BC5C5xT5J/Idoo7y7olQBZMiBKM7Y443ZLcaryZ07f/jW8NhQxn/8/1zrwvrL3NNl
	 O7wSm3/YzZLiVAg43Wf7BJ32IKmN3HsIxHivC/jMzWzbeIsdKSOP9iEvBxW7dJUCHYVmf
	 KE2593L2K2oi+eFuh/hKje43vgJyNelrsr9XB4Xft2b3Gxc8uXiYephs3mPZmOxiKqVLG
	 2X1nB82r56JptNIzBO4JrlBy2846R8aFNtQDtfrdU1vxhlhL63mdjOrC+PnOeNa31zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798902;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lCDljj3wqT2J645H5FJPnLcwZAVCPzo4a/dMK7Mj2yQ=;
	b=FrnuAOf6PwTybhs1p/MYk/SBdM8aWnDArJicyIZYvkxMUsQyEPUML7iULVdYGGIPqEko
	 wBpcrEeoOvEMTuIn4Tc4Jtq6sXRYiskTmOOzjwxlnTLDv+HheLbgkQta5poASvpPXRBTo
	 5I5KBMvjk0nnZlbwhT7Da75SZFMwfWH5W1qM8/TpL1hrt2QD8xD+CC74SQC/b4qKJyipx
	 aI1Zu/256JX5NChT1lcxRHenTgedyL8fTtTV7R+4sdmoIYsXLJRs12jTlxTEWDjzvC4xh
	 RX1570rrhA/eZc4N2IznosLK85i9uuWLbLK2+OVMB26MJ3iJRB0y3KmEyL/1ka7rl6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qs2qTNaU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D4A606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qs2qTNaU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B061F00897;
	Fri, 27 Nov 2026 17:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798901;
	bh=lCDljj3wqT2J645H5FJPnLcwZAVCPzo4a/dMK7Mj2yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qs2qTNaUEW4tdXP1qrDm3MoVcCegOA1yzJgMfvXD1f0mPTX9GEdsEFo5teTrUySWV
	 fBIJVCg2QDaIFhB8FaSE7kyJwk5tHGwpOYVo63gPSpT5vIwT7naYp39QJUrCORrGcO
	 2C/zaKByRtjc8f2CbF5BmOut3S0braDsHQ+aW8oDLNT3UTpgjum744ot4KuHgV2exV
	 D0b8W0s74b707LHHrJ0EGz8H39E8N+zVQpPRgXyMQ95n7249yY3ildYWz+SOqUcD81
	 HHvH8pFQnO3jLju/u2Y1EfGZofT/XMsmJFOkIdBMmgXJNJIxS14DjOd9l0M3zj5ki3
	 YmRhThdgElUyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Daniel Drake <dan@reactivated.net>,
	dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com,
	Thomas Zimmermann <tzimmermann@suse.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: Re: [PATCH 6.18.y] drm/gem-dma: Support dedicated DMA device for allocation and mapping
Date: Fri, 27 Nov 2026 12:00:53 -0500
Message-ID: <2026-11-26-1-daily-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124140251.4131801-1-mcanal@igalia.com>
References: <20261124140251.4131801-1-mcanal@igalia.com>
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

> Add support for the dedicated DMA device to the GEM DMA helpers.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
