Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434105;
	b=aj45siRsbBoGT1PKPbelVwlRkwVPBCQaWxsH4Y/tBY0StJKqR99Au+CaSBvb/wnIxLW2
	 PCJ5mYvPOxmrY/8u8YDUZ7SXY9Jx57BRrRtYb/1IE7q2PRulgtaBkrorNEvzG6vGvUgEE
	 rRwbPZ7X3a7wrs8ulY9+yI88cjLRMoT6wvU66tJkB+HUL3isi5bAuqDZe8xno7ig9BNkS
	 fWy9bCK1xDjENgxV3i0hI2nSMfnCukP2f85AtLfjHPvpCb8zjP2Pm/DWc2KjBSqXkFQU1
	 vVDRTDWNLcR6FRwdO/jQiRw8g03TntLn4ybRemHHPi2SbDe+RNAlyVyIwrbDo5Pks8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434105;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2OaaqXH+XnYjdFpKZ5GbNbCU6Azya9E7qB5YNKf+8Jc=;
	b=qHEd5u5z6dMIzdEQ3KVdeIIdm7oGF4UmffP2Hq8vXFg0kt7Dibc9DNWnNYjVAYnVnQh5
	 CdfWaayF00Aj+8r6vJbArzRnL2LTe+BbP6jlGlB0EY4w72X20qsM5HCFI/E0GZ91+6iXl
	 wZ9lRYbO5uxADi4dS6DtmjCkycdI/tJuF2E/Qk95+em8tzOCsnDnze6lCA5BNADav3D3F
	 t3rVgXJbMAkOCbTn1v8iZQs5+vhvC+vnAZGnoMHWgTaaR4cUcSC4YTBz4hUETIfapeNhv
	 zZZXdYhO0Ukgqkc9rgOBpqhkgPmnFqfrkhHCW8DAwJMX3CkMzK4ZinrLbaUcd/uXKPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkpM0Yjj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC45606A8B0
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkpM0Yjj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCC31F00A10;
	Wed, 11 Nov 2026 21:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434105;
	bh=2OaaqXH+XnYjdFpKZ5GbNbCU6Azya9E7qB5YNKf+8Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mkpM0YjjWo1GkN14lYyPlp+JeLNRJsY9DlB3of7oRNiZGLELVJCZHMVIKWLDbi7pU
	 BnVFpdX0YXwLdswqMIujimQBdSaGDcmV3F61te9ZByklTzdU3Wrt2XzYksGq39fDBX
	 UTN7F1SqLBd7hG3+t+8zdXGJkIgXQOlUMOFXrz3YfqQiwDiHmh6tQSbwljIVytFWE3
	 R1S/VXOqzCcw/lhjIdOy63pw3nt4R7IlDMxkwXRnOwFn5iXclU3Q4zsmCBThunf911
	 oTXbe+zmq/0Y65l6OE2iOSBh/eKLeLdZPlBozH/8HQrVwMGKApHRsE6FUgmFf09WMd
	 xX6Z4v0D8zW+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.12.y] batman-adv: tt: clear ROAM flag when re-adding a pending local client
Date: Wed, 11 Nov 2026 16:54:38 -0500
Message-ID: <2026-11-11-1-daily-reply-0005-ec47082c603a4fa1ff92@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110190259.111201-1-sven@narfation.org>
References: <20261110190259.111201-1-sven@narfation.org>
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

> [PATCH 6.12.y] batman-adv: tt: clear ROAM flag when re-adding a pending local client
Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
