Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52E4A1E1F;
	Tue,  6 Oct 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322564; cv=none; b=s7rcoYv1ideJDDNDiMzjVuazHtespPxOZEdTGmo1CNEVhb3TnM+t72q8yOtmG2QI17cIYqlMsjxdHNjrau4HjxxSmyS1rO0AJWv/JFQqI2T6pQg2Py/FhSNHtzIh55bWTJTuAMgnBChgSUPaY4TrpBz73J2EWwWNOR/WcrPKWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322564; c=relaxed/simple;
	bh=b8g8jCDsRe/FGbwkHoOn57AZd8wmGM5ro/jgtLnss5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8N4Kz9VkoaZVVF+QRZ9VRqrTWMQImdStfBjIJj5wtuXQ4Su3j2jN6a34BhEe+RIND5rivRyjxww47/0Yuxsutu/VHxVSImLQTUw8aDNHto54gIgNuWcU/uZAHWdY8qx7I8oFm1cxV2i7+AvXhBrseHqmSBpTCgZlXK4IiAq0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoiWMl0B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoiWMl0B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979B41F0089C;
	Tue,  6 Oct 2026 21:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322563;
	bh=aphMl/CQvAn73HZzxiI8C1mOIrEB0F4ZVPD2ZLQKtDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OoiWMl0BUVtCCCOyeTjnOpBguS29I9cMR97dUpE4TTzDqqFGI/CvtSVPD7bpiKRJ5
	 9LyuR8fBHUFXhNqDrMGwvd843N4Q62osRPVthBAfPH0NVpxK4/y7hJIP1wihNphBpe
	 6SvGbpQYHslEPrFNG9lq8c0ns9lFXTTtOiHTYxOIUEIThYNYciXc00Nomg2wYIAoVV
	 VPOZeFKK+myEwVfP75gsyDWS2BVZZpwhdJE3uNAfJi+ltuDx+wG9QwWoQK+CkbqHXG
	 TLRWChhLck47TiiqaYp3UZbT2mqRSr1gybQksIG/fHTTjqWeWuhxZfu5S0xaGYn9Vz
	 gqYq8NxaxtDPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org,
	mehmet.fide@screeningeagle.com,
	Mehmet Fide <mehmet.fide@gmail.com>
Subject: Re: Please apply 13221be72034 ("wifi: rtw88: Handle C2H_ADAPTIVITY in rtw_fw_c2h_cmd_handle()") to 6.6.y and 6.12.y
Date: Tue,  6 Oct 2026 17:35:34 -0400
Message-ID: <2026-10-06-1-daily-reply-0002-rtw88-c2h-adaptivity@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005145604.134614-1-mehmet.fide@gmail.com>
References: <20261005145604.134614-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Over USB a register read sleeps. On 6.12.112 with an RTL8822CU, the
> only rtw88 chip with adaptivity support, this gave "Voluntary context
> switch within RCU read-side critical section" in rtw_usb_rx_handler()

13221be72034 ("wifi: rtw88: Handle C2H_ADAPTIVITY in rtw_fw_c2h_cmd_handle()")
only prepares for the WQ_BH conversion in 3e3aa566dd18 ("wifi: rtw88: usb:
Preallocate and reuse the RX skbs"), which is in neither 6.12 nor 6.6. Stock
6.12.y and 6.6.y run rtw_usb_rx_handler() from a plain
create_singlethread_workqueue(), where a register read may sleep, so that splat
cannot come from an unmodified
6.12.112.

Could you send the full trace, and say whether your kernel carries that
conversion or other local rtw88 changes? We will take the patch if it
reproduces on unmodified stable.

-- 
Thanks,
Sasha
