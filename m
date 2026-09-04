Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670BD3EC837;
	Fri,  4 Sep 2026 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788493699; cv=none; b=k0s+XX4ziURDDrP7auAwtKXM2/Wb7E9/xrvY+2aN+1GI8V9xHHMCUhXpWBsdGxXojMHjjifNs+owWcbhR5sw5p8CvPxEUdFTrWTObDv/kVNVB47x3etm4f0iTjsLyKB5x3Tyfp29XnaNWqB7Wl6vMZDn5skO6efbs8hy/Pyzu6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788493699; c=relaxed/simple;
	bh=zucHfOmnE8OQI0qiGvt0nQJc4QeLYF5p1QUsbyvFH2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOJKjLd4S24vedMkCa5L6e+VhNK/4Mr3O5GlaQikZfjf49d63b9OQG9LsCxNSMxe1S9G2Bp/mWC8w0t1E9yiSVZdT2OCbq+wc9KAuhvIwmmdzteXLfYJQFObUhPHlzWp4+wwOpzXcPVybTShiTpoJVFcP3LNx5/oMxndXm1moH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7212e6d6a81311f19a56ed5b684f684d-20260904
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f6b24725-d03b-45f1-a6ad-5270d03f674f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:daa6f7d960b79d765dc4312fd635329a,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50|99
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7212e6d6a81311f19a56ed5b684f684d-20260904
X-User: huangwei@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <huangwei@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1839889899; Fri, 04 Sep 2026 11:48:09 +0800
From: Huang Wei <huangwei@kylinos.cn>
To: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Cc: Huang Wei <huangwei@kylinos.cn>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fan Wu <fanwu01@zju.edu.cn>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: acpi: fix use-after-free on driver removal
Date: Fri,  4 Sep 2026 11:48:06 +0800
Message-Id: <20260904034806.739234-1-huangwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260903232121.271776-1-ivanrwcm25@gmail.com>
References: <20260903030356.58597-1-ivanrwcm25@gmail.com> <20260903232121.271776-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Iván,

This is a nice piece of work. (And apologies for the duplicate of my
earlier note on v1 -- that was an accidental resend.)

I went and checked the ACPICA side after reading your notes:
acpi_remove_notify_handler() does call acpi_os_wait_events_complete()
on the device-notify path, so the flush argument holds up. The stall
you measured for the v1 ordering is a good catch too -- I was happy
enough with the plain reorder on v1 and would have missed that
ucsi_unregister() depends on the notify path for its completions.

The quiescing + CCI masking looks right to me, and keeping the fix
ACPI-local answers my question about the other backends.

If you do post the harness separately I'd find it useful -- the
ordering comparison alone is worth having in the archives.

Reviewed-by: Huang Wei <huangwei@kylinos.cn>

Thanks,
Huang Wei
