Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661002;
	b=YMCTfqj6ltDb2xIsS/sSuQff88gZp7NeVM6SISCD866fhdgCZ67xFaKfXW+9L9FiTdzg
	 g9mSM+dITP7GUdL+0dtpCLjN6atln1asC7GVseraR/ta9hDfKFE9QR4dRPAXuABNOoQBu
	 NjEcUYaW/rtQernmUfMQaXKBTQxchttK5UZ29+U/CFRD3sBbZsZMkxtF8jwJ1GVVRvslm
	 8PHAwaCjgTBJSrKF43udytHNMSEfZqUZgTVYVgN543u1PjeQpFCkb9SmGn5vbW3Sigg4A
	 G6QVf+okY46meeq4L7RYUMZHcwPfld1kx/dhBH6+JRgUCrPrwHSZlLQRrEVkq53Fo5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661002;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qWvv2TqLG+DDcD+PAmBT8QsFJXn/Tm36sf/CUsjlj1E=;
	b=2wsj7D45IzrGYiGkbGVsPqgZPFq541veC390hOpnUVbeYPhHqAsLY/qriArvcW+mq/Gt
	 HWc5ECl8io3tuTEcSCEndqL/BDAwyLatzx29RAsroemHZwHOYMF/Tn1qHCfvg3FF3ZHi+
	 tqnFvWrs6w4gARMuGpVPUR9KAhIx1n48dKTo/yUOgSgH2g8hB7Lt7dff5KlkH1NRnBolq
	 gYsxVy4U0O5W5oS/bW84vcvC2VTAGE+alKTDFlB2Rf51yoz4Ot9RiNskO2vyrwjFGhm6T
	 43IFzJ39WBaCPcBapTk4EDj7v8e0OZUK1PB2ju9jKJlfhxs5mAPfyQN8kIjC9a5OZLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=uBFBQdyY;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A244A606A31E;
	Thu, 26 Nov 2026 02:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A244A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=uBFBQdyY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=uBFBQdyY7eeGvDEu1EHoA1sjznvuGZOpp8m2I05L7s20Nh08C8d+h54fqvCSFGhYBYfhxEs9+0Ogi
	 1YNKda2Efa8cC1/xnVTqSCo986gvMZo7O6ZLhGbZ1yAjyAWVwQnNed2YQ4OoJ+6RN4E9C5Tp5sZNgB
	 wtzeGsSOKVMtpAvk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66b079cbee5a-23449;
	Thu, 26 Nov 2026 10:43:11 +0800 (CST)
X-RM-TRANSID:2ee66b079cbee5a-23449
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.112.32.189])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36b079cbece4-595b9;
	Thu, 26 Nov 2026 10:43:11 +0800 (CST)
X-RM-TRANSID:2ee36b079cbece4-595b9
From: guohongyu <guohongyu@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	alan.brady@intel.com,
	stable@vger.kernel.org,
	13057616121@163.com
Subject: Re: [PATCH] idpf: fix vport_id used as array index in MAC filter async handler
Date: Thu, 26 Nov 2026 10:35:54 +0800
Message-ID: <20261126023554.236227-1-guohongyu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179565949384.3294.6218603099017752049@kernel.org>
References: <179565949384.3294.6218603099017752049@kernel.org>
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

Answers to the three questions:

- How the issue was discovered: manual code inspection.  The handler
was found during a code audit of the idpf virtchnl receive paths;
the bug is visible by reading the function: it resolves the vport
with idpf_vid_to_vport() and then does not use it, indexing
vport_config[] with the raw vport_id instead, unlike every other
call site in the driver.

- Whether the issue was actually triggered: no, it is not proven at
runtime.  The out-of-bounds path requires a control plane that hands
out a vport id not smaller than num_max_vports and then reports a
failing ADD/DEL_MAC_ADDR status for it; no hardware was available to
exercise this, so the issue is theoretical, found by inspection.

- Testing: no real hardware available.  The change is a one-line
substitution of an array index; it was compile-tested with
CONFIG_IDPF=m (x86_64, gcc 12), builds without new warnings.

Thanks.


