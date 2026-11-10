Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344387;
	b=Ni7kaHx6cMZzit/qg1xyov5o+xsvvh72iu7Ff7c18B9UnENwhVHDK3TgaW8NqIMdW7x5
	 FfkZHPxeFkDlzVtMzoPvDnmeDxzpqE25OHDmuWW7id4r1G10p309IyEKCKqzDvHP7fyoh
	 8wzKjGwl2n27L0UU5npkbWO7abXJIL42KDrxttx+DrhL7UwCoPdlZgOkAEk//Tdy4VnAZ
	 BeW+2ghd4zw4efkB0sgAjLy8svkM4BSovi9LXKJYSw7Vh1uKYs/qhTZkExcNx6JEW8s55
	 ieYrlHWCUxXnwm8aPSXKdFEkX8kzxlkkIpTqP2Ix+LQJ4JkdTjVSiGqzaibxeHaGsTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344387;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Q6iBI7zqeM0OeyRTOU1qQ31c4JsN2FpYw3fXt+uTseo=;
	b=LbBZUY963F/vNYqONFdCiUNYpiOwNXzQ7u7480psEletfABYX2bIx31iYO8ye5Qo+e79
	 TQpnZdsi//FZX+tN1Vv3U3WOFH5iDTM8xxdsMVjEWs389Q07i6TctcUuxmvHhhMcxJxcm
	 aU5SOOU3h8DxZISypAi+Hb/36iVJ2A1snYNhEx2r5MQlPRUn9UIhqKCxrglqG3zJ12A1v
	 m/O55QB+toCQaYTn/ByBloHM4irUH8nRLh4YxW8clBiZ7QuO492Td7s8QIJ1Rdm9xL6PY
	 ttt0UGqBVxNH52WFz2dETirY2ACZT8kITWNG3W8imbVDUM/T1IEszX+tBQkvi87uhbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YlfX9Z/E";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A644C606A31C;
	Tue, 10 Nov 2026 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlfX9Z/E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579A51F008A1;
	Tue, 10 Nov 2026 20:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344387;
	bh=Q6iBI7zqeM0OeyRTOU1qQ31c4JsN2FpYw3fXt+uTseo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YlfX9Z/EnToUaigqV2Ou+Hp1Aaj+NxK0K139fjog6ecwJDIMjVREC7Ghf1w45mcHn
	 3/VZUOJHBdacuUHmOhD1nCv0Z7bcf3cBHBnp3kLfw8fBm3Ungd4DPojmvoJy4fLhbs
	 DFJi7EB8TJkMtElE+7nNvgqKYIDvsTWMb6UlnVBmJ3eSt65P7Ypx9zM+T3FJnKgdjf
	 PYdbTS/VZQFLBLuzMA+2U8U7fdiyIdhvzWiuVwl//GyRXoJTRezHtE+qpU4Nu1fc1C
	 a0y8TkkPG3q8z4M57zsNlbhGpEZqt5zyBUAqBmrJJRWAyFCyMCISFbmzO2dVrIU2w7
	 bgvif9PhT3Hvg==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	linux-input@vger.kernel.org
Subject: Re: [STABLE v5.10 0/5] HID: wacom: Fix Use-After-Free vulnerabilities and SW_MUTE_DEVICE registration
Date: Tue, 10 Nov 2026 15:59:10 -0500
Message-ID: <2026-11-10-1-daily-reply-0014-wacom-5.10-series@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109133911.3026622-1-lee@kernel.org>
References: <20261109133911.3026622-1-lee@kernel.org>
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

> HID: wacom: Fix Use-After-Free vulnerabilities and SW_MUTE_DEVICE registration

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
