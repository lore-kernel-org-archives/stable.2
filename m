Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434117;
	b=xDrA3oHRgfF0VxaSdEfSuXbIiK+E0FIqVEw29dZon8hNcvGG/aFMDOY6MI9BlvFVQToR
	 CUXP12RxU5tO9bA8evmfpbOQnVjfa5f9k89CvM+D3KFBCT5RoEHGs6ZLI7cX33lO0Qxcl
	 G8pHT1LKLHE0jk9hUNAKFXuqmfHALlNMbfDikgCJ7wUmOZbr6Ko78M4iujyCb+RZ/2c5n
	 MVDdNj9lyMkK3JfxidrtyTh4i+DXTwMVyjZV4WAbwWe3Q+cL2WOnkxD65FUX/kWnDETUf
	 OHCaioQ/hIB8tgID7PtD4JjC+ejh65pRI7dOt4Up24Dwv13+UuiQXnGe26bA+xJn5Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434117;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ne8F0eehElkwG2dLJaUZ77hcl/clOrDRWqC3wdIslBE=;
	b=bNL0ZbmV9l6aXsHszUrutOf9XXbewRdvMEGmJYQ33yYP8++pH7kV6IJVKBZr01Bfukyr
	 dqQVq5VietpXOrEvWHMoEw0/1SVzsWdCa89jtQ+I2nT+DBRz5tAYOp+ryRuw3Mt5FQLHn
	 C85/f0G5goV9jjgxhEgqEB8akuRNyvBeWVLN0gNfXq3dhKQnKaq4jQjJ1bqPYpxVq8GzE
	 V+a1nexIChYrlLmN4BHlpageSuqodMqKdAWsugtS5QPRhr6fkDshfg9cT0VQR9YK+X08I
	 QkPbRXKrwNwRhTaAHobQBw8aBpOEhQUaK2UnnYMYoR5WStRzQQPw7dDJpvyvqcG7ubA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCyk9zGd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0D60A380B
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCyk9zGd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441041F00A07;
	Wed, 11 Nov 2026 21:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434116;
	bh=Ne8F0eehElkwG2dLJaUZ77hcl/clOrDRWqC3wdIslBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCyk9zGd1BcPta2RM1N2kDBmMpxGY0OTJOyowfMXiHRiYlGOmIkQsBPLZl0kC9d26
	 KoNut8D3cZJzHg06IOuIsLMQzx3uQfEIoM1Cw6DPZgnhBqfzSfvkIN3sRA7EPzZcTK
	 GsVIH9jT0UxaPdcINbpDSCiRhlUPx/QhVhhjIelcgDg/XhfiMCT2YMc+eQN6FIhdtf
	 OA0IA+0t9bZ2yn8DJJ/CoH/AwXxEeJZjBzjwGYKSGlG6v8xLENdqIGsoofhnKF8tUB
	 9g5+5s37p8/H8XEkKOzv8dectlfEcPUFGxmlO8XXV24EYc+fKy+uGMuqLZWgKYHgDT
	 rWrSy+4VQcFIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Valentin Kindschi <valentin.kindschi@fiveco.ch>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 6.12.y] Bluetooth: hci_sync: pause advertising for the scan address update
Date: Wed, 11 Nov 2026 16:54:52 -0500
Message-ID: <2026-11-11-1-daily-reply-0019-c9c2967a3de5df9784c4@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111113716.260959-1-valentin.kindschi@fiveco.ch>
References: <20261111113716.260959-1-valentin.kindschi@fiveco.ch>
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

> [PATCH 6.12.y] Bluetooth: hci_sync: pause advertising for the scan address update
Queued for 6.12, 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
