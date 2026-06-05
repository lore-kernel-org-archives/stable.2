Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C381419316
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688278; cv=none; b=kdY1hMAARvWGRnLDlQGi2CEXEpviLNpC44+BKDOTKOHo3aGkN4cyeWoC+Fygoy36tilNHWmoNtv+zJPHYJTbGsRx4H2KEwqstVt8uj79vGyMENqOeIC2rh3VoKlnnH4K/PW0N+qGcyMpdQo8JN26atXMkIgon/FhBu8w8NN/a5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688278; c=relaxed/simple;
	bh=tTOAFXCdP+6uk1F/DonGGJoVhQRtkFyvhVMk673VWM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1VxUKTHj3iHkt0EZRyGNSbl5weFftr93y3gXFrQ+bm0fXKnESOy+/Tip0jLEIg353ul28P3Ii8M7IizFaY455IGrTUoKgkatX7UGeESllbQQkqyhUB5G6+cm3ZcW1VaYndvavbmgo258Irx2WraQp8176/GVi1EiO0bpiVXZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsbAz19n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsbAz19n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538D51F00899;
	Fri,  5 Jun 2026 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688276;
	bh=QBg7Xx2OztcHIAPGl2Z3FI2HELYO7wnTWXTl+PI/I9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XsbAz19n718JUjjxQmwlvHYgAIJEBTl0Cpb/j5czeOz+Unl1S9NoajMX+4ziTEUL5
	 aQf1wyk3IlzA0qdjUCesPtlpZ89CGOoRyNEavC74YxLQ9sMikpkS/i4NHSt2my3HGe
	 TLoWHJ4mNQtlp8OycjG/Xn8lFs26Y/DFMulX6STEoAq/0mWY7Dlsnpq3K5jHGLwq07
	 leEvXsa2RNf03TirlDVsGCw7DoA3G4r6DBMBIIFYEuQPdgfvpLhiY338ZhnIdjc1Wy
	 EtTvaeBZ13JsilbyLmWhgOhrLIIkctdw3OFtyF76BVQSsy1j5s87+540u0fsF2BcON
	 gejVZ4H/LdRkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jordan Walters <jaggyaur@gmail.com>
Subject: Re: [PATCH 6.6.y] Bluetooth: hci_core: Fix UAF in hci_unregister_dev()
Date: Fri,  5 Jun 2026 15:37:29 -0400
Message-ID: <20260605-stable-reply-0022@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604014809.121934-1-jaggyaur@gmail.com>
References: <20260604014809.121934-1-jaggyaur@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] Bluetooth: hci_core: Fix UAF in hci_unregister_dev()

Thanks for the patch, but I can't take this as-is -- a v2 is needed:

1) The "commit ... upstream" line cites a hash that doesn't exist in
   mainline, and there's no upstream commit titled "Fix UAF in
   hci_unregister_dev()".

2) The diff doesn't match that fix: upstream uses disable_work_sync() /
   disable_delayed_work_sync() (guarded by HCI_UNREGISTER), not an added
   cancel_delayed_work_sync() in hci_unregister_dev(). cancel_* doesn't
   prevent re-queue, and hci_unregister_dev() later calls
   hci_dev_close_sync() which can re-touch those timers, so this may not
   actually close the UAF.

-- 
Thanks,
Sasha
