Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239633;
	b=i+8YkKy7Jf6i3rY3gsb/pOEZx6KxHLra9pbZ/BDvvk+YkFIVEFylhmKFe+3efHUtqqbP
	 R0EOVv2oh26NYX7VEAf4TpI9kfXuG2PEUHt+389m0xDrWPqFN9Jt/Oq37xfFtmmkxniFN
	 ATMN/SrNLFwxHTcVT2Anhgw2puNEgDBF7W/W7Vmg8aGrG10QoCBuaeZ/JbHZ7BpM27Sdg
	 aHK099uBTCQ0ayjzE5CPIeu9U9x5BO+8KjIc7k9dKhxS+1kJT6DilmYeIALTxRi0N77vH
	 /ecqxblZewbNq5NDk/jvWAgT6XgOZbd+DYJKXIfyRRJdOIvGrECPxJzkfYF5KqSwJyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239633;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bN0MYiWjQfiBKechkhlB/ecVqR1DOaZOJ4sJAcDDzNI=;
	b=YIBy9eeVQtQ8qDlLWcwTU+pHz2PrAH6L3B1ZhDLs/kphT8syIuzBrflqPYsNIA12rrH+
	 KZRHpa9SEhT9iYNYgpa56JM3h5QHPCvldzRuKEFvrjd2p+b+Ow1ApfV+zuo6F+S9o3Uys
	 fIbYRrYEdz/+EjJ4cziv9osOKPWeg0hXtbuHrn87eIpJFXFU5xV775Wv7QKNDVvMFW3Fd
	 nJhK3MQ3ateYF4oy4tVbkZHcdqyhgJgQgcQJ8h3cI0c4j4IbScvSUfuQ1QGa4sxkUD1xg
	 d/J+WXh76GC918rb2gB+BiwyrOOWN7eV+d26Pd9UFRPIursafEZtR0uToSlf3ndbR5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQblp5ZT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9570E606EE99
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQblp5ZT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A854B1F008A2;
	Mon,  9 Nov 2026 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239633;
	bh=bN0MYiWjQfiBKechkhlB/ecVqR1DOaZOJ4sJAcDDzNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AQblp5ZTOFHkcUyfoiD/OqlXuZH55qUV6EmHHGzMCvJ3cOjFITf+5fx3kzCpBtRRx
	 QKapMHSjO/dA+VBKFgt+nxOss7aCl2AC6eYFLouttk3bZN0POcSLsdgdnunCQJm+gT
	 tPO8gayN1FbWYBBcCchzFcIFNf/5EyNeeSS1W/UjE6DF5ttS+Xp0d4REIWWrV8D/5/
	 1sIuQPM9IAyVVG2FEvzjrtEZIjUG6+Ll6XLx12SVpgB2iEmcXOC+FD8hnAgo3/jZ8D
	 iCq7qHMu8nXWeRBKOw+i50BuOGEvBloPirmWRP85pivQHlBQcjVoMobF2D3ykYbuY/
	 Cth+9+tEDROhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Sean Baggaley <me@drinkybird.net>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 6.12.y 1/2] media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2
Date: Mon,  9 Nov 2026 10:53:09 -0500
Message-ID: <2026-11-09-1-daily-reply-0027-uvc-gc515-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109093137.2377342-1-ribalda@chromium.org>
References: <20261109093137.2377342-1-ribalda@chromium.org>
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

> media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
