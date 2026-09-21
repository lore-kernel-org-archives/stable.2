Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982CC49E127;
	Mon, 21 Sep 2026 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996192; cv=none; b=rQTG3W1z8R0fay2Q1Db1atXrDJGL19VGkZizGsiLKUCzJQtpqQTF8Yz2pZsm7zy3yxbNuypxard9G5Lww1B5fjeDzj0OqzhbRW4OwUz3VpayxMTYAKkv6OQe6qAfGQyxKvWy15hDfmsJPGeW745SBrGnv4QjwZSIQzqAzGLQBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996192; c=relaxed/simple;
	bh=TEXYmrsbMmnahv1tRX+5vXql6sSGzC6xlXKlfo4WDW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fuPC3Oa7RaMTFhZ6z3Px5dkUEB/VYkLrSuC+HmggfL6GgIZEYpH1HKFX/udPXtMmgPRp3bd4nbAUxTl5snYdBEcLz91I+BwsMVWXMr4lFzXWOZy7YvdUlc2ercndNZ1gRjCDInuDE+z9I97gDhQYWMZ7ZMvkhDKiTnTH5pXEOeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b55c8b92b5bd11f19a56ed5b684f684d-20260921
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:159ada4b-a44a-4fb0-b20a-02fae7af294a,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:26
X-CID-META: VersionHash:7db8b62,CLOUDID:667fd1cd69605c24c0b5b551573aff94,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50|99
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b55c8b92b5bd11f19a56ed5b684f684d-20260921
X-User: huangwei@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <huangwei@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1759593504; Mon, 21 Sep 2026 21:09:42 +0800
From: Huang Wei <huangwei@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+e7aa19176573a6992617@syzkaller.appspotmail.com,
	huangwei@kylinos.cn
Subject: Re: [PATCH] usb: typec: ucsi: acpi: don't dereference a missing ACPI companion
Date: Mon, 21 Sep 2026 21:09:37 +0800
Message-Id: <20260921130937.2982838-1-huangwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026092130-thong-secrecy-1dd4@gregkh>
References: <20260920090711.300-1-yogeshgaur.83@gmail.com> <2026092130-thong-secrecy-1dd4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

Fair enough - my Reviewed-by was about the fix being technically
correct, not about whether we want it, and it takes a driver_override
write plus the bind to get there, which is a fairly deliberate root
action.

The one question I'd leave open is the syzbot noise - this report came
in recently, so if the fuzzer is still exercising the override+bind
path there will likely be more of these. If those reports can be
identified and closed as noise, the patch is indeed solving a
non-problem.

Yogesh, either way the analysis in your patch was solid - the bind
path research was right on.

Thanks,
Huang Wei
