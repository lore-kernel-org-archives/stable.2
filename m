Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717531;
	b=OUQRd6ofthCKJhSCaqHQuvVA/b0ixRgFhZ0hA7EYFj5nFSbpMR3gmIoofMv4k2Doo87i
	 azBmKkQ+kXN6fHeoXFN0Tq1MYHpLa34dI2sOOOD8fVYtGzs7x3LClVxKxVS2ZJkTALXXB
	 3L4ESuDVfqTLgRIE4h20KpORvsvToJuHH9nSPRju6oGWBz4bJ2+uPJOn7kxg3PnKXnGMW
	 1FxP/zXDgWdgcgOU9UahLV3Z4IQQMVjIIo/BDdWFdCBVw7/RhRdtilM7q6UlbIPIgZG0I
	 0Tsgs/qWrWbGV2qnnQ50sptJsUrC6Q3lpP6Z9O/W8VZZgJN77CLXalZhzYGE4WVrTRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717531;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=b2ww1r6hO/dk9YMPcsNkTIQNyUI3YWzYtrGMrf4Qxhc=;
	b=JyBNLsn3NGHDxNpGbk5Ru1llVbLcQpODV7dKu/DFegEv4MrsAN/gFMJYavDGBQKh3Kja
	 bmBqn6xmuQoW+F9IZRh8LVFNeTwFtdhDAdyhp/HbyF/z/hfHEx2TgsBrZIBWDV4vHUnB4
	 tCfE7CZXQtz4XyKfaUMqylA2f6HWijBKdfPwchyxHnlRx+YOtrJ34enZFHUl8mfQx46L7
	 xRZWcXXRwQ/ViMvVZ5bSr/4QHbc6BiMt0MAxWfeQv39rFEKnZFAFhYwLQRehH1N8dNiFr
	 jyOgyvZbzNsC3rXO2myRBdsiu9NneUQ2U6X0CnvCSk9Mhat8c/VD7pg3dZ7n9x8SFJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j59mApkJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838A4606B24F;
	Tue,  3 Nov 2026 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j59mApkJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5270F1F00919;
	Tue,  3 Nov 2026 14:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717531;
	bh=b2ww1r6hO/dk9YMPcsNkTIQNyUI3YWzYtrGMrf4Qxhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j59mApkJOs0Vid05mlBUGuUmMf+zbtk1HtCnqrn+ZjDiV4MFme8WvX/ec+ld9MUlj
	 DnwYD2XnDdDB6kp3dwehJLxlYGdFGCWuNRVrh/sSS+fe3/baHQRVMPUdG556NqpAmg
	 80/dTnFrNkE/EPYfFmevtgAVP54dnTAvG1ydyr4SgKP/lYtXsvKxofMYNYyYmokPoW
	 a+/FXFSxh73PNJfH0GHaOtQfbKnOEQZNTKE4xHD7jzOHPEKr8OaAle5SfnrgB9zDbS
	 XPwHuBgeTyPsAq7mP1hX/2TXEBjWqbQWKAvepgvdo/IIjg2xkKtOBLVEcDdy84V9nm
	 kF0uq2EJf3muw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	2122295973@qq.com,
	Andrey Misiurov <amisiurov@cloudlinux.com>
Subject: Re: [PATCH 6.1.y] Bluetooth: ISO: drop unbalanced sock_put() in iso_conn_ready()
Date: Tue,  3 Nov 2026 09:51:50 -0500
Message-ID: <2026-11-03-1-daily-reply-0002-re-bluetooth-iso-sock-put@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102123418.363320-1-amisiurov@cloudlinux.com>
References: <20261102123418.363320-1-amisiurov@cloudlinux.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Commit 1702f12cf59a ("Bluetooth: ISO: fix use-after-free of listener
> socket in iso_conn_ready"), the 6.1.y backport of upstream 560bef609fa5,
> puts the listener when it is no longer listening.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
