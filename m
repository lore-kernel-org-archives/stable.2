Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982967;
	b=WnsSKyTD4jt+CBdqul0Kt8cnbA4tsD/eSkbPmbglAeDrR2Lw6mxFfg3qvvyFY/XMlqbe
	 jIyl9ZgFpgxtijvJojBkAI4MNhjHcB7uEB0qikxd4bFabnFcD4H5o4B4nZRHxLTds3iqa
	 DqxFjFi1LR7WvsguD+CYCM/M+f6+ncGDNpkFsWgP5Vi0ZQVX1JZmMXdvwywaNarmYX1Ip
	 UIjRTyVbh/No5KJRj+niNUIzT7DPDWdeRzZRK2Jh9Xi2MQX9kdcx1AVAQLGm/lD3OYsxM
	 Zg2Ckm3Vbp7j2o+X05M5mflZ4yeBMRj7yzlnyHRrIGbV5RGnNpL4VgKjP/e9+R7Fs4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982967;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=byvhFFQ+tHo/gn1Tpg+9fO6+ecxePzZ/bworx2PZBiU=;
	b=0QT0NdCNd7NrroPOBZPLGM8XAu3CBNR95AS39nAW65XLqjsAI2Ron/QOQTq/posuDUS8
	 It4tz7KO83PRC4mT/w/U4qcazYv5T8ZdAjqvcTsOXlE6S2J8/bdxWiNGbRF1tudz/5fEo
	 3crRJYhacJngm1LS7g2fqnsGy3Tt67HP2gsk27Xlu16i7B6FdckfCbwv4HpA8aylHcwyU
	 im8VGbR/MOgoTZQIIFyMmsfwFuJDZ/5PJIfvbZSmsmNbVVKIBjoCsr6Sunq1mxDdjZXdB
	 NgIGx95waaDWPA/VzjXidb8bOTd6nRUy7t1IfBfamsfsPUCvXWVAxnIkotdkO/k+0BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGAlyg2w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45747606D825
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGAlyg2w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479241F008A4;
	Fri,  6 Nov 2026 16:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982966;
	bh=byvhFFQ+tHo/gn1Tpg+9fO6+ecxePzZ/bworx2PZBiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LGAlyg2w+GRx/71w+D/6jTjQ0zQRfFQI73bTQSp9CTBLQDbU3520KjEKa88AUQV/F
	 n97SG0jIBU/J+4f03SFMsV/k5Mi6YzOwh/vA1b+2JC4+R/fUuHJ+ootmkngwC6h7Zq
	 c6RiRxRytGnKultsfoKuPkjyI5lhgoBqZHjzbx7xeotBLuXKN7/X9x3XVMfK/fjnHc
	 GEEb/p3YTZHgHWhrgHF3F2E462d7RQp1ZlHD0ys66JNYJuF+nGEnTbCARGLNf4IyMI
	 ubqAZRl21SW45+dKMX/tod5gNsjMMGEd5no4OMUoAqFusiz2UHb4aCvXn+dtgR2qjO
	 6yh8DV9usk8PA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	linkinjeon@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Stefan Metzmacher <metze@samba.org>
Subject: Re: FAILED: patch "[PATCH] smb: smbdirect: fix buffer length underflow in RDMA transfers" failed to apply to 5.15-stable tree
Date: Fri,  6 Nov 2026 11:35:45 -0500
Message-ID: <2026-11-06-1-daily-reply-0010-smbdirect-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <71706f92-565e-4179-8a05-b5ae218d9397@samba.org>
References: <71706f92-565e-4179-8a05-b5ae218d9397@samba.org>
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

> smb: smbdirect: fix buffer length underflow in RDMA transfers

Queued your backport for 5.15, thanks.

-- 
Thanks,
Sasha
